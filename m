Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AAE6FA0A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjEHHKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjEHHJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:09:57 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262601AEF4;
        Mon,  8 May 2023 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683529781;
  x=1715065781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2V+NUhnYRzHcs/qPV372ooVdqlg/MRqyc6ldidCg9bY=;
  b=DIZct6ncsTbjR4096+pVaYccmSB9epzRem86o3mB2lJTEHhNWiK4dJQL
   r42DLb/tRgRntj/24e/cR8/gP95JuKyzZWW4Y0HmiriAwkjX27iX+IFvd
   WnLe9nCeGrWLuhZbJFN2whTcj3yIDDdK5jQbH7X9cdMIWZcIgG3rpw+aJ
   eyNa2HH00SN9yQ73z6bbnWwRHiy7Ei5asQcpMX1753qbkvbCAaVDKh/JJ
   jU0XV54SdkVo4hH5BfN2bpZYIcXPb/vfIoCeyt/ONx5uETqZSmCcUAEpy
   +FeVA8OUSavXWtz22oEChsrns8yFFNShsGk0sTmcVi9SC4FQg9yAvZsqb
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
Date:   Mon, 8 May 2023 09:09:19 +0200
Message-ID: <20230508070925.2123265-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230508070925.2123265-1-astrid.rost@axis.com>
References: <20230508070925.2123265-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proximity interrupt support for vcnl4200 (similar to vcnl4040).
Add support to configure proximity sensor interrupts and threshold
limits. If an interrupt is detected an event will be pushed to the
event interface.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 56d3963d3d66..13568454baff 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -65,6 +65,7 @@
 #define VCNL4200_PS_DATA	0x08 /* Proximity data */
 #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
 #define VCNL4040_INT_FLAGS	0x0b /* Interrupt register */
+#define VCNL4200_INT_FLAGS	0x0d /* Interrupt register */
 #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
 
 #define VCNL4040_DEV_ID		0x0c /* Device ID and version */
@@ -1004,8 +1005,14 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 	int ret;
+	int reg;
 
-	ret = i2c_smbus_read_word_data(data->client, VCNL4040_INT_FLAGS);
+	if (data->id == VCNL4200)
+		reg = VCNL4200_INT_FLAGS;
+	else
+		reg = VCNL4040_INT_FLAGS;
+
+	ret = i2c_smbus_read_word_data(data->client, reg);
 	if (ret < 0)
 		return IRQ_HANDLED;
 
@@ -1321,9 +1328,10 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.measure_light = vcnl4200_measure_light,
 		.measure_proximity = vcnl4200_measure_proximity,
 		.set_power_state = vcnl4200_set_power_state,
-		.channels = vcnl4000_channels,
+		.channels = vcnl4040_channels,
 		.num_channels = ARRAY_SIZE(vcnl4000_channels),
-		.info = &vcnl4000_info,
+		.info = &vcnl4040_info,
+		.irq_thread = vcnl4040_irq_thread,
 	},
 };
 
-- 
2.30.2

