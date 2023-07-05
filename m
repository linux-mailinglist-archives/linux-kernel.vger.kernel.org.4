Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E55748385
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjGELxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGELxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:53:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840FFE6E;
        Wed,  5 Jul 2023 04:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNYwF9nTJpT7fxsgTXAElDEulAEB+dzQQDevaOimhV1MKTM8fH6XE03l95kwc6rb+DgwLygeXpDXSFz3Oe8WZQ5iQZRo6auMsiRLLhdsoocqstJ2Vg/OeeZWjrHsz4ALvpKKftZT0FATMREBudYjkh0WB350ng6u5MuhksS1BZeQOgdUVLKDfvjgx0Y9xyat9N9MaVB82DVdO8ME6yM8D3KNgQlx9Kq63ej5h2SHhrjxmEeT/pkha1vOwtzwYmMXxSSO/7lEnRZLF3mZgHQAJjBgXj2u9whMlBystBz0dPjA4ecoEyoB2NxSeJc8WydXo26M3iMzxVknGwOlU60xpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9SMUWNoeBnq9DnaDbs36me8Jucx26lo3Sqtlu/pFB0=;
 b=a+WwC1BAHkza0Z0lWa5Gtdfvl311ObVGD0PixVCuaysvjFXRI9docz/0VzJkCHgvRfSiguUBfUN7FiTEem4tc5WkZbg63L3IYeHnBgd64K/vOorkmHBqoc4pQ4NBTnkqUgmC7dmBKnbDj1QyzlRURNAtizXj3YwlchNwHA47YvqLK3vP4olQhdCw2n6GZrvrN/kqWOfKdPt5IShciVjk+G/kri7YHh5lcShJF7C1+L/F0P/Yw+dhTZiNvebGVprQLtyMWNCAEGEMDxJr/zor6nbcUp0PvogB7dtrAqMNT+XCt5jl0LHcJ2zuWbmVDhns/3PvC9B+MF+cLWnmiHG1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9SMUWNoeBnq9DnaDbs36me8Jucx26lo3Sqtlu/pFB0=;
 b=BGOITwABfR6aEZnDbS5Y2Lc8zwb18+CiE/Q47pN0tocpEArrypGiAv2QRLi9arLHowFwB85IfiILAOyXDy+ClTodAjMr0AfbzpnB5a6QKzGXPUPgq05Ak2f3d9qVqkbkoN0HqULwncoEHvKfbDw9ma1lkVCKh2Vfhn/KnkcAcnqbSgHGo0hY3NwE9yKuM4GE5mJzADt8s99MHP0dkzArS7ljX7BdqYoltLIo7AiN1NLaCgovXfdQumWotSzNDzH9ciQLKXiQzO5NI05F3RuAgXCsI/a6b2QHSBLZ9IHntowMNU0IKMBt/dM68EDrRprAyls+/OYj1zOAwkRsagaV9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 11:52:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:52:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: timeriomem - Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 19:52:42 +0800
Message-Id: <20230705115242.54285-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e69ba03-892d-4d3a-f8e4-08db7d4e5dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+awc8bJ+enK2InIglxC02E5qN6fUhQaK5Hfv24IcxTjsVWpeu+BQgtMnvIz7HuUrAhJj0sWcXAwp6FwA2UGQgBVe1bj3cMdP5qFwf4hX/1q/UATYuEE7xHMvjtcT5KL4gNU4ArPMkausZGtKz6PhwtnfE/fmFWCr+KzHR3TfAq0cWIKDMN3ajyoW8vM37rkiRNCFv7yKkvmhbH6uQf273yfspW3jUvGCjN2IbDNQhUylXr6n/yhX5dJr0ZOdYASqZuRglJDVBKYeIKEWmFabJ8cUbuiNSysqYAelr4iSVzWiGpAUnYGKpV2gmqpZRu5eRwIftTzxHSzzntV7MJShwacP67X/dYfpSJjPPWmBEFBt62V90Wt7hvzbRHlN9vX1NpA4+2Km/Q7gOW9cdesFTvidB5Uo8OD3Amjwp2guhymPCurxwSlp4/HicWJNQca4yFNKCHazegXjKcXtYnzOYoJ2ZrO8ZwT+FPPcadvJCb3+UpnmytaLUBUnBGuRPLNe4rZLis8/3JDugo5Q1UBe2AdUT4mvMK1kBGhK32FrcDOuieRQ8HwwCJg/Sb3FwZUt/3iO06jR9V2fWyXFGI8AVnhSx+Dp64XTXzFHk6zMbfo7B7DyTQHFz7BRdH9VyC7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(38100700002)(83380400001)(8936002)(38350700002)(8676002)(186003)(41300700001)(26005)(1076003)(6506007)(52116002)(2906002)(6486002)(86362001)(6666004)(6512007)(316002)(5660300002)(2616005)(36756003)(110136005)(4326008)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMbulTqzch7IxmVD6LZVBKcYsrLXzqMmMz82oyzAQY2fO6r+qmoey69gC5DQ?=
 =?us-ascii?Q?RCpTZhZLQJM8mM/+FPmvmhCQdJHXmahe6azrdo5lGZ0X27Q9ZFpvx55FIopH?=
 =?us-ascii?Q?CVxOFFf0cNId6UfdwAm9zQBn/2M26otUl3gUVNyMTBIN4SOQ6fZTZ1GOtZ0F?=
 =?us-ascii?Q?CHmoh9mK4HVwK8O68Xhb/SDOS+OoECCFgQaHBBOneWTJxCEuK3hXk95TWmTT?=
 =?us-ascii?Q?3VzKwCbVsylKGlqv0r6iqddHh2nLNheexiLGsUsbkxcy1c2Cj/+Bf1ppEgtk?=
 =?us-ascii?Q?KbpVBxO/IV95xdbc56CKkjXDMuLj9BPcEz1rQpw/FYX/aYEWDq+Af4g0mUzI?=
 =?us-ascii?Q?0hDVR6SmvGPktWhbm1oajd1ce0CN29FEMHKGzK2FzP2Q+B10nq9EqiMsWdL7?=
 =?us-ascii?Q?HcuDA9XXnuntjJQMfDdt7Wqu1lL9/wjSBxAEAJdj6gei3030jZVFypbUxuX8?=
 =?us-ascii?Q?Rr2dox1EqPzgvt3hga4rMyP3c5k0SyUJkmaAsfZ3l6weh/VB6w1X8mVy//Ct?=
 =?us-ascii?Q?39ZXr5Iv2S3v1B3ol66DsLDwigUaOSrH7/ygWux6OCwZjQTqmXeoB9McTP5p?=
 =?us-ascii?Q?gioyCrrKLZFRlXj9RS3F7LdlSXLBfGMr0VLK10YhivmM3RYbpuq/T/TldPcJ?=
 =?us-ascii?Q?JbKKUvJ7DkYWe6jJtjVWxRx/w8EVDKNlbcWsOqcGy6QnlrPjDMyvAwXuM+6o?=
 =?us-ascii?Q?A+/lomkGSe5zyPcw6r3AFDhiU3KtDAYKMDzZ5m8IreMNIkxXB1DNdoKP0U62?=
 =?us-ascii?Q?EAyWgaXzTlVdTt77KKOSOtBw1hXq3oVwsvXUKt3zv3fd7II/O6Zpe2vCJeo3?=
 =?us-ascii?Q?GCMGVoJEQAwifMzNsdErFqaexeSFYbQmiRASGNG5Fw2H7IUTUqgAAJV5n1NU?=
 =?us-ascii?Q?leQoxg46eFD0awCZrElRbbESSHYdx0gf1FPBV8j7S8s1pzOUBtLJX8iSBSPt?=
 =?us-ascii?Q?aAMLQP8E1rfQxBQ2f0yp6RGs1b74Rismm5jykaLDKYo792eG732T3kMXrXlU?=
 =?us-ascii?Q?EeV9bB/U5ViXOXvW844tdZ/3ZYBsWDuh1UqWGS9QQmVqlTZS2KnbzDbHI6dD?=
 =?us-ascii?Q?+zP2eRjsJdDT2s4PR8n8KXIB177HfeG3EwKRXbMdwPcF8cV4iTMlscTYqeXl?=
 =?us-ascii?Q?0Lll3IXW8LSvzxAR75zz/oIK+c2UuSJx6tKP8Z+jWQjrJxQs2DvJmlSjKP0C?=
 =?us-ascii?Q?GzkOKLZEbARVUhdQBZUJEv/zkng68H3GL5mMrmCW9AlAShhvCYMq268769mp?=
 =?us-ascii?Q?iFo7bcMDfeZ+eBJlq3Rc1jITsu60O3Z9NsiDnVJIec3k/7UHWwm1m72u0jQO?=
 =?us-ascii?Q?3rVUViVpd2zg6EVKnKiLOVCDd5fJoGXQprtHzUmpslh6A3zQCFcOs+TKLe/F?=
 =?us-ascii?Q?1wh2FUfGfxAoF3NdmuFx63AjL7wq8NXftyKr4DSPHmlqAz/arxutHAtiqAzs?=
 =?us-ascii?Q?DMujWAGE8VbX7MCvUNrWYPWKm9jrmZE4d4f+e1Kw14aEZEUNNyP2vkgq2Igt?=
 =?us-ascii?Q?dopDtx8uY0oyGoESQ9YInZ2M+YPemFGnBJdPTolenhM6O2VjqB1KeVYjCoim?=
 =?us-ascii?Q?W8wRFHfPWGXNszsOeMysIyRe4vXF1+CwJ7U1IhMM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e69ba03-892d-4d3a-f8e4-08db7d4e5dbf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 11:52:53.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqvAMdTn8Vs/UUXKWkuYWI5i9rfc2TT/eeUDJvSo3DjOlvS93R7IiC+w7TBb9nk1d7CdhOK3cDSeSZSw0XkMCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/char/hw_random/timeriomem-rng.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index 26f322d19a88..3db9d868efb1 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -113,16 +113,6 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENXIO;
-
-	if (res->start % 4 != 0 || resource_size(res) < 4) {
-		dev_err(&pdev->dev,
-			"address must be at least four bytes wide and 32-bit aligned\n");
-		return -EINVAL;
-	}
-
 	/* Allocate memory for the device structure (and zero it) */
 	priv = devm_kzalloc(&pdev->dev,
 			sizeof(struct timeriomem_rng_private), GFP_KERNEL);
@@ -131,6 +121,16 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	priv->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->io_base))
+		return PTR_ERR(priv->io_base);
+
+	if (res->start % 4 != 0 || resource_size(res) < 4) {
+		dev_err(&pdev->dev,
+			"address must be at least four bytes wide and 32-bit aligned\n");
+		return -EINVAL;
+	}
+
 	if (pdev->dev.of_node) {
 		int i;
 
@@ -158,11 +158,6 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
 	priv->rng_ops.name = dev_name(&pdev->dev);
 	priv->rng_ops.read = timeriomem_rng_read;
 
-	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->io_base)) {
-		return PTR_ERR(priv->io_base);
-	}
-
 	/* Assume random data is already available. */
 	priv->present = 1;
 	complete(&priv->completion);
-- 
2.39.0

