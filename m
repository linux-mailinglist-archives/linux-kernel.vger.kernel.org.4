Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370E5ED4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiI1G1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI1G1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:27:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6579A7B;
        Tue, 27 Sep 2022 23:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1QmjSTSusmaRy2mYteQxze1nJ+S1+nn07lDMcuzIrRLGQ9L/+LUYUXBEaBCpjcHNNHo4jbssKkYQQ+BpX3wksqAxl/CAVvj7bdgiLbA9Mzq1620vGZYbmB72jX/MdxUb8HZe9dKdMvSq7POVvH5/PtUFT3a1rvYo6PMYQFufTQkKc4kAPvuhYVwe/rpctQKRxygPVZPqpDah8nEVoBQWA+QhcXaA5B0qX0OEpwUE9RFKHae2VD7TF3aJlvElrKiKut8MsmC8A254pBYGrR7hL0ryH6ZZnpyAlkKpka3P+v1Pdk9deh+REG0LW8IOXBc05kewAlVjKxojIVv03EMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuKAWNcVzk12MquipdlfIhbm82tMcjOmuxxSIYUN8YM=;
 b=EpHxd6ErJ8PjHzzaltAH4SeokOZUtLf1WuzLEukpHnlGFuf8M+pRpfxgSampG/NXdoN6agdm/Hx+OUg2VVbYCN+n8aihB9fXvjJYR5lxFs9imDGnu4rzpB+ThYcFglx/D8ugQ+wgi65xZnOhn+6ODIKYf4Fu3LfGFEgvV5OiDFjvKk6onmcl5ZavhsX/aauCT07BJCAxblNuRFFPm/hwMougDyLmQuLVoN9hO8tLpftyVifv8kz4i2+M3i56yqAsXs8bSZOeKQhfrnwFc6guTYCf1Rs07OtmlWtF+kXKqy4JZRgdnu5B1sPFlDoAJ55tkkVDA80OYJAitc4GMKRFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuKAWNcVzk12MquipdlfIhbm82tMcjOmuxxSIYUN8YM=;
 b=nnRfBtHJACMa0Ysw8wQsiARIeoBlRob9O81iSEn/8ya7Xq0U7WlEdLxiqSNebn/+94dng5vreAt5OkKv9rANw+M1opM1OapGM18x6JLZBYNF1M0kOm086lUdgLOWhN6V6k4zlWLMvxr0aXBNyMWfD6VMHSVIhnxN/R8XE93OWPMT1ZBZavZYWEA2GYl9FVMaj3THMiqZV6vMEfmWBDLAgElISFhcblHwVwwaqLSD0ZXyg3MJNUjnoo++8f6brP4LO0ZnpyiWBaVExZ8m8VbH1FWS+a8uGUL8U/LBggy6gtYAicrju3jhaVlwhILg2AWql7wFdlJpcACwPCejeZT0Pw==
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 06:27:44 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::40) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 06:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 06:27:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 23:27:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 23:27:37 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 23:27:33 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] arm64: tegra: Fix Prefetchable aperture ranges of Tegra234 PCIe controllers
Date:   Wed, 28 Sep 2022 11:57:31 +0530
Message-ID: <20220928062731.18032-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 48898c7f-7beb-4706-7212-08daa11a8d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Xycp8tXAa6vGyk/w4jap64NO3l5+FHpGqg+vHqborrKqi6hW9pMI85aLsmFe3PH3X51AY959HJCY12Yqxngd6UxOZ4dpuNSAqGfPDXxgr+A+yhvx5ufUn+w6/XV+TEA2j0pH2mOkqTvT73IMO1HVXNumtfgPjLTO/ER9jH/ysBFaLZTYtwPQsYUL/gSHkO/rhmNT2UyHBr+gJ1UFpBzX9+8gv0WUIwpT0S8LOD/x8g8djZ8EBqWrjlEV9xvTC07eroaRL9gGK9fsO1E+x84d8QdvIkZCwHMLWjA/obOqz8MwyilJCsk3bhcfD8H9oG91wqu5x7bPh4SkCBAtV2LkOJ7R+rbL8qe6UoSmRnbtGGwa7T6G40uauKLtHkxJd3mHmt6eIPrn+npWEzpfpwd9yJURFVEK8Quipydl6gOrhw/OfY8WbX9XY91/EQxopLclwTvPNKf9g/29Z4nC2oibq/o26WdfnxR9sH4gj0FZqVp+aHjrP1tG/wYaQps/Z17x36dVXp4bsZbtEpbQMtLOj41ceWXxbcb9hb168Bqx55CDCdzbuZ8E7DP8NJwKraR63Zawv9zUthsVshWOBUM9llvCMkFyVYpqTXnpxy0ZlEibrzQzLj6UIRCP6+DWTzS/3laM5W/kYtRnOLdPujdTT1Bw8slOCghcdGm6Hjb+qGahcsMcPre/zkp7h/19AxympdfhIXBlI0gh2uAc01oqDOrZ3T3nE6A9rIFPdZmEOFSr7X1+eGlE6qkitdl2JaK34LSMh++v4+o0LPx97cd3w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(83380400001)(36860700001)(186003)(336012)(2616005)(1076003)(356005)(82740400003)(426003)(47076005)(7636003)(26005)(40460700003)(82310400005)(2906002)(54906003)(86362001)(110136005)(7696005)(6636002)(478600001)(5660300002)(8936002)(316002)(41300700001)(70206006)(70586007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 06:27:44.1911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48898c7f-7beb-4706-7212-08daa11a8d9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit edf408b946d3 ("PCI: dwc: Validate iATU outbound mappings against
hardware constraints") exposes an issue with the existing partitioning of
the aperture space where the Prefetchable apertures of controllers
C5, C7 and C9 in Tegra234 cross the 32GB boundary hardware constraint.
This patch makes sure that the Prefetchable region doesn't spill over
the 32GB boundary.

Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..9b43a0b0d775 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1965,7 +1965,7 @@
 
 		bus-range = <0x0 0xff>;
 
-		ranges = <0x43000000 0x35 0x40000000 0x35 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+		ranges = <0x43000000 0x35 0x40000000 0x35 0x40000000 0x2 0xc0000000>, /* prefetchable memory (11264 MB) */
 			 <0x02000000 0x0  0x40000000 0x38 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
 			 <0x01000000 0x0  0x2c100000 0x00 0x2c100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
 
@@ -2336,7 +2336,7 @@
 
 		bus-range = <0x0 0xff>;
 
-		ranges = <0x43000000 0x27 0x40000000 0x27 0x40000000 0x3 0xe8000000>, /* prefetchable memory (16000 MB) */
+		ranges = <0x43000000 0x28 0x00000000 0x28 0x00000000 0x3 0x28000000>, /* prefetchable memory (12928 MB) */
 			 <0x02000000 0x0  0x40000000 0x2b 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
 			 <0x01000000 0x0  0x3a100000 0x00 0x3a100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
 
@@ -2442,7 +2442,7 @@
 
 		bus-range = <0x0 0xff>;
 
-		ranges = <0x43000000 0x2e 0x40000000 0x2e 0x40000000 0x3 0xe8000000>, /* prefetchable memory (16000 MB) */
+		ranges = <0x43000000 0x30 0x00000000 0x30 0x00000000 0x2 0x28000000>, /* prefetchable memory (8832 MB) */
 			 <0x02000000 0x0  0x40000000 0x32 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
 			 <0x01000000 0x0  0x3e100000 0x00 0x3e100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
 
-- 
2.17.1

