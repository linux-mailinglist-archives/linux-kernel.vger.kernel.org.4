Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99626472AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiLHPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiLHPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63CAD338
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F14D661F80
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94101C433D6;
        Thu,  8 Dec 2022 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512468;
        bh=Mu/9dkl66q/9zHOO3N55f6Zqs7iCpKF6LOtWcXein+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2HkNy6s5QjxE2i+UKvNQcnPwv6kFyzkuYoIHGFr/Kua9NxLXiuFLSpqHdQRIOqo4
         HEGt+AuJhGNGi8aQ8z0d6a24oUUOcW0sq9qOfH2kLcUQu9saVjFxeJ8O27BkaUAl1A
         IytSdbZ9X+NDPe2nqmgpm2wL2C13OWzqUvC9SNmoRmQ5xpHa0vT7wp2M5p2Y4xHP8f
         CWH7mmeNvxHsQKxBmmJmJb/B60iaLWTFmKnsDttrqSpFGkFZ/4BLxsUcik/o/Qfr91
         v7m4ccq35rbQO6Hq1Gl3VsbQJJwNMUkvq3i7uuUxIF5WUg7csKca2CldSZicW5/jw5
         vMo0sBJvh6ioA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 25/26] habanalabs/gaudi2: wait for preboot ready if HW state is dirty
Date:   Thu,  8 Dec 2022 17:13:49 +0200
Message-Id: <20221208151350.1833823-25-ogabbay@kernel.org>
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

Instead of waiting for BTM indication we should wait for preboot ready.
Consider the below scenario:
    1. FW update is being triggered
           - setting the dirty bit
    2. hard reset will be triggered due to the dirty bit
    3. FW initiates the reset:
           - dirty bit cleared
           - BTM indication cleared
           - preboot ready indication cleared
    4. during hard reset:
           - BTM indication will be set
           - BIST test performed and another reset triggered
    5. only after this reset the preboot will set the preboot ready

When polling on BTM indication alone we can lose sync with FW while
trying to communicate with FW that is during reset.
To overcome this we will always wait to preboot ready indication.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h  |  1 +
 drivers/misc/habanalabs/gaudi2/gaudi2.c      | 26 +++++++++++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 537b1ae3fcb7..cda0bf3dbf1b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1352,7 +1352,7 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	}
 }
 
-static int hl_fw_wait_preboot_ready(struct hl_device *hdev)
+int hl_fw_wait_preboot_ready(struct hl_device *hdev)
 {
 	struct pre_fw_load_props *pre_fw_load = &hdev->fw_loader.pre_fw_load;
 	u32 status;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index de715c91a87e..e5443bf7fe12 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3745,6 +3745,7 @@ int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 void hl_fw_ask_hard_reset_without_linux(struct hl_device *hdev);
 void hl_fw_ask_halt_machine_without_linux(struct hl_device *hdev);
 int hl_fw_init_cpu(struct hl_device *hdev);
+int hl_fw_wait_preboot_ready(struct hl_device *hdev);
 int hl_fw_read_preboot_status(struct hl_device *hdev);
 int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 				struct fw_load_mgr *fw_loader,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index ba3b0ae76ebf..5242b6f6bf95 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -5484,7 +5484,31 @@ static void gaudi2_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_rese
 
 skip_reset:
 	if (driver_performs_reset || hard_reset)
-		gaudi2_poll_btm_indication(hdev, reset_sleep_ms, poll_timeout_us);
+		/*
+		 * Instead of waiting for BTM indication we should wait for preboot ready:
+		 * Consider the below scenario:
+		 * 1. FW update is being triggered
+		 *        - setting the dirty bit
+		 * 2. hard reset will be triggered due to the dirty bit
+		 * 3. FW initiates the reset:
+		 *        - dirty bit cleared
+		 *        - BTM indication cleared
+		 *        - preboot ready indication cleared
+		 * 4. during hard reset:
+		 *        - BTM indication will be set
+		 *        - BIST test performed and another reset triggered
+		 * 5. only after this reset the preboot will set the preboot ready
+		 *
+		 * when polling on BTM indication alone we can lose sync with FW while trying to
+		 * communicate with FW that is during reset.
+		 * to overcome this we will always wait to preboot ready indication
+		 */
+		if ((hdev->fw_components & FW_TYPE_PREBOOT_CPU)) {
+			msleep(reset_sleep_ms);
+			hl_fw_wait_preboot_ready(hdev);
+		} else {
+			gaudi2_poll_btm_indication(hdev, reset_sleep_ms, poll_timeout_us);
+		}
 	else
 		gaudi2_get_soft_rst_done_indication(hdev, poll_timeout_us);
 
-- 
2.25.1

