Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5CF673025
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjASE1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjASD4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:56:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A899D4995D;
        Wed, 18 Jan 2023 19:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTZkGYnUPjyB/pjVRgP5pjDGX2/z7nU8N3xmzUysMqEmaTA+oyqN5Kd3N3zVT2FBA+BJXtne8iEzccy+f/3TufuSvz1xvE+D4gDxFH2kVJ6FCV6lJRKwi0An5ZdolQrPWomdtRWS7lWHX87CS9/5ugAvs8FHv1Vhew42VKvgVrKvvg+5fU12knM1GOlRrsJElNIrBKOQIFhnC2eT6fKyZzJv8o6fH+381S8UEjuTbVLAu6cJjU0VPnWjwqj9YZ1FAZyu8DvwruXETrcJwKrG35XxPy2IsSVQUcHEgzAMhdaAcmmwjzA6R1A+fIHFUindxsxb2iADSxxunZJfKFj2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xnmV3pjfo47eAWg4NT1HzixPPrWIZETdNEOcuAL2l4=;
 b=h1oBJCwmITFvEdLJDxoVouHVkicsk5H+GpmiwJxRkMlpj7VI6kW7HLvwhpD4co7OnZNXvX3JUihRgFyV8QgsEtMQx0FrNYicJTmsTdn79c6QsY6IdbJDbBsZxbJ2usJBpUcOC1rnHDR7kxbdEusNg2Yhd8FCSRvcl7mZ1q0H7VAKIozyClE6qerpcJ5evfq/3xMkEC+pmAMFNN2DrZqsyhv058UhFUV6strouvBFk6M723b+LDMwYPwhd7kgovbKYxQIh0TviOBvemjXO+47pZLaHS7mpgkKjKWl634d1+MeeupuNhjbGnRH7blb/LM4wBI3Gcv1KiPpWnzG/MB9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xnmV3pjfo47eAWg4NT1HzixPPrWIZETdNEOcuAL2l4=;
 b=ApC+vFpe1ttgFbShTSfhiPiVRoQ0Oyo9Wo1t7OO41UNjsuEMdc8mtc92dpvetnuJ4EyTQbTfI0IhebKfM4qAxMOEGYB8C2oH8+jo7I0gc6fhyqqFeP6SiDoSBJPopgpt/uDmW+cP4ssO1i2IF4K48iJCW04+deNyyvIgiOoDy9U=
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 03:52:14 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f4) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 03:52:13 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:02 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 00/15] Support AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:51:21 -0800
Message-ID: <20230119035136.21603-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee979e5-9a3c-4e0a-ad91-08daf9d08cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5EnuuIidZnzcdLoqcK6YV0FRDZtTHdLH41gWh47NWGKuBwaYClAn/Pqtf5tSaf5aEkOZoWWBhP07pncIkA8xqCbdw+68Jn5AIlrsUOy4KpOiR3QoqJXiwL8IfJJYfB06NmPs8xKTgFSKHC9dBVqU6NF1bRGF6XpQh1OHGh07HLF9EWhDoYuinaUp/G9UvXmKv2/DFme/v2e5WLt/xc57yZT87zC7f8vKRqlAXRQKiDH/WSZOlVyqy/CgRFYnxbgvhA9FbqPFVeWZ4/OvM0+XhTHQUlE0eVYOp2wdWearSt+Af4yKNseQw5lVHALHJhHqTMgCgopPInn/3DKlqRGNADN+o40VvrmdKJK3QV+AW4hKVHSjM5Piee9hxpqBaY6h3N34p8Wib23Re6dF+LmwUjXJNVgZnowfkKGzmZ75hvNXeUNexYAJvaSAUDLonBLTnPoxOqPRi/gmLlYzNfdrPNC2qNB9vzDtdXccpCPJRQ9Yydo81U4VAYjx3wVoRttlibRJkMzJzaSNwt56WI5jorqZf1tgtJlfBW7eIX935Xf2rgl2sC8WX3Ph9jqb5IRsIpexnNCzuyUqaTpUFrM45ibRjxu0secZYJnQ3eIQaBs9ou8OdTXGghOWIpmMURy80SHd1j8QSW/0xKvl2fTQeTroXGo3wvRXlMX2m6nEVCeI5Eg0HbGm1E+p+PdQQ2RDYka+tCaOTh9TgI8TbgYgUW1XjhRnE50+dDNm+OOAX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(316002)(5660300002)(40460700003)(6666004)(36756003)(478600001)(2906002)(19627235002)(2616005)(426003)(47076005)(54906003)(336012)(81166007)(83380400001)(1076003)(70206006)(7406005)(7416002)(70586007)(4326008)(6916009)(30864003)(40480700001)(82740400003)(8676002)(36860700001)(356005)(26005)(186003)(16526019)(82310400005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:13.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee979e5-9a3c-4e0a-ad91-08daf9d08cea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables support for AMD Pensando Elba SoC based platforms.

The Elba SoC has the following features:
- Sixteen ARM64 A72 cores
- Dual DDR 4/5 memory controllers
- 32 lanes of PCIe Gen3/4 to the Host
- Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
  also a single 1GE management port.
- Storage/crypto offloads and 144 programmable P4 cores.
- QSPI and EMMC for SoC storage
- Two SPI interfaces for peripheral management
- I2C bus for platform management

== V9 changes ==
v9-0002-dt-bindings-mmc-cdns-Add-AMD-Pensando-Elba-SoC
- Add reset-names and resets properties
- Add if/then on property amd,pensando-elba-sd4hc to set reg property
  values for minItems and maxItems

v9-0003-dt-bindings-spi-cdns-Add-compatible-for-AMD-Pensa
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

v9-0004-dt-bindings-spi-dw-Add-AMD-Pensando-Elba-SoC-SPI-
- Define property amd,pensando-elba-syscon
- Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi

v9-0006-dt-bindings-mfd-amd-pensando-elbasr-Add-AMD-Pensa
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs>

v9-0009-arm64-dts-Add-AMD-Pensando-Elba-SoC-support
- Single node for spi0 system-controller and squash
  the reset-controller child into parent

v9-0010-spi-cadence-quadspi-Add-compatible-for-AMD-Pensan
- Rebase to linux-next 6.2.0-rc1

v9-0011-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC
- Add use of macros GENMASK() and BIT()
- Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()

v9-0012-mmc-sdhci-cadence-Enable-device-specific-override
- No change to this patch but as some patches are deleted and this is
  a respin the three successive patches to sdhci-cadence.c are
  patches 12, 13, and 14 which do the following:
  1. Add ability for Cadence specific design to have priv writel().
  2. Add Elba SoC support that requires its own priv writel() for
     byte-lane control .
  3. Add support for mmc hardware reset.

v9-0014-mmc-sdhci-cadence-Support-mmc-hardware-reset
- Previously patch 17/17
- Changed delay after reset_control_assert() from 9 to 3 usec
- Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()

v9-0015-spi-pensando-sr-Add-AMD-Pensando-SoC-System-Resou
- Previously patch 14/17
- After the change to the device tree node and squashing
  reset-cells into the parent simplified this to not use
  any MFD API and move it to drivers/spi/pensando-sr.c.
- Change the naming to remove elba since this driver is common
  for all Pensando SoC designs .
- Default yes SPI_PENSANDO_SR for ARCH_PENSANDO


== V6 changes ==
- Updated copyright and SPDX

v6-0001-dt-bindings-arm-add-AMD-Pensando-boards
- Delete 'Device Tree Bindings' in title

v6-0002-dt-bindings-mmc-cdns-Add-AMD-Pensando-Elba-SoC
- Change if/then for Elba which has a second reg for byte-lane control

v6-0003-dt-bindings-spi-cdns-Add-compatible-for-AMD-Pensa
- no change

v6-0004-dt-bindings-spi-dw-Add-AMD-Pensando-Elba-SoC-SPI-
- Add amd,pensando-elba-syscon

v6-0005-dt-bindings-mfd-syscon-Add-amd-pensando-elba-sysc
- no change

v6-0006-dt-bindings-mfd-amd-pensando-elbasr-Add-AMD-Pensa
- Expand description, rename nodes and change compatible usage

v6-0007-dt-bindings-reset-amd-pensando-elbasr-reset-Add-A
- Delete nodename pattern and changed spi0 to spi
- File amd,pensando-elba-reset.h is deleted as there is only
  one reset used.
- Update example

v6-0008-MAINTAINERS-Add-entry-for-AMD-PENSANDO
- no change

v6-0009-arm64-Add-config-for-AMD-Pensando-SoC-platforms
- no change

v6-0010-arm64-dts-Add-AMD-Pensando-Elba-SoC-support
- Update node names and add amd,pensando-elba-syscon
- Delete use of amd,pensando-elba-reset.h which had a single definition

v6-0011-spi-cadence-quadspi-Add-compatible-for-AMD-Pensan
- Remove (void) cast

v6-0012-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC
- Update use of amd,pensando-elba-syscon

v6-0013-mmc-sdhci-cadence-Enable-device-specific-override
- Change this patch to add a priv_writel() callback where all
  existing designs use writel().  This separates the Elba
  support into three patches.  The second patch is added
  to the end of the sequence for Elba support.  The third
  patch enables mmc hardware reset.

v6-0014-mfd-pensando-elbasr-Add-AMD-Pensando-Elba-System-
- Updates from review comments
- Use spi_message_init_with_transfers instead of init/add_tail API

v6-0015-reset-elbasr-Add-AMD-Pensando-Elba-SR-Reset-Contr
- Remove use of amd,pensando-elba-reset.h and use BIT()

v6-0016-mmc-sdhci-cadence-Add-AMD-Pensando-Elba-SoC-suppo
- Elba sdhci-cadence.c support added in this patch to build on
  0013 which just adds a callback to override priv_writel()

v6-0017-mmc-sdhci-cadence-Support-mmc-hardware-reset
- New patch where Elba has a reset-controller for mmc hardware
  reset.  The reset is implemented by a register in the cpld.

== V5 changes ==
- Change to AMD Pensando instead of Pensando.
- No reference to spidev in the device tree.  Add multi-function driver
  pensando-elbasr and sub-device reset-elbasr which provides mfd and
  /dev interface to the cpld.
- Rebase to linux-next tag next-20220609 5.19.0-rc1
- Redo the email list after rebase and using scripts/get_maintainer.pl

== V4 changes ==
The version of dtschema used is 2022.3.2.

v4-0001-dt-bindings-arm-add-Pensando-boards.patch
- Add description and board compatible

v4-0003-dt-bindings-mmc-Add-Pensando-Elba-SoC-binding.patch
- Change from elba-emmc to elba-sd4hc to match file convention
- Use minItems: 1 and maxItems: 2 to pass schema check

v4-0005-dt-bindings-spi-dw-Add-Pensando-Elba-SoC-SPI-Control.patch
- Add required property pensando,syscon-spics to go with
  pensando,elba-spi

v4-0006-MAINTAINERS-Add-entry-for-PENSANDO.patch
- Change Maintained to Supported

v4-0007-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Fix a typo on interface max speed

v4-0008-spi-cadence-quadspi-Add-compatible-for-Pensando-Elba.patch
- Update due to spi-cadence-quadspi.c changes

v4-0009-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Change from elba-emmc to elba-sd4hc to match file convention

v4-0010-spi-dw-Add-support-for-Pensando-Elba-SoC.patch
- Use more descriptive dt property pensando,syscon-spics
- Minor changes from review input

v4-0011-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Changed to dual copyright (GPL-2.0+ OR MIT)
- Minor changes from review input

== V3 changes ==
v3-0001-gpio-Add-Elba-SoC-gpio-driver-for-spi-cs-control.patch
- This patch is deleted.  Elba SOC specific gpio spics control is
  integrated into spi-dw-mmio.c.

v3-0002-spi-cadence-quadspi-Add-QSPI-support-for-Pensando-El.patch
- Changed compatible to "pensando,elba-qspi" to be more descriptive
  in spi-cadence-quadspi.c.

- Arnd wondered if moving to DT properties for quirks may be the
  way to go.  Feedback I've received on other patches was don't
  mix two efforts in one patch so I'm currently just adding the
  Elba support to the current design.

v3-0003-spi-dw-Add-support-for-Pensando-Elba-SoC-SPI.patch
- Changed the implementation to use existing dw_spi_set_cs() and
  integrated Elba specific CS control into spi-dw-mmio.c.  The
  native designware support is for two chip-selects while Elba
  provides 4 chip-selects.  Instead of adding a new file for
  this support in gpio-elba-spics.c the support is in one
  file (spi-dw-mmio.c).

v3-0004-spidev-Add-Pensando-CPLD-compatible.patch
- This patch is deleted.  The addition of compatible "pensando,cpld"
  to spidev.c is not added and an existing compatible is used 
  in the device tree to enable.

v3-0005-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Ulf and Yamada-san agreed the amount of code for this support
  is not enough to need a new file.  The support is added into
  sdhci-cadence.c and new files sdhci-cadence-elba.c and
  sdhci-cadence.h are deleted.
- Redundant defines are removed (e.g. use SDHCI_CDNS_HRS04 and
  remove SDIO_REG_HRS4).
- Removed phy init function sd4_set_dlyvr() and used existing
  sdhci_cdns_phy_init(). Init values are from DT properties.
- Replace  devm_ioremap_resource(&pdev->dev, iomem)
     with  devm_platform_ioremap_resource(pdev, 1)
- Refactored the elba priv_writ_l() and elba_write_l() to
  remove a little redundant code.
- The config option CONFIG_MMC_SDHCI_CADENCE_ELBA goes away.
- Only C syntax and Elba functions are prefixed with elba_

v3-0006-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Added a little more info to the platform help text to assist
  users to decide on including platform support or not.

v3-0007-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Node names changed to DT generic names
- Changed from using 'spi@' which is reserved
- The elba-flash-parts.dtsi is kept separate as
  it is included in multiple dts files.
- SPDX license tags at the top of each file
- The compatible = "pensando,elba" and 'model' are
  now together in the board file.
- UIO nodes removed
- Ordered nodes by increasing unit address
- Removed an unreferenced container node.
- Dropped deprecated 'device_type' for uart0 node.

v3-0010-dt-bindings-spi-cadence-qspi-Add-support-for-Pensand.patch
- Updated since the latest documentation has been converted to yaml

v3-0011-dt-bindings-gpio-Add-Pensando-Elba-SoC-support.patch
- This patch is deleted since the Elba gpio spics is added to
  the spi dw driver and documented there.

Because of the deletion of patches and merging of code
the new patchset is not similar.  A changelog is added into
the patches for merged code to be helpful on the history.

== V2 changes ==
- 01    Fix typo, return code value and log message.
- 03    Remove else clause, intrinsic DW chip-select is never used.
- 08-11 Split out dts and bindings to sub-patches
- 10    Converted existing cadence-quadspi.txt to YAML schema
- 13    New driver should use <linux/gpio/driver.h>

Brad Larson (15):
  dt-bindings: arm: add AMD Pensando boards
  dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
  dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
  dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    bindings
  dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
  dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando System
    Resource chip
  MAINTAINERS: Add entry for AMD PENSANDO
  arm64: Add config for AMD Pensando SoC platforms
  arm64: dts: Add AMD Pensando Elba SoC support
  spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
  spi: dw: Add support for AMD Pensando Elba SoC
  mmc: sdhci-cadence: Enable device specific override of writel()
  mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
  mmc: sdhci-cadence: Support mmc hardware reset
  spi: pensando-sr: Add AMD Pensando SoC System Resource

 .../devicetree/bindings/arm/amd,pensando.yaml |  26 +
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  28 +-
 .../bindings/spi/amd,pensando-sr.yaml         |  68 +++
 .../bindings/spi/cdns,qspi-nor.yaml           |  14 +-
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  14 +
 MAINTAINERS                                   |   8 +
 arch/arm64/Kconfig.platforms                  |  12 +
 arch/arm64/boot/dts/amd/Makefile              |   1 +
 arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 ++++++++
 arch/arm64/boot/dts/amd/elba-asic-common.dtsi |  82 ++++
 arch/arm64/boot/dts/amd/elba-asic.dts         |  28 ++
 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++
 arch/arm64/boot/dts/amd/elba.dtsi             | 192 ++++++++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-cadence.c              | 180 ++++++-
 drivers/spi/Kconfig                           |  14 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-cadence-quadspi.c             |  19 +
 drivers/spi/spi-dw-mmio.c                     |  78 +++
 drivers/spi/spi-pensando-sr.c                 | 454 ++++++++++++++++++
 21 files changed, 1500 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
 create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
 create mode 100644 drivers/spi/spi-pensando-sr.c


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.17.1

