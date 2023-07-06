Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB80749C22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGFMnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGFMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:43:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455B19A0;
        Thu,  6 Jul 2023 05:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1NpHNjnnrCYQUlmEElYQzJHv+nqqud8+SVvLsLsbsyQFEY5b0/KwjMhb+tH7bymY9oVdnHAO8mNj7A4ahC21bPy4G3T/IeF7I6c3ADcQpS8FDBvuDK1FT7eWsYpKm+aeFysyvfYQ00ZWoE3EfA2+yKjEe1O++PWalyFdt+cE0WJy4hyj4OoGdtMF6iQm3grObxoEKEgxY0A5bKj9WWs9D+Nuty7QvcT6XfjTksbm1kZteDZkaAYBxDiXUUHLbWbGCiiDItwbbFNje9cIYAunMJFbveEEnY1uKdyoYOmQLbODBW9eSVXRyoL1/nyrQZI+Tj6XoJM/cClJibujE6u9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJiW1igRv+LBe5v/RIatfxmLK8I3x1ONgFtMNsOZQ7k=;
 b=LOQBIZJiAF7iMwM1khYpL4Jr7/Gvau+Q/sqkQL6Gu2kNgkaPrKmt/YK24+icfCGRfCeD0FvXheqTrr1Rt9LinprAISmzn90uxa4/tUXAMzMd0PtJddv8MM3Og2g/exNPAKNfZEtsYCpsUeHj0n5vB6ix0k71fHEAABoPQxk+wHFUGf+hs9uAKXHmUsjggZkqmgS+WvdMqQ3O+I8KfRDooPF+R5zpEJuZkwN2bfiT9fx7hVK8Dor06yaALB8csPP/SOuGqDw0C3h5SVNFAiKXIjKmnXfYfIwmxcfZCck0T/1k12lB18Lx726NbovylalZqyjlCFIWavxmAXM9NnAzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJiW1igRv+LBe5v/RIatfxmLK8I3x1ONgFtMNsOZQ7k=;
 b=LS7Pyemthc9XT5i9F3nVo5XC30xrffaf6YydCjZLXTqFFXlQkqOpB6G9ruUZds6pMLnJkqAAaTaJViRHKytz/mIlmhv3UlmoXt1RSnmyplEYhpn83yUfQ35HIKJZElmuq1WqMIowwLvZy6rwgv3c5kpW1HODWhI0ODlYEYslPswt8lVzuJtNPDRShIOaRsXVC2/Q6R1AEQMpJQ5gJ+xKxfyV4eMNu6/0O3A2MDcCk+k6PDN8DXqNKqTbhwh4qFDLKTFNs3xOBH7bDXIIw9Yi4pu6C4vo/jNDfDjgJoIG1MFt4727duQpiAjCgLZLauSxndUkyM5Xq8GPQEGEQttvCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:43:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:43:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] ata: pata_ftide010: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:37 +0800
Message-Id: <20230706124239.23366-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706124239.23366-1-frank.li@vivo.com>
References: <20230706124239.23366-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 033ec746-bea5-43c7-e667-08db7e1e88c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBbbtyu8JEqiPXRziPmex1FugZocr3Yq99I1Cox8vWp9vT5UszmoqTvCv2ynTQ2sFcf4I74H4/gO2z43l4qQbzTYyO47Mboii4eNCEjWxIPn2pIAMohdZT5I1AuMZO9kkCQjk7M0rtjLM2fvFfKnw1c9ehTUUVmlGU1eynkmtXoqvkDRQ19Ff0kZYORkB8T7tin+s3OfDPu6glkv7EZB3Pa2qrabayWY1lFc57GKP+slHFVdg+luvGn2j0+3cDGK7TYNQKd+jIaict+o9t5HUHrJkqpjHmYqMUZogN4me6zVoucwut+tHS8r4Li1ULnlkViXy5ZTYvEgrGb0Pbup/B4hJ541OwqddzS2Zp5hW8nxIyqE0j551NMb+h42OOCx6pTGKDR7LcpO+Xy0dN8/+EMtXz/CnhNDQqSr2VqkTvBXRhS/HhWws0wbLMtvEQijkDtKufB1SJ2T4ttwzhuMGvJMvumux877UxRD3vQ6XeaS6uUdTs/PQGqDhd0hzF+SZ9mU3TY5gM4x5/F3NQsa6hXPB7XWZD8iROZTkzaQtH6nSt1bx5IwXBiQWmSZJE7vfqiD+RTn4O2IZWpNvRRfLlSYsz3iXNLMvrQWJ1IXWV4BxufZTw8gYSCOuyGgo+uL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4744005)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(110136005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BgPzOelxB7DVL+pGtURUWj2FdSoN59/1MBU/fsp0bsdssNewidCt2FJOFSfG?=
 =?us-ascii?Q?d56KVJK2SamG3/Q0GQCY76PYevB6fUdgUDf4xiI2r1Y7Nqt28+5mgWi+IXcX?=
 =?us-ascii?Q?5mgke3L9dOHqU/2awlDope00EFsRIlsZm+H2sQm8DZLuYyvXjF30z9xVOnYt?=
 =?us-ascii?Q?R8OYntoWoOPrNx4k1bp9T0wZ4r8aD1eWlmFJA8qnDpBeDoRs9RULm/nVPnwi?=
 =?us-ascii?Q?/dXcsDKb60FZk8n1HdNFnVA5Is1FHjPsz1qj+EfRfUXKM42+uxsNwWrK+0rt?=
 =?us-ascii?Q?Eh/hBCBuyL+V9E15iPR8RPlp2IZrJu8j8NRzPamVx5CjMFTCqcXney4YTVR/?=
 =?us-ascii?Q?AaTljAiKAoQJ8ZWZhckVgnVTOdINa8uvUl0C93UMDg2KZFYeCnakpdZgv5LC?=
 =?us-ascii?Q?x4BLFXq72FlVdgBaVdT7tAobm8WOd6wwVf+lEgflXJFobG9xdY2YrLiYAOh/?=
 =?us-ascii?Q?ILYPLpGAssImVYzgoFlQS9dcjEsSFdgXk4NG0RiZqeABk9JBKafDFmmAgPW3?=
 =?us-ascii?Q?9DiKjTf4uVmCXJFS/CkdBYujb2IQJDV4I24rnUHiw9ZbdKORkOHAUIlWDhxc?=
 =?us-ascii?Q?jN9WZ0HIbPjozfTOtM9Cmqrcr4O0jz2r5RX4y7U3AKnk8LP4Wa0KmPMzg/2+?=
 =?us-ascii?Q?Ymk+uAOR9uds3ofq0p2iQqDdDzhroKlN6yK4/Or7UvVQh6ryLcn7xDBz3HNr?=
 =?us-ascii?Q?k8sCAx2ECA1jZy+J69gy8Rs/8lAgeew63Fq9NUSrCdomi+V8dPjWjblyDhYe?=
 =?us-ascii?Q?KthjVmcrb0iU5KTg5Dcq1PRG7H7Xebz3KzSjeUXoJzYsAbIte27Rqo/HvHLf?=
 =?us-ascii?Q?KrXRMf2sMZfRyTbIBN61rnUHqH+1dwrYzq8O3tzN/K1CFgUEVZZSHMW7zYo/?=
 =?us-ascii?Q?HRcvKv6+754EIdIeDWifQAKODQVHJXPBuF4sGgdhEdr/yAiIDcDIiHrz+bEo?=
 =?us-ascii?Q?aX0sL/GCWsy3LFsyWac8dE7MbbTu48Z0reXoL8D1IjpnVQqgHF0OHApmriYM?=
 =?us-ascii?Q?NPOfm/1eGRKYZ0fZ/5DfYAMvQUhY2O5Yss19uWaUtt++RAGVRJFsjO247pSL?=
 =?us-ascii?Q?baTlQitkFHenRxT8MILUih9Vz0+jM6i5mrHbmMQjb8+VusqXRuD8QHNIOvRO?=
 =?us-ascii?Q?aoqI3voBrQ7+Lu6uj5g9yRwfVTawyYaV636L7Z74Uy4ON4Xby31xGHg0BuGx?=
 =?us-ascii?Q?FBYhV+VG8Fvc29exLbw3UlaAzcwijqH+dyl3cadc6Q+JlNf1B+5MuSWMWoj0?=
 =?us-ascii?Q?c2UUgOrh/bZjfIUgLjcIlo5wsZmQzmwWQlqcexOcXFyQ03c0pxd8nR6HC5Oy?=
 =?us-ascii?Q?X9VWTY0r8MxItDD4pjzOxfMJyEWF8tajuN4H26aqgHj+GwZ7OdDQriLlnRgt?=
 =?us-ascii?Q?Canj/hAVVt7iH36Gd6lDaAahJIARY9p2hr+u9ga7ZWEzhJowi1EHd/E0WUxj?=
 =?us-ascii?Q?0QvN4FjRWM+V3Wp8dBGb6KGR0W8vkIXV+GfCJ3oltXWv3D/xBsLC/RmCBJR8?=
 =?us-ascii?Q?OwBw3krBPjw4/qz2eU33bymuVXE04T9eCGXLCC9zCpeUPKnkbkQDYWv7nPOv?=
 =?us-ascii?Q?CAeLokzmK+XbiIuNKMl7vpk5BTf07s0XG//RfMdY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033ec746-bea5-43c7-e667-08db7e1e88c9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:43:01.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NA2KwLnoTWf/MXHliCQgP+Qw1YLTzLwWNysz87HmqbqaRU8Wr1i8YlCt8qDAgQJYH8q0x8KzPagc6GJuvx5SCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ata/pata_ftide010.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 6f6734c09b11..c6f60f1a908f 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -470,11 +470,7 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	ftide->base = devm_ioremap_resource(dev, res);
+	ftide->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ftide->base))
 		return PTR_ERR(ftide->base);
 
-- 
2.39.0

