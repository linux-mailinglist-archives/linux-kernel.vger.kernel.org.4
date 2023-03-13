Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709736B78DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCMN0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCMN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:26:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC35559D1;
        Mon, 13 Mar 2023 06:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUQXDZ5c952uYNat2eokeIvY6dd8o9Cy3M0XCo2MgLIkSOZ39lPEtRtpnAxy784mHqOl2+s6fz5oOud7rNoWHnl2Xi+/MTs1Ymyztx4bs08FT52tAzy9lPYaTfGZNbslyh90GpPS9arRMm0pn6PGfwvJcesFR7BhdXrOy0fjWmzIYzXyrSCilDMXV187zRO70/5xpYf0SWBmWf62a3NQ0eYQJsbrVXz2SIJoJbT73/KF+X0pZcWmH9rI4SmaJGAuK+xvv+RmJcKCXr64MVsCHtj+GlpIw0HkjnIUl3857Z/4ddnao8grKSP8nlheVgMxPlhCT7oWM7RU4LZTVs2mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n85I1dKl4zP1X3miPPqG5Shf/a90Ba9NGbC1Q82mAwo=;
 b=m82fWf5tzUok2WhswngmIGNulfc4+oY3lWKFYksSTu6o0UqZD6KgiwB9FNM3vQiynaT62QwXXyXxgsJNcdUBfgn0mraAmbHU3a8BUI7Of4d2OClJlHi8UfyhDWq4/uObldChBZ9D4x83WtXHeEQFpFxHeTFclHMX8DX7gr3aFm6+iaDeo8FdydyJhDmdHXBU//7pDC1Qr8t6CmdtXEqtycE0RlC/UGCvMFO1qbHGonTPdarJgNrHZHXbcIIBhGNIFw9jqko/vA6wjoUojkpObsaPXcHbxoMyvPw6D2JazJpiDL2pOLz6cd4++HHuspEV9AJ1h37Pgvj/QulqsMKgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n85I1dKl4zP1X3miPPqG5Shf/a90Ba9NGbC1Q82mAwo=;
 b=GGYRWPRW5WpnU8JtnXlvryIYLSS7WLluXtJdTpzLCL4szd0/m6Szna0ChBjxBPfNFbwRrJoGFJkHlAHWg38PBXIHQ+5KVnPoZjPDk+wXJHAGbFj37oDh+CiMgO1Itq0TKs9GAE9Vyf3NM+o65oR2ilR8Jk8DhH/ghL8XBJX0Zpw=
Received: from MN2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:208:23c::13)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:26:47 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::e) by MN2PR18CA0008.outlook.office365.com
 (2603:10b6:208:23c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Mon, 13 Mar 2023 13:26:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:26:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 06:26:45 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Mar 2023 08:26:36 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, <song.bao.hua@hisilicon.com>,
        <mchehab+huawei@kernel.org>, <maz@kernel.org>,
        <f.fainelli@gmail.com>, <jeffrey.l.hugo@gmail.com>,
        <saravanak@google.com>, <Michael.Srba@seznam.cz>,
        <mani@kernel.org>, <yishaih@nvidia.com>, <jgg@ziepe.ca>,
        <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <masahiroy@kernel.org>,
        <ndesaulniers@google.com>, <rdunlap@infradead.org>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v10 0/7] add support for CDX bus
Date:   Mon, 13 Mar 2023 18:56:29 +0530
Message-ID: <20230313132636.31850-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: c41f2ab4-2771-411b-8a27-08db23c69811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLeeLLPYBSEWZMk3xcRuK7hQW4vcUP6bCqMTVRb9i8H6rZJZVz6/NZJYHFi0X6L6jdDZZXH1yJsnGfo5ordeO/V7VPInCRgzkYEBwHwpZ2Ik2iZPAhRhiiXf3lCnDEVs2WYbHwnM/Iu+BuaqQmk3b/7TD7utz8rPWO3Gn1DcmBDGI1+hWFAoCnomotE3x5M0YKJetQcMxiFwK0kKicwVd/h9MT1TBBpg9RXAAVJsfgWPWYdxWMTssakUpxImRfJ58g3ywER3h7xGgVSwrtDD1p5XlopsbrPktdqC8aoqNhPC+t/uEshCuue7J3xprvIUQM4KT4HldGutiD/Y9mk6w1Nzv9Cl/Y43tOmr5qSBZ9701rvVjsub1/Dqa+/1lIFMbXrCI8u9DQdSChryR7BMkAEn1f+RnEH3IgHVM9oLlrNz5h2dbmCeOGzIkLK12bD+d4aPY1k7GNuqdSZ+UQDpTEqnxFVonmvytFqTug+ocosGDq+HTjypYk4GUfzSAz+gCO0hxlO/pvXfCIok/JOD3ITqwrS1m/wooK9FaDDaQT5ZCh8cOO3mcL4NHD2z7ir+Tp0rUPtPL6DR7ibosWuLG2T+w/0d7//cuqAFeaR+UDm4daTPiTqFNXcbjkhIOkLn2RG00yjyDQCa1PZSzbMXkFyV/D9QEs4sHVngGIV+XNMkis28Ps/TJJbnUWRC1WSrGX3UQPODNWaQ9rDhrKHUPJD8Va1svi3+nqYxtwSITgXFedCaanHnxxFtTd/aXpod2jzmkf9fPGxo47dI6GPBzZLufnbJkHAp4SrcuIujQesxVOP8IkX4istk7ro4LBjnEDezXtUwHkJcrp7p2fPOpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(426003)(36860700001)(82310400005)(356005)(921005)(2906002)(70206006)(41300700001)(8676002)(70586007)(40480700001)(40460700003)(4326008)(478600001)(316002)(36756003)(86362001)(54906003)(110136005)(81166007)(966005)(47076005)(5660300002)(44832011)(26005)(2616005)(336012)(186003)(7416002)(7406005)(1076003)(6666004)(8936002)(83380400001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:26:46.4059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f2ab4-2771-411b-8a27-08db23c69811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce AMD CDX bus, which provides a mechanism to
discover/rescan CDX devices. The CDX devices are 
memory mapped on system bus for embedded CPUs.

CDX controller interacts with the firmware to query different
CDX devices present in the Fabric and expose them to the Linux
host on CDX bus.

This patch series:
- Introduces the CDX bus and CDX devices.
- Device tree binding for CDX controller
- Support for CDX bus in arm-smmu-v3 driver
- Add MCDI (Management CPU Driver Interface) as a protocol
  for communication with RPU Firmware
- Support RPMSg channel for Firmware communication

v9 patch series is at:
https://lore.kernel.org/lkml/20230307131917.30605-1-nipun.gupta@amd.com/

Changes v9 -> v10
- Update sysfs entries description to be more specific w.r.t.
  setting their values and the output type.
- Use kstrtobool() instead of kstrtoul() for sysfs processing
  of boolean sysfs entries.
- Update driver override to use pre-defined driver_set_override()
  API.
- Update the name of patch (PATCH 2/7 - iommu: Add iommu probe
  for CDX bus)

Changes v8 -> v9
- Update the name of patch (PATCH 2/7 - iommu: Support ops
  registration for CDX bus)
- update a log print and return variable names

Changes v7 -> v8
- Add ranges property in device tree bindings

Changes v6 -> v7
- Fix compilation for x86 environment in case CDX bus is enabled
- Fixed crash in reset if device is not bound to any device driver
- Update sysfs with typo and other minor changes
- Removed header file issue reported by make versioncheck

Changes v5 -> v6
- updated compatible name in the CDX dt-binding
- updated reset CDX device and removed redundant function
- moved from drivers/bus/cdx to drivers/cdx
- used xarray instead of controller list and ID
- updated sysfs documentation with more details

Changes RFC v4 -> v5
- Fixed device tree documentation
- Add MCDI as a protocol and RPMsg as transport for communication
  with RPU Firmware instead of using MCDI stubs.
- MSI patches for CDX are not added in this series as it's
  support is being revisited as per patch series:
  https://lore.kernel.org/all/20221111133158.196269823@linutronix.de/
  It will be added as separate patches.

Changes RFC v3 -> RFC v4: 
 - Separate CDX bus and CDX controller driver (Greg K-H)
 - Added MSI interfacing to Firmware for writing MSI message
   to firmware so it can be provided to the device.
 - Fix MSI review comments - multiple cleanups (Mark Zynger)
 - Fix the device tree yaml compilation (Rob Herring, Krzysztof)
 - removed vfio-cdx from this series. It will be added after bus 
   support is complete (Jason)

Changes RFC v2 -> RFC v3: 
- Move CDX bus as a new bus type in kernel rather than
  using the platform devices (Greg K-H, Marc Zynger)
- Correspondingly update ARM SMMU v3
- Add support for vfio-cdx driver
- Updated device tree yaml with correct binding information
  (Krzysztof Kozlowski)
- remove 'compatible' sysfs platform patch which was required
  for CDX devices exposed as platform devices

Changes RFC v1 -> RFC v2: 
- introduce CDX bus infrastructure
- fixed code for making compatible visible for devices
  having the 'compatible' property only (Greg K-H)
- moved CDX-MSI domain as part of CDX bus infrastructure.
  previously it was part of irqchip (Marc Zynger).
- fixed few prints (Greg K-H)
- support rescan and reset of CDX bus 
- add VFIO reset module for CDX bus based devices

Nipun Gupta (7):
  cdx: add the cdx bus driver
  iommu: Add iommu probe for CDX bus
  dt-bindings: bus: add CDX bus controller for versal net
  cdx: add MCDI protocol interface for firmware interaction
  cdx: add cdx controller
  cdx: add rpmsg communication channel for CDX
  cdx: add device attributes

 Documentation/ABI/testing/sysfs-bus-cdx       |  56 ++
 .../bindings/bus/xlnx,versal-net-cdx.yaml     |  82 ++
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cdx/Kconfig                           |  19 +
 drivers/cdx/Makefile                          |   8 +
 drivers/cdx/cdx.c                             | 535 +++++++++++
 drivers/cdx/cdx.h                             |  62 ++
 drivers/cdx/controller/Kconfig                |  31 +
 drivers/cdx/controller/Makefile               |   9 +
 drivers/cdx/controller/bitfield.h             |  90 ++
 drivers/cdx/controller/cdx_controller.c       | 230 +++++
 drivers/cdx/controller/cdx_controller.h       |  30 +
 drivers/cdx/controller/cdx_rpmsg.c            | 202 ++++
 drivers/cdx/controller/mc_cdx_pcol.h          | 590 ++++++++++++
 drivers/cdx/controller/mcdi.c                 | 903 ++++++++++++++++++
 drivers/cdx/controller/mcdi.h                 | 248 +++++
 drivers/cdx/controller/mcdi_functions.c       | 139 +++
 drivers/cdx/controller/mcdi_functions.h       |  61 ++
 drivers/iommu/iommu.c                         |   4 +
 include/linux/cdx/cdx_bus.h                   | 174 ++++
 include/linux/mod_devicetable.h               |  15 +
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  12 +
 25 files changed, 3515 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
 create mode 100644 drivers/cdx/Kconfig
 create mode 100644 drivers/cdx/Makefile
 create mode 100644 drivers/cdx/cdx.c
 create mode 100644 drivers/cdx/cdx.h
 create mode 100644 drivers/cdx/controller/Kconfig
 create mode 100644 drivers/cdx/controller/Makefile
 create mode 100644 drivers/cdx/controller/bitfield.h
 create mode 100644 drivers/cdx/controller/cdx_controller.c
 create mode 100644 drivers/cdx/controller/cdx_controller.h
 create mode 100644 drivers/cdx/controller/cdx_rpmsg.c
 create mode 100644 drivers/cdx/controller/mc_cdx_pcol.h
 create mode 100644 drivers/cdx/controller/mcdi.c
 create mode 100644 drivers/cdx/controller/mcdi.h
 create mode 100644 drivers/cdx/controller/mcdi_functions.c
 create mode 100644 drivers/cdx/controller/mcdi_functions.h
 create mode 100644 include/linux/cdx/cdx_bus.h

-- 
2.17.1

