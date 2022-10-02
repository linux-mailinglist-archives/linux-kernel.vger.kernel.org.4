Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7A5F2468
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJBRyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJBRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:54:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3FB73;
        Sun,  2 Oct 2022 10:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJslQCPiyj7q4eoGAothPDfac9yBk349D3yzaX1+051/AVr90tmBQfmHt7rMom19xddardNP+dB6vg3Zu5kU1qcgwYrxsX07RVhwSLBAQZ/+MOwXJQmO+XOygRuEIeLGEXkvdeedi2KYZRGzGGTFm1Y9riraoyLVaetxraEQ8iWtLUmZYEyXkB52Qa572JRCnDrzVzRpX5apXyMsMOvWGg3VDhOav7dt/9n4zNIlHbpPRN2zT1CYW0noprSEwoJv4goQhV4VKhdky/+5oFD8EQc3zERVoLIbbNZxI9c/3cLyw6VeeAQPg2cx3cwWX3dw14tmFcd0rK9D3h3fSCWLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRS2pc9VQykC+BTL6zITy+OBfUzWq0plnbhNAKq3OMs=;
 b=OcU+mpb8mX2bI3tJdj+8Dy8GCVxSF2FbdiAiZbuZ3xdgttYoa53JGHH6aynEYHuE+9C2hkfxC1bMGzpgRiQ89t48sV296hGhRBJJu8AZ+EjJkbWwwJcc91Gtk0UGafzgKWsABAY0aIVD6OVftwDz7o1DHBtxUz8heBEsb9GJKM12AbLmpweRaqSQvLqLzfCwRZv8ihMu0LtzIdm9dpZoKcYxzct9nhPJPOMTiK4bG/QWtl2CMWIImhZ7dvzZE8DD8Zt/InnYa07nXrqwJZlAy6aMEMU270XGASsh8mLXWo4GefZBsni40qnfVjeOFJz6BM1rIsCO1vlpNFtJgSQ8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRS2pc9VQykC+BTL6zITy+OBfUzWq0plnbhNAKq3OMs=;
 b=IbFvcVtUJpoKbrhjg5FkqJq4Hp6L0CLAYdkqP0ojx4TPmlA6fH76jDxqUU7v6qcFk0sVDGi83qFhesWt8hosIMrrgiHK+MEQhV/zXImJhOHyQ+EfrWGzBoI2x4F+ncFZvTb/xAyWXi6G8IgqtuCK3ABFHBsBo4GvMUSBMm1OX8auhDJuL/rNlV4XRT+Jhl4bPcuA1WwPLRGa+jPuz0mAF+psbTTqXTKBrP6mPU7NSsuwaE4FxKPmm5nQEaGP51y7OZ0Z6pU71mlDOl6SJIqLQSv/ojgWXOvDR6sK3BpKmTHN5ig7zjC/7wuwg1HAn8PLIjI5GP6fn1ZnWAqWGK4RaA==
Received: from MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18) by
 MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sun, 2 Oct
 2022 17:54:32 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::fa) by MW2PR16CA0005.outlook.office365.com
 (2603:10b6:907::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Sun, 2 Oct 2022 17:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sun, 2 Oct 2022 17:54:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 2 Oct 2022
 10:54:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 2 Oct 2022
 10:54:31 -0700
Received: from build-petlozup-20220913T015306864.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Sun, 2 Oct 2022 10:54:30 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Select IRQ_DOMAIN_HIERARCHY
Date:   Sun, 2 Oct 2022 17:54:25 +0000
Message-ID: <20221002175425.445559-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 353a7216-b65b-4919-2f06-08daa49f28f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiFCQFMkzgqdagT9FsrUPT8LbQVk0mAy44loueaTQCXgRtGs7iCWbQxE8wtiwlfn74YXFO7E/MpSgZxq62VpdQF+UThfwk8/tbgP6h2JLbeUMaAas7oGRRrrrJXIrSBbvJGPUFfBRkVPmyvU10HE74RAczCB0iZy1hl+MGfnForiAsLJGGjzmCadNROZFMeet/B9VwCNOc1HzTdFF8uy+TtYYPhjALnWBDjGL4gC9+ONACwSZXKax4ZeJywSqqvX7EX2mRWyhiiWXrt5Or+ORzzsJmlYI2FYVFci6RNqSXYL48h1V8foX6MgVDHpa8efOq79JK2g5rIcHM76+WOP7WP7T9EyyrkaG2Op101r4FsfM2u8J90hOjTAW/MiKUH+vrfmNEuL1xLiEoZI95YGfePZKcI0/I202HVErwLIyZSaCuOit7in3VIiDe1bbBYVZr7oCL6pmnd7OrqXepSYNHD3AODsD1Oh9sNaKU7Tel3OVaMv0LNVwdfIh+h+Q0daThTlepyjoq28fEM6fFnRRt64kIiQ5oSzCqIRvH3nVIH1l1ucBnAQ6PYqKpAQXqKhheja7cf3oYSqpJzFLfBXWZUXS9MlIko65TGS4RJhdGIeMvCt66mTMvw8LUCjIESeriOA/Otc+kHVSg6/B6bkh4x8TX8c+osxkmTpej2VpBM4L8UW47YJhUgvSiw9gRSsLnTO0YLgLyeVTaqTWROnnJ/VIrvFJQsddEkQI9mcYX++O7X2w0Hn7rGYIPoBAEqVmFaLC/Yj5yRjXP7varvI8JZkHIUcHtpVtWDWKKrWyEE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(40480700001)(86362001)(36756003)(921005)(356005)(7636003)(70586007)(40460700003)(70206006)(8676002)(4326008)(82740400003)(82310400005)(110136005)(316002)(2906002)(41300700001)(8936002)(4744005)(5660300002)(426003)(186003)(2616005)(1076003)(336012)(47076005)(478600001)(26005)(6666004)(107886003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 17:54:31.8903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a7216-b65b-4919-2f06-08daa49f28f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC driver depends on IRQ domain hierarchy support.
Hence select IRQ_DOMAIN_HIERARCHY config for SOC_TEGRA_PMC.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 5725c8ef0406..3d19adedb651 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -147,6 +147,7 @@ config SOC_TEGRA_PMC
 	select PM_OPP
 	select PM_GENERIC_DOMAINS
 	select REGMAP
+	select IRQ_DOMAIN_HIERARCHY
 
 config SOC_TEGRA_POWERGATE_BPMP
 	def_bool y
-- 
2.17.1

