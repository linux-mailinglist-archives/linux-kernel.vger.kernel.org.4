Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5812260F34E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiJ0JLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiJ0JKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE917046
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C65ACE25B4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D322CC433B5;
        Thu, 27 Oct 2022 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861824;
        bh=70E0gcVTaPge2EP2TR7/yWf73s0yIGYJywPrINv9RrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZQKcz1Bg1F10+ZqqYxTZoBEscMqMqxDOB7XC3ukjLFztc5WJ/XYjYaBomSFqii9t
         /MARY9DnaVKoVaCmHtaDapZpe2bChhfLxc6+TtF+vbTaU89zqC022m8Obl9uUgEAxi
         SH/10qm3AcNglKnD1KM1MMbNu8Fq85GsDXBVAReYnR7bQx5jnjuGwF4qXqOJ8gIs42
         EJJmzPtHw7HpAKhgn8Ac8UQtSCghxTWdAiGJI3vYOocqqg+q2pOmhOgJ4lkrI/3/Z9
         +Tpjquo6Eh5FADJTdZIvsiikVu9xGkLt9yZ8GvpV+o2W8EvmGwnOw13yrwSeglpwee
         Y+LqBni4NfGhg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/15] habanalabs/gaudi2: use graceful hard reset for F/W events
Date:   Thu, 27 Oct 2022 12:10:01 +0300
Message-Id: <20221027091007.664797-9-ogabbay@kernel.org>
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

Use graceful hard reset for F/W events on Gaudi2 device that require a
device reset.

While at it, do a small refactor of the checks and function calls,
to simplify it and to avoid code duplication.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 27 +++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 9208f69dd7f8..22f5445fe71c 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8768,9 +8768,9 @@ static void hl_arc_event_handle(struct hl_device *hdev,
 
 static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 {
-	u32 ctl, reset_flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY;
-	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	bool reset_required = false, skip_reset = false, is_critical = false;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 ctl, reset_flags = HL_DRV_RESET_HARD;
 	int index, sbte_index;
 	u64 event_mask = 0;
 	u16 event_type;
@@ -9158,7 +9158,9 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 						event_type);
 	}
 
-	if ((gaudi2_irq_map_table[event_type].reset || reset_required) && !skip_reset)
+	if ((gaudi2_irq_map_table[event_type].reset || reset_required) && !skip_reset &&
+			(hdev->hard_reset_on_fw_events ||
+			(hdev->asic_prop.fw_security_enabled && is_critical)))
 		goto reset_device;
 
 	/* Send unmask irq only for interrupts not classified as MSG */
@@ -9172,22 +9174,13 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 reset_device:
 	if (hdev->asic_prop.fw_security_enabled && is_critical) {
-		reset_flags = HL_DRV_RESET_HARD | HL_DRV_RESET_BYPASS_REQ_TO_FW;
-
-		/* notify on device unavailable while the reset triggered by fw */
-		event_mask |= (HL_NOTIFIER_EVENT_DEVICE_RESET |
-					HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE);
-		hl_device_reset(hdev, reset_flags);
-	} else if (hdev->hard_reset_on_fw_events) {
-		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
-		hl_device_reset(hdev, reset_flags);
+		reset_flags |= HL_DRV_RESET_BYPASS_REQ_TO_FW;
+		event_mask |= HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE;
 	} else {
-		if (!gaudi2_irq_map_table[event_type].msg)
-			hl_fw_unmask_irq(hdev, event_type);
+		reset_flags |= HL_DRV_RESET_DELAY;
 	}
-
-	if (event_mask)
-		hl_notifier_event_send_all(hdev, event_mask);
+	event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
+	hl_device_cond_reset(hdev, reset_flags, event_mask);
 }
 
 static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val)
-- 
2.25.1

