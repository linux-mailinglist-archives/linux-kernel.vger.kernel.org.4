Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E5A72E20F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbjFMLtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbjFMLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:49:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5090BA;
        Tue, 13 Jun 2023 04:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC9wJ5zpBrG3Jyz/sWcj6++YvVedBR7t9W9MV2c2FuVSthFj6/1+8KqsSv/yplsoKE2b0qj9U51NbR/HmCiuKI4HFD5KPstQlCwHhx3r5aK3/A4MMqr3ktbu9pkOroj7kMRoq2LZp+4uQcudCH+J0m8L/ApAkR7ip7te3T2joNO7B9dWtHk0Q3UJUhk+kuNrY9vKgCK/2i0YDqxneiwKHASicwxoiBLAHkBLLpEyHTTd34gtM4j2ifOfaZi2wEKyuTGe90N4Mocf0JN/nSaB/MICzVKMGWS58E4RZQz7ujINhapqaVu3S8n7M800BSqgtpaJOteFzfwwOCtqzZ7NgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy+wdJ4SRgf2qsL63HDh5KAoa148kEROpkTGcT1sxb0=;
 b=ZRIOXzS1AElYJp9dZvB6oLzZGsLZ9EYlnh7sax5M+k+U0fKABVa0VO43M/fn77g1B6h7agv6LU3TbhcLud5DvtTqNX/BL1YO6R8OM6fgOkfmtTyH+3eN7PtijJ25eqI0YojdU6jQBKzvf87VWSHbSVOw0ZoZrXDy3fgBnRo60WIxU8sH9WavzNSD63cDVHPB/F0Q+GI6a6FoaP3+ATY/EwrvUBBBqOzivCZpLizDjPPpRzyjpdhj6n7t4IGzyKvh4UtF6BD5M3TZsaUfhJJsDCyfhW6GcyNWKHXmltHYhtzWyhHofWS+AMVcXFWofiYvvNaZJAgiRgCyvytrWa7Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy+wdJ4SRgf2qsL63HDh5KAoa148kEROpkTGcT1sxb0=;
 b=Z5G/c+3LvrLfRDxAM8FVnjZgEhG0qN9farR3eC691oLy0Gg2u5p57BiiGjwrdzzniKgrGWb+OXstApsiT1XLRvdnQE10in8FM+E0KODmkOusBTK4+ZVojw75PK9mmmw0G5KkTEw56EBKUKJv2zp8AJwApmpeSihJR7tmLLh06kUSuEb2uuRQTqvZNbny+FXxHKEF4YU0dItT/48l1QFxlcAUwUpZTjb3zLKhqm5FjmD/dJ0rpZDIGQ1HlYg6VWa8HHekMKTKKKIUYASqPxHOpvYqyn6qMCNA1Hw2K3GL+wbKU3z21N7IzrtnRAUW6LJ6mW0ZefZ7lJMoY3BIg3v3rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 04/12] thermal/drivers/imx: remove redundant msg in imx8mm_tmu_probe() and imx_sc_thermal_probe()
Date:   Tue, 13 Jun 2023 19:48:56 +0800
Message-Id: <20230613114904.15749-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613114904.15749-1-frank.li@vivo.com>
References: <20230613114904.15749-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: aa98a817-576c-4656-232d-08db6c0443bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X+IqQNOQURDajsUDeslyW6LaD2H7cBBXNwx7rPhJfAkZzFXzDyMURZghIH6nXufB56QcC/XG8eXJu44cZTwClQq6y6eQqvk7niHx6jIu8S4kznhcyCXPDQ3kgZRMIz1E8b5ZgyDV3tiM+RNCZ7QHw5tMvrVKVB4zqCKpVWGZR5DYqMSu4O3Aegbc1Q2mB01YR/8T7r3GorEPJ7va8z9eMrcL37om0ntdOUERUD1z1WGMJwQemjOaHhvs/ggV4MbAHGjjzTyh4mi/0E9owpVEnGGa3Ci6rEosWnfTjFOOpANnwvUpTP3zZfW/yFoaAD1Anz3vtpGe/aKH8mlrOG7rx+t8yg9c9ZPpEoz3kQS9sGCJuGPqAFg7gFji+OUYUUuENOSpd9DKv1PPqlkUIfTdBbSNCyzETT7UQ413T/AeXChdfpQyKTYG0gEbTvs/EJlG/enjZ+yrLJa6KCd53nVqCHOln6Jx3sxnh/CFTiYsJcO9r7BS4/niJDjJJUckEdhhBrl35d844n13RrFqf9KGQajAbWd+VANEGlF2B+m1VFKlogFqGij/a1KLEL3EXZXwc5Qpv9EKAJQ8GmaqHfDyN+ENSAi4V7km+zSMuKn/+ObvsFI7P/8v+OGx4Cc/ZphTJKOuJ/Z2szOnFLK4R5/GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9dVVeSyyc4mCbZklYNuDkMBoEhtq9wHlLEg1HZQTQWWTxcudKT5ZT4J345p?=
 =?us-ascii?Q?ucL7sKbFtt2HdUVj5OZ1wAgmj80XJZdfZ5NZUetPAOgZ2iKMw72bwzoc6w0G?=
 =?us-ascii?Q?UxgV3m8LOvqM4tI/S5y5gvITpxVI82ItqBbyUHtxowIGHoWbRAJR+rmY8eUB?=
 =?us-ascii?Q?LruZSnX/rjio0zOxqTwn1gNggfI/gJpgGrGhXOwiVmDfCTDmhAzushHv76Fd?=
 =?us-ascii?Q?AcOWsPhVExMUYDOghKFP0YBc0exIiv8MrZoxYB6la/gpQ74ZoiWpSQOLOuHZ?=
 =?us-ascii?Q?xT+2fLnX1AjKBdBOL2MJlGLNJsYkCkX6Noc+IkAUCIgmjkDoIzVrfTsfy/7Z?=
 =?us-ascii?Q?XIoxmTO5csYXNPLXbXVicYzRfDCXfD8N8jD4MKqpd96565ej1wVDbNNlrJNi?=
 =?us-ascii?Q?g3SLl1/NE4ZyBo00QiZQ1F+LBSY5sA2oCiduzBufGy1FI1eKB4L0Zmb8ODMv?=
 =?us-ascii?Q?8npVHAz/ZxZBx507kMBjr+ZHeABk2RMudq7PGLbtdk0nqpdHQwBZNmVrIz3j?=
 =?us-ascii?Q?JHlWCXwumGz/r+6pQ2aqvPTqVTFw3zcsaweaaI0IB/qAK7Yx/0cWQYcvMNlp?=
 =?us-ascii?Q?BjJurm4UFxW8qc0cFJgLiveW/lXxALNJEmHUDu81k36WmjreuKyyOFM09vG3?=
 =?us-ascii?Q?cxIzH2cN51h/vrZUAoy359AQFNgpVxYgFoWgsyKbm8MFFWRpcZHGpu/fksS2?=
 =?us-ascii?Q?TXLjQegtrLbFpMw/Ua+IfwDDT09maYSZ3iHwmZXOgvPhNhGP9pjfx6hthdxA?=
 =?us-ascii?Q?m1Bqgq+NTB/MTwakpBN5cwm+ajKN0n+NDCZhHynoggvTsVYz89ia0Vq2O2/m?=
 =?us-ascii?Q?rY5KjVRG9q63DFULnYQDCgYiB4kHyvA6EHT2Ra7FyrcRaPreE9rI3OJ6GFvv?=
 =?us-ascii?Q?1Ra5+Ldp9NRCU60r0uzuWANeRQAyk0uTd2bPKDmAGipPbeG0mv7C9VbKsU8R?=
 =?us-ascii?Q?9JIc9FQaIWLQf7XY/e2bfaPBvosoK7dONpDwG4Gx5JC9eY0re2zSiJCj8Uzt?=
 =?us-ascii?Q?CPvW+xZwM688ZOWyRMzpxT177y/w0tA8I9TgpZepMYtjKbxKSlnLPvnGBDhc?=
 =?us-ascii?Q?+gqk4Ii1USOUIQWTFQaPwDDbU20N2BEup2QuStaCvJ9VtUL+0Ep+lTov4Qt3?=
 =?us-ascii?Q?sS0UNYVdKBjZu0YiCHk98xAGUD5574ZFJKrBMF+4Quh3frYFFeB/QhQmqBJu?=
 =?us-ascii?Q?9o7vhnv91YOqVJbrlAjwvxUEdq5W+4YH4uB+XvjIE2g58ReIl/aH1+yJ+XiL?=
 =?us-ascii?Q?K0fjySMvNzt7P6byCqBbNlT6d6NHfTkSaTdeIDlnf7ODYLCYqtSmBLoHSSzz?=
 =?us-ascii?Q?WYu2ApBUOr3O3JlNpOyDw//P6jiaROjR6Ip8RFjYgZprdtkEEyc/PniofZAN?=
 =?us-ascii?Q?RTgXkGQ1DX4/1duvty1IvBl9fxpStWAN3hXZaGT40XQDUrVu6QOPD8ikaTN4?=
 =?us-ascii?Q?PUq1aSJflwtp6Ou7pI4bzO+8EWA/rphz26CfK/PdlKbZW/IgDJs1v3ob0lSH?=
 =?us-ascii?Q?/p3/aAmnRJzyIq/BZm8NcmWz0CN+uzjQXRGcdKMNn2e1GWonQy1vsqHSZPsg?=
 =?us-ascii?Q?EM6Z7zi5GpeOT/Sa6ovVGvXyWEeXY0Q4x7tlz9TU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa98a817-576c-4656-232d-08db6c0443bf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:37.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah9kCaEVbcD0bO3cK1qXHleEdoJRwbIRUAbpFYg5mnlV+jiUYCXWIDPDxugFZiMIZdtRT5yVVzMw2kwRH3SDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/imx8mm_thermal.c | 3 +--
 drivers/thermal/imx_sc_thermal.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index d8005e9ec992..d4b40869c7d7 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -343,8 +343,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 		}
 		tmu->sensors[i].hw_id = i;
 
-		if (devm_thermal_add_hwmon_sysfs(&pdev->dev, tmu->sensors[i].tzd))
-			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(&pdev->dev, tmu->sensors[i].tzd);
 	}
 
 	platform_set_drvdata(pdev, tmu);
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 839bb9958f60..8d6b4ef23746 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -116,8 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd))
-			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd);
 	}
 
 	return 0;
-- 
2.39.0

