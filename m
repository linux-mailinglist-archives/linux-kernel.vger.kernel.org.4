Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D8728F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFIFRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIFRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:17:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB82D68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FjYMyKYq6juQYF/VuiuxQCYPCQosF6Tr+IRKaAznDZc=; b=thuIu5DyMUNPC4p08f9hTDoNYd
        M1u06I7ov1vrMXVobNEGB1QR/1iK7aOy159iYfK6/4YegJSyXl8mJo2O3MiduxP8sqRtOL5ujljmK
        r6kru5Ay4JUI9KjZqtmr9leja1obZZolZDNCJl5C9vgNTgVydA+A5th/wI1JxySHK+Wy/rdYeb0/3
        cJRhjlUai9tYpre+xEERURHGNiFaS8IcXyqy+H2fTKvPLBD923FDQSHRSsEDqyJRdwdAXphxh2/2T
        +W87AXax2SGfLvVCP4Tm6VgRVojH4hIOYbusDIHFVJyYcW8uKjFuEMxfP6zr4oUxzBOr+Fxi3iqR2
        Az7Lauzg==;
Received: from [213.208.157.39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7UVK-00Bhez-0e;
        Fri, 09 Jun 2023 05:17:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     festevam@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix rootwait= again
Date:   Fri,  9 Jun 2023 07:17:37 +0200
Message-Id: <20230609051737.328930-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous rootwait fix added an -EINVAL return to a completely
bogus superflous branch, fix this.

Fixes: 1341c7d2ccf4 ("block: fix rootwait=")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Fabio Estevam <festevam@gmail.com>
---
 block/early-lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 48ea3e982419cc..a5be3c68ed079c 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	*p = '\0';
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
-		return -ENODEV;
+		return 0;
 
 	/* try disk name without p<part number> */
 	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-- 
2.39.2

