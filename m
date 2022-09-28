Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C05EE685
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiI1UTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI1UTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:19:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295C6E88F;
        Wed, 28 Sep 2022 13:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5ha0Q349MX4vegeTGktgyEzMjpv9peC8GEBIlaPJzkO4o1i8VAuzzsnurlK+5jj70qkygtIk4i8xkMZX+2xCtg0ppBUYDtr3rvKmz/IU+zZJsQOLoqCE4oPIvqQuzhJwaAC4e1C6PvFHAmm+kmWHKO93p2kQzR8tER1mF5d4E43c0mjmC8OdURKEjuV4mLCqe6vgGvpMk8yt2+nfSVG08XCsvZ6qX++lOxxHEhhSyfY1SK1dN7u9+JtR7BYYzOXHUxs17s/PjCSR4YS/8iAJOpWUQ+6+bAsvfpKlBzdsOezpqIZHNuLqOs7Yd1wQbGPvXEO/l7P8nmH3VuGcUwjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxEAvJtGK4/vz4fCmWglij/cpCcK7WpQtMybnTRh+HQ=;
 b=kMRQIgqAbl7BJcNnAvpRymj8ox8rCzgDhggsV88BgiHGTQ9dwbHdfwblghdQOyTycyqXO1FhVRE1zOx8f3oNQPgodRGFoBMdVORqOIiyZxM93KsMNXRtbvZp+HPG87rpyYN0xLDx9RpugewK2GQZCtFv42nXchaHJnqVn1GXGLT/flBuNGRD5ZsNQayWakzqVW5cFZ5lYeezhLlfoMPhZRWPRx1HACkXVLRbCe43DFgaJpd0fWuO+rYhhWb9t9TZ6vJdJygg21Ei3pt6UnQN5OVXzPX/Vx/fK73cO7v4YE4Ix2V3SglQZWe9qAEkXor1zC7JO7lDowjuK+HQ0/i/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxEAvJtGK4/vz4fCmWglij/cpCcK7WpQtMybnTRh+HQ=;
 b=SW97fFfDlRSY4domQiFhAlHE1M4O4oA15x3s8+2pV/tW7/d6BugV19/wfOM4lO4femG5E2foGOn7ZJMqIqTPnSi67dmSi+OcseMNQkdnFZIz06L4xvueHVf2aFRDHhf7TNhTK9y4rA5YXqW7HtaVG3sbE+4LajtS9nSLdq55ZQIRNRiXaaFjUGgZz8aApTTYh7vvNM30FtAPNk0PKD5E1ZAP0iBQ/IHRSmr7rhl1JATAFkWQKk6UADv/bLBd56xTuQjv9Ge74Yzaci//CCywhJRbaCf+VuHHhA8kiUvxCKNxdPh2r39W89/rrlET9mgXWtaJk0zYFceDKQXN29F9pA==
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Wed, 28 Sep
 2022 20:18:59 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::5f) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 20:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 20:18:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 13:18:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 13:18:49 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 13:18:47 -0700
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
Subject: [PATCH v5 0/2] perf: ARM CoreSight PMU support
Date:   Wed, 28 Sep 2022 15:18:28 -0500
Message-ID: <20220928201830.45637-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: afb37fd0-4973-4d15-971e-08daa18ead1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0f/jZLxc6O2wgW4z9bXkOEH/JrDFQnqBSrBSq47vgxxYZfnwnoiMNj8Qf5FbMKhJyzt9ll5xbc4eeKrykXPf7t0YI8eAHFrUVVj+02LoqsGQ4TvDFrm0p3AIidYEvopshEZVTUIP24B3QgPtnwZfnfOqJrWxoFQiK+dpeAqjNSrf6pDRHGir8UaQTyxsXmPz3YQ42hIP5SjCnuJuyPaYBl6hWDnhwjA5mXnsfmocSCDcYBneigzR+xErfALI+dchcSVEUXpng4G2XyoxiN4+zwFsbSFZectTv6MuKCKqVzqb2FaF19ihkbgOgr+8HW3KsnKA3he8e+0THlwX+lcGgskeaLSZs6YnzEcDVj66iquRgVkeEWUQtoTyBHVb5Kb7NpNHkqcZ1+sUktcQeUiSnPIPcdGfWMmkhV3/yLlFWr7SrHNVLkoEAdKOUZaXZATx9pT5fC6MWloTV/U4fFU8D9JmCzgjYGB5zwTmtJ5gB1mHQk5WQU1D+0X4l/e8/xNeATjS+l5YPd6lqRNdBuw6aAnwLca7PlIB3c3XVhmZ0HZkyiNYLfCf+md7nH3q44K8yAlxbzfw/sg5gJe6vMBEO5k7zYHkdi8/jbIOIvUKQa8MBV2CgDnUzNjNNfc3Bv08r+T5TAD8X/6B/ltGgk6jn464KCfz4J2WBbySXqCiiRX63uzQ8HsTxKRTaPX42hQtbwF1BpxOqvFitKhSbVypZwSy139dCKrU++7e7cDWhrOMy3fsB+BmX054F0Qm2Fl5f7GfRJd0UXGuAu+g7i74HsgRdpA/oDjfpNkXdZiueM+tdaHsQhAUaR7diHYxl67Bq5yQmQWm/9dUnqab0stNYNpFNBAtWqaQNp+CUWFv1e3dmcE5PORyc9lR+WfaWwk/mqIKWDg/MY6gqgSqf+ROQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(7636003)(2906002)(7696005)(41300700001)(336012)(5660300002)(40480700001)(36860700001)(7416002)(6666004)(82310400005)(2616005)(356005)(186003)(36756003)(47076005)(83380400001)(8936002)(26005)(1076003)(82740400003)(107886003)(316002)(70586007)(110136005)(426003)(54906003)(86362001)(70206006)(478600001)(4326008)(40460700003)(966005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 20:18:58.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb37fd0-4973-4d15-971e-08daa18ead1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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
 drivers/perf/arm_cspmu/arm_cspmu.c            | 1285 +++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.h            |  151 ++
 drivers/perf/arm_cspmu/nvidia_cspmu.c         |  398 +++++
 drivers/perf/arm_cspmu/nvidia_cspmu.h         |   17 +
 11 files changed, 2175 insertions(+)
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

