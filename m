Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CE718373
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjEaNvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjEaNtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E11BC1;
        Wed, 31 May 2023 06:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E49263B6A;
        Wed, 31 May 2023 13:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7DDC4339B;
        Wed, 31 May 2023 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540683;
        bh=qEUsjwhhl3BEEVwSGFW2pv6M333EyUzh6VO+NOAFXjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3pOjk76FYy4bL9TYAxuwssEIu4p+TJhFTxbgec992nbDDY+TFbY5KsjHlIMAN2ow
         BNDMG//eujC3Ii97/R8ygu1Ncyo+1qVn4f0GOdDx8jFkILcEEv/yJ2rClCRKenwgfY
         hQkj9xJPr8EZKBcKUPZjMV/QIfhTKsmUHsyjnNvJOe8k4VmavJ6F0Ho8BkRYBjHDki
         PtExoW3GX2VDy44G6+6YKgRUQRm9OdakRcgpPe4DULaADNiGomWZRlquyGSyCuqMjC
         IVc4eajPhywCtIZgZ5BVpVCrPXtgc+uOr8XyOvT0Z4QhqRO6GfWe9GOQ5+XOxZvorf
         NRUAi8orwYsJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/21] MIPS: Alchemy: fix dbdma2
Date:   Wed, 31 May 2023 09:44:10 -0400
Message-Id: <20230531134415.3384458-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134415.3384458-1-sashal@kernel.org>
References: <20230531134415.3384458-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manuel Lauss <manuel.lauss@gmail.com>

[ Upstream commit 2d645604f69f3a772d58ead702f9a8e84ab2b342 ]

Various fixes for the Au1200/Au1550/Au1300 DBDMA2 code:

- skip cache invalidation if chip has working coherency circuitry.
- invalidate KSEG0-portion of the (physical) data address.
- force the dma channel doorbell write out to bus immediately with
  a sync.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/alchemy/common/dbdma.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 4ca2c28878e0f..e9ee9ab90a0c6 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -623,17 +624,18 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 		dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result
-	 * in "stale" data being DMA'ed. It has to do with the snoop logic on
-	 * the cache eviction buffer.  DMA_NONCOHERENT is on by default for
-	 * these parts. If it is fixed in the future, these dma_cache_inv will
-	 * just be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_wback_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_wback_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
@@ -685,17 +687,18 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 			  dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
 #endif
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result in
-	 * "stale" data being DMA'ed. It has to do with the snoop logic on the
-	 * cache eviction buffer.  DMA_NONCOHERENT is on by default for these
-	 * parts. If it is fixed in the future, these dma_cache_inv will just
-	 * be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
-- 
2.39.2

