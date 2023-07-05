Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB850747E20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjGEHW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGEHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:22:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC723197;
        Wed,  5 Jul 2023 00:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye8UVeAO028JgCuq+ACE7O5JvUEwIpDPe5p6K/lOapuaZ1yzPdbFdgLZjRnpeK6+/cRRAORx1C2yilNli44QD196Vf961jFZbebVWtfOXjJnEi4g48ten/40YHNqj5BEjEyLseE58Z+ioJ1CJaaNeTwNZ5LuZm70/5//4b9B6piV4S14iw2+53Po5bsCy+NQ1fO1kJtqX+B1MOvM9us6OCFIvTOtd6eBimDU9cCKi/I/+Sj2fBOxPD/+PaimMpPdteNKrBpExKRjt9afVaN58WwhU9UFm60JraLn/Ir6nmUL4Xmn8xLYrFhBOgNvkL/2lNM64LQ5CtgH3ENc9JtRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqm/4YpIpfV9oXyYVoPj7Fyn6Qwqk7SYVjwSZlxxkIQ=;
 b=ZAUYSPN1dGlVjyJkF+AM9r/Z76ZdHz+I60KG/RuqAjdfUqu9217ukk+2Ik4yDX8mTfE260Jg+i3M7tqUdREbnXlnOd0vehsiSGQSMrHjMjwcDxCHhwdJsWVP1GxogbinsRUNCXyK590gv1OXR7RHcXk5YaOXtghDhSGrSQ7kCQHxh1EWVJl/SkM0lxvTAAjTxhME2wC4Z2dROIR3uAEEujRS7zuRqfEojfL3jtPYlBv41grertOLiMIu/1dDBO2/Hcx7qOGursKhcyLmpOQdbYSq0F7iHCfr5Lv6lFKprW4yc1DIC0FiFW+I9z9TGtmtUAC8/FytA6+rDQ1zBs3ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqm/4YpIpfV9oXyYVoPj7Fyn6Qwqk7SYVjwSZlxxkIQ=;
 b=qXgy/n4gxxI77BP6XgZM0ht/HzpUwKOC6CTkka7ZGlR7fLn0Yc4VPerTfD7A2+bgprnUbZGryal9KxL6bhMA94zCuF7N3148SAeoxoQLK9DoP6NA/4MTLVp9k0FoXmuY1yhKoojLvHn7LO7UNa+Z9rWJg/LJL1+3EpNjaKayM45m20uT33TBCrm7HqLFoTrwdvKHQOp/q+trDVvukMTmE1EMoAQC8FffO3lviNNVpmwtI/jri9kuNTGH3bdEqclHJf4twTSw7WSWm5WL0G/58RiwZrboyKSqx1Aytx4H4WPGIukvo67g0/+ug6mKDfn6AVp4e1PKcyqmCNM0HMuhPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6058.apcprd06.prod.outlook.com (2603:1096:101:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:22:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:22:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] crypto: atmel-aes - Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 15:21:56 +0800
Message-Id: <20230705072159.77221-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705072159.77221-1-frank.li@vivo.com>
References: <20230705072159.77221-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: b700806d-a31e-49a7-a449-08db7d288dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvjYiQfkJRAvbW3ZBdziPZ44pKr7EnqIZ07k4mBjgw/gVHug8xl3pnVLaG69gXW1UXZdd50p8Vcdkpu2rzIgxjd7Ldq2Mq3Pih8pQqBLAFKx7Pz/zSg5wAG2qyjndtdryE8OwhXmZpEQj2pC/eOZ4UoyctS2DdQhSORMB28tjLbM6aVI8IDZLgzdyQTpFGdZu8tF6izZ+xMPxmePPRAyLhPE/xjCee9g7CuIs5eFpDVtH0TJwKjxR3bAfcpb9fIUFesYzDXk7nkSpQr73B9bNs33cHSmBS4Y/3JuO2Fnj9l2Q895j2UCkFUJZzhVL4ge2iEZ/3o2jWj8CkfYYJsnU7/xhqVKVBulcE9xaVN0viQe9KKs2MMkbIa768KpvPpbgnb95RZ0cFlQDBJbSzcCPMmF3WD/qs078FiOvYik2XmYQNTrRf19uwkIckhPYTvZx/ni0eK9lXhVauNEw6ZxQNvropuKEEf6NIT+xbzQVL0RF6FV2esS0GNGYv1NHhZhu6d0IUD9PSqGA/xoA+Lf1qvZ+U+aYlQkvRAH+EklPLerhfnCW+VeTRK0GIOKqUlsRbIPliOYaHIUVQPS4dBr5QIcfs6MwVrNCtPYJGcdnvRTILpD6MJajnwP2zE/w2UK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(26005)(66556008)(66946007)(36756003)(66476007)(4326008)(316002)(478600001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(1076003)(186003)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HLdZsItSB0KF80qnzz09C6nXVvu0Em3PqwkWRvK3VST7+stIL9vUQolTT4M?=
 =?us-ascii?Q?GISCbI5gmpRcobRpM+Jh+wbnTJ1UgWF5+5bhvOPhnjSBsXi4HcEd9OL+jTjw?=
 =?us-ascii?Q?XJe6YzAND7n4Rl6yPlDKMc2SrsfjC49L2385R3JWv9TTwXg2qiboGUdgUaN1?=
 =?us-ascii?Q?2XCNrA+/XL4kdg+4eijkhPFlwvGcfvNLVW0j5ZCN8VxSitL9jhEa0rE0Nl49?=
 =?us-ascii?Q?vCECXpngurGOM53AE9IujXKTOaBF2ZcoRAfdBL9zSDpkrvl53o2qpc70fPvY?=
 =?us-ascii?Q?HKgAVLAL6lxklzK2rh3aThzHOaxbkQNOVOMn/GIwMzQTYXmKCLU6p4xqUMkJ?=
 =?us-ascii?Q?KupZOzPGQnm7qZAa30PlodTvjkCdjPNEP9hgsQpuzcKBNvdHj3G/iQB2hIC5?=
 =?us-ascii?Q?4r1DubQSq7SOLfz3+7snj4gj1tPuKN73p0D54P5WMICYgxRKK2rO5zJKqAFH?=
 =?us-ascii?Q?In5TVaLeoHcVV3PruasZmeF+TNSIrm6RP3F7stncWxCd59chSJfiLG5p33fx?=
 =?us-ascii?Q?jCrDeStn4eW9QbETA/k74ZsRKwWOgaqRSnCE2vDIlAY/S9mHnzCbw4CjaomM?=
 =?us-ascii?Q?RP7J6zhAkUW46hKmq9s8RMgXzVfPVtqzt9i1lrfnaGgUroKQI8NFnw1N3SPk?=
 =?us-ascii?Q?kqRTKyBe967cldEPvQY4ewfC+DLEYkGs45m457A+ZOvry9f85lEuURQFZDIT?=
 =?us-ascii?Q?cIoAGadrG5fMeMuJp6EPNTaF2BolXLXWJtsNMZTnW6Ps30cJ+XceHqrCScsd?=
 =?us-ascii?Q?V6WB+qc7CsawX8FrOx6lYg0ASnZ8uu+BxgjrvjWVwim2ZmX57uRChFoL6suZ?=
 =?us-ascii?Q?VBZoHSxaQ+bUOkS5f3IGg8d4schKcZxBBGt4E/uduC0Cq/HaXjHcklkYo+f7?=
 =?us-ascii?Q?yV5v4qL+pnSXJto7pQPC3c0ASkNqyJtVngxnWHE+lqOebD3DOb5BkvYBnTfG?=
 =?us-ascii?Q?UtPLZR0gn63rfTj++HWWad9zB0qdmuHOAbS6wY5G0+FQ2HPCc4IFy9fK+TuM?=
 =?us-ascii?Q?cM3FsV7SDH6HVtBZhPt7bOkEH/L3a1SVpwmIgi3GlLfuSwPxfmFrpmYUzgsJ?=
 =?us-ascii?Q?F/ZO8+JzGADSOB5A1jEklFDUNSj57GGykljIXvOy7xsOjcPRpGwBIOJFZJBP?=
 =?us-ascii?Q?Avxc89VoVISF3/0eGh8UJoGTuNMd/NDuRk0wl6+ij/Q3Z4rB/YxLN4580IRG?=
 =?us-ascii?Q?d3SymN9WxNil6zBHcSjyIBZA4OG83PvGofJnA8cpqNJC76VTMZvxMFV1JfDm?=
 =?us-ascii?Q?e8DU3QRhpk2hrrEws6ncMAJkbiHcuiNUNUQ+8MoPbdGmCq76V1SwI1Jnsh2D?=
 =?us-ascii?Q?KrfWaA1CDYZ9mbx1x/UhUcBGLV4oo6d6RI5c/q7OMIKMIE7ZxO3LOxjOu1qt?=
 =?us-ascii?Q?xMd/9/fTw324Y1bm1ESDlTeQfDYikA2DaE+erVyou82K2BW/Fbnn1rJs6x32?=
 =?us-ascii?Q?xjbPeG/0YbmbbhI2fzokFWOGxjpLVE4K9xIQC2JSsw8mM+rLNJkU8CLqSHD1?=
 =?us-ascii?Q?NIov+suia2JeiR6BpsE2/tGxfMMGvOfw+yrDvv4VQhUo3bLVpZ/xmSWXEOK0?=
 =?us-ascii?Q?U2MNYXSl1Kawec2vtkvaCpG2AQReao5+sflop5mj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b700806d-a31e-49a7-a449-08db7d288dd0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:22:13.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0bdRuKwOhjLCyfX31oeHOdLCHPbOV5Ez/tV8usJ7+2uk+RpwV4nIpuKs6wNgm30HMbRb3VoTEEMHPUmojyyrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6058
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
 drivers/crypto/atmel-aes.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 143d33fbb316..9692254faad9 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2566,11 +2566,9 @@ static int atmel_aes_probe(struct platform_device *pdev)
 
 	crypto_init_queue(&aes_dd->queue, ATMEL_AES_QUEUE_LENGTH);
 
-	/* Get the base address */
-	aes_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!aes_res) {
-		dev_err(dev, "no MEM resource info\n");
-		err = -ENODEV;
+	aes_dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &aes_res);
+	if (IS_ERR(aes_dd->io_base)) {
+		err = PTR_ERR(aes_dd->io_base);
 		goto err_tasklet_kill;
 	}
 	aes_dd->phys_base = aes_res->start;
@@ -2597,13 +2595,6 @@ static int atmel_aes_probe(struct platform_device *pdev)
 		goto err_tasklet_kill;
 	}
 
-	aes_dd->io_base = devm_ioremap_resource(&pdev->dev, aes_res);
-	if (IS_ERR(aes_dd->io_base)) {
-		dev_err(dev, "can't ioremap\n");
-		err = PTR_ERR(aes_dd->io_base);
-		goto err_tasklet_kill;
-	}
-
 	err = clk_prepare(aes_dd->iclk);
 	if (err)
 		goto err_tasklet_kill;
-- 
2.39.0

