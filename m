Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53A5747C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGEFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGEFYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C631709;
        Tue,  4 Jul 2023 22:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llxMZon0WOgmTwTHH3aN0klZT8Aio8WXB5MXgQ7mriDbcv97bEIbrpf6Am2DQ/95YjAFxLxsszXEnsfuGNEa/S2MzsUbvM6PsUY+DHUuaVTzZYjVVv47Nlzn/drjoWTqAqel0b2meLp7mhwFpmPXXj/FVq3Yqn64UAli/yw5aDsN3Bz2SuCzfVcuU/J694kgrYVEu7KTYi+0pZ73Erijk3hHyRawnU7gdb88gIR3x6+O3xV+lyL0E93SLGnEH9QMIl9MFW5rCoHm4z8P84/ugQy9JUguRbm8hIOdw4c1FQOHQbiqfb7qnoqYpBRkmdt496e5TA9QIqF4+xFHtpZQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvLMOax5iZpOte/zpQRvsfnlAHHKBS+sP9SMT8riXMk=;
 b=RZ2zwLT2JtXUnroU/Bn6ojzQmScU3u5ojuU82AYr7pm+V511pT5HPfhTwc8M1v634J/xhvBYZFyf2fvDW+BoB+sXDhzz8jz5BR3BukkNcgQLPfbQnTVa3HwPf6DzyPaqI1V/CYGNkLqqR5BtZQ/8DsY0xJ2gxHYYQ7YFHNxlxt9sh3LcGfNCtookuSieNKBZYXnlf8mi0pH3NiUPYzX0xUWRFDZAbECLQtA9ZYQ3qdycVIPyVU7QmSPOw1NVf+gRbjTiAfYkiee4pRUv5e7vYbqZoT8n1YWjtGiQ14YXFm+HQTv9ixWtEQGfdhnnm7ocIYCd5grlVIPvS19Qb0zU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvLMOax5iZpOte/zpQRvsfnlAHHKBS+sP9SMT8riXMk=;
 b=Tz8EoWAsm/pgynZ8gQtFrL5On+NNstuYF7iLUrm51oo+kz5uk+WUX7tAeehp/UKfVcU2x9a7T5C632BM24rNdaYr8Wz6jZ8pXk/K6czHaj3j1+biTQUfgyo36NEeDUErVDv2JLYoLhGYTongMvCyXoDe050Cl05r9/oiLW25lseLsmSvxGCIR9BMWal8vn+38aDXplR1+vZQpVSaBR6KGttC3M3WnQLst8yJZd6aj6+AqBLd3sA5AAGTPUc9hywLuaBMiYtOAvwIxnbvKm4RtAlZ+4bcTU5pVuKV/jRLe9tbDw4Xda3j4HoKrdYNcYfilfbP1tDkBJIt2gQpkNusIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:24:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] Input: pxa27x_keypad - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:42 +0800
Message-Id: <20230705052346.39337-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e505770-d7a7-4932-8276-08db7d180ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5wWDygu04Org2PN8a44Iv0fr4i80AS5BZDUIFmRYYxdFfdUbKwD0kh0afsUzDXYfVgfBhTzzLYLEgN5fysW0RnP1aqAVVVX4h8C+KgRQvJlYX44faXN1bJEWWudF2AIKHMl8IPHRrkjIxh4ogomYpiA7PytFY5VRy+9ChU+CqFDWRpWB3PVEAco+5oTZqntceWI/7GxAt3jAWoTc6EjTCUnTjha0B5w7No4K71bHI+KVX2Y0itMh11sV6AfdARt9Xqte21vsl6sp8xdTnrAaWk1lWtAHvDmlyrlNiaIxvdBDybJ00+0ZIF0Z44LnCt7VdApSTsn+NmzC/TGNPKZGWIlAoEO3IIKwiPi/O8Uu6hbBndG0as1FY8A3W1EET3/fmC9rYaMjGD74alyt5THSBQLmPMBowGKoN291TVOuQ3MyYci+HCIT4CZSRighz4qWX8q1gve0dpyUJIrDyA6yXuCK5HqpiLCP/kK7vELSMq+MXmj5wAur8bsbgN57reiC6LU3zSdEY2iuI6AtGgYf6/VaDd5NKBgEIdjElC8JcKIHBsuJLZylDFWR+HrlNMXP8xc389cyDww594cZdAAiXnphKCfju+qNbBvkeaWcJYf026jwVOLjpRMY2whfS4C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(6916009)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOBCaci6e4dEZGbpqxgF8wX8fc45OKAjNXF+Es99BHwFIAJ1g/T4NKXBruSn?=
 =?us-ascii?Q?d6Yr5MP7a78Yqc/EZI/ifCSru4kwAUVV7y00uJaLgIurGedQT7456tbIgdN9?=
 =?us-ascii?Q?fK/VOCMStXjen976VZBmhMW0yR4sqwcKIL3W6jvPR0AOY1HRzFu1u+/dbOhG?=
 =?us-ascii?Q?tADyNxVUBfxeUgNIJ6GLKGBU6i9thmhj2etiDGiN3h/X6V+iychn5K5AM2RO?=
 =?us-ascii?Q?MFu8N25PRMNK6Ag0iJ+QeaqZLGbaaIuEQ5mtgOO4vPT4rxDBq/070Ls37qHD?=
 =?us-ascii?Q?A9fCkU6Tqly30B546pRO/uQLmCwjZR/aF5TFqlcMz7YMAv/4GUeQDZiklD/e?=
 =?us-ascii?Q?2oHec7IX6yPwTQM6K3qq9eOAAfA2xG0lDII/OAX8FKWnAB6IRBQMZy31cocd?=
 =?us-ascii?Q?SehSZdavNkNbe2PDqtO1JTGL7uyWgr/r3DRrFRX1LKporjjx9mL4xkboGztd?=
 =?us-ascii?Q?0pERjWnei990xD2M+5TwCCOUZ4755FVcdne48a4poHYuJOOVF+61uTr48mwD?=
 =?us-ascii?Q?XGIfhnFi2WSvUdznopDw4KlVd3lNMvFF/XxDiDPWF3ZjvflStKjnbpGf7SjZ?=
 =?us-ascii?Q?h0/Pn1TkqEtVgVT7iPE/y3nY7YiU7KFXqbtYohiQyO2nH21Q3zYokN5hiF3d?=
 =?us-ascii?Q?8WpSiXR4cdJYCvyoz41FxUEldsmHL17AgipCc2afV7nw4mBGny8MvpewIhjd?=
 =?us-ascii?Q?wV4q2VvmwLhIuAA+N8wmbGkqiTjnBUDPeYpeRC2ZvF99xPYDiK1M3Uu+iUvQ?=
 =?us-ascii?Q?CxmWeyonuS/vLrw/StruSxr7b2Nl3xgn54DiiTRcLb7b5zErskhhdOdTl/Ht?=
 =?us-ascii?Q?4UNfSKaD4PVU34AA+cHLloQ0StKf5e9E3HoN3+uOrrk0MQVTkq4FXg7O5vHP?=
 =?us-ascii?Q?WNg2K1BjWuYZF7ExVhAsAPdo+4qKR0rixgCddNU0E1xdM4kksrhzjAf5DUx3?=
 =?us-ascii?Q?aBpAY8ibsd6LT4FXb49FlUU79IvOxNqu7dB7y2QW/rcQgIkSjIZS879gphsY?=
 =?us-ascii?Q?puM2r9+g6K9KPPJtUG1lVBpWzZLUQ+yxzim5/WN45wHUB/5BVXDRlBy1jIWH?=
 =?us-ascii?Q?KsgNttpSI5srOcUFS0iw/DpUiEBFfaLklI1kv6ND/Y6U3vhLOVMMoNBip2qN?=
 =?us-ascii?Q?L5pRJk3jzWwvYXfYyNu+q8RgW7hAANldaHYjcTh96UFfxgZZqG29EoKSN2PL?=
 =?us-ascii?Q?FzRDQFyOAKfgu3aaOFGLGqFEPM9ADcmEsX0JTzu7wB7ThwbC/8caI9SXkWLT?=
 =?us-ascii?Q?16Mt8c7jxfPQ7yzTB/hglpHRu9fR2Xlb8mu/hcgnsLre0ToyWmNKBmDLr77H?=
 =?us-ascii?Q?iVY/2LEEcTxXdg19ITGLLGlSUNFhEFiE8jysvPf2KPDbUvpnJWJyb6kBGDSh?=
 =?us-ascii?Q?eQWhx3e9aFOT+AwaC2BfuYdPY1DFNr6hoTFPjXSQrTEWwkm+vfeq6nbfWIVp?=
 =?us-ascii?Q?qKC4Ab+hBY3kSHod5yzTBLPQSFsdtxheN1L6NBhgwGIx9vLJrHSzoIhLUiHJ?=
 =?us-ascii?Q?s+DT+aNnTS3RZJEh7qhuCCUVUkzM/uV7n5WRHotd3Abh2DI0F1YeCLfK7FIB?=
 =?us-ascii?Q?KUHH9OuKShiKaNDg0ljeC3cNDQPXirhnPLieWGpo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e505770-d7a7-4932-8276-08db7d180ddf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:06.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IMBQzgX6OrOfU6Jje/wygEZ9JCrMOnFjgB/9FTSVhvA+Xk0PO+EcL+5uuyb5raN82094CPzj3SdLsypN7Yrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123
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
 drivers/input/keyboard/pxa27x_keypad.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 871f858d0ba7..3724363d140e 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -717,7 +717,6 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct pxa27x_keypad *keypad;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int irq, error;
 
 	/* Driver need build keycode from device tree or pdata */
@@ -728,12 +727,6 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENXIO;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
-	}
-
 	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad),
 			      GFP_KERNEL);
 	if (!keypad)
@@ -747,7 +740,7 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 	keypad->input_dev = input_dev;
 	keypad->irq = irq;
 
-	keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	keypad->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-- 
2.39.0

