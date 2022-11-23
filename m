Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1858863628F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiKWO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiKWO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590E5FA9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8FD8B8206C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06CFC433D6;
        Wed, 23 Nov 2022 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215489;
        bh=0kGd4u1zhabaucfl7C3QkCQrJfpFWk2tRyn/vCN7FXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZl11+mlBdZ5dduflYDzaF3SmpJ4sXaqgKyazDzSQ6sGgo0diZKiBWPiJcP/X6g9N
         V5rjbx8wvEK4ABlqxu8vgGs/L66w58H4oRIJaLoLUTp2AC9kp8Y1IEyJDexjjJEp0u
         PmdyuTGInkeGG+0v7DrHk0SnVbo+E0HOrRYf/K62pcHvwO8ix7f7Nm5w8w0YnnyQ42
         JdIGCD86JWv1zX+6hFWlzmGyjXwoATHj9FAc6KhkTpov/ts+tRQPCSZNvBh2GzxWiW
         DvUhX630sHgR55dczDijvbi63XQpSb6nzC1g+SYX+GAf3+l1mSsY1zW6Q3brirU8hd
         BpkVRwmD6ON3A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/8] habanalabs: print context refcount value if hard reset fails
Date:   Wed, 23 Nov 2022 16:57:56 +0200
Message-Id: <20221123145801.542029-3-ogabbay@kernel.org>
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

Failing to kill a user process during a hard reset can be due to a
reference to the user context which isn't released.
To make it easier to understand if this the reason for the failure and
not something else, add a print of the context refcount value.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index f5864893237c..926f230def56 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -696,10 +696,22 @@ static void device_hard_reset_pending(struct work_struct *work)
 	flags = device_reset_work->flags | HL_DRV_RESET_FROM_RESET_THR;
 
 	rc = hl_device_reset(hdev, flags);
+
 	if ((rc == -EBUSY) && !hdev->device_fini_pending) {
-		dev_info(hdev->dev,
-			"Could not reset device. will try again in %u seconds",
-			HL_PENDING_RESET_PER_SEC);
+		struct hl_ctx *ctx = hl_get_compute_ctx(hdev);
+
+		if (ctx) {
+			/* The read refcount value should subtracted by one, because the read is
+			 * protected with hl_get_compute_ctx().
+			 */
+			dev_info(hdev->dev,
+				"Could not reset device (compute_ctx refcount %u). will try again in %u seconds",
+				kref_read(&ctx->refcount) - 1, HL_PENDING_RESET_PER_SEC);
+			hl_ctx_put(ctx);
+		} else {
+			dev_info(hdev->dev, "Could not reset device. will try again in %u seconds",
+				HL_PENDING_RESET_PER_SEC);
+		}
 
 		queue_delayed_work(hdev->reset_wq, &device_reset_work->reset_work,
 					msecs_to_jiffies(HL_PENDING_RESET_PER_SEC * 1000));
-- 
2.25.1

