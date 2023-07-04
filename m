Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39261746CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGDJEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:04:31 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 02:04:26 PDT
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E7A1A2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=ycfj2BCIyCgA8eLgIbquApDUyZU7DdA5ZV0cKZoxzg0=;
        b=SCuyFuvkuMBhO+TsaInCcf3f8BWugJAbXBCkSCbogZNtcMkJSn4pF/QKd2BDtaMweV2a0Hm/f6zpz
         f4AOoUnIlzhegCeadUgS33N+eC5KwhCcXTPvdouvnlQkVIT0AuoKBh7gQwr8eb0CdrJ4L8+XffO/D8
         srJXxvfvam2XMX4fvJc/dDDqiaWQXAItEQSPuPx1kAHC3935asTr4wC4OyIwd5CyPHrr5sa+44/rSp
         UfjxmnfxkH+6iJ21SG5SzahvwvodFb+PFagxPUvJC1/bK23UibSJ5LZMhlne4NgMXQFbVECJ3qrzXZ
         /h6HT0xXVYA2/xjwMH6THK4AMmirlYw==
X-MSG-ID: 86e0501c-1a47-11ee-a4fd-0050569d3a82
From:   Roan van Dijk <roan@protonic.nl>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, roan@protonic.nl
Subject: [PATCH] iio: chemical: scd4x: Add pressure compensation
Date:   Tue,  4 Jul 2023 10:47:06 +0200
Message-Id: <20230704084706.370637-1-roan@protonic.nl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/iio/chemical/scd4x.c | 41 +++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index a4f22d926400..fe6b3f3f7186 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -36,6 +36,8 @@
 #define SCD4X_WRITE_BUF_SIZE 5
 #define SCD4X_FRC_MIN_PPM 0
 #define SCD4X_FRC_MAX_PPM 2000
+#define SCD4X_AMB_PRESSURE_MIN 700
+#define SCD4X_AMB_PRESSURE_MAX 1200
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
@@ -373,7 +377,10 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&state->lock);
-		ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
+		if (chan->type == IIO_TEMP)
+			ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
+		else if (chan->type == IIO_PRESSURE)
+			ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
 		mutex_unlock(&state->lock);
 		if (ret)
 			return ret;
@@ -386,6 +393,25 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const int scd4x_pressure_calibbias_available[] = {
+	SCD4X_AMB_PRESSURE_MIN, 1, SCD4X_AMB_PRESSURE_MAX,
+};
+
+static int scd4x_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    const int **vals, int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
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
@@ -395,9 +421,11 @@ static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&state->lock);
-		ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
+		if (chan->type == IIO_TEMP)
+			ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
+		else if (chan->type == IIO_PRESSURE)
+			ret = scd4x_write(state, CMD_SET_AMB_PRESSURE, val);
 		mutex_unlock(&state->lock);
-
 		return ret;
 	default:
 		return -EINVAL;
@@ -503,9 +531,16 @@ static const struct iio_info scd4x_info = {
 	.attrs = &scd4x_attr_group,
 	.read_raw = scd4x_read_raw,
 	.write_raw = scd4x_write_raw,
+	.read_avail = scd4x_read_avail,
 };
 
 static const struct iio_chan_spec scd4x_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.scan_index = -1,
+	},
 	{
 		.type = IIO_CONCENTRATION,
 		.channel2 = IIO_MOD_CO2,
-- 
2.39.2

