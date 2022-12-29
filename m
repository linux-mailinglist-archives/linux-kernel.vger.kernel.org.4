Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE09A658F25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiL2Qlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiL2Qlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:41:51 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F913B1E6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tzCYn
        kSXa1e5jyrDt4wYjR1XASYwDDuOd8wscs2Y04E=; b=HJ1S10xOVVOEyFWN+GmwO
        Axjm1zniYJEjEANk7/YxnVRt3dg4I4hwn3ozC0bxK8895YzbwXLbmuepHLR7L1YF
        RND4kWk3LRDdCYZnk5dsj2HCuA6UnmRlxLJt5ROzpi9qOxRFy22x2chKTzNC66VX
        GKjIxoXyzltkFtZzFufphw=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wAnRQL+wq1j1rN9AA--.49187S2;
        Fri, 30 Dec 2022 00:40:31 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dhowells@redhat.com
Cc:     marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] afs: Fix poential UAF in afs_make_call
Date:   Fri, 30 Dec 2022 00:40:29 +0800
Message-Id: <20221229164029.3009754-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnRQL+wq1j1rN9AA--.49187S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1UJryfZw45Xw1fCFyfWFg_yoW3twc_C3
        42gryvk345WF1ak3WSgF4ay3yIga1UWFs5Kr4ftFWSqa45Aw17Cw1v9r1vyFn8Wr48Kr98
        JrsFgFyDCryIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZucM3UUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXAbmU1Xl5PpoLQAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a function call : afs_fs_get_capabilities calls afs_make_call, in
afs_make_call, if error occurs in rxrpc_kernel_send_data, it will call
afs_put_call twice, which will free the call. And the access of
call->state will trigger a use-after-free bug.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 fs/afs/rxrpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c62939e5ea1f..4871210c4b81 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -422,8 +422,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 		call->rxcall = NULL;
 	}
 	if (call->async) {
-		if (cancel_work_sync(&call->async_work))
-			afs_put_call(call);
+		cancel_work_sync(&call->async_work);
 		afs_put_call(call);
 	}
 
-- 
2.25.1

