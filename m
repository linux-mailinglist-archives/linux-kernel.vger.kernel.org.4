Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6045F6281
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJFIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiJFIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02047915F3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25CF2B8203E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0870C433D7;
        Thu,  6 Oct 2022 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044600;
        bh=iUxQDVXgh7Bk8IDrgKsjsK54BrN3XyvHDn6orYndcdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUhYA9Li2PkshdpGx2lYL/FcDib6Snu/fYPcqxn1it1WJte9pr6YWqKABkp8QlvRb
         zonPSPdAIgWR4aeYNSF3DWGSP0MiR7eLm0wVciO4tj4q7pwkRPpDFjFbE4TCp7cmb2
         dB2gc3IxFcQgFoATmPi33wBbCUB1N3PCjr/b4mDWuasFMDua+8xVZxj7lOqhlAFUFd
         mYKDjBdT7p8EGFz4Ta4YYMEcFN0LulomDITpCionJJNPM15MtTh82I+f5XpXG8gEdq
         ocZMTCcJuY9jnB2iAPG0LXR1fOhSZAA3nIcLcr90/FYYyBYJuZG17nfJ5joFezv4UE
         1rWipEknhItEQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 06/13] habanalabs/gaudi2: add device unavailable notification
Date:   Thu,  6 Oct 2022 11:23:01 +0300
Message-Id: <20221006082308.1266716-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

Device unavailable notifies the user that there isn't an option to
retrieve debug information from the device.
When a critical device error occurs and the f/w performs the device
reset, a device unavailable notification shall be sent to the user
process.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 90e1d7fcb17a..e05ffaa047a2 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8576,7 +8576,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 {
 	u32 ctl, reset_flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY;
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
-	bool reset_required = false, skip_reset = false;
+	bool reset_required = false, skip_reset = false, is_critical = false;
 	int index, sbte_index;
 	u64 event_mask = 0;
 	u16 event_type;
@@ -8602,6 +8602,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		reset_required = gaudi2_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		is_critical = eq_entry->ecc_data.is_critical;
 		break;
 
 	case GAUDI2_EVENT_TPC0_QM ... GAUDI2_EVENT_PDMA1_QM:
@@ -8976,9 +8977,16 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	return;
 
 reset_device:
-	if (hdev->hard_reset_on_fw_events) {
+	if (hdev->asic_prop.fw_security_enabled && is_critical) {
+		reset_flags = HL_DRV_RESET_HARD | HL_DRV_RESET_BYPASS_REQ_TO_FW;
+
+		/* notify on device unavailable while the reset triggered by fw */
+		event_mask |= (HL_NOTIFIER_EVENT_DEVICE_RESET |
+					HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE);
 		hl_device_reset(hdev, reset_flags);
+	} else if (hdev->hard_reset_on_fw_events) {
 		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
+		hl_device_reset(hdev, reset_flags);
 	} else {
 		if (!gaudi2_irq_map_table[event_type].msg)
 			hl_fw_unmask_irq(hdev, event_type);
-- 
2.25.1

