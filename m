Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CF6CED27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC2PkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjC2Pj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:39:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62286135
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:39:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7023E1570;
        Wed, 29 Mar 2023 08:40:38 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC0D03F663;
        Wed, 29 Mar 2023 08:39:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, Tushar.Khandelwal@arm.com,
        viresh.kumar@linaro.org, jassisinghbrar@gmail.com
Subject: [PATCH 2/2] mailbox: arm_mhuv2: Add support for multiple rx interrupt
Date:   Wed, 29 Mar 2023 16:39:36 +0100
Message-Id: <20230329153936.394911-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329153936.394911-1-cristian.marussi@arm.com>
References: <20230329153936.394911-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM MHUv2 can be configured to receive multiple interrupt related to the
receiver block, up to the maximum number of available channels, and not
necessarily grouped into a single combined interrupt.

Allow to register more interrupt for the RX block up to the maximum number
of interrupts supported by an AMBA device.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/mailbox/arm_mhuv2.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index c6d4957c4da8..89060bee1fb0 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -163,7 +163,6 @@ enum mhuv2_frame {
  * @send:	Base address of the register mapping region.
  * @recv:	Base address of the register mapping region.
  * @frame:	Frame type: RECEIVER_FRAME or SENDER_FRAME.
- * @irq:	Interrupt.
  * @windows:	Channel windows implemented by the platform.
  * @minor:	Minor version of the controller.
  * @length:	Length of the protocols array in bytes.
@@ -178,7 +177,6 @@ struct mhuv2 {
 		struct mhu2_recv_frame_reg __iomem *recv;
 	};
 	enum mhuv2_frame frame;
-	unsigned int irq;
 	unsigned int windows;
 	unsigned int minor;
 	unsigned int length;
@@ -991,7 +989,6 @@ static int mhuv2_tx_init(struct amba_device *adev, struct mhuv2 *mhu,
 		} else {
 			mhu->mbox.txdone_irq = true;
 			mhu->mbox.txdone_poll = false;
-			mhu->irq = adev->irq[0];
 
 			writel_relaxed_bitfield(1, &mhu->send->int_en, struct int_en_t, chcomb);
 
@@ -1029,18 +1026,23 @@ static int mhuv2_rx_init(struct amba_device *adev, struct mhuv2 *mhu,
 	mhu->windows = readl_relaxed_bitfield(&mhu->recv->mhu_cfg, struct mhu_cfg_t, num_ch);
 	mhu->minor = readl_relaxed_bitfield(&mhu->recv->aidr, struct aidr_t, arch_minor_rev);
 
-	mhu->irq = adev->irq[0];
-	if (!mhu->irq) {
-		dev_err(dev, "Missing receiver IRQ\n");
-		return -EINVAL;
-	}
+	for (i = 0; i < min_t(unsigned int, mhu->windows, AMBA_NR_IRQS); i++) {
+		if (!adev->irq[i]) {
+			/* At least one receiver IRQ is needed */
+			if (i == 0) {
+				dev_err(dev, "Missing receiver IRQ\n");
+				return -EINVAL;
+			}
+			continue;
+		}
 
-	ret = devm_request_threaded_irq(dev, mhu->irq, NULL,
-					mhuv2_receiver_interrupt, IRQF_ONESHOT,
-					"mhuv2-rx", mhu);
-	if (ret) {
-		dev_err(dev, "Failed to request rx IRQ\n");
-		return ret;
+		ret = devm_request_threaded_irq(dev, adev->irq[i], NULL,
+						mhuv2_receiver_interrupt, IRQF_ONESHOT,
+						"mhuv2-rx", mhu);
+		if (ret) {
+			dev_err(dev, "Failed to request rx IRQ\n");
+			return ret;
+		}
 	}
 
 	/* Mask all the channel windows */
-- 
2.34.1

