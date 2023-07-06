Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDC74948A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjGFEFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjGFEFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:05:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D658D1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ4mFJO0hxa3evZr5DGeIlF7L0mgr5OHSWP5WAKUdSn0+nzd00t5grN4EFL7wqaRy5S7VQMkqtlJT/sBatVN9sU0Ns+Wc2U6FF07zm7cevKC/+s4EoqDLYUKyY4Fh7x1gQvZwZ0Pu9OyiK8D5fhOhW7SZnFF47kaJ3ndcITV5Srk7lt9jN1Ax8kEPs1G81jAwRpXzbyHPrXdzlFqqghtLaUEijRf2FuFqkGHmBjKSAuR7kw1zH1cRWxvQFhnTegqJlqKyEcd+aHslgSjM+xGJFVSg7Lw9UcYr43usFmCXuAuCCYq2d8NV0qwdUM8vEWDnvpf1dQgBL/2M/ByHHMWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F60DtyyxcXu4qEz2ynm/lRwj6z8vRuMbXVwcNW0mlZw=;
 b=QpG1Hbw4gdqB03i20sUQcjxvrk0bBB2ZPLk4wHynihOw8ECAr0S36/Jb6QioYgPqSOp2rHgx3Tl2axymAyc60pegtPyJhtIZ2szaqGE7opXlQNZOvOfVTkhRaoF2cOzGdcJ8wNyWOPB/EqjaMBr7IOAy5TCX4ys4m+Hwlqe9HjldeJ3zmpV7ICfCbmGiYH9ElHNugnCuN39KLbXJihAuwuGDKjgno0ErBxJl8EyhdTy7VwBe12G19doKNNTisjKVEB/ATsILrqDU8aGHub6+qekFViNmcBD+Otqm2kzdq35UiFfS5qhsC48NaaSQKi3gV9jjITtj2A8HAjKwRA6usA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F60DtyyxcXu4qEz2ynm/lRwj6z8vRuMbXVwcNW0mlZw=;
 b=lqeVuRtNMGOgPGQxWp7p3/8UO1NeXg04pST+27o1+O8qs92ucBzCalnFAW7NQf6pKSNiIAArybACc6rwVcF0a+OD7m0N/EZEBLrnUQZLnOxn2dSnrxt+btJWJ3FC2qgiYWid3QLgQDVzzp+2sTH+g6jKRAY3hfTMp6gBG7sFTzg8LHBQ2CobgIL4BwVKUelCdY2OyiwTjxpOcyDfw5iupJdj3oruWdxuUVg9Mjj8VNbzy/XY9qMVZxJoy4qpFWKue0AvfKGsjbdO/pv1+BourO9aK1U6xYOeG9qH/EM8uwKV6k0W9RtVDy2qIa6qjJ6VWX/v7KpTtPR+Y/BM7wuUGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4548.apcprd06.prod.outlook.com (2603:1096:301:a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:05:01 +0800
Message-Id: <20230706040504.34057-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: b3892b29-7c27-41e5-b060-08db7dd6375f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3lpRpGOrOFtY7KNMTtcU0KP/eVCsmIpsKW/ntowGEjkuhKq74jjwErdLD5c7/+0QM/tN0UTPN78ieuPBW5aa44gfWVUifqQ7oY/YZ+lyuZrsWS9Vu4bry0siGlaXMDBxdGDr/WVOFm1bOOBNNsQXDb3XrCGyYKd0KlB9tStLXkk+CGbhHxAO8b8qtHEX8sXLPAgNmVCr8fxKTnnTtCnyc77o5/8YXv75Ogc9PNVQ9gnBd5CN277lqBnJVwdC+FdgnZK/h9Mr1I2YyLHMaUlHr/fhVeS3krv55aQLhKlii2C9DxY3dwzFq8riaGzd/m1E348ch43cWHiCf9hMYl+k7VvtrvVV7QUbodt6fyoGORx45CZCERhcHJAanEPCqChM37Rtf6FrABYrY9jsWgKN7bGyUesuMib+uBFmsHGZ/gv+qmqlZvOwgPx2ma7oAoG8vel1HWYo97NWZ11pl/CerM2CC/qh6cne3yfJRLGuyOr54YsHdjRTgj3nQBt5f4oqLbRAWCbI/yqu55gWt9QCVQAzvmGMTJgX9yO0J/mVNlok4NiID1jpmxejWho3DN+/SAex9TZxAhAKkI5jllJr3Y4CJ36SLsCCzE/BQ/TH3g3+jCIBVtC4ynQ94mroJUu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(41300700001)(8936002)(8676002)(36756003)(110136005)(4744005)(316002)(5660300002)(2906002)(6486002)(66556008)(4326008)(66476007)(6512007)(6666004)(478600001)(52116002)(38100700002)(86362001)(38350700002)(186003)(66946007)(2616005)(1076003)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kv7CJ2ZmZuwkbMhfQSPjJF5UjBy7OIq86WdMZWe4tKZGUlaEwCLasZa/22Rr?=
 =?us-ascii?Q?AB6TwuXW18M7MnRVguHkmhA8BtQh12aCO/pAz/gU5wMD8P8fgtzw2TATpg2U?=
 =?us-ascii?Q?2xncVoFZf5lYgmr8wIQzeJikaqtPuouC6KSLyGVteHy98NgzORYyMNwSBVbi?=
 =?us-ascii?Q?lKhl1AxnsousJB0ZYwd6W5460+ONlP8pf4PjTMFbqy2onC+XhmpxQNFXTWh+?=
 =?us-ascii?Q?dwS5LNvhKwNMM3RVDbhW1tENIBrUF/uLT0RhtsY46rj6EpwSIt26qi3P6Q7D?=
 =?us-ascii?Q?2jJTtU8L4em0aLNfQTqAg7dswjS4lPENRuPhvaOFLxUBwnsdjRXIzJPMRXBG?=
 =?us-ascii?Q?fQu62sPjKjPh0VBVCowbgYsf01Yg+Bssj80bzwpZlX3aunbjRIt76uPnZ3yC?=
 =?us-ascii?Q?N4qFE4Aem3BTtsXV5Hp8zwYA7lHYY4tKjeA0MsfOiQ5vyNK0MCfDTL0IcofT?=
 =?us-ascii?Q?sdkl7LLh4DQMsZfjJb5pq+5ZYQObkGGK7dvA/nDiXtT2rk+KVTsXRrEPakNR?=
 =?us-ascii?Q?0I/17Qci/tuGLaDeMldD3m2cMJ5fF7MlWCJNDyuIk2rsyQwYW954LE9mGbV8?=
 =?us-ascii?Q?I3HNvI4IkK1dKjqYLgOvAUTsHNloAKG0M9Bg1Qq+CS2VOhmGQOMoWSyaqUeK?=
 =?us-ascii?Q?SwGzYpFFeNTYtFk3/W17+HauxKgoBIiRnwUrxKD82K0773eA42sfnCUus7p8?=
 =?us-ascii?Q?dm9jLg5SOZX5ZU3OR5o9UEy9lmhj1ZErvrZRkxuk0DK2OWC4YZkZgeDM+BQh?=
 =?us-ascii?Q?gXvMRJSGs1ovbPfS1r7q/KC7XY4DA9bWPR66gLUFpVsWo0SXyPvK1lC82P1m?=
 =?us-ascii?Q?RmS7qEEjwGycORFc/Z4kJVOiEtq4ZHryvgaHCSo8Dx0z3/ROlo82CQ/xx5XN?=
 =?us-ascii?Q?YuncTfPJMlN7ZGgqTp/76W+9dBVqm5M1vZ81Bhr41UInxYoEEepzgRdLAw1J?=
 =?us-ascii?Q?y0lv3Gy/ITlL5SRHOKzkp4yqAVpsdUBdeJKHnYGFVrdHJzhiNPfWnE7BC5/f?=
 =?us-ascii?Q?rgNdImlSFFBLVSwhiGz9tFTFeZRb9ycxC05nEcfEBU1F/jBmt48AKu/HdYCO?=
 =?us-ascii?Q?uGZr72xRbObvioI42SICpVL3a5raZY6SYiSxR/hzIFCrBAXzjtZ1YmFwUJg/?=
 =?us-ascii?Q?jk974uklMhw9ZUfnaygwNz4dXQZpzWlFSv1WlFImnDobraNIznBXJBcgR6Nn?=
 =?us-ascii?Q?a2zh0kA8k/nWSdUPEmYXuje6uHTq3wsabLx/AgUkmxqPRN27zkD1WAN03Pol?=
 =?us-ascii?Q?E6FhQN/gqSxUY2UgeCzUb2NJnh8yIYiLvW8mpCU23Pu+31Ai+LH/urO8fLKl?=
 =?us-ascii?Q?VlafmOcpTsIRmnNv5lrBtgOSilVUPqFL3JbVPicn/0ddH8tkIPCtrkKfGcod?=
 =?us-ascii?Q?lNtmyKpIIeNMAj7dzutrmVReFMX762d8HEW9lt7Hrr23JWAlGN09jF2bl2sa?=
 =?us-ascii?Q?JIgZaUcfaM0NARyroS+LQd0T2d6vvzcE0slfQbob1HY1mUXgsXKHnSekzIeA?=
 =?us-ascii?Q?EuwAVzcIyYh3H3RMlhFsd0mnLICXzRsIuy7LdDXei8f8+DLDSPhYChg4tUSB?=
 =?us-ascii?Q?FZSNUKBewQHvh3r5bdXhrb5Od50QbaQo0It5FMOj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3892b29-7c27-41e5-b060-08db7dd6375f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:21.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5b6q4OhwG6lik8oMckUFHpR3mlzANLvMWZPCt6iNrL2ykHlnvzhubezwarxZsvRQWEkiPK0tdFmln2LeCh7i1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4548
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
 drivers/nvmem/rockchip-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index e4579de5d014..4004c5bece42 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -267,8 +267,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	if (!efuse)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(dev, res);
+	efuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-- 
2.39.0

