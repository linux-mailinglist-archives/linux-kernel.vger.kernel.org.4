Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A973671A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFTJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:11:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E560B9;
        Tue, 20 Jun 2023 02:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/IJEP3F7JSUj9WnS/d7cG8JC/f2kW9Q4cZLLDsCNFTuWQwssk/IyufVTS+66CXmehRVI/+0Ek+o+Lj1da3PENlfY0eszbcusAUdU2XA6NFTR1HogNxT50psbpfhdFnUoLQo1xPSRCN1ZrlvpPUPP89A420ABV9uboEsP+whcaU9MKUsIqrxmhbeMbTkxGVi763ZyGYBNinNf+uHiilflNnpVu+NLKIcUU6VG82dojAJ55lGUY8s2uoyATSf52S7Lhj75kmqCDeUeLi4uCnsgSHzUwygIDD18uqi941wE8cP75H3K2TV7H22wduSzlyci1HJ1y4W8iS7F14Q/VYxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg3RpZ8J48pTxAFiIbg/orgixVeXEximnLov/38xDZk=;
 b=Z+XgkBtWEM890DB3S+6CuGalnZ4OdypbVyUrjoXu9oAuksfrM+HZD4JUQZNgF4sGpqZyOACM+pDTBP12Mnhjn9PAkG+7xxnZgqd+QpMqV+GX+QDgSR8G+jmULle2xbYpyopoKCb93LKds/HlFX3nI3Dv6PClL9FXBTxqSJd+t6regWrm7gtWGRvJfdamOL0kPfUM2hM16CEwPEYkZRUyZm2EYMl16b+8bsKBAmrf664kqw2knbir4PNcnxs3KDqH5/s2uIntLLpXssVo7Lk2EdEGcPf+jnCgwKK6tnai3vDhWNYh5eYxEA5r+qrDUpMEYbAWSOeQjHDl3KfQyDzHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg3RpZ8J48pTxAFiIbg/orgixVeXEximnLov/38xDZk=;
 b=Nsm38KVp5DPvBxG36kD6/fSeBlfQzs+CbBKuahyU1TAtIjwfg9T04vKp5llWCqr0hX7OZ3HzNwMdlz3UeGeTCLTuFO8RNrD4MrZO2Z5lsOUe2v2D/tIiPg/DrYgD+Nq06z0eTA94WnLars7ZxXynM1ivuKYnntGjdtveBvIL6AMS9hQMi6diRK5Cykc+iN1ZajehoMBkuWC83nBW9FEeInkzR43mYb6EJ6UQuzJ1CTRARy3FuqF+1w/AmI6/I1NSIEm/ncTBCqsxoDwWYDeBE1x5UhPQjMbWJ6aeddx7mxpDWsOjSv1dFQv0EQRPvXt6D9uOaN3oLMTvYdIFZoEKUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:10:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:10:58 +0000
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
Subject: [PATCH v4 01/11] thermal/hwmon: Add error information printing for devm_thermal_add_hwmon_sysfs()
Date:   Tue, 20 Jun 2023 17:07:22 +0800
Message-Id: <20230620090732.50025-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 50865fcc-3e30-4cce-9e46-08db716e4290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcXeAwP9+tegG0ue6QCid28UoZgOHC48TZu2Xh067aSne9DO398lZdWajTOpfNZ3sHNbiQh6z/vL9EqJRX3xxsbf6jKUGlEim+Ac3YTW1a2vN+zU/GFViCol75MtkdxQTtlDc1yvcMPWx3QFg4y3GCzKtycuZmC1DFCin9XFetsPnsxMWrwgXk5a/KMW7SF35RcT0KllJhnANKoQ/7oNcBo+4HNgqkfWu4vLBtmiJp+RZYEG0LcnZYkm/mX8YZpnF26Af0Mw/akOW8BxEXYmGZm9wko+4fhqcj9u0UXHbRhm1byH6H4lxP+++eJJAcko5cnEA2jh5ES12L1ObLS+frhEN2d4xeA5bz/f7m+DIAEIeCJLv41wcbV2r7nvc6Vq3+eh/8KautdsD3sVi/kJlLqwe9pZWLXO51b35QnX1Uxpv0+PCXYgc3Nz8aDtQ04YsKOia8MiBWkvymySXD+4UmLhR/ZzdcZ+bRXaoK+2zKIdgvvPYl/PNCX/5YhTvCp6Hefs/GLJL+nuGRGfNKTo2BbaCyc2CwkKnmk2K5zk9aLz3fZjF0AqbsvdHF4Rfs+tkkUMfpZQ1YHUZUVyKecUme49nmZ0s0zuQkQSM9GePoODQtFzsrZjBdqxAp67MZcF1ypTZOKIyjgvfGEYPhSabw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b1Uj4/q4Nl53T/pKlgDOUhtxxf9GpXM4M/Ap+F4u5z4iN/Qmg0dui6NtW9ot?=
 =?us-ascii?Q?9DKv9TmzYw97O4I3RrZFID84bJFjIdYUWPzPeov48Zs8vkit1rah3ilEyI4x?=
 =?us-ascii?Q?1rL8cHVCqj9JmHa/JPHEGeoiwAU4UZDEkUSlzKdW+WYH+eVdC0FydbiU+P5Y?=
 =?us-ascii?Q?3cJU1xD/gA28VvQtjvCywY0U5nMNcQbTIVDArmrlSR4ZKigBNdDfp0x+9kbf?=
 =?us-ascii?Q?4/r4asvCsCSyZATsKEwXgDtvtN8g5fKFm5VQ8AYbCMOg1aTf/28c/OUqbbdp?=
 =?us-ascii?Q?dqayVHCWZ+OsAlHEvMMZzoHtrdFxKii0l+bdXOj/8dr0CQbdvOl+HoUOwTwP?=
 =?us-ascii?Q?JK+zLB/3FG8rWBWQZdsgwhC8opxug+cKc4WX2OovEbHYuFwAAs6Cg+L5mTzN?=
 =?us-ascii?Q?V1Pj2UnMtbesWIV5on1Wvk3PwClhJd8waCCNcsVojZce855MUi1JswX80xde?=
 =?us-ascii?Q?SZBpljm7K2j/FfDsUn+/UT/Qzhy4DI8TnwbLxpJ/LpBpWCROc8ZK6GlHfrPh?=
 =?us-ascii?Q?nRhSzIOBNHvlS15R/kpOWZ/ruin6L0M/dZ5ibkvV6X5t2vhQ5Wphlfe3S5Wv?=
 =?us-ascii?Q?umv31nieZKa61Lgx0ZFs7Su0DXpVFwaA0cyzWpgUYpyjuUVtXt25cUQSwUcg?=
 =?us-ascii?Q?bbkN/ecIa2IH98H7yMezVBkeqO8gjKpe6YVZ9mlnN+8yBhes9EQHtXLobMcl?=
 =?us-ascii?Q?jeUuQmoctAFVPInQGQobjJZCbF6S5xNEtfasw5utBlQQDYoFFeaZabGUFDKx?=
 =?us-ascii?Q?GSBRO7ZB1T6bwGMicxgDVsaf+9W/Sq1Tm/AXgNiJyFTExJvNS62Xir6qQKMB?=
 =?us-ascii?Q?+Hq/VUk+NsKZrABYjuEg8eZX3OgvGOmzBbloSF8xuUxz84EwkhKeAe5aLXqg?=
 =?us-ascii?Q?/5Wdglemz/O3PEaMBhKHRJJjG5TA0YFTm42L1g/OoA2XhYz3njA3Ijlcw2eC?=
 =?us-ascii?Q?TmYBkSNsystXBiL87vxwmq13gFl3umSSp5ZbvrysUbyWV8s+VaoefMspKLQ8?=
 =?us-ascii?Q?q0szdVDuM1SnAyGvmH0B17Z5JTZ8ggafDuZS4ofOkGlFmi9iFKL/xqctT3YT?=
 =?us-ascii?Q?b2Rz+9Fwjp1O0e5xx248f6m+0h55ma/QFcT6nM/ZE8lW6Or3cE86ZaAVSiHT?=
 =?us-ascii?Q?TH5amavCiYu2BOTc7I5Ro1unfepNbZpMB07fgh4zvR9iuBV8rGj5A7mSYrMz?=
 =?us-ascii?Q?E19l4rJ6IRwzLhI/I5U+Xz+3+m/EIfUAmVdXFPjBx6n2o/x94pEi04ygEJWN?=
 =?us-ascii?Q?LnZQ6vLEO98vpxCFM4zFUW2dk/njbBIgizg7B4OstDxbHFcn6L+Q8jVyVbl6?=
 =?us-ascii?Q?+EeXDyPJuxmonOLRx8qfTVjch8yLlL8v5UZlnhsFsYJTbPKj9R1fx8GOp0jL?=
 =?us-ascii?Q?26ZrPnr/BrJV3qs5SLd9wHnEDb8x4ojpmlvIv9gqOVV0yCY3AmwHBqZsLSeN?=
 =?us-ascii?Q?MIArwxDbpHYSzPgkGH9Fm8Vmp+x/8Pvww5M+2v6A8tIDuNe8ug3a4sh73IOi?=
 =?us-ascii?Q?sK18Pyavg3a14SJNk1n4CAeEWqyZHG0C9NEUvWQ0A2ElBtZrRuRmSM0Dy+AJ?=
 =?us-ascii?Q?HzOWCflL8sy8Pnz6oSueYuehxVk9Y3CRJpWZ1vR3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50865fcc-3e30-4cce-9e46-08db716e4290
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:10:58.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRdwlglLptAdbsf+fDelvnkU0ca1dC8qCsY8B9xFf8Fv7UTVcUcW8d2OMOP5+T4xsHmfYhgF0YsyOcCkzbKOTQ==
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

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-merge two generic-adc patch into one
v3:
-cleanup lvts_thermal
v2:
-convert to dev_warn
 drivers/thermal/thermal_hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index fbe55509e307..c3ae44659b81 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -271,11 +271,14 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_warn(dev, "Failed to allocate device resource data\n");
 		return -ENOMEM;
+	}
 
 	ret = thermal_add_hwmon_sysfs(tz);
 	if (ret) {
+		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 		devres_free(ptr);
 		return ret;
 	}
-- 
2.39.0

