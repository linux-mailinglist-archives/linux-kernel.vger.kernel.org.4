Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABF618683
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKCRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E081ADAF;
        Thu,  3 Nov 2022 10:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myv/zDZFhaNtYoKXcof8uQbcH6qnNHfkOnrMBwAiTTxIyh9gkqieK+3v/2sEG/LXNwca39HADZYQw9lpgv8fnn1qPFHhkDkw1n6PmLZTi09TzoanIdP0RfqFY8UZd+QQZ3wTHbP3QWdjP2vBhBoa3hb6sjVUqN2KnHJjIJ9jjMWSQUCu1JN0UO2K6+VepikbzR95rVzDux/w7mpTZ1S8f67/9oCneoMvERJ1I9/RI8XKlbrvH4JT86SEkJEV6AaYD9jKPONdDjdu4iXRCOcIrdQ97JVLigont3DectMI1Stc/RKfOr4hDgd6N0+lPWyYkhzhOsMYO4Qteq3uCGpX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sQo6xxtHOxTMb3Y176x5BNhPW3VFYSlHVEqRwaiEBM=;
 b=JhompsCnDe2xs4j/Bjo8YT51hECp+QNtJszbiLu9Nnw54kngT1y8YKF7nNEYk0bIgr2blKwQzFPGN91sM85BP0V8w+zhdcRplP7U5QGdeR5/4orS8yrfEuCpbwroH67E0HBAijNoOJdUMWwJzHc13kt+e+ub9iZsor9H4v6m+8jqJsKTiXDPcJL9ZC6LLwCNwejtAYnJsEtEynwdG6ypTtvbyuvW++rHQkNIofOMqCAzgigZyH0p0WwE4VuOrrgwiFyAEflAFMHSC5uv9CfRdjwTzNTXM1exJ63qhLhU/J1PJyroV4Ye2Q7dYVhFvlCfQFAT9uBPyrn+Ae7VNj3Pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sQo6xxtHOxTMb3Y176x5BNhPW3VFYSlHVEqRwaiEBM=;
 b=nb1SoQhKIQi8ubFcDepcU+N+nsndZiYQQ3G3Pi9JIDMYwOFL7PmWotSDB7sziMuxqxSkDb/i4wmTUYd90Xcm41nv7OT8Iuca9y5XrmRMM1DY5QwuK2vj1P8FpvLDesGdExas3KYSyV8Suu9bVUqmdJSljlEeEaqLgYx4M8pji/8WufX0SZPgrk8j9943pcvKf3t5dXpgU8L9JJcsw7SekBmdpkSJuR88mUlEQkpH2c+sly5MyqmTwapvDEbj7SkeaOFkRNnVNsGKnpcTcdyUVs5tWz1kE9JRBF/vl+xIitk9xbD/nYTfAzmlkk16aPGIOr5+4YMDQPGx60Sqg/ihyA==
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 17:45:48 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c6) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:36 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:36 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 7/7] arm64: defconfig: Enable HTE config
Date:   Thu, 3 Nov 2022 10:45:23 -0700
Message-ID: <20221103174523.29592-8-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ab95aa-6ea3-4878-3e79-08dabdc33ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTD6m2TKxfg2juUN9RA3R4NH8d2eyhwAwHs+C8RaFuWq4vjjxk6jECRt7oZLWlDZFEA1YyB67IumiLIrTJbVSvd93fsR39DldpDxDaesmDkYi7/5ro2cc7oJMu0Mwqoy1alFfaKLXOStHHHyY+ULN2CcrRBSN5EOEhanUNuQK+NHdNueaOoEDG99iHilJDV3DFPqtVIZlYX6BMhry4etekf3Ay6DniW8F0AWjeuQgJWx7JY6H7EXZVk80mE7EnIrA+I/228T3ix5swzwZauBG5Lma7pr9ZxP/RxBKHhA5UdhJqjrH282VaBXdevjhUtd/bPiZ4Lm8NM7q18P4YgC3uRheA46l9O7w8ew9jm0Tit2JxEXLwaM30BuqrOtGB8X4gW1hswDAbE0mtupAp/odsMRyJhXYA7vD7Fqw6ICNQxdpbrQ6doRz6fWSGA7hjJdIl2sJPdugou2RRnU6TsHsUIk1k32BbCELF0C+o6xrRqBm+XP01WH5du0f01tsUGq86f95/kg8VM9vqkiDICz0p6Um+p0aejXmqnHILf1gfjQ3/Jj/0XjBH9RENweYjpFQwP4/WUQRFF7WbxLPJzraA8h3APov9WVMbWJEbUrJu3xvPBOyNkIm6/GK3oWseWXsQ393diNFLgKEsgG6Pr/kqFEHORqlcIH9weL8mjwCaJVKi61TisjKcEB8+BDkSTDCS3l1FlJxLSRhaK/mYB3CmMFdMnmvCGOdDrkt3jOq7ozRMtb1tMJlWeuOdJznx8GAIu4sJsxzki2w+mK/idEpcIdRfWmz7zjCCFJlUZO+LI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(7636003)(4326008)(356005)(8676002)(5660300002)(426003)(4744005)(86362001)(47076005)(336012)(2616005)(40480700001)(40460700003)(2906002)(107886003)(6666004)(316002)(186003)(1076003)(110136005)(8936002)(36756003)(36860700001)(41300700001)(26005)(70586007)(70206006)(7696005)(478600001)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:47.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ab95aa-6ea3-4878-3e79-08dabdc33ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HTE core and tegra HTE provider by default as built in
module.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0b6af3348e79..c6e04a4f89d5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1307,6 +1307,9 @@ CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
 CONFIG_INTERCONNECT_QCOM_SM8450=m
+CONFIG_HTE=y
+CONFIG_HTE_TEGRA194=y
+CONFIG_HTE_TEGRA194_TEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.17.1

