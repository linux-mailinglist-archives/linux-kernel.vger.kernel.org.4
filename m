Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE562E169
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiKQQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiKQQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EBD74CE8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C883B82106
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8664AC433C1;
        Thu, 17 Nov 2022 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702001;
        bh=kUluxspYCSEwhHwxHr/16Jwpsv1UyFZrsVvni+5ynh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+LFliHw6DVA0OU/n9VR2+v6IzUaaKsWWKGmNUO6jyaK3QK+NQmZoQA84VWy3HskF
         I2fLal0yXwLacbyApJ7pzrTSoM4zdoJpyCSw7yNszO4fDuB0RLhRItzGWFL0C3iZ37
         HnN1WGkEStsCF+tMkoLZFe0l5sLx/M6eVzz+BZqLOOHfg8AlboUC1cgIHfO3pxl/Y9
         vyruDwjPIE+WPompQSCSXmXoKVPdpQ75dpmLR/0l4shWTyPY6s/ang/ANOLnxE5k4F
         IhI7e6tpf1UMnm0Q7geS9hz7sHQT81mH1nI9z+HuyupiaVGaIn2DsBkA9bVyr1miIE
         MKFd70xYmxzGQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 04/20] habanalabs/gaudi: add page fault notify event
Date:   Thu, 17 Nov 2022 18:19:35 +0200
Message-Id: <20221117161951.845454-4-ogabbay@kernel.org>
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
 drivers/misc/habanalabs/common/device.c     | 9 +++++++++
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 6 +++---
 include/uapi/misc/habanalabs.h              | 2 ++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 65bb40f81901..31818121ef4d 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2490,3 +2490,12 @@ void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is
 	hdev->captured_err_info.pgf_info.pgf.engine_id = eng_id;
 	hl_capture_user_mappings(hdev, is_pmmu);
 }
+
+void hl_handle_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu,
+				u64 *event_mask)
+{
+	hl_capture_page_fault(hdev, addr, eng_id, is_pmmu);
+
+	if (event_mask)
+		*event_mask |=  HL_NOTIFIER_EVENT_PAGE_FAULT;
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d9335f3769b8..0781b8698f74 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3815,6 +3815,8 @@ void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_
 void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
 			u8 flags, u64 *event_mask);
 void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu);
+void hl_handle_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu,
+				u64 *event_mask);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 035865cb097c..cbe1daf5a793 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6740,7 +6740,7 @@ static void gaudi_print_and_get_razwi_info(struct hl_device *hdev, u16 *engine_i
 	}
 }
 
-static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr)
+static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr, u64 *event_mask)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 val;
@@ -6755,7 +6755,7 @@ static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr
 		*addr |= RREG32(mmMMU_UP_PAGE_ERROR_CAPTURE_VA);
 
 		dev_err_ratelimited(hdev->dev, "MMU page fault on va 0x%llx\n", *addr);
-		hl_capture_page_fault(hdev, *addr, 0, true);
+		hl_handle_page_fault(hdev, *addr, 0, true, event_mask);
 
 		WREG32(mmMMU_UP_PAGE_ERROR_CAPTURE, 0);
 	}
@@ -7323,7 +7323,7 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 	if (razwi) {
 		gaudi_print_and_get_razwi_info(hdev, &engine_id[0], &engine_id[1], &is_read,
 						&is_write);
-		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr);
+		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr, event_mask);
 
 		if (is_read)
 			razwi_flags |= HL_RAZWI_READ;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 7747e19e81fe..e50cb71df081 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -722,6 +722,7 @@ enum hl_server_type {
  * HL_NOTIFIER_EVENT_USER_ENGINE_ERR	- Indicates device engine in error state
  * HL_NOTIFIER_EVENT_GENERAL_HW_ERR     - Indicates device HW error
  * HL_NOTIFIER_EVENT_RAZWI              - Indicates razwi happened
+ * HL_NOTIFIER_EVENT_PAGE_FAULT         - Indicates page fault happened
  */
 #define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
 #define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
@@ -731,6 +732,7 @@ enum hl_server_type {
 #define HL_NOTIFIER_EVENT_USER_ENGINE_ERR	(1ULL << 5)
 #define HL_NOTIFIER_EVENT_GENERAL_HW_ERR	(1ULL << 6)
 #define HL_NOTIFIER_EVENT_RAZWI			(1ULL << 7)
+#define HL_NOTIFIER_EVENT_PAGE_FAULT		(1ULL << 8)
 
 /* Opcode for management ioctl
  *
-- 
2.25.1

