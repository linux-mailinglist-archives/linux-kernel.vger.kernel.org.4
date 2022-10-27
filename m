Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D960F343
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiJ0JKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiJ0JKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663973122C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F5D62242
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B87C433C1;
        Thu, 27 Oct 2022 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861816;
        bh=I8Rl+bjV8YixLuRld88Rl1wxpGnPcrLbZqrTdMjNFjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbQqNb/KeB7tyMEctzWhI4saze611TfSwvXJeoL6MObjJIlEr8EqxFkmcVpAmnc5P
         t2ucCHsQVjQng7LNj4uUTyaJCoTkvDHN2mOYHv4sfVtVGnwS91idn32fuD7iwM5woY
         0Tu3KUZ7kJF/94ImcFg/PMM9p0LcXxlxIW4a5cQxTU3e9htSNQyFzgtLNS5lvTbPQE
         Yf5oubeP4hvCW3FT7VO1DSaG+s74m57rLbBjrYc6JpQgm+2AubtYevHXaDVjfPo5Oz
         Kn7AsC89yzSv0UjqMmausiUy8CaDM1+U0aH0cz0c+3psWpV/+UH2PgYWTaX3z+dStc
         C8ntvr08bcMLQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 03/15] habanalabs/gaudi2: remove configurations to access the MSI-X doorbell
Date:   Thu, 27 Oct 2022 12:09:55 +0300
Message-Id: <20221027091007.664797-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The virtual MSI-X doorbell is supported now in F/W, so all
configurations to access the PCIE_DBI MSI-X doorbell can be removed.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 34 +++----------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index a4e3586f1a12..9208f69dd7f8 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -4473,23 +4473,9 @@ static void gaudi2_init_sm(struct hl_device *hdev)
 	reg_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_CONFIG_CQ_EN_MASK, 1);
 	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_CONFIG_0 + (4 * i), reg_val);
 
-	/* Init CQ0 DB */
-	/* Configure the monitor to trigger MSI-X interrupt */
-	/* TODO:
-	 * Remove the if statement when virtual MSI-X doorbell is supported in simulator (SW-93022)
-	 * and in F/W (SW-93024).
-	 */
-	if (!hdev->pdev || hdev->asic_prop.fw_security_enabled) {
-		u64 msix_db_reg = CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF;
-
-		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0, lower_32_bits(msix_db_reg));
-		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0, upper_32_bits(msix_db_reg));
-	} else {
-		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0,
-				lower_32_bits(gaudi2->virt_msix_db_dma_addr));
-		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0,
-				upper_32_bits(gaudi2->virt_msix_db_dma_addr));
-	}
+	/* Init CQ0 DB - configure the monitor to trigger MSI-X interrupt */
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0, lower_32_bits(gaudi2->virt_msix_db_dma_addr));
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0, upper_32_bits(gaudi2->virt_msix_db_dma_addr));
 	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_DATA_0, GAUDI2_IRQ_NUM_COMPLETION);
 
 	for (i = 0 ; i < GAUDI2_RESERVED_CQ_NUMBER ; i++) {
@@ -4657,20 +4643,6 @@ static void gaudi2_init_vdec_brdg_ctrl(struct hl_device *hdev, u64 base_addr, u3
 {
 	u32 sob_id;
 
-	/* TODO:
-	 * Remove when virtual MSI-X doorbell is supported in simulator (SW-93022) and in F/W
-	 * (SW-93024).
-	 */
-	if (!hdev->pdev || hdev->asic_prop.fw_security_enabled) {
-		u32 interrupt_id = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM + 2 * decoder_id;
-
-		WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_AWADDR, mmPCIE_DBI_MSIX_DOORBELL_OFF);
-		WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_WDATA, interrupt_id);
-		WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_AWADDR, mmPCIE_DBI_MSIX_DOORBELL_OFF);
-		WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_WDATA, interrupt_id + 1);
-		return;
-	}
-
 	/* VCMD normal interrupt */
 	sob_id = GAUDI2_RESERVED_SOB_DEC_NRM_FIRST + decoder_id;
 	WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_AWADDR,
-- 
2.25.1

