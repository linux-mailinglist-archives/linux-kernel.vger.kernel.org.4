Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADD62F69F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiKRN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbiKRN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:56:05 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF1B855
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:56:04 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id EABC2C021; Fri, 18 Nov 2022 14:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668779769; bh=CQZUY2pFucgWJB1sP94KlRMevw8XHM75WorqTLQ5yWo=;
        h=From:To:Cc:Subject:Date:From;
        b=uSvAaMZ0OpQj5Glb1zO0fX4Vtf2UxJ5sbZfbsKWIfztAOXVUTsOHzFmFyc0pmE+t5
         GQrWZvuuh3a4liNcgeOQwvCoEHFs6y2K7+Yt/77E3yJDKEzFtZGiT3WjkeWt0H/iwl
         82ZX0SajJI92Rqi3iomzgjTv9stjt2NyPtAGTpBmygKeGXdJgg8r0vstY/LgzWvsFK
         tyAHuR1PD6EHY3hz5GWH16hYAsYjBEYo9IM3arp7YcJD4h/hdUtX38LCkhCSNOORBg
         gWmorINpw+gHsHqP1SOebXgTBaNQYE0ydZ5qQRSt1lzWsAO422MKQjywksSUlOO7wg
         gFS1rQN5O+GGw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 6A553C009;
        Fri, 18 Nov 2022 14:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668779760; bh=CQZUY2pFucgWJB1sP94KlRMevw8XHM75WorqTLQ5yWo=;
        h=From:To:Cc:Subject:Date:From;
        b=XiMNoADAAyrOPpLTaJNzk8a4IsyZYtJ+O7/RXIn5s83g068QaP45+jsLpxBpwDnfo
         C5+OMLcLzxe40UuXlB7wiAwffKkXW9YveqbrK5IVaa9RH/AuJ8whqMXlyFG0G1UziS
         lGWwTs0s8GmziCje641LY3z6twFh3tHcype78ggsA7Hu92Lp+GfQkzjlrmOoK+p19f
         X9prWTCp8OX5ByauPLfYvkIsBpzcL4TsnSaOuOqmhi9sac1b6FjPcyKq1PDoBPbiZA
         jHzQxFgLOlkWJ36wmqfexu+Y9wAqpdP3vdSONWV9ImJSC9UtKlNy/YWd7WPY3okRFb
         62TjSrtWPcbGA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 286f58e1;
        Fri, 18 Nov 2022 13:55:49 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     GUO Zihua <guozihua@huawei.com>, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/2] 9p/xen: check logical size for buffer size
Date:   Fri, 18 Nov 2022 22:55:41 +0900
Message-Id: <20221118135542.63400-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_xen did not check the data fits into the buffer before copying
from the xen ring, but we probably should.
Add a check that just skips the request and return an error to
userspace if it did not fit

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

This comes more or less as a follow up of a fix for trans_fd:
https://lkml.kernel.org/r/20221117091159.31533-1-guozihua@huawei.com
Where msize should be replaced by capacity check, except trans_xen
did not actually use to check the size fits at all.

While we normally trust the hypervisor (they can probably do whatever
they want with our memory), a bug in the 9p server is always possible so
sanity checks never hurt, especially now buffers got drastically smaller
with a recent patch.

My setup for xen is unfortunately long dead so I cannot test this:
Stefano, you've tested v9fs xen patches in the past, would you mind
verifying this works as well?

 net/9p/trans_xen.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index b15c64128c3e..66ceb3b3ae30 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -208,6 +208,14 @@ static void p9_xen_response(struct work_struct *work)
 			continue;
 		}
 
+		if (h.size > req->rc.capacity) {
+			dev_warn(&priv->dev->dev,
+				 "requested packet size too big: %d for tag %d with capacity %zd\n",
+		                 h.size, h.tag, rreq->rc.capacity);
+			req->status = REQ_STATUS_ERROR;
+			goto recv_error;
+		}
+
 		memcpy(&req->rc, &h, sizeof(h));
 		req->rc.offset = 0;
 
@@ -217,6 +225,7 @@ static void p9_xen_response(struct work_struct *work)
 				     masked_prod, &masked_cons,
 				     XEN_9PFS_RING_SIZE(ring));
 
+recv_error:
 		virt_mb();
 		cons += h.size;
 		ring->intf->in_cons = cons;
-- 
2.38.1

