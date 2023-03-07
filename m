Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080236AE044
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCGNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCGNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:19:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D268422C;
        Tue,  7 Mar 2023 05:19:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAw7gL903KVgyvpDvHrIfNw38GW7mVAn98h5CjTs00fY/W4a1G1jjU2kpfV6Ng0nxZ5OTTt/udHp+v96ofZflFYN7uqujtKEhNM9+Ud0diUyfgpCyFCbI+/gJ7mypNq2ItUaaU3sf6EOq5M+My52v+3R8mTP1aL0FqHLPgJfEvcdrZWJoryLuXAE9w2ZPGVrAPnvgYaMY8exvyxRXxIIzipvtbi7w3nDWLP3AeioHvXKJ91XtBsgX/hFKi5JjE1b2PjCx9ulGVg0I1XK/7y8EHQM9xD/1em0gUv9EzUsOkrIs6JjaKk1oD/ER9IAnOsxFMR9vJD0zWwcpNpCoxPuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWTpP65H6D4OsKX2cmM3WMyXp49CdcWvw/rRGdBbYDs=;
 b=ipsAqo80xCCNBzEbxt28ddqpMAaAGNAskP+AQecNuAAasqCDvgiJRktw/lvoq/1HWZM95kx2EGy321d8eTTXBjhQgOA97+SEhdVolDXU9GYythWUnXefxUI35uqKseGFawGZzHQqgmtN1btYfo2XPe2t9PX2H9INzMoZ/zj5ib4/+S5IY998tstDcjdIu63c/rQhuSMrAg/4Ezj4qajrxaZsPyL7HEDmYUqs4IJbWIaxN1LU+TRfm6QWE7kn36lAa+jx+5cLXrnVPs+kJWD4UuXzQMgTuCmHr4Vp3QkM48i+cS3W4zCdiJvOSPaH6v7UeTv0RNNf2J+LUvd3/++Bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWTpP65H6D4OsKX2cmM3WMyXp49CdcWvw/rRGdBbYDs=;
 b=Z3RNuDhwLagefwsefK/83NqX0CPFQWRP2cAPxMVxJ1cYn3ZmC+V/6qx9yi7IS1QG7e8gxTI8UoVt/ebVhD0uGPvsQpDzEUJcpATbf/0SummS5qZXmwBkUac2K8w7AGOoWNpZacGtBuV4KmzTq4ELDWhPDwpYW7YRXT5C/zO0ZOc=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 13:19:27 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::ca) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 13:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Tue, 7 Mar 2023 13:19:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:19:26 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Mar 2023 07:19:18 -0600
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
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v9 0/7] add support for CDX bus
Date:   Tue, 7 Mar 2023 18:49:10 +0530
Message-ID: <20230307131917.30605-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 708008fa-deed-4a2f-0a4a-08db1f0e93c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dxoe4QWm9JKyDzyU3LTXHukPcCw/QwgxiWM2PiRwIGEDLqRW/spM99iOMVTUhJHsyvd/l1o8yZxmL7tqUzZtqkcCVLawfPRe8924e++m19sEALumNN5J2Q/0sfyatT3xKxSBkxMpgeutISPDXhlGXc+nUpCZCZNakulFY3yg/g6aVXDAGWu8L5UbxRBY/Q1tOy1pDA4H6okOwB+TQlVS/VXg73A7fB5GFAvqcMXrnE6ZvKKLW+D5u44QWoMOnjBwK/UrlGPbTTtu/KmOlFj/2Fe+nxeq3Da1oygOgyGCmto25v4LYlXhRntuw4b+0MmCo2Bt27MHHXjg2UcJEjUdNNh3K6spX0/v3/DXigIXkCFlWGqLnDvLUVnm2lsn7+yyhbDoYZk6vie2qMS0b1s8XU+YZlo8Y5JJlGYaeo/448KJyAtwmWTVJGWnx0VrfzAInIi3fb8SphaBgLRGvsN6hbUY2NVitl9glYm9DMLDDKy46Yc95FspPJ1P19xuBtzd8gtOky0SodaqQmwxpYdvK9H8WSFriiMa2co8lbU5V9a4zl3w6ne0x7DMFuvEa8yCEiE8NjKCSS+5t9ifdVpEijKlac5MnnsIKNBowUH1VYD+RuxkqyrjcWSMb/agZs3rovEFSDAbduAddF3KjkqaKAQrKp9/YMTsFlaiblB4iinpcYpal0iwwB20zaVY8LYlqfGjHQh42K/OPUyPCV3ON2069d3bI+BRf3UjcDHAvC3TTmdXQu6Sq3eeFMeefz+91TIO4YtaF7TjQzcj3lB/31cijAcS/9ZxDW4EkE1aYhB5yWPmRBqSoXg2OGPX7fDhj3Sfn5nzQfAU+6bfAQqhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(54906003)(83380400001)(316002)(82310400005)(478600001)(110136005)(44832011)(7416002)(8936002)(5660300002)(41300700001)(36860700001)(921005)(356005)(36756003)(8676002)(82740400003)(4326008)(81166007)(2906002)(70586007)(40460700003)(70206006)(40480700001)(6666004)(26005)(2616005)(1076003)(966005)(336012)(86362001)(186003)(426003)(47076005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:19:27.1639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708008fa-deed-4a2f-0a4a-08db1f0e93c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

v8 patch series is at:
https://lore.kernel.org/lkml/20230217132830.3140439-1-nipun.gupta@amd.com/T/

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

Abhijit Gangurde (1):
  cdx: add rpmsg communication channel for CDX

Nipun Gupta (6):
  cdx: add the cdx bus driver
  iommu: Support ops registration for CDX bus
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
 drivers/cdx/cdx.c                             | 552 +++++++++++
 drivers/cdx/cdx.h                             |  62 ++
 drivers/cdx/controller/Kconfig                |  30 +
 drivers/cdx/controller/Makefile               |   9 +
 drivers/cdx/controller/bitfield.h             |  90 ++
 drivers/cdx/controller/cdx_controller.c       | 231 +++++
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
 25 files changed, 3532 insertions(+)
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

