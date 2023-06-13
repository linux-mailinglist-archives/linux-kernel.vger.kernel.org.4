Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8451372E20D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbjFMLtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbjFMLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:49:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9973AE47;
        Tue, 13 Jun 2023 04:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYO2YZ5eDqpBrP01j4/8KBbOX+gujeE31q8EauhreKSX6Af6n44oSi82j/5E0F0w0EY5HK1I5paViWuUpnNIEHyUStE+gZSYaheNuqJ3QmYjIgZPXE3m7K0FahyF7yBHwFWOf+iioW4S+i6lLky3H1uFFsU8NCIXHtnw7hdmUDoTStbwksN11jxh+lJlGP0yYStlPLb0xOPYGLy6swhgirgSHDzi5QQTNSAyZvre0hlrsqjwqgO0td8gePrNSsn9DGfRQwQ8dGMJ1qR+LD6aFCwa2NFgLtSVW9003uAtGWmkJQ4ubC+GycoutnQn4+eKBWCG27nVuQbMX1L/oj7Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Ha1tRsob+jqsqACWErpPA/fxmNzTh+5HmmKy1c0Js=;
 b=c5l6z1CdEo0AcmYWE6M4teAQRZeu2YwFUj0Q4rNb01UntP63AUc2APz1JvkxlO9qtPhUl9A2w9ojjBYQxMoxC4aG0osVmiBm0mmIZMbBm3reSpB+5ChMFWWLQw/rWrMKmRKH6bDa2ADWoRKER0XSIduKqoKagAbzsnOCrxDoEYXs09NaWJuVLWzjosmiHDrbFpGWWSJ2yKv2y9LiG3EyyHf0MG5mD7xGuMrE6ADHcdM2DNIG/IARvp5koiwOwIfgJKlx1glAeiqvoSPXv1GZXh50zAl0JsyIUdEYjZRSGbHwIJLSYxoR31rsvdiVSy3SXN6Z7/UyzH1jABiZADtK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Ha1tRsob+jqsqACWErpPA/fxmNzTh+5HmmKy1c0Js=;
 b=MF4aC8inNl0SstiWkWNYdHFqJrX2ttIV6hP5pWGzAUv2umklkyC3aQ2Xl3fZxTDYDxKjSx851PPKW8F1MpjJIE+vMQsvX4GE67UH9ZCZAN6O7CLNzSXoYmdn+N8jp9aHW19mcN8WBRfm5F+dzDL3kg+tvdQFyWLICL4qya9ZOBN9NWjSIBusjdBbIeRrZIoSvt4JjMMOMQlUI3KfqOu0bYQioRWM/fBt+2Mni8ku9WrcFgfgFSQI/ftda+8YMuMl1bmJWTd6OyHm5xpaDvJgf4rvqZ8gZzuzCZnau6q1MJLIeqx0Ucb0fpv4I68Ehs/oFjw1EuR1Si7VhXNCDIee8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:26 +0000
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
Subject: [PATCH v3 02/12] thermal/drivers/sun8i: remove redundant msg in sun8i_ths_register()
Date:   Tue, 13 Jun 2023 19:48:54 +0800
Message-Id: <20230613114904.15749-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8eb1086-410a-498b-ef3d-08db6c043cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkR1ItsuUP+YkYSFQapZNA7J+pJvEu5Y5Kg56tdiC+KZaJuYUlGLqr99REJcdaP1E5N9ElRGvHtY/YbxYAISEfaYd+c8vmcSyQT79LhtUkO/mYzNt1t93gdI7r5RZAI/csX7pINBKL1x6nLw98SSWuaOHtnbPfc2RoLwCuPD2GHgLIhOUvSmHTEYQIMER3220slgIxlOaqMyJMtvnpLRxy358IlQvsHKr0thWn7Brm6WHzwqSgcbPongnwPbDX6ZtjVB5s2SbYjvObfNmvTVG9gWtK9xBzEiDQnrnFzO5A15co8RXmNneeeUY00GXmnQs9BWgBGOK46QX4VaJNgukyNkLC5ztRYwVgQ5A+T75gzGKcCmaFgl3JYZnUH96/n2UxGRtnuI2SNwcfcVz5wFe4zD50Xf57XcL2Eum8yyU/2rBmRBbv7Ck/VowNUQg/XR2IRTB0e8/tD9atDWHX0efHvrYu3YwAvKYSjY5lmV4cv+/75ABmSCfrPrL15AnJtqBb6coK5yAv/mTyF2qhC6vhV0PgE+pdR2Qcru6vpJdNn4DFEpwHjnf80C4Smx1Nfrh6GYLLhLHhQJUvHYQbL7f20qmD5yU0Ik9SnElbGM/K0v1Mz4+iK+id3M8MbY9pYOTmAWXIk4K7M7Oid6s5nGQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(4744005)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHkr5zT71uIqXBQe7JJh75CGYoY+yBCCyPYflfv0DYg1DiaM384b/+q6J2Sm?=
 =?us-ascii?Q?29zEKFUlkQEzyo2xZOSB2atYXez2n7iInsCp1bCm1FZy0Bj4tcjGpBopgm0L?=
 =?us-ascii?Q?W163Ehaub2cqxJRVy0XkduaT8m/FT799mUa8CJMBKiObytz/kAGAXogj5aQI?=
 =?us-ascii?Q?CipvviD8QG13op2QEnNXTfbW4MmkUC+kMLzZBoV0vKHq4sgT8opxJkndy1ZP?=
 =?us-ascii?Q?aNSFDOAQFow8huaQFdan4PCCPnqPHGK086p0DsGDlhlyBnaCx0rWoRnWkDK2?=
 =?us-ascii?Q?+T0F91zdYM3Fw1Zg/Rrx2zD9BNX7MgOBVan2TInOnrFjxIxIh7JHvRNtno8x?=
 =?us-ascii?Q?tZwFMkvBb7OASBHEIQk8fythG9RCSHjhkxW5akXaNMvR03kMmaGCnXMa5hPP?=
 =?us-ascii?Q?VuMGZ4wXNZwsbS+VCR+Oyqkn0yq78/rVmyeo6ChDVQOtE790KC2dMU6s4eV6?=
 =?us-ascii?Q?k1dwKQRGGmctqWGL+iCayRzP9pHISPqv+eI+4t3CaKWmsyz/MmMXR/T6RSx5?=
 =?us-ascii?Q?P4Z4AoAFrF2woDoj4IGl0vARsIU+0bhm/raI9lxVBAkDtMSanFHASaD2bOm2?=
 =?us-ascii?Q?Cgcry0zZBWJAb4SkGCPdJlC3VjX8ngRCZwwqMRgEunoTZqtWQpwLWZBp7YWe?=
 =?us-ascii?Q?2IPrwEt9Uy6jHT+XJaPNpvJX8GrK/2XEzvAjJKIfJdf5uAqg4toreCFoXZIj?=
 =?us-ascii?Q?ymJZirlzOe5SGfszkOJBLrPka06B9cih9DwfgnmaufIVKnH7PonX68is4R/4?=
 =?us-ascii?Q?6TeO6CUDuwt6YxdAzjZxaXSOVnShe7XCREFhqaSBbiiHNSvbyC5dpaf0ZJXC?=
 =?us-ascii?Q?P1U458dPURZ+9Y/lDjy/LvNTZyPpPL71N5yQzyd71u8FtABTkfPxcZLTZLdB?=
 =?us-ascii?Q?Y7KYRGJhzbiwLwhiboUFEqc1B0/rCqFsKPPscHd+j0Ix2AEReRFNQrY3lsMr?=
 =?us-ascii?Q?9Xi0EzgExtVjxv1jw/N5setXU9cEp8aMWd26Wsz1RHtMoSnUJsivRYaxa/H2?=
 =?us-ascii?Q?Ibo1et58HXXP6kzgqoKsUY0hEk4ukGLb927+WDvch42jMwb8tykOHNBsLhUv?=
 =?us-ascii?Q?FtAJU6vLiLfSG3lx83YS7ab6ZvtUcwsVI0IneKLDMHPtBgekGQ3BuOqK5AK/?=
 =?us-ascii?Q?S0DGU94KttNQy4TCDObmQqZ/O9qfhpsJYtaZVDIWB/PH7Asq32JKcdH0+Qzx?=
 =?us-ascii?Q?l8nFr4esVlV7JDd1kNxvy8nJ04NlGVB5gOwIAD/dFC6SeFaBp2DANiQljdaP?=
 =?us-ascii?Q?5lamKtwXaXbeC5JHpPbA1p4eo+GZ+ntXoCH7Cu2jII8dB4s6oF5ybDHvLcof?=
 =?us-ascii?Q?gJ0xzADJH9bwObUrK8WjqvMP8sOunpiPztn/WccxTmdL6N/BtFGL0TMbvsKe?=
 =?us-ascii?Q?llcIZ08ZxD8VRq0/qPXMrFYxfQVQ5lOe8suw4+GOG5MGM15/1XdvhKMBMKx0?=
 =?us-ascii?Q?NOfDHXU633uNa4TGACRBfQ7ziZQKJdcQqJ1Ypi56wBoebBb6Soq8k/8NRkTu?=
 =?us-ascii?Q?OhWjWzUTIcM7JhWEGE/sDAXA1edACiwjvRaPB7+4ZHgrR3Wggewfmato6e5E?=
 =?us-ascii?Q?VHnlCJ5QfxP4HlXKoUlHJahUQDQLnKe7QrlCaSoj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eb1086-410a-498b-ef3d-08db6c043cdf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:26.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWEkcsAX90gpO8bUkdlGo3U3qK9gPajhu/EsaSynciYw0vkRgQu2HzJQ7y9j0+4trh2YqyTxRq5jR8pDku71iA==
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
 drivers/thermal/sun8i_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..066f9fed9b86 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -475,9 +475,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-		if (devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd))
-			dev_warn(tmdev->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}
 
 	return 0;
-- 
2.39.0

