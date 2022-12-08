Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF08064729C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLHPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLHPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A8A13DB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A06EB823DC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107FBC433B5;
        Thu,  8 Dec 2022 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512453;
        bh=Axm7JkrI0AwBWI6qFRE8GtU+YHzlmrVmu4Yn38yTB8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVG+VSq9MaUHgiL3Q1EsrgdsNxt/qpyf4MRjkMPFKGxFU7I+/oIpUJjB9ByTOPsUG
         +cjBX+TdC28FhRxd5/crjyPbinPRuS472/GD3BNVB0Pf69CfEwjETSYrvqdv9WZG1W
         n8ItVQDBW6KPbldP+Cl9MxFkWENwfa4y1s9fXQ4ohV0E3rIO2dlFB7iyZz2jC+qucd
         ZJRSNXAWzXGC4hnHpYz0XoiyjenK/US+Xoks1hAqak1QDmbJdJLsAIl3jx9Q9Kq2MI
         yN8Ps7tjLHxX/hhwAuYSeXxUrEdcOHAxyaGauzKqcW45AeHzrAcl5wB/i/M84ZdkBT
         3w1v0hHHLRGew==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 14/26] habanalabs: skip device idle check in hpriv_release if in reset
Date:   Thu,  8 Dec 2022 17:13:38 +0200
Message-Id: <20221208151350.1833823-14-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

When user context is released and hpriv_release() is called, there is a
device idle status check, to understand if user has left the device not
idle and then a reset is required.

However, if the user process is killed because of device hard reset,
the device at this point would always be not idle, because the device
engines were already forcefully halted.

Modify hpriv_release() to skip the idle check if reset is in progress.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index afd9d4d46574..71f958a2e91b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -428,8 +428,10 @@ static void hpriv_release(struct kref *ref)
 	 */
 	reset_device = hdev->reset_upon_device_release || hdev->reset_info.watchdog_active;
 
-	/* Unless device is reset in any case, check idle status and reset if device is not idle */
-	if (!reset_device && hdev->pdev && !hdev->pldm)
+	/* Check the device idle status and reset if not idle.
+	 * Skip it if already in reset, or if device is going to be reset in any case.
+	 */
+	if (!hdev->reset_info.in_reset && !reset_device && hdev->pdev && !hdev->pldm)
 		device_is_idle = hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 							HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL);
 	if (!device_is_idle) {
-- 
2.25.1

