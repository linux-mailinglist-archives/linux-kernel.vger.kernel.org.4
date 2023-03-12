Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51ED6B6293
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCLAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCLAs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:48:57 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078A91B57F;
        Sat, 11 Mar 2023 16:48:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNwU2JJQ5TL5QscihAgLVCX85WYgm5Og9A3iQ0HlxgEDBHyJTZr0994RdvRzGU6cxS+XYxiDHbI09ObIwqgpu8aAYufmeH1vFQnbCnyn454RSKBqz4Wk3ovOJS71peYI6hBA8ywVCtmo6j+snTzvkrNj4D0i6qoGeqtWnR1Mik+vjDYQw//sYG6Y7QiGhrfLj1k8CX0hlHt3ll+RNglWYHTP/7Fye1AWcz1aFnjLDpPAqGtkboJaKwjDJPzQAjsbACvwXqvrzttlajRQok1nrWLsF4G2eXWBtg5lgZ+Ub/kEUbOWobyRENi/mwgksgZcd6/BBjNo5hpyXeTGD1nIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJHwz4Eti0SCc5qDuoCWdPJiUcA36js2d2rTxGM1jmg=;
 b=UBjPtdxHzEQKH+UFDj3r6B/3tVGDd2ptxBxUw3Q/D42keKX7FqpK+ZFBmbcy7TZ/xV2F2I6dCUZJHfg0bze50xoltYySPd2jYUDPIkbL1XzMm2S+2wgKLTD/WwkGDJ/qDLNmUrzFnXQhTFBjA0gTmcMqb8vfQ0hkD7wLRgOmlyPf4OVnaXbWeOaNuvdXJ6JUKvpEL5rTVf1u/0SeQeTbaXCp0ArTDCcylk18H4RRCq3KCqW7hlX0AyrXqbBxdxlELFLOrNz4TODlE/bcRS4ZcgNtKjj4tvTqBtPINljjLU6AnBvJlXrSJ26RVLtijBAXS1QOtoWB2B2nT7yNyRTl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJHwz4Eti0SCc5qDuoCWdPJiUcA36js2d2rTxGM1jmg=;
 b=oFhTY90t18cR7LXr2JisdCVgH7iu27NRZqtAw6u6pICUzjOBfbLfpcUETUBNEIhFEwbbStSJODUENmE/5nnzYGkGvxuAb79j+JsD2sYpFClAbBtpvvBzuI0vS4KZ2HBXIOgf0Dv52PekZIJZJMm/2OEpaVIyP4hrbKlwHCNskq8=
Received: from DM6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:5:174::29)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 00:47:25 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::d6) by DM6PR21CA0019.outlook.office365.com
 (2603:10b6:5:174::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.15 via Frontend
 Transport; Sun, 12 Mar 2023 00:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Sun, 12 Mar 2023 00:47:25 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:47:21 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v11 15/15] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Sat, 11 Mar 2023 16:44:45 -0800
Message-ID: <20230312004445.15913-16-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|CH0PR12MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af844c2-152f-4bde-cb95-08db2293591a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2Z2Z/D1/fzczcTmSri9KMgHI6wNyLVrxXgfxuiu2aKQTqwvQiJUynOTSwoUx7UQX+6293i4MWNfz2N+47dDeeg4nN28E4+hDSHjI0XBTfV1kQnlrEufJAm1ZnG7KTzrFkGiknwUaJ4Dm2V3Z19gXmJUmovM1F/Bz1CXivJ9A7YVASMlKQKrS1QUw2Q3FSPrqiqaogzcDbf2uTFJyj+HwtqYcP7lPNWrq0tTfLpUvoe+EA276VXF70/Yk2a907Y5hBUSE8W4Pm3mZWp7IbqqMyAKrF23O1WaH6uIUv2Z4c04RilFVnRem4pMAvenjzFE0ndWmjkFp+LeyVUYvJOKpUVfw9W1Whu4CBQL7yOrRihh/9sfHrlBh+JPiY+3DG/LpdvpDWjAynCYTZPfM4uWGHIwxxEMT8otTdSVMGsZLUm5KXkY5QutmCPko4GcfsjhJDrVCDH9wG+ns6H03/Jm7AKDcVUqXGjNbnfRzNht0DhNmEMiKjlOHgBqyY8I3Nn2k+fJVz5xHiSgqgj8B5nl3knsq6Dh3wMHaKUkmTZI7UIh6Sk1ouIwFvrJPWbnhWfOyYCTspn6Egn6jjgbwEXEYEEG8pAihZC3Me2z1jeCspa31VGIaA/ne3Ky2gyFKAC9LYy1AABJNWl/eb3O22zkcTr565oWABXdVbUCM87IKpLIQ4fvG21M/wPAHX8kGensUL3dzTelkLpul9KXCvH+85mfAzZ/EUbRLlv6hoOiKLw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(966005)(83380400001)(6666004)(36756003)(40460700003)(26005)(1076003)(30864003)(7406005)(5660300002)(8936002)(16526019)(40480700001)(186003)(41300700001)(2616005)(356005)(6916009)(8676002)(4326008)(7416002)(47076005)(426003)(70206006)(70586007)(336012)(81166007)(478600001)(82740400003)(316002)(54906003)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:47:25.2897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af844c2-152f-4bde-cb95-08db2293591a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pensando SoC controller is a SPI connected companion device
that is present in all Pensando SoC board designs.  The essential
board management registers are accessed on chip select 0 with
board mgmt IO support accessed using additional chip selects.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v11 changes:
- Fix the compatible to be specific 'amd,pensando-elba-ctrl'
- Cast arguments flagged with a gcc-12.1.0 warning:
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303061526.I8VPcR1M-lkp@intel.com/

v10 changes:
- Different driver implementation specific to this Pensando controller device.
- Moved to soc/amd directory under new name based on guidance.  This driver is
  of no use to any design other than all Pensando SoC based cards.
- Removed use of builtin_driver, can be built as a module.

v9 changes:
- Previously patch 14/17
- After the change to the device tree node and squashing
  reset-cells into the parent simplified this to not use
  any MFD API and move it to drivers/spi/pensando-sr.c.
- Change the naming to remove elba since this driver is common
  for all Pensando SoC designs .
- Default yes SPI_PENSANDO_SR for ARCH_PENSANDO

---
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   1 +
 drivers/soc/amd/Kconfig                |  16 ++
 drivers/soc/amd/Makefile               |   2 +
 drivers/soc/amd/pensando-ctrl.c        | 378 +++++++++++++++++++++++++
 include/uapi/linux/amd-pensando-ctrl.h |  30 ++
 6 files changed, 428 insertions(+)
 create mode 100644 drivers/soc/amd/Kconfig
 create mode 100644 drivers/soc/amd/Makefile
 create mode 100644 drivers/soc/amd/pensando-ctrl.c
 create mode 100644 include/uapi/linux/amd-pensando-ctrl.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..9e023f74e47c 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/actions/Kconfig"
+source "drivers/soc/amd/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..8914530f2721 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
+obj-y				+= amd/
 obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
diff --git a/drivers/soc/amd/Kconfig b/drivers/soc/amd/Kconfig
new file mode 100644
index 000000000000..9fc03de49f11
--- /dev/null
+++ b/drivers/soc/amd/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "AMD Pensando SoC drivers"
+
+config AMD_PENSANDO_CTRL
+	tristate "AMD Pensando SoC Controller"
+	depends on SPI_MASTER=y
+	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
+	default y if ARCH_PENSANDO
+	select REGMAP_SPI
+	select MFD_SYSCON
+	help
+	  Enables AMD Pensando SoC controller device support.  This is a SPI
+	  attached companion device in all Pensando SoC board designs which
+	  provides essential board control/status registers and management IO
+	  support.
+endmenu
diff --git a/drivers/soc/amd/Makefile b/drivers/soc/amd/Makefile
new file mode 100644
index 000000000000..a2de0424f68d
--- /dev/null
+++ b/drivers/soc/amd/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_PENSANDO_CTRL)	+= pensando-ctrl.o
diff --git a/drivers/soc/amd/pensando-ctrl.c b/drivers/soc/amd/pensando-ctrl.c
new file mode 100644
index 000000000000..4f1b2b1f5092
--- /dev/null
+++ b/drivers/soc/amd/pensando-ctrl.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Pensando SoC Controller
+ *
+ * Userspace interface and reset driver support for SPI connected Pensando SoC
+ * controller device.  This device is present in all Pensando SoC designs and
+ * contains board control/status regsiters and management IO support.
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spi/spi.h>
+#include <linux/amd-pensando-ctrl.h>
+
+struct penctrl_device {
+	struct spi_device *spi_dev;
+	struct reset_controller_dev rcdev;
+};
+
+static DEFINE_MUTEX(spi_lock);
+static dev_t penctrl_devt;
+static struct penctrl_device *penctrl;
+static struct class *penctrl_class;
+
+static long
+penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct spi_transfer t[2] = { 0 };
+	struct penctrl_device *penctrl;
+	struct penctrl_spi_xfer *msg;
+	struct spi_device *spi_dev;
+	unsigned int num_msgs;
+	struct spi_message m;
+	u8 tx_buf[PENCTRL_MAX_MSG_LEN];
+	u8 rx_buf[PENCTRL_MAX_MSG_LEN];
+	u32 size;
+	int ret;
+
+	/* Check for a valid command */
+	if (_IOC_TYPE(cmd) != PENCTRL_IOC_MAGIC)
+		return -ENOTTY;
+
+	if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
+		return -ENOTTY;
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+
+	if (ret)
+		return -EFAULT;
+
+	/* Get a reference to the SPI device */
+	penctrl = filp->private_data;
+	if (!penctrl)
+		return -ESHUTDOWN;
+
+	spi_dev = spi_dev_get(penctrl->spi_dev);
+	if (!spi_dev)
+		return -ESHUTDOWN;
+
+	/* Verify and prepare spi message */
+	size = _IOC_SIZE(cmd);
+	if ((size % sizeof(struct penctrl_spi_xfer)) != 0) {
+		ret = -EINVAL;
+		goto done;
+	}
+	num_msgs = size / sizeof(struct penctrl_spi_xfer);
+	if (num_msgs == 0) {
+		ret = -EINVAL;
+		goto done;
+	}
+	msg = memdup_user((struct penctrl_spi_xfer __user *)arg, size);
+	if (!msg) {
+		ret = PTR_ERR(msg);
+		goto done;
+	}
+	if (msg->len > PENCTRL_MAX_MSG_LEN) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	t[0].tx_buf = tx_buf;
+	t[0].len = msg->len;
+	if (copy_from_user((void *)tx_buf, (void __user *)msg->tx_buf, msg->len)) {
+		ret = -EFAULT;
+		goto done;
+	}
+	if (num_msgs > 1) {
+		msg++;
+		if (msg->len > PENCTRL_MAX_MSG_LEN) {
+			ret = -EINVAL;
+			goto done;
+		}
+		t[1].rx_buf = rx_buf;
+		t[1].len = msg->len;
+	}
+	spi_message_init_with_transfers(&m, t, num_msgs);
+
+	/* Perform the transfer */
+	mutex_lock(&spi_lock);
+	ret = spi_sync(spi_dev, &m);
+	mutex_unlock(&spi_lock);
+
+	if (ret || (num_msgs == 1))
+		goto done;
+
+	if (copy_to_user((void __user *)msg->rx_buf, (void *)rx_buf, msg->len))
+		ret = -EFAULT;
+
+done:
+	spi_dev_put(spi_dev);
+	return ret;
+}
+
+static int penctrl_open(struct inode *inode, struct file *filp)
+{
+	struct spi_device *spi_dev;
+	u8 current_cs;
+
+	if (!penctrl)
+		return -ENODEV;
+
+	filp->private_data = penctrl;
+	current_cs = iminor(inode);
+	spi_dev = penctrl->spi_dev;
+	spi_dev->chip_select = current_cs;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[current_cs];
+	spi_setup(spi_dev);
+	stream_open(inode, filp);
+
+	return 0;
+}
+
+static int penctrl_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations penctrl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl = penctrl_ioctl,
+	.open		= penctrl_open,
+	.release	= penctrl_release,
+	.llseek		= no_llseek,
+};
+
+static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u32 *val)
+{
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	struct spi_transfer t[2] = { 0 };
+	struct spi_message m;
+	u8 txbuf[3];
+	u8 rxbuf[1];
+	int ret;
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGRD;
+	txbuf[1] = reg;
+	txbuf[2] = 0x0;
+	t[0].tx_buf = txbuf;
+	t[0].len = 3;
+
+	rxbuf[0] = 0x0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = 1;
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi_dev, &m);
+	if (ret == 0)
+		*val = rxbuf[0];
+
+	return ret;
+}
+
+static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u32 val)
+{
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	struct spi_transfer t[1] = { 0 };
+	struct spi_message m;
+	u8 txbuf[4];
+	int ret;
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t[0].tx_buf = txbuf;
+	t[0].len = 4;
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi_dev, &m);
+	return ret;
+}
+
+static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[0];
+	spi_setup(spi_dev);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi_dev->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val |= BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi_dev->dev, "error writing ctrl0 reg\n");
+
+done:
+	mutex_unlock(&spi_lock);
+	return ret;
+}
+
+static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[0];
+	spi_setup(spi_dev);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi_dev->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val &= ~BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi_dev->dev, "error writing ctrl0 reg\n");
+
+done:
+	mutex_unlock(&spi_lock);
+	return ret;
+}
+
+static const struct reset_control_ops penctrl_reset_ops = {
+	.assert = penctrl_reset_assert,
+	.deassert = penctrl_reset_deassert,
+};
+
+static int penctrl_spi_probe(struct spi_device *spi_dev)
+{
+	struct device_node *np;
+	struct device *dev;
+	struct cdev *cdev;
+	u32 num_cs;
+	int ret;
+	u32 cs;
+
+	np = spi_dev->dev.parent->of_node;
+	ret = of_property_read_u32(np, "num-cs", &num_cs);
+	if (ret)
+		return dev_err_probe(&spi_dev->dev, ret,
+				     "number of chip-selects not defined");
+
+	ret = alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
+	if (ret)
+		return dev_err_probe(&spi_dev->dev, ret,
+				     "failed to alloc chrdev region\n");
+
+	penctrl_class = class_create(THIS_MODULE, "penctrl");
+	if (IS_ERR(penctrl_class)) {
+		unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(penctrl_class),
+				     "failed to create class\n");
+	}
+
+	cdev = cdev_alloc();
+	if (!cdev) {
+		dev_err(&spi_dev->dev, "allocation of cdev failed");
+		ret = -ENOMEM;
+		goto cdev_failed;
+	}
+	cdev->owner = THIS_MODULE;
+	cdev_init(cdev, &penctrl_fops);
+
+	ret = cdev_add(cdev, penctrl_devt, num_cs);
+	if (ret) {
+		dev_err(&spi_dev->dev, "register of cdev failed");
+		goto cdev_delete;
+	}
+
+	/* Allocate driver data */
+	penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
+	if (!penctrl) {
+		ret = -ENOMEM;
+		dev_err(&spi_dev->dev, "allocate driver data failed");
+		goto cdev_delete;
+	}
+
+	penctrl->spi_dev = spi_dev;
+	mutex_init(&spi_lock);
+
+	/* Create a device for each chip select */
+	for (cs = 0; cs < num_cs; cs++) {
+		dev = device_create(penctrl_class,
+				    &spi_dev->dev,
+				    MKDEV(MAJOR(penctrl_devt), cs),
+				    penctrl,
+				    "penctrl0.%d",
+				    cs);
+		if (IS_ERR(dev)) {
+			ret = IS_ERR(dev);
+			dev_err(&spi_dev->dev, "error creating device\n");
+			goto cdev_delete;
+		}
+		dev_dbg(&spi_dev->dev, "created device major %u, minor %d\n",
+			MAJOR(penctrl_devt), cs);
+	}
+
+	spi_set_drvdata(spi_dev, penctrl);
+
+	/* Register emmc hardware reset */
+	penctrl->rcdev.nr_resets = 1;
+	penctrl->rcdev.owner = THIS_MODULE;
+	penctrl->rcdev.dev = &spi_dev->dev;
+	penctrl->rcdev.ops = &penctrl_reset_ops;
+	penctrl->rcdev.of_node = spi_dev->dev.of_node;
+	ret = reset_controller_register(&penctrl->rcdev);
+	if (ret)
+		return dev_err_probe(&spi_dev->dev, ret,
+				     "failed to register reset controller\n");
+	return ret;
+
+cdev_delete:
+	cdev_del(cdev);
+cdev_failed:
+	device_destroy(penctrl_class, penctrl_devt);
+	return ret;
+}
+
+static const struct of_device_id penctrl_dt_match[] = {
+	{ .compatible = "amd,pensando-elba-ctrl" },
+	{ /* sentinel */ }
+};
+
+static struct spi_driver penctrl_spi_driver = {
+	.probe = penctrl_spi_probe,
+	.driver = {
+		.name = "pensando-ctrl",
+		.of_match_table = penctrl_dt_match,
+	},
+};
+module_spi_driver(penctrl_spi_driver);
+
+MODULE_AUTHOR("Brad Larson <blarson@amd.com>");
+MODULE_DESCRIPTION("AMD Pensando SoC Controller via SPI");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/amd-pensando-ctrl.h b/include/uapi/linux/amd-pensando-ctrl.h
new file mode 100644
index 000000000000..0a6caf3b764c
--- /dev/null
+++ b/include/uapi/linux/amd-pensando-ctrl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/penctrl
+ *
+ * This file can be used by applications that need to communicate
+ * with the AMD Pensando SoC controller device via the ioctl interface.
+ */
+#ifndef _UAPI_LINUX_AMD_PENSANDO_CTRL_H
+#define _UAPI_LINUX_AMD_PENSANDO_CTRL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define PENCTRL_SPI_CMD_REGRD	0x0b
+#define PENCTRL_SPI_CMD_REGWR	0x02
+#define PENCTRL_IOC_MAGIC	'k'
+#define PENCTRL_IOC_MAXNR	0
+#define PENCTRL_MAX_MSG_LEN	16
+#define PENCTRL_MAX_REG		0xff
+#define PENCTRL_REG_CTRL0	0x10
+
+struct penctrl_spi_xfer {
+	__u64 tx_buf;
+	__u64 rx_buf;
+	__u32 len;
+	__u32 speed_hz;
+	__u64 compat;
+};
+
+#endif /* _UAPI_LINUX_AMD_PENSANDO_CTRL_H */
-- 
2.17.1

