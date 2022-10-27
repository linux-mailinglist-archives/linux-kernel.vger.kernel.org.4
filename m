Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7860F9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiJ0NyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0NyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:54:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F51843EA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTnr9JvEIy2AipDw4d8Jekly2jXowr8/L3P0Gg043ed2CSHjti6+C3nPp2/Tt22LEiH7aAcfNxJN9WRhYXEANVHzonjsq1rD2t+KvlBuyRmxWvoucNCBBqC+MMXUmvzbzgIFhg24dONOsqtBjS4hTh05giRK63Wrxsxf0gZxydHNxizw7NLgb/joFj5d001FXFD7cvEJd6G6Eu1eNZ/jZD73bIHSaxBOgvsdaoAnlZ90l7TGYE7JYeS66bS1nWIm1tiZE5DECeRa+VsQzyhBVZkpkT+yETTy96S0/os67zrSo3uydC0tM2Txd6PqMoChxL+OgMw85v0xffRiDxipjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlU9QkzJ9DByiZGOv7wLBA9lsq6TI5jTaeqCQPeSdCM=;
 b=G01Ry7jHYzxnIPuRpWQb0wDoH4KwCaoJ1fyn2spRzMRZMqohe6maXQ5ZqoN0iqengDt/7Z2tPZUPb6/k/yG/h7XzQJEmUjnV4R0oseYUQeM4bW5j5/fh2X7fdzZchFY3hkK5JaxuGFb3FvgBNK4Q9bN1zfPoqn3t9BaWOBIWA88qby82JFoL5j/zcU56wsF9uwc99gkA+k5eXoN1Cn506arFkUVaapIWM92sdEINAsZab6Hk/ncEdhdDzxzCCA3TfdVqA4LtegE97OCGs/yF176/mLD+2yRCKwaubuEO8Y0lWkTQJWXO7sq7yr8iCIdWvh4E6dTaemkEXkt4Z9U++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlU9QkzJ9DByiZGOv7wLBA9lsq6TI5jTaeqCQPeSdCM=;
 b=oC1C/WwxLBAQ1XeCS136zOZJHMTpkRvCzgfUA/5uFi4fbqC/q03QkrLSkxZ6HFPT/tHxoi4Pn3Pix08eMGoRCe1O2p/RDt4uVs8gkac3o/8WayAp9BOzNcMJVl1TYJHd8kCdxmcicC+NITPyLY7cIt6rff9kz3UjXbWrzgA/oz51gXek+yOEa9qKq0GmsbnoX1snZUNIkpXTo1B+0Riu4tbFvYUDjLwl2FO154JsajSobHoQl259y4XdshOcLSYdCj/E5P8WPuLrfAzEtybQm8vkZsLlO7eaHu11LUWto4A+odulM5eNXaRHUMGDh7Z7vVmPlvyEeA3jYGb9ra5ooQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4261.apcprd06.prod.outlook.com (2603:1096:301:8a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 13:53:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 13:53:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jernej.skrabec@gmail.com, samuel@sholland.org, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] MAINTAINERS: sunxi: add myself as reviewer
Date:   Thu, 27 Oct 2022 21:53:25 +0800
Message-Id: <20221027135325.20377-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e5b7c6-2d51-4d4f-30ac-08dab822b01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muKlHvYogx2m8hvVSdeStNCviuWzOo9Jfz5UXjH0K8ddQjhIHaNeVJ2DFzi/mYV/0QebLuMoCjpMTpSylK5x611YA7p2G7PcLLiT5an486daUQBJqqrwTCTfZ4/9sHUL33WhZ6rPFImV7gnf7WfpasJlZx2EcO1LahFnbQLSvUX1LuPo7G3ZMrRa/2f5cK4Gtkf/JGwY5FGLDkL898kqR53MEXR2bVxpdLiUsCnmuS3PIUsg455nuXh2xICbALJ4QNx/e8OM6bHPom42RUTj/CQeCM4/wp4GCyMcrANJPeKGCSKGbz4T1h/FEMpDqqPyezuTNlNKQVZwaYQ40bfKdsyXS+qm5zKMv1+ej4pUhWolXCqgPZ3DzJgUvggk1woI4mxOFUyRWaXolIlWc6q4EAr8VRTTXm1+e42oL+4sZXvwJ3vmt2BfIhZLCBbfJKnZgsesdMF2QLPT1Dt6ZA6fSyX0dMpQJM78lZTgbnNKU7GxOL7SjNLV8LEEM16qp2spRZGLG+wzOVHnhNrnf+5zpS51ovWNO6dwYknL35tZ7HU3zsgVFfTUkWlkSKLr+OyTXxSqvc4u8pi+zZ8flw30zM4AN7U4OpqrouFfFnTjNJFgBQkiahazvXyYiUy6XzSNOTK8sx9W2vNsONnE30pu/suTnbKGiynkPawgYecUjzc3bMB97xbPocOCK/qwxPdR5mOVamk+xmv1eUqFfAdkI+ci0cvQKfAJmV7eVfzBbh+Xv4Z6TCGyszmFFNBXc7kpKDVgUhb5Aj7uY7AVmedgjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(38350700002)(38100700002)(86362001)(316002)(6512007)(2616005)(5660300002)(186003)(4744005)(26005)(8936002)(41300700001)(52116002)(2906002)(8676002)(66946007)(66556008)(107886003)(4326008)(6666004)(6506007)(36756003)(66476007)(1076003)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmch+0Vep/+Z3adfxefJu8/LPBquVDHdYFPvs9U5zkAMnsXc70R0QN338aY4?=
 =?us-ascii?Q?agLMQyWfsvuxioUlMETe8kalRssJlLl+9wY2tpL+RvECEXD+X1frVGzLG6Am?=
 =?us-ascii?Q?spGR6iwaEa/8TCFA096I9O/xelVX5Dl6xfpDsrJ1FEfUJyCOMJSXC9GQrBFQ?=
 =?us-ascii?Q?Tj/2X1274EjTh73+3PPGHcBHTrXfhePhZVyfrXAsvprQIT/QU7rPk758YUYC?=
 =?us-ascii?Q?CmJfHOTYzn+AFbM6b4KCzUT6qu3R0+iy17gdjIXOzvKIAX3PBYrF70RWK4bB?=
 =?us-ascii?Q?y2t7asB41JhNjLXL6lM+uV9V+L0Zn2KJKvCNRyrg98K49rXKFv7waSvT31qZ?=
 =?us-ascii?Q?EDcNSMz81NGTlxnRg98mJWO+o9snCYls6ZLjB9tkZIO8AvJb2kk+T8teNBjJ?=
 =?us-ascii?Q?f83G+BhtLWVDcOYriTupNqEWS0ORxxsMGul8mmn3NQniW3IQFNb0/Fo6mook?=
 =?us-ascii?Q?v3nqDgwLjhrQbEU5Txfm8D/HBiXYsk9mwkv5HUa/WsRGLewgHW+c+c3JCFgW?=
 =?us-ascii?Q?TmCJ0GnQj4TdClYLQZfR6fiKBBxX14/XQGKO/NbYifk0xodKAvkPdUaD0y7z?=
 =?us-ascii?Q?XaPItGmGksEceJrVpLIUk3k6qNycczX52YLluykAImDZ4+kiSfIMA5WHxvY7?=
 =?us-ascii?Q?HpAMScnoJ/u31YZKSdv9IEZUciNH88IOQzqzO3r8SjmcpSRPAYqBhpCCTqFu?=
 =?us-ascii?Q?h/mvJlovNgExAdG6CzRSZFLJIlMoh/dJ6RWkIcP+Dq/+m5ZUWYD7e1K1u185?=
 =?us-ascii?Q?/ChLGH8w8rVQ3+Q3IvPr4R2Onl+owbroTFH70akV9FIWDnVH9rm1rAQnaKLX?=
 =?us-ascii?Q?9JV1q+2zYmyzZa7OrGSAPvyJ2RjBUGRaN8HTLh+nFIvkmO/JRhA6RVdHZr4p?=
 =?us-ascii?Q?bmM/gEstyarCH+9haCpiRuDZPR85M+8ncpqjslLxYpiwvj2+yg223kBWNu1f?=
 =?us-ascii?Q?n/8MxtUED0yJSRiHpWAVuGr9v7sJ16lYvqV3UqcRbcseaaE0LtrIh0LHu4aq?=
 =?us-ascii?Q?ezWupCHoTuZOi0fsndq57B7VCW3ayO99p1wkDn1pCkTyCPhukgHT0x6mhb2T?=
 =?us-ascii?Q?yrE8OqF0AelgZtfpjdCxwzQc+Ofib+BKfNIKgrC1XjwJq1X4xXbIVnreFh8C?=
 =?us-ascii?Q?EYs1Q/USTZQqpZcAaQVKQ1ZsljAQCTv25wPZCr1YZ2Y1o0ibF0bo5OeIZN/t?=
 =?us-ascii?Q?oZIDam2pl+Q3gKIG/BI2fuML662hIREzCszHmEhjhF2pcoG0yv5NKXcAME/h?=
 =?us-ascii?Q?Ecz7t/3FXZCrLRsaPmODerBDthlDyahVw2l/wVR+F/SvlzjdDX8NEWkLmY0g?=
 =?us-ascii?Q?O+vhGgFmBMuUEOX08UskwPuWK+Xf2Jf97cYFlllOoVvMC0yKYvJVJN1P1hL6?=
 =?us-ascii?Q?TxL2UGycl7thQdk2iAPEQ6q72Tf1xydZKVil3+wVsiPCgkF6h2Q8XOyPmXTg?=
 =?us-ascii?Q?Db5hCrdSxZJFdGd25ckuTBPU679ybtIK2PU4QnHg5VPu+A+HgtjRhJta247x?=
 =?us-ascii?Q?UvqBSH++74qi36rrfOzocgrjMxuOa1DeRtctsyAkXlG3Z3Y3yIxv7g45bP3A?=
 =?us-ascii?Q?aWZzbhx7bXJn1bpbIO3y1k0RnZ7ktlVfx6HAYUvX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e5b7c6-2d51-4d4f-30ac-08dab822b01d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:53:55.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2iA8rWf9HmKHQ2X4fI4siDPJBdRO0l+0FZ3fM2ZXCGibwQOtmSzN88u+XpjuTjdkBdRtW8SEFCpZngTWwLayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4261
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have contributed cpufreq, thermal and other drivers to sunxi,
and submitted a100 SoC preliminary support.
Now I have the time and would like to help with the reviews.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..c47ae114a30b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,6 +1817,7 @@ ARM/Allwinner sunXi SoC support
 M:	Chen-Yu Tsai <wens@csie.org>
 M:	Jernej Skrabec <jernej.skrabec@gmail.com>
 M:	Samuel Holland <samuel@sholland.org>
+R:	Yangtao Li <frank.li@vivo.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
-- 
2.25.1

