Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE87471B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGDMsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGDMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:48:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975EB1;
        Tue,  4 Jul 2023 05:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS6N/hKVwjV+V6BMs7orYVSapdTRrwL0I4IfJb4BeC5KzKuz8vWlAYOCEtlp6q31BCv8KDfD63pbWiy+nAQYqd/8xrvoct+9TKbMnFRvUlCL/yMqewLLzd5nAA7lDpeNYzXe1bZce6bDQwZcOerXMDApzeGCGBQmxxc37MIPZasQTkBJRfB5jD0anm2eFr4MjUtuKM+APWXLunUdnGDp1jwdyp/FY87Li/MEF7FqVgA7SUPnbcUrmedk8E+Uluq+UHf3i9TnI1OdQknn2OvJ5DIEtII12Yq18eHFEJxCw4u3X6aqiMtcX5tS65c6hV3CVO9DurrUYzTaeVtbOF8Geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r95PB2vtwVietBCxyqromQKBMMC2ggg7HLSAR6qVvas=;
 b=es5ZQz8Rg1SRTU1fc/PZw+K726+y7xnTpRm2WR9liYYs/xwhwgWuCxGvRGCarcHpsccjmagp3PTTkPauHHZcnvXE8M6wmVhIMkkvUI4kvAMnN+vcOLAcUrwRTok2OjTubOz4Y42jnGmrOAAZhTFsuRF229YKmUvjuGwMrlsWF6dEwM5r1h7gZdx56UvwB+ZFlmGoVkUHzgSO6p94wevExMMLXdb1RkHU7m9dOjBQk1K+7NIEV7uCTgBobslIgta+17Q/zAStTdP6YxpV/Zpac078hOBv2I84k2i/gt06WDYKR3+Q1qKJaliL6lXPPMvFWHXNeV3z8c2DBqzpdFMUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r95PB2vtwVietBCxyqromQKBMMC2ggg7HLSAR6qVvas=;
 b=XykptRWXdUeQomy1M7opK404BwmiwInN2lJeepG7s+UuDwXsWMK9PwSTNlW9AsDO6tSyyKeZ9xhTZ+YXt+gQJovyujTozIyaHe1EIVGZ6P9b74rYiKFwRRhj7Z9zW5iBsXpBPFAjiRLs++t4tZK8KCXVCTjB6PY9GxGQUQFQAkgqQc4j1fL5wKfsEaCVgo41a3fiJDgEt5NyxUKKXU1qn0Rc/0wnhuguS7SORoC7/VPJm2pwwpTrO+OMK6hWoMVzmyCaRHotsGw4hIXOg1CTSAtnsKm2j0pJO7esHE1pC3hRR1k/sOFl11q/2FFx/7xXRHmtN8hSY4slRVrFvbY4Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5679.apcprd06.prod.outlook.com (2603:1096:820:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:47:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:47:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pinctrl: mvebu: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:47:40 +0800
Message-Id: <20230704124742.9596-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6812234c-246c-495a-960e-08db7c8ce308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3a9WPDtvJJ47h/81FgzCg7D5AYbm8DEr1q1XNBElX/B2WoH1D2sTJerpIr9nw7ZueIzxMN7sU641KkBHXvvGmE8Nt87YPGx9Id38B+cEhk+yy/Tqy8jGHL7YXn/x3WSq8l2ka5FQHjy0zbTj9gGhaVavzOzeyXenAY8f/cd43L8hEjGTQOqOk9xm2f5G8Jl3qw3vhnY81EgGxcA4kwmlk/l61aa1aPKwh7kvkQN4OXZS54c9DQNoDvmzrrnyJRK96XpHh/AOr9WE0qSbIbp7UVFMxPWudBYasFix5WGyVP7LmI22DOVrwz3VATtMOz3GPPr/PsjzrqqhCOtROFxpBcD7qsXM80VUFO0UNCWb48/HYvUfZEM3nZ1/YI9gzepeZgLC6FcDxnaj61qBAqdt5vCsmhNkW8s1OUO+engLLbed9oMXtOHho2PNnotcKmUU7cJdITE7hGkKaqDkm8XL/mxbAeHna7/FvgRD3lr8GP6qRRIQd3ke805hideN9PhPEkoXFRraTOTo7QX25Z2ubUuHAF2h+dqAtZ+TgzGeSrmrss/D6CVq3PrO9O4UEdBi4aUyrSbDUDns6CTqimF1m1Ytw+1tzvqUJaZ/yVx4kdaWUUlzRKdWrdFLPOaDSZsZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(1076003)(6506007)(66556008)(66476007)(4326008)(66946007)(38100700002)(478600001)(41300700001)(38350700002)(316002)(2616005)(83380400001)(186003)(26005)(6512007)(52116002)(110136005)(2906002)(8936002)(5660300002)(4744005)(6486002)(86362001)(36756003)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1/6nqP1yhzEfgChRNvw+47+6eci4s8EiOx80W2HkRVtqqL67uZyImESBEBJ?=
 =?us-ascii?Q?PjzgoT1kdf3fh4hcDDjyC+Npzh1eAdG4Y3PbQQFdnNZXxoNtrJMjlyDnvRNY?=
 =?us-ascii?Q?PLiALKi0XCFEA9WdmKqcyvVyxkCMZVj3so3hYmbtFo0SjtrEd12RMtFaamHU?=
 =?us-ascii?Q?heZxVL+W76qtXDSnge3+w8lFBzeZGKgRMD6pkWCF9m+XuDKWkRwsZabqNY4i?=
 =?us-ascii?Q?D3L/HAqTw40/P8Mpb/coJsd+DoqIE/KgBlkwkUNDv2QvOuN6RL7PP4K0fe2/?=
 =?us-ascii?Q?KFxmHgOCQi8wr35N3ZOh+uH6M98pwxgbD2JfzKkFwk7xkr2zmIq7+1MZr0o9?=
 =?us-ascii?Q?j9wqcnUHJE8RFP6jwmNHM6K+G8ZeqFFXe2rP6v+FUoKuINXxLpr3oB5RzdzB?=
 =?us-ascii?Q?j5tTYtvBvEVFzaCSz/K4dcxO1NzSVXpIW3p9A22bWsAlUviB8jmxzainTVOk?=
 =?us-ascii?Q?hlDAgMAJbeCu/dai/QI1dZTY509jQxzMG7S4GrUdjYNAWexDr8zGgwWL8vz2?=
 =?us-ascii?Q?eHk24ufaeNGrEgsQH5211HMJz/0PJGhDr0FyeOlUBgNtBokCscTWpcuCz2Wh?=
 =?us-ascii?Q?oaoyFHH+P5hjLhR2n+M6Y5IV3DXaLsagbvPkyX/SLUhOi+EK0xw552mClBmD?=
 =?us-ascii?Q?Wi959n430uY9l6A/uteHNONYPM63gUM1G/FX6LvI0jOUlIYUYJqFPHdVIf1o?=
 =?us-ascii?Q?yqpoHDv5cT5GOdV2wJleMd0sfjQ5K7o68nJFjYHYF235mTTxIWpnuvMPOYys?=
 =?us-ascii?Q?Yn7UPgG9Dp5/Vvy10Ygh3yeDwhsbxfmEfTgz+Parof86WGTN5GKwm5UbanA6?=
 =?us-ascii?Q?CI48Ep+j8mIwZlqWOoxmp3EjQ3HDGbwqCAxL56LnadZTChjIN+O02rq0X9Yt?=
 =?us-ascii?Q?4PREClTUfnwBFPwn56W73UFIi3SBQhzLcMJlt1h+LSj9GcccSfaPXc6Sdqi3?=
 =?us-ascii?Q?zd8b1EG9s4M3TXfXbgYuN0NxGj3ThRC9LoUKS+ABHRiEedxz1Ob5OZf6AHuX?=
 =?us-ascii?Q?tvEeKB3EKmcvsQs6mKQOLfS7hyfISp4nyj4RrKHUMQ09/6degPe+wZUQqKpK?=
 =?us-ascii?Q?JnuolWl4owhWSou4aXpadE0riWfgS2eJPqQFMrct5joZVeje6A3jv7QDjV8E?=
 =?us-ascii?Q?MMBYnJ+bq4Hkrc4qV4YsQ4yg+sUzUpFPwFMWtL2IoNxFSm3W7+4b8xvvhevu?=
 =?us-ascii?Q?W2IaB3js/9QA/l6L/fQTmqEg0dA1I+NkWNK/0NtXkiwzjXyqdN+ymz4hgjF9?=
 =?us-ascii?Q?X3JUriRaQ7bdvwlE+WWxzL77gabGBbFGsWRHAPSFn5vKlMpODXjyOC8rT8C8?=
 =?us-ascii?Q?3CWIgn1x5nYD5M0fdMvmu7qVnpIBiWaZi6ORaZ08URSI4CxQw0UKhaesytRC?=
 =?us-ascii?Q?JJW9mOVyx9nJEkQPvJMfwInI92RAFZ6kdg/DCtZJP80hkch4SEBhkBfFFE2P?=
 =?us-ascii?Q?g9g1nBF2okHM54B0BYVRQ0kx5VQK+Znq7RRsCqAHDmFEjM8156ossKq534dg?=
 =?us-ascii?Q?59rXeiMXpCQCD7a6BY/JgJ7ecBR+xLhzbItoIu675pe3Cxomjih6/GCkXaL8?=
 =?us-ascii?Q?Yyht+V57Ou1MYtzgIhB+LZnRWpyGe8f2bPhrSh4s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6812234c-246c-495a-960e-08db7c8ce308
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:47:55.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ7dpfM8AhsCEgkiG9bJEcDCqR4prgOvz9giXV5VN9nOpCiQpMZq/yhwcn7VFdC0hLwHp5n2AnKTe1LoMp/eKA==
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/pinctrl/mvebu/pinctrl-dove.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 545486d98532..bd74daa9ed66 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -784,8 +784,7 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(clk);
 
-	mpp_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mpp_res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &mpp_res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

