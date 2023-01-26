Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14267C8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjAZKqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjAZKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:46:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FC946D54;
        Thu, 26 Jan 2023 02:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odW00zrNy0R0f02hebO6ZOLtP73g+UVZ+HIODzH9hJae1OyQgii2G+v/D1FbOUVU74wciQ7Gb6sIm4tYzWV7NC/8dd96l9N0BaZ/PU5vdLE4tkGbdmq0zCo9N2FF4FwvAJrP5gi5KaB6GWx21Kdsf6n+ErfAGppBJyihs+s5ugKW8FxmnCPuIvqZDIBCf4CV2bWPg9PZjXWLwB5eo0F47EN8zOUWVczJPb6hiN3fKZoPv6q8228m6FG2VwCw4G1kYL8t88Ie9n4NzTECxtN5ItBB3iSrvUoUGdTAXNv4Lpl6YfDBU24+d52zFIXLMFsKmp7bf1dYDV1ZxaZwAfSXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GceJ8FbNeI5E0d7Ek5hVgH3PDPYIs1X1Um9Q11XlAto=;
 b=Cxg+BoF1iDetE4ZYK8O2XmXc49uKHNsE2H03zlOuBPCcpdFuI0hm+4ufL76F0TmQ7EmuY/Fca+blQRITkCu/CSxCmnlyaXxKKqNnCAxDXUJ9jlJbVuNli9rQEOzhfmOI2G9TpNhNZnmkTMWkIGGdxKw1LvAxzgWYvGINOUGFlrcVOa0pwGFwrVluXBcnYEEsnzs80HKpz0NydsV57aC8awzX3CGfny8a+DjsTNI50bbXL6VDVKW+hpk4itrOgp+SeAYh1DYUN628bVbIZiVcg2ZGR0S+42jh7T7fMC5l5GBaIhagvZBJ9MbQdwJW0MWX6yk/uUxhx/IzU4YL1/VPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GceJ8FbNeI5E0d7Ek5hVgH3PDPYIs1X1Um9Q11XlAto=;
 b=c3rRhy5E2+r3mqdtj+tj3XXMb2JiagneQ9RyFdRN6CgCstiyVDId5EOnRcYW0CuOqRNmyln4HbmL6aR2oNR77T29oJc5qbDG2n0ZM981BLNQRaTwbQ6Di92iJCJ+e+/L1OsRMFMrXtPH2lAdOc55AAZmd4yo0RDUr+Y82wPium0=
Received: from BN7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:408:34::20)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 10:46:45 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::26) by BN7PR06CA0043.outlook.office365.com
 (2603:10b6:408:34::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 10:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 10:46:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 04:46:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 04:46:38 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 04:46:31 -0600
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
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v6 0/7] add support for CDX bus
Date:   Thu, 26 Jan 2023 16:16:23 +0530
Message-ID: <20230126104630.15493-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5d0962-b2ed-4f24-f982-08daff8a9e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tTEQsK7YAyJdkuWg5jgec6y5BVY5suAbJmthdKg2n2uyxt7+yihMr0q1texJ+ZmDHWUwuyQnxMKaWongDIOtfn2Gre7Ip9z/qWQgBuAP13FQyXSOA1gpdlcggQ+GhUn9wnqLVm8wTEHEyRR8bEOpjTWZ4PXqmWUxqR7kTgk5xA/rIR0MQiFgBQLMqcEq4KFJTLZ8VU3yNAmgzofOnEUtNWcgUcRuWzNWVoqUfLKhsB5r1AuvAK3DIwBdVMuYirrg0ttzql2EkSAb0Fg4l4L+dutsj9BrkEDDaVvoue5tYXtHB3/bskXfDyF6dW8gH+/jXe8f/DB7R/usAMv6ABsFVhQ8s6Bi6WqxXAmeMAjr7WrPYAhdZ9Rl9uwBsl2pzsMBT/c4lwrOax1JrJEXRFesP/R4bQjzCAw9RzH6pw2bw9Dxwe13FVnSGqbQIbQ/XnoHU5A+9BaXxf+dQbMwACGe6fCPZOSoQfHXhoPEqEczKN2RTcuNvgHtAitK0mR9T+wqM0nFpGNMZPn7FBPPA+2GU64djLBaOPbGnhaKzY40YLbl3YlYfqZ6d91MOSxZvGj8XLzF/3/Qy0KdKeBAcRxQ6FouL5HAqatkh8+YxSkgzSLcMfkV5ng5Rs/M0eLfYMtbtaT2Xw2/Q1hGspOwz7KGVMCWoBVJrd24/O6K5fHbXldiBLi17Q1na2c3hnC8RdBW8iqW8jcNTu52p+14kSeug0sZBQdEEHmQHPemXL2JNv7HuG16I+wRF7fEO4fQjb+Dq8TMsdbc5sj6Q7B0hQico/NPkfKsZYDdMESNL6X2fhuGFzfR6w/iIZXV1MbQF13luBn8zfzTZlonIPtQRwEKLTPNmwFBgIIKobwNPNvBqve+cErD+t5y5z/HsMHJrnS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(82740400003)(2906002)(356005)(44832011)(7416002)(81166007)(86362001)(921005)(316002)(5660300002)(8936002)(4326008)(6666004)(40460700003)(82310400005)(40480700001)(26005)(110136005)(70586007)(54906003)(1076003)(47076005)(41300700001)(2616005)(186003)(336012)(426003)(478600001)(36756003)(966005)(8676002)(70206006)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 10:46:45.2423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d0962-b2ed-4f24-f982-08daff8a9e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces AMD CDX bus, which provides a mechanism to
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

After RFC v4 we sent out v1 (non-RFC) which was meant to be v5.
This non-RFC patch is at: 
https://lore.kernel.org/lkml/20230117134139.1298-8-nipun.gupta@amd.com/T/
Sending this series as a v6 now.

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

 Documentation/ABI/testing/sysfs-bus-cdx       |  79 ++
 .../bindings/bus/xlnx,versal-net-cdx.yaml     |  68 ++
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cdx/Kconfig                           |  18 +
 drivers/cdx/Makefile                          |   8 +
 drivers/cdx/cdx.c                             | 553 +++++++++++
 drivers/cdx/cdx.h                             |  62 ++
 drivers/cdx/controller/Kconfig                |  30 +
 drivers/cdx/controller/Makefile               |   9 +
 drivers/cdx/controller/bitfield.h             |  88 ++
 drivers/cdx/controller/cdx_controller.c       | 229 +++++
 drivers/cdx/controller/cdx_controller.h       |  30 +
 drivers/cdx/controller/cdx_rpmsg.c            | 202 ++++
 drivers/cdx/controller/mc_cdx_pcol.h          | 590 +++++++++++
 drivers/cdx/controller/mcdi.c                 | 913 ++++++++++++++++++
 drivers/cdx/controller/mcdi.h                 | 247 +++++
 drivers/cdx/controller/mcdi_functions.c       | 139 +++
 drivers/cdx/controller/mcdi_functions.h       |  61 ++
 drivers/iommu/iommu.c                         |   4 +
 include/linux/cdx/cdx_bus.h                   | 174 ++++
 include/linux/mod_devicetable.h               |  15 +
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  12 +
 25 files changed, 3546 insertions(+)
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

