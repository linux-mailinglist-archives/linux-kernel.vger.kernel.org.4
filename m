Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD956DCB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDJSuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:50:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DCDC;
        Mon, 10 Apr 2023 11:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS1KpNrduri9ZDDHAvF4ZxohkecrNb8tI2LHfFrQ5nTOqoPn761xnOCaQWbZhMXeqVV1ZOWQpncuaE4R9JfhCJEf1tGI+K/Ykgp11MNHLwVLJDXRmZxuWUpDhTdBIJZtdAtZ5CxXQq5lHgnmTTVCeQ2RUwIxmcprAotZ3uiFnQSFGdEfJwdH4G1ScJBepjQ0OFpj7k7BSJRJeL1J0eTNp/eT5A/xNkGdcFQfcj8myUYeLey5JVD9Fx/MHZ7qf9iWdDjqQysl9Z+IVth5cO8LDF45a//JaLO2U8u8ZbfO4MAO1JSx6tdmEoo6cxhCis749fkqDkfjimXe3yxOg2hrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h44Zl9j/dIrJwYJCqJW/TClDVA+3EOCtpbngAJkdy8=;
 b=NyXlssWcAa1M7AnbgHP/5pgip7mEyiMlWUEqq1tgp7r0USrJlYXQUT7x24PhAwTToJq5FVuvxJqq+1HsLtsh0TwYnmfJ0uEOcLfIxc40+M+6AE0rMrR0sFzbmsLBWeB9foXt+BbtYGHeGT70Y9lEPpNJcW2LQAc1HHOaDGgfSporpqzXtgWSdwz7uT2jnPlDTTuIyGTJ9/Xql5sxtxUq7fPeiiPPQeI728zLoJwlLzD8opKXyrblEkLq20FdAVtHSLmk85V7ZJfkGOEcoEWTUAaZedXtrkLcHndzBlk7H5x1qoKWrudKyoEBP5IPKJ7yooofaVFMdy96uAAWY+7RTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h44Zl9j/dIrJwYJCqJW/TClDVA+3EOCtpbngAJkdy8=;
 b=kWR5PYj0fsO4jMoxHslERU3vKP1BkXQOJbafE3KdSIDfOEoqJ87sTt037gUUg4OM5cytuQkAHJ64VqQiZD3NTRlmIYjtxrSUWPuDNZTBtmeL0+i0vYrdSdDvsEmHiB0MLWA1qoRkopKP69tWlvJd0QXweNpD3GB5MQcN0Bp097M=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Mon, 10 Apr 2023 18:48:10 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::43) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Mon, 10 Apr 2023 18:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.26 via Frontend Transport; Mon, 10 Apr 2023 18:48:10 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:48:06 -0500
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
Subject: [PATCH v13 15/15] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Mon, 10 Apr 2023 11:45:26 -0700
Message-ID: <20230410184526.15990-16-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 96715424-a04b-4e32-fab0-08db39f421e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XI3cSPkZRnVV35+dE1NbGKU9ueVrYwg+3mi/x1OEw6/JQLI7ea4ROjdtpdaWtU3lKm2RgtRzA+wJdfw33osP+1arYyw4N31f88Ynp68auxY1+qQ2+tluX8dJ8VtvdNKJbePy6gGCY4cJxCFQ2/lg3zgEVrzColBFIGnCwSBdk02M2vhQNq0+ZbJ7TN0oO/s/XCRnkbQaXGTg7laIr4B9Op/T3Vq/qUaIkpxDU6S4Y7P3BGjLhF43KttwhvANfsgc1Xr6q+5xmeqn0qwRfiVoRtld1PAujgR43pDqbghVFfa9TqD656v2AkoljpxZbZVYiRHwyTTp6ToXf6duSZqTFBS6OvAM3IwPq1gnXju1akO3yfuel8WQEh8PH2XfKxpCjvHZnxYF3gATMDY5OgcYfwmDobtldiGiZ2N1CMUVY6C+OlMfgKD1svBbCh/Y33A3OZ+b9tRrs7Uurf8B0G8PfEFPpKT3RQ64MRvlmhljCWkRHhdvGXMua9DkUaqKL4An+ARihhPzUbD91+ykgvRR9wCB5BZ8hDgxAQ0bf7rtB/fSr4NnOdGKG6FAPtlc+FimL6wncQn4m4nMgUr94VuH5vSUb4ZYHifnh/K29h/dkW4EGEMWaAverTngHgdRk/ey99W/MGp7F8OElcxjgPKPKnokm21TYCkRYxZJh5kMF7qbebw/2T33b4juEaoPNLyACU5LA/Cd1FioYAGDej/bZOmHnuM5Kp94omJ82UYx6kw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(316002)(82310400005)(54906003)(356005)(36860700001)(82740400003)(81166007)(70586007)(8676002)(70206006)(478600001)(6916009)(4326008)(83380400001)(336012)(426003)(47076005)(2616005)(186003)(16526019)(41300700001)(36756003)(26005)(2906002)(1076003)(30864003)(40460700003)(40480700001)(8936002)(6666004)(5660300002)(7406005)(7416002)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:48:10.5799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96715424-a04b-4e32-fab0-08db39f421e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

v13 changes:
- Update include list in pensando-ctrl.c
- Change variable spi_dev to spi throughout
- Removed unneeded variable initialization, simplification of 
  error checks, remove extra castings, and use dev_err_probe()
- Sort the includes in amd-pensando-ctrl.h
- Updates to cleanup if there is an error in penctrl_spi_probe()

v12 changes:
- Fix gcc-12.1.0 warning:
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303120925.SxLjwOd2-lkp@intel.com/

v11 changes:
- Fix the compatible to be specific 'amd,pensando-elba-ctrl'

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
 drivers/soc/amd/pensando-ctrl.c        | 373 +++++++++++++++++++++++++
 include/uapi/linux/amd-pensando-ctrl.h |  30 ++
 6 files changed, 423 insertions(+)
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
index 000000000000..011d5339d14e
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
+	default ARCH_PENSANDO
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
index 000000000000..6e4066564684
--- /dev/null
+++ b/drivers/soc/amd/pensando-ctrl.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Pensando SoC Controller
+ *
+ * Userspace interface and reset driver support for SPI connected Pensando SoC
+ * controller device.  This device is present in all Pensando SoC designs and
+ * contains board control/status registers and management IO support.
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/reset-controller.h>
+#include <linux/spi/spi.h>
+#include <linux/amd-pensando-ctrl.h>
+
+struct penctrl_device {
+	struct spi_device *spi;
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
+	void __user *in_arg = (void __user *)arg;
+	struct penctrl_device *penctrl;
+	u8 tx_buf[PENCTRL_MAX_MSG_LEN];
+	u8 rx_buf[PENCTRL_MAX_MSG_LEN];
+	struct spi_transfer t[2] = {};
+	struct penctrl_spi_xfer *msg;
+	struct spi_device *spi;
+	unsigned int num_msgs;
+	struct spi_message m;
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
+		ret = !access_ok(in_arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ret = !access_ok(in_arg, _IOC_SIZE(cmd));
+
+	if (ret)
+		return -EFAULT;
+
+	/* Get a reference to the SPI device */
+	penctrl = filp->private_data;
+	if (!penctrl)
+		return -ESHUTDOWN;
+
+	spi = spi_dev_get(penctrl->spi);
+	if (!spi)
+		return -ESHUTDOWN;
+
+	/* Verify and prepare SPI message */
+	size = _IOC_SIZE(cmd);
+	num_msgs = size / sizeof(struct penctrl_spi_xfer);
+	if (size == 0 || size % sizeof(struct penctrl_spi_xfer)) {
+		ret = -EINVAL;
+		goto done;
+	}
+	msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
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
+	if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len)) {
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
+	ret = spi_sync(spi, &m);
+	mutex_unlock(&spi_lock);
+
+	if (ret || (num_msgs == 1))
+		goto done;
+
+	if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
+		ret = -EFAULT;
+
+done:
+	spi_dev_put(spi);
+	return ret;
+}
+
+static int penctrl_open(struct inode *inode, struct file *filp)
+{
+	struct spi_device *spi;
+	u8 current_cs;
+
+	if (!penctrl)
+		return -ENODEV;
+
+	filp->private_data = penctrl;
+	current_cs = iminor(inode);
+	spi = penctrl->spi;
+	spi->chip_select = current_cs;
+	spi->cs_gpiod = spi->controller->cs_gpiods[current_cs];
+	spi_setup(spi);
+	return stream_open(inode, filp);
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
+	struct spi_device *spi = penctrl->spi;
+	struct spi_transfer t[2] = {};
+	struct spi_message m;
+	u8 txbuf[3];
+	u8 rxbuf[1];
+	int ret;
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGRD;
+	txbuf[1] = reg;
+	txbuf[2] = 0;
+	t[0].tx_buf = txbuf;
+	t[0].len = 3;
+
+	rxbuf[0] = 0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = 1;
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi, &m);
+	if (ret == 0)
+		*val = rxbuf[0];
+
+	return ret;
+}
+
+static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u32 val)
+{
+	struct spi_device *spi = penctrl->spi;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 txbuf[4];
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t.tx_buf = txbuf;
+	t.len = 4;
+	spi_message_init_with_transfers(&m, &t, 1);
+	return spi_sync(spi, &m);
+}
+
+static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi = penctrl->spi;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi->chip_select = 0;
+	spi->cs_gpiod = spi->controller->cs_gpiods[0];
+	spi_setup(spi);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val |= BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi->dev, "error writing ctrl0 reg\n");
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
+	struct spi_device *spi = penctrl->spi;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi->chip_select = 0;
+	spi->cs_gpiod = spi->controller->cs_gpiods[0];
+	spi_setup(spi);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val &= ~BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi->dev, "error writing ctrl0 reg\n");
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
+static int penctrl_spi_probe(struct spi_device *spi)
+{
+	struct device *dev;
+	struct cdev *cdev;
+	u32 num_cs;
+	int ret;
+	u32 cs;
+
+	ret = device_property_read_u32(spi->dev.parent, "num-cs", &num_cs);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "number of chip-selects not defined\n");
+
+	ret = alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to alloc chrdev region\n");
+
+	penctrl_class = class_create(THIS_MODULE, "penctrl");
+	if (IS_ERR(penctrl_class)) {
+		ret = dev_err_probe(&spi->dev, PTR_ERR(penctrl_class),
+				    "failed to create class\n");
+		goto unregister_chrdev;
+	}
+
+	cdev = cdev_alloc();
+	if (!cdev) {
+		ret = dev_err_probe(&spi->dev, -ENOMEM,
+				    "allocation of cdev failed\n");
+		goto destroy_class;
+	}
+	cdev->owner = THIS_MODULE;
+	cdev_init(cdev, &penctrl_fops);
+
+	ret = cdev_add(cdev, penctrl_devt, num_cs);
+	if (ret) {
+		ret = dev_err_probe(&spi->dev, ret,
+				    "register of cdev failed\n");
+		goto free_cdev;
+	}
+
+	/* Allocate driver data */
+	penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
+	if (!penctrl) {
+		ret = -ENOMEM;
+		goto free_cdev;
+	}
+	penctrl->spi = spi;
+	mutex_init(&spi_lock);
+
+	/* Create a device for each chip select */
+	for (cs = 0; cs < num_cs; cs++) {
+		dev = device_create(penctrl_class,
+				    &spi->dev,
+				    MKDEV(MAJOR(penctrl_devt), cs),
+				    penctrl,
+				    "penctrl0.%d",
+				    cs);
+		if (IS_ERR(dev)) {
+			ret = dev_err_probe(&spi->dev, PTR_ERR(dev),
+					    "error creating device\n");
+			goto destroy_device;
+		}
+		dev_dbg(&spi->dev, "created device major %u, minor %d\n",
+			MAJOR(penctrl_devt), cs);
+	}
+
+	/* Register emmc hardware reset */
+	penctrl->rcdev.nr_resets = 1;
+	penctrl->rcdev.owner = THIS_MODULE;
+	penctrl->rcdev.dev = &spi->dev;
+	penctrl->rcdev.ops = &penctrl_reset_ops;
+	penctrl->rcdev.of_node = spi->dev.of_node;
+	device_set_node(&spi->dev, dev_fwnode(dev));
+
+	ret = reset_controller_register(&penctrl->rcdev);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to register reset controller\n");
+	return 0;
+
+destroy_device:
+	for (cs = 0; cs < num_cs; cs++)
+		device_destroy(penctrl_class, MKDEV(MAJOR(penctrl_devt), cs));
+	kfree(penctrl);
+free_cdev:
+	cdev_del(cdev);
+destroy_class:
+	class_destroy(penctrl_class);
+unregister_chrdev:
+	unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
+
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
index 000000000000..2508a1aef22c
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
+#include <linux/ioctl.h>
+#include <linux/types.h>
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

