Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E21749924
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjGFKMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjGFKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19161BC3;
        Thu,  6 Jul 2023 03:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROwhRr/BYTizapCASt/lu/qhTm0dUNJoUsuw8tmCU5JLf3EWbXE+tVHsLfXur4PgNaC4WxVNpL26nUqboNx5OTKvgRdTnLCTWc3fQM9cXZFdUKmYX3f+Gd31QjTRqHPSD2eeGpCtXGdam7IUqZxgoMVPtsKvFEwf61HrYNLIGvMFfFirE8L4z7+pIzQh/IsZ9aCLothoQYtPQF+BObasSOz3cTQSVRhKplyB0R4v9cYDDiU2co7vrOGtPQ+4kigWgNTVYBFsGPcMUOgyziZUVdmGpt4iNYIGE0b6mc5gL31kxYh7zWTai3zIEI3fNPn7NfF3/I3W+j5TsruZ40GkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32Uv43LxUrBhK+2tw60+pa+ufVqWb9XEOgswDfOphw8=;
 b=j1g0RHEwkw+82IAtGxrWxctzw7TsvjZhk2SyMKU588YUBMdXp+0t1mT4jEg8Jq1TBLjhXsoHbJz+WKr8ON4S9VJzGXIYTndv2QXky3TkxPN/xmygeWxo3zfnRlXq6hBYIq6Wvp9/pMhtc2nnxLZZRPmE6EKCNy+DJA8qyh4H+9orWUFogZxE7toH5vmgHcUo630TFC5D13KyvjO8AXwi71COnnsKLYYmujXSzzkq2Ig77oUlEhsnnqd9Ng1Hy/5IVvETWHof8wcUFhpwj/6QGKeHW7ghu59pxcEnQUI4Afe0I7hUDnIiLfoBKMboPf53asbO4lS2gJHiAZJGp+tBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32Uv43LxUrBhK+2tw60+pa+ufVqWb9XEOgswDfOphw8=;
 b=aE5xP+UkmHg0Mqayc42ueYQhhNp0qpXeykd9WaCvVgIwFfY9bgKjp+py67YZllnGDOt49pM85Rrlzio7xrWUL4S2Ye+kpWaczh1/BRMRAsOOeZvRkjFBC2AN1+fA8xffLV6F6p47U9sHBNFqKyWAIOoh6yVuLsRCZP/9YHWrfVuP1iwjoem7HmE+eh9z4I1Y/6lms86u2HY4Sc0jewo66Z4YY4ofKeasmEgU7n+nRAR+0phT+VDwsaffBfl9yxuOmRhKfK7UKDWBZFg0WkdL6zX0bPxeyfh2+s/jkSt2wCDuArL4kcnwShje+awH5omabVd8Dqn85U44ihw5y+pyjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] media: fimc-core: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:58 +0800
Message-Id: <20230706101100.75654-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: ad94f7d8-d1af-46d1-ac05-08db7e095cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLdaTd4Yh8cXxxVNaWdr5u+Sks1Nw62o2IBsEZNgjhVpyK/JaTF2N6z8duLFdVzJvvjtpt1DNH9ccjQz4kLo8MOYfV/8zWF6n3xvkbf7caCTPNLUYoTY0XxyX2jbpSoqoPjQekiCK1lN/LNlOjwqlVNK8xk+W2tMWlKuOw0an4IsLbP7b2dja7j0R3jwqGg7ptsOzYQKOG71JiqNSgz5l8ZUMTtoBw3ue9SEODHdRRrcazMIaezhCdKNEazQVdlwi/8Ukxx1PioZd7v98eixpTc3McoK0r+IIpAfohvaTCxvEO69ZTW5kkWvzJVlS/lFja4ZxVDb7ufKtHlJiV4UGA8a6jNGLHQRPG3QdDAsrrjzTGi0PDZd+4AR7wNQKk2SEa7VsOBlKrchcKQemWbbE9a1tWm5dCfHBsWWg9NTzKYG4Rv5aiJW/A9+J19p/7mVkzX1zB3pUGs3/fvPsLZAA0O6s+gL3Hwkj31/jMjwRfXYZUkYdOhA2EOdG78LoX2WvzrFMjJ1YDZEvenU/1icSW3sscB3jg/rPmELl61aFuZ1d8mbadHlPl6WoUWfqFavFXNjm/NJtw6bguGtdbVf1G/BfJ3CBWnVZYs/LhaWMRa61gdO3zowuwQAsalW9IiI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(2906002)(86362001)(8936002)(66556008)(8676002)(2616005)(6512007)(6506007)(110136005)(478600001)(6486002)(1076003)(6666004)(52116002)(186003)(5660300002)(38100700002)(26005)(83380400001)(316002)(38350700002)(4326008)(66476007)(66946007)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLWKJBOQ8Z9rLIWX4wtJtSLykrsawxY21rBZj+ZG65LUYIOe+iiNozyJq9T7?=
 =?us-ascii?Q?qmWuVFDZXJkJM6GDFDh60h8emJZKG4viZX7YFdT6zwo9A2q8l/vqj+oE1ft4?=
 =?us-ascii?Q?NAYRXChwaNPk0i52kNr5utmTjW4jWCGS3TebpYbs01mk7pTzOmc0ExDzCBCq?=
 =?us-ascii?Q?h+lXII8kquWBNhvLSUTiEoYhzYTO3GXfZnjofIdN88UDNX0nggdVdZ15cIep?=
 =?us-ascii?Q?r5P2VvSeXmDaVk7OHD1PVTmCoVLxRC9qjFJc8ykm9DBR3UyirfiV8Uzg6BwJ?=
 =?us-ascii?Q?lXsm4oOf7h672jVr0PyDKhcxP3QbFUvQ16WHqY/7WO//2CO0bbh4H6jH3Dak?=
 =?us-ascii?Q?hYXV18yp0hR9bYZQFzpYcsLj3QAEND5WoacW1kzx9NAafSKGM3CD7KHo00Xf?=
 =?us-ascii?Q?dFyobdnbQKQV14EwjKBix5xlDf6uWHhTlunPsM1fRvha8ZGwDjDaPDYbGH2u?=
 =?us-ascii?Q?D+Svy6ECMxncgQC/RrdGo7a8sEoUnKXl/7iKAFdof3gAOvM4DJ7tG6zNvQhG?=
 =?us-ascii?Q?dn/z3g0j5xgmPyLG3ToTG+bQqDmyfjtnOli+u/hbqV5xEr5Fs+PnnYvoHvf5?=
 =?us-ascii?Q?NpNW6b7W1wlh38NKttIkcAGWSnJB18cTxG+aj7HcpqYxIx5lnS6lIv7eYhOR?=
 =?us-ascii?Q?6jf7A/z96b6lxzbTSAeX+doUbvOEEz+qdmDozozc7fCh3yC99PX52DNgJH+0?=
 =?us-ascii?Q?ckKxKlaml8qrpAbVq6EfD5eWeDI+e6gAAp3DRMrBFeRx+rtB1EdfmZSKU/Cj?=
 =?us-ascii?Q?1ionGUq9oc9pqi10qNA0aJSUocR+SzkFZfXBM2P18zaamaWdO5PvNlM/wOLF?=
 =?us-ascii?Q?ut+faJY6/ygg6Vy70UhN0lXkDFLzOEkFcrlMyE0FhEVMterancvH/8ZrhBbI?=
 =?us-ascii?Q?MjExuAJ1r1KUTpUEHeBzhK/sGLHLdggrgIn4P6gEfBQXVSrsIq3OXHTOq6uk?=
 =?us-ascii?Q?GsRz8w22G/AbF4ifLX2hVLuhaeaUrfds9c4crgquhZTMGyGiu6H9IkND6TXi?=
 =?us-ascii?Q?oxqZoJApsr6oy/OwUnC38mzM/IIf1d5V50EasnB57Ije0/6wqmUzncpSRhzx?=
 =?us-ascii?Q?ntPdnQFFGUKsj9tDlAOnk/++T97cq/RGMrvNHJvTUkKcAYw0m+piHRCJ70cH?=
 =?us-ascii?Q?t8vWPa9WPSiGN2qyzk1fJuwXLmaLdxfQrjF7cVQorZKka+9siXBpiuSU8KiK?=
 =?us-ascii?Q?KOPrlG5Vvf7fyq81Bqni8Sdve0kA7NDNd2TUwTwgnV4qcw7eKSWidvr93qB5?=
 =?us-ascii?Q?bRlqZ63AL8qyWipovVxPmvX0iiZBYTrSREZpmev+I7kluniwvqmUapWCGbfV?=
 =?us-ascii?Q?N3VCfSMyKOOysb7SZ3lwo4Mm4PfwIVyCklfsAf184DOEvP6LNxTDoBg480mM?=
 =?us-ascii?Q?xMkXGSJx6CjFvUxHGs94mUnofkKD6MydEbv9xbWWWfRIJk3r+1qzoR1QcsnQ?=
 =?us-ascii?Q?xx/WnjBcW7vdfbN9cCv07MiaSFg7LcP2SfC/EdiAgPWRNbRVIVlk1JVYws4G?=
 =?us-ascii?Q?csOJEIjX8z2QSU5J/JdvvlqOnxQZwt12ib4fmmeHdDBjQGAGwprhAOi+VPeu?=
 =?us-ascii?Q?Qzjy44kyOscDQsrt4T+vOKW/arZvfrjdXHmngNtj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad94f7d8-d1af-46d1-ac05-08db7e095cf3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:28.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6SRPVszSCTu/dKtmIAO04+qB/X9mUEbVCi8u6+4zoA4AFXXZ1hYlAwO1R9Z47bkVgccr+mMD25YwotGQAZ2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 976b4f747ad4..4e8059f100f5 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -924,7 +924,6 @@ static int fimc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	u32 lclk_freq = 0;
 	struct fimc_dev *fimc;
-	struct resource *res;
 	int ret = 0;
 	int irq;
 
@@ -961,8 +960,7 @@ static int fimc_probe(struct platform_device *pdev)
 			return PTR_ERR(fimc->sysreg);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fimc->regs = devm_ioremap_resource(dev, res);
+	fimc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fimc->regs))
 		return PTR_ERR(fimc->regs);
 
-- 
2.39.0

