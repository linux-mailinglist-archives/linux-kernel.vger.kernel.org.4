Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5060F344
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiJ0JKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiJ0JKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB41FF92
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A402362243
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A54C433C1;
        Thu, 27 Oct 2022 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861819;
        bh=VpRfkhtCImVDOH7LH3f1cCEnxnIxnNzXwZHVtePJVkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtBEdbYsaEkCHFIKvmPIqw1pCTXO75n0J8VNPzct1Q2Sc2EqxH7SDoCzOORdqqylb
         lDM6Lhp4aJkgwZil+JwhL4p7L+z6hhf0ixGwT/1QP1TgspUjBXHlcNoRG5ZFZwfmm+
         dDi2lH56mekF5pd9XyNuOFc5O1H/VQQyRQFSkq/0RgUBf6vswqMsUTvok/KXDN3+Ig
         fu0fMghUtHxvtoRzAonHHYDstBo+h6HpFJLeEAvQi9xYD/0jPjwcdSfKvYCtLquD0B
         XN6tbA0w794qlmGTPO/AEScCMJ2xTSO/1Y4gjjkfBxHtJaFNNYGKEnT+AzrNK5I4yI
         nI3/DmFzpNOQQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 05/15] habanalabs: avoid divide by zero in device utilization
Date:   Thu, 27 Oct 2022 12:09:57 +0300
Message-Id: <20221027091007.664797-5-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

Currently there is no verification whether the divisor is legal.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0e88396744a1..b71303ba11d0 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -987,11 +987,16 @@ static void device_late_fini(struct hl_device *hdev)
 
 int hl_device_utilization(struct hl_device *hdev, u32 *utilization)
 {
-	u64 max_power, curr_power, dc_power, dividend;
+	u64 max_power, curr_power, dc_power, dividend, divisor;
 	int rc;
 
 	max_power = hdev->max_power;
 	dc_power = hdev->asic_prop.dc_power_default;
+	divisor = max_power - dc_power;
+	if (!divisor) {
+		dev_warn(hdev->dev, "device utilization is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	rc = hl_fw_cpucp_power_get(hdev, &curr_power);
 
 	if (rc)
@@ -1000,7 +1005,7 @@ int hl_device_utilization(struct hl_device *hdev, u32 *utilization)
 	curr_power = clamp(curr_power, dc_power, max_power);
 
 	dividend = (curr_power - dc_power) * 100;
-	*utilization = (u32) div_u64(dividend, (max_power - dc_power));
+	*utilization = (u32) div_u64(dividend, divisor);
 
 	return 0;
 }
-- 
2.25.1

