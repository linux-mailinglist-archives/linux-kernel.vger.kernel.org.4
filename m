Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B5739FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjFVLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFVLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:35:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F5E213D;
        Thu, 22 Jun 2023 04:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV2JutbNkyTRWbmYWC6FD3OzIteAwvwmlkp6e4iH9AKbwtIUUkJh0x9Ljj/23jD3/r6WgFKj2FKr7L4va/rnojSghXrl8dc3Q9dMZ7emlhhHhHm5bvS4DbKZ8/dyqCR2+W3qd4WsedpxwwRDRG/dEZNbN90th3Mmv7rzGLncWyhI4bbvDsbLYjs2PkIE/WG3DsrWeaE3IVRw3aXHN82KpPQDL6VM1e3dycUO/qppyik8VNm9yOGgqFkRjcDGrh5ubMMhQjYMz2F78Fs4PmKcwpTaBczF4rd7UDOsg1GA2iEg3ycRdaawJvJpkxd/JunVgG6Xky3iPvodr+BUUnDxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuCwMM3vyXtufdb1uc4t1V6RwotqPAeFw7Fjw46Fgxc=;
 b=HeACF+CFv5WP1FH6kz08NONERrUHlkQFojhif6Gc/DtdQJiQAR0gCp8e9adMAup5Fl7nBEMrCqqjwEyPKnHWK/EwWUMoSTOogTCCo3pIedgMFa1akCrkSBzkXCw13VBw/rNnvL9iOEZLzHYlYGksr1bRMeQstEVGHqpbTRAeq1p9i1oBvqC0MP5BVNvdwxRvq7KZwrylrybvxcbLV61H1eIcZxC8m1RTR/Vs9bNWPRjIEQ9mPda6ybCWgVOD411IYOCHb0gcWLDSN+fCE3TRHOmKpL8E1+cyeGy7U5MFsweoX20vHHPWBJPCyjGoeMHzpGOrMvGwmT8VQRWWiDFj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuCwMM3vyXtufdb1uc4t1V6RwotqPAeFw7Fjw46Fgxc=;
 b=me9pIpJ0N4q1n2Cpcn2z0nDeqkSpWbo3S6OI3YiEUFaon3ydbIXxjVw252vWcz5eu3i/uJJp3Pqju7NYiGx7qvre+8sSCZGCWnhZcqRznNUfEiXGOUmmmZsfuhyYnWKxPeJ2Tpi+GkWAHl0LWfBObDAbshmw7jWe3oo08Dp383sYBvY8tFik5QES2LlHVYHLfTfKQhXpN44CoTpWrWY7BnGX9muwHbRx48Nk7jOgiQzx2+cCUgrE5eJZiZdu2mFEajEvLy/yz+il4lLLUW/ZW3o1s+J0leUjkZo+YT4+R1AZf/CAeEnF6Z2yC4J9wkynermugFcEjzf0yoFc6KXmJQ==
Received: from DM6PR05CA0052.namprd05.prod.outlook.com (2603:10b6:5:335::21)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 11:35:08 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::c8) by DM6PR05CA0052.outlook.office365.com
 (2603:10b6:5:335::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 11:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.20 via Frontend Transport; Thu, 22 Jun 2023 11:35:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 04:34:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 04:34:55 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 22 Jun
 2023 04:34:51 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 7/8] arm64: tegra: Update AHUB clock parent and rate on Tegra234
Date:   Thu, 22 Jun 2023 17:04:15 +0530
Message-ID: <1687433656-7892-8-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ace55e-18ab-4207-4132-08db7314bb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmZmN51yhWdzOZkMKXgVy3mC8km9ckJy5cgtFlU3P9+p69Vpbs68xSbJ1iJclvZ3+2rVsRpXgWZvh1HJJ2t4EXxB6ES+irWRfWES3yvclDIgTIlE7I04L/Cc7rAQS2dLivxrdGCcgaRF1DAF0iu9HsuvjL0YH6P+qJC70V0BaetVLVvnVqNuKy/mkkfBWqJHyId92CJj1X9WdYze3XFOitBKAaL1W4QrbNedKPPiTQZWgMuappfV5nU99eLg6/PQfC7tmsCwGUqiZE6aTyGSHAl9ifDsmjc9rLrROrZFkTegaF9cnugBI0ie5Z5SpI7LLHnWrmJLn8SE0/pofrKvFV39BxnPtgES53BRSB3LBNECgEOLuKsdiFu+bCyiTcOxkPz2e7WMheXuvBRqdfV39+05Evc+kzl1IHeaIEWdTy55zP/mCQGYh/SD7qff10ZfOsWiKiPHk6LBs6KQf5SBz8emTuSF8jLgsUkKQwOpS9PQhIDPomfgyX8KLooD7lJQvIUfNu21NEwN1S6YjCSC1XmqX9F7QqKPN46ppppASMHQINwvXPBWoMrqvTzz+N4Le9Ha81aiojIzjedgY5aOFX2O7Pb60YSY45vFUZBSAjHxz5lqiAXkq0iI7NeVxEMSTZ+akjXnjjqksJd/22bWO0uUPcYDMTYTiNYtBDJ5v+FSShVCBVhRvvOEnpgRM1Add4HNkQeSvPs0+SVzsCoceNkYKvLMPuE6uVIrEFHL8o+Scc888L0SxzshvCvNoQs8
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(8936002)(47076005)(107886003)(54906003)(83380400001)(6666004)(7696005)(110136005)(336012)(478600001)(26005)(2906002)(2616005)(186003)(86362001)(5660300002)(40460700003)(36756003)(356005)(70206006)(40480700001)(4326008)(70586007)(82740400003)(41300700001)(316002)(8676002)(7636003)(7416002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:35:07.9267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ace55e-18ab-4207-4132-08db7314bb34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal <sheetal@nvidia.com>

I2S data sanity tests fail beyond a bit clock frequency of 6.144MHz.
This happens because the AHUB clock rate is too low and it shows
9.83MHz on boot.

The maximum rate of PLLA_OUT0 is 49.152MHz and is used to serve I/O
clocks. It is recommended that AHUB clock operates higher than this.
Thus fix this by using PLLP_OUT0 as parent clock for AHUB instead of
PLLA_OUT0 and fix the rate to 81.6MHz.

Fixes: dc94a94daa39 ("arm64: tegra: Add audio devices on Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f4974e8..0f12a8de 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -180,7 +180,8 @@
 				clocks = <&bpmp TEGRA234_CLK_AHUB>;
 				clock-names = "ahub";
 				assigned-clocks = <&bpmp TEGRA234_CLK_AHUB>;
-				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
+				assigned-clock-rates = <81600000>;
 				status = "disabled";
 
 				#address-cells = <2>;
-- 
2.7.4

