Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8262E183
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiKQQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiKQQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676F7AF5A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2312161F8D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6862C433B5;
        Thu, 17 Nov 2022 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702014;
        bh=cG9hZwXNRuiQZjNeQ1AQkqlDnp6QpVaoJ1jmozgotEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSGOLvVpFSA3e+OKPUGDPn0uo5iOkun8Y7IzZciR7DivIrQOtzeT1GbUKdkB1d+t3
         c4q8ZuUIxPGC8ORZeeqPl+ODd/3fz49lzQxou9Gr7LIvCsB7IVNz4KC7FJ35NkvYpq
         CMJWAnzqW9WE8NJgOTxx+wcvq9BFSzmrewSKSbIDN5OcSaHhYiZKbfr1h1M1S+E0dx
         q/btJ45QzQwYAiTNgnY2fJBnlRbAWb+oHYDe/HgOuoCjh+nSdLKubF9XhPzV2SzgTJ
         ZSJNA6ai/fzyD8X6NLPJUqJN5cHB2CjmTr7pSFHqIpbbdC1EUhUp/dT2FhDutTLyy3
         xzKLA4hVXLhIQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 14/20] habanalabs/gaudi2: don't enable entries in the MSIX_GW table
Date:   Thu, 17 Nov 2022 18:19:45 +0200
Message-Id: <20221117161951.845454-14-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

User should use the virtual MSI-X doorbell to generate interrupts from
the device, so there is no need to enable entries in the MSIX_GW table.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 26 -------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 36f0ea1100bb..d5efec347bc1 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -4695,30 +4695,6 @@ static void gaudi2_init_dec(struct hl_device *hdev)
 	}
 }
 
-static void gaudi2_init_msix_gw_table(struct hl_device *hdev)
-{
-	u32 first_reg_offset, last_reg_offset, msix_gw_table_base;
-	u8 first_bit, last_bit;
-	int i;
-
-	msix_gw_table_base = mmPCIE_WRAP_MSIX_GW_TABLE_0;
-	first_reg_offset = (GAUDI2_IRQ_NUM_USER_FIRST >> 5) << 2;
-	first_bit = GAUDI2_IRQ_NUM_USER_FIRST % 32;
-	last_reg_offset = (GAUDI2_IRQ_NUM_USER_LAST >> 5) << 2;
-	last_bit = GAUDI2_IRQ_NUM_USER_LAST % 32;
-
-	if (first_reg_offset == last_reg_offset) {
-		WREG32(msix_gw_table_base + first_reg_offset, GENMASK(last_bit, first_bit));
-		return;
-	}
-
-	WREG32(msix_gw_table_base + first_reg_offset, GENMASK(31, first_bit));
-	WREG32(msix_gw_table_base + last_reg_offset, GENMASK(last_bit, 0));
-
-	for (i = first_reg_offset + 4; i < last_reg_offset ; i += 4)
-		WREG32(msix_gw_table_base + i, 0xFFFFFFFF);
-}
-
 static int gaudi2_mmu_update_asid_hop0_addr(struct hl_device *hdev,
 					u32 stlb_base, u32 asid, u64 phys_addr)
 {
@@ -5232,8 +5208,6 @@ static int gaudi2_hw_init(struct hl_device *hdev)
 		return rc;
 	}
 
-	gaudi2_init_msix_gw_table(hdev);
-
 	gaudi2_init_scrambler_hbm(hdev);
 	gaudi2_init_kdma(hdev);
 
-- 
2.25.1

