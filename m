Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44156DCEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDKBNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:13:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C530DA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:12:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso4531707pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681175575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7+gSuuTv0f9bq9QIeDp09SyV94ikt70k4SDIEX1Jhk=;
        b=KRz4nqT6ZQ+VIaEgAPwliPVNyomhf5KuyAt543VG1ey0h6o6kUJVc0vT32Z58MNWXB
         hg5qmk8nxXAeaBkNq0uUaJxy2QaiKN4Q4ZemThfHO4DQG8oiyEVdoy9Fd8Zbk+N3Ei8t
         gxzOH9aeD6lDbCVh4b0mQr3XpJozxOPvT/0SWjLcvDiEdeWHKja+5xc5w2NNITTbPAxH
         O5DX7ocHsJFiZwToHfoHuzOT23F1sMCGxjhNUDZVQMi9/47JM1dlWbHaEo2qCgxRC/am
         I497FxFYy1cZ+vRWwapEIZrVK9InUB4ciTmLnZoIoCREVtbWWAI7TvUJJWcqkCmCKIcP
         +xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681175575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7+gSuuTv0f9bq9QIeDp09SyV94ikt70k4SDIEX1Jhk=;
        b=I+HTd4FEqSq6tiIdNFjUFVsojec0jhe+PFKy2EbYBAulOGY72YgVuqPtqNSgC2txWx
         71qUg3RmLFRnPqeVc70lHsuxRrFf9LzuVPz/UehtOt5yBQH3SFkwTiyYMKomV3xkk3U4
         5WoFMQcmRPSkLgXsKhU9S+N/P7IoAfS9L4erChbgTMRkn45ozoKbffia7MHu6TI36MGZ
         izHWgo/f4q44j3NbNgGQxvhjDh6mQ6cpmSVpq5WoasibsONsWCAJdXm8Oo7SjBwqz/qU
         9ogWAaLo5WtQ8tIFKleqvsHWwgxAOzPB1Oiu439DfRnHTQ74Gy3Eq0wty6p8kkRbxKqz
         NyGQ==
X-Gm-Message-State: AAQBX9fgsSwO92WzB5b3oVaxHoe6+19RmTiklM27D+RA/sgC46pkfpZY
        AfJOBg+1uIyTGteKenfZk94hyw==
X-Google-Smtp-Source: AKy350bSBtZXFKLeW4rQPnsfdE2WGmurdYRh850nvcD/aWoZ8kS1ScFj3YlZP29o0V0zWJz/4N03gw==
X-Received: by 2002:a17:90b:17c5:b0:246:8497:37c5 with SMTP id me5-20020a17090b17c500b00246849737c5mr9757844pjb.46.1681175575250;
        Mon, 10 Apr 2023 18:12:55 -0700 (PDT)
Received: from subhajit-ThinkPad-Yoga-370.. ([124.148.71.115])
        by smtp.gmail.com with ESMTPSA id k91-20020a17090a4ce400b00246b1b4a3ffsm2220957pjh.0.2023.04.10.18.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 18:12:54 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Date:   Tue, 11 Apr 2023 09:12:03 +0800
Message-Id: <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver support for Avago (Broadcom) APDS9306
Ambient Light Sensor with als and clear channels.
This driver exposes raw values for both the channels.

Datasheet at https://docs.broadcom.com/doc/AV02-4755EN

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

---

Software reset feature is not implemented as it causes I2C bus error,
the I2C bus driver throws an ugly error message.

Could not locate the Lux calculations from datasheet, only exporting
raw values.

Reading of the Status register clears the Data Ready and the Interrupt
Status flags. It makes it tricky to read oneshot values together with
interrupts enabled as the IRQ handler clears the status on receipt
of an interrupt signal.
Not checking the status in IRQ handler will make the interrupt line
unsharable and it does not reset the interrupt line if the Interrupt
status flag is not cleared.

Many applications don't need interrupts. It is good to have support
for both in the driver.

Sysfs structure with interrupt line defined in DT:
root@stm32mp1:~# tree -I 'dev|name|of_node|power|subsystem|uevent' \
  /sys/bus/iio/devices/iio:device0/
/sys/bus/iio/devices/iio:device0/
|-- events
|   |-- thresh_adaptive_either_en
|   |-- thresh_adaptive_either_value
|   |-- thresh_adaptive_either_values_available
|   |-- thresh_channel_select
|   |-- thresh_channels_available
|   |-- thresh_either_en
|   |-- thresh_either_period
|   |-- thresh_either_period_available
|   |-- thresh_falling_value
|   `-- thresh_rising_value
|-- in_illuminance_raw
|-- in_intensity_clear_raw
|-- integration_time
|-- integration_time_available
|-- sampling_frequency
|-- sampling_frequency_available
|-- scale
`-- scale_available

Sysfs structure with no interrupt:
root@stm32mp1:~# tree -I 'dev|name|of_node|power|subsystem|uevent' \
  /sys/bus/iio/devices/iio:device0/
/sys/bus/iio/devices/iio:device0/
|-- in_illuminance_raw
|-- in_intensity_clear_raw
|-- integration_time
|-- integration_time_available
|-- sampling_frequency
|-- sampling_frequency_available
|-- scale
`-- scale_available

As there is a single interrupt enable option, using the existing
IIO bitmasks to cater for channel selection - als or clear and
interrupt type selection - threshold or adaptive
was looking ambiguous. I am open to any other implementations.

I could not find any _available implementations for the event
interface.

Created one sysfs attribute for interrupt channel selection
and one RO attribute for channel availability.

Created two RO attributes for interrupt period and threshold
adaptive value available ranges.

The ALS Measurement Rate (Sampling Frequency) has max values
of 2000ms and 2000ms for both 110b and 111b respectively.
This is not a typo. Found out experimentally that assigning
either values, interrupt is generated 2 secs apart when
interrupt conditions are met.

 drivers/iio/light/Kconfig    |   11 +
 drivers/iio/light/Makefile   |    1 +
 drivers/iio/light/apds9306.c | 1146 ++++++++++++++++++++++++++++++++++
 3 files changed, 1158 insertions(+)
 create mode 100644 drivers/iio/light/apds9306.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..8bd5aa13f49e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -73,6 +73,17 @@ config APDS9300
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9300.
 
+config APDS9306
+	tristate "Avago APDS9306 Ambient Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say Y or M here, you get support for Avago APDS9306
+	  Ambient Light Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  apds9306.
+
 config APDS9960
 	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index d74d2b5ff14c..978ec4b3de4f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
 obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
+obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
new file mode 100644
index 000000000000..d57fb7aaa24d
--- /dev/null
+++ b/drivers/iio/light/apds9306.c
@@ -0,0 +1,1146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * APDS-9306/APDS-9306-065 Ambient Light Sensor
+ *
+ * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
+ *
+ * I2C Address: 0x52
+ *
+ * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+ */
+
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/regulator/consumer.h>
+#include <asm/unaligned.h>
+
+#define APDS9306_MAIN_CTRL	0x00
+#define APDS9306_ALS_MEAS_RATE	0x04
+#define APDS9306_ALS_GAIN	0x05
+#define APDS9306_PART_ID	0x06
+#define APDS9306_MAIN_STATUS	0x07
+#define APDS9306_CLEAR_DATA_0	0x0A
+#define APDS9306_CLEAR_DATA_1	0x0B
+#define APDS9306_CLEAR_DATA_2	0x0C
+#define APDS9306_ALS_DATA_0	0x0D
+#define APDS9306_ALS_DATA_1	0x0E
+#define APDS9306_ALS_DATA_2	0x0F
+#define APDS9306_INT_CFG	0x19
+#define APDS9306_INT_PERSISTENCE	0x1A
+#define APDS9306_ALS_THRES_UP_0	0x21
+#define APDS9306_ALS_THRES_UP_1	0x22
+#define APDS9306_ALS_THRES_UP_2	0x23
+#define APDS9306_ALS_THRES_LOW_0	0x24
+#define APDS9306_ALS_THRES_LOW_1	0x25
+#define APDS9306_ALS_THRES_LOW_2	0x26
+#define APDS9306_ALS_THRES_VAR	0x27
+
+#define APDS9306_ALS_INT_STAT_MASK	BIT(4)
+#define APDS9306_ALS_DATA_STAT_MASK	BIT(3)
+
+enum apds9306_power_states {
+	standby,
+	active,
+};
+
+enum apds9306_int_channels {
+	clear,
+	als,
+};
+
+/* Integration Time (ALS Resolution) uSec */
+static const int apds9306_intg_time[][2] = {
+	{0, 400000},
+	{0, 200000},
+	{0, 100000},
+	{0, 50000},
+	{0, 25000},
+	{0, 3125},
+};
+
+/* Sampling Frequency in uHz */
+static const int apds9306_repeat_rate_freq[][2] = {
+	{40, 0},
+	{20, 0},
+	{10, 0},
+	{5,  0},
+	{2,  0},
+	{1,  0},
+	{0, 500000},
+};
+
+/* Sampling Frequency in uSec */
+static const int apds9306_repeat_rate_period[] = {
+	25000, 50000, 100000, 200000, 500000, 1000000,
+	2000000
+};
+
+/* ALS Gain Range (Scale) */
+static const int apds9306_gain[] = {
+	1, 3, 6, 9, 18
+};
+
+struct apds9306_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+	/*
+	 * Protect single als reads and device
+	 * power states.
+	 */
+	struct mutex mutex;
+
+	struct regmap *regmap;
+	/* Reg: MAIN_CTRL, Field: SW_Reset */
+	struct regmap_field *regfield_sw_reset;
+	/* Reg: MAIN_CTRL, Field: ALS_EN */
+	struct regmap_field *regfield_en;
+	/* Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width */
+	struct regmap_field *regfield_intg_time;
+	/* Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate */
+	struct regmap_field *regfield_repeat_rate;
+	/* Reg: ALS_GAIN, Field: ALS Gain Range */
+	struct regmap_field *regfield_scale;
+	/* Reg: INT_CFG, Field: ALS Interrupt Source */
+	struct regmap_field *regfield_int_src;
+	/* Reg: INT_CFG, Field: ALS Variation Interrupt Mode */
+	struct regmap_field *regfield_int_thresh_var_en;
+	/* Reg: INT_CFG, Field: ALS Interrupt Enable */
+	struct regmap_field *regfield_int_en;
+	/* Reg: INT_PERSISTENCE, Field: ALS_PERSIST */
+	struct regmap_field *regfield_int_persist_val;
+	/* Reg: ALS_THRESH_VAR, Field: ALS_THRES_VAR */
+	struct regmap_field *regfield_int_thresh_var_val;
+
+	u8 intg_time_idx;
+	u8 repeat_rate_idx;
+	u8 gain_idx;
+	u8 int_ch;
+};
+
+static const struct regmap_range apds9306_readable_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_CTRL, APDS9306_ALS_THRES_VAR)
+};
+
+static const struct regmap_range apds9306_writable_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_CTRL, APDS9306_ALS_GAIN),
+	regmap_reg_range(APDS9306_INT_CFG, APDS9306_ALS_THRES_VAR)
+};
+
+static const struct regmap_range apds9306_volatile_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_STATUS, APDS9306_MAIN_STATUS),
+	regmap_reg_range(APDS9306_CLEAR_DATA_0, APDS9306_ALS_DATA_2)
+};
+
+static const struct regmap_range apds9306_precious_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_STATUS, APDS9306_MAIN_STATUS)
+};
+
+static const struct regmap_access_table apds9306_readable_table = {
+	.yes_ranges = apds9306_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_readable_ranges)
+};
+
+static const struct regmap_access_table apds9306_writable_table = {
+	.yes_ranges = apds9306_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_writable_ranges)
+};
+
+static const struct regmap_access_table apds9306_volatile_table = {
+	.yes_ranges = apds9306_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_volatile_ranges)
+};
+
+static const struct regmap_access_table apds9306_precious_table = {
+	.yes_ranges = apds9306_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_precious_ranges)
+};
+
+static const struct regmap_config apds9306_regmap = {
+	.name = "apds9306_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &apds9306_readable_table,
+	.wr_table = &apds9306_writable_table,
+	.volatile_table = &apds9306_volatile_table,
+	.precious_table = &apds9306_precious_table,
+	.max_register = APDS9306_ALS_THRES_VAR,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct reg_field apds9306_regfield_sw_reset =
+	REG_FIELD(APDS9306_MAIN_CTRL, 4, 4);
+
+static const struct reg_field apds9306_regfield_en =
+	REG_FIELD(APDS9306_MAIN_CTRL, 1, 1);
+
+static const struct reg_field apds9306_regfield_intg_time =
+	REG_FIELD(APDS9306_ALS_MEAS_RATE, 4, 6);
+
+static const struct reg_field apds9306_regfield_repeat_rate =
+	REG_FIELD(APDS9306_ALS_MEAS_RATE, 0, 2);
+
+static const struct reg_field apds9306_regfield_scale =
+	REG_FIELD(APDS9306_ALS_GAIN, 0, 2);
+
+static const struct reg_field apds9306_regfield_int_src =
+	REG_FIELD(APDS9306_INT_CFG, 4, 5);
+
+static const struct reg_field apds9306_regfield_int_thresh_var_en =
+	REG_FIELD(APDS9306_INT_CFG, 3, 3);
+
+static const struct reg_field apds9306_regfield_int_en =
+	REG_FIELD(APDS9306_INT_CFG, 2, 2);
+
+static const struct reg_field apds9306_regfield_int_persist_val =
+	REG_FIELD(APDS9306_INT_PERSISTENCE, 4, 7);
+
+static const struct reg_field apds9306_regfield_int_thresh_var_val =
+	REG_FIELD(APDS9306_ALS_THRES_VAR, 0, 2);
+
+static struct iio_event_spec apds9306_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static struct iio_chan_spec apds9306_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 20,
+			.storagebits = 32,
+		},
+		.event_spec = apds9306_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9306_event_spec),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 20,
+			.storagebits = 32,
+		},
+		.modified = 1,
+	},
+};
+
+static struct iio_chan_spec apds9306_channels_no_events[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 20,
+			.storagebits = 32,
+		},
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 20,
+			.storagebits = 32,
+		},
+		.modified = 1,
+	},
+};
+
+static ssize_t thresh_channel_select_show(struct device *dev,
+		struct device_attribute *attr, char *buff)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (data->int_ch == 1)
+		ret = sprintf(buff, "als\n");
+	else if (data->int_ch == 0)
+		ret = sprintf(buff, "clear\n");
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static ssize_t thresh_channel_select_store(struct device *dev,
+		struct device_attribute *attr, const char *buff, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, channel;
+
+	if (len <= 0 || len > 6)
+		return -EINVAL;
+
+	if (!strncmp(buff, "als", 3))
+		channel = 1;
+	else if (!strncmp(buff, "clear", 5))
+		channel = 0;
+	else
+		return -EINVAL;
+
+	ret = regmap_field_write(data->regfield_int_src, channel);
+	if (ret)
+		return ret;
+
+	data->int_ch = channel;
+
+	return len;
+}
+
+/* INT_PERSISTENCE available */
+IIO_CONST_ATTR(thresh_either_period_available, "[0 15]");
+
+/* ALS_THRESH_VAR available */
+IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 7]");
+
+/* Interrupt channel selection available */
+IIO_CONST_ATTR(thresh_channels_available, "clear als");
+IIO_DEVICE_ATTR_RW(thresh_channel_select, 0);
+
+static struct attribute *apds9306_event_attributes[] = {
+	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
+	&iio_const_attr_thresh_channels_available.dev_attr.attr,
+	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
+	&iio_dev_attr_thresh_channel_select.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group apds9306_event_attr_group = {
+	.attrs = apds9306_event_attributes,
+};
+
+static int apds9306_regfield_init(struct apds9306_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct regmap *regmap = data->regmap;
+
+	data->regfield_sw_reset = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_sw_reset);
+	if (IS_ERR(data->regfield_sw_reset))
+		return PTR_ERR(data->regfield_sw_reset);
+
+	data->regfield_en = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_en);
+	if (IS_ERR(data->regfield_en))
+		return PTR_ERR(data->regfield_en);
+
+	data->regfield_intg_time = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_intg_time);
+	if (IS_ERR(data->regfield_intg_time))
+		return PTR_ERR(data->regfield_intg_time);
+
+	data->regfield_repeat_rate = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_repeat_rate);
+	if (IS_ERR(data->regfield_repeat_rate))
+		return PTR_ERR(data->regfield_repeat_rate);
+
+	data->regfield_scale = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_scale);
+	if (IS_ERR(data->regfield_scale))
+		return PTR_ERR(data->regfield_scale);
+
+	data->regfield_int_src = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_src);
+	if (IS_ERR(data->regfield_int_src))
+		return PTR_ERR(data->regfield_int_src);
+
+	data->regfield_int_thresh_var_en = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_thresh_var_en);
+	if (IS_ERR(data->regfield_int_thresh_var_en))
+		return PTR_ERR(data->regfield_int_thresh_var_en);
+
+	data->regfield_int_en = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_en);
+	if (IS_ERR(data->regfield_int_en))
+		return PTR_ERR(data->regfield_int_en);
+
+	data->regfield_int_persist_val = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_persist_val);
+	if (IS_ERR(data->regfield_int_persist_val))
+		return PTR_ERR(data->regfield_int_en);
+
+	data->regfield_int_thresh_var_val = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_thresh_var_val);
+	if (IS_ERR(data->regfield_int_thresh_var_val))
+		return PTR_ERR(data->regfield_int_thresh_var_en);
+
+	return 0;
+}
+
+static int apds9306_power_state(struct apds9306_data *data,
+		enum apds9306_power_states state)
+{
+	int ret;
+
+	/* Reset not included as it causes ugly I2C bus error */
+	switch (state) {
+	case standby:
+		return regmap_field_write(data->regfield_en, 0);
+	case active:
+		ret = regmap_field_write(data->regfield_en, 1);
+		if (ret)
+			return ret;
+		/* 5ms wake up time */
+		usleep_range(5000, 10000);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int apds9306_runtime_power(struct apds9306_data *data, int en)
+{
+	struct device *dev = &data->client->dev;
+	int ret = 0;
+
+	if (en) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "runtime resume failed: %d\n", ret);
+			return ret;
+		}
+		ret = 0;
+	} else {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret;
+}
+
+static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
+{
+	struct device *dev = &data->client->dev;
+	int ret, delay, status, int_en;
+	int retries = 4;
+	u8 buff[3];
+
+	ret = apds9306_runtime_power(data, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Whichever is greater - integration time period or
+	 * sampling period.
+	 */
+	delay = max(apds9306_intg_time[data->intg_time_idx][1],
+			apds9306_repeat_rate_period[data->repeat_rate_idx]);
+
+	/*
+	 * If interrupts are enabled then Status resistor cannot be
+	 * relied upon as all the status bits are cleared by the
+	 * interrupt handler in case of an event.
+	 */
+	ret = regmap_field_read(data->regfield_int_en, &int_en);
+	if (ret) {
+		dev_err(dev, "read interrupt status failed: %d\n", ret);
+		return ret;
+	}
+
+	if (!int_en) {
+		while (retries--) {
+			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
+					&status);
+			if (ret) {
+				dev_err(dev, "read status failed: %d\n", ret);
+				return ret;
+			}
+			if (status & APDS9306_ALS_DATA_STAT_MASK)
+				break;
+			/*
+			 * In case of continuous one-shot read from userspace,
+			 * new data is available after sampling period.
+			 * Delays are in the range of 25ms to 2secs.
+			 */
+			fsleep(delay);
+		}
+	} else
+		fsleep(delay);
+
+	if (!retries)
+		return -EBUSY;
+
+	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
+	if (ret) {
+		dev_err(&data->client->dev, "read data failed\n");
+		return ret;
+	}
+
+	*val = get_unaligned_le24(&buff[0]);
+
+	ret = apds9306_runtime_power(data, 0);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int apds9306_intg_time_get(struct apds9306_data *data, int *val,
+		int *val2)
+{
+	if (data->intg_time_idx > ARRAY_SIZE(apds9306_intg_time))
+		return -EINVAL;
+
+	*val = apds9306_intg_time[data->intg_time_idx][0];
+	*val2 = apds9306_intg_time[data->intg_time_idx][1];
+
+	return 0;
+}
+
+static int apds9306_intg_time_set(struct apds9306_data *data, int val,
+		int val2)
+{
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(apds9306_intg_time); i++)
+		if (apds9306_intg_time[i][0] ==  val &&
+				apds9306_intg_time[i][1] ==  val2) {
+			ret = regmap_field_write(data->regfield_intg_time, i);
+			if (ret)
+				return ret;
+			data->intg_time_idx = i;
+			break;
+		}
+
+	return ret;
+}
+
+static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
+		int *val2)
+{
+	if (data->repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
+		return -EINVAL;
+
+	*val = apds9306_repeat_rate_freq[data->repeat_rate_idx][0];
+	*val2 = apds9306_repeat_rate_freq[data->repeat_rate_idx][1];
+
+	return 0;
+}
+
+static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
+		int val2)
+{
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++)
+		if (apds9306_repeat_rate_freq[i][0] ==  val &&
+				apds9306_repeat_rate_freq[i][1] ==  val2) {
+			ret = regmap_field_write(data->regfield_repeat_rate, i);
+			if (ret)
+				return ret;
+			data->repeat_rate_idx = i;
+			break;
+		}
+
+	return ret;
+}
+
+static int apds9306_gain_get(struct apds9306_data *data, int *val)
+{
+	if (data->gain_idx > ARRAY_SIZE(apds9306_gain))
+		return -EINVAL;
+
+	*val = apds9306_gain[data->gain_idx];
+
+	return 0;
+}
+
+static int apds9306_gain_set(struct apds9306_data *data, int val)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(apds9306_gain); i++)
+		if (apds9306_gain[i] ==  val) {
+			ret = regmap_field_write(data->regfield_scale, i);
+			if (ret)
+				return ret;
+			data->gain_idx = i;
+		}
+
+	return 0;
+}
+
+static int apds9306_event_period_get(struct apds9306_data *data, int *val)
+{
+	int period, ret;
+
+	ret = regmap_field_read(data->regfield_int_persist_val, &period);
+	if (ret)
+		return ret;
+
+	if (period > 15)
+		return -EINVAL;
+
+	*val = period;
+
+	return ret;
+}
+
+static int apds9306_event_period_set(struct apds9306_data *data, int val)
+{
+	if (val < 0 || val > 15)
+		return -EINVAL;
+
+	return regmap_field_write(data->regfield_int_persist_val, val);
+}
+
+static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data,
+		int *val)
+{
+	int thad, ret;
+
+	ret = regmap_field_read(data->regfield_int_thresh_var_val, &thad);
+	if (ret)
+		return ret;
+
+	if (thad > 7)
+		return -EINVAL;
+
+	*val = thad;
+
+	return ret;
+}
+
+static int apds9306_event_thresh_adaptive_set(struct apds9306_data *data,
+		int val)
+{
+	if (val < 0 || val > 7)
+		return -EINVAL;
+
+	return regmap_field_write(data->regfield_int_thresh_var_val, val);
+}
+
+static int apds9306_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, reg;
+
+	mutex_lock(&data->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
+			reg = APDS9306_CLEAR_DATA_0;
+		else
+			reg = APDS9306_ALS_DATA_0;
+		ret = apds9306_read_data(data, val, reg);
+		if (!ret)
+			ret = IIO_VAL_INT;
+		*val2 = 0;
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = apds9306_intg_time_get(data, val, val2);
+		if (!ret)
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = apds9306_sampling_freq_get(data, val, val2);
+		if (!ret)
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = apds9306_gain_get(data, val);
+		if (!ret)
+			ret = IIO_VAL_INT;
+		*val2 = 0;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+};
+
+static int apds9306_read_avail(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, const int **vals,
+			int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(apds9306_intg_time) * 2;
+		*vals = (const int *)apds9306_intg_time;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(apds9306_repeat_rate_freq) * 2;
+		*vals = (const int *)apds9306_repeat_rate_freq;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*length = ARRAY_SIZE(apds9306_gain);
+		*vals = apds9306_gain;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int apds9306_write_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int val, int val2, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	mutex_lock(&data->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = apds9306_intg_time_set(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = apds9306_sampling_freq_set(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (val2 != 0)
+			break;
+		ret = apds9306_gain_set(data, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_info apds9306_info_no_events = {
+		.read_raw = apds9306_read_raw,
+		.read_avail = apds9306_read_avail,
+		.write_raw = apds9306_write_raw,
+};
+
+static irqreturn_t apds9306_irq_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	/* The interrupt line is released and the interrupt flag is
+	 * cleared as a result of reading the status register
+	 */
+	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "status reg read failed\n");
+		return IRQ_HANDLED;
+	}
+
+	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
+		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+				data->int_ch, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
+		iio_get_time_ns(indio_dev));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int apds9306_read_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int *val, int *val2)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	u8 buff[3];
+	int var, ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD) {
+			ret = apds9306_event_period_get(data, val);
+			if (ret)
+				return ret;
+			break;
+		}
+
+		if (dir == IIO_EV_DIR_RISING)
+			var = APDS9306_ALS_THRES_UP_0;
+		else if (dir == IIO_EV_DIR_FALLING)
+			var = APDS9306_ALS_THRES_LOW_0;
+		else
+			return -EINVAL;
+
+		ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
+		if (ret)
+			return ret;
+		*val = get_unaligned_le24(&buff[0]);
+	break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = apds9306_event_thresh_adaptive_get(data, val);
+		if (ret)
+			return ret;
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	*val2 = 0;
+	return IIO_VAL_INT;
+}
+
+static int apds9306_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	unsigned int var;
+	u8 buff[3];
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			return apds9306_event_period_set(data, val);
+		if (dir == IIO_EV_DIR_RISING)
+			var = APDS9306_ALS_THRES_UP_0;
+		else if (dir == IIO_EV_DIR_FALLING)
+			var = APDS9306_ALS_THRES_LOW_0;
+		else
+			return -EINVAL;
+
+		if (val < 0 || val > 0xFFFFF)
+			return -EINVAL;
+
+		put_unaligned_le24(val, buff);
+		return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		return apds9306_event_thresh_adaptive_set(data, val);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int apds9306_read_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		ret = regmap_field_read(data->regfield_int_en, &val);
+		if (ret)
+			return ret;
+		return val;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = regmap_field_read(data->regfield_int_thresh_var_en, &val);
+		if (ret)
+			return ret;
+		return val;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int apds9306_write_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					int state)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, curr_state;
+
+	state = !!state;
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		ret = regmap_field_read(data->regfield_int_en, &curr_state);
+		if (ret)
+			return ret;
+		if (curr_state == state)
+			return 0;
+		ret = regmap_field_write(data->regfield_int_en, state);
+		if (ret)
+			return ret;
+		mutex_lock(&data->mutex);
+		ret = apds9306_runtime_power(data, state);
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return ret;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = regmap_field_write(data->regfield_int_thresh_var_en, state);
+		if (ret)
+			return ret;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_info apds9306_info = {
+		.event_attrs = &apds9306_event_attr_group,
+		.read_raw = apds9306_read_raw,
+		.read_avail = apds9306_read_avail,
+		.write_raw = apds9306_write_raw,
+		.read_event_value = apds9306_read_event,
+		.write_event_value = apds9306_write_event,
+		.read_event_config = apds9306_read_event_config,
+		.write_event_config = apds9306_write_event_config,
+};
+
+static void apds9306_powerdown(void *ptr)
+{
+	struct apds9306_data *data = (struct apds9306_data *)ptr;
+	int status;
+
+	/* Disable interrupts */
+	regmap_field_write(data->regfield_int_thresh_var_en, 0);
+	regmap_field_write(data->regfield_int_en, 0);
+	/* Clear status */
+	regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
+	/* Put the device in standby mode */
+	apds9306_power_state(data, standby);
+}
+
+static int apds9306_init_device(struct apds9306_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = apds9306_power_state(data, active);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 5000);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = regmap_reinit_cache(data->regmap, &apds9306_regmap);
+	if (ret)
+		return ret;
+
+	/* Integration time: 100 msec */
+	ret = apds9306_intg_time_set(data, 0, 100000);
+	if (ret)
+		return ret;
+
+	/* Sampling frequency: 100 msec, 10 Hz */
+	ret = apds9306_sampling_freq_set(data, 10, 0);
+	if (ret)
+		return ret;
+
+	/* Scale: x3 */
+	ret = apds9306_gain_set(data, 3);
+	if (ret)
+		return ret;
+
+	/* Interrupt source channel: als */
+	ret = regmap_field_write(data->regfield_int_src, 1);
+	if (ret)
+		return ret;
+	data->int_ch = 1;
+
+	/* Interrupts disabled */
+	ret = regmap_field_write(data->regfield_int_en, 0);
+	if (ret)
+		return ret;
+
+	/* Threshold Variance disabled */
+	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int apds9306_probe(struct i2c_client *client)
+{
+	struct apds9306_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->indio_dev = indio_dev;
+
+	mutex_init(&data->mutex);
+
+	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+					"regmap initialization failed\n");
+
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	ret = apds9306_regfield_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"regfield initialization failed\n");
+
+	ret = devm_regulator_get_enable(&client->dev, "vin");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"Failed to enable regulator\n");
+
+	indio_dev->name = "apds9306";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (client->irq) {
+		indio_dev->info = &apds9306_info;
+		indio_dev->channels = apds9306_channels;
+		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels);
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+				apds9306_irq_handler, IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT, "apds9306_event", indio_dev);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					"failed to assign interrupt.\n");
+	} else {
+		indio_dev->info = &apds9306_info_no_events;
+		indio_dev->channels = apds9306_channels_no_events;
+		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels_no_events);
+	}
+
+	ret = devm_add_action_or_reset(&client->dev, apds9306_powerdown, data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to add action on driver unwind\n");
+
+	ret = apds9306_init_device(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "failed to init device\n");
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int apds9306_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = apds9306_power_state(data, standby);
+	if (ret)
+		regcache_cache_only(data->regmap, true);
+
+	return ret;
+}
+
+static int apds9306_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	regcache_cache_only(data->regmap, false);
+	ret = regcache_sync(data->regmap);
+	if (!ret) {
+		ret = apds9306_power_state(data, active);
+		if (ret)
+			regcache_cache_only(data->regmap, true);
+	}
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops, apds9306_runtime_suspend,
+				apds9306_runtime_resume, NULL);
+
+static const struct i2c_device_id apds9306_id[] = {
+	{ "apds9306" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, apds9306_id);
+
+static const struct of_device_id apds9306_of_match[] = {
+		{ .compatible = "avago,apds9306" },
+		{}
+};
+MODULE_DEVICE_TABLE(of, apds9306_of_match);
+
+static struct i2c_driver apds9306_driver = {
+	.driver = {
+		.name = "apds9306",
+		.pm = pm_ptr(&apds9306_pm_ops),
+		.of_match_table = apds9306_of_match,
+	},
+	.probe_new = apds9306_probe,
+	.id_table = apds9306_id,
+};
+
+module_i2c_driver(apds9306_driver);
+
+MODULE_AUTHOR("Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>");
+MODULE_DESCRIPTION("APDS9306 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

