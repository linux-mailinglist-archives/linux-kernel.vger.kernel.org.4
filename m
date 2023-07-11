Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4084974E578
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGKDtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKDtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:49:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E0AE40
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcupD1CMOw/QgKpeQTbJm/+mT+Xo1aEwhSTNo0/sfOu/TVHAFgeNCMEfvkBWlgUapRZikIkHtsWFq2v7aNPoPw1JhnDDzEz8URXNj3DOqnsBNVDKIeGysc52wUKRTIGBgRad41bhfIf0Sd6n8Ksd2Zlge4K55j1BfBF2sLAqYFNh6zAYhB1VE/Van2vU+JsiJbcs7OwyWlziNVSxWb6ml7t3W5NKeCUHlhcWrEM4F3kxXo8+axkSiTgFRrTNdhZxSKfD3x3v81sA9vwHQ1wZ0V9x2MIjHf4i0f4S53OueQEekaKd5LpSIidwT+5/P66lkR01tg7VoUQUN9oqrOZxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uiMaQCpGxelaT3fKaDxDNnSSEZ6fsAqhFU64aNTykM=;
 b=OtShYY7cI4g1ioT16OBYZdgOOmUiJE+C/1rjYfwZZYjGfXf7nCnNHWVyhQ3EP9CqBHSGeJ4KYvjCJxtUyCYYmkSjsmL4WTyhxAuuNv/TJF2bDRbf6bfFewaq5pQIzgDCo1u5PQ+z6lmhuqMPr5uc3ci5VuHqtD8YzFXmybJLqct0cN/HF6P7S90OG9AbvVO26LuJGZFn854pEVpEHgu6qmhL0P5whWxR2x3YG54HaAKzVrxlvPMWZdyQ4UBMzbYHpMJ4McpHrMSgLKSSWbxEHdgH+IxISo5ga6naw2OhuwnpD96GO/engaJKnTHD4Aaq5BNCePrLNNnrrOVW4tWqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uiMaQCpGxelaT3fKaDxDNnSSEZ6fsAqhFU64aNTykM=;
 b=EW2yvQCWEdP+yLGLYuaWdga7U11GgagoYpeSBDE3PlvFnPodsK7GIGYwHvqSySjz2z7hVjCzxqB+mwBp1+RhWQWXGuagWIt/kGTruHwHv7+//eZCPIVuJDIrzqSbMlgFy6tzp0IMRk14j1N9xEpD/CXRhcKcYZ9co69s3K7VEP/z1HzdTz7BTm1xXEsInRh3wbDdqVEvBnHz0fjUl/zt93g+UUwPEpKCRmgZYidMFXCZm6GFaF9bBV9SYsdXG34FDLzX69GwHeaZYXJQ5jzX5cNtRCZtpjXmKPTt8tRChfaUQ0Kpm3xEnvjEoBlM1I0wrncvNlMS1cFLfOE9NsPQWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4385.apcprd06.prod.outlook.com (2603:1096:820:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 03:49:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 03:49:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/5] ASoC: mediatek: mt8186: Convert to devm_platform_ioremap_resource()
Date:   Tue, 11 Jul 2023 11:48:43 +0800
Message-Id: <20230711034846.69437-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711034846.69437-1-frank.li@vivo.com>
References: <20230711034846.69437-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8902d2-557f-4b63-9c33-08db81c1c462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnPmvjuMNhK1RjJs3OfyrBUvwQ9Wf/I0K30RaOsi5nyCWqOGvqJ0nNpMAkX8ZqdTwEz4Tnvu/oPyzKuxlySlrprvxQx6HXf+mgpRr4yW28Gv9LdreJAOFB6TDiv3TdFJ07LnuKubwV9MozqEpdqIfGVQXHv5kmHoZ5+Uc5ZthsAR7llfdyKkvHqDnZsNndZ/J3C1MFbVQfTSZWKdH11q8kirvWBE2nTAsURDkftMGaVLu+YV5kekghg0dTXurEXbaPhGtQs2vrJysE+XlD5PZgEEctxWhV1IDLdvSdUNte94i9jzYL6HSrLjSgRFtOANDhA74/qJAjbn7AT3kK6GkFvYNNHXM5jd7Z0ELLWNRG81mYns9CKahHcapAIxkicIj8Kp6l3IkbkqzG+oXxwhnv0SF2iEWNNxZqyXKfvrHbZffd2wWtSIfsMJKwQ+2KAS/9P7UXDl98EXnXXoQvHw3kRUzQCUk4DfacsUar3aH4BZShk46jxAT3g8fZF9FdvF2XiTLJ7mjxVUnLh2RuMARbv8BjusLnqhZ67qbDfsuJdHsNlQs9uuIZtAa9R97B2jkHvRtaNb1BsM+w6JNI7/mYyPonRRpHG6hg0XHti6+Ui4tZGctk7DoOc0enhJLdaV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(478600001)(4326008)(52116002)(6486002)(66476007)(6666004)(36756003)(66556008)(41300700001)(110136005)(316002)(66946007)(86362001)(6506007)(83380400001)(26005)(1076003)(2616005)(186003)(38350700002)(6512007)(38100700002)(2906002)(8676002)(7416002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3EsrdH8cVWzJxoWEiApKp2inAVUw5VpQ8tHWhMdyoy+ZB/DXgbxZCGNkVCa?=
 =?us-ascii?Q?IP5AJTnJbhxICuQMORfQ/zIzZ8hsaQ9x2qL3HsU10B06JINQ3fmnCFp85GDc?=
 =?us-ascii?Q?p9HQPU5HSvfvktB9sfdeX0rniYSn7zoN84VRTzQYvDzungaUldgAh9lBWVCY?=
 =?us-ascii?Q?YHH9snuQ65oHHc1FQApKN/183Wmv23RqUlFF+JPPgAbowvWlsy7mdERpLyHu?=
 =?us-ascii?Q?HrdWyOLINcLxGEzcT95UEOLSGXV4SOVpCyiaJBYBt06TnXqOxzc0us+gwcUu?=
 =?us-ascii?Q?R1QVynh8Xk+JU/PuZY0JBlG1/ZVp7cJtpWl0LGD4lMoc7egGqYQKofjWwtMB?=
 =?us-ascii?Q?ZajYWz9H7aGNCRySIkQUwwccrHpovFwpkNlmEaNvbNHWr6WAzZJ8gpU2krfx?=
 =?us-ascii?Q?CDqkml4gSxz7dbGQWNXAH+CseNJTmGyqFXQ8ArCm2R/1F2Fr+SKRjX8BOVeR?=
 =?us-ascii?Q?Tm7a9tPs9gdbywC99/JwgR6BfLKq6zRG9n8nOr3j9y8cFWDH2R9b+xsIvOX1?=
 =?us-ascii?Q?F8DU/IZIjtM4qgHljtfFcDN0KwuCUYhdLxpKqIrSzJurCT3hPRBwFs4LK9Nr?=
 =?us-ascii?Q?fSmCo6zXh/u/I4FSFlzhdNf48AEwZJBhM1dyuG92zysxJ3X6N+rCh0FqW5qM?=
 =?us-ascii?Q?nvpO7eFBR8j0pbdv6K7BnH4Ih/oIOlBg7HjUWsE0Nttyxf5soxqFYqoCwoFI?=
 =?us-ascii?Q?2Cl1SEwaZohHlqaqJcb3JPYUYZIWw11sJPj5S2iKNskggIy8ObFb/Q9fGOXK?=
 =?us-ascii?Q?I7f8+BD5vJKXm4cA7gV5f8k0W30oCT+Au1Vn3a+g1qi9/5NeUdKw+SuP2dkZ?=
 =?us-ascii?Q?ZZXQ4RanhHPdacGhMVfZRaNWZmmSojZIfXRBDxsF/Kq/nqLv0saXTWjV3Boi?=
 =?us-ascii?Q?L3HNlXIJWsgQ9KKiZ6P30wUTMu+4/zp06brIFeAQmqI4qncpkgsWAtxPZPum?=
 =?us-ascii?Q?bUd5ecTwn6nB/NxfBtY+Any92gF7j4aAiMgxqZWv0bGMQy6pic6j96G0MAZR?=
 =?us-ascii?Q?kbc1UmCbWUc2/dJTNT/x8miUDMeM1q1dRFR8NeljfPigNm0c+8INXLfl9Wao?=
 =?us-ascii?Q?H+KSr0jBvxJsGO16VPjF881m+wUoQVY79in64ybGP76AUHpK+6r0dcoDC2pf?=
 =?us-ascii?Q?gr1SYa3fkLYeJOMIwWkg8eHwEuy81OhKbtMyzasN4cM6WfBeG2c5EbIn6GN0?=
 =?us-ascii?Q?nSC1MK6zr09hlyIZOmMfjuN3RJ7FJQlbvY/GtCMqZ9wXiV3xgwiYBABB7+XT?=
 =?us-ascii?Q?ZJWVlkskqsQXkwaZ3DOzM2bazvdw/VYXsa7ei4RxPnsM8WcvIAPc//eNskY0?=
 =?us-ascii?Q?yi+SEBjGS2v/SvHrejPvR1Dvy7SYz6h2qrcDtZgAhxF1SE2Eg450b//0u0zf?=
 =?us-ascii?Q?vqrCec35rj78/7sCLZdxl9C7FMBJEe6/8mJesODprrYhHO6+xcosK3becEuG?=
 =?us-ascii?Q?ZWxK0OKO9mwUeYwVtpL5f8r5nTMIQbUSksSjZfGMk+isujr4yMFevf9Xk2vR?=
 =?us-ascii?Q?Lzx51zq1ZrRW2NHas9o54M8m1QGmE7caHXp0vcCb3gueqSJbxT4Bs/iRMpvR?=
 =?us-ascii?Q?zMBD73RlelbHfmJoTmD8ihAY0N4T+d88/rZlHfbi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8902d2-557f-4b63-9c33-08db81c1c462
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 03:49:02.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOt1IqxjzbSrwYLx54LWv0mN9k14fiytfYb1mAMYgt9FhTdZrrf6rTfRNPvD8ug+dwjacCpPsdH6W6lHe249MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4385
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
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index a868a04ed4e7..b86159f70a33 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2815,7 +2815,6 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
 	struct mt8186_afe_private *afe_priv;
-	struct resource *res;
 	struct reset_control *rstc;
 	struct device *dev = &pdev->dev;
 	int i, ret, irq_id;
@@ -2836,8 +2835,7 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	afe->base_addr = devm_ioremap_resource(dev, res);
+	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(afe->base_addr))
 		return PTR_ERR(afe->base_addr);
 
-- 
2.39.0

