Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5834C63452D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiKVUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiKVUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:08:33 -0500
X-Greylist: delayed 2102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 12:08:32 PST
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D78A3400
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
        Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
        Content-Description; bh=weFqBBEuoYe8WdB7ucJUMCD7rrVXpr62keLdAWyCS78=; b=c/Y03
        viW3pfh0CXBuJXFUV546K3MLlDBf5+7XUhj4ROuE0l2qcUJ/JnBG4GE2ZcQ8owjiLrsSiRBZ31Rzq
        flAl00AViUPcqtsLv7xfi4YgHhblZsPut5DgW7z1+/pIDGV+HPWGI7ve9dLnzocVWY9Uu/vFi2qgs
        MwXFy2RgWFApTkOzb03wORpqHFmlRLgKyfUNKfuryT9xA5O3olsNxQtO2l/rLzKCeD5DqTGd1F3iB
        eF9a2y9XdqVfimrDVR3XI3tOJK6PIQiQ2AX6E4jJP0qsVOplVBBBfpBaLGLMXUeiW7R3LZvgojpuz
        nQGnvZgL/mJ2ffyIyMUa5THslAimA==;
Message-Id: <8f2a5c12a446c3b544da64e0b1550e1fb2d6f972.1669144861.git.linux_oss@crudebyte.com>
In-Reply-To: <cover.1669144861.git.linux_oss@crudebyte.com>
References: <cover.1669144861.git.linux_oss@crudebyte.com>
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 22 Nov 2022 20:20:22 +0100
Subject: [PATCH v2 1/2] net/9p: distinguish zero-copy requests
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add boolean `zc` member to struct p9_fcall to distinguish zero-copy
messages (not using the linear `sdata` buffer for message payload) from
regular messages (which do copy message payload to `sdata` before being
further processed).

This new member is appended to end of structure to avoid inserting huge
padding in generated layout.

Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
---
 include/net/9p/9p.h | 2 ++
 net/9p/client.c     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 13abe013af21..429adf6be29c 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -531,6 +531,7 @@ struct p9_rstatfs {
  * @offset: used by marshalling routines to track current position in buffer
  * @capacity: used by marshalling routines to track total malloc'd capacity
  * @sdata: payload
+ * @zc: whether zero-copy is used
  *
  * &p9_fcall represents the structure for all 9P RPC
  * transactions.  Requests are packaged into fcalls, and reponses
@@ -549,6 +550,7 @@ struct p9_fcall {
 
 	struct kmem_cache *cache;
 	u8 *sdata;
+	bool zc;
 };
 
 int p9_errstr2errno(char *errstr, int len);
diff --git a/net/9p/client.c b/net/9p/client.c
index aaa37b07e30a..c7935e392812 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -680,6 +680,9 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	if (IS_ERR(req))
 		return req;
 
+	req->tc.zc = false;
+	req->rc.zc = false;
+
 	if (signal_pending(current)) {
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
@@ -778,6 +781,9 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	if (IS_ERR(req))
 		return req;
 
+	req->tc.zc = true;
+	req->rc.zc = true;
+
 	if (signal_pending(current)) {
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
-- 
2.30.2

