Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45806657FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiL1QIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiL1QHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCAD17E04
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA5961560
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A926C433F2;
        Wed, 28 Dec 2022 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243661;
        bh=suc0ENB/vq+OUx6TpaXodOxorZdG/jjYJG0OLpCZjQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFF1gcuPO66zuctJWPYqtj6D3AJXbIX3hyRQY9VkWBw+46Fm7kQj9fWzvciDDiK8L
         W6YfUhML3nmnPPEuILVrqOiwUKzaT7qZZOWvqJvwJT2cudHTlTdKrHjJXrE7cloM8T
         9tlLSh6uw3GqC8gv7BViGnK7zLpiMDvaW1DCoAgo7vnTC95/tspv5wTcwC9eFNgLBr
         +q5H+e8bhfmqYq1OlUu7bUXD5PUT91iX/6gpZ9jGY1Slkl1TdEI4B5A0KFHzIbL8vR
         OOXzPocH/PkesTp6d7qXU+7iY3i6uH0b29FWW0isjK6PQutXejK/h4FYVl+TQQHmpI
         Eis50qTYsOjHw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 7/9] habanalabs/gaudi: allow device acquire while in debug mode
Date:   Wed, 28 Dec 2022 18:07:21 +0200
Message-Id: <20221228160723.387-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228160723.387-1-ogabbay@kernel.org>
References: <20221228160723.387-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

During device acquire, the driver is using a QMAN for clearing some
registers. In order to avoid internal races, the driver verifies
the device is idle before submitting the register clear job.

This check introduces an issue, as debug mode will cause the device
to be non-idle which will lead to device acquire failure.

In order to overcome this issue we can entirely remove the idle
check as the driver is using the QMAN only when there is no active
context.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi/gaudi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index 13f9e6c0cd90..733916f38752 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -6434,12 +6434,6 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 	else
 		timeout = HL_DEVICE_TIMEOUT_USEC;
 
-	if (!hdev->asic_funcs->is_device_idle(hdev, NULL, 0, NULL)) {
-		dev_err_ratelimited(hdev->dev,
-			"Can't send driver job on QMAN0 because the device is not idle\n");
-		return -EBUSY;
-	}
-
 	fence_ptr = hl_asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL, &fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
-- 
2.34.1

