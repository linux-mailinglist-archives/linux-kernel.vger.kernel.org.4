Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97F6FC86A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjEIOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEIOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:02:09 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CDA30E8;
        Tue,  9 May 2023 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683640919;
  x=1715176919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2V+NUhnYRzHcs/qPV372ooVdqlg/MRqyc6ldidCg9bY=;
  b=cnx4hZNk3RLw+BNyLhSOE8tqUSVh/j/WkCDZdqZjsxr3rmbCGd+cXg4W
   iDvgZFZJX5K8bIAFniiwUX9Tf+bQhLpMgHVZxB+DAzCGi41tntoFgWtrc
   KH23HCEF3pIJRNoEHNk7uTrwpCKxYuwx3zE0QfeL3yq5n9/VMp62nYL5q
   hABKss+YF2eXu3NXfy4i37MlHx/NU7ul3j3ZNrM6K6H6FDZ7JxCoHBfvW
   YzfUOT6R87I67L2glh5DWMh/hfYFuZUdbRU8qHUuIeXL97+hcYbMLq8xu
   y0NJ7lUJytIi3Sx9l0vQrn+3VGuPz4CO91QqARa+4CT8w05PlHkEhVCef
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
Date:   Tue, 9 May 2023 16:01:47 +0200
Message-ID: <20230509140153.3279288-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509140153.3279288-1-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

