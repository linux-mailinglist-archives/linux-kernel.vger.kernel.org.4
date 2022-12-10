Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3AA648B90
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 01:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLJALC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 19:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJALA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 19:11:00 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3430F7F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 16:10:58 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id AD31DC01B; Sat, 10 Dec 2022 01:11:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670631067; bh=HyFR8xSzRUqVUlavgT48EJ0ZVGK/uZU9vO4AzilxacY=;
        h=From:To:Cc:Subject:Date:From;
        b=ripLB6FSl1Bmq/LE0nufGTv/HavizAqpw2unUao7R6KQeDmBLo8GB0b+YIqjNKC8d
         IutrWk/aOL2SpRYc/jOimr2kFQc81MPr34AIuIGh6BvMfotO9THbNxF6BO7M523mtT
         r/5NpZF05pVFzmEL9lYlDP79bzUkPmx/3941oZ0q3mQm2Qt3Z9nP0XKZj0YsK3gyi9
         dzRzt3oWA9WL41q8O3r0btW28xJdAR4JMLX2aPDp9s4mU29gn1aeeADbTtMEHW8qkC
         oZzhsEmZGJKhFbsK2VRarstSlxU+gxhxfgUs+aNlVLQaciwtBIuINexy6N07DMV4uM
         6CSDhOOTSOPeQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7E094C01B;
        Sat, 10 Dec 2022 01:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670631067; bh=HyFR8xSzRUqVUlavgT48EJ0ZVGK/uZU9vO4AzilxacY=;
        h=From:To:Cc:Subject:Date:From;
        b=ripLB6FSl1Bmq/LE0nufGTv/HavizAqpw2unUao7R6KQeDmBLo8GB0b+YIqjNKC8d
         IutrWk/aOL2SpRYc/jOimr2kFQc81MPr34AIuIGh6BvMfotO9THbNxF6BO7M523mtT
         r/5NpZF05pVFzmEL9lYlDP79bzUkPmx/3941oZ0q3mQm2Qt3Z9nP0XKZj0YsK3gyi9
         dzRzt3oWA9WL41q8O3r0btW28xJdAR4JMLX2aPDp9s4mU29gn1aeeADbTtMEHW8qkC
         oZzhsEmZGJKhFbsK2VRarstSlxU+gxhxfgUs+aNlVLQaciwtBIuINexy6N07DMV4uM
         6CSDhOOTSOPeQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 19dbb211;
        Sat, 10 Dec 2022 00:10:51 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] 9p/virtio: add a read barrier in p9_virtio_zc_request
Date:   Sat, 10 Dec 2022 09:10:44 +0900
Message-Id: <20221210001044.534859-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The request receiving thread writes into request then marks the request
valid in p9_client_cb by setting status after a write barrier.

p9_virtio_zc_request must like p9_client_rpc issue a read barrier after
getting notified of the new request status before reading other request
files.

(This has been noticed while fixing the usage of READ/WRITE_ONCE macros
for request status)

Link: https://lkml.kernel.org/r/167052961.MU3OA6Uzks@silver
Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_virtio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3c27ffb781e3..98425c63b3c3 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -533,6 +533,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
 	err = wait_event_killable(req->wq,
 			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+
+	/* Make sure our req is coherent with regard to updates in other
+	 * threads - echoes to wmb() in the callback like p9_client_rpc
+	 */
+	smp_rmb();
+
 	// RERROR needs reply (== error string) in static data
 	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
 	    unlikely(req->rc.sdata[4] == P9_RERROR))
-- 
2.38.1

