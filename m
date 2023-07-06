Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9190749917
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGFKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjGFKLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72C10EC;
        Thu,  6 Jul 2023 03:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3rCfGxGDrqUqKBC2LEIHl7joPrScZFTJ53yJVh0+RtHKhr+HcKZTa1stJzLupVmPuRrsrMPB+OtV45k4yOpyltborh24Fa2o+vyKMENg0U0vYs+rTvPduCXAtfnKIlINNfJdvVorObRT3OMoQ83ANeLZoMk1RHxKbw/k7M5IiY/cu/D6+rCyacaeD+wXww42g42JW9ujc3IeqbSux7qcL/ieKwxd5rx/cR/rWoV261inWld/13yYX/7q9D4Imyp2KfF+6zr9XxoKOGLFbXWsisIZa5HD9kccGoTwHWJrmfMiiPnrTONn0Ok7/2GxRnGheRZcM6eRcW2PXLvlM3UAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEb7wQ2yN858EKiV1wEH9mQOxIfFLeAU3Cf5LzryOFA=;
 b=cy8N6LUDDLorAIspDtdeOCbjOWY/uHYZZVkpXbKaRaff9YOd1vmLj0urcUXzfzQaaCzllajku1W4oGr4+D6mK++guzxfEkv2/t5K776oZ2Uecm0YCc+6blROZJZ/7nYNR8gsUdG3uohWWXVmmQyqvQ5aQb7OUqhxg4mTUpF1u8fC+uXGEiI+7FQ8GZG+PdslOaWJ+bcmwNWszg7QwSwSRQhSNYSyfle1bhzAF3KzrURedaPEFiIr4pQSJ9Ugg0ng6IwRKcsyZ770/sFJLk45Kdck68HGcE7Heke2lCshp+GJuGlfNLnpVivKdRDXbG4Uk7LkuW/tlwqRQ3KnYQ5qFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEb7wQ2yN858EKiV1wEH9mQOxIfFLeAU3Cf5LzryOFA=;
 b=qX5ZDOZZIEwdfyNEBe6+jRXM9Xl//mJVBzi6DW1DyH58Wxf2mOhK/q9cubYYLf+z6d8bv8DcIfndg0y6+NrAOoT/CctsE5VmASo9SO41ieYRmJfExnLbehck0XATAsVOqp4QOgnQ9KB6VJmA6mFAFlbzZphWGT5lOMibyd1iFqR1W5Y83eQ68HUkPBHEq7v1G6hJysxxOPfjb+jnOmB1m37K6YMMfjnPlmfIW2z6EWtA98ud0g9VwfgQrNzf/N1AAVpMjmq++F3wl3Vp7rQ4hqx6Uue1OhNS+b9XzCMZNzFb6+PMha2W3oHpC2LuoIi8pcJ6sxWxK8fPZlyZ3fH/yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6447.apcprd06.prod.outlook.com (2603:1096:820:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] media: fimc-lite: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:53 +0800
Message-Id: <20230706101100.75654-5-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 285f3c2a-4b69-461f-c752-08db7e0956ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxP90stcrYHQAwcIHMnwSVW4onX1faDI/pkAOyK1tIOqjpzdszCorHZL+/KOpyfK/TYi+mbcNmmBcb+13MTgT4YokMU+Lv7P+br2mRjvjc2KAXLE16bvAg3iI6KHOJLs1GwmtGW5aDA6fEduJF4G8Tkfaa+7fvLUhmaPqUy0BqPAg27DasUy0mrfGhRHsocZh65M1S9t9IVoLwKUNVIr1fWhlkP5eTl9evTlKeHxguA6KujuikGWhoFJip9YT0srytkCkbPtHouGM9b2xQb5CEGEbB8HuRLoqnpy/jFpeKMFOxVicnKrUy/xwMsTA2K8fFMvJVSjeZwpBNKZRV2wa7RADR1iFRXazYe/KREiuA1zAko40Q07AxhRYHBCyVqrlxTsmMjZMX8az4Rb0xte8i/gYE2PAIOHnrwOLsnzryHndLZRv6GwSHwwds2Q31LvmxMJ0OmV3xkHF1oICznxHpIljyOUaT5TXbhu4PXx6FfaOmgGzEM5BnG/ed5OA/p+Di/YAEnRhXc8oF7BJev99e7bembqf/bkzqcjMNDnnyMAnM8VEPbGTrvpuvZdkkyyE/Oquh7wfwQSp7iQojZbbDoK78XkQw40KGDoIkOJFh6yMSafMzCSi+0xZlBHYPJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(86362001)(2616005)(83380400001)(38100700002)(38350700002)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(36756003)(52116002)(6512007)(26005)(6506007)(110136005)(186003)(1076003)(6486002)(478600001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cv7eQ+MHlLVaproVgBOxPaH25IaPlGZI64t3/OZqpeZ2X6el3FdCORSBlTpg?=
 =?us-ascii?Q?jc4TuOl8k5CEvy6gi86tfxq7v0soz6YX4mGWhnhrUXqPt0dNF9HupNLM7V4T?=
 =?us-ascii?Q?kdY5hr99L1okgVBlABHhhWUGD+TF15izDOSOyum4NNsj+4f4QebVXfYRyXlR?=
 =?us-ascii?Q?4d++nOod51semzAIC1snmsnS1Tj1+fC6FYcVXkSTUHj0Cefu2D5YOh8TqLvm?=
 =?us-ascii?Q?jHsUKg1+nnDyo5APDDQ2hVwLaflGPKlEdTzYVd4H2q1vyVi+yj66xvkxjM7K?=
 =?us-ascii?Q?7BqAwg0D7wpCxFShFfod5Bto+peGteuY7RGlsiiEagr1QryaGVFTAg0o/q0G?=
 =?us-ascii?Q?daiWoj4tBsuKwZVJaRS7yMEja0tuvVF6c3mylZ3Q6cvbOnjxr+MIDuKtUTug?=
 =?us-ascii?Q?A96uNwJjShbj5/ewCVsk3brfOYIQ+bG4pob0bk5OiYDklTLFfs6CWVZ30NX7?=
 =?us-ascii?Q?CcYeWDqVJmTzvX5PtWSpInCwskU8d57KRZphrwWOIl5oqreHsiQ37rio06Tv?=
 =?us-ascii?Q?c8sMAe5NpeOftYVjDYrtSstnwibQD8fPaiV2wELze0Ws9jF6dtz6Zcsta9SC?=
 =?us-ascii?Q?eBzjPwaptJdjRwiAiRW/ybWPSFRTh+7Bu6Wz2Tvcc2pwXtWS4afjahEJk2k7?=
 =?us-ascii?Q?L+GfL9ujny+Ly6O/F5aWNQyT5lrb93c12qJ+l79hoKi1zLmXNxYRV8a5mmgI?=
 =?us-ascii?Q?cVbj5RMxYSk+7b0QMjQYw5EmD1J6g9dBlcx+6FzbHVvHcp12oz930xOYdLUq?=
 =?us-ascii?Q?K8g5VYG66LeQwx/fUL7QTOdKF3n8HCJ135C5yRva6r/tcPwVjfRbX1MT7z67?=
 =?us-ascii?Q?7FUCaXCaE0Br7qnNSxaT5AMt5zodDsHKXh1FZ7N/+VJCRqvBZPkOw4LATSJr?=
 =?us-ascii?Q?RoqQrOLcEJFI9hQ5S+RVoRlr3AF6vA/Fv3bgk7pWDksFZBgLwO7GapIxtUde?=
 =?us-ascii?Q?qMvy67d4gZUgnFZxWSx87STCa/DajNbogcvl6TJyQwOG0O9NyGbL2XS3BwMz?=
 =?us-ascii?Q?jekI+Ego2LkqsmmLYDifzY/z9FSQlDxy6yWP1fz83VMCZNCM8cYatsJM8wVv?=
 =?us-ascii?Q?qPYR66/P2d6/W5WuGUm6hnPPQKVwkZMY2ApAHS2o5b1uvrcSV/p2k0PQyaaI?=
 =?us-ascii?Q?3K9vEnUUqa79SnBi5P4A1TrwxqNPJWoyK10dcjlSNcUlKPsCQzkFtP+SmdGq?=
 =?us-ascii?Q?Uyo8Oh1VLmtKu0Ji+EKZXEnzkUzi2nu3Oqvbl2Rb1o0I0mwHNjjTEKRFwlP+?=
 =?us-ascii?Q?Dt4uuO+dQYwYKjE5XEWetjckArfG2ABhhRz3bhfhZ+4FhVpi74M10aANNkYT?=
 =?us-ascii?Q?BSxveHXN76kcAnZMr8YQFaLvqDUjTXleCvupe2uCEvrboy5GO8eD5rs3f8dx?=
 =?us-ascii?Q?bgG5z2SGjDPsYbn0nhrv8rSPUnPK7qb92S0tyyfZ7A3b3d3XujUTWahTmk8+?=
 =?us-ascii?Q?Z/Zrex3Bv2dPD1CjfFwflaJ43YVHfB+q7bmw8bJ6GgwViWyEdNEyn+hxJeyX?=
 =?us-ascii?Q?j29Oq6tZwfrZA0MzKlJ7vomSsZ7djvU//qCx+XoNfQQl8YEcTug3rd6FvP0y?=
 =?us-ascii?Q?ryQjNUgvt2J7qzIUV0uSjpPIQWiEZcXMHLBzyv1W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285f3c2a-4b69-461f-c752-08db7e0956ef
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:18.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68y3Cjf2/PcXJcYpJvKrcyzz8lJu+cb1HWEmpC9kH1vBijym0CDovjoxBFeT1D2dfnbsDsE/c66X8I9Y23pwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6447
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
index c3146ae08447..9396b10b5b1c 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
@@ -1450,7 +1450,6 @@ static int fimc_lite_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id;
 	struct fimc_lite *fimc;
-	struct resource *res;
 	int ret;
 	int irq;
 
@@ -1479,8 +1478,7 @@ static int fimc_lite_probe(struct platform_device *pdev)
 	spin_lock_init(&fimc->slock);
 	mutex_init(&fimc->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fimc->regs = devm_ioremap_resource(dev, res);
+	fimc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fimc->regs))
 		return PTR_ERR(fimc->regs);
 
-- 
2.39.0

