Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3791749B65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjGFMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGFMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:09:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3109172B;
        Thu,  6 Jul 2023 05:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVllzy5E14X4FmPK/+dW0LxDhaM3wNhvLrtjs0OC+80O3tLV//hiFLAJM8jHPrWmAi1Z2JCUJS7+SbLtDITuc5hS8BwQhUhiPw0h8Nur2swQkGcLjIWC4EyQt51rZM+IxdnMBk3A7jTlPb7sOBMk1MW0WOkGYZqOVN0oHmJXnW0p2afMkeQSjE2CrGGgSRvswQD1MdGLSM0AZBEdRSHWlngRvx0lGLjwiQTL1ZDFRsfle4N/fQFG+nmL90ZZBEUi14abhJz7TSqm9/AoVu7jfqCvhFh1aCg73llVwn7mlr98jJaEWXqpHblOi3DO/JTxUAB70B0aVdNYGVz6UnZBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/WML68uYj2jXuL5bSi9UsazKB1sPPP+ROnGfU5ckbc=;
 b=jSeIGI3zytK9HspkgY6CfdLQ7Lco/18wkTgZ4dAO+4tkLupX3BoplplHm9vFicGlCNmk+7t+4yNqq7jTqm6/Ss1utLeSdQEJE32hpWlGH4AiNvWRRlB2sG0sDFtl4ADpWRGctz4juhXqdA0EHC+MmQN6akkzV1AOsgyGpheyB0sZ2/WOQybF06EIBtdNA3e2tzRkYSDq3h3Dy/P7R53j6YYx/uvrIjEs6TNPWNEONgE7yu89NTK9MHUt9+HKTfhpTTC7NVL7ZH9KQx1mV+sEBYBoZaISqhw4+fLwWmNGVjCvxS5mrDyQ4V4Uw/M9FE/VkLlH89vKGkPvQ9EGSAJhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/WML68uYj2jXuL5bSi9UsazKB1sPPP+ROnGfU5ckbc=;
 b=Ycfnw5dOSu8ey5y9BI5qPLo3sE9PCUOU40iu6IY1+6f+qUl2DeXZ29lnZdnPRtsp5A5CCKgIFRqogGtaUIe7cfbESp6LJZ1vbG+JIhb1o5npSlFOPbOjHOFENSsplc/Qf2idZkGzEJiKvNG3yG37E9W0+LrCN5DoZknapUaYaoq+l9Wz2dTthoDtQLIce1m7pnWYZWeICj2FBWvoSy2JUULzJQLL41xc1Uz98PcnydV8CutvPhRdzgmWrITSTbDtPLNJ4QqAqRE7id4T70kal1qBSh1TAhr7zhR5nkExvnLOx97L3yWAqGlPJ3RX5l3HEUG2DpS7H0o2P5jWsXNm5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5634.apcprd06.prod.outlook.com (2603:1096:400:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:09:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:09:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] tsnep: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:08:48 +0800
Message-Id: <20230706120850.11026-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4fc680c-90e7-483f-7f3a-08db7e19c9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yx7uHWb+DMEFtBhq7XeTPtEK7rOBM0emScPv9pauop2zifao6ZJy92JGZsKtTP5XdCIofdNh+Fe6+iRZDbfSZC62BNQxaEPAvMH5PexQJlxeOpSolSum+8gakyOMXu+LBa7/T0CJg1T+TNh2cdpDdzSYy3mRDDk6rvPpv9cSDVcLbpOq9oNkPImLCd/ceffC3x3Qv2MorkNeeN6C1z63GkOwXwDYENWqEx4Kz+hfGBxRA0bLPh+XixdAyRg14X5L83fgxLnQGWgjjhugsTmuKDeSJbokjsvqWt1qrXv9UEn80Cs19mhgVuKZD0dGQnZokcohWYIIomGoWIF6KhS0FqBDJCykmJxhQSmUZUnUheqEidx7e395lXjkhBwlLknZ1jTyJfJk+NL4+/QfCMoZA6pOKRvPqYfmuSywNmiak6F6T6aeJeKRgG1kHSJffo8r76laadRQctf31P4nNsfjckIKgi5vnugCgNn4JWNV0/ivvdeWNeJaNJ4oOS3sp92cH8XSCqWGd9Y7gGcV5WNoBlj8GgCVGcuzgmrzQ549337DJgLHEVQulJtUzGM5ug2uZFx/rVBI5GvIcyDw1zZrH7npLtqwyusYskNxDoGExl6Z06rusoNk0PPG5McLU32m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6486002)(52116002)(478600001)(6666004)(110136005)(83380400001)(86362001)(2616005)(36756003)(4744005)(2906002)(66946007)(6506007)(1076003)(26005)(6512007)(186003)(38350700002)(38100700002)(8676002)(316002)(66476007)(66556008)(4326008)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tc0RBPFoOh/wjapFtrvuKfuWc3BHG//EiDfVWwgfCsl71tLXkWfzppqKVRlJ?=
 =?us-ascii?Q?83yFCr1olVFYbSHnferzQSsJ+QAVTPCYsAezLWmrymonhcRi9mBdlNRpn4Hf?=
 =?us-ascii?Q?pdsUt1XxT3siUaS/YzM6VRjytJDAoemp+799t98hfgWpipd1ML/lF4iOz4Am?=
 =?us-ascii?Q?NxfSrOSsbCGC8PEhuTYxUlgo0+Esy5YDHU1YHBtSJ0G6MmTmy4gX/kV96eiN?=
 =?us-ascii?Q?ZFINkOgIgzSpMpPeqXCuT/Oke/ok5YQJ3bkJmgU1P3YbGf4Lg8U2gW1ljgze?=
 =?us-ascii?Q?WSdx4+JLe0VAWvdj4sKTczOqmTpi4eoknTTUYbhjL2ieGg070hXcMFA12b7r?=
 =?us-ascii?Q?FUX87nZael08w69kUcgzEx+a/1Iopklxeuw8iMv8kuFe1Mra3WGrk4Zkj8Gx?=
 =?us-ascii?Q?+xG5gY/clua49WcdyC0zGjL9X+1hXkce3Wh/DvVd+e1lmy6fOYS7fRFEHDGX?=
 =?us-ascii?Q?hg1sZ/t9nXeIu5ABmSF+dmY9MJILDfhPLHSCK9vtLu1lrAWh/wG2E2MUtdZq?=
 =?us-ascii?Q?HsNcqA2ZCG59p/7sqYTIYSKZMtnaskCfYU8oljs/BjoGhVpj1m1Wsd4oOXI1?=
 =?us-ascii?Q?+IY172n8bJvqEhvygXOTGFEVEUfEtGNIHrnFhOISrvsqjINz63fbB8hFKiM5?=
 =?us-ascii?Q?B4IPr5jNC3UOgRnCIWwWmj3+bogmIKzceHi78Pz+In4sPz4C4YAVx7fRdWus?=
 =?us-ascii?Q?Nr4vll3Fv7wuz/bQ8cvppI/jys7C9u9jvYbS/HHEv+TcfR+qGiOU6ICtCDTh?=
 =?us-ascii?Q?8FB4i5ZxjYnNpHnLeO+Uue1GC25wfrYCyCVlq4EYUq4IothYC0fpuNgR2u3q?=
 =?us-ascii?Q?zClgFMJXIPF54BgbtuIbA1evJ9CLqWEekmRvcGj7ovCn6p5fquWStCLeGm7J?=
 =?us-ascii?Q?ddzQOf9ljZ0H+phIq/gC/AfYVRd4yvHwzrPPKGIbjeZB6i+dYK7uzeBGTXpM?=
 =?us-ascii?Q?ZiB4zJVatGvP6Zua8Ckh2DkTNYGI3BGX/q9E7Tk2GNLjCb6gj6MbtTBFA3eI?=
 =?us-ascii?Q?+BI7wvqOncKEymnk40t1o87Be+HtToiJk/b2Hcsfw9k7nUHlOz9KZywSsr4V?=
 =?us-ascii?Q?PFMM61N26rc4EFW+7BjTAzevqo7oveCu5pSgU/wiF74iLIfq/CRgF8PAyqfe?=
 =?us-ascii?Q?RZ9lVxNXyemBdSgwYSuaq/2o/i6TYtyoO1fGLZiXBiEpNsApF7I4bh6i+Wns?=
 =?us-ascii?Q?llj3gSZCZSQZ7+WzIHr+4SYEiqy4mf6i7dYeADAvwEasnOIRphhUFuinMkZE?=
 =?us-ascii?Q?MINTZiL/Tt9nf+7GKrKBa6ccF/AFn+sCOZM5W89Hzcopfld6j6Ndl4tgW0Dg?=
 =?us-ascii?Q?Mp7u6B7+I8a9zNo5wlDH3JPfXzYb0jtnljF//99PqKP0FGMzbn2b60Cua2fp?=
 =?us-ascii?Q?PG8HcAts1whR+bSqj5MMzgNC1DPjjnOHC/szgotjczCnyBn19nNko9RyBg9a?=
 =?us-ascii?Q?kpbGY2mX3EeOy11hLyFtDed/COvepuwEzn/b89/QIuoAYg1dQj8r5ECW5aXe?=
 =?us-ascii?Q?Hc79ZAo3i8HxDZlDSsinBuNGTWs3yAbOO//BNI8Nlyp2TSw/g0vS6nmTOvIm?=
 =?us-ascii?Q?7FQte7Nk2MCg2jCUWsbkRyOdamHe31slWQFYOhRC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fc680c-90e7-483f-7f3a-08db7e19c9b2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:09:02.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJUz9YNiWZmBxJEpEHtzrj5h5YOxfdvvv4cMvjQ3lH/yL2qHgWV2q+N1jv9VqcxekRbytjdT92gfsKv4RAmlMg==
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
 drivers/net/ethernet/engleder/tsnep_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 84751bb303a6..28a1a4f5d7b3 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2487,8 +2487,7 @@ static int tsnep_probe(struct platform_device *pdev)
 	mutex_init(&adapter->rxnfc_lock);
 	INIT_LIST_HEAD(&adapter->rxnfc_rules);
 
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adapter->addr = devm_ioremap_resource(&pdev->dev, io);
+	adapter->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &io);
 	if (IS_ERR(adapter->addr))
 		return PTR_ERR(adapter->addr);
 	netdev->mem_start = io->start;
-- 
2.39.0

