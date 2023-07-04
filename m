Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5B7471B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGDMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjGDMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:48:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0AAB;
        Tue,  4 Jul 2023 05:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6KE1HuXVs4Gvd4OdcRPwcKhc+w+uOW/sg5+FwKN/vtQHdSC4fV4cgPcucu2SjiT10YRGpvH0AwBjJqpgSxUKP9TYcuF4UVn4BqP8P6kRfQ0eksuN//twyChzL+suij53xQHe0pZ/uQjdSGVXpD+Ua/rDJlikva4EERJMGJwps3d26frCPrZQaffTP0u2IWKNxT4oQuA1M3Yh3aagAXveCIdn/ECmeU+KDOE49QjbZDInko+cvkLVQUTa6Pujo3K/hOausYPFMwRd843A3LgEh93vVdDp823khzWes7YuEt9CdFqyoqMXGS6emy+qUGKXi+2ZwIFcu/SzZKVldawHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoPGO8xYoQbo02iizNYAsQ4M+whVOXi4Yv1TVZl3jV4=;
 b=GrVT/7fzzZjE69cSOY30IE15+zxSA7IDQJTbmHVU4Yri2dqpPbnekwySmjuS9d3yaNgjrIoecprBArSjH/oBoKia08ZvRvyxwJ6iUkK7u0Lfk/TNTEgnAwTvF4aag6naI/ZpunDfGZbU3sjAZRbC23GAi9YbFvAE/mgfJKhCprPSILoHhvA6Le9UD781SVV1TRoW9OTRaQO5qbvXtsFsx49f2Kz2t9VKxQF+qq2se1SwipKJUa51j7PAMuwdi7E3zPyAZJzb598eANE9K7xXjm+CiT9b7Kt8gGQgxtONfe+VrgvVfoBjCBTPqgZjiA5xOqEGoOTG+hlgBYiFe3F2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoPGO8xYoQbo02iizNYAsQ4M+whVOXi4Yv1TVZl3jV4=;
 b=K/1W2MC0YlAL4D4qlAJa3oTGcAlIcOua5DNi5yq7pCVPdwl/52Q+2lGWnfXFTweZV3/IOfdoEI7urwonkob95UBlAynWvr0r6gZMa90OnW3WMXsVfsKtpopm7A7MQ3ibPSxBkUF4QZPy+SHz8zKX6bWc7fTfXef8r//b0H7CLrPa/Eoc7zIXQ0AAcnps+jdwJZX+RGOzLddMCxvDkjQK/hwSgZIVNvsb1cbIRoY3Rraloym0OqsShr5lBY1L3K5jczT7e0RkhomFKTwW5beMrLoSs+ns3bO3dDNxp/wnjPobebMMjC5tiJKIUdK4H8z3SqpRV5eKNb/7nIeDSM/N/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5679.apcprd06.prod.outlook.com (2603:1096:820:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:47:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:47:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pinctrl: pic32: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:47:41 +0800
Message-Id: <20230704124742.9596-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704124742.9596-1-frank.li@vivo.com>
References: <20230704124742.9596-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dda063-9df7-4eb4-e0c6-08db7c8ce402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xNdNSoAneSXguSZ/egP0SAZqhlgWqMWeSCcdmTBhn+yH/MbmnxSOHE8X6PWYFNjYz2Vny+3xrrX3nt1zWcWRHKGep3adbw+JUoQe/lBvH9TSjlHf6t6y/0WjHT+kE5dLOnfxPYeG10HthXDoL9/Ou1xmEjQdubZAvHH0qkQGyT2RacgrmkkQhU65ZKXcidMMiQ3c1DRVujGHRR2y27o/SvQB1l4vf64a3C41Iu0NjbYnNKr3Ynhlo21+6v7EHe21bU43gk0fzIjRGsDQhVjr5twKLujIABeUMfIDEGESQH8nyLwLlXYV01EGniotPY62bt9Zbg6JFHRWMPE5EPfZWuHMvNXr6i8TpMXH0HgljWIflJOA0EK0ygE6WJkKsrv0/kjgokvgYLP6Vc760O5nQk3MRRpn9NraHwrM0kZ0HZHilIA8rwLoStidmQvEYdW/v7VSZ1oaeyriSLoHHjqcJ+AkL6OL82r8sEUOD9kp04ri63yXpoGNK9zB4w+ZK8TPun+K7ZMVVhS/YIbkF/q4GCGOMLooc7WvpdOhFiFokAn0n8NyhjaMbZO1WpnVpOsY5kWINPqnQTczhOioEETXKxglr5QPlcH0mym3Dw2V+2ww9ulN+1DLqWTi2BVrdxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(1076003)(6506007)(66556008)(66476007)(6916009)(4326008)(66946007)(38100700002)(478600001)(41300700001)(38350700002)(316002)(2616005)(83380400001)(186003)(26005)(6512007)(52116002)(2906002)(8936002)(5660300002)(6486002)(86362001)(36756003)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y4Do6S9KY5liUA/GfqPRXF++itxEDLqui1huksipENIsGxQWK0Vlx9wWYKhd?=
 =?us-ascii?Q?ZNhXDVFFE/jR2GVrFz3i6n1OSiXww0urBN9ddcW8krLDS1W9M8YBCfCj9VUM?=
 =?us-ascii?Q?jJEKCS5hEsC5yBEPBaaD0gZY2gK7483Hh/rcTpFu0/a9fx82PiM57tS14Qwf?=
 =?us-ascii?Q?EYUvmnPtRId8zZxJsfDcy2FkeNeKtPGeKin4BQ4s0PYS1RJgjnZYul2v06dk?=
 =?us-ascii?Q?g41z/6fiGYg+DNVjFkWWyZurMcpbycl93O3fxai4wogp55nah6Dx0/KWY8xa?=
 =?us-ascii?Q?sobaySh6GEAxcWBORdtcAxmwxqP6FhUIHAsXutj9grWJAtbXkOFVU1v/XABo?=
 =?us-ascii?Q?Dh0gzHO9prEf7uWRcaIhBJjtCMVq+hc+wFUtnx94YkTWsj4tYmkBz5TLYukS?=
 =?us-ascii?Q?ln2Uie2sgWF8acZ9OTwinmnFWbKq1hFqYeGlR4gsumOOZvzbuLgjfp//2aKN?=
 =?us-ascii?Q?8+2OP8ejc/8RLAsJUlW4sPqbaed3A39fwS365urPsNbao0LpJ7UHRvAWZQwl?=
 =?us-ascii?Q?gqChSK/TZtXa3WuURxJvHYQ6K2bQDL3YFCzkLkj44htK1m2atJXRKNrxzceN?=
 =?us-ascii?Q?CkCPCgy/hITj0GPmVZjciiq5z8gdjCT1+T5ivaDa1g3MYQGJwwZO55vFJDn0?=
 =?us-ascii?Q?Ii/Kqz0zhzVNYuQJV2TJ25YK2AUUYo1OkvjW6V6NQsX5iunm7rS9l5+pABcH?=
 =?us-ascii?Q?eL6wgR5azWsK4neptJrOYp7NeO2QKcnge9k8XNgGIejuoEk01d3UyAtLfTA4?=
 =?us-ascii?Q?KK9wg1BV04VnOqkfhpRNeYfzcTB68KlemW/2YPH7jx+vDy8OjrfMQRtkIyTQ?=
 =?us-ascii?Q?ozSClcZanhkbAolTn1DV5gaAOoI2QD8JiCK5p0CXYVw1sQWJYqJiHwt6mSy2?=
 =?us-ascii?Q?4XIH9PMQjxih/get996wCTLrwLNu0fyfyivdljGag8cFEFSDExLON5S9h6Z7?=
 =?us-ascii?Q?H5D/pOkUv5vLVRItHJv0E/sE7sr0hRMbDJxtTfXmMeCoXTTjallyb3y0uoYs?=
 =?us-ascii?Q?dxj7w+EeGerC01NpWqA2GrTc6a7a9fkLKaXsBLOhIsrSu+QwuJX6Ey5iQnnC?=
 =?us-ascii?Q?sjlunnaacAhVfVBUHbu7IWtr8Bal2YDnoFqqIxew6PDSgIt9Q1MtcnOkB/+u?=
 =?us-ascii?Q?D1lnEn9xKpV8VatAaw47h7WUDnZ7zsjlXqWNLZhf4xodGeJ9c3wwEElRRavq?=
 =?us-ascii?Q?UntnmwkfVsXd+4zLsgoSJf+XJes784TUZrPukCHUuWbKd8IIDsOrProL6BuD?=
 =?us-ascii?Q?dOUHM68l7SPS+t+dkmEg4/ALGpF85DFlTKcnr8TMgY9ChLPdRveVOhkzwMMD?=
 =?us-ascii?Q?4IJST1WyWmjGiZqp6++8T/TaJS51E/OJOvu60EYohCP45wRAHIR2UP2R2/zD?=
 =?us-ascii?Q?fq0rvizQaDpG2oJ7qOCIUqhnBL/y67AfqAKMg/UQq6aPUuRb24BcdYom2hkX?=
 =?us-ascii?Q?i/Jv7eXVEITXTnZovWlDcyQ1whDRYVQQCOPnKkvGPbNX34xIS27kzAZciLxY?=
 =?us-ascii?Q?CNUjtcmt7E4RxqH25ImDPlWVAymE4k5a+FHWnK+i+eR2RD7y1PQVmkwb7QBE?=
 =?us-ascii?Q?Ivr2dokJIo2d7TwgRXQK17YJM88oS3KCZryWbssV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dda063-9df7-4eb4-e0c6-08db7c8ce402
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:47:56.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxbnox1sDlHnNJVBfspHf8nTrURy4Lm1AJUcF14zvvUnghro8et5NtafFhnA4OaGHinDT5d0FJYsoZn+iQlRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5679
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/pinctrl/pinctrl-pic32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index dad05294fa72..8ed6c5f8acc1 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -2162,7 +2162,6 @@ static const struct irq_chip pic32_gpio_irq_chip = {
 static int pic32_pinctrl_probe(struct platform_device *pdev)
 {
 	struct pic32_pinctrl *pctl;
-	struct resource *res;
 	int ret;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
@@ -2171,8 +2170,7 @@ static int pic32_pinctrl_probe(struct platform_device *pdev)
 	pctl->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, pctl);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pctl->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	pctl->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pctl->reg_base))
 		return PTR_ERR(pctl->reg_base);
 
-- 
2.39.0

