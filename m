Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21E692F3A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBKHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBKHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:51:01 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2A56EE0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:50:59 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DBCC6C01F; Sat, 11 Feb 2023 08:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101879; bh=0dG1T5rTNJj68tFKpAZu+B7hHGU13VEF6aoe1h4gpx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBn9QulEmLuWlHT2eRLH8T0dFTSaM2Ogzr+ibPEeADMRtJPOP1QifNtSgepbDDiaP
         nXYnhuEVFv65LWu8ynDOvO9KXsaGJMduer8+CFu4Quxb4x3663LVQv4wY08cNoHDPA
         stfbU8l8M4ZefNBlUk8MAIJoHkUijr/OTYe2c34wKKaR1X9051Rb4O8zDGGfruaIhF
         RY6gHvolHQOEudQkknXwJJC3tker2amohpF4n29BtorhUW186EcyrD7PofGeUzKMxB
         xA2VFWHQZZqRWZcsH2xjkHQi1LWJHDf6gu+NmfOvCuCONog9JaLYYN37XAlr3BHOqE
         B3J1riCC0LHDw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 2A438C01F;
        Sat, 11 Feb 2023 08:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101879; bh=0dG1T5rTNJj68tFKpAZu+B7hHGU13VEF6aoe1h4gpx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBn9QulEmLuWlHT2eRLH8T0dFTSaM2Ogzr+ibPEeADMRtJPOP1QifNtSgepbDDiaP
         nXYnhuEVFv65LWu8ynDOvO9KXsaGJMduer8+CFu4Quxb4x3663LVQv4wY08cNoHDPA
         stfbU8l8M4ZefNBlUk8MAIJoHkUijr/OTYe2c34wKKaR1X9051Rb4O8zDGGfruaIhF
         RY6gHvolHQOEudQkknXwJJC3tker2amohpF4n29BtorhUW186EcyrD7PofGeUzKMxB
         xA2VFWHQZZqRWZcsH2xjkHQi1LWJHDf6gu+NmfOvCuCONog9JaLYYN37XAlr3BHOqE
         B3J1riCC0LHDw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5f99bccc;
        Sat, 11 Feb 2023 07:50:46 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/5] 9p/net: share pooled receive buffers size exception in p9_tag_alloc
Date:   Sat, 11 Feb 2023 16:50:20 +0900
Message-Id: <20230211075023.137253-3-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async RPC code will also use an automatic size and this bit of code
can be shared, as p9_tag_alloc still knows what client we alloc for.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 53ebd07c36ee..4e5238db4a7a 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -282,8 +282,15 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 			    t_size ?: p9_msg_buf_size(c, type, fmt, apc));
 	va_end(apc);
 
-	alloc_rsize = min_t(size_t, c->msize,
-			    r_size ?: p9_msg_buf_size(c, type + 1, fmt, ap));
+	/* Currently RDMA transport is excluded from response message size
+	 * optimization, as it cannot cope with it due to its pooled response
+	 * buffers (this has no impact on request size)
+	 */
+	if (r_size == 0 && c->trans_mod->pooled_rbuffers)
+		alloc_rsize = c->msize;
+	else
+		alloc_rsize = min_t(size_t, c->msize,
+				    r_size ?: p9_msg_buf_size(c, type + 1, fmt, ap));
 
 	if (!req)
 		return ERR_PTR(-ENOMEM);
@@ -728,18 +735,10 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	int sigpending, err;
 	unsigned long flags;
 	struct p9_req_t *req;
-	/* Passing zero for tsize/rsize to p9_client_prepare_req() tells it to
-	 * auto determine an appropriate (small) request/response size
-	 * according to actual message data being sent. Currently RDMA
-	 * transport is excluded from this response message size optimization,
-	 * as it would not cope with it, due to its pooled response buffers
-	 * (using an optimized request size for RDMA as well though).
-	 */
-	const uint tsize = 0;
-	const uint rsize = c->trans_mod->pooled_rbuffers ? c->msize : 0;
 
 	va_start(ap, fmt);
-	req = p9_client_prepare_req(c, type, tsize, rsize, fmt, ap);
+	/* auto determine an appropriate request/response size */
+	req = p9_client_prepare_req(c, type, 0, 0, fmt, ap);
 	va_end(ap);
 	if (IS_ERR(req))
 		return req;
-- 
2.39.1

