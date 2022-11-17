Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3262E186
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiKQQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbiKQQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B877C00E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F88DB82108
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59456C433D7;
        Thu, 17 Nov 2022 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702021;
        bh=lYxwufEX6icK/IjetN7+SM6rENMbyTQIdRIkrtag03o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPYwgNf3lDE08P02M+mr4Q3kn378AEr9TaLo/ya/1Tc21up0nZaGUhhu2Jk6I2BOo
         iEkSHbkEVs6QiF0p2rMctjZykkUehJwb4KCbqJgp4FJzSMYpbCq1yy7Xq966YlzEdm
         faXBYOGrC0QvGarJfgLWuqqQvFeEH3JhvyRZLfC+hKTRu5HvXNLHoRYLCCZ5UgktOe
         udoUW9UTQ+GTs40tsbd8AEUEkU+HZGLSOyD+lYBXrfsJPXZGdjuIB8JAy11xzOaKvr
         Jsi29alfGeg899nBtogwpM63BiHZdVx5PLHi2EICMhp5WbM+El35l0y5AGvxfZ3TBv
         YhriaEjkpc7ow==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 19/20] habanalabs/gaudi2: change memory scrub mechanism
Date:   Thu, 17 Nov 2022 18:19:50 +0200
Message-Id: <20221117161951.845454-19-ogabbay@kernel.org>
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

From: farah kassabri <fkassabri@habana.ai>

Currently the scrubbing mechanism used the EDMA engines by directly
setting the engine core registers to scrub a chunk of memory.
Due to a sporadic failure with this mechanism, it was decided to
initiate the engines via its QMAN using LIN-DMA packets.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 129 +++++++++++++++---------
 1 file changed, 83 insertions(+), 46 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index f0f2f77f56de..c14e63164a84 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9171,34 +9171,74 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	hl_device_cond_reset(hdev, reset_flags, event_mask);
 }
 
+static int gaudi2_memset_memory_chunk_using_edma_qm(struct hl_device *hdev,
+			struct packet_lin_dma *lin_dma_pkt, dma_addr_t pkt_dma_addr,
+			u32 hw_queue_id, u32 size, u64 addr, u32 val)
+{
+	u32 ctl, pkt_size;
+	int rc = 0;
+
+	ctl = FIELD_PREP(GAUDI2_PKT_CTL_OPCODE_MASK, PACKET_LIN_DMA);
+	ctl |= FIELD_PREP(GAUDI2_PKT_LIN_DMA_CTL_MEMSET_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI2_PKT_LIN_DMA_CTL_WRCOMP_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_EB_MASK, 1);
+
+	lin_dma_pkt->ctl = cpu_to_le32(ctl);
+	lin_dma_pkt->src_addr = cpu_to_le64(val);
+	lin_dma_pkt->dst_addr = cpu_to_le64(addr);
+	lin_dma_pkt->tsize = cpu_to_le32(size);
+
+	pkt_size = sizeof(struct packet_lin_dma);
+
+	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id, pkt_size, pkt_dma_addr);
+	if (rc)
+		dev_err(hdev->dev, "Failed to send lin dma packet to H/W queue %d\n",
+				hw_queue_id);
+
+	return rc;
+}
+
 static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 edma_queues_id[] = {GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0,
+					GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0,
+					GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0,
+					GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0};
+	u32 chunk_size, dcore, edma_idx, sob_offset, sob_addr, comp_val,
+		old_mmubp, mmubp, num_of_pkts, busy, pkt_size;
 	u64 comp_addr, cur_addr = addr, end_addr = addr + size;
-	u32 chunk_size, busy, dcore, edma_idx, sob_offset, sob_addr, comp_val, edma_commit;
-	u32 old_mmubp, mmubp;
-	int rc = 0;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	void *lin_dma_pkts_arr;
+	dma_addr_t pkt_dma_addr;
+	int rc = 0, dma_num = 0;
+
+	if (prop->edma_enabled_mask == 0) {
+		dev_info(hdev->dev, "non of the EDMA engines is enabled - skip dram scrubbing\n");
+		return -EIO;
+	}
 
 	sob_offset = hdev->asic_prop.first_available_user_sob[0] * 4;
 	sob_addr = mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset;
 	comp_addr = CFG_BASE + sob_addr;
 	comp_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1) |
 		FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1);
-
-	edma_commit = FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_LIN_MASK, 1) |
-			FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_MEM_SET_MASK, 1) |
-			FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_WR_COMP_EN_MASK, 1);
 	mmubp = FIELD_PREP(ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_WR_MASK, 1) |
 		FIELD_PREP(ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_RD_MASK, 1);
 
-	if (prop->edma_enabled_mask == 0) {
-		dev_info(hdev->dev, "non of the EDMA engines is enabled - skip dram scrubbing\n");
-		return -EIO;
-	}
+	/* Calculate how many lin dma pkts we'll need */
+	num_of_pkts = div64_u64(round_up(size, SZ_2G), SZ_2G);
+	pkt_size = sizeof(struct packet_lin_dma);
+
+	lin_dma_pkts_arr = hl_asic_dma_alloc_coherent(hdev, pkt_size * num_of_pkts,
+					&pkt_dma_addr, GFP_KERNEL);
+	if (!lin_dma_pkts_arr)
+		return -ENOMEM;
 
 	/*
 	 * set mmu bypass for the scrubbing - all ddmas are configured the same so save
 	 * only the first one to restore later
+	 * also set the sob addr for all edma cores for completion.
+	 * set QM as trusted to allow it to access physical address with MMU bp.
 	 */
 	old_mmubp = RREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP);
 	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
@@ -9211,17 +9251,22 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 
 			WREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP +
 					edma_offset, mmubp);
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_LO + edma_offset,
+					lower_32_bits(comp_addr));
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_HI + edma_offset,
+					upper_32_bits(comp_addr));
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_WDATA + edma_offset,
+					comp_val);
+			gaudi2_qman_set_test_mode(hdev,
+					edma_queues_id[dcore] + 4 * edma_idx, true);
 		}
 	}
 
-	while (cur_addr < end_addr) {
-		int dma_num = 0;
+	WREG32(sob_addr, 0);
 
-		WREG32(sob_addr, 0);
+	while (cur_addr < end_addr) {
 		for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
 			for (edma_idx = 0 ; edma_idx < NUM_OF_EDMA_PER_DCORE ; edma_idx++) {
-				u32 edma_offset = dcore * DCORE_OFFSET +
-					edma_idx * DCORE_EDMA_OFFSET;
 				u32 edma_bit = dcore * NUM_OF_EDMA_PER_DCORE + edma_idx;
 
 				if (!(prop->edma_enabled_mask & BIT(edma_bit)))
@@ -9229,41 +9274,26 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 
 				chunk_size = min_t(u64, SZ_2G, end_addr - cur_addr);
 
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_SRC_BASE_LO + edma_offset,
-						lower_32_bits(val));
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_SRC_BASE_HI + edma_offset,
-						upper_32_bits(val));
-
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_DST_BASE_LO + edma_offset,
-						lower_32_bits(cur_addr));
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_DST_BASE_HI + edma_offset,
-						upper_32_bits(cur_addr));
-
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_LO + edma_offset,
-						lower_32_bits(comp_addr));
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_HI + edma_offset,
-						upper_32_bits(comp_addr));
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_WDATA + edma_offset,
-						comp_val);
-
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_DST_TSIZE_0 + edma_offset,
-						chunk_size);
-				WREG32(mmDCORE0_EDMA0_CORE_CTX_COMMIT + edma_offset, edma_commit);
+				rc = gaudi2_memset_memory_chunk_using_edma_qm(hdev,
+					(struct packet_lin_dma *)lin_dma_pkts_arr + dma_num,
+					pkt_dma_addr + dma_num * pkt_size,
+					edma_queues_id[dcore] + edma_idx * 4,
+					chunk_size, cur_addr, val);
+				if (rc)
+					goto end;
 
 				dma_num++;
-
 				cur_addr += chunk_size;
-
 				if (cur_addr == end_addr)
-					goto poll;
+					break;
 			}
 		}
-poll:
-		rc = hl_poll_timeout(hdev, sob_addr, busy, (busy == dma_num), 1000, 1000000);
-		if (rc) {
-			dev_err(hdev->dev, "DMA Timeout during HBM scrubbing\n");
-			goto end;
-		}
+	}
+
+	rc = hl_poll_timeout(hdev, sob_addr, busy, (busy == dma_num), 1000, 1000000);
+	if (rc) {
+		dev_err(hdev->dev, "DMA Timeout during HBM scrubbing\n");
+		goto end;
 	}
 end:
 	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
@@ -9275,10 +9305,17 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 				continue;
 
 			WREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP + edma_offset, old_mmubp);
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_LO + edma_offset, 0);
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_HI + edma_offset, 0);
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_WDATA + edma_offset, 0);
+			gaudi2_qman_set_test_mode(hdev,
+					edma_queues_id[dcore] + 4 * edma_idx, false);
 		}
 	}
 
 	WREG32(sob_addr, 0);
+	hl_asic_dma_free_coherent(hdev, pkt_size * num_of_pkts, lin_dma_pkts_arr, pkt_dma_addr);
+
 	return rc;
 }
 
-- 
2.25.1

