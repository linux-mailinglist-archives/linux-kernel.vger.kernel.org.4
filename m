Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249A74948B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjGFEFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjGFEFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:05:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C811BC0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik8h5F11U0KcatljsPWGN4Ebi+4SfmBBJWM3fcUYIa32bRBTzTRa/w4zWBz5xG4zmdY6r6mB/JcMtpo52/lctRpQK5LVu2v+s1xtvEv0ExiVT3UX0tv2ILyHqfRekcbEByVGP6n8s4dOzk7CpReCwRxjKkgX94MIVPrdsacd9em7vRtsa0MtJkkCSmCgvdIFzUg9lnuZY9diz4uiL/R93Z7o/UXRL6AQF196dJBdFLtSHPXo7Vp7XQE3paJ+vnxJUp8XnSO/IIlASetpVri0M7W3dezd+Dhn9AOpuHWlqF6CU1k1Gu2V7YH8eCn81b5Zg9WsPoSQpwBJVXhSEaTldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zHhX2g1E8S3p0kvzrKDtwKLqNP2IrKxYRUxYn8U2ao=;
 b=gBlAA+SIp9TP+HK1prNJxLCFPkwUh2bdZh+A+sQlZiO2FQlh0im+0GqlkOGuUSFsYWdVu5BHm6RHR77l6LfulsmxkcPYx5KUf4rFyr9GXbOaS5T3XWs/350uzbuZ1iNg4h76bMxAQtWNl3uiPmB3cqzEmePo+EHGw59qJEyw3SkqdYldIwWEEzhzdlBDA+97i5bxHu6KHz7gxd/t9HLi9d6jbACwa7CRej2jNW3wm1hFo5CNBgvp1QAp3QHJecKULaHLk+4PCncXP3LpaBtuGIv5wRUj0Sn21ISs7/TW+CxEFkw6jV9U1Smt/J+UpWekOYjlOv9PTY3rBUSYmWElOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zHhX2g1E8S3p0kvzrKDtwKLqNP2IrKxYRUxYn8U2ao=;
 b=X9sICrErOGUKwgcDYG9C270O5UkS/7RaGYNV1/NfQjBe/quo2FAXv3PVtBXaHas+/tApqGPJ07Xiqx73aQuuVtSE9Jjm+EhnKHOJRWU7j9+tO1EQ+C+glPgVGTNeUoX4ci+IheblILOS7QVrd55RfmVr9dRBtH4eDham1w6KUVmVIfMAWeybITVDRj+WS8QUaBIQXf3WkoWHH6zdU2XoN94L2/nu4iPu01e8v8UFFO9BZZSUXL/67TZVibgq3tXIY8UuogbDoGzPmFqzqgLrhrwnYGXiilnijB5QPmCnLH9ELsQ8dwtAO/5yheRRm20dj3+TTNzIvFssXyI+eyyS4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4548.apcprd06.prod.outlook.com (2603:1096:301:a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:05:00 +0800
Message-Id: <20230706040504.34057-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4a253ce-40e4-457f-2d03-08db7dd6364b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BQuN8YsQlm2uNWf0U3ocj+NaACsylTqNTurApVm0aN1p4oJn17cMIIgL+a9sAwfOMCUyOU2yrLdR9lVu7q1lK7Q0KCBWGMR/Fde19VLrJ1Loe3MTIBikBn9ejqgCgtaRsMGGIRtsAr79GmySN6xGszs+4GVJhFFTUyH44nlZhwJ0afUNY/gQmWCAPw2VBk2MMAwNXcBFoSrGJ82x8e9hyNvDD+XNGyAnYTHg6wqh+y1eBwmMeYluWZRfG81IFHo/bU3Y8oWnyQhoR4mW7FEMSdplXn4TZNtnyJuyTB2eoujYzIbTtkQBdIgvb93+jWCqi1LDolfZQEpV2w5YdGv76UB0R87EWA0Rb8dwhaRNdlSyWcecKv7xFUmDHT/dk/sxOUeS3i3ssd+ben8IBl96vk7oy68RtrJ6UAbyj6OzTSr7lkzsSglOiHE9QrzrCs0jZplr8sEFLo6UaZmo5YZ7hMA4SfMK6YjMaVfu1eGO/RwNWXNowrIR/rI0v0zQ7PpnHDmzDx1WKgvMOid8C8LCERlDogoNL4uy1vZ7iM3Cy+VDWls7XkucteCHx8KyuGoWrjRlmi0bgqwtQEx7T+1CiwpCHqtBxMZsfQ3cx/GhAmTFzZhUBJMHKXZe6EVGhn4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(41300700001)(8936002)(8676002)(36756003)(110136005)(4744005)(316002)(5660300002)(2906002)(6486002)(66556008)(4326008)(66476007)(6512007)(6666004)(478600001)(52116002)(38100700002)(86362001)(38350700002)(186003)(66946007)(2616005)(1076003)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fx4KQVUPcLSSKIL05ZltOIF/Oz87aEBb5B7mySgU8nE2/h+4aWfAkxlq2JQ1?=
 =?us-ascii?Q?QkRsllvU6WhsPn1J82QmaGaKHsS3F7tezkRX4RYmlTw4zlycZaqxoa+vwQDl?=
 =?us-ascii?Q?nG1yeLzWFVNikau4Hb6bh4quDaAF70aYQx6ssphblf1VOFrNBP0/lZUQqHVQ?=
 =?us-ascii?Q?InU/ED9lIemIe1zvfhwOswtH8JzwZ0qi+R6NvqyfASynWepdmR0dEfgXMMP0?=
 =?us-ascii?Q?SX71UspiGSZfHxN4aFdSD+aLFETPv+CDOUlV8z1fWTn4+JbqP4O/8C8CMukb?=
 =?us-ascii?Q?67eUnXOrnBuQUZld8G24+PHUuhCF5r+kqV107BK8FwbYp2L7Hp+dhgse1Q9Y?=
 =?us-ascii?Q?9R+3JktlCNg7qq7gyLS9SMS1w/TUjTTVWAV+SjlCW186+QhXhvKEIQAUbEC7?=
 =?us-ascii?Q?NzeiJ+kBXsbQlss7lEqSDvfOMbBnu7XYPgvKIceg4vI60Gb2Jf5Xy8zsEL0j?=
 =?us-ascii?Q?jd+5rW0tBeSWhKEM1J4ALe49aoOLHln6oMR8p5p3Xmvx0103PnRVLjKQ3t3g?=
 =?us-ascii?Q?C/7M/WFBiqPbnO+XL1bppVaKRshHWxdLDJOQUun8ZQvUFkuBuvLDMy3WWuqy?=
 =?us-ascii?Q?4S1MzCHzJf3Q+ilHxknZ3ygjil4jGJIK4I8P3o9DKNrhW/fxILRrt0TfE4UP?=
 =?us-ascii?Q?7K8Ad5GcVdG5smZATUSLTcjwjccb6hjvpq7j6COCPhYlsz9iwRkSyYCtGVGL?=
 =?us-ascii?Q?ODwGhWBRcerimd5vYEYftVjLCwuyU3n2InBqu63gvGxL1TUd/lupZyN6q5Ty?=
 =?us-ascii?Q?WyPoRz2VuKjj3e503yfWLlLQmslW2V8ydfAs2HkfoC3PbflOFdTffi4J6c3M?=
 =?us-ascii?Q?RfDYCpx8NXm1cazt+L/47P+j7JgaxHcvtOwfGWODPUBiyYI9plsYvtr+v7Mf?=
 =?us-ascii?Q?557kCuwHEhgVJFIOBhaZ3DPSclzh3w7rOSBZwt0v+m6O0KvKm6i+jABZXQ7s?=
 =?us-ascii?Q?BI6X46I1W36AXGQQuy4OzSVP89WcUYPvf2BCCaJpq22CLS8jyN/3jSxhXjpN?=
 =?us-ascii?Q?hhT4Y+WTbHa81NrY37jQHrisswNAuyifogQBjHhsIRJxUDR8gxrB6XhmrBaz?=
 =?us-ascii?Q?3Elt/6r2lesVmi6NQqX9hKS/IZj8sf/P9dI53iAXpoKz2GXBjAe+0Rd0Yc4L?=
 =?us-ascii?Q?6ZyK9ZH89+tBpFwCA3rX6cPojRC6ZELeoebTv7JREY5I6v89uv1TJsn9Ad7z?=
 =?us-ascii?Q?CVi2KRTYtKiREkanfRz0feP6kaxASIGn/wNNFJZbmynTEesZtQrI8QaJ9BMN?=
 =?us-ascii?Q?DWsrysCJ1H7yDNmBJz/3fI07qe1XD2jv0Ip0KwOTSSrWJJqH13EoDoD1saOW?=
 =?us-ascii?Q?wk/S+CiZ+7ME2ptdiUEICqIiKvQdMLeX0jqY3Ui49x0kld4FEQmD1lbrv2a8?=
 =?us-ascii?Q?9KrxAap24/g8lDBSqdVA/kEJ5TuSi5qVY4thPnUjjAz3xkye0t8jIDCa6nDc?=
 =?us-ascii?Q?Li2IONe/0iBB1XCVfsTNvlWkJLFiORx4aE21FQik/kqcF8+IAf4+kuBQF60w?=
 =?us-ascii?Q?P3tKYibZ/Dsar82yLuyq0T4jXftG3DTuOjp5231SCcwVCg1v9EfQvX6UELAs?=
 =?us-ascii?Q?soS+5UP7W/V5TPHJjhhky9GV0yfNSslgnZZa86Bc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a253ce-40e4-457f-2d03-08db7dd6364b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:19.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9aYEg0+1zbIHQ/PfsqZ8H5Avhhhgxpn+xVhuuAX2aU0qwxo4Ebw5wdmGfNpbfmCWtXoGWbQ/NMriXdTOI4Fmw==
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/nvmem/meson-mx-efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 13eb14316f46..461e3ad87bcd 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -194,7 +194,6 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 {
 	const struct meson_mx_efuse_platform_data *drvdata;
 	struct meson_mx_efuse *efuse;
-	struct resource *res;
 
 	drvdata = of_device_get_match_data(&pdev->dev);
 	if (!drvdata)
@@ -204,8 +203,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	if (!efuse)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-- 
2.39.0

