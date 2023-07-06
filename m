Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFDA74963D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjGFHVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGFHVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B642DA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaTfZTNBrlhyY2jslFUHmsuhxnwbJfWocI7H3JJs/8mdrSCiZQPawcya83B0SMo9kxFh8MRY2+QWK+PdEbN92zm4NB7CNXIhgEMy+nLO/O2WbqTT3EpEERRg1rREwEmBWTZAEf9Pn/J4aDz2iosW5lFtBdrCcY51ynuq6Nn/Xqq/bY2XnecG72wmCGF+q5a9jxmLDCJhqIaqQQyNbYRp1fs11Wh30zu9f/MjTDi8KIR4WFvinY/KBIttDDEOROGJR0R8IhC1RpEuO3tOL6g+hGsfLoGallof2wA2oNBXV6p0XF6s7/oLcHm2k7cve54k0NwJqJ7OmRkM4YNs82x2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5bn7ncMehRBS1ZQydPUbDvazY3QY3oKMgwsfUyfqk4=;
 b=fD3M+br951bk/K8mnHzSGLPE/72XPIxM/0QHA0+jE1W1NUYnb1gseoUesW1AnX5pLVVb6tlhFB+650G/BKtJynz8Q13dkLNG3XA0Edh5G7feors8sYNVMPIyl1Ir7IxTjbKA0G3tufri3+BajGn7Gy1J6M1VC3mIwlB6Fx+uZodDidBAkVm5n+peWHqtrDYoNY7St6yGp2ttj0pc1URnnvMKuqcttcJOAB7wgwdRzpZpOz3PAtDNg6jXiEgQXkor4DJjo7moSXBn09n06cnUeRRlo73+KvTMv211ObYjg11FzgFfyuLAV7A/ZcpxZCENbC/fcwk3IVc8PqqEUbTYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5bn7ncMehRBS1ZQydPUbDvazY3QY3oKMgwsfUyfqk4=;
 b=XXrNyarQChU9agEo3R2VAysa1Fj7NyQ1FEmW3RgDJpzCy/l8jHv7fW57KFOzOPOuWzpEg+gXoQPwy1/5fvGDIZhiQ3+Tx8N73pJ1IxkAh0Q11jiBb9jTrZQHSo6pxjn/QWo5pUSQYf9rr4NtuYWxPej0T4N4Yjg8AhTr1rTKqsS3fxlDs+cTldHQ1WB57H4Mnv4HxAosPKhdfgJOoKlt4e4DoI3lJH7vzPObx+uSbgGdiIVoP/bRnuDvKHTFv3gqG5UjTqUPkyc2qEhpDzur1rOX3ZFPagXq6qgLvhjwR00FY3F3JZqMRnCHFyjpMPUr1SotZkn9DCcziXPUbDRpXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:20:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:20:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] bus: sunxi-rsb: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:36 +0800
Message-Id: <20230706072042.31296-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 388946c9-9a33-4ad2-125e-08db7df188d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w17lgeIe9rsh+SIuHw6j70guCQ3nIjbs/pEhd6c30zyOZc4Eadgx19TZqHHkZGFOzP8D5YVYq16X6skfcwgd6SPvdOqeJfkVNVHWxxLz9eDuHzoPC/lPLpiuolgWZb7nc93bNAnCYLptJwa/7MH/PYJTcFoHvXRx5oivO7dcoYGg9shBUVnhHrFkzAukj/1JVpg2kkyvDVtAHrtOtcxQ+mGxsYsdABIqgYq+GgwqcYTw92puMViekuTp/SEltSX1AOY7JRFxgrddvUtaW1kk9rfDEbvMXpFgkkM2A+gUbot0twIhba/g+UfLr6MHSYQpiTX7ukTDrs0kqlCOtFwC5tRGiRspl0R90t4iF2s1PBwCaVIkeWZx7B5Kw9G7bQJiiyU8WS6oQa/IgE05p2G5i4qVq0B4xZlUBlmNngIgMM1OhTlFSfbcXochiEHiNGIchJa8/W6ZuTuC+xfwqmR/ip9jV65JJ4y4/wEd4nD29Ba6IKOttC9G84I+ojE6cB8pcI2awIzAWDD7LG5kRzIeeLdZiAxWF4oojPgDPqIs49W4BI9HMjv5DDB+U8m8YC6w0TD1zJo1LIjUjwWS2zzFc0dBkiJBPAeCl7ejgJT5JKBzTan77ECKMQlKU1yTmB0g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(478600001)(66476007)(66946007)(110136005)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(4744005)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7ZDv3ZGFXH+T/JzlxzHvJCx4k8okAy83MtKpIkhPjxTAxLpCmgMcRQjujdL?=
 =?us-ascii?Q?QJo21zT44+8kfo657FOmhA8DaFzWPnRRizs4friQx512FqzPpMkK+9X69c3s?=
 =?us-ascii?Q?he3HhWesBQdQ1bVGbIsl+erDQRetZXnhzqql6/THyFIKWwxcUdZYkTWsxyiR?=
 =?us-ascii?Q?helEVQmK5b1MIj8pOMEtnnf9GhUtWXmzzkOmq+2xd6FB3jvZ3il8EsaVa6u3?=
 =?us-ascii?Q?eEvd/LVZ8oxJSKhkxOLi3XB+ENH+DiKByig8qyaXb0LXNcU+TmjAdjd9Fl+6?=
 =?us-ascii?Q?at+0136TTs78xm+gdN5dU+N1ydQoDetKhLwUSLZGYiQLpV7+5gYuLFgMZPKZ?=
 =?us-ascii?Q?wB+Igfi+wgdZr2glrXUPaO3DygI0d3ry8Y1aW5A5RsXvNZONgtdNEZMtedpU?=
 =?us-ascii?Q?KVYUDSj7K5uGVcrcPDnmsId3b0gJpKvtspNYxS2sA0oiE8RlE9oKi+gXioEt?=
 =?us-ascii?Q?vIrw+eB4gz06NmsoYIy5eBeMnY9+mQ86GUZAZk+4FvJmWWxGiYlez9SEEH6k?=
 =?us-ascii?Q?dVKem1fsbsFbG+JfmXcdqntvKB9myCyWiaqukzeazySO1B6ba+QQmUlYn1+b?=
 =?us-ascii?Q?MSWF7Va+nJaanFMq/awBygZ2m6xMOTB3LDeSK3yMIC+MwJfhH6e4C0Eyhvyt?=
 =?us-ascii?Q?PeDtVqrdCCH42thpfvNfCHuXBxuV4Zdkn5JyeXR2Z/f91fjDilOv3w7FYzZv?=
 =?us-ascii?Q?HjWfF7kgY+X9zVFT0k/JVTUGUTCd/V1q/A7g6rW09Vld5LVooWmCEC4TVtjO?=
 =?us-ascii?Q?rkElMGN7Er5qcaCGd3B29iL4Cbb9y/gmd6Qp1m4qFAuZHXaxxh6u/7TyymIR?=
 =?us-ascii?Q?p5Tmhv7M2L5FMJ8kezmUzG11jz33j4Z0xgArruhNii8WNXmeQIzVzMBQYlvp?=
 =?us-ascii?Q?lA+k0eXCoi11EKOqEQBWeCOwIqeEvr/wC4PivgGi16jACeh5U98fQkCX3fH4?=
 =?us-ascii?Q?4ig18GrDvyUO+0thEXIf+FZgyk/R+U0zWOfcm+WhYDKc+DZgUfZkRbW8Ml89?=
 =?us-ascii?Q?xaUjcdACpQnGE/z+mdeJ+sJ2dkeRWd5IeiEhSGYP40PDEVudHaHdUUSfLrk0?=
 =?us-ascii?Q?ATrENx6o/4cqlmaQZCRf6cVJ5Foop/xJ7KiEkGjl/+I7WzH0fbODshJsR526?=
 =?us-ascii?Q?As1/69gV0T+ZlMaK1O1Y9IT++FqMJB3ibym6zXA/BtPwLICvTwELykb5AhrS?=
 =?us-ascii?Q?NMwguWhkbGvOSGmySLV4n5VPkz6QTh4i+Vze+mPQvXmP4/5j9qlJDyLm/qn4?=
 =?us-ascii?Q?smZj3V2d/7zh2F+RUz9Onfgzu/Gs11sHCxXCqGammvjjueRTQCj9m7KAEBU3?=
 =?us-ascii?Q?cmoXF7UA0tz995eNDBY5a64H205qBc24rMXmvnY4/pV6Q+DHlrRzeSBWbRW/?=
 =?us-ascii?Q?3dGBtH7KMVUfG5Dfp+At9DJBMa+Hqv4aWydFlzNLBOts2yWCqHu1w3jQPjgU?=
 =?us-ascii?Q?pLSxTrJ0cyYX4rDMxX3Z2+PznmIWhj9Vln1TAmCq9n5UupNlUaJSmnU55vz6?=
 =?us-ascii?Q?Yu/8oaO+CR/RpgqVzrofo8K2lxr6xiYXqvG364u3Y+79n0et2wx7uiiVW5jV?=
 =?us-ascii?Q?RBghFk7PvOrlLxaDQvzNQTNULPLlrDOQraZaiaft?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388946c9-9a33-4ad2-125e-08db7df188d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:20:54.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcLVnFra98bzDKDwA/WPKRC6Dif1jMdLF+OUSFeFG0i3tQjRy7CI/ibADlcgUqgtJvBxfiYdE7NobTw460W1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/bus/sunxi-rsb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 696c0aefb0ca..2aefd5dde3c9 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -746,7 +746,6 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct resource *r;
 	struct sunxi_rsb *rsb;
 	u32 clk_freq = 3000000;
 	int irq, ret;
@@ -766,8 +765,7 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 	rsb->dev = dev;
 	rsb->clk_freq = clk_freq;
 	platform_set_drvdata(pdev, rsb);
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rsb->regs = devm_ioremap_resource(dev, r);
+	rsb->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rsb->regs))
 		return PTR_ERR(rsb->regs);
 
-- 
2.39.0

