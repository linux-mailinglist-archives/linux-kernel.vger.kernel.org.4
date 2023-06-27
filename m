Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B971D73F9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjF0KQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjF0KPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:15:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF1359C;
        Tue, 27 Jun 2023 03:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+EwJzzITsl2lySZeLhKhCRepYGD2mSST/XlGSwt8fg9hP9/WxhdAybS1rbFafdE0gPMGL0xFR6FSE/FyEXwad+rqYblpNRj2JdQPUit0BNe2KrSnte03F5pF51dwbI+VMC29IKqiGFzubSDsRe9VoRzHuBUy7hcsXDzpz+t9FKDFVTfgkmt4uflYC6SiE6EObMILnPcClBQw6eI2BQdHLW6SXn5sAJw+jzjWx2FTVRenOAvw4E0tUEn2zfTrbCktOod+WWaJO5siKa7ZKCDBNBkyNYI1+PBMlmQojGmBP0wMiAZA7XQpeP8wlTGNtci+FqNaXzt4TUHknF8ZbH2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gASfYiTU57ZLaNaZNulzFw3MNfbmcSk/7+JPT43/H2Q=;
 b=XInHywmnDTb6J9YOwW7MV7/0qEgGrB31++ssbxgQXjt8g6aiqBH3V4/+rWWzAWsLZSGxWl+Qs5rhySSIJ4Zh4oErkaPm1tbVe43iXL+LceJiiRvLqpc0nRV1xQRb6/8s2ukHIDZn4vnvdu394zig4Sy9wUPV4oG3ElwBmOPXXsHl9jSwf804kkZvP/BIqltz5ZH8OeBLwqBEjnMobvUPBAR+kVKdptGyDLOCQSdjdTIz0WI3zz/RQzjH7fPWS5UKH2w5hS3aoqP4+fsUEHqeyqAWGcK8TQU/5g4TpBegc36/YI8dFeD+7zvlmqn7xI5FUmx4rE2w4x6KN2BL48xOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gASfYiTU57ZLaNaZNulzFw3MNfbmcSk/7+JPT43/H2Q=;
 b=XgoV7igkQ4FVg+z6TRj4Je9uv6bpSku7JrZlUmeKxJd40FXPoiavfocBA8i3hp5u1zB9LdYLq6x8bObyemC2+u9dG7pzsQmZHOVFHfMAFb/DW92avHvxRrSdxYgmyYu7vKxGSrjKVlVNBsLffAGh6Xx/yR1E6IKhoVMdQYgEhkN/PjcMnuQYt18V5Mhh2Y89sdygXhybKmFkoAnFfwIdp5lqGmNRMvmLrnCwvsJMC+8EsHRCr2zUdDLTnOlQzTg7X91z/0vkep4LCkesVBoUNqMpajBdxw4vI6wkx8GxH6v7ROkIOmxl4DjMjgD1x42AYtTMJx4trv+j8SQWk9x5gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 11/15] thermal/drivers/intel: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:11 +0800
Message-Id: <20230627101215.58798-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecd2735-aff9-4e9e-9228-08db76f72b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeAvELycZguyVN8lyLWeJ0F/pfbd5g+xFgYPa5QcY75f4POsxhpG0pd5NetvQpmedyM0JjXURKql44QLlcHRJ9TJyS6LqZKQgsnKlXrDXcMN+TNug9uGO5jdEnPd+l6mgaveEJSz5PsFkQSYJ3QFQpQ3i/877NR3lpneLPMd5gOp/8Bg5ZSUHMLCI0Sn5AJoJOXVmBXZEBQ7hFqNAg7MHCv84BjVtnvt198PxDbY/ASDpvW8cOtAVqNoC+Z5jArRueC8HPoHdxdsitgSNHpaOyymuX+8PbiKVUCl4grOVeh38e7HUXHKSbxDiN8Pn1ZonKlSjDaPxRzmdplPAboMBT9IPYyRn/EmeLOGBUPhnUEsvBHwi2J7zbMEr+FhzHNGtlu2dBq0Vyt8fUUc7sGeB49KSAJ2td+EnIPaEnRJVMMmSmYQsFH22B4Wr7fOgp0i2oru7WKmCbupCe/1Irg+YxMKIZVSDZwmYbBOuzXXq56Obmg3h4V/irWHuqbazSvnsmcdABNlnQzAFwdApJEN62vsd9eG+5W5s+eCcPQsO5IQhh4icv6Fu4vROjaMkGFIU0P1ktB0pkYWLQvzUsfwhhJEfC6VvYrGP/IJZfohG9Wn2VxsM15QpYiI4qZ8kRDguK3TyUW2xhEcUU+QhKJzLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckJ4SQVSUQ3ExDJYYwq1VsuHkB1ysUxJxXCCYxVpRCxvPXUbdGURkoPT0fG5?=
 =?us-ascii?Q?OpdZ6Vq7rhoPgifnFnmxOuissZTFxDBa4yCVERoHibnzVcWn9pYnibFpBMNT?=
 =?us-ascii?Q?DMuPj+otnJ7XARfY1lzN6ICDwiqQ1SF1KxrJxA6xccYkgVA6+98isVjSZAQV?=
 =?us-ascii?Q?CU/msykM1iQ2R9sElUv0CDB694OyZnJ9C0f78Xk7zPupD6Jv5sDDuY92NNd9?=
 =?us-ascii?Q?c9MlgjmMO/JAOXp6xo5aufrKfgt7PvDbu5LM51VeFdjRC/zLLVKPIknX9vDz?=
 =?us-ascii?Q?L6vcg3Mdcp5XGefD/kwBxTEzRzuuMHDLZXkaq73bhA0tkVL5pig2tG4laAPh?=
 =?us-ascii?Q?TEvsGrCDrDCKQFu+VA5ybY8GUvfp1f37dOtjSQki44euH4nSdiK8X1OaTUK2?=
 =?us-ascii?Q?WBu8rP3AAh9YpVy7fhrudKHdW2XEMrhCoJKXvhVlhYo8nFm2kFTgI+IiGQSG?=
 =?us-ascii?Q?qM8rIDNuJDCrlf5uvk/BCEppbftOq+NglKSQoG1DOmmrW6AY8pAInlVg1PAp?=
 =?us-ascii?Q?M4xg7l3c2JOJf/jo+zkXeUPGSHXeg9xL8NQBeAL6c3h5gvc5Qmeq7pFovudz?=
 =?us-ascii?Q?JP2BRvLYUB8ZS0F0aZQ4gALrZ0J0s52PDr3cgPYEP8x0cFwWRX+zDghOrycp?=
 =?us-ascii?Q?yEWfy5O/0MRWsL4ELMgNWTibB2dMu7gHvB65+UkZFjSBg85Qa4D8K211x2UO?=
 =?us-ascii?Q?okP/0wokXNXD1hvz5UdMslCUvLHwhN5MBoRpHpovhe1xv2jlWlTUnaEKt2ar?=
 =?us-ascii?Q?b9hQnxlk54QQsLr2PelbzsFgghQty9NO/gNNe93+0np5JceQqa8Qy5HoLHaI?=
 =?us-ascii?Q?ZwZTwemdHDXku7XOzcy5ECV1cG5Ld2pw3PDov8upTLGQq6Iky73jFHPJ/N2y?=
 =?us-ascii?Q?AwWmApZzz7Ydc2ouJ2nRnucDg01uFhnFHTbLUhQy6XV8xI77bVtlJH4mHLhQ?=
 =?us-ascii?Q?BblNRHSimehcD5hYsOPfL09pEjKOcCyyXQnaUbSoznV9mM/4Ysu0sAZpjU3r?=
 =?us-ascii?Q?WuHhVEeq+klMig1JDWNhMv24KYemcvl06G79d3KB0QQJLYqqybhH6eAH1LFn?=
 =?us-ascii?Q?wYeDmZ37lG0RR1VIuRbHLtg9tIhTZ2No9BX3rPQ12+N4UydA5d6MzgAkNRzI?=
 =?us-ascii?Q?vhWgb1M3NXbxFK6QEG9YSIYA50C+e4nkd9Z68cyi3dnB0rt0fhlblXcWTgBn?=
 =?us-ascii?Q?L3tg0es41pVzNnY3iQhSFJBY/6Pfw5TWIF7RcTr95maMB4UiyagREW/k05bX?=
 =?us-ascii?Q?W5oKK/uQICYU7tdJWPJMPdYkisMoSnT/dFFRsKjNkkcoOo6jpYKjYe0ES4kb?=
 =?us-ascii?Q?EvZhrDvkGo3+UiUjXX2lH5yS3uITnljA5tfvPRpYUuv9ep4JkxtesTSwBjpO?=
 =?us-ascii?Q?Modjw0dzX6XRBYG4PKjf+iMxZh/8RYVOuqbPGbDLC89L25aVQClzCtHJTKJw?=
 =?us-ascii?Q?fFnzYYv+If66bcp5jYsqvD4Dml5JbP3zCsDX2XGzlI3RnMKlXlEHoCeMKXkt?=
 =?us-ascii?Q?1q0msPbrcPJ79W5UAG2vHMcr3sFRRDDqX7AUVJC9r3ZdGepUwwOb+PtALl2F?=
 =?us-ascii?Q?+oyPP4pSQx8NlZHN+M4RPuNFcRsupxfrf5Gub4u/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecd2735-aff9-4e9e-9228-08db76f72b05
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:35.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd1DGy+kaXFLygvfycu5Q2tN2kRWnFYSg+xxw1/HZ+K1JJJKVXmbDzx56zLpehmPzTKWZbnHqyV/JCpIJRIMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/intel/intel_bxt_pmic_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..aeaefbbd5d8f 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -245,10 +245,8 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 				NULL, pmic_thermal_irq_handler,
 				IRQF_ONESHOT, "pmic_thermal", pdev);
 
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
-- 
2.39.0

