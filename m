Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26662E177
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiKQQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiKQQUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B0313F0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 840BCB82103
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E94C433C1;
        Thu, 17 Nov 2022 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702009;
        bh=wYyaZcJsYDXxKravXk0Nnu1NnFDV/b9rP1oOJ4QQBLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgqM1oZES5ioOOPcPdD6n4nW5+3+070B7V8JTS1qoJQ3n4xpz9g2AugODSAfXo1UN
         jqAmmVvaL2Wf+RMKlr3YvD1rCTmK8oYBF/BAJ8vorhoeWojQXOdC5lmm387sX7I2Ao
         OYhvLzvRwPdhsgP/D8tGOHsN2mzEtoSdKlFSGrMHGqFDgs/jXreY68e3JvSBzfHfsg
         j0D5cYZe82g0w2wrR5x/eR/jr1u/1yWRudGHhh3PvcipWNOxxWhLenXkZDntVAvA9N
         ee4GcI5SrhkMWLfUADLRNFSj+oYeTbRiHRJprrk/jyBWCdeQT6RwJYmUCVr/84Pm/z
         lsWhuyvGtuQMg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 10/20] habanalabs/gaudi2: add page fault notify event
Date:   Thu, 17 Nov 2022 18:19:41 +0200
Message-Id: <20221117161951.845454-10-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

Each time page fault happens, besides capturing its data, also notify
the user about it.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 61960fa059e0..65c9b535aa69 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8253,7 +8253,8 @@ static void gaudi2_handle_hif_fatal(struct hl_device *hdev, u16 event_type, u64
 	}
 }
 
-static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool is_pmmu)
+static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool is_pmmu,
+					u64 *event_mask)
 {
 	u32 valid, val;
 	u64 addr;
@@ -8270,7 +8271,7 @@ static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool
 
 	dev_err_ratelimited(hdev->dev, "%s page fault on va 0x%llx\n",
 				is_pmmu ? "PMMU" : "HMMU", addr);
-	hl_capture_page_fault(hdev, addr, 0, is_pmmu);
+	hl_handle_page_fault(hdev, addr, 0, is_pmmu, event_mask);
 
 	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE), 0);
 }
@@ -8296,7 +8297,7 @@ static void gaudi2_handle_access_error(struct hl_device *hdev, u64 mmu_base, boo
 }
 
 static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char *mmu_name,
-						u64 mmu_base, bool is_pmmu)
+						u64 mmu_base, bool is_pmmu, u64 *event_mask)
 {
 	u32 spi_sei_cause, interrupt_clr = 0x0;
 	int i;
@@ -8309,7 +8310,7 @@ static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char
 						mmu_name, gaudi2_mmu_spi_sei[i].cause);
 
 			if (i == 0)
-				gaudi2_handle_page_error(hdev, mmu_base, is_pmmu);
+				gaudi2_handle_page_error(hdev, mmu_base, is_pmmu, event_mask);
 			else if (i == 1)
 				gaudi2_handle_access_error(hdev, mmu_base, is_pmmu);
 
@@ -8381,7 +8382,7 @@ static bool gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 	return reset;
 }
 
-static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type)
+static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	bool is_pmmu = false;
 	char desc[32];
@@ -8439,7 +8440,7 @@ static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type
 		return;
 	}
 
-	gaudi2_handle_mmu_spi_sei_generic(hdev, desc, mmu_base, is_pmmu);
+	gaudi2_handle_mmu_spi_sei_generic(hdev, desc, mmu_base, is_pmmu, event_mask);
 }
 
 
@@ -8969,7 +8970,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
 	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
-		gaudi2_handle_mmu_spi_sei_err(hdev, event_type);
+		gaudi2_handle_mmu_spi_sei_err(hdev, event_type, &event_mask);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
@@ -10206,7 +10207,7 @@ static void gaudi2_ack_mmu_error(struct hl_device *hdev, u64 mmu_id)
 	if (gaudi2_get_mmu_base(hdev, mmu_id, &mmu_base))
 		return;
 
-	gaudi2_handle_page_error(hdev, mmu_base, is_pmmu);
+	gaudi2_handle_page_error(hdev, mmu_base, is_pmmu, NULL);
 	gaudi2_handle_access_error(hdev, mmu_base, is_pmmu);
 }
 
-- 
2.25.1

