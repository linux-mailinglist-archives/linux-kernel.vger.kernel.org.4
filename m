Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E320166DF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAQNl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjAQNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:41:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BE5253;
        Tue, 17 Jan 2023 05:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXtqr/Pb6ZIzFfksjzotnvB3kHaoSaS2aiBGKoPZytc3/J7KIBbKMStqSm+Z3FjgR1J823/rEyEfEvFdzXksWxxMgFKZA5sBAMkkdbqvJdXJz2LEDDR/XmH82YU+SR/V1WJnYojmgARU3qCiKVywKsQ1Ma4Wq1q0MGQUkX4YGwTWpm3tC4mcCU3cpdCwPs/qyivUK8xNFfIOyX3CQXBbjH6aSgLtZ4m6ZaNAkhAkf5deVb5gDJ8r0qaFW4MbImhq77SClz0egyRiawl5S/Lk9K1qXUtlLd59PP0JOe6lzcBLmw/n2diMMDWjxx7XOTjOY6MApmVGaJ0l2ESO+RjqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuQq/B7H7nDr+dI5VCnCvJ+f3D9Si0uJXhjxm22hqZA=;
 b=cgFZSIwr/XcVa+wC6BCrQnpouapgUAoq0tx24Oxuj9BiEJ9B9uvWKQ+YgGBdJf/e3eklqNu4gfaEMF4mAAzv/ZCpfhf6iMoUhlAO5Nkmx8+LdoOWwEbJRb8sU5Un1x+O2vAubSivAW1m+9uaOiiUIMT/f5KZGJgQxtHSh+zQZv11KGIDVkIPZOOarRiqy9WIauCJ/LUO6txTOK2kC/f3R3DElvFf5QEDrjR/tWIvQtb59RghwWVkgV8HEySXtb8G7ZSZIbd3ut2/vAMijhev9WpQUfh4jgcjPCAjFZcCrVibalmHy1B03K195po1T3+hLzCkYA9tgbcZ5lee3o/OEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuQq/B7H7nDr+dI5VCnCvJ+f3D9Si0uJXhjxm22hqZA=;
 b=dLoA5ac+bAEUGLm4bmEY8mbzivG6p7b6qHBeKk8YP//GjYgDoryeO4dgQkYwexyD1VXv3uZqB+xdh92XSF/fNsB7aMIjxMe0oGwmGSw00fVRF9trvmQxMRGMbA/rkim0RXWI/rt+dbfP6RNlf/C8/VUQdlQiiTokuWo4OeCbwXw=
Received: from DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 13:41:53 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::47) by DS7PR05CA0050.outlook.office365.com
 (2603:10b6:8:2f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Tue, 17 Jan 2023 13:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:41:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:41:52 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:41:44 -0600
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
Subject: [PATCH 0/7] add support for CDX bus
Date:   Tue, 17 Jan 2023 19:11:32 +0530
Message-ID: <20230117134139.1298-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|DM8PR12MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: 092fa728-5410-4f0b-f78b-08daf89097e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: selQpEeDQ7jZ44yLzA2ASXraInhBBE2xHlj+W+sCnlYHwu41cX9TGmCNKJviS1SbY/ZXLa0qMCJhy/iBTaOgwXHQk2auWn563VvAXgChL4ihmJu9rBd4A1v20VTyBnQa9BXkGniRZnwCpirBOLVSHcz/7acoKQpiseoytUuoi2+TVaHpn6mTebNWMJWX6V3l6VwMHMQuvgAHdgnJZe4sfPkxruMzRc067U85fPzwNaR9ShqZxBsO5LE39WjMjChPnxwuTYTWDaTZMxGXfukNk86zT2rHMixEHj5m0oXCd/WErgBjAZVVupxONwWUNybiQAF8GcmZRzYuUcq/3sDYAbLmCir7QSKeLjye1UOD3wyf4D9YGByI0jJb/BYM+EuRv280Kpg3PBdlkWETQVUAdaT3eQEu9lSt0xe4Pka9SJ2PcCKnCdhDiOn2zQS+TYnL8WXuKHA3RYNbRWJ4KYlvT5XvSIL8F5anzQO34tkEshuPuK5qJwPRfogI+rzp9DYdPPGZofIUz9LfABNlTVh+KtrmRpV0joXp8DWeYxfrWbWl6tGy3FaObBclEoGpcR1bzM4G3ZWdLL33TX4WHQK8WenatQw+rZ3VZKkxTzyLJu0QD3l3wOt3Oc5rVMHwQsxG5/bLw++GK0EUqnDC8AavSZ6kQ0lmD2MTyhpMrQ8ep54sjX0fIDHLhQgj4R/dscA4kg2VGkiQFWHYezyMboY9pA6pigrQG7vnaK4yTLFR8vdgywfSjofFKa2GJec7ycyQX+3ddSqvvmcP/e6BNR601OJ7F1wXB4zcobYeQZa+VKnlimsSQuSzRhPSyfRb+EsDZessiN6nIyjsXXQvw4noAm82NIZDnGOAPpVL4mJx7XpdnRRimWGRlSgygganCMQp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(7416002)(86362001)(921005)(356005)(8936002)(8676002)(44832011)(70206006)(70586007)(5660300002)(2906002)(4326008)(36860700001)(81166007)(82740400003)(478600001)(40460700003)(6666004)(316002)(54906003)(966005)(110136005)(40480700001)(82310400005)(41300700001)(47076005)(336012)(426003)(1076003)(2616005)(26005)(186003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:41:53.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092fa728-5410-4f0b-f78b-08daf89097e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

MSI patches for CDX are not added in this series as it's
support is being revisited as per patch series:
https://lore.kernel.org/all/20221111133158.196269823@linutronix.de/
It will be added as separate patches.

RFC changes with stubs were submitted at: 
https://lore.kernel.org/linux-arm-kernel/20221014044049.2557085-1-nipun.gupta@amd.com/

Abhijit Gangurde (1):
  bus/cdx: add rpmsg communication channel for CDX

Nipun Gupta (6):
  bus/cdx: add the cdx bus driver
  iommu/arm-smmu-v3: support ops registration for CDX bus
  dt-bindings: bus: add CDX bus controller device tree bindings
  bus/cdx: add MCDI protocol interface for firmware interaction
  bus/cdx: add cdx controller
  bus/cdx: add device attributes

 Documentation/ABI/testing/sysfs-bus-cdx       |  46 +
 .../bindings/bus/xlnx,cdxbus-controller.yaml  |  68 ++
 MAINTAINERS                                   |   8 +
 drivers/bus/Kconfig                           |   1 +
 drivers/bus/Makefile                          |   2 +
 drivers/bus/cdx/Kconfig                       |  16 +
 drivers/bus/cdx/Makefile                      |   8 +
 drivers/bus/cdx/cdx.c                         | 577 +++++++++++
 drivers/bus/cdx/cdx.h                         |  62 ++
 drivers/bus/cdx/controller/Kconfig            |  30 +
 drivers/bus/cdx/controller/Makefile           |   9 +
 drivers/bus/cdx/controller/bitfield.h         |  88 ++
 drivers/bus/cdx/controller/cdx_controller.c   | 282 ++++++
 drivers/bus/cdx/controller/cdx_controller.h   |  30 +
 drivers/bus/cdx/controller/cdx_rpmsg.c        | 222 +++++
 drivers/bus/cdx/controller/mc_cdx_pcol.h      | 707 ++++++++++++++
 drivers/bus/cdx/controller/mcdi.c             | 918 ++++++++++++++++++
 drivers/bus/cdx/controller/mcdi.h             | 259 +++++
 drivers/bus/cdx/controller/mcdi_functions.c   | 139 +++
 drivers/bus/cdx/controller/mcdi_functions.h   |  61 ++
 drivers/iommu/iommu.c                         |   4 +
 include/linux/cdx/cdx_bus.h                   | 176 ++++
 include/linux/mod_devicetable.h               |  15 +
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  12 +
 25 files changed, 3744 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,cdxbus-controller.yaml
 create mode 100644 drivers/bus/cdx/Kconfig
 create mode 100644 drivers/bus/cdx/Makefile
 create mode 100644 drivers/bus/cdx/cdx.c
 create mode 100644 drivers/bus/cdx/cdx.h
 create mode 100644 drivers/bus/cdx/controller/Kconfig
 create mode 100644 drivers/bus/cdx/controller/Makefile
 create mode 100644 drivers/bus/cdx/controller/bitfield.h
 create mode 100644 drivers/bus/cdx/controller/cdx_controller.c
 create mode 100644 drivers/bus/cdx/controller/cdx_controller.h
 create mode 100644 drivers/bus/cdx/controller/cdx_rpmsg.c
 create mode 100644 drivers/bus/cdx/controller/mc_cdx_pcol.h
 create mode 100644 drivers/bus/cdx/controller/mcdi.c
 create mode 100644 drivers/bus/cdx/controller/mcdi.h
 create mode 100644 drivers/bus/cdx/controller/mcdi_functions.c
 create mode 100644 drivers/bus/cdx/controller/mcdi_functions.h
 create mode 100644 include/linux/cdx/cdx_bus.h

-- 
2.17.1

