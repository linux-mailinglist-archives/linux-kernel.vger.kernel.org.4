Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11296A829E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCBMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCBMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:49:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364529E09;
        Thu,  2 Mar 2023 04:49:28 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PS9pY6mcpz16P2D;
        Thu,  2 Mar 2023 20:46:45 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 2 Mar
 2023 20:49:25 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <linkinjeon@kernel.org>, <sfrench@samba.org>,
        <senozhatsky@chromium.org>, <lsahlber@redhat.com>,
        <hyc.lee@gmail.com>
CC:     <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <yanaijie@huawei.com>
Subject: [PATCH] ksmbd: fix possible refcount leak in smb2_open()
Date:   Thu, 2 Mar 2023 21:58:04 +0800
Message-ID: <20230302135804.2583061-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference count of acls will leak when memory allocation fails. Fix this
by adding the missing posix_acl_release().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/ksmbd/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0685c1c77b9f..f04d810a2588 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2977,8 +2977,11 @@ int smb2_open(struct ksmbd_work *work)
 							sizeof(struct smb_acl) +
 							sizeof(struct smb_ace) * ace_num * 2,
 							GFP_KERNEL);
-					if (!pntsd)
+					if (!pntsd) {
+						posix_acl_release(fattr.cf_acls);
+						posix_acl_release(fattr.cf_dacls);
 						goto err_out;
+					}
 
 					rc = build_sec_desc(idmap,
 							    pntsd, NULL, 0,
-- 
2.31.1

