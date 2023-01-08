Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD466174A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjAHRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjAHRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528DA470
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B2C460D2F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF766C433F0;
        Sun,  8 Jan 2023 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198446;
        bh=I/rGezdf/1ZPyv8jYX4fSost+efILM+CtktYAob8RCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHZTzXmUp81ZDuK8yUdvOoPkXHgXXzPaeTUty0Lwb8H91Z1oVLIEEYuCtmvsYDbSH
         cU4H2Igqja8MK9FHLA3cXpYmbX4KILaP5PuGhCTfzDfFETp+FGP4Zj6D+4QIJur6mD
         wzy0DNmBhlg0rIrn4LFXD4D/jhWKxROTnmJ77yP1IT6/vIeiHQ5EfX7dmMAsWwTyXt
         fmLpdxesMa5Z9VOZNXgfp1qyMA08fCKowYVHb9fwYHQ8zsCpzvyv6WIEa93y1BPuoU
         /pr5SlA71tZSEPCPbqmI8UawH0um4/4Gryg9/yDoUlcWFe88Be52HtnXxBpodxMOvf
         UMMNlWHk6/qlw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/7] habanalabs: add set engines masks ASIC function
Date:   Sun,  8 Jan 2023 19:20:35 +0200
Message-Id: <20230108172040.3991204-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108172040.3991204-1-ogabbay@kernel.org>
References: <20230108172040.3991204-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

This function shall be used whenever components enable/binning masks
should be updated.

Usage is in one of the below cases:
- update user (or default) component masks
- update when getting the masks from FW (either CPUCP or COMMS)

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 12 +++++---
 drivers/accel/habanalabs/common/habanalabs.h  |  2 ++
 drivers/accel/habanalabs/gaudi/gaudi.c        |  6 ++++
 drivers/accel/habanalabs/gaudi2/gaudi2.c      | 30 +++++++++++++------
 drivers/accel/habanalabs/goya/goya.c          |  6 ++++
 5 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index eb000e035026..ef228087ef55 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -2647,7 +2647,7 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
 
 		if (rc)
-			goto out;
+			return rc;
 
 		/* read binning info from preboot */
 		if (hdev->support_preboot_binning) {
@@ -2660,15 +2660,19 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 
 			rc = hdev->asic_funcs->set_dram_properties(hdev);
 			if (rc)
-				goto out;
+				return rc;
+
+			rc = hdev->asic_funcs->set_binning_masks(hdev);
+			if (rc)
+				return rc;
 
 			dev_dbg(hdev->dev,
 				"Read binning masks: tpc: 0x%llx, dram: 0x%llx, edma: 0x%x, dec: 0x%x, rot:0x%x\n",
 				hdev->tpc_binning, hdev->dram_binning, hdev->edma_binning,
 				hdev->decoder_binning, hdev->rotator_binning);
 		}
-out:
-		return rc;
+
+		return 0;
 	}
 
 	/* load boot fit to FW */
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index cd474422163d..0b7fe4afd92d 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -1549,6 +1549,7 @@ struct engines_data {
  * @set_engine_cores: set a config command to engine cores
  * @send_device_activity: indication to FW about device availability
  * @set_dram_properties: set DRAM related properties.
+ * @set_binning_masks: set binning/enable masks for all relevant components.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1687,6 +1688,7 @@ struct hl_asic_funcs {
 					u32 num_cores, u32 core_command);
 	int (*send_device_activity)(struct hl_device *hdev, bool open);
 	int (*set_dram_properties)(struct hl_device *hdev);
+	int (*set_binning_masks)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index 733916f38752..71debe862c86 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -9135,6 +9135,11 @@ static int gaudi_set_dram_properties(struct hl_device *hdev)
 	return 0;
 }
 
+static int gaudi_set_binning_masks(struct hl_device *hdev)
+{
+	return 0;
+}
+
 static void gaudi_check_if_razwi_happened(struct hl_device *hdev)
 {
 }
@@ -9262,6 +9267,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.set_dram_bar_base = gaudi_set_hbm_bar_base,
 	.send_device_activity = gaudi_send_device_activity,
 	.set_dram_properties = gaudi_set_dram_properties,
+	.set_binning_masks = gaudi_set_binning_masks,
 };
 
 /**
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 4529a64d49b6..0f3e690041af 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2437,6 +2437,25 @@ static int gaudi2_set_cluster_binning_masks(struct hl_device *hdev)
 	return 0;
 }
 
+static int gaudi2_set_binning_masks(struct hl_device *hdev)
+{
+	int rc;
+
+	rc = gaudi2_set_cluster_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_set_tpc_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_set_dec_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
@@ -2492,15 +2511,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 	if (rc)
 		return rc;
 
-	rc = gaudi2_set_cluster_binning_masks(hdev);
-	if (rc)
-		return rc;
-
-	rc = gaudi2_set_tpc_binning_masks(hdev);
-	if (rc)
-		return rc;
-
-	rc = gaudi2_set_dec_binning_masks(hdev);
+	rc = hdev->asic_funcs->set_binning_masks(hdev);
 	if (rc)
 		return rc;
 
@@ -10597,6 +10608,7 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.set_engine_cores = gaudi2_set_engine_cores,
 	.send_device_activity = gaudi2_send_device_activity,
 	.set_dram_properties = gaudi2_set_dram_properties,
+	.set_binning_masks = gaudi2_set_binning_masks,
 };
 
 void gaudi2_set_asic_funcs(struct hl_device *hdev)
diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanalabs/goya/goya.c
index ee0c7db16270..2b135e856607 100644
--- a/drivers/accel/habanalabs/goya/goya.c
+++ b/drivers/accel/habanalabs/goya/goya.c
@@ -5425,6 +5425,11 @@ static int goya_set_dram_properties(struct hl_device *hdev)
 	return 0;
 }
 
+static int goya_set_binning_masks(struct hl_device *hdev)
+{
+	return 0;
+}
+
 static int goya_send_device_activity(struct hl_device *hdev, bool open)
 {
 	return 0;
@@ -5524,6 +5529,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.set_dram_bar_base = goya_set_ddr_bar_base,
 	.send_device_activity = goya_send_device_activity,
 	.set_dram_properties = goya_set_dram_properties,
+	.set_binning_masks = goya_set_binning_masks,
 };
 
 /*
-- 
2.25.1

