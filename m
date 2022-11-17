Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE662E187
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiKQQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbiKQQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C197C01D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3409B82105
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A714AC433C1;
        Thu, 17 Nov 2022 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702022;
        bh=JDHtdW/pxUL6/mqDWx53BUt82+lAEInA9L1ewsxB9Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twV7rplvfG3X7ZI34DGD8FW7G6nXFmu0BDi1rd3jJO0fpnqbuAsL8A6QXy43r8v6q
         IC4zVdJY8/Fc5MaeL1l51+519cYcEXP8uKjW5g6tHrPqanXrtC1oH9xl/ZE7LOgPSN
         7qZ1Pu9mWXc4Ct2mHfQaX8ioGmPql5dwcP0/adg9F9Q3/lnP8J0S45VR2kUILNFUcT
         AANfYwogpwgtRekJjWBzK51T16Ri8Eas6HUDX6ugZKrmkUx45xktAuvmZr4TGP0zrM
         bHz3kZ3Qi0FClLXbhiptvOZp3CD8RiXyfGanWWwNK/tdU/lvaO9rq2UGxNJURfEf3n
         fCjCf7oFtw02g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 20/20] habanalabs: increase the size of busy engines mask
Date:   Thu, 17 Nov 2022 18:19:51 +0200
Message-Id: <20221117161951.845454-20-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

Increase the size of the busy engines mask in 'struct hl_info_hw_idle',
for future ASICs with more than 128 engines.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 9 +++++----
 include/uapi/misc/habanalabs.h          | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 63d0cb7087e8..f5864893237c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -416,8 +416,9 @@ static void hpriv_release(struct kref *ref)
 		device_is_idle = hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 							HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL);
 	if (!device_is_idle) {
-		dev_err(hdev->dev, "device not idle after user context is closed (0x%llx_%llx)\n",
-			idle_mask[1], idle_mask[0]);
+		dev_err(hdev->dev,
+			"device not idle after user context is closed (0x%llx_%llx_%llx_%llx)\n",
+			idle_mask[3], idle_mask[2], idle_mask[1], idle_mask[0]);
 		reset_device = true;
 	}
 
@@ -1661,8 +1662,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	/* If device is not idle fail the reset process */
 	if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 			HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
-		dev_err(hdev->dev, "device is not idle (mask 0x%llx_%llx) after reset\n",
-			idle_mask[1], idle_mask[0]);
+		dev_err(hdev->dev, "device is not idle (mask 0x%llx_%llx_%llx_%llx) after reset\n",
+			idle_mask[3], idle_mask[2], idle_mask[1], idle_mask[0]);
 		rc = -EIO;
 		goto out_err;
 	}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index e50cb71df081..3b995e841eb8 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -916,7 +916,7 @@ struct hl_info_dram_usage {
 	__u64 ctx_dram_mem;
 };
 
-#define HL_BUSY_ENGINES_MASK_EXT_SIZE	2
+#define HL_BUSY_ENGINES_MASK_EXT_SIZE	4
 
 struct hl_info_hw_idle {
 	__u32 is_idle;
-- 
2.25.1

