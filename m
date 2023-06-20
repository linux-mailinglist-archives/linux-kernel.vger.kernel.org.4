Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EF673672B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjFTJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjFTJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:11:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3981728;
        Tue, 20 Jun 2023 02:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVORVkEC5motW/1PinugGXAo3gNV1Z6VcwNhfuaEoui0Gix9UBlflVNWmg6oS/jzB/hFAkT4cZcTEo20qUrdJD2Iw6vno3oNNmH9vGZN8ZMqY1Hr0U4xYIm68AJKHYQ+fA63nI9A7smnKOyMdDcTyKEH6YeeRkGAJfzil7Voc3rehoBRxDBqKrT3jJRISM9NFemzYcKiNNdTWu2g4RkgTrQ43b/mWe4MUqtu7EckwtXLYh0LkX4guhx888WL2n1HBf9Z39D0HOM3cBQRkwBuSHevz11cT/49gdpK+RbqxnfmWSFZX44VTWXMIU/0jDiUqlZiC7EJmkpkYDMfak+Q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy+wdJ4SRgf2qsL63HDh5KAoa148kEROpkTGcT1sxb0=;
 b=ZQGkJ7yjU/4UAHuGG1pyEcqHMt0l0BDLGU/LftKJph9Ix1N+uPlYfA/Dz/nFBqV722Sso886cQmUVBNw7OH5I7Zn+ZKheEeMdAaVNdrY+8FcJWqlmwft45HqcAXQRAnwF5FYSl57p9BTkdaKGZQthVAMQVhYRzG5RbZavnF4Pq1kuc2ltt+Z0TD+5WeYnQoNWOc2isU0WImzrOWSKX0zqQMlzBBaNQHatEZgXBTmQTs7Z9Bn81YKK424HiY7VCmUjlNi0//XJq+AU5QYiYQC7NTPj3CTFk/gszqO9QolzuSrM9eVwcWZzY0wFQsrq+An6dUwGcE6hYvG5g+6PUi0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy+wdJ4SRgf2qsL63HDh5KAoa148kEROpkTGcT1sxb0=;
 b=Tx20Fe3P2mfpAgqktUGzoMkysR7fPmm9arX36XAwzKV99qBNsyaXdTgRbN1w+eVdg88NQCsSn5kA78n6VvmiuBzKHRxj1jlOd63O47nX2gDvwQa0xlRQVCINdUPZ+z0jWX9foIXSbMZB/ZJ2yfEDkuQQyjiNvLQjdmwEgHkJsLEfNnGh84ClX374nqOS3bAkt0O2TocnLcQbK+gBO0yiCttG5x9g3ET4I2FRQfo1QfJ3ykiAJj78JS2w+CBeDDSANF9zu1b9NzGLb2ICaPaWlM/v3zgCEHaDvig814eVzgKTQfS7LPin9zgH5Mug5VkP6/aYAI7Y/XsOKbCae+YAIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, f.fainelli@gmail.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 04/11] thermal/drivers/imx: remove redundant msg in imx8mm_tmu_probe() and imx_sc_thermal_probe()
Date:   Tue, 20 Jun 2023 17:07:25 +0800
Message-Id: <20230620090732.50025-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230620090732.50025-1-frank.li@vivo.com>
References: <20230620090732.50025-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dc6eb5-8859-464e-d85a-08db716e4d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jbz93tT0YdoB3zuvF5uqeMheKBG6oakxPjFoZJ89hTohX27h3mZ/4g5xC7Ac2HNzNVoi7p7Xz63GFvna+Rbo6YFIsrdXj2FL9BoExwSLskJCArGIL/X6EsPOokxUmnKM6JBcnVYwa6XefBv0eZ8NK/WXP5cIRXKLNKiyB2syok81BINtAXH3qmSg1U+VqZI4bQ3zVYarGV0HTzazy1yjgXc+893VOK1/WC0k8G6hIh/SEhPnDpTkMk4HliEUhMQZJ39rdjMojAocAXf0GykQGrVYXWj3auPLGqBF5G/njqet7RenqJ3HB6e9ZvKXt48Q/2etTXkPrXxw0zmEnPkD2TYQAhKLb3Sx0peztg2cC/5/9gdDNIpFfL4FXtYzckO0HusePReWLluZCI9OslskBEXiQAXwJM51CzR8/QQZ7ljh/TXr5JCYinwqvWJyDz0f0dvubEKouG/OHQD3Mg3LdT+Qv6oqm3ZxVpQspvVzQKumTXRedl+bAXkKSrqnzNu1Ch9o1OJByB78QM685r6zlLHkfrboP2n3YlbGSF8KwCZ5464v5wRJUUGgKqQ+xh8ZGZ6Bmf4kALakQUO6qDOD5OclkdL+ERe+SuHMijjyPaM3tuCtg72lZum2b+HlBbJOW258XXBfaKTTilhGpFBNgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPScpPqanjMah2bNHDgvYCgbjo34jsVpVSCdB8UOATKqk8h1aMCTJSgq1IqQ?=
 =?us-ascii?Q?jZD/EtzZ5drfASuqeo3bXuTZ67IJq64TgJAAWi0Mn/gfZcqmx8RUwm1ORYbo?=
 =?us-ascii?Q?PSt9mlTo5TsAeUmy6oSpXErDtjF0QhI5pcwgYJyhqpr9gFA7tSo1kHce9s/C?=
 =?us-ascii?Q?7/g4jmKzYxSVdZU000SSxIqChDVX5b2mwZ/7c0+AadKr9tXL4KKsTpVkqlKu?=
 =?us-ascii?Q?zoAfd4DNr/P2PEIVBscGqcYnk80Gv5wRlv8iaEouOTxfIMEG5j+4m9xDnxXG?=
 =?us-ascii?Q?LJlbVM1U9ECY+lsSEGwV+0Pt+D3K4IRFsrc4xD7RwcfOPbYPWRhsqrDMpfg6?=
 =?us-ascii?Q?rCsIePTr8pG0OkyBwzc1vbAp2hEW6c6EGmWLWImbsLnJ8WOm2cc3B+B3f66N?=
 =?us-ascii?Q?Ayg43S0nYFpvL2W5Wt8CZERBuDTvgk6qEXdX7KwnCCFSsD1i7gOEXaYlxVXj?=
 =?us-ascii?Q?0cg0bEcY3BcTujETPzSiCnZMCK6GsBCisA7mCZePF5UxI/FpxEi6p7uhW2K2?=
 =?us-ascii?Q?1OLB3bUlcLRo0pluPg/mWRga0fadaRs36XWnw5OCpz7DiPzgou16HMcd/q/6?=
 =?us-ascii?Q?vs2k98He/GZRIu70MSAIgPXDdzepMGICQfEHOSK9e6/KJXAIULpAVWfJ5x5i?=
 =?us-ascii?Q?4Xvx2MMpCqat2l+MBRS42VxLpbgs36eKSvXYdIyNc0bC12X/ntCs1v6Ntf7Y?=
 =?us-ascii?Q?v850n75orkoFRce60lJ8vfcoC7is5od81b0TnX9pRYxqiDnZdYqZBofeWs//?=
 =?us-ascii?Q?GV/cspZH1O6IzGNEFK1GnnG/TQJnj8z4oVVlPapAdp8EMrh9h1N/R9BBt0C3?=
 =?us-ascii?Q?MgH8c/1QkIu2rYQ9kmR+qhMZp0pXtZ1BV+SMJgK4zgKaRUO2ixR2tcpDLWBm?=
 =?us-ascii?Q?ZGxH9nCnEslzV6YNnoiwn+UjSjQDc5zLpK/88vh/ilmpEKe3ahuQXpcLfEH2?=
 =?us-ascii?Q?atEHBv3TMuon+Xlr0RXKRwH9Fr4+Ko2RjyjM49f5TLtlYpTLLbjiqHDAN10g?=
 =?us-ascii?Q?qbmycNEtldYDLwOjqt8Rw4zNreC/FjG3ZJtHLyOZD4AZwnY/E3fZaXe90BZx?=
 =?us-ascii?Q?UquFu1IRdhx9o6SlsfMFVviaUbjqs0elr8KMnxC6PsOthdAF7BpROdOFFarI?=
 =?us-ascii?Q?YKyOk8guajPeBn34MdIhxjm1WGDamHS/7XiaqTRloVt4+2HKxWvWcLnCpsRr?=
 =?us-ascii?Q?FY7hsFw3JcVnSxMoe/LOirqCBIEgRTocoYhN6E4sbLdVJJByZCK2Z45Pawrr?=
 =?us-ascii?Q?7XdQDYxWsy8TLQoMfg5RpmsV6FG1wVS3jgXl3WKtYVHLmBWRerl5GxOq8n/f?=
 =?us-ascii?Q?wNaDD4s0CkKT8EOT4s9uFBWpVdbeM2eNwpUakrFh/I1+hBB0sRJhJB/N2F22?=
 =?us-ascii?Q?+W1Y2Cz6Npd62kwS74/p3W/yLIfu07g9SQeqXFNUsGdCUbuuAspk3jzYINto?=
 =?us-ascii?Q?eStnCKqoaOoZGz5fWkra9byE2LDfOkgjxHL9xMavdnP8sqvwVfIcPMklJXpE?=
 =?us-ascii?Q?UIVK545bAZFJHy2VFY6715twehBjorHZA1aQfIJUHda5+sWqGXfRHRNapyX3?=
 =?us-ascii?Q?xwZarpXA1AKlLahJD/oBNBYRCoBuxWDPYtfLCBKk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc6eb5-8859-464e-d85a-08db716e4d32
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:16.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljn8LnTYKgU/F0UfXC/FJSW6vZGF5Y8SLQWn3Z9BYyP6LyJn8ZSpoI1SRqsPNmh/Amukm6LJeLC2MUGgiCHQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
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

