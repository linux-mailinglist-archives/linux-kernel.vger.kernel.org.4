Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E9703C74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbjEOSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbjEOSSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D13DDAC;
        Mon, 15 May 2023 11:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA5sGakG9WUBgdSKeVwKnPLcWC4gcBXn45CZet8zNiyzp2gcZ8ICv8FUFPIPT0oRBzql1ktIlHhU0Cc6fhu2SEqCOxfB36cdvMKkhRbQYH07dr/SjcrhB/ctQ9A74xM9bdGxb02ZnsVN5WybD7Yv7DbgzpgC95rQVpsqrssbcRQQYafs7SI68JrZWJkPSlafHRShrR3ZNGKxQlAoJGOZ3ZUqh4YnCIF/9KajYIRDvzcqVaoTyHkrplguq3AXHTHCgiVHPJgj/2UsmBP7nRRD/LjwtwBjm+vaF3EaFNloyX+WUuZgPuPA+pd9DdEqCu7XF7WuRpwMV7Zwx52/ysvY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CkIvxNxNTRWPJZJDDm9uvAAIyqFTiT/zmC8YlU8Ql8=;
 b=fibkk4oSLGydh0EXWtkZTcXOfOKZx25WyE0lUMtZae6fdSjdSK1k67oVD7+LxLyuwufn9UdHcQs6ruZpkg8/I5uuda+5rs8vy12XehGo+562vDELYQAzW5T2PBohNHwhL2I29RfT0NbtvD/27lh7kpdUxljXA2HJFM8gznIoyDHp6EZ/2Km9zH1a1+tnlDSsQZ1hDW3RpJk4y13TCd8pSMKHydzYcHovaY8Z44mbagO/Ux/0Zawvpd/nwiymIGGco09BRZ04Cm+J+MFIR/4oYIRaB5MlwqHOkOYYadQ41pMdslRBem5jXoZR+8zk129Gb/z/pG9hI499ET+nPlTsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CkIvxNxNTRWPJZJDDm9uvAAIyqFTiT/zmC8YlU8Ql8=;
 b=GzLkrjo7HO3fKv2oXilTew/9/vPJZP2H5YYDXVFj73xrT6iDet+Hnc5OZzb6bOgoXXgBT5lzuPgHDM/4/qGlcaP4lFbSrNAa+J7m21AbmcYm1SkXDdFo941crp2V20iEQzxw/V3UtHi9Iet2g6GrLScxT8Uofi+DzzOHx4Yva3w=
Received: from BN9PR03CA0772.namprd03.prod.outlook.com (2603:10b6:408:13a::27)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 18:18:02 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::bf) by BN9PR03CA0772.outlook.office365.com
 (2603:10b6:408:13a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 18:18:00 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:17:56 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Mon, 15 May 2023 11:16:06 -0700
Message-ID: <20230515181606.65953-9-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: da4c14bb-570c-4f7e-4350-08db5570b7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNrU24DRmY+C+ZINJs4TGHp2crS5qOBF0tqzdvTibxtujYp52MgmkF/LZTBcdfPn5lwytPoYeFZJcwJhJr4uioUUKrYB4XgLVhwiN7xnXWbf1ZGV4obE1Lraqy33RX8USze0w/Vz00sr5eTJctfJIZnsG6jYQSreefafG8dahhCCEWaGSNytB1z9wtxr3ToYBCLyNZVMWieeMoD85c0D9IpdxBEp47kveN+8MiE2U0Gk7bP3OlJn/BLcpIIUs3ocTZeYbyny8/0B4PoHhag4R+OwPwUUTk3+MNr+KRCpR7l87aF0DL94bEVwEP48p9PTTRYkKYHmLuBs6suWkgYzHG61zw/v1QEJ9+0gsPtXkcLxMdT6U7w9/0/TplfhWneRHp9NuEVFZTGPD7x/r2DQmcWkmct1LG5SUy7o33km+OopR8rGgcjS0/YCSJfwbKpi/SrwmayjO6YmUOJDwIwlxco1P+XmqAUSmjkfTTSXaChm8UMICOoB1SdtklyvMmNfS+W3VIlUIPnQwJumBwDO5ZGfk2iBMdfbtRHn7YIIRsgITW4IpfT3kBB1Jl8oLi7robTOYx1FLOd0l1M36qbpE0akdayA/s9YA+Iq7b78fTiMCtROrpQVP8lptW4rpXrbCW4CIWgkBVYAV8YSvAypSWWEAvKclt5vP5Cy8+poLrR5ngFXFxZ7d4lbxIlxPUCkUlEKWCyxSF0jkGdwAaIgMdIoeolbq8lOVXRizFTWLMDwirFP/kzSYpvKcCH/dfwNqG5TFukDU51YOvRNpIiTEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(356005)(2616005)(426003)(36860700001)(47076005)(1076003)(336012)(186003)(26005)(16526019)(40480700001)(83380400001)(2906002)(30864003)(41300700001)(5660300002)(7406005)(7416002)(8936002)(8676002)(36756003)(966005)(478600001)(6666004)(70586007)(70206006)(6916009)(316002)(4326008)(54906003)(82310400005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:18:00.8388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4c14bb-570c-4f7e-4350-08db5570b7a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

v14 changes:
- Save 8 bytes of code size by swapping spi_device and reset_controller_dev
  in penctrl_device
- Code simplification and clarity from review inputs
- Set penctrl_spi_driver.driver.name to match compatible pensando-elba-ctrl
- Remove unused include in amd-pensando-ctrl.h
- Rebase to linux-next 6.4.0-rc1 class_create() API change
 
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
 drivers/soc/amd/pensando-ctrl.c        | 368 +++++++++++++++++++++++++
 include/uapi/linux/amd-pensando-ctrl.h |  29 ++
 6 files changed, 417 insertions(+)
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
index 000000000000..a7ddd181dfe8
--- /dev/null
+++ b/drivers/soc/amd/pensando-ctrl.c
@@ -0,0 +1,368 @@
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
+
+#include <linux/amd-pensando-ctrl.h>
+
+struct penctrl_device {
+	struct reset_controller_dev rcdev;
+	struct spi_device *spi;
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
+	if (((_IOC_DIR(cmd) & _IOC_READ)) && !access_ok(in_arg, _IOC_SIZE(cmd)))
+		return -EFAULT;
+
+	if (((_IOC_DIR(cmd) & _IOC_WRITE)) && !access_ok(in_arg, _IOC_SIZE(cmd)))
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
+	if (num_msgs > 2 || size == 0 || size % sizeof(struct penctrl_spi_xfer)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
+	if (IS_ERR(msg)) {
+		ret = PTR_ERR(msg);
+		goto out_unlock;
+	}
+	if (msg->len > PENCTRL_MAX_MSG_LEN) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	t[0].tx_buf = tx_buf;
+	t[0].len = msg->len;
+	if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+	if (num_msgs > 1) {
+		msg++;
+		if (msg->len > PENCTRL_MAX_MSG_LEN) {
+			ret = -EINVAL;
+			goto out_unlock;
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
+		goto out_unlock;
+
+	if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
+		ret = -EFAULT;
+
+out_unlock:
+	spi_dev_put(spi);
+	return ret;
+}
+
+static int penctrl_open(struct inode *inode, struct file *filp)
+{
+	struct spi_device *spi;
+	u8 current_cs;
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
+	t[0].len = sizeof(txbuf);
+
+	rxbuf[0] = 0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = sizeof(rxbuf);
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
+	struct spi_transfer t = {};
+	struct spi_message m;
+	u8 txbuf[4];
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t.tx_buf = txbuf;
+	t.len = sizeof(txbuf);
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
+		goto out_unlock;
+	}
+
+	val |= BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi->dev, "error writing ctrl0 reg\n");
+
+out_unlock:
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
+		goto out_unlock;
+	}
+
+	val &= ~BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi->dev, "error writing ctrl0 reg\n");
+
+out_unlock:
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
+	penctrl_class = class_create("penctrl");
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
+	/* Register reset controller */
+	penctrl->rcdev.dev = &spi->dev;
+	penctrl->rcdev.ops = &penctrl_reset_ops;
+	penctrl->rcdev.owner = THIS_MODULE;
+	penctrl->rcdev.of_node = spi->dev.of_node;
+	penctrl->rcdev.nr_resets = 1;
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
+		.name = "pensando-elba-ctrl",
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
index 000000000000..e5f9f0dfe146
--- /dev/null
+++ b/include/uapi/linux/amd-pensando-ctrl.h
@@ -0,0 +1,29 @@
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

