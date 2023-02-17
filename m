Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A769AC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBQN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:28:47 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564D62404;
        Fri, 17 Feb 2023 05:28:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1y8ke9eGtWMHlbSjHibYi/49myi6NmxnzzNa3tbjvdjAzNEJEIOS7xF13A8wmo2LdTBzBFcSEX30gTtKjuJXZuaY4H8W52VJtyGJ5ouSOiT8kW7jVeRNrwjBUn2iw2LPy5LLqL75KI1rDBM12U7HnMnS+Ele0u3jdTvkYAx07N/+ZO2oxSJkLHPKbdCm2/xIIo7iXzQ5VWX93LxNLFme/YTn/i1tspAYnpP4IrcBBvCODxfAwOHDINGnQEH/bnWwwvxF48UNtMd9PxlC6VORBH+weTLE3hzUyd30OpogYLuaEwMVOevq1tb2wQyLYFoe7eEK2c/4dSaTSoUOvwJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcw+JaoNx6Nr2f/SbqW42xKzIPkGvxi/5Gu68qiPrRo=;
 b=mxqmyQ1ZTBvw3RLUUkGcsa8L6JoghNEC7r9v2U652JKrz/Td1B7A38xPhGJI2uxCP5Gk9W6c3+HeAd4LFx6JW77lknrn8cqt0xf4QDime8vKJ+Vc6U8hkjsoKKmsyu8FUpxMEC1sVQSUda7THlJPv2aXCoNEb4VVI3nHgkYZy1ZAPjpgM5HGfbbcfh4EYePDRVU2niU734tOgJK8scNaqRRNdbpvWAmPtiudFwvRej4FflAax7bEVl95RFB7V07PgNkWricGSprZVIcJTXtIdkeQY/hisLmQvg8jextaHTWzoeQrRVnZLFmOv+CWCN668TvZAUhPbTnM6c8OJwVDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcw+JaoNx6Nr2f/SbqW42xKzIPkGvxi/5Gu68qiPrRo=;
 b=OyCYU67eMTbjGztwvLhiHPG/L6MTt8l1+zvt5YILqKiDO29RCjGo5VtJhvcnApXs3/pPU33EdkUHZ9YWB/ycRJp2RNneOGMAVBaIXAuxtMcWT5073Ku4LZkqlA69gDhgia7LJFNHFsuD0+i8btd5Dr2OsEY0VaJOETJro3PZy9Y=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 13:28:42 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::55) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Fri, 17 Feb 2023 13:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.15 via Frontend Transport; Fri, 17 Feb 2023 13:28:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 07:28:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 05:28:40 -0800
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 07:28:31 -0600
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v8 0/7] add support for CDX bus
Date:   Fri, 17 Feb 2023 18:58:23 +0530
Message-ID: <20230217132830.3140439-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: dffa7434-a2f3-4915-78a6-08db10eae325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzH8qg3QaMoqPlNjnFR49yzAgM/lKxVoNh5uiml9PIYwRZOVxIjnCqNQGZIKcCdr2yShzfCWiZBwDawZIxOW/vU+7cGpKNjf6Y0HKpnMRGhckJClUAupwkMDvOwksusZz3wmMHh+7P7EcNIKSHwa8R1lPxL51x4+QP66UQ8OC4YucFYM0fxZG0UEtH6ldQuac7Dd9ksHSyAVBBEG1JMS/9GNPHMeJh+Cws18BAoVKZXTSu2QHS9JFub252cfwJoL+Q/iiLekae2oaoeO6yqmgLlXSTebZf6kHhxAlhH6995PX/XDRQiv7hykDLVqFIzLQ3afx1QfhaFVqbRSTWni1H8gmIHGXRYiUuA9idgtecem90Iqp6jpYwYvWUBvTTPxFEr9svDQC/EnKT35MaoXzxdxlhRNoeSMehmzhV7Z8Te+C2gWwDVhbYKUOjIPlrTb7jBrdX+fwzFrJ2JzWdVJptyxnm7jZU3eq/ZV5EXiHUcPs0mKArJxwG6qG99FfI9LPheSJbN7BCQCgO3Gek1+zh7jqAMGBGkJFOloxauoZua82KlFUheP2Rmi6G8W6yAbKV5FAwXvE62RJ419rA1A1kG/mT7WJb3QqVJ817qixp76MDBrW1kpE+e3mTXC22dgPpXVyp9FTiKHofpkgiJIsY6nlZzncnt28Egly7F+ms+xsXFd21rShh2eFmkZI+C4t5yhrCWdg5oWFEuFQJN6loMM4DiqSWSUS3xrvTT4w4RGYu0skQTdvNmc5Rb+hQ/XqDLUwAyGLoHom8Kr4jjXzo9pmljxOMvD/dtMXW7wWrwLQwlwT3GyrnJ/L7+d/cKlF9fjgEgrmoJpxbN1e5+TzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(2616005)(336012)(86362001)(83380400001)(2906002)(44832011)(426003)(82310400005)(36756003)(47076005)(966005)(6666004)(1076003)(478600001)(186003)(26005)(70206006)(356005)(40460700003)(921005)(81166007)(36860700001)(82740400003)(5660300002)(4326008)(7416002)(8936002)(41300700001)(70586007)(8676002)(316002)(110136005)(54906003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:28:42.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dffa7434-a2f3-4915-78a6-08db10eae325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

v7 patch series is at:
https://lore.kernel.org/linux-arm-kernel/20230131084049.23698-1-nipun.gupta@amd.com/

Changes v7 -> v8
- Add ranges property in yaml

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


Abhijit Gangurde (1):
  cdx: add rpmsg communication channel for CDX

Nipun Gupta (6):
  cdx: add the cdx bus driver
  iommu/arm-smmu-v3: support ops registration for CDX bus
  dt-bindings: bus: add CDX bus controller for versal net
  cdx: add MCDI protocol interface for firmware interaction
  cdx: add cdx controller
  cdx: add device attributes

 Documentation/ABI/testing/sysfs-bus-cdx       |  56 ++
 .../bindings/bus/xlnx,versal-net-cdx.yaml     |  82 ++
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cdx/Kconfig                           |  19 +
 drivers/cdx/Makefile                          |   8 +
 drivers/cdx/cdx.c                             | 553 +++++++++++
 drivers/cdx/cdx.h                             |  62 ++
 drivers/cdx/controller/Kconfig                |  30 +
 drivers/cdx/controller/Makefile               |   9 +
 drivers/cdx/controller/bitfield.h             |  90 ++
 drivers/cdx/controller/cdx_controller.c       | 230 +++++
 drivers/cdx/controller/cdx_controller.h       |  30 +
 drivers/cdx/controller/cdx_rpmsg.c            | 202 ++++
 drivers/cdx/controller/mc_cdx_pcol.h          | 590 ++++++++++++
 drivers/cdx/controller/mcdi.c                 | 911 ++++++++++++++++++
 drivers/cdx/controller/mcdi.h                 | 247 +++++
 drivers/cdx/controller/mcdi_functions.c       | 139 +++
 drivers/cdx/controller/mcdi_functions.h       |  61 ++
 drivers/iommu/iommu.c                         |   4 +
 include/linux/cdx/cdx_bus.h                   | 174 ++++
 include/linux/mod_devicetable.h               |  15 +
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  12 +
 25 files changed, 3539 insertions(+)
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
2.25.1

