Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A66E433E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjDQJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjDQJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:07:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2054.outbound.protection.outlook.com [40.92.99.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9049E2;
        Mon, 17 Apr 2023 02:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E91wi4/0jmWoN3Br9JRejB/TIz4SRuo59NUymOQ+AZW6ARpqyqJc/45noha3hJhgKk8oNhupUn1fzMoRpyuKQRnUYyLQh9HzuwvinqZfZREyddQOTE1q9Cl5GIPBaWBrALYmHgKpqnZyrEPyqcO+IPDHeBwHau7t4O9gH5Wz/DdmZwT0IB7waNFYP2qXYV2rUCMsVjqx1/NMbwshtfGbBNBpg2LNQz4jkiXT0sfjLveBx+fK5Ba2JWqZDxUTcPNOo4YAc+kqmATUcer3BcWk6wCOnaoNd/9zXwUakRcRQfQw/s9coC7baFbofrT5NObd/OLDfyjQEgI8N7W9Dycknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyUvM7fnXs5sxLfjuDrj9mqgJ30HXmiSWVpFzs3KbGg=;
 b=fAeQF/y9iuHhTZhz6hm6wyxQt1qp+m++SyvzZTWo0Pc6Zcw9GEC8CutQckHvpeZJEeqcpA+CFvfpmwfMQmjizllPjUdIRSFC2f9tXiT0Yt9YHw2xEEwZLRqQkkSaVOub5IW2PGE37YRiQte/dc+Cla8J48emOKLaMsYlR8gsm1nB2hTe3HdTFb9fj9XmEgskl+Q9tFYzMQq4ykxoiPQ6YI3cilJmQzk+jXvD+MMB38F8N4swFxFKmyF5GcecN+rPsILAyL+vfKauwRVezz2M+0Bg7oVmOm3ROwx8wbh3imEBJs7PB31WY3RLQyHezLGNieYMZ25W9h1CJjUmtf81ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyUvM7fnXs5sxLfjuDrj9mqgJ30HXmiSWVpFzs3KbGg=;
 b=J+NBxdjVV7kFzBRZyUCCcggecCnV/b5pGCm9WkfDwdGNY4wx0jMRCdN1enSNTlPRH6btKE0hGfVUbctamCJxjmjLrJvXiqp2X/jq8OP8gToasL4cJhTNetOQMlDK6IJgmPMRFSetfJaM9sHlQ5sxFnOX4E9/B20NKQsSorrUQlC8nhd0FQP/7YnyX3S6i4M8DCpV+Y5eN3N/82KL0eKcng3NFkl9oYt0RNwN6glYm32Xe+PM27D1B3A5/NO7eodrjoFI/yVUa8au5BXIEkUpwduqK8cfaulHPTHgka6sDzV4JFBGN04wPft5KrVSQS6OgLYKFTqQlp4Yu6NyZbtrdQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB1989.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 09:06:45 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 09:06:45 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 4/4] regulator: axp20x: Set DCDC frequency only when property exists
Date:   Mon, 17 Apr 2023 17:05:38 +0800
Message-ID: <TY3P286MB2611527CD760DF6ED30A2901989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417090537.6052-1-wiagn233@outlook.com>
References: <20230417090537.6052-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [T0K7JouQ6ueXFpbecMRr3dzLn3eACpD1]
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230417090537.6052-5-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: 9726b4c9-7c13-4b9a-05c7-08db3f231139
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmofvZvLhntBlNaxIR7rLBomeB3X5LZ2IiYd8dznN/K6upbSu194UBR8WEAHLkmKDTJq8UDP3qWxNgxbV8F04f3MTflH17Nz1QeRCDHzA5klscS2OJ2y6kG6ZT2fr9T4Zg5LLCpTkF5Gw5QLoNR64jR9pUDoje+waN5OuWwIxk8cjHqYr6Jaq+Hx1dM9eHGQziZ3Z00bz7bOCEkbsnJsSyXALW9pf+2lgH1YntWWjv/xm1cstu5XgKFt1FcYMyIIFJmQfA9bAqhMLbqGiIWZFEF0SekbGeO4lcOCWuia6Y78KrluERt32e1PeRO3RC81s0ARIwaVyOATw5EHTnfAjGULm9tR7Wr4NQsSZFynftzdDy+izOf9oO2s1MPj6hzx9yeNSwSq36wRR/akONZ33XrVMEzpK4HbkXyb4M6TbRDdaSPNwqcUz4ZuPliS0e3OWxRdnvSjDIfTNdAVXf02N56XMIaDPTiL1nxA+Moa+2RAqUdCCJ1sd+jtf3P21IiW88MUmILezi57kWKk2nkk3aYEJLDl/3wj21UJl6J40OdBkjEKyXPwKmJ28Sz0mOcG3jrWgIfeVekpTErJpYUTyJcXis8sc6qH/vNESfqG5tqhud8lykmUWxQ95lAc43gK9xkv8YXrl/fzt5fuX1CYpASpaZmzjI5bdD2IARDEUPSRS3l+ghRekyrWuZBwp0/R7Q5q60PpK+li5H40BGDTfdxXHh9NCqYMfgS5OdVRUosliNMESKIC9keQ+9rSSmgX07Q=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg/uLErEUWaLAxUyF7t/8Nx+ujs3xBUve9j6+jVIGzuuae6VEbvH6aOcZ3Y4bat7PSrfBz9AzA42Mtj4S9k6gzNzdtphF3DrKLJrJt/HA2pmcBgeV5hFXd2Ea430ySegqvaIcp22TvQ0JKDGomGxh0R5nElqeapU7IC25foRMYoQFYzzSlswtGd6T5YjM8ezzSuemgb9E4gYLEYu6183ZS5EIEHAPv9xwpRCBnnB5y3O0+BeLV/urjPMeB9IDnJYIuVFcJ5/qDfLAjlBX9/Rj3rgBeT+Q2krTlg3NdvzSgwMtfw+MKKUpvV0qsBp0qN+yYXrd0LZIYKponDdxPQ/GVd6UWfJf9goZaCpGGw6m5QNZsYAvwHim5ESHLN+YIWuqYvTVBrgkEFBszifuAqffM2zopoZP0iXUNS3usKAceNFxeSwJnOMwKGvGs+fcCgcagg0ShYxq8OHASXNx5JVazjtew1y0Vkr3LHDLYugxOQFvFcFpamZWV9Hvfy2APvZZSBhK9v58bzVXqNgY3Rj8vh60jxu3737G+T7eBZhTj4fjmN+Ru5qTsjX1J7S+pJN6QrBY0Xx37ywZTQ1dmnSyPaGKClVFrz3r43Q5yNlg/0nZZYWLCT5zcAexbAMu3GN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzfKrMh+JGw/bC3GIcam3BG0bu6A+UWPqIuYs19doI7CYkXKt4dSGs6mvROo?=
 =?us-ascii?Q?pWuP/pU1x5OIQDoZRj7U4MaloKgN/ng9pgUY6V8LjzujNNBSe7MmmiJ4ZTpj?=
 =?us-ascii?Q?NQRKWXAX+QSrHrqs/bHBPl8cYpMhTuZYN5KURv3LZvwPfJ191yvywLBg9iGN?=
 =?us-ascii?Q?hKngBSjf7j/jMrAkz2dtdJ+Lz5WPEtPBB+nvfeHpqn4x9r2Q0LkQ5eww0bbr?=
 =?us-ascii?Q?fjvAS9hOecRf0Ms0imk2vmfvXzLHj4W1koLOP6qrM6UqtGC0mF4kLbBJDF/P?=
 =?us-ascii?Q?SpU3654aO8nyY/FMcwbrJm24d5ZoIZ3kBhVvGZne3Sq2eE8/+o7RrMpxuuUy?=
 =?us-ascii?Q?piBTQ1aR6mtrASfrY3pnFByl0luZ6gCVIayXjzSfm+WS2CFdZqJ2gCjzWQIw?=
 =?us-ascii?Q?CiJoF3lRe0qBHGDj6AG0MLC/T/TQspMpvte/vP7j4drFsr8oIBDBUF/sodvc?=
 =?us-ascii?Q?wtKz+44l7V4J6fHCbLjY7U1Dv52wLfUAIKZCKDK6mU/NwX3kxOKibPE7o4u4?=
 =?us-ascii?Q?b+0XXrN8JZtsRAortQ3EiMWX87osSSnIsqPq4w45BQmYydaGuZUGzpqv1F3Y?=
 =?us-ascii?Q?0FCbsUlOmBEJ3wSvsmA0BvlOg7/5uKjkYpMRxf1V/wEJEY5PtplURTCtFcrM?=
 =?us-ascii?Q?RjsaTR/eb7s0+9jqCF6EP15gkcsilSQ1FdRzHOmUbeVyhYW1ptLtcuT3xbLE?=
 =?us-ascii?Q?S9gbKlkpahJwRU/P2pPOLZw6byxDV5Q0O1eTJrMM4kjbrOAVZCdwnD9rA9Xq?=
 =?us-ascii?Q?dk+AzaH6u1PhgpuO0naB+YUkAr1Q52Ch35SKAJpXsLvzVVFR+lyxD26lOPC+?=
 =?us-ascii?Q?SbjhYm3oV/ifJKMdmj7HOCQQ77aIcbOq7GCSTXnL2WKUEt2ggxuBtC4+ZjJs?=
 =?us-ascii?Q?EWKKC1shzT3rmyO2Lvg63N74oGDpjhW/6pZDMYpg4SBQ/icsJX5SDBcDi9AV?=
 =?us-ascii?Q?erTbmchgdVhjn2INeq9a6k2QYCIs1Jsk1iSsbOgGYfuBsIHweblZUHgDnBCx?=
 =?us-ascii?Q?ftq+L759/k8peYHn/goI/07eN0nWOZBmCDu49rFwc0x0DcPW6AwpGLs2cRg9?=
 =?us-ascii?Q?dASWLYzpePao8a1hY0CTjNECcOzq8xP7Xy2c0xP/5ut+IrT3+U1aS02InGQ3?=
 =?us-ascii?Q?zJxCQmAaqXgLryS/OjGIYPOU0KX35HyBC78SZl1Pflzd5ympqVt7mU8+k/l3?=
 =?us-ascii?Q?P6N8FkbLoi5R4BMUGm/djeQqJMZqIMCiilP6vA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9726b4c9-7c13-4b9a-05c7-08db3f231139
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:06:45.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB1989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current axp20x regulator driver would always set DCDC frequency even if
there is no x-powers,dcdc-freq in device tree data. Causing meaningless
warning info output on variants that do not support DCDC frequency
modification. So only try to set DCDC frequency when there is frequency
property.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index a4564d3590aa..68a22e3e6e0e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1247,10 +1247,10 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 	if (!regulators) {
 		dev_warn(&pdev->dev, "regulators node not found\n");
 	} else {
-		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
-		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
+		if (of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq) != -EINVAL) {
+			ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
+			if (ret < 0)
+				dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
 		}
 		of_node_put(regulators);
 	}
-- 
2.25.1

