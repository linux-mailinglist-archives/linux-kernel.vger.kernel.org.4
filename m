Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834C663828
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAJE0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAJEZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:25:59 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D0A18D;
        Mon,  9 Jan 2023 20:25:58 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A3n9CS010209;
        Tue, 10 Jan 2023 04:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=bGTvQoYDlzWDjzwyojuOqg2J3s6qOsa62mcWyflaHSU=;
 b=m2NiAEXFcSCvLiqF1ivlkK00WWAPMPYZ88jmP04qub5AeStHhGAcE1bVLgrcROCSxnXs
 bJza3umrCG04borxGnjf568YcT3HvTQfF1dSohTzssmxaFvYNQjD2ScTyN8q5dPiZpwR
 ISTiTi+W/OYbwPwZi3qh9axQqbR/o8e3Fou3MUMD+YKc/XUGmGwZemkgGr8DwJ8X4yBu
 jRvdNEqxG2Kh7iex/y0yzXYvQSEulEjB1DY3KVpfBU2mjawDRKkIuLQnMlNvxPgoaJne
 skZqtUl4g72Mg/42jYQlQntMJyHiEUf/d+owhn/x9hi6zi+k7Ck69NGF2TSNqJa9u0uZ dA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3n10eq054g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 04:25:46 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 50331310DD;
        Tue, 10 Jan 2023 04:25:45 +0000 (UTC)
Received: from openbmc-dev.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id AD4E780BA36;
        Tue, 10 Jan 2023 04:25:41 +0000 (UTC)
From:   clayc@hpe.com
To:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
Cc:     Clay Chang <clayc@hpe.com>
Subject: [PATCH 1/5] soc: hpe: Add GXP SROM Control Register Driver
Date:   Tue, 10 Jan 2023 12:25:29 +0800
Message-Id: <20230110042533.12894-2-clayc@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110042533.12894-1-clayc@hpe.com>
References: <20230110042533.12894-1-clayc@hpe.com>
X-Proofpoint-GUID: Q-52ofkOBdfnLsGx71tk32l1kWgeUOd0
X-Proofpoint-ORIG-GUID: Q-52ofkOBdfnLsGx71tk32l1kWgeUOd0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clay Chang <clayc@hpe.com>

The GXP SROM control register can be used to configure LPC related
legacy I/O registers. Currently only the SROM RAM Offset Register
(vromoff) is exported.

The GXP SOCLIB is a common library used for creating the common
"soc" class in the kernel.

Signed-off-by: Clay Chang <clayc@hpe.com>
---
 drivers/soc/Kconfig          |   1 +
 drivers/soc/Makefile         |   1 +
 drivers/soc/hpe/Kconfig      |  29 +++++++
 drivers/soc/hpe/Makefile     |   2 +
 drivers/soc/hpe/gxp-soclib.c |  17 +++++
 drivers/soc/hpe/gxp-soclib.h |   9 +++
 drivers/soc/hpe/gxp-srom.c   | 141 +++++++++++++++++++++++++++++++++++
 7 files changed, 200 insertions(+)
 create mode 100644 drivers/soc/hpe/Kconfig
 create mode 100644 drivers/soc/hpe/Makefile
 create mode 100644 drivers/soc/hpe/gxp-soclib.c
 create mode 100644 drivers/soc/hpe/gxp-soclib.h
 create mode 100644 drivers/soc/hpe/gxp-srom.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 5dbb09f843f7..faff0f036b61 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
+source "drivers/soc/hpe/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index fff513bd522d..d257b9d654b3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
+obj-$(CONFIG_ARCH_HPE)		+= hpe/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
diff --git a/drivers/soc/hpe/Kconfig b/drivers/soc/hpe/Kconfig
new file mode 100644
index 000000000000..88f5d46b06b6
--- /dev/null
+++ b/drivers/soc/hpe/Kconfig
@@ -0,0 +1,29 @@
+#
+# HPE GXP SoC drivers
+#
+menu "HPE GXP SoC drivers"
+	depends on ARCH_HPE || COMPILE_TEST
+
+config HPE_GXP_SOCLIB
+	bool "GXP Common SoC Library"
+	default y
+	depends on ARCH_HPE_GXP || COMPILE_TEST
+	help
+	  This is for the common library for all HPE SoC drivers. It
+	  creates the root soc class (/sys/class/soc) for all GXP SoC
+	  drivers. It must be yes if any one of the GXP SoC drivers were
+	  added, so the config of all GXP SoC drivers must select this.
+
+
+config HPE_GXP_SROM
+	bool "GXP SROM Configuration Driver"
+	default y
+	depends on ARCH_HPE_GXP || COMPILE_TEST
+	select HPE_GXP_SOCLIB
+	help
+	  Say yes here to add support for SROM Configuration. The GXP SROM
+	  control register can be used to configure LPC related legacy I/O
+	  registers. Currently only the SROM RAM Offset Register (vromoff)
+	  is exported.
+
+endmenu
diff --git a/drivers/soc/hpe/Makefile b/drivers/soc/hpe/Makefile
new file mode 100644
index 000000000000..78de24ecb606
--- /dev/null
+++ b/drivers/soc/hpe/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_HPE_GXP_SOCLIB) += gxp-soclib.o
+obj-$(CONFIG_HPE_GXP_SROM) += gxp-srom.o
diff --git a/drivers/soc/hpe/gxp-soclib.c b/drivers/soc/hpe/gxp-soclib.c
new file mode 100644
index 000000000000..11b0afe09070
--- /dev/null
+++ b/drivers/soc/hpe/gxp-soclib.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett Packard Enteprise Development Company, L.P. */
+
+#include <linux/device.h>
+#include <linux/module.h>
+
+struct class *soc_class;
+
+static int __init gxp_soclib_init(void)
+{
+	soc_class = class_create(THIS_MODULE, "soc");
+	if (IS_ERR(soc_class))
+		return PTR_ERR(soc_class);
+	return 0;
+}
+
+module_init(gxp_soclib_init);
diff --git a/drivers/soc/hpe/gxp-soclib.h b/drivers/soc/hpe/gxp-soclib.h
new file mode 100644
index 000000000000..eb0e72b67aee
--- /dev/null
+++ b/drivers/soc/hpe/gxp-soclib.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Hewlett Packard Enterprise Development Company, L.P. */
+
+#ifndef __GXP_SOCLIB_H__
+#define __GXP_SOCLIB_H__
+
+extern struct class *soc_class;
+
+#endif
diff --git a/drivers/soc/hpe/gxp-srom.c b/drivers/soc/hpe/gxp-srom.c
new file mode 100644
index 000000000000..5a8f005055cf
--- /dev/null
+++ b/drivers/soc/hpe/gxp-srom.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett Packard Enterprise Development Company, L.P. */
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+
+#include "gxp-soclib.h"
+
+#define SROM_VROMOFF		0xf4 // 80fc_00f4
+
+struct gxp_srom_drvdata {
+	struct platform_device *pdev;
+	struct device *dev;
+	void __iomem *base;
+	struct mutex mutex;
+};
+
+static ssize_t vromoff_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct gxp_srom_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned int value;
+	ssize_t ret;
+
+	mutex_lock(&drvdata->mutex);
+	value = readl(drvdata->base + SROM_VROMOFF);
+	ret = sprintf(buf, "0x%08x", value);
+	mutex_unlock(&drvdata->mutex);
+
+	return ret;
+}
+
+static ssize_t vromoff_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct gxp_srom_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned int value;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &value);
+	if (rc < 0)
+		return -EINVAL;
+
+	mutex_lock(&drvdata->mutex);
+	writel(value, drvdata->base + SROM_VROMOFF);
+	mutex_unlock(&drvdata->mutex);
+
+	return count;
+}
+static DEVICE_ATTR_RW(vromoff);
+
+static struct attribute *srom_attrs[] = {
+	&dev_attr_vromoff.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(srom);
+
+static int sysfs_register(struct device *parent,
+			  struct gxp_srom_drvdata *drvdata)
+{
+	struct device *dev;
+
+	dev = device_create_with_groups(soc_class, parent, 0,
+					drvdata, srom_groups, "srom");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+	drvdata->dev = dev;
+	return 0;
+}
+
+static int gxp_srom_probe(struct platform_device *pdev)
+{
+	struct gxp_srom_drvdata *drvdata;
+	struct resource *res;
+	int ret;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_srom_drvdata),
+				GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->pdev = pdev;
+	platform_set_drvdata(pdev, drvdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no srom resource defined\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drvdata->base)) {
+		dev_err(&pdev->dev, "ioremap_resource error\n");
+		ret = PTR_ERR(drvdata->base);
+		goto ioremap_err;
+	}
+
+	mutex_init(&drvdata->mutex);
+
+	ret = sysfs_register(&pdev->dev, drvdata);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "sysfs error\n");
+		goto sysfs_err;
+	}
+
+	dev_info(&pdev->dev, "initialized\n");
+	return 0;
+
+sysfs_err:
+ioremap_err:
+	platform_set_drvdata(pdev, NULL);
+out:
+	if (drvdata)
+		devm_kfree(&pdev->dev, (void *)drvdata);
+	return ret;
+}
+
+static const struct of_device_id gxp_srom_of_match[] = {
+	{ .compatible = "hpe,gxp-srom" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gxp_srom_of_match);
+
+static struct platform_driver gxp_srom_driver = {
+	.probe = gxp_srom_probe,
+	.driver = {
+		.name = "gxp-srom",
+		.of_match_table = of_match_ptr(gxp_srom_of_match),
+	},
+};
+module_platform_driver(gxp_srom_driver);
+
+MODULE_AUTHOR("Clay Chang <clayc@hpe.com>");
+MODULE_DESCRIPTION("HPE GXP SROM Configuration Driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

