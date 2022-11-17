Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD862E182
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiKQQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbiKQQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9CA7AF5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7012A62129
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CB2C433D7;
        Thu, 17 Nov 2022 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702015;
        bh=KhJyknLK5Qtb4Z8bOVZFK77k3kNLc1fNDCAq4CrK1e4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ef3xfg9m3uRrhmpQlChPhNytjeizFdqV4x61w+5EIqIh5C/FuQgoEj6wJ5K9gjnM6
         12yhoWtL5LsbBBnnu8NZMs/0ZCFo5CARtG8m0wpFRffqO4zXSwiXRNeh4Z4LeA7Hug
         uVMgYo1L8PiD/2xAAAPmPXi/2JWTAlCsOWK7Q7n1BHodVwmFms+4LOjbNnB0DDlo5x
         tXMLZyc5jjjOe9Rv3VEAVPMGeaA+NfQGENsiHUqudNoWrPw0NbiWE5LJ072ZeRSYBU
         z8lE2cjG40T5fGM5uWMDBwB3fgF1k/00Gw4bog+vF0uyzP3zD3UljGjtmUNE0P3OTU
         PBVnzULSIAtMg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 15/20] habanalabs/gaudi2: return to reset upon SM SEI BRESP error
Date:   Thu, 17 Nov 2022 18:19:46 +0200
Message-Id: <20221117161951.845454-15-ogabbay@kernel.org>
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

Due to a H/W issue in the LBW path to the PCIE_DBI MSI-X doorbell, there
were false sporadic error responses in SM when it was configured to
write to there, and hence no reset was done as part of handling the
relevant event.
Now that the virtual MSI-X doorbell is used, such errors in SM are not
expected and reset shouldn't be skipped.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index d5efec347bc1..f0f2f77f56de 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8300,11 +8300,10 @@ static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char
 	WREG32(mmu_base + MMU_INTERRUPT_CLR_OFFSET, interrupt_clr);
 }
 
-static bool gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
+static void gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 {
 	u32 sei_cause_addr, sei_cause_val, sei_cause_cause, sei_cause_log;
 	u32 cq_intr_addr, cq_intr_val, cq_intr_queue_index;
-	bool reset = true;
 	int i;
 
 	sei_cause_addr = mmDCORE0_SYNC_MNGR_GLBL_SM_SEI_CAUSE + DCORE_OFFSET * sm_index;
@@ -8329,10 +8328,6 @@ static bool gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 					gaudi2_sm_sei_cause[i].cause_name,
 					gaudi2_sm_sei_cause[i].log_name,
 					sei_cause_log & gaudi2_sm_sei_cause[i].log_mask);
-
-			/* Due to a potential H/W issue, do not reset upon BRESP errors */
-			if (i == 2)
-				reset = false;
 			break;
 		}
 
@@ -8352,8 +8347,6 @@ static bool gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 		/* Clear CQ_INTR */
 		WREG32(cq_intr_addr, 0);
 	}
-
-	return reset;
 }
 
 static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
@@ -8755,8 +8748,8 @@ static void hl_arc_event_handle(struct hl_device *hdev,
 
 static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 {
-	bool reset_required = false, skip_reset = false, is_critical = false;
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	bool reset_required = false, is_critical = false;
 	u32 ctl, reset_flags = HL_DRV_RESET_HARD;
 	int index, sbte_index;
 	u64 event_mask = 0;
@@ -9113,7 +9106,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE ... GAUDI2_EVENT_SM3_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE;
-		skip_reset = !gaudi2_handle_sm_err(hdev, index);
+		gaudi2_handle_sm_err(hdev, index);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -9153,9 +9146,9 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 						event_type);
 	}
 
-	if ((gaudi2_irq_map_table[event_type].reset || reset_required) && !skip_reset &&
-			(hdev->hard_reset_on_fw_events ||
-			(hdev->asic_prop.fw_security_enabled && is_critical)))
+	if ((gaudi2_irq_map_table[event_type].reset || reset_required) &&
+				(hdev->hard_reset_on_fw_events ||
+				(hdev->asic_prop.fw_security_enabled && is_critical)))
 		goto reset_device;
 
 	/* Send unmask irq only for interrupts not classified as MSG */
-- 
2.25.1

