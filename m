Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77961141D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiJ1OJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiJ1OJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:09:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 495401E046A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:09:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55110113E;
        Fri, 28 Oct 2022 07:09:16 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CAAA3F534;
        Fri, 28 Oct 2022 07:09:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 6/8] firmware: arm_scmi: Fix deferred_tx_wq release on error paths
Date:   Fri, 28 Oct 2022 15:08:31 +0100
Message-Id: <20221028140833.280091-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028140833.280091-1-cristian.marussi@arm.com>
References: <20221028140833.280091-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devres to allocate the dedicated deferred_tx_wq polling workqueue so
as to automatically trigger the proper resource release on error path.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 5a3b7185c47c ("firmware: arm_scmi: Add atomic mode support to virtio transport")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 36b7686843a4..33c9b81a55cd 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -148,7 +148,6 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 {
 	unsigned long flags;
 	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
-	void *deferred_wq = NULL;
 
 	/*
 	 * Prepare to wait for the last release if not already released
@@ -162,16 +161,11 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 
 	vioch->shutdown_done = &vioch_shutdown_done;
 	virtio_break_device(vioch->vqueue->vdev);
-	if (!vioch->is_rx && vioch->deferred_tx_wq) {
-		deferred_wq = vioch->deferred_tx_wq;
+	if (!vioch->is_rx && vioch->deferred_tx_wq)
 		/* Cannot be kicked anymore after this...*/
 		vioch->deferred_tx_wq = NULL;
-	}
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
-	if (deferred_wq)
-		destroy_workqueue(deferred_wq);
-
 	scmi_vio_channel_release(vioch);
 
 	/* Let any possibly concurrent RX path release the channel */
@@ -416,6 +410,11 @@ static bool virtio_chan_available(struct device *dev, int idx)
 	return vioch && !vioch->cinfo;
 }
 
+static void scmi_destroy_tx_workqueue(void *deferred_tx_wq)
+{
+	destroy_workqueue(deferred_tx_wq);
+}
+
 static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			     bool tx)
 {
@@ -430,6 +429,8 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 
 	/* Setup a deferred worker for polling. */
 	if (tx && !vioch->deferred_tx_wq) {
+		int ret;
+
 		vioch->deferred_tx_wq =
 			alloc_workqueue(dev_name(&scmi_vdev->dev),
 					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
@@ -437,6 +438,11 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		if (!vioch->deferred_tx_wq)
 			return -ENOMEM;
 
+		ret = devm_add_action_or_reset(dev, scmi_destroy_tx_workqueue,
+					       vioch->deferred_tx_wq);
+		if (ret)
+			return ret;
+
 		INIT_WORK(&vioch->deferred_tx_work,
 			  scmi_vio_deferred_tx_worker);
 	}
-- 
2.34.1

