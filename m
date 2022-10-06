Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E645F6282
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiJFIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiJFIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E783915CD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C5C6B8203D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4926FC433D6;
        Thu,  6 Oct 2022 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044602;
        bh=u+xJMHnlD6MOkaiwKV5Eg3L6VAtZuvoqkbE0tC5A8d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Obb8s3wvyTxa2SHf4rKJpx6LjRP9xCF4qndzCjkoxkMX+hpQGP5ytJoJzF+15BHXR
         46UqyyBJ+9oXZ441aYIJCzJbQOQSgk4DLZtD0ycpn5rF5YfTv6cvjwEPG7eewwYZ9r
         K6KRNAxsyKGcUlf8ywFZ8MaS0Zk8R7YsHLesv9tvezq++XGTv7IwEKBgL/0gT8/V2k
         jk+dybTzemVAq2rAKnlIwetvfAbIpN54dLC8rWmO5MO6dv6XXBrKmof2W0iUAyrnJC
         3rY008d0pBlpqot1ajpYbdFIT8garYd/npl7YQlAWFLSVXoDYmmDAxIQX3CBgKXnsS
         GNq1CM0nTDo/g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/13] habanalabs: skip idle status check if reset on device release
Date:   Thu,  6 Oct 2022 11:23:02 +0300
Message-Id: <20221006082308.1266716-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

If reset upon device release is enabled, there is no need to check the
device idle status in hpriv_release(), because device is going to be
reset in any case.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bf675cf39f71..e60ed0c8a9db 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -398,16 +398,14 @@ static void hpriv_release(struct kref *ref)
 	mutex_destroy(&hpriv->ctx_lock);
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	if ((!hdev->pldm) && (hdev->pdev) &&
-			(!hdev->asic_funcs->is_device_idle(hdev,
-				idle_mask,
-				HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL))) {
-		dev_err(hdev->dev,
-			"device not idle after user context is closed (0x%llx_%llx)\n",
-			idle_mask[1], idle_mask[0]);
+	/* No need for idle status check if device is going to be reset in any case */
+	if (!hdev->reset_upon_device_release && hdev->pdev && !hdev->pldm)
+		device_is_idle = hdev->asic_funcs->is_device_idle(hdev, idle_mask,
+							HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL);
 
-		device_is_idle = false;
-	}
+	if (!device_is_idle)
+		dev_err(hdev->dev, "device not idle after user context is closed (0x%llx_%llx)\n",
+			idle_mask[1], idle_mask[0]);
 
 	/* We need to remove the user from the list to make sure the reset process won't
 	 * try to kill the user process. Because, if we got here, it means there are no
-- 
2.25.1

