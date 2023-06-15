Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4832673156B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbjFOKdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbjFOKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:33:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E07272E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:33:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so14653225e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686825181; x=1689417181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1HsVsrfhvETgBAemCLuPxBtPh8WFHYrP12bN6GFyYY=;
        b=uMaNCLV11UTwxykENLei2iLrFhvTG8P03O8DJr5lwf8mgNUZQxml1spGRQdw/rjJdi
         vDvDYpdwi+NF8na7ZYC3bqbYBa/U57zA36ok+Sin792TG9mBlvYFLiscpBq4LN8v4tw6
         JBisVOC3J0GK3GJOmY+AIFlIr9VRAMR/bCooKP9bX7HyLhBzAsevIU3DRqh5FMWnm1Ua
         KQ0VHuwlGq6h4aV6I5a326Mflh6A69Rk8daxbDveItUtCJS73fgSU0faXxvBn8gfShWv
         C4VOdWTTP46nfRzWxYgiiUiuIPGlBDsmHhTX7oouTAv29gc9TFdtnuCmLik99H5eDGqs
         7dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825181; x=1689417181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1HsVsrfhvETgBAemCLuPxBtPh8WFHYrP12bN6GFyYY=;
        b=TpJpZ1vXqUyD7R632TqDQip51flezPmkVbesJUCPMi2AFhVJ8QQTneHBKRcPt4HF8d
         sxg+6XLd6YIWHKlDrX9XDLYcTn4VmkIFAL2GLxo1NNwviJQG5ZDZFajPEOqd8614wCDU
         MWYiJSw4DWPiVPvoc+ZvnaABTG/IzGTaWsz3zlw3R1j2wknWU4GZx3Cinz7soJ7Zxf+T
         aV9ZBdHkxgZtbzcTG/sDZGuSCtdAup46flhkWEZ6xcHj12jqSaWI8jgVo/Df1qCpSOrl
         XnekQvvrKPDfMkUHaqgWJ8O5d9zd76xBzmL32kyBSfcyH5DbysnhOjFTYnShKoQIDQe2
         75dA==
X-Gm-Message-State: AC+VfDxs5K0AVcmOTvnMUoNykK2x3X+MCelvuP3UAXOSV9yWKny1Bh3e
        Cxd+n8YoEFwvnqeH0sHPV5qCKg==
X-Google-Smtp-Source: ACHHUZ70BObKAY22u1Fm4yaR0KyM4UzETrTl/M6QqK47BQrTdSWFzs536GwqnDbmm+6UXeAx93scJA==
X-Received: by 2002:a1c:f70a:0:b0:3f5:1728:bde9 with SMTP id v10-20020a1cf70a000000b003f51728bde9mr11621935wmh.2.1686825180711;
        Thu, 15 Jun 2023 03:33:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f17848673fsm20072088wmj.27.2023.06.15.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:33:00 -0700 (PDT)
From:   neil.armstrong@linaro.org
Date:   Thu, 15 Jun 2023 12:32:55 +0200
Subject: [PATCH v4 2/2] usb: typec: add support for the nb7vpq904m Type-C
 Linear Redriver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v4-2-91d5820f3a03@linaro.org>
References: <20230601-topic-sm8x50-upstream-redriver-v4-0-91d5820f3a03@linaro.org>
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v4-0-91d5820f3a03@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16659;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hr5eCT9CJLtsQRZLTzA99fzaKFuLxziSE8cMNrtnvik=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiujZvv9oTg7igQl/2yN84pFrqgw04CTj4Rx6M8qB
 soDBmJ+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIro2QAKCRB33NvayMhJ0bBHEA
 Cd/AXVTJMUPx/3P3XmoOMK0Qs12R0tA7kRwa7oAKeAsXmJU2gIPnb40qEfnwMZyUVOcM/jRyVj5VlN
 DGy7TpITijY0Voo+TAx9DLfd5t0L7ca4FovqRRyX71VLKhAGT2/eQvMb6eUIkvftSUljslevlpKn8M
 R3ouDTcMzgbpl3TP+ot+Nom4HBHwi4O/GsZglZWnJGxiOUyXaXNvETtZqUqfd3+BTGyTs0f1Up3kWy
 hxiw1+qfAxij5EH6OtylSXE9E6lpIY1ECFWXB0esPdZia0HckWtLjqzY5E54GYbv3FgcN1JGspBi1x
 gDZkAt21PqpqAZwkaacwZUCNl5+/7+7XhWHyBSQ8N7D5kBA4Iqqt/+hqXhnjZHi8xulpPiKUzAfdU3
 HRxH7QLWyaNRxbbdU2ik0Eq6+l6fj6oo81DLzUk6QhiAEHbjvcTfFPrSAiYWOUkAFysheUhHW1A2dK
 Dsft4CRT4AdnXcXmMTmNbd1beKLpjbenIY3DvMu2c9FDaCIqj8RtHjANYevZ3ocGH9s7uVfCDFyBNj
 zd34GN9dQTMj22mFY7H3pq9YL1b+CjeF5jUAFh9IFiEl3SgAZs8/dy2Cpp2jzeqlx9Ys3xbjRTYg+Y
 oZqh+ymopMoRh5SoNGYkRpJbfNsFf5DSDWknpsyuJJanBgH8AGcXSIKY3R9w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
and DisplayPort ALT Mode Linear Redriver chip found on some devices
with a Type-C port.

The redriver compensates ultra High-Speeed DisplayPort and USB
Super Speed signal integrity losses mainly due to PCB & transmission
cables.

The redriver doesn't support SuperSpeed lines swapping, but
can support Type-C SBU lines swapping.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/mux/Kconfig      |   8 +
 drivers/usb/typec/mux/Makefile     |   1 +
 drivers/usb/typec/mux/nb7vpq904m.c | 529 +++++++++++++++++++++++++++++++++++++
 3 files changed, 538 insertions(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index c46fa4f9d3df..8c4d6b8fb75c 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -35,4 +35,12 @@ config TYPEC_MUX_INTEL_PMC
 	  control the USB role switch and also the multiplexer/demultiplexer
 	  switches used with USB Type-C Alternate Modes.
 
+config TYPEC_MUX_NB7VPQ904M
+	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
+	  redriver chip found on some devices with a Type-C port.
+
 endmenu
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index dda67e19b58b..76196096ef41 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_TYPEC_MUX_FSA4480)		+= fsa4480.o
 obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
+obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
new file mode 100644
index 000000000000..80e580d50129
--- /dev/null
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * OnSemi NB7VPQ904M Type-C driver
+ *
+ * Copyright (C) 2023 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/of_graph.h>
+#include <drm/drm_bridge.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#define NB7_CHNA		0
+#define NB7_CHNB		1
+#define NB7_CHNC		2
+#define NB7_CHND		3
+#define NB7_IS_CHAN_AD(channel) (channel == NB7_CHNA || channel == NB7_CHND)
+
+#define GEN_DEV_SET_REG			0x00
+
+#define GEN_DEV_SET_CHIP_EN		BIT(0)
+#define GEN_DEV_SET_CHNA_EN		BIT(4)
+#define GEN_DEV_SET_CHNB_EN		BIT(5)
+#define GEN_DEV_SET_CHNC_EN		BIT(6)
+#define GEN_DEV_SET_CHND_EN		BIT(7)
+
+#define GEN_DEV_SET_OP_MODE_MASK	GENMASK(3, 1)
+
+#define GEN_DEV_SET_OP_MODE_DP_CC2	0
+#define GEN_DEV_SET_OP_MODE_DP_CC1	1
+#define GEN_DEV_SET_OP_MODE_DP_4LANE	2
+#define GEN_DEV_SET_OP_MODE_USB		5
+
+#define EQ_SETTING_REG_BASE		0x01
+#define EQ_SETTING_REG(n)		(EQ_SETTING_REG_BASE + (n) * 2)
+#define EQ_SETTING_MASK			GENMASK(3, 1)
+
+#define OUTPUT_COMPRESSION_AND_POL_REG_BASE	0x02
+#define OUTPUT_COMPRESSION_AND_POL_REG(n)	(OUTPUT_COMPRESSION_AND_POL_REG_BASE + (n) * 2)
+#define OUTPUT_COMPRESSION_MASK		GENMASK(2, 1)
+
+#define FLAT_GAIN_REG_BASE		0x18
+#define FLAT_GAIN_REG(n)		(FLAT_GAIN_REG_BASE + (n) * 2)
+#define FLAT_GAIN_MASK			GENMASK(1, 0)
+
+#define LOSS_MATCH_REG_BASE		0x19
+#define LOSS_MATCH_REG(n)		(LOSS_MATCH_REG_BASE + (n) * 2)
+#define LOSS_MATCH_MASK			GENMASK(1, 0)
+
+#define AUX_CC_REG			0x09
+
+#define CHIP_VERSION_REG		0x17
+
+struct nb7vpq904m {
+	struct i2c_client *client;
+	struct gpio_desc *enable_gpio;
+	struct regulator *vcc_supply;
+	struct regmap *regmap;
+	struct typec_switch_dev *sw;
+	struct typec_retimer *retimer;
+
+	bool swap_data_lanes;
+	struct typec_switch *typec_switch;
+
+	struct drm_bridge bridge;
+
+	struct mutex lock; /* protect non-concurrent retimer & switch */
+
+	enum typec_orientation orientation;
+	unsigned long mode;
+	unsigned int svid;
+};
+
+static void nb7vpq904m_set_channel(struct nb7vpq904m *nb7, unsigned int channel, bool dp)
+{
+	u8 eq, out_comp, flat_gain, loss_match;
+
+	if (dp) {
+		eq = NB7_IS_CHAN_AD(channel) ? 0x6 : 0x4;
+		out_comp = 0x3;
+		flat_gain = NB7_IS_CHAN_AD(channel) ? 0x2 : 0x1;
+		loss_match = 0x3;
+	} else {
+		eq = 0x4;
+		out_comp = 0x3;
+		flat_gain = NB7_IS_CHAN_AD(channel) ? 0x3 : 0x1;
+		loss_match = NB7_IS_CHAN_AD(channel) ? 0x1 : 0x3;
+	}
+
+	regmap_update_bits(nb7->regmap, EQ_SETTING_REG(channel),
+			   EQ_SETTING_MASK, FIELD_PREP(EQ_SETTING_MASK, eq));
+	regmap_update_bits(nb7->regmap, OUTPUT_COMPRESSION_AND_POL_REG(channel),
+			   OUTPUT_COMPRESSION_MASK, FIELD_PREP(OUTPUT_COMPRESSION_MASK, out_comp));
+	regmap_update_bits(nb7->regmap, FLAT_GAIN_REG(channel),
+			   FLAT_GAIN_MASK, FIELD_PREP(FLAT_GAIN_MASK, flat_gain));
+	regmap_update_bits(nb7->regmap, LOSS_MATCH_REG(channel),
+			   LOSS_MATCH_MASK, FIELD_PREP(LOSS_MATCH_MASK, loss_match));
+}
+
+static int nb7vpq904m_set(struct nb7vpq904m *nb7)
+{
+	bool reverse = (nb7->orientation == TYPEC_ORIENTATION_REVERSE);
+
+	switch (nb7->mode) {
+	case TYPEC_STATE_SAFE:
+		regmap_write(nb7->regmap, GEN_DEV_SET_REG,
+			     GEN_DEV_SET_CHIP_EN |
+			     GEN_DEV_SET_CHNA_EN |
+			     GEN_DEV_SET_CHNB_EN |
+			     GEN_DEV_SET_CHNC_EN |
+			     GEN_DEV_SET_CHND_EN |
+			     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
+					GEN_DEV_SET_OP_MODE_USB));
+		nb7vpq904m_set_channel(nb7, NB7_CHNA, false);
+		nb7vpq904m_set_channel(nb7, NB7_CHNB, false);
+		nb7vpq904m_set_channel(nb7, NB7_CHNC, false);
+		nb7vpq904m_set_channel(nb7, NB7_CHND, false);
+		regmap_write(nb7->regmap, AUX_CC_REG, 0x2);
+
+		return 0;
+
+	case TYPEC_STATE_USB:
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> USB RX
+		 * B -> USB TX
+		 * C -> X
+		 * D -> X
+		 * Flipped Orientation (CC2)
+		 * A -> X
+		 * B -> X
+		 * C -> USB TX
+		 * D -> USB RX
+		 *
+		 * Reversed if data lanes are swapped
+		 */
+		if (reverse ^ nb7->swap_data_lanes) {
+			regmap_write(nb7->regmap, GEN_DEV_SET_REG,
+				     GEN_DEV_SET_CHIP_EN |
+				     GEN_DEV_SET_CHNA_EN |
+				     GEN_DEV_SET_CHNB_EN |
+				     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
+						GEN_DEV_SET_OP_MODE_USB));
+			nb7vpq904m_set_channel(nb7, NB7_CHNA, false);
+			nb7vpq904m_set_channel(nb7, NB7_CHNB, false);
+		} else {
+			regmap_write(nb7->regmap, GEN_DEV_SET_REG,
+				     GEN_DEV_SET_CHIP_EN |
+				     GEN_DEV_SET_CHNC_EN |
+				     GEN_DEV_SET_CHND_EN |
+				     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
+						GEN_DEV_SET_OP_MODE_USB));
+			nb7vpq904m_set_channel(nb7, NB7_CHNC, false);
+			nb7vpq904m_set_channel(nb7, NB7_CHND, false);
+		}
+		regmap_write(nb7->regmap, AUX_CC_REG, 0x2);
+
+		return 0;
+
+	default:
+		if (nb7->svid != USB_TYPEC_DP_SID)
+			return -EINVAL;
+
+		break;
+	}
+
+	/* DP Altmode Setup */
+
+	regmap_write(nb7->regmap, AUX_CC_REG, reverse ? 0x1 : 0x0);
+
+	switch (nb7->mode) {
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> DP3
+		 * B -> DP2
+		 * C -> DP1
+		 * D -> DP0
+		 * Flipped Orientation (CC2)
+		 * A -> DP0
+		 * B -> DP1
+		 * C -> DP2
+		 * D -> DP3
+		 */
+		regmap_write(nb7->regmap, GEN_DEV_SET_REG,
+			     GEN_DEV_SET_CHIP_EN |
+			     GEN_DEV_SET_CHNA_EN |
+			     GEN_DEV_SET_CHNB_EN |
+			     GEN_DEV_SET_CHNC_EN |
+			     GEN_DEV_SET_CHND_EN |
+			     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
+					GEN_DEV_SET_OP_MODE_DP_4LANE));
+		nb7vpq904m_set_channel(nb7, NB7_CHNA, true);
+		nb7vpq904m_set_channel(nb7, NB7_CHNB, true);
+		nb7vpq904m_set_channel(nb7, NB7_CHNC, true);
+		nb7vpq904m_set_channel(nb7, NB7_CHND, true);
+		break;
+
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_F:
+		regmap_write(nb7->regmap, GEN_DEV_SET_REG,
+			     GEN_DEV_SET_CHIP_EN |
+			     GEN_DEV_SET_CHNA_EN |
+			     GEN_DEV_SET_CHNB_EN |
+			     GEN_DEV_SET_CHNC_EN |
+			     GEN_DEV_SET_CHND_EN |
+			     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
+					reverse ^ nb7->swap_data_lanes ?
+						GEN_DEV_SET_OP_MODE_DP_CC2
+						: GEN_DEV_SET_OP_MODE_DP_CC1));
+
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> USB RX
+		 * B -> USB TX
+		 * C -> DP1
+		 * D -> DP0
+		 * Flipped Orientation (CC2)
+		 * A -> DP0
+		 * B -> DP1
+		 * C -> USB TX
+		 * D -> USB RX
+		 *
+		 * Reversed if data lanes are swapped
+		 */
+		if (nb7->swap_data_lanes) {
+			nb7vpq904m_set_channel(nb7, NB7_CHNA, !reverse);
+			nb7vpq904m_set_channel(nb7, NB7_CHNB, !reverse);
+			nb7vpq904m_set_channel(nb7, NB7_CHNC, reverse);
+			nb7vpq904m_set_channel(nb7, NB7_CHND, reverse);
+		} else {
+			nb7vpq904m_set_channel(nb7, NB7_CHNA, reverse);
+			nb7vpq904m_set_channel(nb7, NB7_CHNB, reverse);
+			nb7vpq904m_set_channel(nb7, NB7_CHNC, !reverse);
+			nb7vpq904m_set_channel(nb7, NB7_CHND, !reverse);
+		}
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int nb7vpq904m_sw_set(struct typec_switch_dev *sw, enum typec_orientation orientation)
+{
+	struct nb7vpq904m *nb7 = typec_switch_get_drvdata(sw);
+	int ret;
+
+	ret = typec_switch_set(nb7->typec_switch, orientation);
+	if (ret)
+		return ret;
+
+	mutex_lock(&nb7->lock);
+
+	if (nb7->orientation != orientation) {
+		nb7->orientation = orientation;
+
+		ret = nb7vpq904m_set(nb7);
+	}
+
+	mutex_unlock(&nb7->lock);
+
+	return ret;
+}
+
+static int nb7vpq904m_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
+{
+	struct nb7vpq904m *nb7 = typec_retimer_get_drvdata(retimer);
+	int ret = 0;
+
+	mutex_lock(&nb7->lock);
+
+	if (nb7->mode != state->mode) {
+		nb7->mode = state->mode;
+
+		if (state->alt)
+			nb7->svid = state->alt->svid;
+		else
+			nb7->svid = 0; // No SVID
+
+		ret = nb7vpq904m_set(nb7);
+	}
+
+	mutex_unlock(&nb7->lock);
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
+static int nb7vpq904m_bridge_attach(struct drm_bridge *bridge,
+				    enum drm_bridge_attach_flags flags)
+{
+	struct nb7vpq904m *nb7 = container_of(bridge, struct nb7vpq904m, bridge);
+	struct drm_bridge *next_bridge;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
+
+	next_bridge = devm_drm_of_get_bridge(&nb7->client->dev, nb7->client->dev.of_node, 0, 0);
+	if (IS_ERR(next_bridge)) {
+		dev_err(&nb7->client->dev, "failed to acquire drm_bridge: %pe\n", next_bridge);
+		return PTR_ERR(next_bridge);
+	}
+
+	return drm_bridge_attach(bridge->encoder, next_bridge, bridge,
+				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+}
+
+static const struct drm_bridge_funcs nb7vpq904m_bridge_funcs = {
+	.attach	= nb7vpq904m_bridge_attach,
+};
+
+static int nb7vpq904m_register_bridge(struct nb7vpq904m *nb7)
+{
+	nb7->bridge.funcs = &nb7vpq904m_bridge_funcs;
+	nb7->bridge.of_node = nb7->client->dev.of_node;
+
+	return devm_drm_bridge_add(&nb7->client->dev, &nb7->bridge);
+}
+#else
+static int nb7vpq904m_register_bridge(struct nb7vpq904m *nb7)
+{
+	return 0;
+}
+#endif
+
+static const struct regmap_config nb7_regmap = {
+	.max_register = 0x1f,
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+enum {
+	NORMAL_LANE_MAPPING,
+	INVERT_LANE_MAPPING,
+};
+
+#define DATA_LANES_COUNT	4
+
+static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
+	[NORMAL_LANE_MAPPING] = { 0, 1, 2, 3 },
+	[INVERT_LANE_MAPPING] = { 3, 2, 1, 0 },
+};
+
+static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
+{
+	struct device_node *ep;
+	u32 data_lanes[4];
+	int ret, i, j;
+
+	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
+
+	if (ep) {
+		ret = of_property_count_u32_elems(ep, "data-lanes");
+		if (ret == -EINVAL)
+			/* Property isn't here, consider default mapping */
+			goto out_done;
+		if (ret < 0)
+			goto out_error;
+
+		if (ret != DATA_LANES_COUNT) {
+			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
+			ret = -EINVAL;
+			goto out_error;
+		}
+
+		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+		if (ret)
+			goto out_error;
+
+		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+			for (j = 0; j < DATA_LANES_COUNT; j++) {
+				if (data_lanes[j] != supported_data_lane_mapping[i][j])
+					break;
+			}
+
+			if (j == DATA_LANES_COUNT)
+				break;
+		}
+
+		switch (i) {
+		case NORMAL_LANE_MAPPING:
+			break;
+		case INVERT_LANE_MAPPING:
+			nb7->swap_data_lanes = true;
+			dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+			break;
+		default:
+			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
+			ret = -EINVAL;
+			goto out_error;
+		}
+	}
+
+out_done:
+	ret = 0;
+
+out_error:
+	of_node_put(ep);
+
+	return ret;
+}
+
+static int nb7vpq904m_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc = { };
+	struct typec_retimer_desc retimer_desc = { };
+	struct nb7vpq904m *nb7;
+	int ret;
+
+	nb7 = devm_kzalloc(dev, sizeof(*nb7), GFP_KERNEL);
+	if (!nb7)
+		return -ENOMEM;
+
+	nb7->client = client;
+
+	nb7->regmap = devm_regmap_init_i2c(client, &nb7_regmap);
+	if (IS_ERR(nb7->regmap)) {
+		dev_err(&client->dev, "Failed to allocate register map\n");
+		return PTR_ERR(nb7->regmap);
+	}
+
+	nb7->mode = TYPEC_STATE_SAFE;
+	nb7->orientation = TYPEC_ORIENTATION_NONE;
+
+	mutex_init(&nb7->lock);
+
+	nb7->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(nb7->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(nb7->enable_gpio),
+				     "unable to acquire enable gpio\n");
+
+	nb7->vcc_supply = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(nb7->vcc_supply))
+		return PTR_ERR(nb7->vcc_supply);
+
+	nb7->typec_switch = fwnode_typec_switch_get(dev->fwnode);
+	if (IS_ERR(nb7->typec_switch))
+		return dev_err_probe(dev, PTR_ERR(nb7->typec_switch),
+				     "failed to acquire orientation-switch\n");
+
+	ret = nb7vpq904m_parse_data_lanes_mapping(nb7);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(nb7->vcc_supply);
+	if (ret)
+		dev_warn(dev, "Failed to enable vcc: %d\n", ret);
+
+	gpiod_set_value(nb7->enable_gpio, 1);
+
+	ret = nb7vpq904m_register_bridge(nb7);
+	if (ret)
+		return ret;
+
+	sw_desc.drvdata = nb7;
+	sw_desc.fwnode = dev->fwnode;
+	sw_desc.set = nb7vpq904m_sw_set;
+
+	nb7->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(nb7->sw))
+		return dev_err_probe(dev, PTR_ERR(nb7->sw),
+				     "Error registering typec switch\n");
+
+	retimer_desc.drvdata = nb7;
+	retimer_desc.fwnode = dev->fwnode;
+	retimer_desc.set = nb7vpq904m_retimer_set;
+
+	nb7->retimer = typec_retimer_register(dev, &retimer_desc);
+	if (IS_ERR(nb7->retimer)) {
+		typec_switch_unregister(nb7->sw);
+		return dev_err_probe(dev, PTR_ERR(nb7->retimer),
+				     "Error registering typec retimer\n");
+	}
+
+	return 0;
+}
+
+static void nb7vpq904m_remove(struct i2c_client *client)
+{
+	struct nb7vpq904m *nb7 = i2c_get_clientdata(client);
+
+	typec_retimer_unregister(nb7->retimer);
+	typec_switch_unregister(nb7->sw);
+
+	gpiod_set_value(nb7->enable_gpio, 0);
+
+	regulator_disable(nb7->vcc_supply);
+}
+
+static const struct i2c_device_id nb7vpq904m_table[] = {
+	{ "nb7vpq904m" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nb7vpq904m_table);
+
+static const struct of_device_id nb7vpq904m_of_table[] = {
+	{ .compatible = "onnn,nb7vpq904m" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nb7vpq904m_of_table);
+
+static struct i2c_driver nb7vpq904m_driver = {
+	.driver = {
+		.name = "nb7vpq904m",
+		.of_match_table = nb7vpq904m_of_table,
+	},
+	.probe_new	= nb7vpq904m_probe,
+	.remove		= nb7vpq904m_remove,
+	.id_table	= nb7vpq904m_table,
+};
+
+module_i2c_driver(nb7vpq904m_driver);
+
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
+MODULE_DESCRIPTION("OnSemi NB7VPQ904M Type-C driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

