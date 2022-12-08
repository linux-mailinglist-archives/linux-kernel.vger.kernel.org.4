Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FDE647299
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiLHPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiLHPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96020ABA12
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E3E61F79
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84869C433D6;
        Thu,  8 Dec 2022 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512441;
        bh=yxVZQftgzo21Yr+TkI+JgRMZd0otPm2SNXiTeaqQMcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmF2CYCMbHGi9ckAu7W3NxQMfQABVl6dh71pCCdT3FtpZ3D0AQeZcP0okCZSM4ida
         rS6J4Z/C5hhFcQ3I+DjFmLTjoaAuagetFubJ+J9CAd2mAssxvzyrgHs79HdtYtkA4G
         pBxT39gdz7qG94CyDowN7ZhCs9EUGC2DWJY85seVl5oJ5hlrrUFBmct2cl/DUQqlsa
         q7yy+wCQzZq3FYA5DFQ5TSdnNz1QV9sgkfYXZtCVaz7WVTRZoTGoFl6jLP6ns8YgU4
         /Zm6xntf+mPyo+gvN5TxZuw1wGRoPahLPRLgvNKByvOg+n/fr+ghMD3tbuVXKwx90t
         HQGmwZRY7B29w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 05/26] habanalabs: don't notify user about clk throttling due to power
Date:   Thu,  8 Dec 2022 17:13:29 +0200
Message-Id: <20221208151350.1833823-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

As clock throttling due to high power consumption can happen very
frequently and there is no real reason to notify the user about it,
we skip this notification in all asics.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c   | 7 ++++---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9f5e208701ba..ae78f838f987 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7584,7 +7584,7 @@ static int tpc_krn_event_to_tpc_id(u16 tpc_dec_event_type)
 	return (tpc_dec_event_type - GAUDI_EVENT_TPC0_KRN_ERR) / 6;
 }
 
-static void gaudi_print_clk_change_info(struct hl_device *hdev, u16 event_type)
+static void gaudi_print_clk_change_info(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	ktime_t zero_time = ktime_set(0, 0);
 
@@ -7612,6 +7612,7 @@ static void gaudi_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_THERMAL;
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].start = ktime_get();
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = zero_time;
+		*event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to overheating\n");
 		break;
@@ -7619,6 +7620,7 @@ static void gaudi_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 	case GAUDI_EVENT_FIX_THERMAL_ENV_E:
 		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_THERMAL;
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = ktime_get();
+		*event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		dev_info_ratelimited(hdev->dev,
 			"Thermal envelop is safe, back to optimal clock\n");
 		break;
@@ -7887,8 +7889,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		break;
 
 	case GAUDI_EVENT_FIX_POWER_ENV_S ... GAUDI_EVENT_FIX_THERMAL_ENV_E:
-		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
-		gaudi_print_clk_change_info(hdev, event_type);
+		gaudi_print_clk_change_info(hdev, event_type, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index e793fb2bdcbe..c14b3bb16f96 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8603,7 +8603,7 @@ static void gaudi2_handle_hbm_mc_spi(struct hl_device *hdev, u64 intr_cause_data
 				hbm_mc_spi[i].cause);
 }
 
-static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type)
+static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	ktime_t zero_time = ktime_set(0, 0);
 
@@ -8629,12 +8629,14 @@ static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_THERMAL;
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].start = ktime_get();
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = zero_time;
+		*event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		dev_info_ratelimited(hdev->dev, "Clock throttling due to overheating\n");
 		break;
 
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
 		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_THERMAL;
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = ktime_get();
+		*event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		dev_info_ratelimited(hdev->dev, "Thermal envelop is safe, back to optimal clock\n");
 		break;
 
@@ -9085,8 +9087,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_E:
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_S:
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
-		gaudi2_print_clk_change_info(hdev, event_type);
-		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
+		gaudi2_print_clk_change_info(hdev, event_type, &event_mask);
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_QUEUE_OUT_SYNC:
-- 
2.25.1

