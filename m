Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF4747D89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjGEGyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGEGyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E51700;
        Tue,  4 Jul 2023 23:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FptRGBgYmiVQrQro2Nyd4t64z1+KbMtdaenYXkEp/qpbbE023sGvQClkj3rvrvB5EPVA8k3PzayzypGKbiCf5HUi+dQcKWrYN0rYeUp7ekZgCEve6dwa41QVUkeYZAIF/g4u0cYZsEeDT/WJFuS4aNJxqbtmuk4qHAeQ5pb6rjf/QFFvFiV8ZzFvzB6GpGaNMRcFVZYe+0pA29t0Z3nhYUBcHdw8W/eGMPydMPdzuqjxLJWXGGl70mHtuY2nfgzotXiVmBJtOp1voKorUEXrzugNlUwIQfkLb2v6GS9mrsz8JY3dpOxtLltt7t5USL/jbpgRYbj/1H3lMk+TesreMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw6gJMrRLCMcYi1rZm+II0m0vXjAMv8iB91oC9kBuWc=;
 b=Q8Osx20jquTcdpmRNnxnP15cPCCyQI9KoWXCvZv7dJ0FCvBSWXvijks9YB3wSJtNFL8d2oEI4Duqd2pF2aVNE7zIMMiHRk2WfwNBAArEz31jqdSC5L07siurNs01JsyMCWkl7cwqSzuG0iTPxgu6zT2F+K5cYGEPn27WAM/U0YqZdXqenDSVbb9cce4Gy3FOaOMisverR5GNLdR5ytPEo59TAWVac/hwBOLstNUne41fuKfor4yGWwjZcU/qms57HnHmizIZhDakkLJCG7fRmefJFQuEDFtKqat5SXP44gEpM0NP4r4t5kWp3tzGLAd+OzTph27V4ihw8Zef+HYrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw6gJMrRLCMcYi1rZm+II0m0vXjAMv8iB91oC9kBuWc=;
 b=bbBg/bX4YgOdltjr2ixOrwLtXrBO8SYkcbCeMDn79vizyCziOMPXVKcy7EhYRDyqhDamfAJbmp+Cee0Yoe1M5uG1nBQ1jPog7tnM7OJch+bGYU978Z7jQ6vhrE76aNcwXndVwKt3OTC1bETV+HUohRKSy5O+7I3kKMlnz6G1m9DF0ym2+LZxFSAPMCvqcH92CJbzuBH+y6cAkUij74NTZuHG3zZg6u133DeL+mLZi45u5CrnrwKFhNwB2rGqczbanwE1pgfHFLtXF+bWrggvdDW1LbxibtzHMHNTx/G2MJTzWAkgvjF2Rti1VaGIcgDhXwtmiyJ5s58sI8HnWvxRtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] clk: gemini: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:06 +0800
Message-Id: <20230705065313.67043-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f694af3-16b6-4829-9ae9-08db7d248dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVQHWG7zMmegpRxMt6AVKNDFbCj8MMJPNx92ecP/rtiHQRwrewirRho4phdw3HhKn5rL4OBMtkhgnCPeVRW2xZYTD68/UBn62NM/1TwYnKhZefeTLxU4gbmncuGabFvGwMYa2FBnAR3HE3/rsDxCaZZKct+wlfyAD4t2lYPFPBNBwT/E3Of55h++1UeBOZR7viatcPKzpMK4wll87zEU1h2/TjcyNtbZCE1BNFGnikBk1gDYfxNHpMrA1Hupnz0sFw+yjxqQHFYfIU/XvOOjfhCCxHtC2aVxLvsG7hg0S5M9bmt8Hd5BaAFsU3yA1bolTTeR4evnglNRxOENJKAmNu3Eqq4tQs+jHOIBlAnxUHkHxejjtMmioFkd7j55EaXAP9hTcSGHRhDqSTUN+kMWF0tEN6wIrAiQz1GwHMHKnk8FOSMxCxc14TZbLVaj2dYT3zMoQUwZ18EY8VRla/BM5w34rmhTkuqo0gLM6NZM+udvf5sBdBqtOCjXHN36+k4Y53bZqG5Z4xEF8RHREwhsj3QndXI5ISSGSt2zgaPzdein7zVUbFuvdL+NfENRvAJnAeDANBM/KEFqYFTu7MRF9EFKPsInP95RPvSY+REZD058XezDoAoknKQ3gEe+XEsZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pd8fUtAo+FeWZYvvnZ5yxBxDePoQIK+CQmru7p1J4K4VQ4ZTMCjkMdnK1ZXt?=
 =?us-ascii?Q?HUlyemjXKQ77uHMfqW6jinsuHRxy6IkBZSXX6fG8g6bYKYMAkZgu+698tbUF?=
 =?us-ascii?Q?MXA1/XfKmnwXa+gjpRv3AO7OJfzNlp0wpcxb4uyCWFBSU51kU6KVwioBkczq?=
 =?us-ascii?Q?N3bmDfGDTErrCNHYRZSvw4TfsXwazvrzqs2ZqJJBvbQD0HDrMTpiuAnDtpOm?=
 =?us-ascii?Q?05nuZPI30A3JeVvgDDILJj6Fti7oN0c6WU59yshxwex/+QnQWb/ydELfrxb1?=
 =?us-ascii?Q?jhTg7wjubqI7KA8ksVWIfeeXrSVpuG1jAPJM3u3W7H5bj2CCxNKQM93t2d6+?=
 =?us-ascii?Q?W5DiOVtTZnCzFL0bpnsLxSbtX23j+LFtxyfA/w3PBH+HFNDfzTPObhrOB63g?=
 =?us-ascii?Q?1UsBzIlWiiAxWYz+FDUCADjexVbTWafkL1HkD2vmTzxhBNVOiIrV/gR5U1aq?=
 =?us-ascii?Q?wbLPz0Td2jJP8aUq5ywd15SVk4d6E8d0slANmrlsH+41L188/HMih7Gy8DRl?=
 =?us-ascii?Q?DNlSZQqISz6WVHF494eNgmY72MCYGq7Bhv8xdAcwmKH6GHpwm7V5ggQ44DSu?=
 =?us-ascii?Q?ZXFXjGZ99T2+NOGaNbSdDv4q7hM7BIGZAKvHvIgHvjJV5T01qwxnIuwfcbtN?=
 =?us-ascii?Q?6wEQMoC4LqWUYA6v1J+Bsznqk+4ahyCQi45QyYZuj8sQhATjzdKDXws9iuaX?=
 =?us-ascii?Q?HHizHoPXlNa6pbTb1rU2MRxG8rRuSsACDUEzr4hZUdPpGNaTBzAuFHL3t4+J?=
 =?us-ascii?Q?3M4qgLLwaycYr5patlUtK2064EjyqnaUyoJ/joHeniPL/1IxoAYMVV5lPowu?=
 =?us-ascii?Q?a8L8UOc1zhPc9ygUfeCLzZeDsjuqaxJzrZStSbBnsIKF+Qi3pFJVxFAYgp20?=
 =?us-ascii?Q?WT67ZegsV9t4/JpTPm4O5uGhlGbNmXHon/+ZE6s8Ckp7C6BiWW+o09w2Mh2v?=
 =?us-ascii?Q?pQwzfFJutnZ8ThCkVLDM6Uq///DhJot0gWLw1ML/dYiUYIrW5NHfcVJ1SLdi?=
 =?us-ascii?Q?FiDRdDlul1jN8eWwsdpsAuqY1AS61x5uQx14iwC1BIaIB9d4VrFvSzJY2MnT?=
 =?us-ascii?Q?vT+yWUwja+DEn4HWM+xTHJQqMVD0LycPYDEUr9SW1k8YiIBQ5OGhFvisqU8b?=
 =?us-ascii?Q?xApowQp5M+kcuCZWbKRQNqBu27C6mLXZI+zUT47gEbnu/mO8Pit3MkmtwuVO?=
 =?us-ascii?Q?wNLAywJIgbPfn6NlzyosnK8duWu2O3mXazetS0Dz3mvok/DTavJfiqRzCRwf?=
 =?us-ascii?Q?e2eGhT/3NaYXKIXGlr+f3KPRP1b+HXA945d/piKG9FQyvBard4Jr85/czChy?=
 =?us-ascii?Q?+wy8H1+P3tDHhwNXZIgbxTJMAIoo1m8Br72choFWMgOKcFcoYmCoJRfRlNzS?=
 =?us-ascii?Q?8hvIYzfQ58K7HoVpLnuHtRGqaMYkljt28XE0mtCMEiARtTo3qAhVxh+PRVoY?=
 =?us-ascii?Q?A3B1ky3ZUm0qZK/lD2iVC3dn2VxUGqDYZmUOk8eN818IPTRQ45rRnm6TpnjS?=
 =?us-ascii?Q?JU+EfvzTBvYQ+A0PcKgHUVo9t54N7n9N4++gYm3AVWCF1Ayh/bKZIYd4SLgP?=
 =?us-ascii?Q?tRlqFDrncBMhU0WTFcVi3F46dgrvW9oTnDFdkdgv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f694af3-16b6-4829-9ae9-08db7d248dcb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:35.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3s5TQ1TDQH49g8tYAoaX45iCuv17JLbtcLrY1RDmW0elFW/ODUryZkzemjrCieTEkmpEfbwJMzObo6c/wtUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/clk-gemini.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
index a23fa6d47ef1..4a085b042d22 100644
--- a/drivers/clk/clk-gemini.c
+++ b/drivers/clk/clk-gemini.c
@@ -276,7 +276,6 @@ static int gemini_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	unsigned int mult, div;
-	struct resource *res;
 	u32 val;
 	int ret;
 	int i;
@@ -286,8 +285,7 @@ static int gemini_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Remap the system controller for the exclusive register */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

