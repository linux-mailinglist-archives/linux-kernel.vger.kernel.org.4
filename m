Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76391626498
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiKKWZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:25:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0595;
        Fri, 11 Nov 2022 14:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BChhebGhLCOb9OVo0LUBUI8Wm9rlkp4OdFIVCEnqSQMolivCEOVjRE8fWPQWGoDhaa1vjywvaYEWeG3nuZ5AXSTf1M7CjkMyc+b5KR+PZOp46wAXDEzoDAXaMWX6kXKHzqrToNKjTH4GYTExHBmJKGQhI93OUFBveLzswNQc3LxHZY36PODbnRCFUrAaHTNBaYw3RdJTeGBuYf0gvo/aUpY4/aGe6Uf7hk1i0z55QZR0qIYfv2LbXI6Ch3+xwVWccxRfusYEG5AL69nJunTpIHxNTgkrhl4PO3GsJrNTYWCygUe1ptlJ47pMynJPx3zvl0Bn5h35yE7GQKXY5Ge7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziUj9LwUmyz3z5SiCKU7h367e0xQX6XhhZsYGBmKMzo=;
 b=kCCzkK75OzdgY+7BDY4REvilMgxS0lIHYQicD5NV3SJZclwKlu+OfZZ6M4UE0+FruyNz6EpAcFVP5fR7odWSgKmXBtc+o6RPQKcL0+btgihPbHZqTBV5rr3gQZ8E0E55bmitl9rP/UcWTHM8noBBmQ87UTk2h/nMsH2anyyxtOv5ih05dSL2OUj6Yg2pZINQoZqtDMJfXW7NKtKVfsBGKFbop0WgD6whOXWLZqSuaDTBgES8CbcTsRGFrZW2VVSaEHeR1BZfqwrf2ajUbRB43/g7BxU1pPM12oIHaStOpQRjIgFt3Hv7Wo5h/rRTAJVbrHCgke4GGTeJbuIthnyEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziUj9LwUmyz3z5SiCKU7h367e0xQX6XhhZsYGBmKMzo=;
 b=O5cpPuNeCbc/hVbO+fSe7q8/UTgvWEsKAsx0dMQIJU8/J1taeisuvsyvAxlA/iUd0y8AEXfku4M0OoUgP1wMNdwrzkpD2smw2rmPj8Ik6n0lRoTUfeQ2BCjnxGIC9EPe7y2dOF3d47bYgEWxSTa9fJ5Y4Li0wEt+MUOXGARyF79WYhC2gXgtzdncAk6pwXBhxsJL6lr++E4cFpthLvE/5qjAt2xIwzRdTEXweEd3kxZ/qQ8g5Qy+7SVn//sfVQPicT/+N/Kb6zVdoApbCDytNbXSZ8e6VX0w5LcA4i20m+fvP8gayRtKz5hQN7rgQaa7hQhKuYxemUx0aavpMcP5NA==
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 22:25:01 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::c2) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 11 Nov 2022 22:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 22:25:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 14:25:00 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 11 Nov 2022 14:24:59 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 14:24:59 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <robin.murphy@arm.com>, <sudeep.holla@arm.com>,
        <thanu.rangarajan@arm.com>, <Michael.Williams@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v7 0/3] perf: ARM CoreSight PMU support
Date:   Fri, 11 Nov 2022 16:23:27 -0600
Message-ID: <20221111222330.48602-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|SA0PR12MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ce8798-dca1-431e-f20b-08dac43392d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6obsFlfMDYwC5SOOtPRDx7lZQs5h5i28yoDZX6xhjxsIwCeqYViSkQ1JvYzLJjAxUbCn5Ja83ctPwlyHRqsxBJnkRbVQpSgf7Tq8gA7/43CRDmMXtddx3QQ2+IJ7FlS094H3GrOjHj3EYE8Bn7JCcSzPop44niWBDeXwWZcirEx77V5eIAETBoAJdvutJ4+w+JiqB91Q6Q4WaXJ11uICCSWMEf6pd2qdq9r3k0IFwaQ5XyXI77Q9meRQTIw/x91evthLr/SEkcpOleT00R087x+SUIwUvj7G+uaC1BPNvzMOeflqpKVvY4FcIafWSkSzHu02lWgvL/RBCDd7XHzvTkar6uTrmta5FDnNWMg+gfXwJNa7sfOICl+vI9+jUnRc7PdnO6rgYeVZWmGSenY8ov2Haiq1nwpFU21GXsmMdjgr4TRAhCYbzYMUTqjQHgNjUOoKwcLOUWnZ4oevylEwKQaRh3hSj62fDIDDQ35Yw9srGZqBQVS005+zvC2q1MXwEA5pX/SEdcYVsq48el5WjjF1NJmJpmb+vDdAh5rOrYvFQvZOjIBbCU7tfCdFnK+OLauXrm0ZUcJZm+Zd87uxZX0nh8RUj9lB/5ABwGzqItQ/gSED6QZbBACDVogM380V3+RWWwcqB4xh6vYXKbIRzc+vZgsnuseHcNnETD0klAAJSZjUqiFGa4bSTHTuZdV1MhKNP71BOSOtSPk6FRzCmTUNAMp5jpBLxYF2caD8gIFPHpmlka1yvN/OMQZ1DRhqQtGYTPQzyeM83BZwjzXFk68rS1v1TQbKRMAmyEmnPPi0lYUVs0To6Qhxh+MiYynwwFLh8deXULH8Oib/7liR43VZNY68dh+XWkQIorAWJafowx9psJUeuZQgxuhj7+3DZlb+PwgAABKDzxNvyc6lgw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(1076003)(107886003)(82310400005)(6666004)(186003)(26005)(2616005)(966005)(478600001)(40480700001)(40460700003)(82740400003)(356005)(7636003)(86362001)(36756003)(426003)(83380400001)(47076005)(336012)(36860700001)(8936002)(41300700001)(5660300002)(7416002)(110136005)(54906003)(316002)(4326008)(8676002)(70206006)(70586007)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:25:01.0327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ce8798-dca1-431e-f20b-08dac43392d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.1-rc4
  
For APMT support, please see patchset: https://lkml.org/lkml/2022/4/19/1395 

Changes from v6:
 * Rebase to 6.1-rc4.
 * Fix copyright lines on the new files.
 * Separate the patch for defconfig change.
v6: https://lore.kernel.org/linux-arm-kernel/20220930023443.9463-1-bwicaksono@nvidia.com/

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

Besar Wicaksono (3):
  perf: arm_cspmu: Add support for ARM CoreSight PMU driver
  perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute
  arm64: defconfig: enable ARM CoreSight PMU driver

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


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.17.1

