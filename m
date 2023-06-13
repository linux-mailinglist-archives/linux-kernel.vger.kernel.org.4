Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46B72E22D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbjFMLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbjFMLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:50:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8F1715;
        Tue, 13 Jun 2023 04:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtUixy/+hqug/2xgUuSkd54X5k95FYwQCOqfN9y1fnnI0l3FRTMSEBVpV7COUr1rj9iOH2rbZDpWfbc8IwFGHXqgmE3w5nb4wSl4gsiK0wsocd359dEHlLVe1pgx94zOjWLU7GuLbTWfF+zBk0ff6PjVI6ChhQxQF1n+ZokYYvOlYo9h4FEu5VQ1i+qvQUGqMcYcDkZk/t780cqw+wQlDUHKh1ZiCRtfGQq2ttV9JSKMuleQQzPsrva4sMpEZ1V50+mZMmvpxopY4QnxuJE/Ai+l8PGxJiuiCZUAMXwsEJ7YvhM9svexfyyBdjttXl5Vc1aeGzN5P7OB31IVdBhN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXpLXWtvW9vTwPmiDzSOE6tj7pUVzNz+N3YWTCmvrT4=;
 b=ktHTCxqyF05U/V5SMx9krnVM7l1aeOu+++CspH4QZVPq8+GLyji5hWtvOL/Ufy/y605a8Gz76AQuwzEj06Hng/6LlLX66Mki0O1j/UTWqvXElj94ieyvkNy09yOyMR2uR9JKqqTEvUJnvQ21SEtrWCpcQECqVV2Nw2Gun00OoNPpVIVvXXnB812fQYXyHVFTlS0ud5D5o5oUynhpgCODAPTkJR4NDjwAJrZKGU8fGYMyibQHylGScOOicj0PJNaFLJMdEK/eWdY2pij/+MiIxVI1QVIwJRv7H83Pmd2vCCPvcN3ai2YelAarGz+sBsrmsHuSmeG99yBhndi1/UUP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXpLXWtvW9vTwPmiDzSOE6tj7pUVzNz+N3YWTCmvrT4=;
 b=gHWdoNJdSR9pmuYkyp2UTSeriSUDdyFIxdx7Rg8hEV4mxlfNM+XvONroV2wBkYH1QTsbMCkips9AsLgZTEvWYXDhcC9PsMqqKTOt02B+JVpX3FoO3Vl4z4Dai55/Te/hvyq3a4BV4mC5onVZLm3oQC+80y6HJ811kyQW7OqMPV2VpNdCXdB5UIma7FplrTHA7AnWdLRXWCnmB0oCCMnuS0DxZzV7anuZT7C0/fxPWJ3TiuOfklDdLoEIniJtD95csovNgNTHB0HnvUsnVfZ5tbSTss0zVu0GHDlA4bi06g3mmFMb7aQ/90ThLHubclfRt2dHPFUosRvDPwqYYL1PKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:50:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:50:06 +0000
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 09/12] thermal/drivers/qcom: remove redundant msg
Date:   Tue, 13 Jun 2023 19:49:01 +0800
Message-Id: <20230613114904.15749-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a64cf92-937c-45c4-1575-08db6c0454bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bm5krWAenwm7Z/AcACZVgzW9dpqPzt9TPAB8TPacmvIiAIUUfDDyq0CaekRjMI5Qzi+yG+kOCbR+e3+kyuU1XntvVDDGUWrfQfLfSgBUDyftHUMdr3v1kIMZQVCNbIJaRA5F4TNV4KHKTniMIq5YCkoWdW9XtTWr/RT+h7bXeyRg0u00V93Sx5Kbre4oJrmdTAp1yYINaMbIoGgzTPnzRE/s+6L6m2FrL11CIL/TLg74glIP/HwfguRB3No4PEK+hvK0Z1f1LiTPYk5itfz5bYrK3kyIB3BDLgH4nZqFF6CahVj1RgqSaerViJOBd4fzNwafMOras9vBJTNgnMqczUt3E2UMWe2WJrqpB/h+V4s9+1nRu+uK/bwCeP92+ag+AwtaSQ8VVYxnfllh2p7Ofi8XNSBRA1yl5ItrcmwheB2evTTEms50nyU0XbXYD2f3DtZedKpna2Fw8JYzSlooc+RsBsKOlb+7tR0wrspCju5wxeyIbAQ+ckGaJEcF1MPJBPsfGzHp6G5HLlG8tkeQk1T0ciuLE+YeNWUFyRirhK7Xrdgzro+YPBrhRNQKgX5riENAbgW60AS3jxRNsXDX80DDdRDrTze8gBKn7sGKm25b3ESPUQkXWZ0T2OMjmXug2ELbGmY29i1vqlubGWPy7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(54906003)(2906002)(66946007)(8676002)(66556008)(5660300002)(6666004)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?60N/+PUYUUIJRr4RiezwnmZ74jtxmMWI5e8tSZ75WPnBtx406y0uf4jZGpQU?=
 =?us-ascii?Q?efB43GP/E9xoqO2sMiS13JjzX8FLTyQnOl+7Kn0WDpBL+I3KBgCZWwJEmmCl?=
 =?us-ascii?Q?awYt6fhp1n1ZkhNzwXIWiBU8WrG2Xk5BYWSXYnlGlNqS+84DKztxWgJ0epYa?=
 =?us-ascii?Q?FO4A89QwfG5JtEwkKlL0FAPEAv3SCRDd0zZh8Slx/YkcLVyzk+Wq1MmoWXgA?=
 =?us-ascii?Q?wdcQNJLTzu/gJBSj+wwm2RBYhTvvOtvAXmlGf65ByvBWkAdBZgrXlrkA1km6?=
 =?us-ascii?Q?ZIbVn3N/bgjl6xWmqJz9oJ1gNBgm6EBaF34oj/7nMgEHQlqPWJZLojmbaBlD?=
 =?us-ascii?Q?joV8DssczMaYa7AunptFlLSl8KhtiUHPD5IOmpKPcwfUxt501lb9xh72EVJI?=
 =?us-ascii?Q?JiBI1HRj5MbNdgIRi5M7p3BmdUQ0h2LMi+Xqe7UaQFgcUYcvoNSbh7uBbuqZ?=
 =?us-ascii?Q?DnGCGtKejaSvEuFUXtMWLCMLwqpgg1eTa7FPtFL+Q95ian2+255+T5yiFpGC?=
 =?us-ascii?Q?wBysGRY/Yyw6+T14peOxuOXiYENtBq1hdTIgphu35uKrjHzIj1t4XGbo0iTJ?=
 =?us-ascii?Q?NoHZP6qC305alT1jAL6Eol7BVFVP0raEC9NjOnPj95s+/0I/zKh2mEBhbTbM?=
 =?us-ascii?Q?pkV3ef1qezaaKZ+0jmlxSbdKJoul0wXBL5U+MLnm84WLWRSYZtMT5L5ZoxLD?=
 =?us-ascii?Q?QHfLLUNmgHWATBcdhoJrmHPvqvYr9NKA2uKAwS5WuqxZ0YTiX7WqAkKc610O?=
 =?us-ascii?Q?RXJYuQ8Z0snWi6gjcdndXe6HQlhay+XSuJDrP7jnHUy+xQLxMlibiYQqsro9?=
 =?us-ascii?Q?+lvz+HfhqC2i8g6/Sb8q08Z7eMMyjI33UFOZSYHmJwVCulvEpfkndTB47Bzk?=
 =?us-ascii?Q?GT5Ng1QgFGSJqK/CTAdHU2nd8vUlfC5++1QwL4wyVxaxwe5ruwlcSFCv1l+a?=
 =?us-ascii?Q?pmSmqW512pIkjcMDnA8hKEUj3F1eSHNdKrjSIWeTwFDxMUZETRoa1EDO31v2?=
 =?us-ascii?Q?WiydTQWdbPPIVqndCizVDbERt8KDMVRnMgJ7+MxDelsRhfN7CAf8jkZ5Sjtb?=
 =?us-ascii?Q?Wxc1mXyuZquo3veaMH/XF4rOEWc4G7Jf+QBx2CwAB9FbTGefaMAfyqeMpBYi?=
 =?us-ascii?Q?WJIifTjAuwRrBsJ1+sEZha+3TBQafeCoCfp41vfsOBXi5boJtloS5N5adt5B?=
 =?us-ascii?Q?G2sn9NyGHchGkrG52hAIOlCOZVxkCL5R11YB1z1RwwKMLoW4VwYfEswvAY2c?=
 =?us-ascii?Q?WEZfZ5AKmz23TeYg5zIisb5NrTDbeMtAX1njW+2WoYzztPTnCm1Vxr0Zcid2?=
 =?us-ascii?Q?6vEDW5DlGbEP3+OCRa7iA1N0GlSUssJuS+lMFskUNL7jbtq3Jrh0j2AAHUHa?=
 =?us-ascii?Q?G/48AkryFrX4Po8R/dBD1Th58Pagl7Isk2PV2VMayXaJTmEg2qlZ0lYTsR36?=
 =?us-ascii?Q?/DV1+uqFbqn3rlGZ1PbLcOWR1HmGzj9pOz6BtBHgn1xuBDqGj1jy3i8D56ZY?=
 =?us-ascii?Q?S6URVAjd4VrHJ1l9qRF552FZwSGPHDT5HhWLCCe2temVMPUjoBDt9xOZSJXp?=
 =?us-ascii?Q?7MWp8I4Y03qEUbXTy6u4iXcMlfmj7nJBuakwF0r7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a64cf92-937c-45c4-1575-08db6c0454bb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:50:06.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwTfLHWS4FNp8gIgFonX0ZB2YgIYJ1YfBDiZZH5Y87KmANelJbzdO55jYg5xxU8jndRaxpDb5tgjRFm/rz0Ulg==
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 4 +---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 +---
 drivers/thermal/qcom/tsens.c                | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 5749149ae2e4..5ddc39b2be32 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -689,9 +689,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
-		if (devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd))
-			dev_warn(adc_tm->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd);
 	}
 
 	return 0;
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 0f88e98428ac..2a3b3e21260f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -459,9 +459,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev))
-		dev_warn(&pdev->dev,
-			 "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
 					IRQF_ONESHOT, node->name, chip);
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d3218127e617..f99b0539468b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1189,9 +1189,7 @@ static int tsens_register(struct tsens_priv *priv)
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
 
-		if (devm_thermal_add_hwmon_sysfs(priv->dev, tzd))
-			dev_warn(priv->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(priv->dev, tzd);
 	}
 
 	/* VER_0 require to set MIN and MAX THRESH
-- 
2.39.0

