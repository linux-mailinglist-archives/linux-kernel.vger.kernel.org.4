Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308272E19C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbjFML1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbjFML0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:26:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351B1BD8;
        Tue, 13 Jun 2023 04:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHCqJ4BMPwpLjfp1zVZC0z0uA2G4qoMPyjibKN/cqh2PBK/hle+TrkYX1x7+YTrdUH6tah/8dWxbwny0GzI+O2h8TDfamw7ograpAVhkiRrjNWK30x4b2tb+/GsH+AMN8aBVaS5PNft+IuBPuJ+xtyeSS3hOQqKGOvbxRLzrWl3uNul9GutN/XldB0HTAZXk6kh8lR0TbvzASdRe62iuoNjjIeWn5yDH1f/5Ob2ZEXvhm5cAfxjwe3dXR8F2TjBW2lqglauQbGyHNNXbO/5Av3ZBICg2/qDtruvQM8lvI6dqgB79JwfrcPAW9itaVyQUoqVyyslY5ECVtmokuLz+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXpLXWtvW9vTwPmiDzSOE6tj7pUVzNz+N3YWTCmvrT4=;
 b=mE93nXoeLLdPmbF4JhzjgZKRCn9qBiLTVrdE9lqavHFcZNjoM9SSkoCoN3XccFtb0ZYIXhOW+JxbgDcUznZ8gJcnnpLsYzvnUusQ1ELMwTL62oMxeVZVHrVns3vwxuPvAhH/0h2HDYuSV8q2VUf5AwmQ+IPw4c9MwyirIgg9KpCtVPWqHAHF2nCtzE1aO65dgq48UXJTkcdXNae1cuNheXG0faP8FACPBzrf5Gu40sbC2RECnTAOGSGrXnPqudn/Xc5jRaRBkF/T6aDwqeDCOaX7rl3LVAoHGuflbG3I28KVdrhNoRmjlWlk2Hmop6J10gspe2SNDiJt/ZrRfQEL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXpLXWtvW9vTwPmiDzSOE6tj7pUVzNz+N3YWTCmvrT4=;
 b=MPJ5lUQMpUPpp7SRqH03E1QrxE3RDRMJlsV/lBtgcps0W3XCXNa4PxOz2Ape8N4XnahB+RAM8oLgS6E1QUU2RQNN1ME4khkKZ2Mwmu7zHqY6VRD62SspCfOPebG1KY0V0BC6Sn9MCZQMfPeRMtG0Xy70yYWSCH6Yl/orJddj1yanzNszIpfDztdxUcA7GPFoM5gT4EtaDz+4Zamhc9rkOngx2LrLoGYgbbOejStH+iES8HFQ0GJpY/p4XWFsAB36CxPmLQuiccyDg5mC6KIxOefJVn4jsUIQ83TJnoPpbvulLnoI+yYHTT/++yuG9J3Kp2xKoyNAh+zK0T/PhVVy6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 11:26:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:26:18 +0000
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
        f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 09/11] thermal/drivers/qcom: remove redundant msg
Date:   Tue, 13 Jun 2023 19:24:42 +0800
Message-Id: <20230613112444.48042-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613112444.48042-1-frank.li@vivo.com>
References: <20230613112444.48042-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e145b-8985-4275-ee40-08db6c0101ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2/X9q/wN6SmejZzAQOSbz5c+mKQqBoQS6OUO2QcnmAw+N7HUjj+LyjRC647frKYgn49JI/l7WoUFOOLD+jPE7ukaAt5pyUQMOwAFGsqSHfWe4g7Mbpf+loO2b00MtVMp+kmyzCnQ2x2/HjUfcEnkFVupr6yA6scusq3fjAg/OTAdh8VaOS9gtIKuSQXT9CgZhOk/EcWDpAa8OUPsvm2a68rWDZD8vzZBmGyjJEojx0rb6MQ+8BuoHgT2LNPe7cQrGm6Xgepua0aS7qlm8OXll1c5FK0VD20kFC3X7jaYm+QUpyLVVc6rq+xWtVhPE3FOD0yRqral/w8Pw4DL/h32/w5SWDLBVEol8WDKnPGZ5eY9tq1uR4rpSipqRy5VRoeYcH9Qso6b21vx9myHNQ0TKm+wNaGSF8LDt/JqzmI+RUJY0IYTNrO+05EfSsHK3FEJvxDZOLl3y2Bid2yEWR5OB9xZS4FggnfOzKB1VXuxEvXh17ImOy0m13MFRtDxqxOo1LLvpnIHIZoGOS32qYEOES9pl7to10OaCA1PyAD67OY/SvtHLHU+HgzSYCQy6/LSAblxOt6HK/Z+9hyPhf2P5mrOU2eZtuoVgMPLqsTbm73hiGuSM+jZE8S1pTwUSn3iUg3uURQlPa7ZO4KoKtzbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(921005)(6666004)(6486002)(38350700002)(38100700002)(52116002)(83380400001)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(36756003)(478600001)(316002)(41300700001)(66556008)(66946007)(66476007)(4326008)(7406005)(7416002)(86362001)(2906002)(8676002)(5660300002)(54906003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3GQrhAU7kF6/0B8K/nVqpFnOp8zw4QrIli3Oz9rczINgUbSIQ/6inKc7a9lC?=
 =?us-ascii?Q?hh+flv3hLPRVvc5jXHCuOoNS1/AvLf+ypGlpu7ofd4zV4+M3nVHHyD3NKGt6?=
 =?us-ascii?Q?eevTUX9u05yu+7IaMPP7inLyGi52rhNwEkow69QqCISkSpw2DPuAcB4goAIJ?=
 =?us-ascii?Q?Fj1UKH5eYMwzm5mbV8RVUnJ/jrZJmwzexE0yfs/43xNh+JeSJtsZVuPf/uj9?=
 =?us-ascii?Q?8+Xpang/dvjXjWHtqxf7umBnc67bveUbffiSIRK25pcygEwshE3V4fyRd68W?=
 =?us-ascii?Q?xGv5J1Y/LOLBZFzm9scmSCr2bofG1JctAWk5x6plfet2aEbAV/Ia7B8fNIe/?=
 =?us-ascii?Q?0Hk91OiMOHzFaiSkXiqi+RmGexMgfC22vw70HcHFRWEw6A/QxHPRjuoHxX16?=
 =?us-ascii?Q?whL4RFBo/tvkuH2CZBSYD+sto/uS3IsAzRbUApuN6EYwlt6MlfMv/XA3RkYp?=
 =?us-ascii?Q?h9F/MHgLHMK/DSWBCMNta+75/C2wuy8kMrkaU7HX0+p3VnONTwWQ61BPo7ki?=
 =?us-ascii?Q?q3wKsl7grSipwFJTfl5To3pfj43LVdvtM4Tsne2LlM+OBGVSjed9HZMeyjcp?=
 =?us-ascii?Q?rjBkrMDghOzYdOifwT+TWb/ikmmT2RlrzxLtIAMmROZNCSxf04Dej5LimRnd?=
 =?us-ascii?Q?QzO+fZCSvvYmoWVc1kwM83NUFmbkUZ3bxKgGM+0RUNg0eoZTqXpzjApF2CdJ?=
 =?us-ascii?Q?yLYM4puq8zmHKgCzgYcy6wYnLJJZUsTTHoVNGqReCq+ZycCtqOe6SnN8e6Xk?=
 =?us-ascii?Q?yGahVirc6pSwk4AY2b81Tgmcbrrw6i41C/5OTyBGd83RdBDRlMeK+hsDCsgT?=
 =?us-ascii?Q?ckoJo7+RMJTkQk/J0SEHAgqEPPIOvZqPmntEtiwoA1gVc0bLX7oDTsxqDl6Q?=
 =?us-ascii?Q?2LmUyr8d9XlOX3ncNjIRaBNsvm+S0zLetyLaSgpv2TW2qMWzV7wIzsiaLZ4r?=
 =?us-ascii?Q?lcUqADRHOrcUapQ64kMYcKSiiWoq787mg1jPJMbVjygek9cqEOJpmXPTJzb9?=
 =?us-ascii?Q?osiQDLF4uQZ2FJy5jlDKxbFnrCyDdkURt2LAqLeQpbNaA/WqvLu1GUcsdCsl?=
 =?us-ascii?Q?/7KeZkZ5Tovi9M+n76HbVCAPrYh9oUGzTjz/HuXnBVwauDhakvEdzdLZKqv/?=
 =?us-ascii?Q?Uh8uM0tpML6J9GBkC6labNtePnLNNAfHC9lOr2Aph66FXRkb98lJCNscL8zw?=
 =?us-ascii?Q?WE95rAse5RFjhJstJflU9r758c+xF16gs8QkFo8dOFZEuccNX17L3pwBuIVp?=
 =?us-ascii?Q?hUPjCaihZbkcxe+Wt6Ag5lJucGJcIxhYdX5UfD+XPU6aFT80z2QRj3oXLE3O?=
 =?us-ascii?Q?H5FFQqGsUXu4HGo4aGlQaUq2ejEP2Na/pBnf5qb4ENhCRwm7G0YTYP8yYsIW?=
 =?us-ascii?Q?fE+BIsf17eCAJMqe5f+/EqapEIavtP0AwXiSl+VQ7FOnDwjRraTrcLlBE/O2?=
 =?us-ascii?Q?nayN6aUZfoxCkX4q1NMgODNP7Ql3lfXcyrFYvbQvyt2A8ZUVGXrxDegQTcUt?=
 =?us-ascii?Q?racmoJff4NLjxPIdIWCwexRd1Q4BMzMDZpXHd17PH6PM58+T3+RLsbrkpwpK?=
 =?us-ascii?Q?yBo+qJBSg5ZOWEIlUPqgTfaqNaGbRIs3yDZY7ivq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e145b-8985-4275-ee40-08db6c0101ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:26:18.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QREzffOEgaAKBNTg+TgsLks4vbs3Q1GUy8aQH+g9semI2ysQAcY0pbo0XQq2TrWrwyZcUNtz/W1laKopNGzB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
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

