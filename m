Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1360DBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiJZHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZHGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:06:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EC074BAC;
        Wed, 26 Oct 2022 00:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYZ3ApH6L/+BJvImPVbQbmujLCdBa+apGwZZ4/MfCRLNT1qQyOj2MgzvRq+K6jz5PwHDLeuRupYmU09xrSq7c4MbxsZ2JzK5QRoXyX2HChNrGUCpFU/VMyvYIjircqgbeF/KiLB+xSLdg2E9rmYbyqej2ocxvAqJG06n+duwXkW9UGhDkcSpDRnjEO1AmT3gyB5JEag8D8PvvcLYicqZwITVaJQzovPq8lgVJXanpQDPUWG+ZdE0RePRavdbFUfR6gsWkEWZDGnihudPtoqTmOA/parLcqtBjAxeLrXcmaaOsfl10RDmnnJhb4eCXyte0YWweMTiMiXtSbrsmDg/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoeFATyX+h5wykISW8rRPdJcJK8iYkyvfCTwyBC422k=;
 b=QKpbdwiY6qkcb+NuWBsJdeY0TpoleQz6BBj0deZN87opFr9AMUWTKEi9IHCPct9DQTxiU8v2KKNY2nVasaXyn50cgHpqDk4FiriuRqoVcgh9pxhUb7akQNd76Pgoj/0gPr9xwPFyAXV/mM1UIXlgzoB6+JO3a2cAqmf+0nIJzXWSbrtUY+PMPr0NLG18OTJ/vrA0PbPZr1iXS1OIqkGFdb6jGRMQb59KoelwxQ5uOVKQRBAV3fujUCvinu8meaORQET361+rS0qvj7M2JFoocrKRLYCGY+cq3xxSw8MKIDiPIwQnkID1FMsTPmEgKn36IIKMQMvjs8oPwReW6GDfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoeFATyX+h5wykISW8rRPdJcJK8iYkyvfCTwyBC422k=;
 b=tbvf0epf4YrDJacIkIOLfyEywYjJmhhAFIYCNWADhyZthw1I6vgausfU5ZxSgDZMYtg1k5JwkUh5mbQjz7S+tl+vXXHGXgnBsjQikt4WOJu00r4WZAeFmGz9sKA9M5EIAaN00qzSAmjXsWQFrUx648s7mXaEuhvWkHlBOg5A0NlKHESDuxdiz5/0xgiuMeNj3ZKoZYspppAeNgt3Ugkx+fT+Al+7j3kbNljVQ2URZJKxmtBP/5x20qCCyWUPVItjWwIPpnEkWAuprwIO3fXOBDJBpG0aJRYrElF5nv6XJ+UAIZEdL6u7N2UeSKP3qhwY0aOGLhkmhcGWHwk5uJBCDQ==
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 07:06:35 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::2e) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 07:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 07:06:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 00:06:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 00:06:23 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 26 Oct 2022 00:06:20 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <thierry.reding@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH v2] gpio: tegra186: Check PMC driver status before any request
Date:   Wed, 26 Oct 2022 12:36:14 +0530
Message-ID: <20221026070614.24446-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Y1aa3/oJA2ElSGp0@orome>
References: <Y1aa3/oJA2ElSGp0@orome>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|CH0PR12MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fafa4df-d1c0-42aa-0ec3-08dab7209ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcRKXASe9blxy2SsGpgdhEEOu0ZD5T7sg0KvpuVkOXSyeR+XikN8Z3wi9JrK2NPh+MLLHURn8GX9yqinqsRmzyScbcSa/eZG9vnijtE7etr7PrVZq1QSPKfyOXkEyzzA077ZT/sRtbaiqJy2Zm8LUqsMoPMZ+pmVl1voGrchMJEW+Il5wiitNH6r1XgKFjfyA9A811I3Uy47gRBf8HCKpjoGIO6R27gx/shz9rYueJ2hPk/GOnhKG8aEwoGdbpAUV8muMCy5qiaiTKrkIxUiL9irEZ4FPXwSkzP02ikY/dG+MaeeWLc5jY1n9XkxyyZT77ogD+3u9pfbkBIqKN5EKlqgDxy4ywTdZ61jgrOUQN3aPfmond4D648goVHwdzUyCFRf+lb/BUpcU6B0awgmI4S5Qliul1CDQk51BTkvCkox8kkUpqIu+s/BF8+TRQJgDabK1G+fVDKepnQlx1om56wY6UBVIK7Y+9dRTyidgtOSserV6Whu538kdVd9fg5ia/ws64kbsbwQmiaaoKbmlG8EZ29wJJ86jYps1xHgH9aMUzijBK+58ZDtxt1FV0/nTmYQRetDwqzeG9zf082P3B+DhrghJ0qnAW9JP1kbMaMm82z88eITOVaW8Xx+mQ74IgOm0CvqSb02gLBPQhZlAcSx3Iy8knrIpgk/0iODgcAOrftEXnRbT/Qbub47uoGpDquooMVoBPWVSHTqDdJyvJjkN60vXfRFXSiJZUlg26KsibsbX6oc13lOfEPsZocXbPMb44TQKzdptBHZFHpuMA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(41300700001)(107886003)(7696005)(110136005)(82740400003)(36756003)(5660300002)(40460700003)(54906003)(8676002)(478600001)(356005)(40480700001)(7636003)(4326008)(8936002)(316002)(70586007)(70206006)(86362001)(83380400001)(2616005)(82310400005)(2906002)(26005)(47076005)(426003)(186003)(1076003)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:06:35.6055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fafa4df-d1c0-42aa-0ec3-08dab7209ed0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue where even if PMC driver status is
disabled still we are trying to look up for the IRQ domain
that PMC driver would've registered if it had been enabled.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..b99756037ed4 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -896,11 +896,15 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 
 	np = of_find_matching_node(NULL, tegra186_pmc_of_match);
 	if (np) {
-		irq->parent_domain = irq_find_host(np);
-		of_node_put(np);
-
-		if (!irq->parent_domain)
-			return -EPROBE_DEFER;
+		if (of_device_is_available(np)) {
+			irq->parent_domain = irq_find_host(np);
+			of_node_put(np);
+
+			if (!irq->parent_domain)
+				return -EPROBE_DEFER;
+		} else {
+			of_node_put(np);
+		}
 	}
 
 	irq->map = devm_kcalloc(&pdev->dev, gpio->gpio.ngpio,
-- 
2.17.1

