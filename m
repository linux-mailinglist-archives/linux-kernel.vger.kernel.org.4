Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809BC64729A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLHPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLHPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E947B565
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 805DEB82362
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A88FC433D6;
        Thu,  8 Dec 2022 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512445;
        bh=EdMaeOizcuVWEAj740RUMsc9QgZkcxvrbrIB5v7n/Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6SoIfk6mQFBlPX+luIjx3jHsXhqDmks/UsYtoRZd/HdKWDDYdEc6ft8R+3aFYckw
         qwB/iiQhHiqLVR9znif49XBArz6oNln+F/Wa1XlTH0WAANmWCNC5zJiRtrCrzotfE7
         uBzlyHIlL1y00cDUmcqbnSfCo+oj48jyHVif2PDXvchMDsfaSWiE2Jnm/wEUwxSS+F
         hPKiicdaP92qL6n4knvA4IapQXr78p+oI23RM5RHM8EhRQcPYBQChgEGgaIwIvlCll
         75fWc9sw0irX5YkLSlz0/Qvl+qL3kR3F1SUYGRM+43OMprSZeiTK2aWGZVQOs7xO3c
         7E5owuZGya8eg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 08/26] habanalabs: make set_dram_properties an ASIC function
Date:   Thu,  8 Dec 2022 17:13:32 +0200
Message-Id: <20221208151350.1833823-8-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

As ASICs are evolving, we will need to update the DRAM properties at
various points because we may get different information from the f/w
at different points of the initialization.

This ASIC function is a foundation for this capability.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 1 +
 drivers/misc/habanalabs/gaudi/gaudi.c       | 6 ++++++
 drivers/misc/habanalabs/gaudi2/gaudi2.c     | 3 ++-
 drivers/misc/habanalabs/goya/goya.c         | 6 ++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ecf7e5da8f1d..893ebcba170b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1683,6 +1683,7 @@ struct hl_asic_funcs {
 	int (*set_engine_cores)(struct hl_device *hdev, u32 *core_ids,
 					u32 num_cores, u32 core_command);
 	int (*send_device_activity)(struct hl_device *hdev, bool open);
+	int (*set_dram_properties)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae78f838f987..1b701a87c6fe 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9134,6 +9134,11 @@ static u32 *gaudi_get_stream_master_qid_arr(void)
 	return gaudi_stream_master;
 }
 
+static int gaudi_set_dram_properties(struct hl_device *hdev)
+{
+	return 0;
+}
+
 static void gaudi_check_if_razwi_happened(struct hl_device *hdev)
 {
 }
@@ -9260,6 +9265,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi_set_hbm_bar_base,
 	.send_device_activity = gaudi_send_device_activity,
+	.set_dram_properties = gaudi_set_dram_properties,
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index c14b3bb16f96..10c017b8ddfa 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2485,7 +2485,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 	 * at this point the DRAM parameters need to be updated according to data obtained
 	 * from the FW
 	 */
-	rc = gaudi2_set_dram_properties(hdev);
+	rc = hdev->asic_funcs->set_dram_properties(hdev);
 	if (rc)
 		return rc;
 
@@ -10467,6 +10467,7 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.set_dram_bar_base = gaudi2_set_hbm_bar_base,
 	.set_engine_cores = gaudi2_set_engine_cores,
 	.send_device_activity = gaudi2_send_device_activity,
+	.set_dram_properties = gaudi2_set_dram_properties,
 };
 
 void gaudi2_set_asic_funcs(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0f083fcf81a6..ee0c7db16270 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5420,6 +5420,11 @@ static int goya_scrub_device_dram(struct hl_device *hdev, u64 val)
 	return -EOPNOTSUPP;
 }
 
+static int goya_set_dram_properties(struct hl_device *hdev)
+{
+	return 0;
+}
+
 static int goya_send_device_activity(struct hl_device *hdev, bool open)
 {
 	return 0;
@@ -5518,6 +5523,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
 	.send_device_activity = goya_send_device_activity,
+	.set_dram_properties = goya_set_dram_properties,
 };
 
 /*
-- 
2.25.1

