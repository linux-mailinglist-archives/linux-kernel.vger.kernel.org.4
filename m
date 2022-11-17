Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB762E184
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiKQQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbiKQQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F37AF6E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4292B82105
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD002C43470;
        Thu, 17 Nov 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702018;
        bh=wbYG2vjUDd05FiCs7SNIga4vIYg+NlzDLIU18TLiheo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAksOiwmV1nsYl8BjIaf3XghN+QaPyDKhDTYYNwoT16rZg/Uz7AI7vlSJB7fntqmw
         pjrS5wTXFQyg87jRvNqya7jDhXSQ391dAg+QfOxisfo186gnnahhoyOP6MKZ3Ceg4D
         gzI2XpCihBG0kaYp7sdFX3T/Iek60GGwwbCOJdqbqFS/GA/HI2RPcn9222Q6FlAntZ
         7MawTbJeWZU2Rxc+oGgK9OLu/PY1iPaAWOw60GD1b42FQWpvhldrKaPvJ84mqepCJq
         d54XEuLb7VrYSw5aMF8ykMuLA0SK0Yr3ene2cTeoANH9m+TP68Hc5nrXfnRdIF73E5
         VxogtvMX4wRUA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 17/20] habanalabs: check schedule_hard_reset correctly
Date:   Thu, 17 Nov 2022 18:19:48 +0200
Message-Id: <20221117161951.845454-17-ogabbay@kernel.org>
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

schedule_hard_reset can be true only if we didn't do hard-reset.
Therefore, no point of checking it in case hard_reset is true.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/common/device.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 49640c8ca910..0650e511a0f5 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1737,18 +1737,19 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		 * the device will be operational although it shouldn't be
 		 */
 		hdev->asic_funcs->enable_events_from_fw(hdev);
-	} else if (!reset_upon_device_release) {
-		hdev->reset_info.compute_reset_cnt++;
-	}
-
-	if (schedule_hard_reset) {
-		dev_info(hdev->dev, "Performing hard reset scheduled during compute reset\n");
-		flags = hdev->reset_info.hard_reset_schedule_flags;
-		hdev->reset_info.hard_reset_schedule_flags = 0;
-		hdev->disabled = true;
-		hard_reset = true;
-		handle_reset_trigger(hdev, flags);
-		goto again;
+	} else {
+		if (!reset_upon_device_release)
+			hdev->reset_info.compute_reset_cnt++;
+
+		if (schedule_hard_reset) {
+			dev_info(hdev->dev, "Performing hard reset scheduled during compute reset\n");
+			flags = hdev->reset_info.hard_reset_schedule_flags;
+			hdev->reset_info.hard_reset_schedule_flags = 0;
+			hdev->disabled = true;
+			hard_reset = true;
+			handle_reset_trigger(hdev, flags);
+			goto again;
+		}
 	}
 
 	return 0;
-- 
2.25.1

