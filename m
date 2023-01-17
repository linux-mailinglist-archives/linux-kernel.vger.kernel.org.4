Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD466E683
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjAQS5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjAQSxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:53:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8959E7E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIvjHEZdsqWv8sIbMhxO8NLlQGCxFHiAn1j/SO+0P0dmNHB4KDR1kcFLAYy7Niwkj3CngtSVGrD+4GC5n9Gpb73qjP6wa1FgfF8aF7tTJ/d2r2AO4XTjAvogMU1ZBNy6JTkOFc8fA0yK8ZTbN6UFYIRLstKPfOe/MMIzjJdKNMz9SEOFBe3Yplv/Vt7i20uE18SNv8pq7wlvTzUC5kf/+mpllh5bXlI2XvcmhDmDPveTBfNcg/A2DWng94TE3OiJk36Y86QNP7sl8ivujQhC8sKiRFEj4BRqAbxKdifOArn5UAjNyIw8AIV2diz/efTdxPX2NK1QqQUpoDNAMwUIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTisFQAnn/izqNFxlaa99ermaFC5YZPY7gtujuoRrVk=;
 b=Q8f1nKAI0ZxtuzZ3tn9/pplKBrEjiwhgQtE7h1uOHzPOecN9CPdNi5LAt6gOm2q8O1ffolSIUaoBqZLuwq/8u+9ab5vaf/wj7STYL8rtbKP65LFr2HpQhiRcbkEXH52QaJ65Qn0KhHGwT8zQzoo/lr0jmlfbFJdJHeXfsdp3p3GnzDWT90Rg9r34q5h56IbomWPMZ9Sljpml2tj8+Ta9cxpTV5dyqsDllY2Pn5lFYJaZ3JH/XkyUlNJYZYizWI4+86oB36IrpQVFceajqlW/dlmnZjZlhSneOZRWuz7FRMxpyICfczia9cuUWY1dx+52vSPDPbq2dXoicdh+T2TvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTisFQAnn/izqNFxlaa99ermaFC5YZPY7gtujuoRrVk=;
 b=qqJmBCIXfWfjegp3AuoBuE49WrX3tu23HJLI7PCPk3BCo4HZpBb51U1JoUOg41471B7i+uLNXhEMjd3ZogzthViAhbsOjfbUrlgpw9Bh7YCEqp/eBbZlU/lihFcFX4syerrLClqhzgV6fRMvbup2HBPO98Ra7azWfZNzsKkjmSZjTyV9qGy9ZitsMkHfNCBCAzKlLUIgZhAmwtHE81008mtUCc8ZIWCBu9evJo5Ki7kw/9ev3DH9ARfPEgxK7Iw9HOWI4aeaDXo5lvpt9Mnd5Fei/zXJlhFUMuMAf/BBRv4p9VNgP5IImExlnA4LJKEJjKXymXnNRVAuQ/UPmqoL4g==
Received: from DM6PR04CA0019.namprd04.prod.outlook.com (2603:10b6:5:334::24)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 18:17:17 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::21) by DM6PR04CA0019.outlook.office365.com
 (2603:10b6:5:334::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 18:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 18:17:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 10:17:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 10:17:06 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 10:17:03 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <shawnguo@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
Date:   Tue, 17 Jan 2023 23:46:58 +0530
Message-ID: <20230117181658.17010-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d39835-ba95-405e-57eb-08daf8b710e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUDwaT3vxtHIFGrma4yFtMa8JVZoqlevxm2EAtLfs2xcFAUFwYFWIPuS5O7vTvuO9UUeqofZ9AEy8FK/Zbd5j3VbqWartTaHRNAJCbf54keiu/Rmul+WmZdfmCxo3Jd3WjGwI/3CSQWvSYg9iRu/UY5aro1/+D80i8UoSd6yKCouG81PneC/7MHa7c8JBc0ANqC0xN7yGO5HOvz4N2hhNYgiEy8vv14UMk9z9+y4hqVcxO67Hep1jJPCL7kgxejP39Ak1XCtd2+g6HcORibPLl14bTl/EoUq72WPzbpf5vlhk1DWWqWWjnwEmAqU5pSJ6Yew2aVV0c2zrAakZBfeftFeegA3hW2G88VEaFRdj8YvkrupKkaJ6cv8VCctcA3XlGwzQGJEtpgvAkhLdeUdmC06MEzMGzSjdz55mS/UTFmF5H8RfLQyypxubEvcKWvvmY5hB63pemEuW+smVVkDse4h61ZjM8Ms9Gibg2qWZe8QcYdSnYqLHMGaPjeog7ohFA6jSgDBKzV1vYVRR8pEDq6M1Ll6lqxOif4TxULXZbwqQi3m6HcSZ7HQ+c9AOGCTgt/YsRbosWTpiMl/VAKo2Im52gCl2ZkpDf17X5yRSjTeOIlNvvC0+4tfSkmjve/Hx4LqbOa9F+qeEMaHbrur6Qi5g4m3sJcHoh4GKdYttjfctYQu4vlAYa71gXxwwHoObH2zdlbmu4EccjRVq3Y7Hg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(356005)(86362001)(8936002)(70586007)(8676002)(70206006)(2906002)(4326008)(4744005)(82740400003)(36860700001)(7636003)(5660300002)(7696005)(110136005)(40460700003)(316002)(54906003)(41300700001)(6666004)(40480700001)(478600001)(82310400005)(2616005)(426003)(107886003)(336012)(1076003)(47076005)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 18:17:17.1306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d39835-ba95-405e-57eb-08daf8b710e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
ARM64 based platforms as Intel PCI driver was used for registering the
sound card.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f3053e7018fe..abdf0ff469d7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -812,6 +812,7 @@ CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_ALOOP=m
+CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
-- 
2.17.1

