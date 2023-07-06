Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9E749B66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGFMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:09:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506C199C;
        Thu,  6 Jul 2023 05:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXKnyRnepurAxqwyS8cwGPNkFjaSChJyocf07UNqPfPH8vxdyuc9EBHGGlJbvKXfKkW3W4UaMYz+j9XdeyJ7fIPaWV5o03JVfI3qL6k3Mf6vxOcm44fKloX20wW70iye3Knycs0josY89pyAQCvKkNw7BcwXGHQTdjz5iI5/H3cWy0NIA5b0+S2wY28aLUrcAR/dGkXq4FD5iExrxXZxl1aoI9DxzWmes3g69I0FsRnXIPCxIJ+a7kyewx7N+SmccBQQZmOfe3uDpXv6G528f3GA7vjxDJOper2BUdcAy+rsZofJXeow3bOTudIxRCSFRY6wpsbVkX50Ok78Km7aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QJOnv0L/kXb1i7P7/EaFdEP4hTXsMvzzi3EjjrNjU=;
 b=TKo7YEc0hESNTNTjn8/siSyzyrOGAqSCrrLgpPaZEE2JqeBOnsVrwV5sjVwSznczJezafgN3IE64hSfpvMJtsR8+NstE2wVBuAoxzBoPLjs8k+SGaooTkpFopXxrnK8KxTfG6NJ+XbeMUpQUsvOg0ZhI8nTa82C53RMJDBr5ckX2EETWQN3pkEYSky4ONPh3w2X7J32+3MDFQCSys2VF1Pe8TsY+Xw+8Su+JRZbzwOrXmXi42Oe92fuK1xu5h1lxDU9UL6yl+/SY7pHOEtnRbICse6st0YurH0LM6ux704ssUeT7TNYNjyr6WeKj2bT0qYX2T9OupRwnB2twHs9ZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QJOnv0L/kXb1i7P7/EaFdEP4hTXsMvzzi3EjjrNjU=;
 b=BZXRK8RLOhh2IihiLvgqjAUElp7IjahjPARLNRdwx2FHgbocAjGp/zJhyPKlvVXffU3FAQRYwTDTL81RerPW/U82aQKX14AUXrE/S0RGXL1kTvQxY6xB2ng1ofReufmJkBo9mzicBKCsW0GMJKuRniWpLpEl6090xXKfPBYWE3lbMho72NxjJbgUc89XB6ACJQlD0/BhZoKY/PweN4Y8puZFa/bxQK/L0wFK27eaCoD6l+LGUoAiDARnwtcmP9PRxXC1gziHtD/WfZEodgPFPujE4QuCpbzwIX/2GY+MVdo89j/trRuZLoHsmrJ6TaudgxE/VfPlriRqQVw6oll+ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5634.apcprd06.prod.outlook.com (2603:1096:400:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:09:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:09:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] net: wiznet: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:08:49 +0800
Message-Id: <20230706120850.11026-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706120850.11026-1-frank.li@vivo.com>
References: <20230706120850.11026-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e516cf-3abf-4727-f9ce-08db7e19cb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PJaEBtglH1jdGXqbj+Sr9IUk/dkuaGpMX07cVxFax7QcGMzdsvBUh4zrvnFiOkfSA3M89qcBkWHXXB1OQKariH/Ai0sK4u2di+gMqFrVTMCgZfhVEY7NyQO+P2XgKNVrfE0NQhzgwTxWpzYK5EUQRWDLT4AtekxVTuvvRSYBGoxnC3h3Cr+OS9ZY9rmbcBqu8X6ejojVEhL0zVYziS3fAzd3wlQzaTcgZ7LancjFSwAhG3+nTq2bI1r+HdWv1fhmhlXxMkzFQZEElwfDv4klQHdIx2PDbUR+eLKPyJ7zyMG8heFbgg3HMaRc0HFl7aGEn19pPRC6/Mfx1wm2hlz1tQtXO0MAxJg0J/Bl7j2a+4gS/T8DqjDIVMNtX6b6SLh/OPYvN4OTn5dVhAl0D8YLE25uGqmYz0yqtIPgkhj/qfLWTB5z24Hal3wG/qwpuz+axjnivjmOgwtp1Pguz0S8eLyJmnmaXQrOBuSjr1QDnRi1+AVN3i0bYJNhqRdNHbSp6z2MHFlztpBOFi1pVQVcKsxyBQ7mPoC+p3h5F9fMyyQV6B/7ts1iA8OWXdccFBi77q3Hu6w4Yv5FxkCcMyCEtqKc1uUbpW975M1ijqraj4VmcP0wmX6jnzzV9ZWn/XY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6486002)(52116002)(478600001)(6666004)(110136005)(83380400001)(86362001)(2616005)(36756003)(4744005)(2906002)(66946007)(6506007)(1076003)(26005)(6512007)(186003)(38350700002)(38100700002)(8676002)(316002)(66476007)(66556008)(4326008)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aqs1ByKrBDdPSLRphVffx0/V8X44kDnWkg0JGl6fmRxTCSR3JdQdEZUP+4DG?=
 =?us-ascii?Q?8rsRVMYWvcdEtO1fmr/ouGS+ia3wl6UweslUFKLinuTDP12eyC7QO6WRolyE?=
 =?us-ascii?Q?Ddp/jpIc69aUIEAkNAnoPwiZ64D2UXwnMSiobZYjP4LMtUh/Lu1nPfPy2xje?=
 =?us-ascii?Q?cOSwjaqbpaQ3F0yiqJudgoDZbbrrwwbYtQzqomQibR6L/XE0ksSCPAtTq0H3?=
 =?us-ascii?Q?4Dz4dllT4TtFOpP8bDe+DOenvUn6LiqUxNaebZ0NCGuCdh77t8GBVKtkMSm4?=
 =?us-ascii?Q?r2rWOLNaB6hUS/OMTqPi7VoOUagQJQ4NLX/Vk1aeJ1KrYFgtROsj4NigZk+2?=
 =?us-ascii?Q?WfnABjm0ae+Pk2sIoKmRCkkRv5df3wCER3gPL0RMCogPWYMqEK/dct86jbL4?=
 =?us-ascii?Q?TW2NrtVwcvLS1QdD4mgiJkZZNWEmt5nXaDJZs2NLDSL5DkOj1SjaW3WEbeU7?=
 =?us-ascii?Q?PMQjiOmBkcUZOTQOKz3/Og3M2flAYb11EqtxO1HqnYLCUdOf3WV1MVAKj5Jc?=
 =?us-ascii?Q?CWrnLEwdCLwVTyw0+wI85qRfZ9dIYOi1vTvBCvg03oLWWnK3Kv+jG8fa9IRN?=
 =?us-ascii?Q?QWvF8lpClYEZWeeMZX8UtfRJX6o6fSLClrvLy7nZm1ylXova0hz9lJIRz6TV?=
 =?us-ascii?Q?TJS00Zm8xOM+vV+eyuuYsFDJl+JeZRF4CMXs+rCEBWVrn88eJfKpiLZ2wlFj?=
 =?us-ascii?Q?GbRkANXNwfiUdSAsvv3s4wRlgVw+BU9H+wFg8+m3spXMLNZqNUo4Rpyv5lH0?=
 =?us-ascii?Q?QAKfEpKywKiKvGCz3fPEw4YRukg8YQGjNbZNj/s1RMOS330oRuMiYv/R6pe1?=
 =?us-ascii?Q?99i7HX9AA6pmXOdIpb+fDZp6pSszCVIxQdP2AbEEoCnhwh3vC3jpDHNkauzW?=
 =?us-ascii?Q?4SU2HeOasFkGeIi/ufqsUEbb8Gv1HTnbTfVy87SaI4MMWJsechNSVrBHtoCK?=
 =?us-ascii?Q?2Zm1UYbLoMKVtNliX7jXWX3KpgN5sv5YBuPGtQwwTt/mdHAbFDIssFN9/5N0?=
 =?us-ascii?Q?hR0BYpiOLuc7UIacGS+j+WxmFUXIBqcK7u2lis+krR48B7KrGJGdBeexH/iK?=
 =?us-ascii?Q?Cz0L8R9BNxfrPpjw7kISOJxKcxeNdDSQKR4DMRt+3c4UZwuSJVZOXCA2XoYH?=
 =?us-ascii?Q?db8poeO5HBSNbVmEAtHERI5f5dngVbPSbfrA8HLlZfnfxJxg456JJCvCv1ml?=
 =?us-ascii?Q?qv6IFR3LrpeB4hWRNCks6iUjx9ivqv2QNzVHnYwKMYCDHuwOL9n6avpRhIBO?=
 =?us-ascii?Q?CHGyg+QihyBxRXr6bgj2ZmDkV0vz/XgQmQdrdguXwK/ZebSveM4tzvXJnu4G?=
 =?us-ascii?Q?w0TZT4LFfAP9jpbBMq3tAsuxHcniJPrOjEWD4LXimObxFiLX9vMlyE/7UwQ5?=
 =?us-ascii?Q?mnk6VmrEFLFf/dWUOD12RSHD1kgx3SLtcKrSjCNr0fy/n5zD43f+YerZFzlT?=
 =?us-ascii?Q?aO9WK/fE61jbNo2IIZytrlFuZZl03rcAh+72LlkvXhEjNj6q43NPGus2QW27?=
 =?us-ascii?Q?3rzllncfmNrdnmSZiHUJNHwfzIs8ikIaCn7QI86Sd9zGBhPTtbRxx176HQSA?=
 =?us-ascii?Q?j/9KCZ9MlCpXcPzRgPxAmZwGeWfbtch3J5z72oSH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e516cf-3abf-4727-f9ce-08db7e19cb23
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:09:05.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPoIc/d3V1J8UmxpAI/1752AgwLTJMY9mW1m5ggruZ0QfybPL7UxQt+7fQH70UKAl5oRp/5SfZVXIZiOZ0vtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/wiznet/w5300.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index b0958fe8111e..8ba931c98435 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -539,8 +539,7 @@ static int w5300_hw_probe(struct platform_device *pdev)
 		eth_hw_addr_random(ndev);
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, mem);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.39.0

