Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C832974EB91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGKKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGKKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:14:29 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBE59E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=HKlgnykOnFg9SknTx7FMyWuQFrDaMQk/32MCbOChNI4=;
        b=T15BVvnEJBkTOo9yT6EHD9ta9Wgkqo3S8+BzK6EcDV/JPnNhgycTl4lqdw2lFYTTtDrAuKF6TQHiu
         haXXglCr3zTOUH34j/ta0aM4CQGS0AvRaNj9vgqPo7ttHQyF+M7FaiX2YgEKA1way5qcFleAFI1T3c
         nIDRlGf4dymGL5UAJblFfthVsMmyR2MIqNmdLS82g2MbgSf5oZD37bzuz5kHOTE1lmVS2jnbAlEYmJ
         Pj+vhUepqEBcqmvRP7ocfUMLnwGvGXXTNYFFk8xIlWxEtbyj7oXToBZNGB22NNmVB7TpiPIoOySRcg
         GN02bBfmUFYPNFZdlDuv8VB1dcGbsWw==
X-MSG-ID: b56f306b-1fd3-11ee-9499-0050569d11ae
From:   Roan van Dijk <roan@protonic.nl>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v2] iio: chemical: scd4x: Add pressure compensation
Date:   Tue, 11 Jul 2023 12:14:19 +0200
Message-Id: <20230711101419.2065107-1-roan@protonic.nl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pressure compensation to the scd4x driver. The pressure can
be written to the sensor in hPa. The pressure will be compensated
internally by the sensor.

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---

Changes since v2:
 - Fix for kernel test robot errors of uninitialized symbols
 - Changed pressure compensation to output channel instead of a channel
   with calibbias
 - Pressure can now be compensated during measurements

 drivers/iio/chemical/scd4x.c | 79 +++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index a4f22d926400..4bb5d215c54c 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -36,6 +36,8 @@
 #define SCD4X_WRITE_BUF_SIZE 5
 #define SCD4X_FRC_MIN_PPM 0
 #define SCD4X_FRC_MAX_PPM 2000
+#define SCD4X_PRESSURE_COMP_MIN_MBAR 700
+#define SCD4X_PRESSURE_COMP_MAX_MBAR 1200
 #define SCD4X_READY_MASK 0x01
 
 /*Commands SCD4X*/
@@ -45,6 +47,8 @@ enum scd4x_cmd {
 	CMD_STOP_MEAS           = 0x3f86,
 	CMD_SET_TEMP_OFFSET     = 0x241d,
 	CMD_GET_TEMP_OFFSET     = 0x2318,
+	CMD_SET_AMB_PRESSURE	= 0xe000,
+	CMD_GET_AMB_PRESSURE	= 0xe000,
 	CMD_FRC                 = 0x362f,
 	CMD_SET_ASC             = 0x2416,
 	CMD_GET_ASC             = 0x2313,
@@ -137,7 +141,8 @@ static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
 	 * Measurement needs to be stopped before sending commands.
 	 * Except for reading measurement and data ready command.
 	 */
-	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
+	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS) &&
+			(cmd != CMD_GET_AMB_PRESSURE)) {
 		ret = scd4x_send_command(state, CMD_STOP_MEAS);
 		if (ret)
 			return ret;
@@ -166,7 +171,8 @@ static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
 	}
 
 	/* start measurement */
-	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
+	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS) &&
+			(cmd != CMD_GET_AMB_PRESSURE)) {
 		ret = scd4x_send_command(state, CMD_START_MEAS);
 		if (ret)
 			return ret;
@@ -188,9 +194,11 @@ static int scd4x_write(struct scd4x_state *state, enum scd4x_cmd cmd, uint16_t a
 	buf[4] = crc;
 
 	/* measurement needs to be stopped before sending commands */
-	ret = scd4x_send_command(state, CMD_STOP_MEAS);
-	if (ret)
-		return ret;
+	if (cmd != CMD_SET_AMB_PRESSURE) {
+		ret = scd4x_send_command(state, CMD_STOP_MEAS);
+		if (ret)
+			return ret;
+	}
 
 	/* execution time */
 	msleep_interruptible(500);
@@ -200,7 +208,7 @@ static int scd4x_write(struct scd4x_state *state, enum scd4x_cmd cmd, uint16_t a
 		return ret;
 
 	/* start measurement, except for forced calibration command */
-	if (cmd != CMD_FRC) {
+	if ((cmd != CMD_FRC) && (cmd != CMD_SET_AMB_PRESSURE)) {
 		ret = scd4x_send_command(state, CMD_START_MEAS);
 		if (ret)
 			return ret;
@@ -338,6 +346,18 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (chan->output) {
+			mutex_lock(&state->lock);
+			ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
+			mutex_unlock(&state->lock);
+
+			if (ret)
+				return ret;
+
+			*val = be16_to_cpu(tmp);
+			return IIO_VAL_INT;
+		}
+
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
@@ -386,6 +406,25 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const int scd4x_pressure_calibbias_available[] = {
+	SCD4X_PRESSURE_COMP_MIN_MBAR, 1, SCD4X_PRESSURE_COMP_MAX_MBAR,
+};
+
+static int scd4x_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    const int **vals, int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = scd4x_pressure_calibbias_available;
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_RANGE;
+	}
+
+	return -EINVAL;
+}
+
+
 static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
@@ -399,6 +438,21 @@ static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 		mutex_unlock(&state->lock);
 
 		return ret;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			if (val < SCD4X_PRESSURE_COMP_MIN_MBAR ||
+			    val > SCD4X_PRESSURE_COMP_MAX_MBAR)
+				return -EINVAL;
+
+			mutex_lock(&state->lock);
+			ret = scd4x_write(state, CMD_SET_AMB_PRESSURE, val);
+			mutex_unlock(&state->lock);
+
+			return ret;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -503,9 +557,22 @@ static const struct iio_info scd4x_info = {
 	.attrs = &scd4x_attr_group,
 	.read_raw = scd4x_read_raw,
 	.write_raw = scd4x_write_raw,
+	.read_avail = scd4x_read_avail,
 };
 
 static const struct iio_chan_spec scd4x_channels[] = {
+	{
+		/*
+		 * this channel is special in a sense we are pretending that
+		 * sensor is able to change measurement chamber pressure but in
+		 * fact we're just setting pressure compensation value
+		 */
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+		.output = 1,
+		.scan_index = -1,
+	},
 	{
 		.type = IIO_CONCENTRATION,
 		.channel2 = IIO_MOD_CO2,
-- 
2.39.2

