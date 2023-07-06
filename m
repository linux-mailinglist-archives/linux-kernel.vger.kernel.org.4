Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A574942A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGFD1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:27:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243721BC8;
        Wed,  5 Jul 2023 20:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiVL2DEuCPqyLwaOi4DSi50N7kdAzO8Wo20gxeS7XjBrV9w3fxi8qzcJH0lyqCOjUPUCvjNjptMFxGJMspESPCQyzfS4didGkC1K1/d9YauGcc+TW5fxlNjCGKPviLvU7f9CZBzZl/9VKUdU/scnnIgDebzz7ej50bPd7Kty4viZTrwrjT5YF9hPg01gBtx37Qal3Vn6Cr75fJFqmaVeP90xEVcXEkgBHRXvhmqFFZQsQ1Vq6jo00DkJaUv9ghQm56zsb+EE4+M8I4bTtups2Etm6NkqarD2cS3v/EhC6efS6gbzTkzVd4WcfZNbfp/p8h0e3EPkkIIoM1qYRHcXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB8Prm/iB+Ntgacg/uw1C/+t1A2VdIMtWaGOC8HEr4s=;
 b=YOqYMRfL6ZFn6xJ1KNRpTyWTwyQ/BsNoeLsBsOqnOpkc7j/te5D2i3AW12x7YgFAQBp3mk0CA8EPYjwR8VZvA5p1/UVSW4c4w+XqVPI/OVStxoKs9eH+3UDHUf83XRC5HFraMcWKB9e+gG7xlqPB1nU6TYMZntKl9WBhwGIcj1j0A7u5MS3MCE/BUjvUWmgmuARXDxMSzPSFFuwsnQozwBX3Txp2J8qMv0YzZ7RDs4nS2Vph+K1fVUenQrCyIvmD0JspSOX/haTRa6Kqtqbqm97GG79eepzfw3WoZHuNulD2LnUpAn9YdcD8PrPtJmDwW6phMVAC7owdD1hVxd54CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB8Prm/iB+Ntgacg/uw1C/+t1A2VdIMtWaGOC8HEr4s=;
 b=SKLumlFbg12l/4rmIyzJeJ+JxfaiLIwU/u8ay+mf90TfbnK7iYklgTNOEgQKBZ/wG0MjdgGEoF9DIteSZbGLbebKEpIyUmvqg0XyzbnyvU/JIcpjU7LlGG52WUX/Pc548TlUUkCGZDNU4+9cb4TGox5KyUPX4WtiSfa9afz+Zmdx3QyPzJdq+bwzXzJuPho/sAQOInDXzm8jYGW6zdCNFRJpd54OH0Mpahq57wLqZkrTr2jHzWvLALp/AfqZkZVESEptPpSGK4O8x/+FqoAg9a409rcWeM5y9JK+4Kly7PMiK82blP+cwxsc3DjZgJuda+85LDTGExNq1HHmZ5nfpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5468.apcprd06.prod.outlook.com (2603:1096:101:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] spi: atmel: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 11:27:20 +0800
Message-Id: <20230706032727.9180-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: fe53c927-9c0f-4057-2b63-08db7dd0f17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/mvpvkrjS2MMHaCRvc/NLp4H5waNmQd0z/CWKypg28rEsO1pKtnrW7V24wBTRkcBSJPlBZfmWnJ50Ndjgr3XPM2onrPocmdKBgv27kgN44V0hUUbDkcCbxxabHzZIKmg2Y5FGTT+x2SSOsa0zxYddNhhLdbNC4sV1oGHOvx7ieo3x8UBvgXgIsl/83Th47xROXKbPmtUTnMMGCN4NdYCbGKFqwv3ZjmuGJrB7VP6KUfSPAwzv186pyAkzhZuUm5ftNvyN4tvukLT+cjK9IJAy/90KtUkkKrAsdkpUxypfuybw2zZs2t5ZZYU2rW9uP/p4DzdKaowVuIUbD/cEyteq8TNwlmwu0i9HSh1TPmhmU6NqUvrUjfow+Ay8PRbn4C1DIUI3aeYB6LlFXAU7jGOKUELp+KNlPiP7GKYZeps9VJvO7XhXFNnUCKWWNcxS3mPgsRS7LOqFAU46joJhawC3Q1ubNBCW3mg/BN0TrFjAt/AGpHcJnbVDLQiT4Q84bgUCGTb+5upCnGQVZXel/pDfqxia81eozf4zh7P/q/BAeUcCQ7B4fgj9RJTjmBKqwc2GvvzdbzbWpYxo6OL9IVPJjjyzWRF2nWXRtVagzpJZHjKM8UESmlaARubAV1DIte
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(41300700001)(478600001)(6512007)(110136005)(52116002)(86362001)(38100700002)(38350700002)(6666004)(36756003)(6486002)(316002)(66476007)(4326008)(83380400001)(66556008)(66946007)(8676002)(2906002)(8936002)(2616005)(26005)(5660300002)(1076003)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FtSX3YyfRYz8V+7+vBwYNelVAZMnooIwOyAlXMedCjxPqQte9C8CV6Gas2Ho?=
 =?us-ascii?Q?2s6JPlWeLdRREL9Pbje053lIk7TdyqY9hNSBA5F0+Bbvxwub5P325unZAZFx?=
 =?us-ascii?Q?G1mLkfaB8wCUO1maEHmz3+VQ9KNbgsnyzh52vTcl+h+N5/M7pSq2mJgqFLrD?=
 =?us-ascii?Q?8t06Wo6Yjf3x3Cq4em7ktWwJf8wAItr1NPv/6yf6TIlm/BC/6cyVZ4hD42or?=
 =?us-ascii?Q?fCDTk6IKIaQ6HeDBg4lNiKlsIAgOhbSKuVsr71jXEmZ15+yZO1StZH/t6Um6?=
 =?us-ascii?Q?I8cgaHVDLyMg4MZHl6JkYA+kQj8gAwh/BjrOMNFgsBstjecjIgS9FZmwYwk4?=
 =?us-ascii?Q?KEtxZTAu5o4+7lIoTrN04EMLwzOZDDSSyQNEGC2G+eHcl5UMhXQo3sFWoyXL?=
 =?us-ascii?Q?zru63pdDyni+v0JoUyWwMGeKTjzwkajtbTl+6xlw3/ZNcE9i+36YCoSZhgii?=
 =?us-ascii?Q?MVE66RipLFwIENloI2+GW5IXTQePFPrP0k0bq3mgMbNIfa4ilJC/UtkXuzMF?=
 =?us-ascii?Q?5hMiu1koQQYvdjkgL6qQ3q0JUewL4gKX34htZmBCML9odLb8e/r7t6ePlOfY?=
 =?us-ascii?Q?OkqnmY5GPNTM6DfHCo7Xc73UA2G+3E/SG8Sl4OmSrNJwNMMqfPGvLrapnMyC?=
 =?us-ascii?Q?qZcG1Mr4jzKvAmXvyJn7j3/tdluBHZ3JvGn+6w9U2t1t4gYPl5OB6c8XcsOh?=
 =?us-ascii?Q?Ye7BrK4GP1CX8HTl0jDutJBIORniHg+1frmbbAvcq987R14Gg2vPmqCi0H5e?=
 =?us-ascii?Q?tpY9sy0FcFnfmpsmAqGygUIVvC/C5Z1gsFoUHOC6ETVb/t+3VOWgaeP0S0ez?=
 =?us-ascii?Q?cOBbQnXNQgpkb4WYWtcnrJpZeed/pthV5V9LR+B5TSQL9E3g5+Yg82Y7lq/v?=
 =?us-ascii?Q?781NILfXEFfWpnG2dsGd0D0nGzCmI4k/srkjl6jYJCc211UaVJH3z4KA+fRG?=
 =?us-ascii?Q?85Jr5uB3JsfdnyNKIlKxos5wvwK4tE4i6N6iGUbQYcKt0Vsrzf3eKfI4RNn5?=
 =?us-ascii?Q?NHob8ZJkkl3T5WLZF4tYkWJ36O59Tm8r2kGMyJSHsMQDOqFIWoodovAvX2n6?=
 =?us-ascii?Q?+plIBBIzgKEGMtUy2GKIwa/EOBknL2Whk/in3aEJwA1eeXmuc8P+q9NKrY2o?=
 =?us-ascii?Q?eoA+u9SVYpUnbejDD4WYeLUdCE11zMWA5YOqiTILKMCjaXQ7DXjE6bY9fgkG?=
 =?us-ascii?Q?meZa9/LZqB4oMRnu7E+ZWiSmj4dCbF0Vr5jd/bE9epCm0f+bkaM44HLQaKYj?=
 =?us-ascii?Q?PO/8/1k4akJtr9pPgy5sJCU4brIQNuGQ8SEhC9Bq65DbT/T+PXPi97Y//tUG?=
 =?us-ascii?Q?oABsyIaQ+MNKZqG9hSSpYiShSoKF6qK85D5SRAnLtsHEVVeVUu0vAkPv3e7O?=
 =?us-ascii?Q?W+kI4uGmMUIdCzZKOsxUNDTqL2rTydGT2mJ2nezIhuyvJe49VbBz/MWpM+Yb?=
 =?us-ascii?Q?jZpGkZ0saarA6Dr/u9Y4c3FqW9CXTd9Rh+Illu9sR27Vspb6vqwPgsNgfzAz?=
 =?us-ascii?Q?23//xl9MbTw9sIs5mWUDh6xfSLAbE7X8m2X6uxtvyHbtS7WuhILQ/co4KgIx?=
 =?us-ascii?Q?GIB/3/x66EGqCgxPieiTCAMzgaAHevGAneVHfZg6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe53c927-9c0f-4057-2b63-08db7dd0f17b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:36.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1M5ADtMuvfpEyTLtge4KLvH+hPZ1S861opcApzpqqvBnyThsFA7BEyZ5p7kE8mxwpcEptHniMUc7W1qt3LXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5468
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
 drivers/spi/spi-atmel.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 152cd6773403..8a9c8b92be8c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1450,10 +1450,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(&pdev->dev);
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs)
-		return -ENXIO;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1490,7 +1486,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&as->lock);
 
 	as->pdev = pdev;
-	as->regs = devm_ioremap_resource(&pdev->dev, regs);
+	as->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(as->regs)) {
 		ret = PTR_ERR(as->regs);
 		goto out_unmap_regs;
-- 
2.39.0

