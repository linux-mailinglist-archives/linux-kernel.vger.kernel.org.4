Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA40633127
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiKVAK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVAKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:10:50 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D0E92B49
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:10:47 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id EB1BEC01B; Tue, 22 Nov 2022 01:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669075851; bh=QzhrOUAQP1dDRAYbRqs4t/e9Y2uqBB20wcovyN9kH70=;
        h=From:To:Cc:Subject:Date:From;
        b=zHlCKufGNvI4Xksi9kl1ZNwMiMPmJsegF7rbq9KZAYBSn3hpeHGnZKQ9BIRnoyXFM
         9lOO9XcrHbJlPZzH7/5vyHrikq2bObB7Iaa/BZvlxNpy/vKIzobjlv0S+aCvZIt9gU
         y5jhnOVbYTJfSAzlbz14q99/YGhBs+v0gA/HloLNr1IW/lAg1zZVHzmFs9mubM+tEO
         QPKfhcUgLip0NL/WZevnmlGlgtnbc74AKp74GlJ8X8RcTSkZEdKZpP52IjVcYWJyAy
         /HNJfOaxycYPHRybzt+OWUofWEMbTpybtExNDSQX/K+9z8+OgsFLl3jXlwhS1ngRAz
         gC07QcDRfpRdA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id AD670C009;
        Tue, 22 Nov 2022 01:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669075851; bh=QzhrOUAQP1dDRAYbRqs4t/e9Y2uqBB20wcovyN9kH70=;
        h=From:To:Cc:Subject:Date:From;
        b=zHlCKufGNvI4Xksi9kl1ZNwMiMPmJsegF7rbq9KZAYBSn3hpeHGnZKQ9BIRnoyXFM
         9lOO9XcrHbJlPZzH7/5vyHrikq2bObB7Iaa/BZvlxNpy/vKIzobjlv0S+aCvZIt9gU
         y5jhnOVbYTJfSAzlbz14q99/YGhBs+v0gA/HloLNr1IW/lAg1zZVHzmFs9mubM+tEO
         QPKfhcUgLip0NL/WZevnmlGlgtnbc74AKp74GlJ8X8RcTSkZEdKZpP52IjVcYWJyAy
         /HNJfOaxycYPHRybzt+OWUofWEMbTpybtExNDSQX/K+9z8+OgsFLl3jXlwhS1ngRAz
         gC07QcDRfpRdA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9b56555b;
        Tue, 22 Nov 2022 00:10:39 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] 9p/xen: do not memcpy header into req->rc
Date:   Tue, 22 Nov 2022 09:10:25 +0900
Message-Id: <20221122001025.119121-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while 'h' is packed and can be assumed to match the request payload,
req->rc is a struct p9_fcall which is not packed and that memcpy
could be wrong.

Fix this by copying each fields individually instead.

Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Suggested-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.22.394.2211211454540.1049131@ubuntu-linux-20-04-desktop
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Follow up from the previous xen patch's review.

This isn't an immediate fix so I don't think this one should be rushed
in with the rest of the overflow fixes -- I'll let this sit a bit in
-next after reviews.

 net/9p/trans_xen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 4665215bc98b..e8e3f54a837e 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -216,7 +216,9 @@ static void p9_xen_response(struct work_struct *work)
 			goto recv_error;
 		}
 
-		memcpy(&req->rc, &h, sizeof(h));
+		req->rc.size = h.size;
+		req->rc.id = h.id;
+		req->rc.tag = h.tag;
 		req->rc.offset = 0;
 
 		masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE(ring));
-- 
2.35.1

