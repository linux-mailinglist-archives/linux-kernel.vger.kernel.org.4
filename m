Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0C61141B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJ1OJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJ1OJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:09:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3766B1E0449
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:09:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467DE1063;
        Fri, 28 Oct 2022 07:09:15 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276103F534;
        Fri, 28 Oct 2022 07:09:08 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: [PATCH 5/8] firmware: arm_scmi: Fix devres allocation device in virtio
Date:   Fri, 28 Oct 2022 15:08:30 +0100
Message-Id: <20221028140833.280091-5-cristian.marussi@arm.com>
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

SCMI Virtio transport device managed allocations must use the main
platform device in devres operations instead of the channel devices.

Cc: Peter Hilber <peter.hilber@opensynergy.com>
Fixes: 46abe13b5e3d ("firmware: arm_scmi: Add virtio transport")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Since as of now (v6.1-rc2) cinfo->dev == info->dev in virtio (given
ONLY one channel can exist in virtio transport), this change is sort
of more semantic than real as of now, BUT it will be needed fully soon,
once the per-transport-devices will be adopted (part of an unrelated
series) since in that case cinfo->dev != info->dev for virtio too.

So maybe I can fold this one in the SCMI Raw series carrying transport
devices patch, if you prefer.
---
 drivers/firmware/arm_scmi/virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 14709dbc96a1..36b7686843a4 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -444,12 +444,12 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	for (i = 0; i < vioch->max_msg; i++) {
 		struct scmi_vio_msg *msg;
 
-		msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
+		msg = devm_kzalloc(dev, sizeof(*msg), GFP_KERNEL);
 		if (!msg)
 			return -ENOMEM;
 
 		if (tx) {
-			msg->request = devm_kzalloc(cinfo->dev,
+			msg->request = devm_kzalloc(dev,
 						    VIRTIO_SCMI_MAX_PDU_SIZE,
 						    GFP_KERNEL);
 			if (!msg->request)
@@ -458,7 +458,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			refcount_set(&msg->users, 1);
 		}
 
-		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
+		msg->input = devm_kzalloc(dev, VIRTIO_SCMI_MAX_PDU_SIZE,
 					  GFP_KERNEL);
 		if (!msg->input)
 			return -ENOMEM;
-- 
2.34.1

