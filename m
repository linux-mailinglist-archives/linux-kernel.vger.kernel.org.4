Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7E72BB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjFLJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFLJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:04:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76674E63
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:01:00 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.124])
        by gateway (Coremail) with SMTP id _____8Cx+enI3oZktpkDAA--.7910S3;
        Mon, 12 Jun 2023 17:00:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.124])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxZuTF3oZkoGwVAA--.61735S4;
        Mon, 12 Jun 2023 17:00:54 +0800 (CST)
From:   YingKun Meng <mengyingkun@loongson.cn>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Yingkun Meng <mengyingkun@loongson.cn>
Subject: [ PATCH v2 2/3] ASoC: loongson: Add Loongson ASoC Sound Card Support
Date:   Mon, 12 Jun 2023 17:00:46 +0800
Message-Id: <20230612090046.3039532-1-mengyingkun@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxZuTF3oZkoGwVAA--.61735S4
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAADGSFuYEEQQAUsF
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1DCr4DJw47Zw4fXryfXwc_yoWfCr1xpa
        nxZay5KrWrJr4fCr1FqrWrAF1a934xuFnrXay7Gw1xKr9rA3s8WwnrGF1UZF4fAr98KFWU
        XFW5GFW8KFyDGacCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI75rDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingkun Meng <mengyingkun@loongson.cn>

The Loongson ASoC Sound Card is a general ASoC DAI Link driver that
can be used for Loongson CPU DAI drivers and external CODECs.

The driver supports the use of ACPI table to describe device resources.
On loongson 7axxx platforms, the audio device is an ACPI device.

Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
---
 sound/soc/loongson/Kconfig         |  10 ++
 sound/soc/loongson/Makefile        |   4 +
 sound/soc/loongson/loongson_card.c | 237 +++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 sound/soc/loongson/loongson_card.c

diff --git a/sound/soc/loongson/Kconfig b/sound/soc/loongson/Kconfig
index 4478ac91e402..c175f9de19a8 100644
--- a/sound/soc/loongson/Kconfig
+++ b/sound/soc/loongson/Kconfig
@@ -13,4 +13,14 @@ config SND_SOC_LOONGSON_I2S_PCI
 	  The controller is found in loongson bridge chips or SoCs,
 	  and work as a PCI device.
 
+config SND_SOC_LOONGSON_CARD
+	tristate "Loongson Sound Card Driver"
+	select SND_SOC_LOONGSON_I2S_PCI
+	help
+	  Say Y or M if you want to add support for SoC audio using
+	  loongson I2S controller.
+
+	  The driver add support for ALSA SoC Audio support using
+	  loongson I2S controller.
+
 endmenu
diff --git a/sound/soc/loongson/Makefile b/sound/soc/loongson/Makefile
index cfd0de1b1b22..a173a0fe17fe 100644
--- a/sound/soc/loongson/Makefile
+++ b/sound/soc/loongson/Makefile
@@ -2,3 +2,7 @@
 #Platform Support
 snd-soc-loongson-i2s-pci-objs := loongson_i2s_pci.o loongson_i2s.o
 obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PCI) += snd-soc-loongson-i2s-pci.o
+
+#Machine Support
+snd-soc-loongson-card-objs := loongson_card.o
+obj-$(CONFIG_SND_SOC_LOONGSON_CARD) += snd-soc-loongson-card.o
diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loongson_card.c
new file mode 100644
index 000000000000..7f0ce8957a4f
--- /dev/null
+++ b/sound/soc/loongson/loongson_card.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson ASoC Audio driver
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include <sound/pcm_params.h>
+
+static char codec_name[SND_ACPI_I2C_ID_LEN];
+
+struct loongson_card_data {
+	struct snd_soc_card snd_card;
+	unsigned int mclk_fs;
+};
+
+static int loongson_card_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct loongson_card_data *ls_card = snd_soc_card_get_drvdata(rtd->card);
+	int ret, mclk;
+
+	if (ls_card->mclk_fs) {
+		mclk = ls_card->mclk_fs * params_rate(params);
+		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+					     SND_SOC_CLOCK_OUT);
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "cpu_dai clock not set\n");
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					     SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "codec_dai clock not set\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static const struct snd_soc_ops loongson_ops = {
+	.hw_params = loongson_card_hw_params,
+};
+
+SND_SOC_DAILINK_DEFS(analog,
+	DAILINK_COMP_ARRAY(COMP_CPU("loongson-i2s")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link loongson_dai_links[] = {
+	{
+		.name = "HiFi PAIF TX",
+		.stream_name = "Playback",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_IB_NF
+			| SND_SOC_DAIFMT_CBC_CFC,
+		SND_SOC_DAILINK_REG(analog),
+		.ops = &loongson_ops,
+	},
+	{
+		.name = "HiFi PAIF RX",
+		.stream_name = "Capture",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_IB_NF
+			| SND_SOC_DAIFMT_CBC_CFC,
+		SND_SOC_DAILINK_REG(analog),
+		.ops = &loongson_ops,
+	},
+};
+
+static int loongson_card_parse_acpi(struct loongson_card_data *data)
+{
+	struct snd_soc_card *card = &data->snd_card;
+	struct fwnode_handle *fwnode = card->dev->fwnode;
+	struct fwnode_reference_args args;
+	const char *codec_dai_name;
+	struct acpi_device *adev;
+	struct device *phy_dev;
+	int ret, i;
+
+	/* fixup platform name based on reference node */
+	memset(&args, 0, sizeof(args));
+	ret = acpi_node_get_property_reference(fwnode, "cpu", 0, &args);
+	if (ACPI_FAILURE(ret) || !is_acpi_device_node(args.fwnode)) {
+		dev_err(card->dev, "No matching phy in ACPI table\n");
+		return ret;
+	}
+	adev = to_acpi_device_node(args.fwnode);
+	phy_dev = acpi_get_first_physical_node(adev);
+	if (!phy_dev)
+		return -EPROBE_DEFER;
+	for (i = 0; i < card->num_links; i++)
+		loongson_dai_links[i].platforms->name = dev_name(phy_dev);
+
+	/* fixup codec name based on reference node */
+	memset(&args, 0, sizeof(args));
+	ret = acpi_node_get_property_reference(fwnode, "codec", 0, &args);
+	if (ACPI_FAILURE(ret) || !is_acpi_device_node(args.fwnode)) {
+		dev_err(card->dev, "No matching phy in ACPI table\n");
+		return ret;
+	}
+	adev = to_acpi_device_node(args.fwnode);
+	snprintf(codec_name, sizeof(codec_name), "i2c-%s", acpi_dev_name(adev));
+	for (i = 0; i < card->num_links; i++)
+		loongson_dai_links[i].codecs->name = codec_name;
+
+	device_property_read_string(card->dev, "codec-dai-name",
+				    &codec_dai_name);
+	for (i = 0; i < card->num_links; i++)
+		loongson_dai_links[i].codecs->dai_name = codec_dai_name;
+
+	return 0;
+}
+
+static int loongson_card_parse_of(struct loongson_card_data *data)
+{
+	const char *cpu_dai_name, *codec_dai_name;
+	struct device_node *cpu, *codec;
+	struct snd_soc_card *card = &data->snd_card;
+	struct device *dev = card->dev;
+	struct of_phandle_args args;
+	int ret, i;
+
+	cpu = of_get_child_by_name(dev->of_node, "cpu");
+	if (!cpu) {
+		dev_err(dev, "platform property missing or invalid\n");
+		return -EINVAL;
+	}
+	codec = of_get_child_by_name(dev->of_node, "codec");
+	if (!codec) {
+		dev_err(dev, "audio-codec property missing or invalid\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = of_parse_phandle_with_args(cpu, "sound-dai",
+					 "#sound-dai-cells", 0, &args);
+	if (ret) {
+		dev_err(dev, "codec node missing #sound-dai-cells\n");
+		goto err;
+	}
+	for (i = 0; i < card->num_links; i++)
+		loongson_dai_links[i].cpus->of_node = args.np;
+
+	ret = of_parse_phandle_with_args(codec, "sound-dai",
+					 "#sound-dai-cells", 0, &args);
+	if (ret) {
+		dev_err(dev, "codec node missing #sound-dai-cells\n");
+		goto err;
+	}
+	for (i = 0; i < card->num_links; i++)
+		loongson_dai_links[i].codecs->of_node = args.np;
+
+	snd_soc_of_get_dai_name(cpu, &cpu_dai_name);
+	snd_soc_of_get_dai_name(codec, &codec_dai_name);
+	for (i = 0; i < card->num_links; i++) {
+		loongson_dai_links[i].cpus->dai_name = cpu_dai_name;
+		loongson_dai_links[i].codecs->dai_name = codec_dai_name;
+	}
+	of_node_put(cpu);
+	of_node_put(codec);
+
+	return 0;
+
+err:
+	of_node_put(cpu);
+	of_node_put(codec);
+	return ret;
+}
+
+static int loongson_asoc_card_probe(struct platform_device *pdev)
+{
+	struct loongson_card_data *ls_priv;
+	struct snd_soc_card *card;
+	int ret;
+
+	ls_priv = devm_kzalloc(&pdev->dev, sizeof(*ls_priv), GFP_KERNEL);
+	if (!ls_priv)
+		return -ENOMEM;
+
+	card = &ls_priv->snd_card;
+
+	card->dev = &pdev->dev;
+	card->owner = THIS_MODULE;
+	card->dai_link = loongson_dai_links;
+	card->num_links = ARRAY_SIZE(loongson_dai_links);
+	snd_soc_card_set_drvdata(card, ls_priv);
+
+	ret = device_property_read_string(&pdev->dev, "model", &card->name);
+	if (ret) {
+		dev_err(&pdev->dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+	ret = device_property_read_u32(&pdev->dev, "mclk-fs", &ls_priv->mclk_fs);
+	if (ret) {
+		dev_err(&pdev->dev, "Error parsing mclk-fs: %d\n", ret);
+		return ret;
+	}
+
+	if (has_acpi_companion(&pdev->dev))
+		ret = loongson_card_parse_acpi(ls_priv);
+	else
+		ret = loongson_card_parse_of(ls_priv);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+
+	return ret;
+}
+
+static const struct of_device_id loongson_asoc_dt_ids[] = {
+	{ .compatible = "loongson,ls-audio-card" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, loongson_asoc_dt_ids);
+
+static struct platform_driver loongson_audio_driver = {
+	.probe = loongson_asoc_card_probe,
+	.driver = {
+		.name = "loongson-asoc-card",
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = of_match_ptr(loongson_asoc_dt_ids),
+	},
+};
+module_platform_driver(loongson_audio_driver);
+
+MODULE_DESCRIPTION("Loongson ASoc Sound Card driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_LICENSE("GPL");
-- 
2.33.0

