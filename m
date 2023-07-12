Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70DB74FF53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGLGb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjGLGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:30:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9D26B6;
        Tue, 11 Jul 2023 23:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjEH7b5oRCb95/eG4mujlaWRBVNTnRp0Cef94tunP3XvJgx62kCeUHf2c8Qganrwhv53EbJAoUOKGkjC02H/2MfuUIdrimJBJVOn4Kandl19G1mI9vvpvRyoB7AdEklkELPZ7Ac0n4MqVPM5EZYyrM9Edyl7bXPkLXeocA5pAwRFBtu6z4JJC4n0GSMBN42ST/xYsvahXOZk4ZK5QRRAkRk/1za+SepVsng2WsHot7NmqPiILZYPV7TLyH6lsQ5uSju9dsc8RDILJ5sf53G38lohyiUg/rVWpDUHgAtXGYDvqBjYG7qD1dVLr2raHeT3WUsz7kqQUVSaH0EuL6k60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ERvSezg9PnZ/Q26izoUo2TeUcyCh39NDFUlOa0u5lE=;
 b=FeeJ/uM4n2gmVby/dWEIrCNZF0TyzGuiRGsM4Gtw1AmQNC3hcZvWVlSNR/9mITbo+sptRWWRuTHc/vBWYg7kCqCSfm6nBNLErJtK73wwC5gSk/DhhXHgMXiXjQp66CJEawHZKAa8pLRomgW3RJ4CI9v5nRY/uTv84kjKuztcg9ETgIIXX54+wFwTjhry7kN1wzLIbLClmQNc29EOE8qx7Hrgl5CtvCgzMDaNZziO2fdErrr90RSsW9pb9OOdus5uHvwFSUEiu/AjkQBqHpk6+kl/Nuey53ZRGH2DJts7QRrZAQmkOulSrMuc2RtJXxs8yVXav46EwcoWq6I0a1rD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ERvSezg9PnZ/Q26izoUo2TeUcyCh39NDFUlOa0u5lE=;
 b=W80ObTAOyYQUr3F2d2EG1drpjR6GHPvP887SIMt8m+jeUdBLzaxV2f9DlYjZc7v76fUal5pf5uoQDT0JZyDwsKPBzN+Es+oQZTlS7O735mCBmP3Wi03imGrMiLiQ7RnNv457k7Zjd2F2oNI+1wq/zv4fzUwatq22DMi9cZNDBg/pe/g5tmz7/JzQxTo7vehJRTPeuy0ETwPn3nHH1/BEJ8z4IhBYrzwCe+QQoYng4YGReZkNez6CaBcCcQn75qXA19at5GYWbKQu0qod+etRHE1yXTY9x4HBGymHBsO/pWaDrkdZojpHi5gsENJVfDu3DqJ5q3cVVov4i04cC75xBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] serial: sprd: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:48 +0800
Message-Id: <20230712062853.11007-10-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ce0f76-8d0e-4dc3-a95d-08db82a15775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePWCvwGKhjqvD1HxMYsSEaJoF5rSCKmNUFd6mkfNP6x9hpVhKs9HU/GIl5lmjfZBg2Hh3sYEULI9fI+OlD2nwQIwP1zUqwr+xzBNYwrWmZoCgUMggNfNuCT43hlSlNeBRPYsakAO4N23gAIXDWxz+iWcCZqeKZLMwZR01acrUqDpfJYAgxjNgOiNCsCyhLB0X2BR397nl+tPrQxzAEF82Mlng8YP8nvKvAOdM7qTr//H1hk2a8c8TM0EuYBMeNTDdzslNqXU5FMgy/OkHfPlhaBPNWWC0rX1tTpkm1fYbCbeCTx297JIT2GNFxFBy0HO/FYJCVK20C2YOfw8i0L2ZPFRYMnNwRojyqnJ2Xwya8hOkc9t3tVcULoL6e0P3TnP2XLYrx39MHrcipJfKoXwMsXRw+MpZb3wJly7Vu33FVaGlwOQodwF5/svlMibi6L0z+ag6n92kcQTdjc1KmUxQubrmWmZXV0NNpyAc5OJ/wQ34KBOWonUTSG5AVitnFjJSKO6P3Lg7JQxeBVrEb9BREJN2w8y48Z+ot5rzducWv3hv10vnYhokkTmNHaZjPibQhADSroojOx5kxrOCN6ZfPaLJ9qjgGoyYhOViqx6Mg6hZfWyerVz1ifTJYWU7GiP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gdwr3xYz5GW0+rF4CwzugAOHEsp1uaGaQCapGqBam8Xav257lY/pRCNeY4Uv?=
 =?us-ascii?Q?IABQiBkLexhPoQi74dxuTqXnWy3j9wAyPZUKaSBh21DC1Qe8Doo5mAdqopzI?=
 =?us-ascii?Q?wVP4AOE6WqAyHSxZr1f3iJVKUdviUNE6/+TwW3W4kp4h04dwGKLtcvpZwzNJ?=
 =?us-ascii?Q?ZsAzZ5UADJA2f17bOgb13HFb3VJMpHbqfT5lvqbwccuVP5Ky568uM18N5QUM?=
 =?us-ascii?Q?lBgO7a8dnPrvPfSV1ESV3s2t6aVvoNpby8L/s2rp+lDh8L1dLPwF2jBzZLsP?=
 =?us-ascii?Q?OFolWaPfssvjVUoDi1+8rdrPKC39pDuB0Gu6dl3rfEe6Hz0yCurttln3+IVK?=
 =?us-ascii?Q?5LAysOlVqi7nrps09X13InME9M1GLBuOVWFI8L+igA63m7Ek5TdczxodmiZB?=
 =?us-ascii?Q?KFX6Of1zpLhVL6/bC3k3/v3DLVBzqYKt6SH7sS1yZXJ2PmaeKHwtPddEq3kU?=
 =?us-ascii?Q?O8bAmxDCcaJi3cEC6l7NYLIQx7qfP3gTyxbHQ4fpmCT8FKsUmuuTL4zGV8Ey?=
 =?us-ascii?Q?E71oLUJH6FeCe+95FZmvbygFECbA6dggtOUPw63gebjyRZd2sQUcM+hjRfjT?=
 =?us-ascii?Q?ysoGXaaCtjRYQF3diMzzABG9WAsgpp6LmStK14ryvqhVv2N5zvi2lr4/ISUZ?=
 =?us-ascii?Q?++hPhSQ1tCbikw8gZstvlixFXmIrvfSywxbxolxQnAq5yNswbHiM+aKgdJjl?=
 =?us-ascii?Q?Bse6dPmKuSyjNGDH4Nyb5uIwrQZS5m7zrfskjdmRC07GT7bRM5SWI+e8aav3?=
 =?us-ascii?Q?kVhHKHZ6eF7CYVDzj/cOPAu2Zq+QDoPp/ikU9kESEuPdhVrLOqhTQWkEDtkN?=
 =?us-ascii?Q?QL0wG31DAdu9zKOVyUaSPNRKpIGE3CePU9qYWfoCm+HEoWUXgOtg9D7GUejJ?=
 =?us-ascii?Q?+QHh8VReA7nOr89aUzr6KxT2m6YbQsEd5cktv6d/buto2aT0EM+OC10/0wET?=
 =?us-ascii?Q?kpGpmwnICgFrM5x/K2Zh3f2USwavMBj9bj/ANLI8c1hIlmKJPht85UVXJMfU?=
 =?us-ascii?Q?6RQmrmAZsVreYXxnZHZvKJNe+uJlZk0DY8HiD4cPw8E5tW/WaFkSCUUogQHu?=
 =?us-ascii?Q?y+VoHjG8mdKXr2vzi0wG+KnMPq69DCed7PRPUwY1fiDtbVROIEvvzWrZYGXr?=
 =?us-ascii?Q?ehyWaeHb0X822XQVTj9CAb8+mrOn29oR9HwLPE+HoA7sS+BUfg/NzLKarAk6?=
 =?us-ascii?Q?PhYdwwV0iMOwh29fEgzaF2svS+tNDbdtrEpHSVs/V79fcf4E9lwGwz0wUxvm?=
 =?us-ascii?Q?rYvMRCC8X1NZEuTfVL1f8s8QYLzzVTLx2u8DywyGL0bPHtUVf7gwWkbN2y5J?=
 =?us-ascii?Q?lNJw/oP7fTSflcAU7K7IntyKfZREfWXb7fAlt9fNWPvMgY6/xZueKrLHUECP?=
 =?us-ascii?Q?bnUYLGK+0SHlh41sHvGTxmdGZEr8Fyi1BWmRMZ4KqqjdBy6Ru4Uk7Cyvh16e?=
 =?us-ascii?Q?CNwFddnfNNlUsr6G2+s8X9n6iZif5Xx+azboXPrcVgOlB6K0yVGS+67+lTUq?=
 =?us-ascii?Q?d9w/DrtnWIQoJ/tlXJXYZSo+33NBAmLEKNFuq1VL2/+VF/BbIa3LuD0ZFyzm?=
 =?us-ascii?Q?GtYRLk6cRiSMAJvWHw9BtmDsuScI7LVLxmnLOvZi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce0f76-8d0e-4dc3-a95d-08db82a15775
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:27.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9EOqb885aaP0yf9387l/8k+YxCTqdpHeez5lh/dA39TFsgWg5PhctW6RimrGnGBNmqSgE1Hwug8+ZNlqf05nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
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
 drivers/tty/serial/sprd_serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index b58f51296ace..bc47229069a3 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1179,8 +1179,7 @@ static int sprd_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	up->membase = devm_ioremap_resource(&pdev->dev, res);
+	up->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(up->membase))
 		return PTR_ERR(up->membase);
 
-- 
2.39.0

