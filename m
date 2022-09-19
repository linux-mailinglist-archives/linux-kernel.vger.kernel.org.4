Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA25BC154
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiISCVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISCVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:21:04 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49EFB13D2C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:21:03 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id EC5FD1E80D75;
        Mon, 19 Sep 2022 10:18:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CZ5HXtYIhMB8; Mon, 19 Sep 2022 10:18:02 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6F7721E80CAB;
        Mon, 19 Sep 2022 10:18:00 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     ogabbay@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        ttayar@habana.ai, obitton@habana.ai, osharabi@habana.ai
Cc:     bdotan@habana.ai, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] drivers: habanalabs: Remove unnecessary (void*) conversions
Date:   Mon, 19 Sep 2022 10:20:54 +0800
Message-Id: <20220919022054.3813-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void pointer object can be directly assigned to different structure
objects, it does not need to be cast.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 98336a1a84b0..264376617310 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -6149,7 +6149,7 @@ static int gaudi2_non_hard_reset_late_init(struct hl_device *hdev)
 static void gaudi2_is_tpc_engine_idle(struct hl_device *hdev, int dcore, int inst, u32 offset,
 					void *data)
 {
-	struct gaudi2_tpc_idle_data *idle_data = (struct gaudi2_tpc_idle_data *)data;
+	struct gaudi2_tpc_idle_data *idle_data = data;
 	u32 tpc_cfg_sts, qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts;
 	bool is_eng_idle;
 	int engine_idx;
@@ -6727,7 +6727,7 @@ static int gaudi2_mmu_shared_prepare(struct hl_device *hdev, u32 asid)
 static void gaudi2_tpc_mmu_prepare(struct hl_device *hdev, int dcore, int inst,	u32 offset,
 					void *data)
 {
-	struct gaudi2_tpc_mmu_data *mmu_data = (struct gaudi2_tpc_mmu_data *)data;
+	struct gaudi2_tpc_mmu_data *mmu_data = data;
 
 	WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_MMU_BP + offset, 0);
 	WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_ASID + offset, mmu_data->rw_asid);
@@ -9336,7 +9336,7 @@ static u32 gaudi2_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 
 static u32 gaudi2_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id, u32 size, bool eb)
 {
-	struct hl_cb *cb = (struct hl_cb *) data;
+	struct hl_cb *cb = data;
 	struct packet_msg_short *pkt;
 	u32 value, ctl, pkt_size = sizeof(*pkt);
 
@@ -9429,7 +9429,7 @@ static u32 gaudi2_add_fence_pkt(struct packet_fence *pkt)
 
 static u32 gaudi2_gen_wait_cb(struct hl_device *hdev, struct hl_gen_wait_properties *prop)
 {
-	struct hl_cb *cb = (struct hl_cb *) prop->data;
+	struct hl_cb *cb = prop->data;
 	void *buf = (void *) (uintptr_t) (cb->kernel_address);
 
 	u64 monitor_base, fence_addr = 0;
@@ -9481,7 +9481,7 @@ static u32 gaudi2_gen_wait_cb(struct hl_device *hdev, struct hl_gen_wait_propert
 
 static void gaudi2_reset_sob(struct hl_device *hdev, void *data)
 {
-	struct hl_hw_sob *hw_sob = (struct hl_hw_sob *) data;
+	struct hl_hw_sob *hw_sob = data;
 
 	dev_dbg(hdev->dev, "reset SOB, q_idx: %d, sob_id: %d\n", hw_sob->q_idx, hw_sob->sob_id);
 
-- 
2.18.2

