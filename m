Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288BF73674C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFTJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjFTJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:12:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0F1734;
        Tue, 20 Jun 2023 02:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEhoOE3eRGFuo7XjK4/TJvPvWrJhGZJdowwpCdJ4jTQVyUTlPEqUB/O5RekzrKniTAqEgXxBIVSFPDtpywUBeDE+pxoX9WVDeOK/T9omZZzImsLdvoZ/9PHibT7IZRqUWbQk58xD0TGCyTfElvztwL7Tne+B0YuwslwediQyBFFKsHVH+xm/b3YEgQd4DZYRk9KCFEZEFGG4AdsYd6LoGk8xJRlGSkzSGaFPvkaZXxggMXWBJMeU46anEQ7Bh0qNLlUb/CmveCBVdRDME6IS+NcyQPNep633vzBr5N+5+vIUfMzQbCNTIpYNPqumazMeqE/JP6672MhwC0xsMQTIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8P2XwfIBCwYW5oDJeTe7o+u3tMLpF9fm2q5Jlq/Juc=;
 b=DmCBLFLfJb0nSX0sWeRh2pQhmufdy2LneXnbGqGJ1bVA3OiTgCH7uWS6wsC1A+tiZPcmQLtOhrnCj786Qxjp8fo7IdR1eWYRweuB30TUFsDr7toUM4FKBKesZLfGD137oN764+ClLzRoh7wPs7FvbmLQU4bmozRtNvehW00IP7EN6rT0d9fjT/HpxOJJ1i2mCjLwT6n5tLRDgz/Yfrdl6Xl0Enx64PT7GwkzRE6J3GSpEAfXqKybynUB48HoGGTjrDRsUy+WXQwaaWXO+srQHKgWLtbQnaTLq3KTPNgqKJfMUJRnmETYY3M0VRAgCV3fQu5uoR4KJfM72WMuEIFU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8P2XwfIBCwYW5oDJeTe7o+u3tMLpF9fm2q5Jlq/Juc=;
 b=dspIXavCscir5rKpulLuRvlHr4QrtV7vk4rOMsa1sJx3JKcP/mzNKgH7XpIssvdN2iKyer4IQkW/JN5aDKPIx42q9XjmqZDuG2ugatzdmVm+Xjfe8Sv0vujXsqmrL6XPCbiFHomPjlbm8cz/4dXrew4reSZ9LiLk0BSumZ6JQ57xyLJv8WIb4SLAhlcrm9jcaXV/wxUWa9YzZy7htUbs9Twdz90n9xWOMLOCp3D3igU8Z8UbFUyHbg5XJKR001WCO1Yl9eQ84+w8C5MPaYcJt3+Xe4k0vF7y99jrh1l3ia8k6m6niUGy+ofvzLIGNYcSjBQxxq1nK9O4R7g7CboEZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:38 +0000
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
Subject: [PATCH v4 08/11] thermal/drivers/ti-soc: remove redundant msg in ti_thermal_expose_sensor()
Date:   Tue, 20 Jun 2023 17:07:29 +0800
Message-Id: <20230620090732.50025-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d81ca5a0-13ef-443b-7c04-08db716e5acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vX0gNGrUe2chJkUGLvPFkimX3UCjdf5CGCDf1nEE16xASYwf1WZPQFm5LbLu8Bton+SlQTnsRZ4qbwZy8BGWi+OpK3c1QN0o+2GvvxL586yE27gB7VNacZ4B4h6lb2Na285LW4RJMtpeKXyrP2o4XvQ8Qw9ablw5haajvnYRfqfqvCWp+ANS/lnS5sS76UV2c4Wdzv3volcZlSFx8Q3UZ+d4+InpSz3feZezoQRawAYQOdRkiRphDiCjR2x7Xh+jLFQQoww/MMA1TbCs0Y8FtNzR/XqJsjEMXiEs1xJD/MTYnFX5/qgvb3HknvXSVZ9vEsQgWWWDy+1WfCQ+/Vkw4BG63nrZzf5Lbct7+BzLijAFr7c4FFyNlQAdrhmAeL92Pg+Vqo+BppBtqSvuGiJhbiJhAWHYQB8Im9kGhikjtuBM8uc0/uDRWRYjyhHlnWkzMpqF6FNysrTd6Dl5la1kpCVcnO7+Rs+qjUf5KeBNyAq4EBBAPAc7YfdNpQsESGaUjg03jvTyppDo9CG+faw5UTo7X+EI7p6q+YjC4TijQuOBVfCp6HnGDtwNSV1UYtBh9ARowp2cWB4LeM2Q8zd+1t18k+tFifkxCiE8h47MU7Kc2IGRZs9SGgm8XpDA9eH7KqmuGBuzl3+FlyLUfLIe8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(4744005)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f27YyfIiUZNjU9horpizTkkgLWSx1bGrbpOO/K7U3Vt6AtEs/GhaaZNqmw7o?=
 =?us-ascii?Q?8Yh4HEbap0kTUOm2xd2a+v/HRG33fBQ4a+Oez4OUipZJ3Vs0S4UNsQTZORey?=
 =?us-ascii?Q?b61ZBXUI6ijSNonIrt6tMSt7aIePX5JZZWho6fntmiUvUsShoO+sVN5QS8Ej?=
 =?us-ascii?Q?Jhb5CE2y4cKYVMI5zguub5y9NsMBgbm7ia+Vf7JxAFJNrqNnI3saeBabfNa9?=
 =?us-ascii?Q?W2vrvdLGhj1v7Z9YA6ynxq9cwpB/w7MhnO0GhZkym4M0twaNwQzTsL+0GEFC?=
 =?us-ascii?Q?zd0sk+2nlJ62Db8KDeZmVRnUBXCQgK12dHG4FM7EC4lfu7gIfayEKYNu8jRP?=
 =?us-ascii?Q?fGXin+dduwxADVpgfXqQJzPcCY36KWPf57Fa8Cuwt8n0RrjWEf01Pu6+zlC5?=
 =?us-ascii?Q?T55BsAPtHJ+DogoN5nmlFa1zt2QfMiJr0Qpc641YJ0b/n2tdNVMfDmE3bCEY?=
 =?us-ascii?Q?wiNRy9zeeiN079hz5NYNJiKNPP+Co+0l19RbWn3P+dnnGe3gQS68gjP8wj+T?=
 =?us-ascii?Q?sJIkGHngvpNqyyXBkaY+bUHpN+AD/HZKilH3/6dS162jZ6c/uCEO2QpL60ag?=
 =?us-ascii?Q?1DLFp1RRndcnMR/eM/UrSvbO6f8HzJj/FpP+9xR/BR/Alfq4HBD7OlX1gZ9F?=
 =?us-ascii?Q?wGTRQSssAbBPEb9OmxONnbt2FQKVpLcEXi4KFfLEhgvLDbZb51BL6bAHJRVa?=
 =?us-ascii?Q?M+j+PyVLNYk7w17m1uOVgQBUhwJoi092/gBMECARTFJxybZYsCwYDxMDzF6W?=
 =?us-ascii?Q?iZ8HS7hkFnqXu+QAWV7EzrlQ5JsKwLDtc26InkTLF6FeTFb6st3Xul9sA3uj?=
 =?us-ascii?Q?QS2FUOyIU3iPKKZnbbWPR7SwMF3rFPQ7z/48+6ed3FpQPph8NULhdEJ/mYhK?=
 =?us-ascii?Q?R+jRjL92R6tw1uv6p17i5OD3ZlE8O4hJd1CkUdUwVbPsml0fQJSmPkPZyzmC?=
 =?us-ascii?Q?ls3GbZq0LZDMZNDk6od5WKJV9fVzgTYg8DnxCrUsN9wgpdHK5GX2jJouaJH+?=
 =?us-ascii?Q?ASzZCyamFZaOxY5OPDGPQlw7IXES4zXoEnxICth++Id/nmjPsT1ODWUgXdfv?=
 =?us-ascii?Q?VKgZxipYUijDkbifapxPBwlLUgDT7Rb7Bamvof9KtvfaqBxiIV6dsJv5PSa8?=
 =?us-ascii?Q?D8MlkCJirqJlPXHYz1c6e/gMBpQwTLYXF2hgOJUw4NajcbGfthockpy6MASU?=
 =?us-ascii?Q?kF1C/L9FPaU3Bw5mElbXJisd+F4hkupZePkLLMRcUmjNR/EbHze49s0vj3Ae?=
 =?us-ascii?Q?7T1EYRyDDUiw40nyGVXrCUAMbYZvMX75YHU4px4C2t66TdAesmz2j14Bnybr?=
 =?us-ascii?Q?KWb46QZV0oGN+rZ2e1X/8nmPnR4nRY0RdrKetHYIJUm2TDRoPKtFQ0tj1wh8?=
 =?us-ascii?Q?yRuDachZS64ocDT+4hwx2TICm8RprAkvZXqXDYWM1BlV+9R5gQh6xTv2JxVV?=
 =?us-ascii?Q?3XneJNZaAOT/mNdLMWUS3JXibYJliicxlRKyMhRGfmNQwvHsOvfqTy1ns4/A?=
 =?us-ascii?Q?HOFqXYpNil3GIM3iwCsQ9copq0PBeLnnpPIwmO/3bqcfE5UwiH5j5TgZebL0?=
 =?us-ascii?Q?vNkglK42GG3sUx8vWAddJjF0yJvHfymoV0sCFXOo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81ca5a0-13ef-443b-7c04-08db716e5acd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:38.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQJQZjVCOupjL1DrkENHpeNQiNCtKc8KcIrGQxewQNWxQ1NAvlds7TwFgQ17M9JZGVAi0OmvOGb2aZIq3tV3tQ==
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
Acked-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 6a5335931f4d..d414a4b7a94a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -182,8 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					 TI_BANDGAP_UPDATE_INTERVAL_MS);
 
-	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
-		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal);
 
 	return 0;
 }
-- 
2.39.0

