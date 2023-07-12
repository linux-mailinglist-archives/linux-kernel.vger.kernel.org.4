Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F302774FF36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGLG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGLG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05431726;
        Tue, 11 Jul 2023 23:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa12cQVy3qfmyk+MIBzJoPT7b/T1ehW3S53t2UQhaDZkA2gq6/vTUUOnX4J1a8El2fDBRMJWYhRLntu+jLG/ThldTnfhtyslHcHiyo/sCmvHva2VOnupRHaCLpEW1PWWEFKsHHlqJZIPjzel6/pufqxu9yhFtKisa+tUx/JrXsl5q89CKtgrvwXXjsevIgjdX9ouMe+GB134sEQop9wPA/WuzwPI5vfgVd0MTMrW6q3cF8NYsP8o7eg3gJi25a+e10+aZVj+ZfLBP62SrUGUBplYPE+M+ewxaYIHf3ZLXLRr2+GNQG+e/iA9YW+Xc6mlGFG8ir5A00t9/V/WLLPERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PFUlov9zhAF0HfbeF/uNM7Av8vzeBAp49doKrDhJi4=;
 b=T822QeQ0gaSDL0SckjYejv8NvHy/D/Z2X2q0po166krwda5lZhofAceijCjSXm1s4M1Gp+pcv1on2HabZIu5lhp5tPa+j8Rbd10I9dodVM5frNR7NlKKRjJHeXhOZKwXDKPdMzGEXazrndwUAnwQ9L1rmNnHCL5KYljS5gPEwx3N7wdFK+wLnc2FaEM+Obql7VS9jrWO1o5iSVbgmT05j2ysAnajlIxbh4WfVGDKhpMYMLMWxH4BynW+vWd7paFIMEMv9ZleGNz6nALL4WOEWit0kNb+d9kiYW3fIF+orxBNiItN1GkfWl0Bfxp1SUVh2PXPIuIAbrp6pEZO9j/kXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PFUlov9zhAF0HfbeF/uNM7Av8vzeBAp49doKrDhJi4=;
 b=AYHXuUyaXRaAlZlY/faUz4+Y49WppsTLT7a/0l+QFQk4MYIRRxKy1hL/AHxjxy1aONa0M+nvpuY9ggwmY3cX8T7tvUXtQr6EXC7sduWGwR0BYO1o2lehVxr+oYgABUQy3DyjpW4x2Ds8RKdGRYPL91IVST0MVyajw5FgJ4XA3kv3970qa0QzBWbl+fQSmDOFcdrLYL2hNjwL8MnSWrUjG0u2DmjO0ua+PI8KHOUS4jx/RC5r8rGTia+wwMFMJYZIuycMl68By04mLpIugU0YUEw5tzhpAESymu5Ql3zsC2BLPAWBNhpW2ppqR1eBjQB4Wb0SSyLEYo7STXJryhKXbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6672.apcprd06.prod.outlook.com (2603:1096:820:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:29:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] serial: tegra: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:43 +0800
Message-Id: <20230712062853.11007-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d294eb-8e0c-48f1-f4f6-08db82a1511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBkJuTuiXSzj5jmqnvzpH3Sqe++qjdZRLLI4tC5k1F0aDakG5yAagsRKsjsoU1YGH3hC5HA2Kvs8J1L78JO3fQue6eV5ShbNCZQ17WN9hi1BuBMT0Oz3faTkcbhrCdVroRPYNZq3VS+aJzs9jOery21Q6Llt6HJOtWYQ4EoY/sBS8XaVHrUJRe91hgWeZAy/hkTezoQq6pL3kALbM9sNXKGOevkD/aMiuV+YESVQbaXTKmZCQT/AHeZjxOABfdt9r1ZJ8Yc41M8qFHAUbYerxyJss+7zJof0MLQQHcmb/VwzDPepW+KZFUv7lcM70gZQ3EmasiRISu8Dek4EvctgNpJFrm5CmWiTBNBhHY7uim3AV7BdIoiRy935Lu+Vl1I4rB8u5lJMEuIqFtXJf8HksodhPOEE8ZUv2sdA6bhXfYUec+a56iY9oqUKsgHurHccIq/+tejppvoNE2Ai+qnqywax77c+Lp3O/PznY41M+Ht+a113IouGcA9ZO7F6CsgSOlQpuP+Z0zodTPGYiAq6HZkHbrGGITZkKRfFUw93flpH8vtug4xWgxVCkOR2rtnLZBI1ulVT1vOZuiovm9bJNQpqqX9O9+KpVJ3hqHC3ZFxFSCLVynb+CgpQwmeTrQpa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38350700002)(38100700002)(4326008)(316002)(110136005)(478600001)(41300700001)(66556008)(66476007)(66946007)(5660300002)(6506007)(8936002)(8676002)(2906002)(6486002)(6512007)(6666004)(52116002)(26005)(186003)(1076003)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xj1qsItw8I1i88YKPIcyib7NJ+1axSBB/8lPKh4vrWs5h2zR/DLP1jr0uV6C?=
 =?us-ascii?Q?Kdw+qDNzx869jkXoIYhUHQKexDnnI/chsM6O+5BuW4YCM6AYfF5Y62Dxeh9C?=
 =?us-ascii?Q?BxjK08tuZ7xmACxUCQXoXBM8u76wwmsd3Mq2YuTgGdgNEnWa6b9+j4IyBOFL?=
 =?us-ascii?Q?GhU6H2uGHh+5G/mZuwcHISzrgNeSTZ131qEW3mJHP/UxvIs2wAoocYPVZOfp?=
 =?us-ascii?Q?Um2NjkziLG7voIfQRila+KN+8RsP/451kJrSn+NqpL6u6pgvsRtBdFyYcuqF?=
 =?us-ascii?Q?1XcccfW2fwv6aDRGi+EhDpo8zAEkkBij4HhuO6haXGtDu2sLPKnjx9373sVf?=
 =?us-ascii?Q?tP7VPCVAYKCIYtD1ikXoWbCFuRerXMt4pv9GANc7oCm+xliPaqlZS+URDNTP?=
 =?us-ascii?Q?o8Pns+VCoL6KvXcTBa//xUetjmDYS4S/7b0AiicKNk2WMw2CuwLqKUXMM7Gf?=
 =?us-ascii?Q?+AbWLrQIL4W1PTz1vQCAJ73GWr9bktqUni9jmf56gZ2Js7i+ovQOjnjib5W9?=
 =?us-ascii?Q?duVsCzNCHFQK3cP6C12IHAhuSp2Jwcag6g/MtHMHvfHOkHjgFbt3bzRAUFrL?=
 =?us-ascii?Q?UUB+iwLpWyqlaB+8PeZpG5Ghb8ty7eaqvmQxZYt3lbn8ILjFzz+U2OvvZGpq?=
 =?us-ascii?Q?rXXCE0qrgXAi9G7WIlORX/6A+Tli8bdNMvzhxIxUwWZYMgIWHNYVXNw9kFTp?=
 =?us-ascii?Q?SmzHA3ri0hy5tEZUW9xWqglhRNIoyPipef8KeaQrCg8sONngnUqnXfemkBGQ?=
 =?us-ascii?Q?Dxfo7DIB0WipJ8kx03IBxWSw8KiaXipV0m1e5/rrt++HW58WHL4gkDbpB9TP?=
 =?us-ascii?Q?M7bvR88h55YTeZtl10MwVhJTV2IctaOg1wj8bOrG3V1QiJQsEkOvTvLUVitu?=
 =?us-ascii?Q?MxHKPVVAaXCQzHH+mEhE9zCoVPz/1bSgSoH3oVy3uypUQV+pBqJ9Mq+kLMVO?=
 =?us-ascii?Q?CEmC8ol0NaqNz2lOQVabIqYgeRLwDGTIdK+Hf6z7Qpz2xyoNhy0CvNL5nLY9?=
 =?us-ascii?Q?tkwTQh6sHigFv0gqzdQ246HfR867uvf+usDo6IQOdAyymYfoQkJxRshhCtNp?=
 =?us-ascii?Q?F6EGBeFu5z06kmHJBG02SRe7d9Lq53nUyHBbEqYYCk5/9H3bed7XRXbOpsq7?=
 =?us-ascii?Q?suHX3uny6snWc2J0i/Afg3bmgZowCGMEseK887tfrLFj8sLkGIWibLNwCMtX?=
 =?us-ascii?Q?OII9dA5NoaoHPCCqVr66rTzSu0FIaRB+q12TJJz9B1Wo5xm9seIuq0hcw78c?=
 =?us-ascii?Q?08YG/0PjF5UsN2bFQ91X0xMlEOuS8WF+EFYLujKWyhksZi6nMp6qi9GBAiRr?=
 =?us-ascii?Q?xRR5glN5dJApcnUeipjnSnx0+wqW+E+CxWRgNWQuDDdWWdzcw7UIcPXKuGZA?=
 =?us-ascii?Q?TInYAa0sxsEdENhX1iCoVcLbgCNa/JUGkx0nN94EBFqurE5GqGo2GK2gVbP4?=
 =?us-ascii?Q?N+D5uWHAw4MM0RZu8UYuWkfQEiwTLbV67VnOcSR4rIv1a0a002fEOUO/gg+N?=
 =?us-ascii?Q?/qSxix7ngDhkdv6JGyMSmHziUmk4+/0p2vdc4k+xYW1P8qIFeKx1zJ3NUtWA?=
 =?us-ascii?Q?eLbeS0ki1HAgjDc5pvi1lGaC11C3TRDXhlkmxaXJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d294eb-8e0c-48f1-f4f6-08db82a1511b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:16.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAxnpdcOROZaCWAcT4xH4F99i1qAvdDW+65rlQOkwYUh5RAXjpiNamSbWVdSi+yH7jfX+uFWvO9dSgA2mghJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/tty/serial/serial-tegra.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 1cf08b33456c..1edb4c381888 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1579,16 +1579,11 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	tup->cdata = cdata;
 
 	platform_set_drvdata(pdev, tup);
-	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!resource) {
-		dev_err(&pdev->dev, "No IO memory resource\n");
-		return -ENODEV;
-	}
 
-	u->mapbase = resource->start;
-	u->membase = devm_ioremap_resource(&pdev->dev, resource);
+	u->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &resource);
 	if (IS_ERR(u->membase))
 		return PTR_ERR(u->membase);
+	u->mapbase = resource->start;
 
 	tup->uart_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tup->uart_clk)) {
-- 
2.39.0

