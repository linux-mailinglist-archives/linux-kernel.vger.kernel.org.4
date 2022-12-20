Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0216652418
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiLTQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiLTQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:02:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8017ABC;
        Tue, 20 Dec 2022 08:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciOuSei6cnxczy2HGCxOKNTSm9lv0bV/k+a8jD/i8K0uiTRcPPnEKaIMghhmEOl0NMon5E4oSGJw2mGoIjcDODpCvhzUAQPYskb6MRHNI1e4pV+602+1m8EonrQw+BoHvDbyPKudItBOfpOcw1TZlyc/PNUucQf7CelFyhGfBY1Cwzmt/OaN/Irrr+1GtWY6fon5Rfj0vAfVWFB5FDxMNvOynuVGoySW1u5tjaYaphsPZFRl0jYUHmhBZc6IJgMtbZakM3guCq0VCYldu6qSyhP82iUBID4Q6Om7ZTkcQsoY1V+fdtIA7R9HoPUhfwOhVdowBzCYWVCDKZht93AAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlmBoCzODn3LI6yAoZh4HbqhUuiI7j3L9uT9ORgfHLs=;
 b=Cgde71LTQSOCmrz1/MibPleaf0ncYfxmNeWOptwIoQy6lum9rAF13OHvmtethjcqH9JnEz6fzWUuNrugQlqJaMExg4DLJ5MCsiMXEThNsKHUBmkRhKJNXGYIuyqpGzsMKckMV6Z9LFU3SOoivUeCWa80ZFGGwehcoIgeFb8VNksDqKW3LWF5a4CJK3ZdV2MuN9jjNaAmC4hx5QQHOQrxJF38G1kKODlP0DE9FQ5gSdJD5vVu9zEmc3NAyXhfFT0NY7Rfo8oi/wU/F+hMLvRNM58BBPyH1zTJAZBk1/wrAZVIXUS07Xks6k4R1+v2iEVhpmLjDw0NCw2ETn4CVczJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlmBoCzODn3LI6yAoZh4HbqhUuiI7j3L9uT9ORgfHLs=;
 b=VQoRsvuYoV2JcNffsf8QwPT1vZ6CCpOafNEPrNcUvdrtY6vVHxC8ky9mKg5LKTIfj4EJ8/5+NNf1ab5aZSQsFKBS1zWqUFRsImws4lrEwKjUKy6a2O5tODRWuDWkoOLF+XAESbE00TbfXIi3skE7LokD15cnviFB/pltoutTHq3esa084V6qhMGMshYC9mWmAO0XXlXdf9FWWX+wYToMQrQJhuTfqUv8Ocw9WDsYIJ00eVm39UlzVRRmNQUhzmES8eUnjJDM/OxVqFXuv/mpCEuHLp0lOd4yRnyjheZAe+6ugnPrSN+u5WKEfuRjJL1rR3FhgwU8wMovYsXkNRpPIQ==
Received: from MW4PR03CA0234.namprd03.prod.outlook.com (2603:10b6:303:b9::29)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:02:51 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::8d) by MW4PR03CA0234.outlook.office365.com
 (2603:10b6:303:b9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:02:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:02:48 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:02:48 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:02:44 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 00/10] Tegra234 Memory interconnect support
Date:   Tue, 20 Dec 2022 21:32:30 +0530
Message-ID: <20221220160240.27494-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6e7447-9baa-408d-60ff-08dae2a3a5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ELGWvRMDtWS44BdBURH6CtU1hFQZ6pfR4qwi3PcTZ/BI/2JqHd1lxAeEq2uMeu6aWUQXPJWHiJZEljtESRK2cGNo+h7RjM72T3qGb/VXgZY59zok1xqtLtMVK581J18yqO46LaB9StWmfb5TBKAIlOTFRV1Q5IaDGO7kcHECuqDlU6+UNspN+5/bopz63RKYKg7ne4ttKa/iiWwCUT9otoAqB1V8iiDwIE9zC88GWjcx88iOz+WG7KilJQ0AAd0p0ljHik4A7b/NH/quVhoPqnTMMBDpKFcL7st8NOi0yluh794zMbXbaGJPwOUpzCDH4h3TXuOkDwFxGfPXSji3VhYE0gfYyfXeqIP6hXNR2DC0WTEMiyzF2b3X5E4fZOyGhoih048KCpUjiAxMehLC8xHXA8lYQ+tHDkDueUR863tRo6GX5zEc6NE+ytClSalGjx5DkurWmZdEX1j3Khx+zr8ZAndTzGQQcp9cv/W4wE3eXwm5vvVvzSc5fHYB2R8vHb4p9+sPDFrKvn5py7Nebg5Ot7c6V4wlkHCIIk+qvkElNg2lzPupviVM9vVmjqc/wRCHBuJktu2CJooosUFDNgwakbUAQpTh5zHOdoUOhqYW8czc0VuFwyozqyHk0PNyBLZS93++huVggyVf2wIlij6gGM9XkoqaKzyT1YjDRUgMNgbEIYM3fJ4+4R+Ibja
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(36840700001)(36860700001)(2906002)(356005)(47076005)(336012)(426003)(36756003)(40480700001)(921005)(82740400003)(110136005)(26005)(186003)(41300700001)(7636003)(86362001)(82310400005)(8936002)(5660300002)(1076003)(2616005)(70206006)(83380400001)(4326008)(70586007)(478600001)(316002)(54906003)(8676002)(6666004)(107886003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:02:51.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6e7447-9baa-408d-60ff-08dae2a3a5b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds memory interconnect support for Tegra234 SoC.
It is used to dynamically scale DRAM Frequency as per the bandwidth
requests from different Memory Controller (MC) clients.
MC Clients use ICC Framework's icc_set_bw() api to dynamically request
for the DRAM bandwidth (BW). As per path, the request will be routed
from MC to the EMC driver. EMC driver will then send the Client ID,
type, and frequency request info to the BPMP-FW which will set the
final DRAM freq considering all exisiting requests.

MC and EMC are the ICC providers. Nodes in path for a request will be:
     Client[1-n] -> MC -> EMC -> EMEM/DRAM

The patch series also adds interconnect support in the CPUFREQ driver
for scaling bandwidth with CPU frequency. For that, added per cluster
OPP table in the CPUFREQ driver and using that to scale DRAM freq by
requesting the minimum BW respective to the given CPU frequency in OPP
table for that cluster.

Sumit Gupta (10):
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: adding iso mc clients for Tegra234
  memory: tegra: add pcie mc clients for Tegra234
  memory: tegra: add support for software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  arm64: tegra: Add cpu OPP tables and interconnects property
  cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist
  cpufreq: tegra194: add OPP support and set bandwidth
  memory: tegra: get number of enabled mc channels
  memory: tegra: make cluster bw request a multiple of mc_channels

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 276 +++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c     |   1 +
 drivers/cpufreq/tegra194-cpufreq.c       | 152 +++++-
 drivers/memory/tegra/mc.c                |  80 +++-
 drivers/memory/tegra/mc.h                |   1 +
 drivers/memory/tegra/tegra186-emc.c      | 166 +++++++
 drivers/memory/tegra/tegra234.c          | 565 ++++++++++++++++++++++-
 include/dt-bindings/memory/tegra234-mc.h |   5 +
 include/soc/tegra/mc.h                   |  11 +
 include/soc/tegra/tegra-icc.h            |  79 ++++
 10 files changed, 1312 insertions(+), 24 deletions(-)
 create mode 100644 include/soc/tegra/tegra-icc.h

-- 
2.17.1

