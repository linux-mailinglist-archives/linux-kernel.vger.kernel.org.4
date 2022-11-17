Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4062E180
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiKQQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbiKQQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31130786F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE836621A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE76C433C1;
        Thu, 17 Nov 2022 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702017;
        bh=hxwBfzDVRHpZPJp/0PFGkD/rqrFUwxmnq4wJ7+7pWNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4M86P8J4Ph5qvZ/aI0wbH+YrK+DCRtCA6l8OHe3PyT8m7n66FZQ8R+2w663rOpE6
         Tx304iQj55me/VwRXIM3ssBZUExhx12KNtKHkpag2usF4WddBIWHtWnDjYeknaEjdA
         MsjsJAJWYgp/fNsRftsn1DYv4aCUdPsaOGFasIqP8YmN5fMNalrV9SsRU1f+93/pOV
         kZUQixn1QVk0G4oVIq9BOlSrXIhJ0muyx01WCD81A3FPv+4Ed5D50jDOXaj+mBUV3k
         P7pMq4XzWBHYYVHGbddLuhUZDwgpvmRiAAUuGS4RRR/yeBf+ezvcK97RE6rTLAuKdW
         Ll6/76AtPLoPQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 16/20] habanalabs: reset device if still in use when released
Date:   Thu, 17 Nov 2022 18:19:47 +0200
Message-Id: <20221117161951.845454-16-ogabbay@kernel.org>
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

If the device file is released while a context is still held, it won't
be possible to reopen it until the context is eventually released.
If that doesn't happen, only a device reset will revert it back to an
operational state, i.e. need to wait for a CS timeout or an error, or to
wait for an external intervention of injecting a reset via sysfs.

At this stage, after the device was released by user, context is held
either because of CS which were left running on the device and are not
relevant anymore, or due to missing cleanup steps from user side.

All of this is in any case handled in the device reset flow, so initiate
the reset at this point instead of waiting for it.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 708db0f48ee0..49640c8ca910 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -504,9 +504,10 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 
 	hdev->compute_ctx_in_release = 1;
 
-	if (!hl_hpriv_put(hpriv))
-		dev_notice(hdev->dev,
-			"User process closed FD but device still in use\n");
+	if (!hl_hpriv_put(hpriv)) {
+		dev_notice(hdev->dev, "User process closed FD but device still in use\n");
+		hl_device_reset(hdev, HL_DRV_RESET_HARD);
+	}
 
 	hdev->last_open_session_duration_jif =
 		jiffies - hdev->last_successful_open_jif;
-- 
2.25.1

