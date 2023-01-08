Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39F866174F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjAHRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjAHRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA128BF79
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77685B80AC0
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4463EC433F0;
        Sun,  8 Jan 2023 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198454;
        bh=vqssQjg/rR9BvJsOnxSjY5Rls0IAFtCEfpWOFryRbf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdZP04+adN+vQMxV1n3nrrdEsjxBHzgiyIjQgx4h92ySv9kgxSF38u+SjEvayw5hF
         GwTI8g5g7nhAHkYshcsP7GsZvrGntJEOn9nlpStv3jnMx06H3ymeuNLovepG2mJopg
         ow7o+uz6Jbzg7K/iXiqnjk22IASRALKKb/QT6jLKTEKrob7MPLizh9gAxG7C1yE8SF
         DTp5HZs0xqOkete078AaU3C9wtTBvQaZ36y2Fi0glP1e7X+avK6VZi5P3USTtO8Hc+
         s6VnTp/YaVruX74f/UNNwnF6yRLZUXgn39KjvgHNYrOs7ZAef3gCz/BnqqulhKoV5j
         xNOsaqD3It3fA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 7/7] habanalabs: extend fatal messages to contain PCI info
Date:   Sun,  8 Jan 2023 19:20:40 +0200
Message-Id: <20230108172040.3991204-7-ogabbay@kernel.org>
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

From: Moti Haimovski <mhaimovski@habana.ai>

This commit attaches the PCI device address to driver fatal messages
in order to ease debugging in multi-device setups.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 38 ++++++++++++++++--------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 722a5beb0974..2b6971463f12 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1563,7 +1563,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		if (rc == -EBUSY) {
 			if (hdev->device_fini_pending) {
 				dev_crit(hdev->dev,
-					"Failed to kill all open processes, stopping hard reset\n");
+					"%s Failed to kill all open processes, stopping hard reset\n",
+					dev_name(&(hdev)->pdev->dev));
 				goto out_err;
 			}
 
@@ -1573,7 +1574,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		if (rc) {
 			dev_crit(hdev->dev,
-				"Failed to kill all open processes, stopping hard reset\n");
+				"%s Failed to kill all open processes, stopping hard reset\n",
+				dev_name(&(hdev)->pdev->dev));
 			goto out_err;
 		}
 
@@ -1624,14 +1626,16 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 			 * ensure driver puts the driver in a unusable state
 			 */
 			dev_crit(hdev->dev,
-				"Consecutive FW fatal errors received, stopping hard reset\n");
+				"%s Consecutive FW fatal errors received, stopping hard reset\n",
+				dev_name(&(hdev)->pdev->dev));
 			rc = -EIO;
 			goto out_err;
 		}
 
 		if (hdev->kernel_ctx) {
 			dev_crit(hdev->dev,
-				"kernel ctx was alive during hard reset, something is terribly wrong\n");
+				"%s kernel ctx was alive during hard reset, something is terribly wrong\n",
+				dev_name(&(hdev)->pdev->dev));
 			rc = -EBUSY;
 			goto out_err;
 		}
@@ -1749,9 +1753,13 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hdev->reset_info.needs_reset = false;
 
 	if (hard_reset)
-		dev_info(hdev->dev, "Successfully finished resetting the device\n");
+		dev_info(hdev->dev,
+			 "Successfully finished resetting the %s device\n",
+			 dev_name(&(hdev)->pdev->dev));
 	else
-		dev_dbg(hdev->dev, "Successfully finished resetting the device\n");
+		dev_dbg(hdev->dev,
+			"Successfully finished resetting the %s device\n",
+			dev_name(&(hdev)->pdev->dev));
 
 	if (hard_reset) {
 		hdev->reset_info.hard_reset_cnt++;
@@ -1786,7 +1794,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hdev->reset_info.in_compute_reset = 0;
 
 	if (hard_reset) {
-		dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
+		dev_err(hdev->dev,
+			"%s Failed to reset! Device is NOT usable\n",
+			dev_name(&(hdev)->pdev->dev));
 		hdev->reset_info.hard_reset_cnt++;
 	} else if (reset_upon_device_release) {
 		spin_unlock(&hdev->reset_info.lock);
@@ -2185,7 +2195,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	}
 
 	dev_notice(hdev->dev,
-		"Successfully added device to habanalabs driver\n");
+		"Successfully added device %s to habanalabs driver\n",
+		dev_name(&(hdev)->pdev->dev));
 
 	hdev->init_done = true;
 
@@ -2234,11 +2245,11 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		device_cdev_sysfs_add(hdev);
 	if (hdev->pdev)
 		dev_err(&hdev->pdev->dev,
-			"Failed to initialize hl%d. Device is NOT usable !\n",
-			hdev->cdev_idx);
+			"Failed to initialize hl%d. Device %s is NOT usable !\n",
+			hdev->cdev_idx, dev_name(&(hdev)->pdev->dev));
 	else
-		pr_err("Failed to initialize hl%d. Device is NOT usable !\n",
-			hdev->cdev_idx);
+		pr_err("Failed to initialize hl%d. Device %s is NOT usable !\n",
+			hdev->cdev_idx, dev_name(&(hdev)->pdev->dev));
 
 	return rc;
 }
@@ -2294,7 +2305,8 @@ void hl_device_fini(struct hl_device *hdev)
 
 		if (ktime_compare(ktime_get(), timeout) > 0) {
 			dev_crit(hdev->dev,
-				"Failed to remove device because reset function did not finish\n");
+				"%s Failed to remove device because reset function did not finish\n",
+				dev_name(&(hdev)->pdev->dev));
 			return;
 		}
 	}
-- 
2.25.1

