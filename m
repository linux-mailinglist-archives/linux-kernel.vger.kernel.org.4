Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E0636291
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiKWO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiKWO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E0E0BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC0CB61D58
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822AAC4347C;
        Wed, 23 Nov 2022 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215493;
        bh=pYSt7jQ9btgaRriP6YpWfQx9rfOfcdkzZZBxDT0fl+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKdmQ11uqU2SqpICA9u0lRjJzJXyWhE/6aZjOIsn6cn2BM4eky/a56pN5+b8pjgr/
         7pwCUa3CzvDxh3NwvPsW6NAQp83LSsQUUUadXXv9CJB8o91EABjVOdfWYvsBGAYFeD
         UzbifdkylVk5upfIY3iBEZOZ6+P5iN+qekqwbAYhtkT9zq2+yVtjObtO4QpYWHO1CB
         QWHqh0QZyD6jmxkfRhgQ6JhC6PBvgiNQIESPp+QdSNI0OdAECu8Mf4QqykTd8+Uawo
         kymOSPvk/WZUt7ZAM7nREP3mkjky0cFHFy8x62Bemsq5z3Tm/O1Yx5Kpu+1GeODO7j
         E4kPdEDcUugNg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 6/8] habanalabs: make print of engines idle mask more readable
Date:   Wed, 23 Nov 2022 16:57:59 +0200
Message-Id: <20221123145801.542029-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123145801.542029-1-ogabbay@kernel.org>
References: <20221123145801.542029-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

The engines idle mask was increased to be an array of 4 u64 entries.
To make the print of this mask more readable, remove the "0x" prefix,
and zero-pad each u64 to 16 bytes if either it isn't zero or if any of
the higher-order u64's is not zero.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 27 +++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 926f230def56..87ab329e65d4 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -386,6 +386,23 @@ bool hl_ctrl_device_operational(struct hl_device *hdev,
 	}
 }
 
+static void print_idle_status_mask(struct hl_device *hdev, const char *message,
+					u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE])
+{
+	u32 pad_width[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {};
+
+	BUILD_BUG_ON(HL_BUSY_ENGINES_MASK_EXT_SIZE != 4);
+
+	pad_width[3] = idle_mask[3] ? 16 : 0;
+	pad_width[2] = idle_mask[2] || pad_width[3] ? 16 : 0;
+	pad_width[1] = idle_mask[1] || pad_width[2] ? 16 : 0;
+	pad_width[0] = idle_mask[0] || pad_width[1] ? 16 : 0;
+
+	dev_err(hdev->dev, "%s (mask %0*llx_%0*llx_%0*llx_%0*llx)\n",
+		message, pad_width[3], idle_mask[3], pad_width[2], idle_mask[2],
+		pad_width[1], idle_mask[1], pad_width[0], idle_mask[0]);
+}
+
 static void hpriv_release(struct kref *ref)
 {
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
@@ -416,9 +433,8 @@ static void hpriv_release(struct kref *ref)
 		device_is_idle = hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 							HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL);
 	if (!device_is_idle) {
-		dev_err(hdev->dev,
-			"device not idle after user context is closed (0x%llx_%llx_%llx_%llx)\n",
-			idle_mask[3], idle_mask[2], idle_mask[1], idle_mask[0]);
+		print_idle_status_mask(hdev, "device is not idle after user context is closed",
+					idle_mask);
 		reset_device = true;
 	}
 
@@ -1673,9 +1689,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 	/* If device is not idle fail the reset process */
 	if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
-			HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
-		dev_err(hdev->dev, "device is not idle (mask 0x%llx_%llx_%llx_%llx) after reset\n",
-			idle_mask[3], idle_mask[2], idle_mask[1], idle_mask[0]);
+						HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
+		print_idle_status_mask(hdev, "device is not idle after reset", idle_mask);
 		rc = -EIO;
 		goto out_err;
 	}
-- 
2.25.1

