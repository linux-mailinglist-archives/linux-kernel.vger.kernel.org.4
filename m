Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C6703C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbjEOSSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244687AbjEOSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:17:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145518C94;
        Mon, 15 May 2023 11:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIe7U6Fn6pwQvPK4CHgmfLxwwdYbCcgOGDAKEqxCVKirPnUVuttY/38MiKRQ3WFyiODPM1orHfYCMgfldUYLI1aZuW48VQQd4qiiG+lt4o4x3ApU8Bo76j0epmSW02+eWcZILxyF6AJkqTJcJt7e+2eb0ZRKML42DxUf3VWaML+0NSciNZSMGsRq7zYT1hg5B/53gc6vkwzGmn3TArHAUFhfdgsWOEsPN7LUjLpke50zS2Uw3sfV1hsA9/cZO+KBKVBONoyz2W0uLVDLW5/bg2XeyRJNf5i9DquMaindYtsVaawdNClj6K3YmlcGztj0JKWhCiIEEdAVciKm9iv7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvxOVMt0RfgkEGpl3ePcj3viMO2GZI1F58LazZmHXJk=;
 b=m/RJEG7uWu4y2ZGICM/V/kCksiPJhFtOPkfPnS9t7EGEhlR9l/bNl3XRqz2glUejw4ARopxJXVwY2wOug0M2nPt/F84W0zK7K8ci86LwmF6zGrhuVi04rUgYvMWGQU8rNCSiUhdKJ8gQWoxmfNClSsrHZrVI3yxCL1kRRmq1KDQMZGUuAM5SFwVO9bwyOXBnE+iDM2yiAMzJIZCoZdg5ZR1+GQBYOMq+e5AXi2pyypriDemDOKZx2SinCwj4XQ6mv4Qsv3zjjJXWokWfN9S1danVkTlXauZaj9nYBwbFPZlGSUgSVncagpPlkGtw0qSSz8lWfCvWqXUtZ3AXlX3VnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvxOVMt0RfgkEGpl3ePcj3viMO2GZI1F58LazZmHXJk=;
 b=MCLuG5SSQ/kM/aCMLklOLof3Jv7TdjTNWJztFm97Hc846iHn8KjTxJLSOWoKWw9YHfg3b7Pgqwf26M/uGqsqj3C/ujDu9H4+wULJ9lkU7QpB8CiKMkk/ItJHM/zkaZ8Fq4p6ZeGeyRutJ4V10W677h6Mc7gFJZ71+olDsc1p73M=
Received: from MW4PR03CA0193.namprd03.prod.outlook.com (2603:10b6:303:b8::18)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:16:23 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::a3) by MW4PR03CA0193.outlook.office365.com
 (2603:10b6:303:b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 18:16:23 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:16:18 -0500
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
Subject: [PATCH v14 0/8] Support AMD Pensando Elba SoC
Date:   Mon, 15 May 2023 11:15:58 -0700
Message-ID: <20230515181606.65953-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adcdd79-c6f8-4ed1-e13e-08db55707dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgOF5uofClmWugSd6IBLuBbg4G9oqbotsu3bk0mZZhUZk7h7HlOK4Zq09LDhjgkMKAihr8DRHbnzD47VpbPjAzFHpPslB1qGEXuK8ElQ7qLy3bDtkcL44qr8l7LRH6CXhxNdn1TLt/uVstsCHB/LJXK0pe8McR1BdGiuC7ceY5wukgUhT4A36Es5symFca3qicYre36dOZxvXQ9JZBgqkNXjtwaQzgcL3/NmkBtQWCWEtzSKqNqWMbbDn7P2ansjQ7xjVnJCv+qIXKSbkUk0SPsxQQ2YYnMcX9arCH+t63dZ0gx1LHw+11f9EG446LyqVyHw5KeAlELvmC5XFJG2w/PP0CoYoRWPc8KFK+DNs+NUB5i0MsGdcHO+WTJaYnSa6j2gfIVvAqbN2xxc+8TTctj0uA9GclL18VzSOB84s+UynHxdE7zwU+ZKCiJ6C0hlgJoi1bAxMchL/iWuIpQlNTMcEs+7O34UEVQ0OfV02EFRMV1UWVQMkVeVqrlqejcChnXjqj8zmrYzt6XulkXwX+sp6VDR2P4mWkkea9pXnWO9IfdoLUe4RWasX1u/Vv5H2WLBNs2nkT9pM+Lu+CrY5e3rzvtwn9Ut20z672kth+/wux925Abcbg9DB4ESrTiUm3csznwpWCO8Nb1ddpWCn+PiuFBFbQwS8/vryvVP4c9ZO2YZPlblIz4t69Sz+A5CtqGSki6uB1dw/K4y18xktUZ9/T8em87JgDT6EufMA48hg5hMPMONHdVw1iGWxNYJRjiLGARQ3fT84x5Ap/5qwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(19627235002)(54906003)(316002)(4326008)(6916009)(70206006)(70586007)(966005)(478600001)(81166007)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(30864003)(2906002)(7406005)(7416002)(356005)(82740400003)(41300700001)(16526019)(2616005)(1076003)(186003)(26005)(336012)(36860700001)(83380400001)(426003)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:16:23.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adcdd79-c6f8-4ed1-e13e-08db55707dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

== V14 changes ==
Updated email list using get_maintainer.pl

Rebase to 6.4.0-rc1 and drop these patches (merged into 6.4.0)
- v13-0002-dt-bindings-mmc-cdns-Add-AMD-Pensando-Elba-SoC.patch
- v13-0004-dt-bindings-spi-dw-Add-AMD-Pensando-Elba-SoC-SPI.patch
- v13-0010-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC.patch
- v13-0011-mmc-sdhci-cadence-Enable-device-specific-overrid.patch
- v13-0012-mmc-sdhci-cadence-Support-device-specific-init-d.patch
- v13-0013-mmc-sdhci-cadence-Add-AMD-Pensando-Elba-SoC-supp.patch
- v13-0014-mmc-sdhci-cadence-Support-mmc-hardware-reset.patch

v14-0003-dt-bindings-soc-amd-amd-pensando-elba-ctrl-Add-P.patch
- Change GPL-2.0-only or BSD-2-Clause to GPL-2.0-only OR BSD-2-Clause

v14-0006-arm64-dts-Add-AMD-Pensando-Elba-SoC-support.patch
- Fix dtbs_check l2-cache* property issue by adding required
  cache-level and cache-unified properties
- Observed the issue after updating dtschema from 2023.1 to 2023.4
  and yamllint from 1.26.3 to 1.30.0

v14-0008-soc-amd-Add-support-for-AMD-Pensando-SoC-Control.patch
- Save 8 bytes of code size by swapping spi_device and reset_controller_dev
  in penctrl_device
- Code simplification and clarity from review inputs
- Set penctrl_spi_driver.driver.name to match compatible pensando-elba-ctrl
- Remove unused include in amd-pensando-ctrl.h
- Fix compile error, class_create() API changed

== V13 changes ==
v13-0013-mmc-sdhci-cadence-Add-AMD-Pensando-Elba-SoC-supp
- Use GENMASK(7, 3) in elba_priv_writel() to set all byte enables 
- Add a variable 'shift' with GENMASK(1, 0) in elba_write_w() and
  elba_write_b() to set the byte enable variable.

v13-0015-soc-amd-Add-support-for-AMD-Pensando-SoC-Control
- Update include list in pensando-ctrl.c
- Change variable spi_dev to spi throughout
- Removed unneeded variable initialization, simplification of
  error checks, remove extra castings, and use dev_err_probe()
- Sort the includes in amd-pensando-ctrl.h
- Updates to cleanup if there is an error in penctrl_spi_probe()

== V12 changes ==
v12-0004-dt-bindings-spi-dw-Add-AMD-Pensando-Elba-SoC-SPI
- Correct property amd,pensando-elba-syscon description

v12-0010-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC
- Add a newline in function dw_spi_elba_init()

v12-0015-soc-amd-Add-support-for-AMD-Pensando-SoC-Control
- Fix gcc-12.1.0 warning:

== V11 changes ==
v11-0002-dt-bindings-mmc-cdns-Add-AMD-Pensando-Elba-SoC
- Remove resets description and reset-names
- Add descriptions for amd,pensando-elba-sd4hc reg items

v11-0003-dt-bindings-spi-cdns-Add-compatible-for-AMD-Pens
- Removed redundant if/then for amd,pensando-elba-qspi

v11-0005-dt-bindings-soc-amd-amd-pensando-elba-ctrl-Add-P
- Fixed the compatible which should have stayed as
  'amd,pensando-elba-ctrl', the commit message, and the filename.
- Reference spi-peripheral-props
- Delete spi-max-frequency
- Remove num-cs from example

v11-0008-arm64-dts-Add-AMD-Pensando-Elba-SoC-support
- Delete reset-names
- Fix spi0 compatible to be specific 'amd,pensando-elba-ctrl'

v11-0010-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC
- Simplify dw_spi_elb_init by using syscon_regmap_lookup_by_phandle()

v11-0013-mmc-sdhci-cadence-Add-AMD-Pensando-Elba-SoC-supp
- Remove elba-drv_init() call to platform_get_resource() since that
  check is done inside devm_platform_ioremap_resource()
- Move spin_lock_init() before error check
- Remove extra parentheses

v11-0015-soc-amd-Add-support-for-AMD-Pensando-SoC-Control
- Fix the compatible to be specific 'amd,pensando-elba-ctrl'
- Cast arguments flagged with a gcc-12.1.0 warning:
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303061526.I8VPcR1M-lkp@intel.com/

== V10 changes ==
Binding property amd,pensando-elba-syscon was merged in 6.2

v10-0002-dt-bindings-mmc-cdns-Add-AMD-Pensando-Elba-SoC
- Move reset-names property definition next to existing resets prop
- Move allOf to the bottom and set resets/reset-names required only for pensando
- Fix reg maxItems for existing, must be 1

v10-0003-dt-bindings-spi-cdns-Add-compatible-for-AMD-Pens
- Fix cdns,fifo-depth, only amd,pensando-elba-qspi is 1024 bytes

v10-0004-dt-bindings-spi-dw-Add-AMD-Pensando-Elba-SoC-SPI
- Move definition of amd,pensando-elba-syscon into properties with a better description
- Add amd,pensando-elba-syscon: false for non elba designs

v10-0005-dt-bindings-soc-amd-amd-pensando-elbasr-Add-AMD-
- Property renamed to amd,pensando-ctrl
- Driver is renamed and moved to soc/drivers/amd affecting binding
- Delete cs property, driver handles device node creation from parent num-cs
  fixing schema reg error in a different way

v10-0010-spi-dw-Add-support-for-AMD-Pensando-Elba-SoC
- Delete struct dw_spi_elba, use regmap directly in priv

v10-0011-mmc-sdhci-cadence-Enable-device-specific-overrid
- The 1st patch adding private writel() is unchanged.  The 2nd patch is split
  into two patches to provide for device specific init in one patch with no
  effect on existing designs.  Then add the pensando support into the next patch.
  Then the 4th patch is mmc hardware reset support which is unchanged.

v10-0012-mmc-sdhci-cadence-Support-device-specific-init-i
- New patch to provide for platform specific init() with no change
  to existing designs.

v10-0013-mmc-sdhci-cadence-Add-AMD-Pensando-Elba-SoC-supp
- Add Elba specific support into this 3rd patch.  This builds on the private
  writel() enabled in patch 1 followed by platform specific init() in patch 2.
- Specify when first used the reason for the spinlock use to order byte-enable
  prior to write data.

v10-0015-soc-amd-Add-support-for-AMD-Pensando-SoC-Control
- Different driver implementation specific to this Pensando controller device.
- Moved to soc/amd directory under new name based on guidance.  This driver is
  of no use to any design other than all Pensando SoC based cards.
- Removed use of builtin_driver, can be built as a module.

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

Brad Larson (8):
  dt-bindings: arm: add AMD Pensando boards
  dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
  dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC
    Controller
  MAINTAINERS: Add entry for AMD PENSANDO
  arm64: Add config for AMD Pensando SoC platforms
  arm64: dts: Add AMD Pensando Elba SoC support
  spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
  soc: amd: Add support for AMD Pensando SoC Controller

 .../devicetree/bindings/arm/amd,pensando.yaml |  26 ++
 .../soc/amd/amd,pensando-elba-ctrl.yaml       |  58 +++
 .../bindings/spi/cdns,qspi-nor.yaml           |  18 +-
 MAINTAINERS                                   |   9 +
 arch/arm64/Kconfig.platforms                  |  12 +
 arch/arm64/boot/dts/amd/Makefile              |   1 +
 arch/arm64/boot/dts/amd/elba-16core.dtsi      | 197 ++++++++++
 arch/arm64/boot/dts/amd/elba-asic-common.dtsi |  80 ++++
 arch/arm64/boot/dts/amd/elba-asic.dts         |  28 ++
 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 +++++
 arch/arm64/boot/dts/amd/elba.dtsi             | 191 +++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/amd/Kconfig                       |  16 +
 drivers/soc/amd/Makefile                      |   2 +
 drivers/soc/amd/pensando-ctrl.c               | 368 ++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.c             |  19 +
 include/uapi/linux/amd-pensando-ctrl.h        |  29 ++
 18 files changed, 1160 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
 create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
 create mode 100644 drivers/soc/amd/Kconfig
 create mode 100644 drivers/soc/amd/Makefile
 create mode 100644 drivers/soc/amd/pensando-ctrl.c
 create mode 100644 include/uapi/linux/amd-pensando-ctrl.h


base-commit: e922ba281a8d84f640d8c8e18a385d032c19e185
-- 
2.17.1

