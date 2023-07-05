Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54B747C67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGEFZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGEFZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:25:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4191BE9;
        Tue,  4 Jul 2023 22:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXyF+G8knFoXG6iKThUvocFrbOIll35uPdVVyBqYevkclpw1+cJbQA0tluXxYM2+O8wjJPRM1R/INPEG0gZQR4RtcteiZO+GDnwK4FJXlHJ88qxuGNou7DWuH86Qsc8ajvAGWejl3BSVKdxAJBtmKJ59W3JM1EDQLBfseSus03ibuAu1YQHAxmNqyEPXUudAS0TSGL+AA0ulaq0psga0KctrqeKE4WdiJXui5l7Uv/js+UdwNl8Za0sQAU0RzmD5TN9lz/9av60YOGdp23/fxbpVHKn8+8oaLJZ1K7zzW08fe1uayCLVeRM9HCjiwJBnkCD+mwyFDY/Gb553aWxOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CxYlipi5yIx32FK1How3ukb3KrSmIrX38LmE45Mwhw=;
 b=YB0G+onFVliuZQVE/oF9uOU9FoR1+6V3apWiTOW3h0QvNf4Zv/LPZMgJOP6ORdEgxSTCB0cjmCwtQ1edNNXTycXeCDgdyyjOAsWR/RbLaSHe8hycV76ttBqmYg0EyDxXbNYWe2zjT1p0VD0AhG/US+4C/UHld0ZiNGIFDHBRW8KiKoUHKxWSOcYPVhI/KNq4JWnePiMBs2N5qSFSteE59GEJfpQC1yy1oPA8niNSYhr4fpxrXXekpXwwB/L94X1CVQ5NxNzSF7btyYUdJWms+0tVe1UTpFdMy5BSQM5cfAQn5QFDtSIYmRkbtZStgaw/IbMJghsgQwT+tv9RD0usJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CxYlipi5yIx32FK1How3ukb3KrSmIrX38LmE45Mwhw=;
 b=BKYHWHZ2ju6GlkSKVianvoCMKvhh7zvPFjkv2jYNb/BoRMjxx+TuKnZzhHo0RXKX+b+G+ce61aEs8lsB47sRq17eSRaN4U9UJdgwETEoye1ZhtXebo+CEOyVWNiuaKEXTeSl95MB3MGHj9ucj4o+Bf18V2EbfmCrkPj4lxSbbK891eGJHJa/itOlC2NbHcTTr227QVsIAUxLc6Ozi1LgVKPmmCDlq3RLbIpTPO2ckKkQaTj6OcGHqO67fWs5dFYJOjtvX3aw/UM+RfcuJNo7Ec/6JAWxNulrJRYgU+pm8SWor2sS57UDphbtdTH1j1zghgU756u1Kq6m3uOWY4bjKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4069.apcprd06.prod.outlook.com (2603:1096:301:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 05:24:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] Input: lpc32xx_ts - Convert to use devm_* api
Date:   Wed,  5 Jul 2023 13:23:46 +0800
Message-Id: <20230705052346.39337-10-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8226bfc6-1c0f-482a-5dc1-08db7d1812a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgYVzOzmI0oD8qk/jgCnyDms3wdaO2xhVpINKSlghL83P6cVTdOQf4hfz8J8bQz+k0nOd8OusVTbSBhAbaHq9yA1sFFdAwdN4cfyucgxXX5g0ZKUdzdABKJYF25NkPn1rkLduIKqWt7GywtXD2tpJIpooQcBSq5X4luye2sPWryoW5ciYXJptydywmdD6byfgSYQoRb9iGWtsHSWRSs0CdxvEkK5hliki5uXZLs4mafMFJWIPU5s7E4BB0T27tWtNfz8CjMTByTCOMFuAyPB9wQBI5KBEfMpdnI96VJPk8U/OLqoRKxYzsE74sm0wD7078eecpFV2Xyrz8BMh9x7OOoMNp9fh5Ty65rQmzWkNr8rMWU7pD0t+o1mhmev7VyMD4IT2LNV4fRO5yOnBJVjIU++nq0D4/VSj1NTIEJ2xor1KVVjJLH5NXTfnqBIe3ooRYsugaop+FbwSYA5iwhceQHu1PlbeZweIgu7OaGivl0TLqfmmOM3xOutnpNMyUJ6aiq92r3nvETPKDhjqFsexMMQ9GqlhkrWvQYKEOh3lxEFVAHn5npCyBnpxu+4zixU+bCbHuEWVPtvBYymi3ZPqmEQiq1Q58N3cT6FeSe2ILwI74ezev6THY1rSlKdK2XL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(376002)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?32ixnQGnDY2JkgLPTznB+WU0PI/sLloebq5jQdVasTiWktGtt0Ii2qv4o2F8?=
 =?us-ascii?Q?jgAKESDobfS70q40+nZI4NBH1x4RUot4W09sJveC9QWwLJP/+q7s540zMlWk?=
 =?us-ascii?Q?E018GBIVurzIIycQ7rnTtghnD2R+h40IQEm7xzNTYxrKOKGJ2RN18Zt1k885?=
 =?us-ascii?Q?mjsEt7Ua05c+4N0mCXMy/M8YIaOwsDAl3dPGqIb1/e0e2prlgasze5bUc4Ei?=
 =?us-ascii?Q?ji/gdUbRTUY31crohVfpVuQ6nNVoOmGA/TpFS0MGj5jA3OTLqkKedMDEsBa4?=
 =?us-ascii?Q?S6JhmXFdbVTrsa/rH0ghpAmvc2oYE6T42Cm7+wEkteZ5ez3zd5gf70TbYdGn?=
 =?us-ascii?Q?evUu6Gbkj9vFf9bnljF5wt3SQMaFn0yfidczQR3qR7PhCww3rYnPKv3qmYvA?=
 =?us-ascii?Q?kcxizgolgZCsYKL3lvlEkMJF0EVGXVLfYb0OW5cCbGaBuYsIeyFZfv2N3DRj?=
 =?us-ascii?Q?VdxTg78pX5mEdSlMKEEh+d1qrRZzMTddSTYoqN3rbsWiqiyNvfGV8VdB59RZ?=
 =?us-ascii?Q?Z0cLX8V6jzK7ehysMGNwVHfmLAJcsbbOCbbn0DlurgI/VFufSKqxHVFtsF5O?=
 =?us-ascii?Q?0H+hlvZB9ss4jquJTgKJgbN/BMioJBj09g1spFg8czFZxpwDGlLJZvl8J8F5?=
 =?us-ascii?Q?wYQ/cxMwBMCCu4QwFwqdDU8x0om1lW1VM9cXuv7H7vlf25lGYktiu7NTrhSw?=
 =?us-ascii?Q?TuRcFXXZo2wxr06os7zOfbedrHFRyAnZW2ufuWEtuAD/kiMSu58KPCceytRP?=
 =?us-ascii?Q?iyUBTXAvY6hXGatA6ggRmZFH0BWywRhv6Fz4bPclSziDtAEpsQ8TFiUFhUWB?=
 =?us-ascii?Q?5Ba7qII5elFFlTcpJKCx6tZquMltd+ubTV1g9ND+9mLFzqfrnCbeNI5AI/gG?=
 =?us-ascii?Q?StWFNcYA27uRreGLgCSxD76fQEOvMbR5Gs/7P3ByOTDTgH5PnSjeuRGzirtT?=
 =?us-ascii?Q?q+OOdoQTvjfw4hm1XOH7MQxu93RrbfLLV9JLbqWzqyLQUB/MOrpxdSaKtebJ?=
 =?us-ascii?Q?p5YqSDTR4E7ZQyKjA/5s/dCI2fSXj02dHLMIex/8Rd7EzsU89qqu95oQXCjC?=
 =?us-ascii?Q?dmjtbmRDsa5d79uF2dGmOrrhIm4VJPnsvnsPKjq2D8d9FhFRra7H2eRe2zpG?=
 =?us-ascii?Q?Dt7h040tT6qznk+JBQIWWPvtn+TzHjxFuCZkQOjdx3IIOLMNOPiyc9ldq620?=
 =?us-ascii?Q?R3+9YOgx6DTzGoahXWHWR445Mx5YAiHI1FnFBjPLDttknNt5t/Y4h3XFCmPj?=
 =?us-ascii?Q?SC4wii/jxQ0dMpbFrJhOq7uBn66T1dEaB/NmiHAHuK4aOJzKtJ0t1nuBf/Uf?=
 =?us-ascii?Q?3aGy6mqbjjHcMnL4Wio5WcbFHFHMxvbEqjULqGijZd0qWuu0NIKmg5NyFQsf?=
 =?us-ascii?Q?3oBBH+c8tmPJBdTh87bx/t3Ffw9r3RukqSYCuQYWXPEIegq77O7GgItTAAXi?=
 =?us-ascii?Q?E9uaFREviCmcA3i+XX5X9eWNLfvIe8xSC6gLMABShiq42n9oXXMxL9Jf0v6W?=
 =?us-ascii?Q?cu0alh2cPjalDqsbopoLUHVmu5hQ+rpERm6RO4L7+QMBLQieREXv3ITyMu59?=
 =?us-ascii?Q?s5aT3JEY2TE7PV6VOICfdbQQHENAxV9QrIJcWXKD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8226bfc6-1c0f-482a-5dc1-08db7d1812a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:15.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHUydFxrhfKhfAltxvIWmlqn2pBt2SK/UJs4Q9Qv2fDKrBb47QPVoIVL2qtfmTBs9gVM0fsoeAmLSX+1ZlBgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/touchscreen/lpc32xx_ts.c | 75 +++++---------------------
 1 file changed, 14 insertions(+), 61 deletions(-)

diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index ffdd748a9992..d30ce1380f72 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -198,54 +198,34 @@ static void lpc32xx_ts_close(struct input_dev *dev)
 
 static int lpc32xx_ts_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct lpc32xx_tsc *tsc;
 	struct input_dev *input;
-	struct resource *res;
-	resource_size_t size;
 	int irq;
 	int error;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Can't get memory resource\n");
-		return -ENOENT;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
-	input = input_allocate_device();
+	tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
 	if (!tsc || !input) {
 		dev_err(&pdev->dev, "failed allocating memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	tsc->dev = input;
 	tsc->irq = irq;
 
-	size = resource_size(res);
-
-	if (!request_mem_region(res->start, size, pdev->name)) {
-		dev_err(&pdev->dev, "TSC registers are not free\n");
-		error = -EBUSY;
-		goto err_free_mem;
-	}
-
-	tsc->tsc_base = ioremap(res->start, size);
-	if (!tsc->tsc_base) {
-		dev_err(&pdev->dev, "Can't map memory\n");
-		error = -ENOMEM;
-		goto err_release_mem;
-	}
+	tsc->tsc_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tsc->tsc_base))
+		return PTR_ERR(tsc->tsc_base);
 
-	tsc->clk = clk_get(&pdev->dev, NULL);
+	tsc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(tsc->clk)) {
 		dev_err(&pdev->dev, "failed getting clock\n");
-		error = PTR_ERR(tsc->clk);
-		goto err_unmap;
+		return PTR_ERR(tsc->clk);
 	}
 
 	input->name = MOD_NAME;
@@ -267,58 +247,31 @@ static int lpc32xx_ts_probe(struct platform_device *pdev)
 
 	input_set_drvdata(input, tsc);
 
-	error = request_irq(tsc->irq, lpc32xx_ts_interrupt,
-			    0, pdev->name, tsc);
+	error = devm_request_irq(dev, tsc->irq, lpc32xx_ts_interrupt,
+				 0, pdev->name, tsc);
 	if (error) {
 		dev_err(&pdev->dev, "failed requesting interrupt\n");
-		goto err_put_clock;
+		return error;
 	}
 
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev, "failed registering input device\n");
-		goto err_free_irq;
+		return error;
 	}
 
 	platform_set_drvdata(pdev, tsc);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, true);
 
 	return 0;
-
-err_free_irq:
-	free_irq(tsc->irq, tsc);
-err_put_clock:
-	clk_put(tsc->clk);
-err_unmap:
-	iounmap(tsc->tsc_base);
-err_release_mem:
-	release_mem_region(res->start, size);
-err_free_mem:
-	input_free_device(input);
-	kfree(tsc);
-
-	return error;
 }
 
 static int lpc32xx_ts_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_tsc *tsc = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	lpc32xx_stop_tsc(tsc);
 
-	free_irq(tsc->irq, tsc);
-
-	input_unregister_device(tsc->dev);
-
-	clk_put(tsc->clk);
-
-	iounmap(tsc->tsc_base);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	kfree(tsc);
-
 	return 0;
 }
 
-- 
2.39.0

