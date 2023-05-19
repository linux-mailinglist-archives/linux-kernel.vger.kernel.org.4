Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97970709140
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjESIDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjESIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:03:35 -0400
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDEEC;
        Fri, 19 May 2023 01:02:50 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[39.144.39.119])
        by rmsmtp-lg-appmail-06-12084 (RichMail) with SMTP id 2f3464672d184e5-4055e;
        Fri, 19 May 2023 16:02:36 +0800 (CST)
X-RM-TRANSID: 2f3464672d184e5-4055e
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v3 4/5] ALSA: hda/tas2781: Add tas2781 HDA driver
Date:   Fri, 19 May 2023 16:02:27 +0800
Message-Id: <20230519080227.20224-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2781 HDA driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v3:
 - fixed issue | Reported-by: kernel test robot <lkp@intel.com>
   | Link: https://lore.kernel.org/oe-kbuild-all/202305022033.LiI7Ojm4-lkp@intel.com/
 Changes to be committed:
	modified:   sound/pci/hda/Kconfig
	modified:   sound/pci/hda/Makefile
	modified:   sound/pci/hda/patch_realtek.c
	new file:   sound/pci/hda/tas2781_hda_i2c.c
---
 sound/pci/hda/Kconfig           |  15 +
 sound/pci/hda/Makefile          |   2 +
 sound/pci/hda/patch_realtek.c   | 106 ++++-
 sound/pci/hda/tas2781_hda_i2c.c | 806 ++++++++++++++++++++++++++++++++
 4 files changed, 926 insertions(+), 3 deletions(-)
 create mode 100644 sound/pci/hda/tas2781_hda_i2c.c

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 886255a03e8b..e66257277492 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -130,6 +130,21 @@ config SND_HDA_SCODEC_CS35L41_SPI
 comment "Set to Y if you want auto-loading the side codec driver"
 	depends on SND_HDA=y && SND_HDA_SCODEC_CS35L41_SPI=m
 
+config SND_HDA_SCODEC_TAS2781_I2C
+	tristate "Build TAS2781 HD-audio side codec support for I2C Bus"
+	depends on I2C
+	depends on ACPI
+	depends on SND_SOC
+	select SND_SOC_TAS2781_COMLIB
+	select SND_SOC_TAS2781_FMWLIB
+	select CRC32_SARWATE
+	help
+	  Say Y or M here to include TAS2781 I2C HD-audio side codec support
+	  in snd-hda-intel driver, such as ALC287.
+
+comment "Set to Y if you want auto-loading the side codec driver"
+	depends on SND_HDA=y && SND_HDA_SCODEC_TAS2781_I2C=m
+
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 00d306104484..1c76609690d6 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -32,6 +32,7 @@ snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o
 snd-hda-scodec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-objs :=	cs35l41_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
+snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
@@ -56,6 +57,7 @@ obj-$(CONFIG_SND_HDA_SCODEC_CS35L41) += snd-hda-scodec-cs35l41.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_I2C) += snd-hda-scodec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_SPI) += snd-hda-scodec-cs35l41-spi.o
 obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
+obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_I2C) += snd-hda-scodec-tas2781-i2c.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 172ffc2c332b..f5b912f90018 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6705,7 +6705,7 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 	}
 }
 
-struct cs35l41_dev_name {
+struct scodec_dev_name {
 	const char *bus;
 	const char *hid;
 	int index;
@@ -6714,7 +6714,7 @@ struct cs35l41_dev_name {
 /* match the device name in a slightly relaxed manner */
 static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 {
-	struct cs35l41_dev_name *p = data;
+	struct scodec_dev_name *p = data;
 	const char *d = dev_name(dev);
 	int n = strlen(p->bus);
 	char tmp[32];
@@ -6730,12 +6730,31 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 	return !strcmp(d + n, tmp);
 }
 
+static int comp_match_tas2781_dev_name(struct device *dev, void *data)
+{
+	struct scodec_dev_name *p = data;
+	const char *d = dev_name(dev);
+	int n = strlen(p->bus);
+	char tmp[32];
+
+	/* check the bus name */
+	if (strncmp(d, p->bus, n))
+		return 0;
+	/* skip the bus number */
+	if (isdigit(d[n]))
+		n++;
+	/* the rest must be exact matching */
+	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
+
+	return !strcmp(d + n, tmp);
+}
+
 static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
 				  const char *hid, int count)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	struct cs35l41_dev_name *rec;
+	struct scodec_dev_name *rec;
 	int ret, i;
 
 	switch (action) {
@@ -6760,6 +6779,40 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 	}
 }
 
+static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
+	const char *bus, const char *hid, int count)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct alc_spec *spec = cdc->spec;
+	struct scodec_dev_name *rec;
+	int ret, i;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		for (i = 0; i < count; i++) {
+			rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
+			if (!rec)
+				return;
+			rec->bus = bus;
+			rec->hid = hid;
+			rec->index = i;
+			spec->comps[i].codec = cdc;
+			component_match_add(dev, &spec->match,
+				comp_match_tas2781_dev_name, rec);
+		}
+		ret = component_master_add_with_match(dev, &comp_master_ops,
+			spec->match);
+		if (ret)
+			codec_err(cdc,
+				"Fail to register component aggregator %d\n",
+				ret);
+		else
+			spec->gen.pcm_playback_hook =
+				comp_generic_playback_hook;
+		break;
+	}
+}
+
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 2);
@@ -6787,6 +6840,12 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0101", 2);
 }
 
+static void tas2781_fixup_i2c(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781", 1);
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -7201,6 +7260,8 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
+	ALC287_FIXUP_TAS2781_I2C_2,
+	ALC287_FIXUP_TAS2781_I2C_4
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9189,6 +9250,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
+	[ALC287_FIXUP_TAS2781_I2C_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_i2c,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
+	[ALC287_FIXUP_TAS2781_I2C_4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_i2c,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9725,6 +9798,33 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC",
+		ALC287_FIXUP_TAS2781_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC",
+		ALC287_FIXUP_TAS2781_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual powe mode2 YC",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC",
+		ALC287_FIXUP_TAS2781_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC",
+		ALC287_FIXUP_TAS2781_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL",
+		ALC287_FIXUP_TAS2781_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL",
+		ALC287_FIXUP_TAS2781_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
new file mode 100644
index 000000000000..a742805b749b
--- /dev/null
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -0,0 +1,806 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// TAS2781 HDA I2C driver
+//
+// Copyright 2023 Texas Instruments, Inc.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+
+#include <linux/acpi.h>
+#include <linux/crc8.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/hda_codec.h>
+#include <sound/soc.h>
+#include <sound/tas2781.h>
+#include <sound/tlv.h>
+#include <sound/tas2781-tlv.h>
+
+#include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_component.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+
+#define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
+
+#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinvert, \
+				 xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_range, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xreg, .shift = xshift, \
+		 .rshift = xshift, .min = xmin, .max = xmax, \
+		 .invert = xinvert} }
+
+enum calib_data {
+	R0_VAL = 0,
+	INV_R0,
+	R0LOW,
+	POWER,
+	TLIM,
+	CALIB_MAX
+};
+
+static int tas2781_acpi_get_i2c_resource(struct acpi_resource
+	*ares, void *data)
+{
+	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)data;
+	struct acpi_resource_i2c_serialbus *sb;
+
+	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
+		if (sb->slave_address != TAS2781_GLOBAL_ADDR) {
+			tas_priv->tasdevice[tas_priv->ndev].dev_addr =
+				(unsigned int) sb->slave_address;
+			tas_priv->ndev++;
+		} else
+			tas_priv->glb_addr.dev_addr = TAS2781_GLOBAL_ADDR;
+
+	}
+
+	return 1;
+}
+
+static int tas2781_hda_read_acpi(struct tasdevice_priv *tas_priv,
+	const char *hid)
+{
+	struct acpi_device *adev;
+	struct device *physdev;
+	LIST_HEAD(resources);
+	const char *sub;
+	int ret;
+
+	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+	if (!adev) {
+		dev_err(tas_priv->dev,
+			"Failed to find an ACPI device for %s\n", hid);
+		return -ENODEV;
+	}
+	strcpy(tas_priv->dev_name, hid);
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub))
+		sub = NULL;
+	dev_info(tas_priv->dev, "subid = %s\n", sub);
+
+	tas_priv->acpi_subsystem_id = sub;
+
+	ret = acpi_dev_get_resources(adev, &resources,
+		tas2781_acpi_get_i2c_resource, tas_priv);
+	if (ret < 0)
+		goto err;
+	acpi_dev_free_resource_list(&resources);
+
+	put_device(physdev);
+	dev_info(tas_priv->dev, "global addr: 0x%02x devcnt = %d\n",
+		tas_priv->glb_addr.dev_addr, tas_priv->ndev);
+
+	return 0;
+
+err:
+	dev_err(tas_priv->dev, "Failed acpi ret: %d\n", ret);
+	put_device(physdev);
+
+	return ret;
+}
+
+static void tas2781_hda_playback_hook(struct device *dev, int action)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_info(tas_priv->dev, "%s: action = %d\n", __func__, action);
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		mutex_lock(&tas_priv->codec_lock);
+		tas_priv->cur_conf = 0;
+		tas_priv->rcabin.profile_cfg_id = 1;
+		tasdevice_tuning_switch(tas_priv, 0);
+		mutex_unlock(&tas_priv->codec_lock);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		mutex_lock(&tas_priv->codec_lock);
+		tasdevice_tuning_switch(tas_priv, 1);
+		mutex_unlock(&tas_priv->codec_lock);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		break;
+	default:
+		dev_warn(tas_priv->dev, "Playback action not supported: %d\n",
+			action);
+		break;
+	}
+
+	if (ret)
+		dev_err(tas_priv->dev, "Regmap access fail: %d\n", ret);
+}
+
+static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 1;
+	uinfo->value.integer.max = max(0, tas_priv->rcabin.ncfgs);
+
+	return 0;
+}
+
+static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
+
+	return 0;
+}
+
+static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	tas_priv->rcabin.profile_cfg_id = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static int tasdevice_create_control(struct tasdevice_priv *tas_priv)
+{
+	char prof_ctrl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	struct hda_codec *codec = tas_priv->codec;
+	struct snd_kcontrol_new prof_ctrl = {
+		.name = prof_ctrl_name,
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.info = tasdevice_info_profile,
+		.get = tasdevice_get_profile_id,
+		.put = tasdevice_set_profile_id,
+	};
+	int ret;
+
+	/* Create a mixer item for selecting the active profile */
+	scnprintf(prof_ctrl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+		"tasdev-profile-id");
+	ret = snd_ctl_add(codec->card, snd_ctl_new1(&prof_ctrl, tas_priv));
+	if (ret) {
+		dev_err(tas_priv->dev, "Failed to add KControl %s = %d\n",
+			prof_ctrl.name, ret);
+		goto out;
+	}
+
+	dev_dbg(tas_priv->dev, "Added Control %s\n", prof_ctrl.name);
+
+out:
+	return ret;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->nr_programs;
+
+	return 0;
+}
+
+static int tasdevice_info_configurations(
+	struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->nr_configurations - 1;
+
+	return 0;
+}
+
+static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->cur_prog;
+
+	return 0;
+}
+
+static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	unsigned int nr_program = ucontrol->value.integer.value[0];
+
+	tas_priv->cur_prog = nr_program;
+
+	return 1;
+}
+
+static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
+
+	return 0;
+}
+
+static int tasdevice_config_put(
+	struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	unsigned int nr_configuration = ucontrol->value.integer.value[0];
+
+	tas_priv->cur_conf = nr_configuration;
+
+	return 1;
+}
+
+/**
+ * tas2781_digital_getvol - get the volum control
+ * @kcontrol: control pointer
+ * @ucontrol: User data
+ * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
+ * depends on internal regmap mechanism.
+ * tas2781 contains book and page two-level register map, especially
+ * book switching will set the register BXXP00R7F, after switching to the
+ * correct book, then leverage the mechanism for paging to access the
+ * register.
+ */
+static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_digital_getvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_amp_getvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_digital_putvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_amp_putvol(tas_priv, ucontrol, mc);
+}
+
+static const struct snd_kcontrol_new tas2781_snd_controls[] = {
+	ACARD_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2781_AMP_LEVEL,
+		1, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, amp_vol_tlv),
+	ACARD_SINGLE_RANGE_EXT_TLV("Digital Volume", TAS2781_DVC_LVL,
+		0, 0, 200, 1, tas2781_digital_getvol,
+		tas2781_digital_putvol, dvc_tlv),
+};
+
+static int tasdevice_dsp_create_ctrls(struct tasdevice_priv
+	*tas_priv)
+{
+	char prog_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char conf_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	struct hda_codec *codec = tas_priv->codec;
+	struct snd_kcontrol_new prog_ctl = {
+		.name = prog_name,
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.info = tasdevice_info_programs,
+		.get = tasdevice_program_get,
+		.put = tasdevice_program_put,
+	};
+	struct snd_kcontrol_new conf_ctl = {
+		.name = conf_name,
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.info = tasdevice_info_configurations,
+		.get = tasdevice_config_get,
+		.put = tasdevice_config_put,
+	};
+	int ret;
+
+	scnprintf(prog_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "tasdev-prog-id");
+	scnprintf(conf_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "tasdev-conf-id");
+
+	ret = snd_ctl_add(codec->card, snd_ctl_new1(&prog_ctl, tas_priv));
+	if (ret) {
+		dev_err(tas_priv->dev, "Failed to add KControl %s = %d\n",
+			prog_ctl.name, ret);
+		goto out;
+	}
+
+	dev_dbg(tas_priv->dev, "Added Control %s\n", prog_ctl.name);
+
+	ret = snd_ctl_add(codec->card, snd_ctl_new1(&conf_ctl, tas_priv));
+	if (ret) {
+		dev_err(tas_priv->dev, "Failed to add KControl %s = %d\n",
+			conf_ctl.name, ret);
+		goto out;
+	}
+
+	dev_dbg(tas_priv->dev, "Added Control %s\n", conf_ctl.name);
+out:
+	return ret;
+}
+
+static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
+{
+	unsigned char page_array[CALIB_MAX] = {0x17, 0x18, 0x18, 0x0d, 0x18};
+	unsigned char rgno_array[CALIB_MAX] = {0x74, 0x0c, 0x14, 0x3c, 0x7c};
+	unsigned char *data;
+	int i, j, rc;
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		data = tas_priv->cali_data.data +
+			i * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+		for (j = 0; j < CALIB_MAX; j++) {
+			rc = tasdevice_dev_bulk_write(tas_priv, i,
+				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
+				&(data[4 * j]), 4);
+			if (rc < 0)
+				dev_err(tas_priv->dev,
+					"chn %d calib %d bulk_wr err = %d\n",
+					i, j, rc);
+		}
+	}
+}
+
+static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
+{
+	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
+		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static efi_char16_t efi_name[] = L"CALI_DATA";
+	struct hda_codec *codec = tas_priv->codec;
+	unsigned int subid = codec->core.subsystem_id & 0xFFFF;
+	struct tm *tm = &tas_priv->tm;
+	unsigned int attr, crc;
+	unsigned int *tmp_val;
+	efi_status_t status;
+	int ret = 0;
+
+	//Lenovo devices
+	if ((subid == 0x387d) || (subid == 0x387e) || (subid == 0x3881)
+		|| (subid == 0x3884) || (subid == 0x3886) || (subid == 0x38a7)
+		|| (subid == 0x38a8) || (subid == 0x38ba) || (subid == 0x38bb)
+		|| (subid == 0x38be) || (subid == 0x38bf) || (subid == 0x38c3)
+		|| (subid == 0x38cb) || (subid == 0x38cd))
+		efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
+			0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
+	tas_priv->cali_data.total_sz = 0;
+	/* Get real size of UEFI variable */
+	status = efi.get_variable(efi_name, &efi_guid, &attr,
+		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		ret = -ENODEV;
+		/* Allocate data buffer of data_size bytes */
+		tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
+			tas_priv->cali_data.total_sz, GFP_KERNEL);
+		if (!tas_priv->cali_data.data)
+			return -ENOMEM;
+		/* Get variable contents into buffer */
+		status = efi.get_variable(efi_name, &efi_guid, &attr,
+			&tas_priv->cali_data.total_sz,
+			tas_priv->cali_data.data);
+		if (status != EFI_SUCCESS) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	tmp_val = (unsigned int *)tas_priv->cali_data.data;
+
+	crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
+	dev_info(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+		crc, tmp_val[21]);
+
+	if (crc == tmp_val[21]) {
+		time64_to_tm(tmp_val[20], 0, tm);
+		dev_info(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
+			tm->tm_year, tm->tm_mon, tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		tas2781_apply_calib(tas_priv);
+	}
+out:
+	return ret;
+}
+
+static void tasdevice_fw_ready(const struct firmware *fmw,
+	void *context)
+{
+	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
+	struct hda_codec *codec = tas_priv->codec;
+	int i, ret = 0;
+
+	pm_runtime_get_sync(tas_priv->dev);
+	mutex_lock(&tas_priv->codec_lock);
+
+	ret = tasdevice_rca_parser(tas_priv, fmw);
+	if (ret)
+		goto out;
+	tasdevice_create_control(tas_priv);
+
+	for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
+		ret = snd_ctl_add(codec->card,
+			snd_ctl_new1(&tas2781_snd_controls[i], tas_priv));
+		if (ret) {
+			dev_err(tas_priv->dev,
+				"Failed to add KControl %s = %d\n",
+				tas2781_snd_controls[i].name, ret);
+			goto out;
+		}
+	}
+
+	tasdevice_dsp_remove(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
+		codec->core.subsystem_id & 0xffff);
+	ret = tasdevice_dsp_parser(tas_priv);
+	if (ret) {
+		dev_err(tas_priv->dev, "dspfw load %s error\n",
+			tas_priv->coef_binaryname);
+		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+	tasdevice_dsp_create_ctrls(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	tasdevice_prmg_load(tas_priv, 0);
+	tas_priv->cur_prog = 0;
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	tas2781_save_calibration(tas_priv);
+
+out:
+	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
+		/*If DSP FW fail, kcontrol won't be created */
+		tasdevice_config_info_remove(tas_priv);
+		tasdevice_dsp_remove(tas_priv);
+	}
+	mutex_unlock(&tas_priv->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+	pm_runtime_mark_last_busy(tas_priv->dev);
+	pm_runtime_put_autosuspend(tas_priv->dev);
+}
+
+static int tas2781_hda_bind(struct device *dev, struct device *master,
+	void *master_data)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+	int ret = 0;
+
+	if (!comps || tas_priv->index < 0 ||
+		tas_priv->index >= HDA_MAX_COMPONENTS)
+		return -EINVAL;
+
+	comps = &comps[tas_priv->index];
+	if (comps->dev)
+		return -EBUSY;
+
+	pm_runtime_get_sync(dev);
+
+	comps->dev = dev;
+
+	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
+
+	ret = tascodec_init(tas_priv, comps->codec, tasdevice_fw_ready);
+
+	comps->playback_hook = tas2781_hda_playback_hook;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static void tas2781_hda_unbind(struct device *dev,
+	struct device *master, void *master_data)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+
+	if (comps[tas_priv->index].dev == dev)
+		memset(&comps[tas_priv->index], 0, sizeof(*comps));
+
+	tasdevice_config_info_remove(tas_priv);
+	tasdevice_dsp_remove(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+}
+
+static const struct component_ops tas2781_hda_comp_ops = {
+	.bind = tas2781_hda_bind,
+	.unbind = tas2781_hda_unbind,
+};
+
+static void tas2781_hda_remove(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(tas_priv->dev);
+	pm_runtime_disable(tas_priv->dev);
+
+
+	component_del(tas_priv->dev, &tas2781_hda_comp_ops);
+
+	pm_runtime_put_noidle(tas_priv->dev);
+
+	tasdevice_remove(tas_priv);
+}
+
+static int tas2781_hda_i2c_probe(struct i2c_client *clt)
+{
+	struct tasdevice_priv *tas_priv;
+	const char *device_name;
+	int ret;
+
+	if (strstr(dev_name(&clt->dev), "TIAS2781"))
+		device_name = "TIAS2781";
+	else
+		return -ENODEV;
+
+	tas_priv = tasdevice_kzalloc(clt);
+	if (!tas_priv)
+		return -ENOMEM;
+
+	tas_priv->irq_info.irq = clt->irq;
+	ret = tas2781_hda_read_acpi(tas_priv, device_name);
+	if (ret)
+		return dev_err_probe(tas_priv->dev, ret,
+			"Platform not supported\n");
+
+	ret = tasdevice_init(tas_priv);
+	if (ret)
+		goto err;
+
+	pm_runtime_set_autosuspend_delay(tas_priv->dev, 3000);
+	pm_runtime_use_autosuspend(tas_priv->dev);
+	pm_runtime_mark_last_busy(tas_priv->dev);
+	pm_runtime_set_active(tas_priv->dev);
+	pm_runtime_get_noresume(tas_priv->dev);
+	pm_runtime_enable(tas_priv->dev);
+
+	pm_runtime_put_autosuspend(tas_priv->dev);
+
+	ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
+	if (ret) {
+		dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
+		pm_runtime_disable(tas_priv->dev);
+	}
+
+err:
+	if (ret)
+		tas2781_hda_remove(&clt->dev);
+	return ret;
+}
+
+static void tas2781_hda_i2c_remove(struct i2c_client *clt)
+{
+	tas2781_hda_remove(&clt->dev);
+}
+
+static int tas2781_runtime_suspend(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	int i, ret = 0;
+
+	dev_info(tas_priv->dev, "Runtime Suspend\n");
+
+	mutex_lock(&tas_priv->codec_lock);
+
+	if (tas_priv->playback_started) {
+		tasdevice_tuning_switch(tas_priv, 1);
+		tas_priv->playback_started = false;
+	}
+
+	tas_priv->cur_prog = -1;
+	tas_priv->cur_conf = -1;
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		tas_priv->tasdevice[i].cur_book = -1;
+		tas_priv->tasdevice[i].cur_prog = -1;
+		tas_priv->tasdevice[i].cur_conf = -1;
+	}
+
+	regcache_cache_only(tas_priv->regmap, true);
+	regcache_mark_dirty(tas_priv->regmap);
+
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return ret;
+}
+
+static int tas2781_runtime_resume(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	unsigned long calib_data_sz =
+		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+	int ret = 0;
+
+	dev_info(tas_priv->dev, "Runtime Resume\n");
+
+	mutex_lock(&tas_priv->codec_lock);
+
+	regcache_cache_only(tas_priv->regmap, false);
+	ret = regcache_sync(tas_priv->regmap);
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to restore register cache: %d\n", ret);
+		goto out;
+	}
+
+	tasdevice_prmg_load(tas_priv, 0);
+	tas_priv->cur_prog = 0;
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	if (tas_priv->cali_data.total_sz > calib_data_sz)
+		tas2781_apply_calib(tas_priv);
+
+out:
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return ret;
+}
+
+static int tas2781_system_suspend(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	int ret;
+
+	dev_info(tas_priv->dev, "System Suspend\n");
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Shutdown chip before system suspend */
+	regcache_cache_only(tas_priv->regmap, false);
+	tasdevice_tuning_switch(tas_priv, 1);
+	regcache_cache_only(tas_priv->regmap, true);
+	regcache_mark_dirty(tas_priv->regmap);
+	/*
+	 * Reset GPIO may be shared, so cannot reset here.
+	 * However beyond this point, amps may be powered down.
+	 */
+	return 0;
+}
+
+static int tas2781_system_resume(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	unsigned long calib_data_sz =
+		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+	int i, ret;
+
+	dev_info(tas_priv->dev, "System Resume\n");
+
+	ret = pm_runtime_force_resume(dev);
+
+	mutex_lock(&tas_priv->codec_lock);
+	tas_priv->cur_prog = -1;
+	tas_priv->cur_conf = -1;
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		tas_priv->tasdevice[i].cur_book = -1;
+		tas_priv->tasdevice[i].cur_prog = -1;
+		tas_priv->tasdevice[i].cur_conf = -1;
+	}
+	tas2781_reset(tas_priv);
+	tasdevice_prmg_load(tas_priv, 0);
+	tas_priv->cur_prog = 0;
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	if (tas_priv->cali_data.total_sz > calib_data_sz)
+		tas2781_apply_calib(tas_priv);
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return ret;
+}
+
+static const struct dev_pm_ops tas2781_hda_pm_ops = {
+	RUNTIME_PM_OPS(tas2781_runtime_suspend, tas2781_runtime_resume,
+		NULL)
+	SYSTEM_SLEEP_PM_OPS(tas2781_system_suspend, tas2781_system_resume)
+};
+
+static const struct i2c_device_id tas2781_hda_i2c_id[] = {
+	{ "tas2781-hda", 0 },
+	{}
+};
+
+static const struct acpi_device_id tas2781_acpi_hda_match[] = {
+	{"TIAS2781", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
+
+static struct i2c_driver tas2781_hda_i2c_driver = {
+	.driver = {
+		.name		= "tas2781-hda",
+		.acpi_match_table = tas2781_acpi_hda_match,
+		.pm		= &tas2781_hda_pm_ops,
+	},
+	.id_table	= tas2781_hda_i2c_id,
+	.probe_new	= tas2781_hda_i2c_probe,
+	.remove		= tas2781_hda_i2c_remove,
+};
+module_i2c_driver(tas2781_hda_i2c_driver);
+
+MODULE_DESCRIPTION("TAS2781 HDA Driver");
+MODULE_AUTHOR("Shenghao Ding, TI, <shenghao-ding@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_TAS2781_FMWLIB);
-- 
2.34.1


