Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525962CB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiKPUkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKPUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:40:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E81D5A;
        Wed, 16 Nov 2022 12:40:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7IIgx9qAk72gmNoD5SvLZzHKsr+S31m7BCSugHu6plr1wjMNCqYIpzW5SZ3exPvDLjaYKQ1HG6f+3zup6jb0jpYbpHnrBAnLNZUKDCVGBDutDnPZm67GftG84n/HfR3Px/pb3Sr0kw6XeFqWGAcuDM4YjUUI2uc3In8U6Zc5gJFKJeCyu8qvNM2TQ03nRECP5Fw0HlFid07SzZav+eglIDQqH1QT8Df2ZR8/7DLP3Gzmuj6qG0ePIVVkQTXvIst4gBWIxHNGML1x3uxPrAi5juW44u92vemwMH0U6svVV4eGgekHJYk6LaHQsryd1wJ/Wt4piN8mwyfWhAy9SkBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMGVTYyvrrEvsXRay10Kp+Cpz1S2gcUI3N1EWYVcmR0=;
 b=AyVJoWooyH3HnRSLqvIFInZL0HsWIR2yw/P6k+DfycySqMZ1tlMCuyKok+UUHgciQPXXtPdJ+E3hS8RxIIaKouOFMUn5ez/m6kfRtvh+fg5lK573KJ8zQeqW6iDETy2kWtWTPy30FHbhkjBa2A/O3KGk59W/riJ+2jMt7Ggab0X29eTP60m93XQFl964751yNbdvJ3btaGiBoQDU+qDdOIlVRqLbelMjomWVkQiQ8htSzWSScpKGKVkhVZcyFyLiUZ/lw0n61i5YHuNPQbf8rwUaDcpH0FDukx6RCEge9E4YuUlnoI+emKNIrqltHaAf5svwUL0FArF8GbYqITEijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMGVTYyvrrEvsXRay10Kp+Cpz1S2gcUI3N1EWYVcmR0=;
 b=oqvDHKXbC58fAJnDXeHnT0XHybFL3OlF6/Lo6Mu2N34vbQUOs3QIS1VETCkC4c3eYagYF1WB8H4ev0lckFxlOVqy3n/hrfiarCPSiyu82rGo003p0jUR+SIYecMolMwH3Gf9KAsdwYTgjukpckQu6szCz2nII+C23/BI8Oc9ZzZ1YY4mgV+BjHPShdAYkV313MH3g8aRQBowWkfpxZg12feEG/XsEWb/Wbjcbytvz75j1UxlIJS+2Rb1jwyoRHlVGBFpq9Wh5qPYCW0KLONdnNR0PGQMRelMEHhF8ezLPQSQ6PqLBgnorhr9FtWtvRPretEKWS7N50PcV7GYWiuOmQ==
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 20:40:13 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::da) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18 via Frontend
 Transport; Wed, 16 Nov 2022 20:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 20:40:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 12:40:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 12:40:04 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 16 Nov 2022 12:40:03 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <ywan@nvidia.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH] perf: arm_cspmu: Fix module cyclic dependency
Date:   Wed, 16 Nov 2022 14:39:52 -0600
Message-ID: <20221116203952.34168-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|BL0PR12MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c15064-6698-4a9f-5a54-08dac812c288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XQXof5EIcs3FudnxXlwEHkjoA86e56217XVecNKLPn7Z4Qdkevj6uN/Pmlzznen3zuyhFd6/EGkCx2E7zBNxxN3vpzI++g91388zU27T9QMYPogXfiqVRObgIsnXlRTRQdZrU9D92l4ixrXgw/ChBU/le1MI3p68Guf/veRASO6of/ANW0NnPCzeyePiNd7nrp7c7Ik8wE+8bAwGS1ktMHJQoTNL+y/EzZrg+yy76zMk1MOnNH2LOY/yZlxdPGKgY5wb0UwZKaH/ulrqsfI3MEaVeEG56sZDEpX+MlSYYiHb+ihhNK/k5p7AzNX2paVSapikBqqzF8Drhnjqj0MV/rYPoRaD4knv59ZYn8fplfs5FCoKy5DmgSpPkGwDWfygbqi2OBOFv8I5kOvMax3cWMNha8rXgpZeCqbhXZuXS434qsnCWCMsNT9Pha6Bu1sSLR9wF9p294PH0Qzss8eFmgcJ1+pmDcwE2tnDklzy3ZkxMHAiqKOLBA65nl0lmtcHzhd3qLWwws+IBlEfqnENAJw2DmHV+EF8NpCCODZo/FE4ukDH3b5Dz9AD/95hn1i/A78ORSJj1An8mPBv8uxxP1ITdguy3yjVN/U8XDQCcNdWYWGlRi8iJRC1zCn56fbpPcAktsa12DuvXKyf4qRvJg/Fcq+zZkl9xh/0tqNkWw8jtFJJGyDsHj5AhUW6NZH0B7IA/HppcQKqtPHEPhNRYk1uegS49HY15kGCxMlX7L5zcia/JI46v7n3JZpwqN6wgEQ/kB3Kj3G3RXNQN8F+w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(8676002)(4326008)(70586007)(70206006)(336012)(356005)(47076005)(7636003)(5660300002)(8936002)(426003)(26005)(7696005)(41300700001)(36756003)(36860700001)(82310400005)(478600001)(54906003)(2906002)(86362001)(83380400001)(40480700001)(316002)(110136005)(186003)(82740400003)(107886003)(1076003)(6666004)(40460700003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:40:12.4091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c15064-6698-4a9f-5a54-08dac812c288
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build on arm64 allmodconfig failed with:
  | depmod: ERROR: Cycle detected: arm_cspmu -> nvidia_cspmu -> arm_cspmu
  | depmod: ERROR: Found 2 modules in dependency cycles!

The arm_cspmu.c provides standard functions to operate the PMU and the
vendor code provides vendor specific attributes. Both need to be built as
single kernel module.

Update the makefile to compile sources under arm_cspmu into one module.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index 641db85c018b..fedb17df982d 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -2,6 +2,5 @@
 #
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
-	arm_cspmu.o \
-	nvidia_cspmu.o
+obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
+arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o

base-commit: 9500fc6e9e6077616c0dea0f7eb33138be94ed0c
-- 
2.17.1

