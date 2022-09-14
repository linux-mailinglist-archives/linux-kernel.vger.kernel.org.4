Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF15B5B85B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiINJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiINJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:57:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28033718C;
        Wed, 14 Sep 2022 02:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWcF/LY/3jVF4wOWWFkTAJciF1taYKvHzB73CpI0EWTPez0YBJp9XYCUCpPU1dm467ETJReNYEwPOnXPpX/XJGHd8t3Ma6ziwIWaZojrlXnyMhfSQu8PNNtUvUOzZOYcZ2bGlAFAbuDKrJsBcCXehyM8akrKFJkwNQsAVvLR5B3rPnWAfj+7sQmc5eBb7sZfYKEXZZCp0P7DW6UKVZGw433+b341FX3hQfGMrAxW1UmaQCL1qK2bFMhLoCPyEQKECSucptWtfVHue3x9wE/xZfWvvpqg9hwz6oI+DfkZRRICmZOgfEfLEYtjbm05WKsTw1P9hi8KW/Xt9i5Khxw8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qBQYNaKm2MhEinRXcg8iI4nOywOgz82jF7DzulIU2Y=;
 b=Uf4fR0nNuZbWsqY4Xqk0DtXwxacGusMfTPJepMwG3cO9r5NUgk4UcdE5lBVyY/Rf1UPBErXx484gPogj0JJLwxAS/nzoYlSKg78VtkWkURiG29vpr2XIp+VwCxq8UvGPd8B9s1Pd2doSPHVQJ+eVMtYwTuhOyt2L2GTMcp05hdnxqIeY3YFG4ELtH4RAyFf1Cw51ii/WYMOrNzm02sNDHoH0GkvgaHWzEQcuOAP+NakLYFixSUbf0i0/mYYiXXBQ0VM1acys2AHYtHb8mQHeMd5/S8Ny3Jv7g/yYsaEHV7ObrUT9louH4MLnHDIxRfmV4ehq+anklHIeGpE8/ax3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qBQYNaKm2MhEinRXcg8iI4nOywOgz82jF7DzulIU2Y=;
 b=r6mJSNTG2BJC61SSnugqGMqGU5Ou8uSixeffs2ISh6ybl1SR9MDtqrPZ5iFCZRZSl7itplIi8Z3CU2bUpF3EFEXkw4QGoTS6D5TosGkhQUNaotO32r/1iX1xNgLowbRBQseN5nY/6H1spYniZVtQJgZAkV1THaQJS6moUobHvnDR8Pf1hrFKf467mS7o0vljwiazj8tJ3BCSKrKeX7PB91M7etM445J2bSg4QpwAEPi8Ecfb7PSLJngEcX5KRx8ob+0APtJCAzqVLeFgCMT98WtblHSYk8LAT9MWwFvoQoVtZ+mqGwwviQtP7kYMtrWMZdfkZUr3XwwTZ+Taqz249Q==
Received: from BN0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:408:142::24)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 09:57:04 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::99) by BN0PR08CA0017.outlook.office365.com
 (2603:10b6:408:142::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 09:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 09:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 02:56:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:56:50 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 02:56:47 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v2 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Wed, 14 Sep 2022 15:26:28 +0530
Message-ID: <20220914095628.26093-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914095628.26093-1-pshete@nvidia.com>
References: <20220914095628.26093-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: d82a5b9d-663a-4689-72b3-08da963779b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOvDF4zpWm6YSXNHspdFiVCWu1P/m5XXbiGCurhX17OsXuDyfXMc6iKW7rIVH+jU5yoSG5cQj2awq30kXhfAvHQwxEJoMynEfhzeh5HhkYbHcz5a3huAQZ9yKmSdk1oS1m9PXtsHVVo2c1KC8gCBv042Eyezy+RDSg5yN8j3DluZjyFUSNrHiLSoqA13dNYlkVXFoPNvTmk4i3A+Za8hKL+vVHkiJUshPgi791gt3JxuYtRAjseYtEr8EW1zE8wxuPOaW0Mdy/IjErMzPzCbvKsfSd0c7UKy60idIX1hehjwz39x1uww1403FEYdHKaKPknntVOZRH0QvFTzySDVEY+JOGztzRNqrU8yJbETFd6EYiDk70X3ypFW1C3/PMDVAHdYBQn/XDEWcBq6RfK7sRaNWvzKZVhNjZg+x1++M+vzQ3HxXOtRxG696XVE1CZtHLNMso3JKKsa+/iRKH1Me3BQ+A24d1NziJOf6M0T14to9woHOxMDS2xdRMFC7NjeEH7tiRuCRNvBksQm2mAVmaKof4mEJh4EETiKDa3Wsn1p8TQvZcPntO9Ovwu6zQU2qRFLqEoIWdl/AQvtS/kqW8chkSSwS5eThf7+ie2PAFS8lvMKqwkdW2x1sYbu2jaRTIC8KUB9NY/2G+IAysUbTi8bqZKEuUtmjlgXVpWeyCZq1okfuhzENytYNOnRS0KRG3L6SKPCathtIjOlNSrhwCuUIt2TBMvPXuYFi3pLFWTv4uxQ22uZpaeAGpqFErSVUB9/nGj+yxmm1lln9/4vgg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(8676002)(1076003)(54906003)(86362001)(7696005)(40460700003)(2906002)(41300700001)(110136005)(8936002)(4744005)(36756003)(40480700001)(70206006)(478600001)(316002)(82740400003)(107886003)(5660300002)(2616005)(4326008)(47076005)(6666004)(426003)(83380400001)(70586007)(356005)(26005)(82310400005)(336012)(186003)(7636003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 09:57:03.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82a5b9d-663a-4689-72b3-08da963779b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
instead of requested clock rate for proper use during tuning correction
algorithm.

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7d16dc41fe91..42b018d4ebc3 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -778,7 +778,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

