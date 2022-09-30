Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399D85F02DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiI3Cff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiI3CfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:35:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84559123D8D;
        Thu, 29 Sep 2022 19:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRhaWM46151afUiO+R/rhNwFGVoGHf4wSRPzAofOymrSn5DvEEZP1rP20b5SXEJm9fzWtiaCE+i6aKyCC0JMsj/gdk81Z5aSi03cRX+m9UMLqyPaqRd/f2g6krqGJ5CaNLVwHf8a1FswZGXDlPacEb0i30Klcfp2UxHyiJB+FwxVMXlSMrT3mtnqGVWfWj4+ozEWwfZGODFkzwLroJWCEnHdeBRocpu0WKnXwxEj51xaAmFMlN9qU/wjIgscbR0LHtbr8aWUGmHf5V0RZy6GPut/AQWveo48x6Vfi+lAPEGXp3vnQRGJ413nm8GuJe1cdJ3d0P9GwiTG3DpUUwpIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsvA+V6tvm6Nb3l9dElxiJlx3B7oKVnWrJVG6Mew+eQ=;
 b=R2ZPh0DFAhzA8sD0m9Wr2XTF0OUU2NrTqewkcemWHCQXb0t/QC6+3juk9I7+YaET6JfhLCL16U4e7qHyIzcezw/TUmKFsRQUsLxQk641Wr07ka7jcdYohbRBmaRAIGJLg0gw9AZxX8rU+0Ju5DONgyaU9FduvO7cXxilNLHZIg9UEn/fobdKFFSdQ3lHVID/4+ZxDnQjH3Q5fGima0yM5C/Zt5dEWs1jDdaLlwReSa2XK9Hoa/ILOboNbwxsLjKSzfZ8Xc0rhgVjvmQ5TUOAUP0ScS6qGKWeBvY46XLV+DcBWiHRViADj34UZ0Jc2UVe5G3NRyaKOHHZWZGORo34EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsvA+V6tvm6Nb3l9dElxiJlx3B7oKVnWrJVG6Mew+eQ=;
 b=X4OTARpWz/dlLGiCLxEqOvQf0H14GxhoTPK+cMb+ylHcW9uWDd+DSpmB9bTp+P26httpxT/tByd5aAogKEQTqDPDHJQXdp6PjrlLh543QC7mZGSqHz6SdasLKXkH5r5iTh4+pmyWBi6z7hjkO5oYW8dAOo1n9ls0u+ejW7F9RaZKqRDH40agSAcWkMzwO199QBRY4MSxaMrfoKQgdZ++5cZIDFkVHLudJVaUh9WuV7PUppy2s4urCMVyMMrL6tVSmnCqDD21ugPKwXFtry+1VwK9/GScGU0S4/a1OGeMPZ4S6XNneBQ/p4zTyY174/2QQZTJy6OqAgxCHQZ0GCv/eg==
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 02:35:07 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::8c) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Fri, 30 Sep 2022 02:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 02:35:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 29 Sep
 2022 19:34:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 19:34:54 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 29 Sep 2022 19:34:53 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v6 0/2] perf: ARM CoreSight PMU support
Date:   Thu, 29 Sep 2022 21:34:41 -0500
Message-ID: <20220930023443.9463-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|MN2PR12MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3a0476-60d4-46e7-f118-08daa28c632e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+Be5gLuDSKLgwj1dGdrpThOZsAWrpeG+qtIejIWdY9IMwJWat4ZmRpfQ4sTniXHprBsatPSs/kewyJz9Q/EqG+j1Zl2FPppkEQ0qL9ZNzlvjEKpUnIei8+7rpTx0zBWmUyZf+Gl9bYz3Q0e1UO/mxbbnAI1s1g9m41xT0kuIhD3BkBNZL++3F9dzV9gt81Rc/HD/BAEIjll3Ag1i0DmnS2qSuMF1lXzJ2EP2cW5mKn/PLORYdPAP4uLqyYPT7glAofr79NFeub+zZPyGrxedxVnMKcv2JWoCTQFj7cytRNHCCIpoJmPYNiOjKZH35NvLy+aXZNl1YlZ/DCWmFcUX5uK18622BjTc5Iy6gTfhUMeabs5sU3BCB2NKe5m0U03/nptqy/+5TSjIJk2N384QCgPDAdewXW8nX1kpgTT6m7W+RSHQBRowYksSoqI0hfmFzXS37Q3ksVtaYAMrYAdTFL4DjPad/sn5tbqPhnkE/JOpvsuVPUEv7cTUk+r6glWRAJ7EqPiX31xdiaBFqHu8JYi5eyVFjBxbtS58+KTo6AnjP05jZi69YnHX815D/5KuogC4jlCyMXBpsOjwTfzrXL6jXfrcGb/QOLhNOBc00wHno4ud7z7qdhNZujLAQczdRF6vGvZo5Knpi4JJVUa+wsgMvlt7yRNuUAiEMqQQkp/KYDVxwSSk0wahbviGZDAwiH2dWNVvZI3nIusgWOWVKMZVIRScIzxt0umtjuiWZKnKLKJO7GoOZu698ZAmkBTBXY/9I/3WXrqhwwCdCxZZkGlb/cS0fQNi52VVBVZnuW5BaMyVNYVekMRRVjQbOvRPGioVL8ks6SAxA9Y6aaR4YPPCFw+m5mnVctLL/5cZgRd+xSWEKvuDWvA0/s9tt8hBMxcSf9tXooejx6MWX72oA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(26005)(2616005)(40460700003)(186003)(336012)(1076003)(426003)(478600001)(8676002)(54906003)(316002)(7696005)(83380400001)(5660300002)(110136005)(7416002)(4326008)(966005)(70586007)(70206006)(86362001)(107886003)(6666004)(8936002)(41300700001)(82310400005)(82740400003)(36756003)(356005)(40480700001)(7636003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 02:35:06.7925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3a0476-60d4-46e7-f118-08daa28c632e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
Performance Monitoring Unit table (APMT) specification below:
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest
 * APMT: https://developer.arm.com/documentation/den0117/latest

The patchset applies on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  master next-20220524

For APMT support, please see patchset: https://lkml.org/lkml/2022/4/19/1395 

Changes from v5:
 * Default get_event/format_attrs callback now returns copy of default array.
Thanks to suzuki.poulose@arm.com for the review comments.
v5: https://lore.kernel.org/linux-arm-kernel/20220928201830.45637-1-bwicaksono@nvidia.com/

Changes from v4:
 * Fix code formatting
 * Add timeout to read register function with high-low-high sequence
 * Add NO_INTERRUPT capability on PMU that does not have IRQ
 * Fix the name of NVIDIA PMUs
 * Drop filter attribute for NVLink-C2C PMUs
 * Added Reviewed/Acked-by from Suzuki
Thanks to suzuki.poulose@arm.com and will@kernel.org for the review comments.
v4: https://lore.kernel.org/linux-arm-kernel/20220814182351.8861-1-bwicaksono@nvidia.com/

Changes from v3:
 * Driver is now probing "arm-cs-arch-pmu" device.
 * The driver files, directory, functions are renamed with "arm_cspmu" prefix.
 * Use Kconfig ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU.
 * Add kernel doc for NVIDIA Uncore PMU.
 * Use GENMASK and FIELD_GET macros everywhere.
Thanks to suzuki.poulose@arm.com and will@kernel.org for the review comments.
v3: https://lore.kernel.org/linux-arm-kernel/20220621055035.31766-1-bwicaksono@nvidia.com/

Changes from v2:
 * Driver is now probing "arm-system-pmu" device.
 * Change default PMU naming to "arm_<APMT node type>_pmu".
 * Add implementor ops to generate custom name.
Thanks to suzuki.poulose@arm.com for the review comments.
v2: https://lore.kernel.org/linux-arm-kernel/20220515163044.50055-1-bwicaksono@nvidia.com/

Changes from v1:
 * Remove CPU arch dependency.
 * Remove 32-bit read/write helper function and just use read/writel.
 * Add .is_visible into event attribute to filter out cycle counter event.
 * Update pmiidr matching.
 * Remove read-modify-write on PMCR since the driver only writes to PMCR.E.
 * Assign default cycle event outside the 32-bit PMEVTYPER range.
 * Rework the active event and used counter tracking.
Thanks to robin.murphy@arm.com for the review comments.
v1: https://lore.kernel.org/linux-arm-kernel/20220509002810.12412-1-bwicaksono@nvidia.com/

Besar Wicaksono (2):
  perf: arm_cspmu: Add support for ARM CoreSight PMU driver
  perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute

 Documentation/admin-guide/perf/index.rst      |    1 +
 Documentation/admin-guide/perf/nvidia-pmu.rst |  299 ++++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/perf/Kconfig                          |    2 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/arm_cspmu/Kconfig                |   13 +
 drivers/perf/arm_cspmu/Makefile               |    7 +
 drivers/perf/arm_cspmu/arm_cspmu.c            | 1301 +++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.h            |  151 ++
 drivers/perf/arm_cspmu/nvidia_cspmu.c         |  398 +++++
 drivers/perf/arm_cspmu/nvidia_cspmu.h         |   17 +
 11 files changed, 2191 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
 create mode 100644 drivers/perf/arm_cspmu/Kconfig
 create mode 100644 drivers/perf/arm_cspmu/Makefile
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h


base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
-- 
2.17.1

