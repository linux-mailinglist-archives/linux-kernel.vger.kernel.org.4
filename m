Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA5073DCF0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjFZLJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjFZLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:09:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDDD1;
        Mon, 26 Jun 2023 04:09:21 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A483124E27D;
        Mon, 26 Jun 2023 19:09:14 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:14 +0800
Received: from ubuntu.localdomain (113.72.146.167) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:13 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/5] ASoC: starfive: Add JH7110 PWM-DAC driver
Date:   Mon, 26 Jun 2023 19:09:08 +0800
Message-ID: <20230626110909.38718-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626110909.38718-1-hal.feng@starfivetech.com>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.167]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM-DAC driver support for the StarFive JH7110 SoC.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                        |   8 +
 sound/soc/starfive/Kconfig         |   9 +
 sound/soc/starfive/Makefile        |   1 +
 sound/soc/starfive/jh7110_pwmdac.c | 787 +++++++++++++++++++++++++++++
 4 files changed, 805 insertions(+)
 create mode 100644 sound/soc/starfive/jh7110_pwmdac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc12c5c02f7..a936ba4d5f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20125,6 +20125,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/starfive*
 F:	drivers/mmc/host/dw_mmc-starfive.c
 
+STARFIVE JH7110 PWMDAC DRIVER
+M:	Hal Feng <hal.feng@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac*
+F:	sound/soc/codecs/jh7110_pwmdac_transmitter.c
+F:	sound/soc/starfive/jh7110_pwmdac.c
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/sound/soc/starfive/Kconfig b/sound/soc/starfive/Kconfig
index fafb681f8c0a..fabef377db8c 100644
--- a/sound/soc/starfive/Kconfig
+++ b/sound/soc/starfive/Kconfig
@@ -7,6 +7,15 @@ config SND_SOC_STARFIVE
 	  the Starfive SoCs' Audio interfaces. You will also need to
 	  select the audio interfaces to support below.
 
+config SND_SOC_JH7110_PWMDAC
+	tristate "JH7110 PWM-DAC device driver"
+	depends on HAVE_CLK && SND_SOC_STARFIVE
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_SOC_JH7110_PWMDAC_DIT
+	help
+	 Say Y or M if you want to add support for StarFive JH7110
+	 PWM-DAC driver.
+
 config SND_SOC_JH7110_TDM
 	tristate "JH7110 TDM device driver"
 	depends on HAVE_CLK && SND_SOC_STARFIVE
diff --git a/sound/soc/starfive/Makefile b/sound/soc/starfive/Makefile
index f7d960211d72..9e958f70ef51 100644
--- a/sound/soc/starfive/Makefile
+++ b/sound/soc/starfive/Makefile
@@ -1,2 +1,3 @@
 # StarFive Platform Support
+obj-$(CONFIG_SND_SOC_JH7110_PWMDAC) += jh7110_pwmdac.o
 obj-$(CONFIG_SND_SOC_JH7110_TDM) += jh7110_tdm.o
diff --git a/sound/soc/starfive/jh7110_pwmdac.c b/sound/soc/starfive/jh7110_pwmdac.c
new file mode 100644
index 000000000000..c3123bd6ea45
--- /dev/null
+++ b/sound/soc/starfive/jh7110_pwmdac.c
@@ -0,0 +1,787 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * jh7110_pwmdac.c -- StarFive JH7110 PWM-DAC driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ *
+ * Authors: Jenny Zhang
+ *	    Curry Zhang
+ *	    Xingyu Wu <xingyu.wu@starfivetech.com>
+ *	    Hal Feng <hal.feng@starfivetech.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define JH7110_PWMDAC_WDATA				0x00
+#define JH7110_PWMDAC_CTRL				0x04
+	#define JH7110_PWMDAC_ENABLE			BIT(0)
+	#define JH7110_PWMDAC_SHIFT			BIT(1)
+	#define JH7110_PWMDAC_DUTY_CYCLE_SHIFT		2
+	#define JH7110_PWMDAC_DUTY_CYCLE_MASK		GENMASK(3, 2)
+	#define JH7110_PWMDAC_CNT_N_SHIFT		4
+	#define JH7110_PWMDAC_CNT_N_MASK		GENMASK(12, 4)
+	#define JH7110_PWMDAC_DATA_CHANGE		BIT(13)
+	#define JH7110_PWMDAC_DATA_MODE			BIT(14)
+	#define JH7110_PWMDAC_DATA_SHIFT_SHIFT		15
+	#define JH7110_PWMDAC_DATA_SHIFT_MASK		GENMASK(17, 15)
+
+enum JH7110_PWMDAC_SHIFT_VAL {
+	PWMDAC_SHIFT_8 = 0,
+	PWMDAC_SHIFT_10,
+};
+
+enum JH7110_PWMDAC_DUTY_CYCLE_VAL {
+	PWMDAC_CYCLE_LEFT = 0,
+	PWMDAC_CYCLE_RIGHT,
+	PWMDAC_CYCLE_CENTER,
+};
+
+enum JH7110_PWMDAC_CNT_N_VAL {
+	PWMDAC_SAMPLE_CNT_1 = 1,
+	PWMDAC_SAMPLE_CNT_2,
+	PWMDAC_SAMPLE_CNT_3,
+	PWMDAC_SAMPLE_CNT_512 = 512, /* max */
+};
+
+enum JH7110_PWMDAC_DATA_CHANGE_VAL {
+	NO_CHANGE = 0,
+	CHANGE,
+};
+
+enum JH7110_PWMDAC_DATA_MODE_VAL {
+	UNSIGNED_DATA = 0,
+	INVERTER_DATA_MSB,
+};
+
+enum JH7110_PWMDAC_DATA_SHIFT_VAL {
+	PWMDAC_DATA_LEFT_SHIFT_BIT_0 = 0,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_1,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_2,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_3,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_4,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_5,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_6,
+	PWMDAC_DATA_LEFT_SHIFT_BIT_7,
+};
+
+struct jh7110_pwmdac_dev {
+	void __iomem *base;
+	resource_size_t	mapbase;
+	u8 shift;
+	u8 duty_cycle;
+	u8 cnt_n;
+	u8 data_change;
+	u8 data_mode;
+	u8 data_shift;
+
+	struct clk_bulk_data clks[2];
+	struct reset_control *rst_apb;
+	struct device *dev;
+	struct snd_dmaengine_dai_dma_data play_dma_data;
+	u32 saved_ctrl;
+};
+
+enum jh7110_ct_pwmdac_name {
+	PWMDAC_CT_SHIFT = 0,
+	PWMDAC_CT_DUTY_CYCLE,
+	PWMDAC_CT_DATA_CHANGE,
+	PWMDAC_CT_DATA_MODE,
+	PWMDAC_CT_DATA_SHIFT,
+};
+
+struct jh7110_ct_pwmdac {
+	char *name;
+	unsigned int vals;
+};
+
+static const struct jh7110_ct_pwmdac pwmdac_ct_shift[] = {
+	{ .name = "8bit", .vals = PWMDAC_SHIFT_8 },
+	{ .name = "10bit", .vals = PWMDAC_SHIFT_10 }
+};
+
+static const struct jh7110_ct_pwmdac pwmdac_ct_duty_cycle[] = {
+	{ .name = "left", .vals = PWMDAC_CYCLE_LEFT },
+	{ .name = "right", .vals = PWMDAC_CYCLE_RIGHT },
+	{ .name = "center", .vals = PWMDAC_CYCLE_CENTER }
+};
+
+static const struct jh7110_ct_pwmdac pwmdac_ct_data_change[] = {
+	{ .name = "no_change", .vals = NO_CHANGE },
+	{ .name = "change", .vals = CHANGE }
+};
+
+static const struct jh7110_ct_pwmdac pwmdac_ct_data_mode[] = {
+	{ .name = "unsigned", .vals = UNSIGNED_DATA },
+	{ .name = "inverter", .vals = INVERTER_DATA_MSB }
+};
+
+static const struct jh7110_ct_pwmdac pwmdac_ct_data_shift[] = {
+	{ .name = "left 0 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_0 },
+	{ .name = "left 1 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_1 },
+	{ .name = "left 2 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_2 },
+	{ .name = "left 3 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_3 },
+	{ .name = "left 4 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_4 },
+	{ .name = "left 5 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_5 },
+	{ .name = "left 6 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_6 },
+	{ .name = "left 7 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_7 }
+};
+
+static int jh7110_pwmdac_info(struct snd_ctl_elem_info *uinfo, int pwmdac_ct)
+{
+	unsigned int items;
+
+	if (pwmdac_ct == PWMDAC_CT_SHIFT) {
+		items = ARRAY_SIZE(pwmdac_ct_shift);
+		strcpy(uinfo->value.enumerated.name,
+		       pwmdac_ct_shift[uinfo->value.enumerated.item].name);
+	} else if (pwmdac_ct == PWMDAC_CT_DUTY_CYCLE) {
+		items = ARRAY_SIZE(pwmdac_ct_duty_cycle);
+		strcpy(uinfo->value.enumerated.name,
+		       pwmdac_ct_duty_cycle[uinfo->value.enumerated.item].name);
+	} else if (pwmdac_ct == PWMDAC_CT_DATA_CHANGE) {
+		items = ARRAY_SIZE(pwmdac_ct_data_change);
+		strcpy(uinfo->value.enumerated.name,
+		       pwmdac_ct_data_change[uinfo->value.enumerated.item].name);
+	} else if (pwmdac_ct == PWMDAC_CT_DATA_MODE) {
+		items = ARRAY_SIZE(pwmdac_ct_data_mode);
+		strcpy(uinfo->value.enumerated.name,
+		       pwmdac_ct_data_mode[uinfo->value.enumerated.item].name);
+	} else if (pwmdac_ct == PWMDAC_CT_DATA_SHIFT) {
+		items = ARRAY_SIZE(pwmdac_ct_data_shift);
+		strcpy(uinfo->value.enumerated.name,
+		       pwmdac_ct_data_shift[uinfo->value.enumerated.item].name);
+	}
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = items;
+	if (uinfo->value.enumerated.item >= items)
+		uinfo->value.enumerated.item = items - 1;
+
+	return 0;
+}
+
+static int jh7110_pwmdac_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol,
+			     int pwmdac_ct)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct jh7110_pwmdac_dev *dev = snd_soc_component_get_drvdata(component);
+
+	if (pwmdac_ct == PWMDAC_CT_SHIFT)
+		ucontrol->value.enumerated.item[0] = dev->shift;
+	else if (pwmdac_ct == PWMDAC_CT_DUTY_CYCLE)
+		ucontrol->value.enumerated.item[0] = dev->duty_cycle;
+	else if (pwmdac_ct == PWMDAC_CT_DATA_CHANGE)
+		ucontrol->value.enumerated.item[0] = dev->data_change;
+	else if (pwmdac_ct == PWMDAC_CT_DATA_MODE)
+		ucontrol->value.enumerated.item[0] = dev->data_mode;
+	else if (pwmdac_ct == PWMDAC_CT_DATA_SHIFT)
+		ucontrol->value.enumerated.item[0] = dev->data_shift;
+
+	return 0;
+}
+
+static int jh7110_pwmdac_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol,
+			     int pwmdac_ct)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct jh7110_pwmdac_dev *dev = snd_soc_component_get_drvdata(component);
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items;
+
+	if (pwmdac_ct == PWMDAC_CT_SHIFT)
+		items = ARRAY_SIZE(pwmdac_ct_shift);
+	else if (pwmdac_ct == PWMDAC_CT_DUTY_CYCLE)
+		items = ARRAY_SIZE(pwmdac_ct_duty_cycle);
+	else if (pwmdac_ct == PWMDAC_CT_DATA_CHANGE)
+		items = ARRAY_SIZE(pwmdac_ct_data_change);
+	else if (pwmdac_ct == PWMDAC_CT_DATA_MODE)
+		items = ARRAY_SIZE(pwmdac_ct_data_mode);
+	else if (pwmdac_ct == PWMDAC_CT_DATA_SHIFT)
+		items = ARRAY_SIZE(pwmdac_ct_data_shift);
+
+	if (sel >= items)
+		return -EINVAL;
+
+	if (pwmdac_ct == PWMDAC_CT_SHIFT)
+		dev->shift = pwmdac_ct_shift[sel].vals;
+	else if (pwmdac_ct == PWMDAC_CT_DUTY_CYCLE)
+		dev->duty_cycle = pwmdac_ct_duty_cycle[sel].vals;
+	else if (pwmdac_ct == PWMDAC_CT_DATA_CHANGE)
+		dev->data_change = pwmdac_ct_data_change[sel].vals;
+	else if (pwmdac_ct == PWMDAC_CT_DATA_MODE)
+		dev->data_mode = pwmdac_ct_data_mode[sel].vals;
+	else if (pwmdac_ct == PWMDAC_CT_DATA_SHIFT)
+		dev->data_shift = pwmdac_ct_data_shift[sel].vals;
+
+	return 0;
+}
+
+static int jh7110_pwmdac_shift_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	return jh7110_pwmdac_info(uinfo, PWMDAC_CT_SHIFT);
+}
+
+static int jh7110_pwmdac_shift_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_get(kcontrol, ucontrol, PWMDAC_CT_SHIFT);
+}
+
+static int jh7110_pwmdac_shift_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_put(kcontrol, ucontrol, PWMDAC_CT_SHIFT);
+}
+
+static int jh7110_pwmdac_duty_cycle_info(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_info *uinfo)
+{
+	return jh7110_pwmdac_info(uinfo, PWMDAC_CT_DUTY_CYCLE);
+}
+
+static int jh7110_pwmdac_duty_cycle_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_get(kcontrol, ucontrol, PWMDAC_CT_DUTY_CYCLE);
+}
+
+static int jh7110_pwmdac_duty_cycle_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_put(kcontrol, ucontrol, PWMDAC_CT_DUTY_CYCLE);
+}
+
+static int jh7110_pwmdac_data_change_info(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_info *uinfo)
+{
+	return jh7110_pwmdac_info(uinfo, PWMDAC_CT_DATA_CHANGE);
+}
+
+static int jh7110_pwmdac_data_change_get(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_get(kcontrol, ucontrol, PWMDAC_CT_DATA_CHANGE);
+}
+
+static int jh7110_pwmdac_data_change_put(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_put(kcontrol, ucontrol, PWMDAC_CT_DATA_CHANGE);
+}
+
+static int jh7110_pwmdac_data_mode_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	return jh7110_pwmdac_info(uinfo, PWMDAC_CT_DATA_MODE);
+}
+
+static int jh7110_pwmdac_data_mode_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_get(kcontrol, ucontrol, PWMDAC_CT_DATA_MODE);
+}
+
+static int jh7110_pwmdac_data_mode_put(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_put(kcontrol, ucontrol, PWMDAC_CT_DATA_MODE);
+}
+
+static int jh7110_pwmdac_data_shift_info(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_info *uinfo)
+{
+	return jh7110_pwmdac_info(uinfo, PWMDAC_CT_DATA_SHIFT);
+}
+
+static int jh7110_pwmdac_data_shift_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_get(kcontrol, ucontrol, PWMDAC_CT_DATA_SHIFT);
+}
+
+static int jh7110_pwmdac_data_shift_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return jh7110_pwmdac_put(kcontrol, ucontrol, PWMDAC_CT_DATA_SHIFT);
+}
+
+static inline void jh7110_pwmdac_write_reg(void __iomem *io_base, int reg, u32 val)
+{
+	writel(val, io_base + reg);
+}
+
+static inline u32 jh7110_pwmdac_read_reg(void __iomem *io_base, int reg)
+{
+	return readl(io_base + reg);
+}
+
+static void jh7110_pwmdac_set_enable(struct jh7110_pwmdac_dev *dev, bool enable)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	if (enable)
+		value |= JH7110_PWMDAC_ENABLE;
+	else
+		value &= ~JH7110_PWMDAC_ENABLE;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set_shift(struct jh7110_pwmdac_dev *dev)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	if (dev->shift == PWMDAC_SHIFT_8)
+		value &= ~JH7110_PWMDAC_SHIFT;
+	else if (dev->shift == PWMDAC_SHIFT_10)
+		value |= JH7110_PWMDAC_SHIFT;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set_duty_cycle(struct jh7110_pwmdac_dev *dev)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	value &= ~JH7110_PWMDAC_DUTY_CYCLE_MASK;
+	value |= (dev->duty_cycle & 0x3) << JH7110_PWMDAC_DUTY_CYCLE_SHIFT;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set_cnt_n(struct jh7110_pwmdac_dev *dev)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	value &= ~JH7110_PWMDAC_CNT_N_MASK;
+	value |= ((dev->cnt_n - 1) & 0x1ff) << JH7110_PWMDAC_CNT_N_SHIFT;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set_data_change(struct jh7110_pwmdac_dev *dev)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	if (dev->data_change == NO_CHANGE)
+		value &= ~JH7110_PWMDAC_DATA_CHANGE;
+	else if (dev->data_change == CHANGE)
+		value |= JH7110_PWMDAC_DATA_CHANGE;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set_data_mode(struct jh7110_pwmdac_dev *dev)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	if (dev->data_mode == UNSIGNED_DATA)
+		value &= ~JH7110_PWMDAC_DATA_MODE;
+	else if (dev->data_mode == INVERTER_DATA_MSB)
+		value |= JH7110_PWMDAC_DATA_MODE;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set_data_shift(struct jh7110_pwmdac_dev *dev)
+{
+	u32 value;
+
+	value = jh7110_pwmdac_read_reg(dev->base, JH7110_PWMDAC_CTRL);
+	value &= ~JH7110_PWMDAC_DATA_SHIFT_MASK;
+	value |= (dev->data_shift & 0x7) << JH7110_PWMDAC_DATA_SHIFT_SHIFT;
+
+	jh7110_pwmdac_write_reg(dev->base, JH7110_PWMDAC_CTRL, value);
+}
+
+static void jh7110_pwmdac_set(struct jh7110_pwmdac_dev *dev)
+{
+	jh7110_pwmdac_set_shift(dev);
+	jh7110_pwmdac_set_duty_cycle(dev);
+	jh7110_pwmdac_set_cnt_n(dev);
+	jh7110_pwmdac_set_enable(dev, true);
+
+	jh7110_pwmdac_set_data_change(dev);
+	jh7110_pwmdac_set_data_mode(dev);
+	jh7110_pwmdac_set_data_shift(dev);
+}
+
+static void jh7110_pwmdac_stop(struct jh7110_pwmdac_dev *dev)
+{
+	jh7110_pwmdac_set_enable(dev, false);
+}
+
+static int jh7110_pwmdac_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+
+	dai_link->stop_dma_first = 1;
+
+	return 0;
+}
+
+static int jh7110_pwmdac_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	unsigned long core_clk_rate;
+	int ret;
+	struct jh7110_pwmdac_dev *dev = dev_get_drvdata(dai->dev);
+
+	switch (params_rate(params)) {
+	case 8000:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_3;
+		core_clk_rate = 6144000;
+		break;
+	case 11025:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_2;
+		core_clk_rate = 5644800;
+		break;
+	case 16000:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_3;
+		core_clk_rate = 12288000;
+		break;
+	case 22050:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_1;
+		core_clk_rate = 5644800;
+		break;
+	case 32000:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_1;
+		core_clk_rate = 8192000;
+		break;
+	case 44100:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_1;
+		core_clk_rate = 11289600;
+		break;
+	case 48000:
+		dev->cnt_n = PWMDAC_SAMPLE_CNT_1;
+		core_clk_rate = 12288000;
+		break;
+	default:
+		dev_err(dai->dev, "%d rate not supported\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	switch (params_channels(params)) {
+	case 1:
+		dev->play_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 2:
+		dev->play_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		dev_err(dai->dev, "%d channels not supported\n",
+			params_channels(params));
+		return -EINVAL;
+	}
+
+	/*
+	 * The clock rate always rounds down when using clk_set_rate()
+	 * so increase the rate a bit
+	 */
+	core_clk_rate += 64;
+	jh7110_pwmdac_set(dev);
+
+	ret = clk_set_rate(dev->clks[1].clk, core_clk_rate);
+	if (ret) {
+		dev_err(dai->dev,
+			"failed to set rate %lu for core clock\n",
+			core_clk_rate);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int jh7110_pwmdac_trigger(struct snd_pcm_substream *substream, int cmd,
+				 struct snd_soc_dai *dai)
+{
+	struct jh7110_pwmdac_dev *dev = snd_soc_dai_get_drvdata(dai);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		jh7110_pwmdac_set(dev);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		jh7110_pwmdac_stop(dev);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int jh7110_pwmdac_crg_enable(struct jh7110_pwmdac_dev *dev, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		ret = clk_bulk_prepare_enable(ARRAY_SIZE(dev->clks), dev->clks);
+		if (ret) {
+			dev_err(dev->dev, "failed to enable pwmdac clocks\n");
+			return ret;
+		}
+
+		ret = reset_control_deassert(dev->rst_apb);
+		if (ret) {
+			dev_err(dev->dev, "failed to deassert pwmdac apb reset\n");
+			goto err_rst_apb;
+		}
+	} else {
+		clk_bulk_disable_unprepare(ARRAY_SIZE(dev->clks), dev->clks);
+	}
+
+	return 0;
+
+err_rst_apb:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(dev->clks), dev->clks);
+
+	return ret;
+}
+
+static int jh7110_pwmdac_dai_probe(struct snd_soc_dai *dai)
+{
+	struct jh7110_pwmdac_dev *dev = dev_get_drvdata(dai->dev);
+
+	dev->play_dma_data.addr = dev->mapbase + JH7110_PWMDAC_WDATA;
+	dev->play_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dev->play_dma_data.fifo_size = 1;
+	dev->play_dma_data.maxburst = 16;
+
+	snd_soc_dai_init_dma_data(dai, &dev->play_dma_data, NULL);
+	snd_soc_dai_set_drvdata(dai, dev);
+
+	return 0;
+}
+
+#define JH7110_PWMDAC_ENUM_DECL(xname, xinfo, xget, xput) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = xinfo, .get = xget, .put = xput,}
+
+static const struct snd_kcontrol_new jh7110_pwmdac_snd_controls[] = {
+	JH7110_PWMDAC_ENUM_DECL("shift", jh7110_pwmdac_shift_info,
+				jh7110_pwmdac_shift_get,
+				jh7110_pwmdac_shift_put),
+	JH7110_PWMDAC_ENUM_DECL("duty_cycle", jh7110_pwmdac_duty_cycle_info,
+				jh7110_pwmdac_duty_cycle_get,
+				jh7110_pwmdac_duty_cycle_put),
+	JH7110_PWMDAC_ENUM_DECL("data_change", jh7110_pwmdac_data_change_info,
+				jh7110_pwmdac_data_change_get,
+				jh7110_pwmdac_data_change_put),
+	JH7110_PWMDAC_ENUM_DECL("data_mode", jh7110_pwmdac_data_mode_info,
+				jh7110_pwmdac_data_mode_get,
+				jh7110_pwmdac_data_mode_put),
+	JH7110_PWMDAC_ENUM_DECL("data_shift", jh7110_pwmdac_data_shift_info,
+				jh7110_pwmdac_data_shift_get,
+				jh7110_pwmdac_data_shift_put),
+};
+
+static int jh7110_pwmdac_component_probe(struct snd_soc_component *component)
+{
+	snd_soc_add_component_controls(component, jh7110_pwmdac_snd_controls,
+				       ARRAY_SIZE(jh7110_pwmdac_snd_controls));
+	return 0;
+}
+
+static const struct snd_soc_dai_ops jh7110_pwmdac_dai_ops = {
+	.startup	= jh7110_pwmdac_startup,
+	.hw_params	= jh7110_pwmdac_hw_params,
+	.trigger	= jh7110_pwmdac_trigger,
+};
+
+static const struct snd_soc_component_driver jh7110_pwmdac_component = {
+	.name		= "jh7110-pwmdac",
+	.probe		= jh7110_pwmdac_component_probe,
+};
+
+static struct snd_soc_dai_driver jh7110_pwmdac_dai = {
+	.name		= "jh7110-pwmdac",
+	.id		= 0,
+	.probe		= jh7110_pwmdac_dai_probe,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &jh7110_pwmdac_dai_ops,
+};
+
+static int jh7110_pwmdac_runtime_suspend(struct device *dev)
+{
+	struct jh7110_pwmdac_dev *pwmdac = dev_get_drvdata(dev);
+
+	return jh7110_pwmdac_crg_enable(pwmdac, false);
+}
+
+static int jh7110_pwmdac_runtime_resume(struct device *dev)
+{
+	struct jh7110_pwmdac_dev *pwmdac = dev_get_drvdata(dev);
+
+	return jh7110_pwmdac_crg_enable(pwmdac, true);
+}
+
+static int jh7110_pwmdac_system_suspend(struct device *dev)
+{
+	struct jh7110_pwmdac_dev *pwmdac = dev_get_drvdata(dev);
+
+	/* save the CTRL register value */
+	pwmdac->saved_ctrl = jh7110_pwmdac_read_reg(pwmdac->base,
+						    JH7110_PWMDAC_CTRL);
+	return pm_runtime_force_suspend(dev);
+}
+
+static int jh7110_pwmdac_system_resume(struct device *dev)
+{
+	struct jh7110_pwmdac_dev *pwmdac = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	/* restore the CTRL register value */
+	jh7110_pwmdac_write_reg(pwmdac->base, JH7110_PWMDAC_CTRL,
+				pwmdac->saved_ctrl);
+	return 0;
+}
+
+static const struct dev_pm_ops jh7110_pwmdac_pm_ops = {
+	RUNTIME_PM_OPS(jh7110_pwmdac_runtime_suspend,
+		       jh7110_pwmdac_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(jh7110_pwmdac_system_suspend,
+			    jh7110_pwmdac_system_resume)
+};
+
+static int jh7110_pwmdac_probe(struct platform_device *pdev)
+{
+	struct jh7110_pwmdac_dev *dev;
+	struct resource *res;
+	int ret;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	dev->mapbase = res->start;
+
+	dev->clks[0].id = "apb";
+	dev->clks[1].id = "core";
+
+	ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(dev->clks), dev->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get pwmdac clocks\n");
+		return ret;
+	}
+
+	dev->rst_apb = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(dev->rst_apb)) {
+		dev_err(&pdev->dev, "failed to get pwmdac apb reset\n");
+		return PTR_ERR(dev->rst_apb);
+	}
+
+	dev->dev = &pdev->dev;
+	dev->shift = PWMDAC_SHIFT_8;
+	dev->duty_cycle = PWMDAC_CYCLE_CENTER;
+	dev->cnt_n = PWMDAC_SAMPLE_CNT_1;
+	dev->data_change = NO_CHANGE;
+	dev->data_mode = INVERTER_DATA_MSB;
+	dev->data_shift = PWMDAC_DATA_LEFT_SHIFT_BIT_0;
+
+	dev_set_drvdata(&pdev->dev, dev);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &jh7110_pwmdac_component,
+					      &jh7110_pwmdac_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register dai\n");
+		return ret;
+	}
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register pcm\n");
+		return ret;
+	}
+
+	pm_runtime_enable(dev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = jh7110_pwmdac_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int jh7110_pwmdac_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id jh7110_pwmdac_of_match[] = {
+	{ .compatible = "starfive,jh7110-pwmdac" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_pwmdac_of_match);
+
+static struct platform_driver jh7110_pwmdac_driver = {
+	.driver		= {
+		.name	= "jh7110-pwmdac",
+		.of_match_table = jh7110_pwmdac_of_match,
+		.pm = pm_ptr(&jh7110_pwmdac_pm_ops),
+	},
+	.probe		= jh7110_pwmdac_probe,
+	.remove		= jh7110_pwmdac_remove,
+};
+module_platform_driver(jh7110_pwmdac_driver);
+
+MODULE_AUTHOR("Jenny Zhang");
+MODULE_AUTHOR("Curry Zhang");
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 PWM-DAC driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

