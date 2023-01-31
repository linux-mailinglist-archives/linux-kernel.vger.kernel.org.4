Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E824682735
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAaIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjAaIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:45:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E904ABD7;
        Tue, 31 Jan 2023 00:41:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPC1eQ/2NIrtZYMFzOL9MiOtvOn2VuWCkSfVtt6oZIsREp5+f0ZJU3sIVVsg5jfi4CDiod/TTv7ZRtU46CSAV8CkLPwYsCuFPjdIhdRTeJc7wxvAmFYbb2OkRo5Mq94sB1iojsuEfdKjzt3o4HevFHkGrRsOVHCUyn01HBgrGLdMQK37Gbol1niFhnnsqNvC9RankGYC1xSGK2O0/zPRAcXO6TbsJYM5rz0qxcabpttlTTnXHBBbeRgcUx0hzHm6WyamekWUua1p/95vsMdxD9SqAf4N4BitaSs3EqVPsqfUc2AmgIi0TRVk57Jc+U8pCw3tfE3aByRTEZ6X6saW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMEAvGUF26IfQapRYf4ZjCJ8Jfae2o7vBSaYXVlBM9I=;
 b=jE+Gifc2WSto+0Ws9+KI6p59+hmHSdZeRPk6zqwW6Lgmahb5gUM3RNv++D8NjFjbPvcURO5aPiWdZEpJOUNwe7jQyxgeVAb+M37/ohGDI/ARXbJko34YT/SkQ0IvrPyHGWCmPXMyKA2NzZeh+TfFH9yWtMiKDUDa/S9OGE7u2mjiF6IYmpUAELbY7XuTLM3BPsIOyU6FqKGPbKrlNvzBqQo2Ynp27fHwMY+nOvWUm6sUdkjdIhvUY2wDBE18vwp/3SZBkgbcwCVSMxUVWJWBTLRasTYKo8JHm98IcDls1LZjJ3bVi7ucJDYIw+xeRkVmo08bkmpYL732cjFIGmk1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMEAvGUF26IfQapRYf4ZjCJ8Jfae2o7vBSaYXVlBM9I=;
 b=hlIv6sxwyGMZHkt+RAGEyfXDBoeMR048gq957HqxNhwas7UC6L08beIXog/OX2u/SmbG8TUcplJR+t5yNOngI9a7DkR5bqB2iwmenK/WmE2l8jzo7UsJ9wTNCbcPbYk6KxReZC/2x78E+qS4Xscmlop9VGartyKkxB8I017wgso=
Received: from MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 08:41:00 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::8) by MW4PR03CA0292.outlook.office365.com
 (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 08:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.25 via Frontend Transport; Tue, 31 Jan 2023 08:41:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:40:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:40:57 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Jan 2023 02:40:50 -0600
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
Subject: [PATCH v7 0/7] add support for CDX bus
Date:   Tue, 31 Jan 2023 14:10:42 +0530
Message-ID: <20230131084049.23698-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c326d2-e240-47a7-b4f7-08db0366e16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOqeHjduwhQ+aPKOJ5R2wSkR9bBwtxm0Ysl2LJOfI11blFvd9o2pOO/azclGoaFM3UP0mOx8MytY/y7amx8bmO9THAUsYWhm/DP9glc/I2Mhrgs8EcBQlGbadUq6QzK9Ve2n8Deop6vxeyKQUBA+xzuhuEiCqgPLQYlkD2QtiyqYhaF8NqSAQD2xyRJcT6OGSthMGegMk9j+kLY9t8laYVCf4ONWClwrJz8/gu5l+V4fcIwthlLBChRFQw8wvn+arBYG+II4MS7jUlBQ6eDH0cR61ziBrFcl5WxGD8jCmPz7wLZ3GSaS4o1QhdADgwXeJvuCTf7KGmU38NBOr3tAHiNODZuTtfYVrQrnvoL5PKcj6gYNGQL57Q392iB7wGqPytPGTs0lA2X5y7HvAyAkcb1cfw8RlUnEAP2IBKRNdVNYmOzS+Spm27IKG6pzOH8YBwLIt8YlHH1romuWJoHizUw3921tGXymPTiEh28h5mfDYWeu9/DqHioWK72C2tZMMN0MocFupI2ARi8XOvOTXPakuFbi5rKmlbqIMNu/avzVdItEBzhPdJK6nw5j/jb04/ybnRkTQXOGuU5XiHPsaXmOQFbycdd1XAHENRmxR1eIuUATBe4G6kDhclhrwFm2yTtXPyB/XW/yMw+49l1GnRUREL2zoKZzNFKIh91b9IGtDRz/kBKeCgz47l/LG3E+K5BctWgbnuxMZvUZtToVzysWtj6nyXgIryp43baYX8io072jtQVnyq85ynskVj3AH2SK3gjcF7uaQdxtvNNwZbwgAnAPNfvV8Th7Sp/k/aX+JH5G9IQNTkLyi/oWsGi955Ct/D4xP6uQ7YtAtIgRLDlnsYpV0ymg3KC80dL9EIqVXBHB6vgSUVRyR/fVEQrz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(186003)(82310400005)(26005)(1076003)(36756003)(44832011)(5660300002)(41300700001)(7416002)(81166007)(70586007)(356005)(70206006)(54906003)(110136005)(316002)(921005)(6666004)(8936002)(4326008)(86362001)(40460700003)(36860700001)(336012)(83380400001)(426003)(2616005)(40480700001)(2906002)(8676002)(478600001)(966005)(82740400003)(47076005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:41:00.4909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c326d2-e240-47a7-b4f7-08db0366e16a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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

v6 patch series is at:
https://lore.kernel.org/lkml/20230117134139.1298-4-nipun.gupta@amd.com/T/

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
 .../bindings/bus/xlnx,versal-net-cdx.yaml     |  68 ++
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
 25 files changed, 3525 insertions(+)
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

