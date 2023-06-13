Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4682D72E227
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbjFMLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbjFMLtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:49:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7C10E4;
        Tue, 13 Jun 2023 04:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxQw1cuNGvsjzRq86y6VHYqT26ZTg6b1i9ideHoaEtnK/omelLjW/vDeVxqLNXB80aozsP1tgUEn5XYkWg819jSfPyMxE1+24tWjfcAdM2+afYIkovVHdn9FlhNRHixwDradLqETThLwP9+ZJXVDUEmFJTGtZvm4jo0T3aAP4XVWbfPa1W3BeGxgfk2TVnRreW7iMCKLpJY1RXGICxa3XFLu8XsDst09NxbMdnYlSRtpB4jBPzR3oSv5uj6MzRe2Kve/MSTT3sp4JBmnPzr0Nn2KS/80AuJA0kFLTeXe837j5ZlVrOWw0vRWLL2VzHdg1YjeWobwvJgU/k7USAUykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3OBtGY/5chd6gxnhXKVzWiME3BSs4Qa259qqbn6U0M=;
 b=Qasv+W9aK7iw7CSdq8mu+3lRcJ0iXnuhZ52SJrM2qgmNS8R6Eqb2bvp+aCGk4u+ic814DaDR9JfVrZTlZoRtTtVjII6t2yzrJA3cSc3BtnNG4/dVC1iipZaG7o9V9QyUh++WfVJgtqI3wmKMPDXNuXzxe+P6cO/DnRgXGqWpji+Ve3ZQ5Po+lbIailvx39swiSnwBhDlas1gWPfcxJquuFQY898+W0TEefaa6kusc0idAarGkNy84gsm6/XqH0zZm/v8V43519KRzUkLxv3K+I+z3TS7rfkadpWzLENxLuDFTBbgiJHzUR8T5XUGmY9I8BX96h+DVkpgjCIDY9uVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3OBtGY/5chd6gxnhXKVzWiME3BSs4Qa259qqbn6U0M=;
 b=Ij2waRngEzbNHAQPl6f6XsFFwJ2IXvLDgus3qSUkYd2v3+2/UgJK890uqSAVTmPUeFcIdf8bc5HE3e2ky6tZ2Rdd4QTYwg8UsKLhRF51goi88+0SrhDLprr3OKfV/qyWCUApkQ+oEX9SLa3nddnH+c9IU5RW9dMGHvGqaKDjD1oJwHTgb5f9gOoBUuqyUtfCwrSf7wvSucPUvd7x4bIU0lepBVUEmKgE6DobQkHOba6T1hQ/VktrRW5MWtWMhDi1M+TmW+hnUnNoHToovFZ/DzhHndFTW879PuiAoMa7uX+7zQtkaKsCdGhDuSETjqPYewAyXYGB+rLAtbAGATIV5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:32 +0000
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
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 03/12] thermal/drivers/amlogic: remove redundant msg in amlogic_thermal_probe()
Date:   Tue, 13 Jun 2023 19:48:55 +0800
Message-Id: <20230613114904.15749-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4fc10397-1b26-4866-2411-08db6c04406c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsTNaLErwClZxp7hnNtEuQqo0u21Pvupfr6ht6dz8I/pk++7BpxhL6f3EjoLKfvp9gDTTjNZYz0eUVQnEwMs07Colo8NC7yQ+e2isFRK5PXMs03JJHboGwLa7pkbzF4yg6T+CVDAuWCak5peMh3eyKFwAMsTvEnXTlGL6XC/iNpO8IEdQfJtKkAnM7b1PetAb0+/VOIj71yNBkyNAlv9tuHmSH4W0jdFs+QsupR2rqDmEuHuJnxfqaO0Kv3fLzJCFYbh3OL9gZtJ+3V4I6sim17BbkOknphG5tt70Wyp1rHAKFyp3h4Js/LUUHfOdhVZYG6vHryQfCxszXkp/pL5hFtaBBfFB/3pGpUbibIXWbo5wm8kE5vtf/Dt7dGvGNmEjeEFxvKRFcbEKJK7sqJ1Lj05kNmyJuOZyT0TFMDSRJxuZxrPw5uW1KarHwMdKZ/Bj9MDUgXo9V1g7sz5CNuvSEau8fiRFk/XlFHC4yJ5e5UZrDbE3pqsycM2XR24QoS2VlQbBObcB46OJA0wpsS/PKGm0KGf1elLDzjczkggoPvnuyG8AJw0tGbWu14+dFsAI1iPYenA/WFy5/1VhAQe/XgEx4M696eUzr5OYJH2Be1Q9iWjvegfiHFrPkOYWpwyvef8FxBYmLLPqcIlEskuTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(54906003)(2906002)(4744005)(66946007)(8676002)(66556008)(5660300002)(6666004)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAWXg/+jFZLqoAz98OhEseeGKEyefpI1zt5dYTEDO6rHHeqtKimj9KYbp8Er?=
 =?us-ascii?Q?A15VngzTySx6MuPoRYhOGYJpHM0Lzw/QezSTDBfm3l8Ivl98mdDaDTl7S83D?=
 =?us-ascii?Q?zPIaQnr9iIUfPs98EsCmJxA6rDHvNBY9CshI8ctKJnQtwYDhYPzT40+12y5N?=
 =?us-ascii?Q?s5HX88zjHv+qXOKktBGmbVwC32rMQgxwF/U8PkKiSYxc+nUAz+QCY4SDDkdB?=
 =?us-ascii?Q?bEcfkhIn84KH9zTe46lf1jqiHp8gA+wTh0a5WcMWfi7T33Pbny4H7Ava7nUt?=
 =?us-ascii?Q?T1XjiUw+PF4eEn3qu78zN5FLxqFX+HyJ4BT43XqtEkKM3UyJBRns0E8ShzJ8?=
 =?us-ascii?Q?nWIfUup1/4vz5lsaUGAqnsiaFWKOdKAo6uGQ35bMVy5DJWeZKclpQEYlW+S5?=
 =?us-ascii?Q?wPM0AdjqyU0vrKNTlGHxR7NJKuKHACiYpQyEL8tUiYLIOdMK03LM6pWxExPx?=
 =?us-ascii?Q?a1k/1GC79H9u1+8qo8+hIx3+SMk9PvHPhFgUPyWrguIpJgaA4dNLzzU1PWsU?=
 =?us-ascii?Q?OfFIuj+Nq14C7vJMpoNQeFjFuiom8Fi+7OFGqaDdgXA1pd7+HT3UJPcBEsoM?=
 =?us-ascii?Q?WLng6nynTrLMgJGUR+2k26bFWVUS4ghdWQ+WrkELB5xIm1+oFqY3v3SWYfkM?=
 =?us-ascii?Q?J5ndAsBpDUlI9kjYCQtC1KBynwtdwaQ84oYFigMPJG6XUO9rM8MOZL0Rio00?=
 =?us-ascii?Q?+eCvxige7HcjhHVUg2uz7HB8A/u4sQgyQQkxOHngq8PtUdr5dheN/c1sdyPJ?=
 =?us-ascii?Q?UdrvARaixTS5PhDRc2NKIrgeteq77CDKduojVO0msHmSImLTVZ1gFtqLqxA/?=
 =?us-ascii?Q?PKKj0f+xUHVmtCo+0lRQxHFRFN48qpseboK4S/4AfUMtJPD/DpzUtBKVtWQf?=
 =?us-ascii?Q?te3Kkhxl5D6R/So4+qWemfaCVsqvTCuykt9vT+IC5vdhvyQ3pA8gW+5wa8ow?=
 =?us-ascii?Q?4bO+0Ls1dRDfoLJMz809ZEqHPnHcBEtATK7PcwhaW52rJx3iOaT0shjbfupW?=
 =?us-ascii?Q?YPPAOHoWh+1sR9iaRHaWGDWGHJZFnHgFj0YUYsyiXLX1aVKvybXqAiYa7wHF?=
 =?us-ascii?Q?Rs87KZdrQY3ngf7+XuGQCxxM0PtK0ZALVgU3OF2DrRH9fqH1gOcLT5i5F6PF?=
 =?us-ascii?Q?fCof5TeYShHGaK3kPROmhBQLZw2DPsBQL8F2miwzMmAFpoypMkSg54bF1FM+?=
 =?us-ascii?Q?+DEl4S2BewNHRaAcuy+dYlyDa0hRUA9dJVjhwhG+TTYzcj0AO56Yfg5DiCOj?=
 =?us-ascii?Q?UbUK0DjPKP0nDNT9921/i4geJZ2rbsBiyCkatEj2XmllA302MrMGEu5qoIs1?=
 =?us-ascii?Q?fzNrFuxGj+AigMTqQe/MxLUnKJWGKQL+PGFpILmXhhkZx72E8vfXopKuSCL6?=
 =?us-ascii?Q?Tv98LeOCGs4S6NYIA/vgD3XbiMB05Ls6bcsptRe3+qaDmNmNmHPMxGpZ8N4z?=
 =?us-ascii?Q?XPx9PTa19nEo3fFgOEH/Imv2wW1R86XN6dlWfkMx4d7QMONpJx1P4UJ+SoWX?=
 =?us-ascii?Q?NKX4hwv7wxiuawmDt0Z2oYLKvUr+DcLkfn84tXuYWUNTB62MD0fsBJeRKi9A?=
 =?us-ascii?Q?rvcmHj3rxHszAx4TcZDD/IIgKsuLEm7Qp49aT+76?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc10397-1b26-4866-2411-08db6c04406c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:32.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65nCCv6I8Fvvllhy980Weahlo/9iUmCCr5U0uIEocOq3DfYUgChga5F3fobE5pLxCecV1EpdCgceR05wp4PJMQ==
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/thermal/amlogic_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 3abc2dcef408..756b218880a7 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -282,8 +282,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd))
-		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
 	ret = amlogic_thermal_initialize(pdata);
 	if (ret)
-- 
2.39.0

