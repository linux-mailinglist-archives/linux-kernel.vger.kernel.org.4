Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC7668AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjAMEMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjAMELm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:11:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E365352;
        Thu, 12 Jan 2023 20:11:28 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D3xABO029564;
        Fri, 13 Jan 2023 04:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0D6Fjvc3NxXQBk6jAWjWbsDYNmDhmP6kCq1JnFpueXA=;
 b=QB3yMaIt+ABJBjk133hKGUPpDvW9nBTJTXhaCIo7HdOJHSD0RH4q3d0LXyoQ+UUpmffa
 srvf2HtzDRaDewSzAmHX0+LDQgTHN9MB3cTtyEVeUyq+sAfv24C0Ze1xZ8mR7rdk5OBM
 aWWD333C6+9+VQexbXj1yl064TZmK7fBpmlvhVIHXN9mf5JjF4YtxzesluPbH74HgLvi
 LvB7IW1Z4LxwmLd7dc0/5HfPI/gylrfadz16zdOqwRrKhoieZ0jqnDbvTS3pHhisRqkC
 8BGZkhDTk4rD2zsE53dDrZwLGcMimF7mIib7y+bsq94S6HKx/1IIdn+9k1Bj80XKSdHk 0w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2s0crpt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:11:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D4BLZm011464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:11:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 20:11:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] usb: typec: mux: Introduce GPIO-based SBU mux
Date:   Thu, 12 Jan 2023 20:11:15 -0800
Message-ID: <20230113041115.4189210-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N0qIkdJR3d6XBGuAV1H4QrUWkbpG7o65
X-Proofpoint-GUID: N0qIkdJR3d6XBGuAV1H4QrUWkbpG7o65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

A design found in various Qualcomm-based boards is to use a USB switch,
controlled through a pair of GPIO lines to connect, disconnect and
switch the orientation of the SBU lines in USB Type-C applications.

This introduces a generic driver, which implements the typec_switch and
typec_mux interfaces to perform these operations.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Fixed "swapped" being uninitialized for TYPEC_ORIENTATION_NONE in switch_set

 drivers/usb/typec/mux/Kconfig        |   6 +
 drivers/usb/typec/mux/Makefile       |   1 +
 drivers/usb/typec/mux/gpio-sbu-mux.c | 172 +++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 drivers/usb/typec/mux/gpio-sbu-mux.c

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 5eb2c17d72c1..c46fa4f9d3df 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -12,6 +12,12 @@ config TYPEC_MUX_FSA4480
 	  common USB Type-C connector.
 	  If compiled as a module, the module will be named fsa4480.
 
+config TYPEC_MUX_GPIO_SBU
+	tristate "Generic GPIO based SBU mux for USB Type-C applications"
+	help
+	  Say Y or M if your system uses a GPIO based mux for managing the
+	  connected state and the swapping of the SBU lines in a Type-C port.
+
 config TYPEC_MUX_PI3USB30532
 	tristate "Pericom PI3USB30532 Type-C cross switch driver"
 	depends on I2C
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index e52a56c16bfb..dda67e19b58b 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_TYPEC_MUX_FSA4480)		+= fsa4480.o
+obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
new file mode 100644
index 000000000000..f62516dafe8f
--- /dev/null
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+
+struct gpio_sbu_mux {
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *select_gpio;
+
+	struct typec_switch_dev *sw;
+	struct typec_mux_dev *mux;
+
+	struct mutex lock; /* protect enabled and swapped */
+	bool enabled;
+	bool swapped;
+};
+
+static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
+			       enum typec_orientation orientation)
+{
+	struct gpio_sbu_mux *sbu_mux = typec_switch_get_drvdata(sw);
+	bool enabled;
+	bool swapped;
+
+	mutex_lock(&sbu_mux->lock);
+
+	enabled = sbu_mux->enabled;
+	swapped = sbu_mux->swapped;
+
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NONE:
+		enabled = false;
+		break;
+	case TYPEC_ORIENTATION_NORMAL:
+		swapped = false;
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		swapped = true;
+		break;
+	}
+
+	if (enabled != sbu_mux->enabled)
+		gpiod_set_value(sbu_mux->enable_gpio, enabled);
+
+	if (swapped != sbu_mux->swapped)
+		gpiod_set_value(sbu_mux->select_gpio, swapped);
+
+	sbu_mux->enabled = enabled;
+	sbu_mux->swapped = swapped;
+
+	mutex_unlock(&sbu_mux->lock);
+
+	return 0;
+}
+
+static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
+			    struct typec_mux_state *state)
+{
+	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
+
+	mutex_lock(&sbu_mux->lock);
+
+	switch (state->mode) {
+	case TYPEC_STATE_SAFE:
+	case TYPEC_STATE_USB:
+		sbu_mux->enabled = false;
+		break;
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_E:
+		sbu_mux->enabled = true;
+		break;
+	default:
+		break;
+	}
+
+	gpiod_set_value(sbu_mux->enable_gpio, sbu_mux->enabled);
+
+	mutex_unlock(&sbu_mux->lock);
+
+	return 0;
+}
+
+static int gpio_sbu_mux_probe(struct platform_device *pdev)
+{
+	struct typec_switch_desc sw_desc = { };
+	struct typec_mux_desc mux_desc = { };
+	struct device *dev = &pdev->dev;
+	struct gpio_sbu_mux *sbu_mux;
+
+	sbu_mux = devm_kzalloc(dev, sizeof(*sbu_mux), GFP_KERNEL);
+	if (!sbu_mux)
+		return -ENOMEM;
+
+	mutex_init(&sbu_mux->lock);
+
+	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(sbu_mux->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->enable_gpio),
+				     "unable to acquire enable gpio\n");
+
+	sbu_mux->select_gpio = devm_gpiod_get(dev, "select", GPIOD_OUT_LOW);
+	if (IS_ERR(sbu_mux->select_gpio))
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->select_gpio),
+				     "unable to acquire select gpio\n");
+
+	sw_desc.drvdata = sbu_mux;
+	sw_desc.fwnode = dev_fwnode(dev);
+	sw_desc.set = gpio_sbu_switch_set;
+
+	sbu_mux->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(sbu_mux->sw))
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->sw),
+				     "failed to register typec switch\n");
+
+	mux_desc.drvdata = sbu_mux;
+	mux_desc.fwnode = dev_fwnode(dev);
+	mux_desc.set = gpio_sbu_mux_set;
+
+	sbu_mux->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(sbu_mux->mux)) {
+		typec_switch_unregister(sbu_mux->sw);
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->mux),
+				     "failed to register typec mux\n");
+	}
+
+	platform_set_drvdata(pdev, sbu_mux);
+
+	return 0;
+}
+
+static int gpio_sbu_mux_remove(struct platform_device *pdev)
+{
+	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
+
+	gpiod_set_value(sbu_mux->enable_gpio, 0);
+
+	typec_mux_unregister(sbu_mux->mux);
+	typec_switch_unregister(sbu_mux->sw);
+
+	return 0;
+}
+
+static const struct of_device_id gpio_sbu_mux_match[] = {
+	{ .compatible = "gpio-sbu-mux", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gpio_sbu_mux_match);
+
+static struct platform_driver gpio_sbu_mux_driver = {
+	.probe = gpio_sbu_mux_probe,
+	.remove = gpio_sbu_mux_remove,
+	.driver = {
+		.name = "gpio_sbu_mux",
+		.of_match_table = gpio_sbu_mux_match,
+	},
+};
+module_platform_driver(gpio_sbu_mux_driver);
+
+MODULE_DESCRIPTION("GPIO based SBU mux driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

