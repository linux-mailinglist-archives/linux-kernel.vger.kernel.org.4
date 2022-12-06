Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2B643AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiLFBsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiLFBsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:48:32 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92812AD8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:48:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3c9960ad866so140162967b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 17:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ona3nQhBrLZaaG1x9qU+YFP1W+urJRD03FwSRumD8gY=;
        b=A9qtxOI/Tdaj12nkeMWSvyYXEDRYdvwR9ZNvaD3X4xeDj3Q/gr9YExgaHfl6/7CVp4
         IiBEuEYJodQbCTRISUhhLld+xQXoGm1Uai+faW3X26A2qk+DRP2/p44ABbpaaBOafmWZ
         bLaGGv80EP0wniY2zoH8EDYHoDR92aEHUC3uVkQatTPyeWFEqfnkBh55xXjG1NqTWTRj
         UItTrOybrYfAUF4eeFm87KNPpuJgj4UCoRjRE4B+WhgBgCXGrptlrwBy9ug5WfhrGMEC
         Xe88y7LWF5q6t8921RfFoyJXYnWQsRDzYkB0xZrgofTBBlMAJrdPaKsoyobdivL51ykE
         Wn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ona3nQhBrLZaaG1x9qU+YFP1W+urJRD03FwSRumD8gY=;
        b=Q/jyI+IvFijezFx0z41o1BPpAP6gjGG+Aajg4rO77wR3HbiRbAyvEUgmKmdyWCZqFs
         ENb37rwR43I5hc2fpbgJqvmixy+Swh9HVZktI++t4yFibYud5Ds7qEeTENAR83dd3I2T
         S/cT9dUbQf7FCm5+4UgT9umiOppaRS8zXA+PrYAuCItw+uOXaWzAUoEiTsS4Ou49xkzT
         Rn5vZDASuaLm2yybC+gBVBGR2uKKtq6M+sYkIMXTRzUU1L20dchZKyTqs6A70ZysCyT0
         1vyaFsfWLjYRRc1wDsEd4iNhA0IrfArCCeYEKGObOMaTBmrOHfELBGBZmhYGAyJFLYge
         T2Jg==
X-Gm-Message-State: ANoB5pmqPSb8sNbvda2+ZpITSNGpEwlI2n/VVH+fzPhS95Bk6i7odmhn
        jIu/TVg0Soj3gtbTK1/NL/Kb8q1e5ek=
X-Google-Smtp-Source: AA0mqf4TxJ6SLgxeM9J8xo2oTCf3oCc6zEsb7PNWb2Mzf0cWVRRrct4FgLR/l9ubhN9QaM+GbzAeh3R1aIg=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:8c86:3c57:a044:cb9])
 (user=badhri job=sendgmr) by 2002:a25:8:0:b0:6f2:2d25:6623 with SMTP id
 8-20020a250008000000b006f22d256623mr49805461yba.481.1670291309822; Mon, 05
 Dec 2022 17:48:29 -0800 (PST)
Date:   Mon,  5 Dec 2022 17:48:22 -0800
In-Reply-To: <20221206014822.4105421-1-badhri@google.com>
Mime-Version: 1.0
References: <20221206014822.4105421-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206014822.4105421-3-badhri@google.com>
Subject: [PATCH v4 3/3] usb: typec: maxim_contaminant: Implement
 check_contaminant callback
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim TCPC has additional ADCs and low current(1ua) current source
to measure the impedance of CC and SBU pins. When tcpm invokes
the check_contaminant callback, Maxim TCPC measures the impedance
of the CC & SBU pins and when the impedance measured is less than
1MOhm, it is assumed that USB-C port is contaminated. CC comparators
are also checked to differentiate between presence of sink and
contaminant. Once USB-C is deemed to be contaminated, MAXIM TCPC
has additional hardware to disable normal DRP toggling cycle and
enable 1ua on CC pins once every 2.4secs/4.8secs. Maxim TCPC
interrupts AP once the impedance on the CC pin is above the
1MOhm threshold. The Maxim tcpc driver then signals TCPM_PORT_CLEAN
to restart toggling.

Renaming tcpci_maxim.c to tcpci_maxim_core.c and moving reg read/write
helper functions to the tcpci_maxim.h header file.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v3:
* Renamed functions and removed the unecessary EXPORT.
* Fixed ktest robot warning.
Changes since v2:
* Implemented is_potential_contaminant to offload
* disconnect_while_debouncing
Changes since v1:
* Renamed tcpci_maxim.c to tcpci_maxim_core.c and compiling
  tcpci_maxim_core.o with maxim_contaminant.o as a single module
  as suggested by Guenter Roeck
* Got rid of exporting symbols for reg read/write helper functions
  and moved them to header as suggested by Heikki Krogerus
* Sqashed the commit which exposed the max_tcpci_read helper functions
  into this one.
---
 drivers/usb/typec/tcpm/Makefile               |   1 +
 drivers/usb/typec/tcpm/maxim_contaminant.c    | 338 ++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h          |  91 +++++
 .../{tcpci_maxim.c => tcpci_maxim_core.c}     |  78 ++--
 4 files changed, 476 insertions(+), 32 deletions(-)
 create mode 100644 drivers/usb/typec/tcpm/maxim_contaminant.c
 create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.h
 rename drivers/usb/typec/tcpm/{tcpci_maxim.c => tcpci_maxim_core.c} (89%)

diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
index 906d9dced8e7..08e57bb499cb 100644
--- a/drivers/usb/typec/tcpm/Makefile
+++ b/drivers/usb/typec/tcpm/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
 obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
 obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
 obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
+tcpci_maxim-y				+= tcpci_maxim_core.o maxim_contaminant.o
diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
new file mode 100644
index 000000000000..6eb11fb33715
--- /dev/null
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 Google, Inc
+ *
+ * USB-C module to reduce wakeups due to contaminants.
+ */
+
+#include <linux/device.h>
+#include <linux/irqreturn.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/usb/tcpci.h>
+#include <linux/usb/tcpm.h>
+#include <linux/usb/typec.h>
+
+#include "tcpci_maxim.h"
+
+enum fladc_select {
+	CC1_SCALE1 = 1,
+	CC1_SCALE2,
+	CC2_SCALE1,
+	CC2_SCALE2,
+	SBU1,
+	SBU2,
+};
+
+#define FLADC_1uA_LSB_MV		25
+/* High range CC */
+#define FLADC_CC_HIGH_RANGE_LSB_MV	208
+/* Low range CC */
+#define FLADC_CC_LOW_RANGE_LSB_MV      126
+
+/* 1uA current source */
+#define FLADC_CC_SCALE1			1
+/* 5 uA current source */
+#define FLADC_CC_SCALE2			5
+
+#define FLADC_1uA_CC_OFFSET_MV		300
+#define FLADC_CC_HIGH_RANGE_OFFSET_MV	624
+#define FLADC_CC_LOW_RANGE_OFFSET_MV	378
+
+#define CONTAMINANT_THRESHOLD_SBU_K	1000
+#define	CONTAMINANT_THRESHOLD_CC_K	1000
+
+#define READ1_SLEEP_MS			10
+#define READ2_SLEEP_MS			5
+
+#define STATUS_CHECK(reg, mask, val)	(((reg) & (mask)) == (val))
+
+#define IS_CC_OPEN(cc_status) \
+	(STATUS_CHECK((cc_status), TCPC_CC_STATUS_CC1_MASK << TCPC_CC_STATUS_CC1_SHIFT,  \
+		      TCPC_CC_STATE_SRC_OPEN) && STATUS_CHECK((cc_status),               \
+							      TCPC_CC_STATUS_CC2_MASK << \
+							      TCPC_CC_STATUS_CC2_SHIFT,  \
+							      TCPC_CC_STATE_SRC_OPEN))
+
+static int max_contaminant_adc_to_mv(struct max_tcpci_chip *chip, enum fladc_select channel,
+				     bool ua_src, u8 fladc)
+{
+	/* SBU channels only have 1 scale with 1uA. */
+	if ((ua_src && (channel == CC1_SCALE2 || channel == CC2_SCALE2 || channel == SBU1 ||
+			channel == SBU2)))
+		/* Mean of range */
+		return FLADC_1uA_CC_OFFSET_MV + (fladc * FLADC_1uA_LSB_MV);
+	else if (!ua_src && (channel == CC1_SCALE1 || channel == CC2_SCALE1))
+		return FLADC_CC_HIGH_RANGE_OFFSET_MV + (fladc * FLADC_CC_HIGH_RANGE_LSB_MV);
+	else if (!ua_src && (channel == CC1_SCALE2 || channel == CC2_SCALE2))
+		return FLADC_CC_LOW_RANGE_OFFSET_MV + (fladc * FLADC_CC_LOW_RANGE_LSB_MV);
+
+	dev_err(chip->dev, "ADC ERROR: SCALE UNKNOWN");
+
+	return -EINVAL;
+}
+
+static int max_contaminant_read_adc_mv(struct max_tcpci_chip *chip, enum fladc_select channel,
+				       int sleep_msec, bool raw, bool ua_src)
+{
+	struct regmap *regmap = chip->data.regmap;
+	u8 fladc;
+	int ret;
+
+	/* Channel & scale select */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL_MASK,
+				 channel << ADC_CHANNEL_OFFSET);
+	if (ret < 0)
+		return ret;
+
+	/* Enable ADC */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCEN, ADCEN);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(sleep_msec * 1000, (sleep_msec + 1) * 1000);
+	ret = max_tcpci_read8(chip, TCPC_VENDOR_FLADC_STATUS, &fladc);
+	if (ret < 0)
+		return ret;
+
+	/* Disable ADC */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCEN, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL_MASK, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!raw)
+		return max_contaminant_adc_to_mv(chip, channel, ua_src, fladc);
+	else
+		return fladc;
+}
+
+static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
+						enum fladc_select channel, int sleep_msec, bool raw)
+{
+	struct regmap *regmap = chip->data.regmap;
+	int mv;
+	int ret;
+
+	if (channel == CC1_SCALE1 || channel == CC2_SCALE1 || channel == CC1_SCALE2 ||
+	    channel == CC2_SCALE2) {
+		/* Enable 1uA current source */
+		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
+					 ULTRA_LOW_POWER_MODE);
+		if (ret < 0)
+			return ret;
+
+		/* Enable 1uA current source */
+		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, UA_1_SRC);
+		if (ret < 0)
+			return ret;
+
+		/* OVP disable */
+		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCOVPDIS, CCOVPDIS);
+		if (ret < 0)
+			return ret;
+
+		mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
+		/* OVP enable */
+		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCOVPDIS, 0);
+		if (ret < 0)
+			return ret;
+		/* returns KOhm as 1uA source is used. */
+		return mv;
+	}
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBUOVPDIS, SBUOVPDIS);
+	if (ret < 0)
+		return ret;
+
+	/* SBU switches auto configure when channel is selected. */
+	/* Enable 1ua current source */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBURPCTRL, SBURPCTRL);
+	if (ret < 0)
+		return ret;
+
+	mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
+	/* Disable current source */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBURPCTRL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* OVP disable */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBUOVPDIS, 0);
+	if (ret < 0)
+		return ret;
+
+	return mv;
+}
+
+static void max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *vendor_cc_status2_cc1,
+					     u8 *vendor_cc_status2_cc2)
+{
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
+
+	/* Enable 80uA source */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, UA_80_SRC);
+	if (ret < 0)
+		return;
+
+	/* Enable comparators */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCOMPEN, CCCOMPEN);
+	if (ret < 0)
+		return;
+
+	/* Sleep to allow comparators settle */
+	usleep_range(5000, 6000);
+	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC1);
+	if (ret < 0)
+		return;
+
+	usleep_range(5000, 6000);
+	ret = max_tcpci_read8(chip, VENDOR_CC_STATUS2, vendor_cc_status2_cc1);
+	if (ret < 0)
+		return;
+
+	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC2);
+	if (ret < 0)
+		return;
+
+	usleep_range(5000, 6000);
+	ret = max_tcpci_read8(chip, VENDOR_CC_STATUS2, vendor_cc_status2_cc2);
+	if (ret < 0)
+		return;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCOMPEN, 0);
+	if (ret < 0)
+		return;
+	regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, 0);
+}
+
+static int max_contaminant_detect_contaminant(struct max_tcpci_chip *chip)
+{
+	int cc1_k, cc2_k, sbu1_k, sbu2_k;
+	u8 vendor_cc_status2_cc1 = 0xff, vendor_cc_status2_cc2 = 0xff;
+	u8 role_ctrl = 0, role_ctrl_backup = 0;
+	int inferred_state = NOT_DETECTED;
+
+	max_tcpci_read8(chip, TCPC_ROLE_CTRL, &role_ctrl);
+	role_ctrl_backup = role_ctrl;
+	role_ctrl = 0x0F;
+	max_tcpci_write8(chip, TCPC_ROLE_CTRL, role_ctrl);
+
+	cc1_k = max_contaminant_read_resistance_kohm(chip, CC1_SCALE2, READ1_SLEEP_MS, false);
+	cc2_k = max_contaminant_read_resistance_kohm(chip, CC2_SCALE2, READ2_SLEEP_MS, false);
+
+	sbu1_k = max_contaminant_read_resistance_kohm(chip, SBU1, READ1_SLEEP_MS, false);
+	sbu2_k = max_contaminant_read_resistance_kohm(chip, SBU2, READ2_SLEEP_MS, false);
+	max_contaminant_read_comparators(chip, &vendor_cc_status2_cc1, &vendor_cc_status2_cc2);
+
+	if ((!(CC1_VUFP_RD0P5 & vendor_cc_status2_cc1) ||
+	     !(CC2_VUFP_RD0P5 & vendor_cc_status2_cc2)) &&
+	    !(CC1_VUFP_RD0P5 & vendor_cc_status2_cc1 && CC2_VUFP_RD0P5 & vendor_cc_status2_cc2))
+		inferred_state = SINK;
+	else if ((cc1_k < CONTAMINANT_THRESHOLD_CC_K || cc2_k < CONTAMINANT_THRESHOLD_CC_K) &&
+		 (sbu1_k < CONTAMINANT_THRESHOLD_SBU_K || sbu2_k < CONTAMINANT_THRESHOLD_SBU_K))
+		inferred_state = DETECTED;
+
+	if (inferred_state == NOT_DETECTED)
+		max_tcpci_write8(chip, TCPC_ROLE_CTRL, role_ctrl_backup);
+	else
+		max_tcpci_write8(chip, TCPC_ROLE_CTRL, (TCPC_ROLE_CTRL_DRP | 0xA));
+
+	return inferred_state;
+}
+
+static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
+{
+	struct regmap *regmap = chip->data.regmap;
+	u8 temp;
+	int ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL3, CCWTRDEB_MASK | CCWTRSEL_MASK
+				    | WTRCYCLE_MASK, CCWTRDEB_1MS << CCWTRDEB_SHIFT |
+				    CCWTRSEL_1V << CCWTRSEL_SHIFT | WTRCYCLE_4_8_S <<
+				    WTRCYCLE_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_ROLE_CTRL, TCPC_ROLE_CTRL_DRP, TCPC_ROLE_CTRL_DRP);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCONNDRY, CCCONNDRY);
+	if (ret < 0)
+		return ret;
+	ret = max_tcpci_read8(chip, TCPC_VENDOR_CC_CTRL1, &temp);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
+				 ULTRA_LOW_POWER_MODE);
+	if (ret < 0)
+		return ret;
+	ret = max_tcpci_read8(chip, TCPC_VENDOR_CC_CTRL2, &temp);
+	if (ret < 0)
+		return ret;
+
+	/* Enable Look4Connection before sending the command */
+	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_EN_LK4CONN_ALRT,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT);
+	if (ret < 0)
+		return ret;
+
+	ret = max_tcpci_write8(chip, TCPC_COMMAND, TCPC_CMD_LOOK4CONNECTION);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce)
+{
+	u8 cc_status, pwr_cntl;
+	enum contamiant_state state;
+
+	max_tcpci_read8(chip, TCPC_CC_STATUS, &cc_status);
+	max_tcpci_read8(chip, TCPC_POWER_CTRL, &pwr_cntl);
+
+	if (chip->contaminant_state == NOT_DETECTED || chip->contaminant_state == SINK) {
+		if (!disconnect_while_debounce)
+			msleep(100);
+
+		max_tcpci_read8(chip, TCPC_CC_STATUS, &cc_status);
+		if (IS_CC_OPEN(cc_status)) {
+			u8 role_ctrl, role_ctrl_backup;
+
+			max_tcpci_read8(chip, TCPC_ROLE_CTRL, &role_ctrl);
+			role_ctrl_backup = role_ctrl;
+			role_ctrl |= 0x0F;
+			role_ctrl &= ~(TCPC_ROLE_CTRL_DRP);
+			max_tcpci_write8(chip, TCPC_ROLE_CTRL, role_ctrl);
+
+			chip->contaminant_state = max_contaminant_detect_contaminant(chip);
+
+			max_tcpci_write8(chip, TCPC_ROLE_CTRL, role_ctrl_backup);
+			if (state == DETECTED) {
+				max_contaminant_enable_dry_detection(chip);
+				return true;
+			}
+		}
+		return false;
+	} else if (chip->contaminant_state == DETECTED) {
+		if (STATUS_CHECK(cc_status, TCPC_CC_STATUS_TOGGLING, 0)) {
+			chip->contaminant_state = max_contaminant_detect_contaminant(chip);
+			if (state == DETECTED) {
+				max_contaminant_enable_dry_detection(chip);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+MODULE_DESCRIPTION("MAXIM TCPC CONTAMINANT Module");
+MODULE_AUTHOR("Badhri Jagan Sridharan <badhri@google.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
new file mode 100644
index 000000000000..1a78e1ac3820
--- /dev/null
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2022 Google, Inc
+ *
+ * MAXIM TCPC header file.
+ */
+#ifndef TCPCI_MAXIM_H_
+#define TCPCI_MAXIM_H_
+
+#define VENDOR_CC_STATUS2                       0x85
+#define CC1_VUFP_RD0P5                          BIT(1)
+#define CC2_VUFP_RD0P5                          BIT(5)
+#define TCPC_VENDOR_FLADC_STATUS                0x89
+
+#define TCPC_VENDOR_CC_CTRL1                    0x8c
+#define CCCONNDRY                               BIT(7)
+#define CCCOMPEN                                BIT(5)
+
+#define TCPC_VENDOR_CC_CTRL2                    0x8d
+#define SBUOVPDIS                               BIT(7)
+#define CCOVPDIS                                BIT(6)
+#define SBURPCTRL                               BIT(5)
+#define CCLPMODESEL_MASK                        GENMASK(4, 3)
+#define ULTRA_LOW_POWER_MODE                    BIT(3)
+#define CCRPCTRL_MASK                           GENMASK(2, 0)
+#define UA_1_SRC                                1
+#define UA_80_SRC                               3
+
+#define TCPC_VENDOR_CC_CTRL3                    0x8e
+#define CCWTRDEB_MASK                           GENMASK(7, 6)
+#define CCWTRDEB_SHIFT                          6
+#define CCWTRDEB_1MS                            1
+#define CCWTRSEL_MASK                           GENMASK(5, 3)
+#define CCWTRSEL_SHIFT                          3
+#define CCWTRSEL_1V                             0x4
+#define CCLADDERDIS                             BIT(2)
+#define WTRCYCLE_MASK                           BIT(0)
+#define WTRCYCLE_SHIFT                          0
+#define WTRCYCLE_2_4_S                          0
+#define WTRCYCLE_4_8_S                          1
+
+#define TCPC_VENDOR_ADC_CTRL1                   0x91
+#define ADCINSEL_MASK                           GENMASK(7, 5)
+#define ADC_CHANNEL_OFFSET                      5
+#define ADCEN                                   BIT(0)
+
+enum contamiant_state {
+	NOT_DETECTED,
+	DETECTED,
+	SINK,
+};
+
+/*
+ * @potential_contaminant:
+ *		Last returned result to tcpm indicating whether the TCPM port
+ *		has potential contaminant.
+ */
+struct max_tcpci_chip {
+	struct tcpci_data data;
+	struct tcpci *tcpci;
+	struct device *dev;
+	struct i2c_client *client;
+	struct tcpm_port *port;
+	enum contamiant_state contaminant_state;
+	enum tcpm_state tcpm_current_state;
+	bool potential_contaminant;
+};
+
+static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
+{
+	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
+}
+
+static inline int max_tcpci_write16(struct max_tcpci_chip *chip, unsigned int reg, u16 val)
+{
+	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
+}
+
+static inline int max_tcpci_read8(struct max_tcpci_chip *chip, unsigned int reg, u8 *val)
+{
+	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
+}
+
+static inline int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg, u8 val)
+{
+	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
+}
+
+bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce);
+
+#endif  // TCPCI_MAXIM_H_
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
similarity index 89%
rename from drivers/usb/typec/tcpm/tcpci_maxim.c
rename to drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 83e140ffcc3e..8e6770ac2953 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2020, Google LLC
+ * Copyright (C) 2020 - 2022, Google LLC
  *
  * MAXIM TCPCI based TCPC driver
  */
@@ -15,6 +15,8 @@
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
+#include "tcpci_maxim.h"
+
 #define PD_ACTIVITY_TIMEOUT_MS				10000
 
 #define TCPC_VENDOR_ALERT				0x80
@@ -39,14 +41,6 @@
 #define MAX_BUCK_BOOST_SOURCE				0xa
 #define MAX_BUCK_BOOST_SINK				0x5
 
-struct max_tcpci_chip {
-	struct tcpci_data data;
-	struct tcpci *tcpci;
-	struct device *dev;
-	struct i2c_client *client;
-	struct tcpm_port *port;
-};
-
 static const struct regmap_range max_tcpci_tcpci_range[] = {
 	regmap_reg_range(0x00, 0x95)
 };
@@ -68,26 +62,6 @@ static struct max_tcpci_chip *tdata_to_max_tcpci(struct tcpci_data *tdata)
 	return container_of(tdata, struct max_tcpci_chip, data);
 }
 
-static int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
-{
-	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
-}
-
-static int max_tcpci_write16(struct max_tcpci_chip *chip, unsigned int reg, u16 val)
-{
-	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
-}
-
-static int max_tcpci_read8(struct max_tcpci_chip *chip, unsigned int reg, u8 *val)
-{
-	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
-}
-
-static int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg, u8 val)
-{
-	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
-}
-
 static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 {
 	u16 alert_mask = 0;
@@ -348,8 +322,14 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 	if (status & TCPC_ALERT_VBUS_DISCNCT)
 		tcpm_vbus_change(chip->port);
 
-	if (status & TCPC_ALERT_CC_STATUS)
-		tcpm_cc_change(chip->port);
+	if (status & TCPC_ALERT_CC_STATUS) {
+		if (chip->contaminant_state == DETECTED) {
+			if (!max_contaminant_is_contaminant(chip, false))
+				tcpm_port_clean(chip->port);
+		} else {
+			tcpm_cc_change(chip->port);
+		}
+	}
 
 	if (status & TCPC_ALERT_POWER_STATUS)
 		process_power_status(chip);
@@ -438,6 +418,38 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
 	return -1;
 }
 
+static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tcpci_data *tdata)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
+
+	if (!max_contaminant_is_contaminant(chip, chip->tcpm_current_state != TOGGLING))
+		tcpm_port_clean(chip->port);
+}
+
+static bool max_tcpci_is_potential_contaminant(struct tcpci *tcpci, struct tcpci_data *tdata,
+					       enum tcpm_state current_state)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
+	enum tcpm_state tcpm_prev_state = chip->tcpm_current_state;
+
+	/*
+	 * Return previous determinted contaminant status when tcpm is in CHECK_CONTAMINANT
+	 * state. Do not update the tcpm current state either.
+	 */
+	if (current_state == CHECK_CONTAMINANT)
+		return chip->potential_contaminant;
+
+	chip->tcpm_current_state = current_state;
+
+	if ((tcpm_prev_state == SRC_ATTACH_WAIT && current_state == SRC_UNATTACHED) ||
+	    (tcpm_prev_state == SNK_ATTACH_WAIT && current_state == SNK_UNATTACHED))
+		chip->potential_contaminant = true;
+	else
+		chip->potential_contaminant = false;
+
+	return chip->potential_contaminant;
+}
+
 static int max_tcpci_probe(struct i2c_client *client)
 {
 	int ret;
@@ -471,6 +483,8 @@ static int max_tcpci_probe(struct i2c_client *client)
 	chip->data.auto_discharge_disconnect = true;
 	chip->data.vbus_vsafe0v = true;
 	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
+	chip->data.check_contaminant = max_tcpci_check_contaminant;
+	chip->data.is_potential_contaminant = max_tcpci_is_potential_contaminant;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

