Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4673E736754
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFTJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjFTJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:13:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A51BD5;
        Tue, 20 Jun 2023 02:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzpQfQsEj8dgDdha8n8pVCZLrTc5+8xceVZOYQrFmiSgBw4UKjTj4/gf9cN80uOe0ETgd73fqUod9mnmsc/jBYQP+JG6AZIBBVoKo8PMcxB6ttH0F80EG8RbOlE6mjiYPuLFg5dCl/gUCyWdhun2opyOuOgO+uA4a5dSkmRCJ6+5StLsvS6TGQGXkFAVJWHGm28hG3vLwHycousxT/xd/aDYqUjD3FOwXlSQRieXjwO5Km7hi7NhtBxXSAaiOHu9XG/3y4KDjbgXHYuVh8Mn2LHmkU5vrRbkUx6WkZKL2HRoNWWGBbZisLDGipeuBVCkWB87WF1VsVVgWUwHljJK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXpLXWtvW9vTwPmiDzSOE6tj7pUVzNz+N3YWTCmvrT4=;
 b=nxOHHFxgMHwB2vD7mer+vxlrSzWvX6Z1MA4reYSllfr9Xl3LKJiepF6MtE4C++poDWRukrs36o2S8JMgAARjeT7g2hSQ0Y3k/EohdiU+pK4eFEb1GSmrrlCXQdCbNUOPcVsJ+sbJ2iFsacfzcASlrOczP31VeLvqEslCU7wcOphwAz1Clu6nIjmWSLuAlMBi8SHTz9bPVbMNfhjfKhFkBeVnhhEqYweTZu/GOv2DOlDkzH84TX8FBhyGdNmnvXxO8uHBNI9pSwE1o+Vyo0iXCqQ0E5pqDFvW5r8kJCM3TClK6PEUBYN2p1Ioske7OcURxQrtmciuqKGd7qtFr4KOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXpLXWtvW9vTwPmiDzSOE6tj7pUVzNz+N3YWTCmvrT4=;
 b=WtTzoT6W6UGt++lbakmQsxDkBQ2bdFjqTwSpbQ5cX/51l0BwmbmdfQWkwWf6JK1HKQ26JgqkwlQgDla/UMz6/kGtIyt8E/uZHDqkhrM1gxLEFphD+pTtFcK41Cv4q5NRbwGR6MWmr9U8YZkTALtwe7g9SgE0QNwmaMOIBAvJ0WAU/FtEUo/QSMJpaf05DcOYe1RjJVwYfb/DO7fSSN6YJqVSa8OiW6CA/zP83DBjX3eCwYLoCIA0h7RQ1qHTe22qCJzKJ8Ju1ZRoCg1476MNupCkH/y9dYchie1cPzuFiKz8hU1S6dSPTZWIvkNvCb+XeVTMZzpO6DUeJI3v6BTQPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:44 +0000
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
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 09/11] thermal/drivers/qcom: remove redundant msg
Date:   Tue, 20 Jun 2023 17:07:30 +0800
Message-Id: <20230620090732.50025-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39d1127a-5260-4624-50c6-08db716e5e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyII6nlp1G6xAUeIocVFSaoUpcARE0m6OlkRUBj5qfY53bMeyNAHToKIJrH/PYvEBaXIGrFp0ANHtWamMQs9R+VnKBxXD60OGWK2UKxQTMKyN1gYtbmI4iNhRvNf92587AiYOgEnInahixpwoalXAvOU6xBs1WXwTLcngDF5YMqTWzETPrVC9MkfNu7JZnT5AGwy/rFVz/PdEqoz4P35zrplYo+t9VRpHIQCHcTpTROLR1sFH4TaWCuYIp/0UN8AmvhbLZ++Dubj/3E636PQTAVtyWSal3viLk3eFptE3T9HYxOmi7dam7JgBnBHw/ocvp0wrFfAKik0FsgEQbnv2kfzIa8v2WdeCSfPpFpGAx7W8cronrPvt5zB+75BsY8uXlzV+tuU9V6tLqi4GDhbx2ovin3QBjAPpez+LEIxC/D/+b6+9LpuLCcwGMuEfRmPs+mP9L9o8AU+ALUIchBWA8lkSGLiNu4ocIBr1cMNvRpIexYGl7f/HRZeTzr8XN35bpwd9C4j8WWcIJXo5tyAZPUMkO5Xvn1yRJfOhcJ3SQzqs3aFxi5O1lOhCoAD6KggrOJ6WJlp/hJU6rD43wijqSIKGp2j50ZxeuTEnZeJUqX93drUKfMT6VVt7s6Sw03NGI4acY3I28hDCeVpgoCT8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(54906003)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ho5RMXPQpu7SQVlzSjqEy6xjzIdvHERdM4l0vrjGoyZ2fzIpXC6AxfURarg?=
 =?us-ascii?Q?QcRKeoS2tXmiDdbBCWKhCrURI40I6dvIcM91uI8ShilCtjoV76pRz1sCdCb6?=
 =?us-ascii?Q?DjOanv4seWPvACn8ee2f0xm3GZumOrPRW1ta0fS+YroZyoFBQT8PekM51U5X?=
 =?us-ascii?Q?+fAHt1Nh8IvKgyEkh2G/0K4rpS00myPIGelfwZd0U+cPkcArP7l8Sx+iGnT7?=
 =?us-ascii?Q?XQ1kdneAsdhPpuHmFDbgEbGDTtW/lies+2dPtmfp8PAr0pqZjRifzqDtkSsI?=
 =?us-ascii?Q?byE7YJvow00D27z9Cb1+3GZCd2mwIt4LB9JELGeWvnVtashGFanfuV+MXO8e?=
 =?us-ascii?Q?infb6Ic+nnbeH+rWNJOspMmmfjKRJFPqr6BkLXGg2Vz9OzvD1iID24LKDiDg?=
 =?us-ascii?Q?NVLIi/b6ICu0Bw5Q5AqLI4lGFt5+WWrf/oQoAh0Te/Twzf0tUuHGsaU3apH7?=
 =?us-ascii?Q?ROI+3jp049eBxZOebPcwBnTe2hx263er0JVsVd8to9uG7wDAiYvWsJfljmHj?=
 =?us-ascii?Q?crr6Vae57k02JuuUvD3WiisUw40qxNMSy5xbwbFFFkpE7JNCVteYz0+k8cin?=
 =?us-ascii?Q?GqpoDIc0Y1bOJ+yFoJzCFPSIycgeLR/LXtwG5ZCH2D3YXHATC1TxVSyqRTT/?=
 =?us-ascii?Q?SrPWlu5BErBFs9c7FJeYydHL4kj50l0WkJvQYUh9fAEeEqKf5nfL4SUPJPFd?=
 =?us-ascii?Q?G3a09v6fvoP2kkckduiz+zZhLpFJzkZjnuBDuw9DAN6BPG4wnJ+/CzGKlSOF?=
 =?us-ascii?Q?4BdinaqMeS+MVpxYyimlKejbDZCtH4pdiWwZ93zfDr4qsJPvs36JMsA77u53?=
 =?us-ascii?Q?DDQeSYAGBdMNsad/iXfiy4YfSdA26OKXQ7vhDYCPxmtFJBYfIf9PSCYl699w?=
 =?us-ascii?Q?M3NJ0hHkStk8VDibtXq5mOSTFHUl6ZrIAi5HgjFQaHCyfDYPODc/VEDX7LqA?=
 =?us-ascii?Q?/ZefJiXpxTZTQgkXBimP2KTSusUvwp6zLReQ1cEsI3EVQP1+kpAe6TByZCCE?=
 =?us-ascii?Q?GBy7eRq9c1v+NiUdZc62uGLXKhcTCwXOlqUhWLhsvVDXsFxJ5lF7bpVmZsUZ?=
 =?us-ascii?Q?RnUICS/2uYZ+087MaQzrYCn8s1wf9QOB+D8BTIU97Oa8ny5wRP1LPPGtgoyw?=
 =?us-ascii?Q?5JnLwd/qEqw2L5bKdsv0AodOQIXQeqPCrJDkNVg6ZAb+7QvhXcSSC5xR0lcn?=
 =?us-ascii?Q?DO65eqv4QkJpYWCr3NyBwZvk9KUE7vk5zcjgU69bdQb/3VlpaxRVrQXB8RFQ?=
 =?us-ascii?Q?yq7GCkIzdg7v7HXz4+WuVsP4ebylwzmKVAYpfmszQsII1e2/4lEpioaPXF9f?=
 =?us-ascii?Q?u8+41SmZexLrtsCBNIOzcoKGI4F3YM5r8JcjQchVf/vvrAjjIpD3KaHjLct5?=
 =?us-ascii?Q?nGl7VQYHWOENevaqE0X69aF/52VnuH7PtPG1DpNyDSDClmEF/sL3U5h02MQ0?=
 =?us-ascii?Q?Ngmeo09aqMyg2moaBfPnkgCWVQO7mSpfgtG8d2C2Ygo5DDMs0u33pBomlOw0?=
 =?us-ascii?Q?273S3V9YFrZsaJ8NBanOKqjNxTcLN1smpv7/zWNKFRVp/5nt1XqFblOnGSQz?=
 =?us-ascii?Q?nLRpahAKirZat41z2hs/K/a8W+uHJ/1lNjFoczkK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d1127a-5260-4624-50c6-08db716e5e38
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:44.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBTpJOU4eMs52orVxpw4mEZ2LZvssML6EN609X+EdxXB7BKOEOaQNoATDhkxVtky99UsUZhY38FJe9OatofiBA==
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

