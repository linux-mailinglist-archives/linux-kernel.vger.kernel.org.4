Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0C74948E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGFEGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGFEG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:06:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884971FC8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIbVsHbRXNAsZZ4hZW4ioJXCE0hVtP6jkwVI9Ugp0e65BiUxxdmL2yRBHHiut0lDfnXzukkdo3dj0ksLopIfM/51qHeSOrbeb4Xxmp1pY6DsZRuocCzgziuGp5Hey7uwJkEWkY7/fToTM9Zpl/jfVrzJecsZVc2rJn+NyH83ofRG9KLg6C/+h2jDJHZS6Twk89fWcSH1r8JfVoF+kdNr2hgPWre3e+EKlU03n2sfZm3UgBtSlw+6Q+AX5JbBTC9vJjLLwRJJMqY4hroPDFuiQGq1nSpCF1RK6ntb24xFM925AxggP2TL+KwN5j5kbcTxo0nDtyF8U+kVBD8r1+0fXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3ScmgkAuJvkeXR8mK5+Kd4Z7X7zbvWx+5wQsJdp/lU=;
 b=ZjaICIEkHEZTlTS+6GWWitm5JuqKeFkrEkEvvAkysDR+0DQSKpbKLHhqlhW/tohha6APAYqB4HqDb89YswaCZjXDCs5L3uyFlsGlBcDmz4x9bOf9aK50u4UZkNPBgQ0ihNi0WkJG96oBm8B86jIKC1CcgRyyR6KEbtIK6KL7T1oyKywJsRRPaUbUAx+PesonhmEJz/KJoMEe2JcPIJQu9AKoDNljcbsSVYbKGpt1XO4PuDg028LQYMceTwOfGoHO5/NdQq+NCv1Mf7kRXy4aevtfIxWpe23QdQsV2QY6SNVr3aA8GVtOaBnuSn6I/Cofre5PpVr48BhOhuPIoYN4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ScmgkAuJvkeXR8mK5+Kd4Z7X7zbvWx+5wQsJdp/lU=;
 b=cw+AuzQkoklb1BBW71w0raqwBx6Rre3sj5ebMfTA7zsgAHFJ/xtvtKnoB/rEHn/dWpg8uEQ9Zkp5BKuQVzQALhGx+uGJ+zag4fLLe6fZA3oETYskFVk/Lu1yHSdWsJNpPwrUOYPX2FQhM1Lt911hg7vAevLXPHe2b78TJAuX0kPZAy4BNR2Zk5TTVdEIvBKsXEqsjye+JaeswNh+6Uc8Ua7ueL8RbIhIEOMaNTQG7XOx/kkh7d5PQDpbUzTfSUV39eMIGrvhNXcY64eXwzN5ukQYCpf8wLAKn8QZommwp6QMTaFBPc8EGDab4rXoGvF7HB4sBVVK8DNic4Ve3bBoOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4548.apcprd06.prod.outlook.com (2603:1096:301:a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] nvmem: qfprom: do some cleanup
Date:   Thu,  6 Jul 2023 12:05:03 +0800
Message-Id: <20230706040504.34057-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: accba1a6-f2fe-47e4-0505-08db7dd63a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tHcQfxt95RDlDGAZ5ej2uaJRbQDUxvlY9NLSYeaEGRqF6b5JWEdTtt2tky3atzMm490kxALGyUlIEW/lLH8i2Fg9LOkFCizOAQi18+5BwnuPB/0SyqeN3j1XetqW7pzIwC2Cl/FHal/1NFtOX2lOZ8ZtmZ39J2RaPqD0Tee8ZIP3vc6f+ru3cGZh0fsg/O5javEcyg6HBE5FRUdJabu4Sljdk2+0KjX6EuZrz9MGqGfD9p4peq3GHM5MJ/ckvQigVPJ2o8dvcpxkEgUMx2jhVQA7vft+XPUAv3O7VIaSrz26hG55QkXR022g6VgfPi1QijC44kKEqUUY1Al7U6jV0O6FzpRxEvAVbnbmv0oy5hI2zov5jmyWAJO1siTvOtk5S6ocP7vuOfBOfTbjwuAefjD6Jx2Ng63IVPxw/Oafv/RT6QY9RNfxUtXfsdJ+aaC6I1cZ+oBVTs65YqQ48eSQw6h0i/XSg2JFuMXFEVBx249KVywFwIhkJ8/5kmg1ShLMSovLtVwiO/WZxDc3HoVZ+ipp+RjQnu1MQKykzW2dOPuAnVPCinB3nVLisnhdWQ2TU62ABHxlvmaxi/4JJqdczhwQN8eJlZIn3CixephZ4MkLokNFFjbI5T63EMwy/xZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(41300700001)(8936002)(8676002)(36756003)(316002)(5660300002)(2906002)(6486002)(66556008)(6916009)(4326008)(66476007)(6512007)(6666004)(478600001)(52116002)(38100700002)(86362001)(38350700002)(186003)(66946007)(2616005)(1076003)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEdDsI2/pcG079lezUXnkniUz86Y91gO29vFnjHXg6TXiImqtrsrRzGw8sVx?=
 =?us-ascii?Q?Edj7nSl0fEvhwTH7GYvQFaQbhLT3bThlPOCF09GqZ3Zqcxcb+Yrn5kXVSpKl?=
 =?us-ascii?Q?2OmB2f2in16GeemSTUFKh79hYKRvN/MWVbA+SwIKcqMU5aqLoQoW1wHrVmcu?=
 =?us-ascii?Q?IRwf2MnDjw/9IwhCwHl28RLneJbrqfeu1zCRwf2g0lW+cjdyRv9UtdHjJ4IO?=
 =?us-ascii?Q?PubeTZRam5eIXVSEB3pEAfkXUEv83B8touz+qrU/jICPZdH+r8EMJP5/UxTU?=
 =?us-ascii?Q?586n191bxqsnGfaZES54bieJT0bncyFlPSIcMk1ZZhdY4u+oHIfHH4Ve7tgd?=
 =?us-ascii?Q?Jmy9MEitkJhae8pGzIQjhPOj6kdSd6gfuX9r5kEWVGPmDj3gm/21dfjhm9ez?=
 =?us-ascii?Q?h8DN+ahjZF88t9CvY+jmvDKwo/p87Y+8dR0Qru8bzL9lPblIPoSh1wrNGKfL?=
 =?us-ascii?Q?BCRPm5g9112GXWXkKv3ElT921Ho6TGVfk07aeXG9ZLKs669Ymgpwgbh25IX/?=
 =?us-ascii?Q?4d9bPjVu+KkA/Vyi2pZ93ZO4B2fRN+YQCbCsakQqw345NcfrdTYa0POT3dB5?=
 =?us-ascii?Q?VV1FfIMmyof14hmN8l4SQFgZCeO8zO5W+rVxrqFBLCdS1m/98XAxUX0rh3DU?=
 =?us-ascii?Q?nOHPwoq2DIMHPDDKWqknXimkMNa5Vhxn2h9pOY/hU8kcieOMoAqDbNoFCzyf?=
 =?us-ascii?Q?8yHT5GzTB0z+8PxLpVBlv03OAVeUjD4pe5GfQA5jE2ovPi0UMsqihRXQeomY?=
 =?us-ascii?Q?+R0JazPUNygaNmDRWLTy07PbuycquZgryIsberV+dQSYmNNYkZHfxZLs/xNo?=
 =?us-ascii?Q?7ki1vgd141J3PZ8PtbV2E9Za9AkCpRbPz8B0kMAFlbK7/jk87inWRuemwyaG?=
 =?us-ascii?Q?59kiLhrLNyFvvrdWdxRibjXIIk7Uq0nvCEVYl9/hCIwaU83yrnLocIpDN+Vt?=
 =?us-ascii?Q?qnS8oMr91KJZf+8WP/wX+YSA8bNjSsbYnWBOKInIzZwKBPh5rW/MiJXBwXV8?=
 =?us-ascii?Q?HOm5pnZDk9/Wbdem1r8+06zwATsiY/rLXwnAa/Ia6gmilL4UVjcsIzmwVvBw?=
 =?us-ascii?Q?buNLOvnxABeHasUfOKJuNHCdAkwzNp6I5Hvh30xIRXq8/VLvWXen7/UxiPZG?=
 =?us-ascii?Q?ZisIu5gEW6bOsrAR5nWHRmK/NUILQG2q+v45nWjr/YveYSMmNtRuiIvmGCJh?=
 =?us-ascii?Q?p0dGvPHNt8If0ezcaOH4oskmX0tjI+7cjQuWFR9/gvQx6hcqINaiODiqhM2N?=
 =?us-ascii?Q?vHjsRCSKN/tBroAuxk+L6iW7JXq/DPj6+oGTX9rRlsMKV8qqhoGA0nmZx2cB?=
 =?us-ascii?Q?2+b/Wo1PaJoJDaGPC/98xeWSas/llpMKiVy+hyA0K/fRGFGcNvqH6B9vkRFM?=
 =?us-ascii?Q?u0FC/m13YUCFAI/VoQLiIXNFQWXoZmkz+niuyVL6OKMdEc22uz9cwzTvOSjO?=
 =?us-ascii?Q?V6vULJbxxyG4bu5+PLCHBBqdHmV+90dXbw51qEIRCDHbgXTqnKuoBCNoils4?=
 =?us-ascii?Q?sj6rv3WKnn9OMlWaxCRzLp9OT4DiBXSwPHp5239x5gVDYZgd43k8Zey2KVGx?=
 =?us-ascii?Q?lTpxLL1ybDzf1LH5tYpEPNuVVtHU0MqNhzeB4DsA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accba1a6-f2fe-47e4-0505-08db7dd63a64
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:26.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPOlkKj1nBDWwnHdPTMvVfGEpUi2d5kWhrELvNmtKiRobYqTH20MF1VDoFGAT1NohV01crCeIHW/bDqT2N0yDw==
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

Use devm_platform_ioremap_resource() and
devm_platform_get_and_ioremap_resource() to simplify code.
BTW convert to use dev_err_probe() instead of open it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/nvmem/qfprom.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c1e893c8a247..14814cba2dd6 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -374,8 +374,7 @@ static int qfprom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* The corrected section is always provided */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->qfpcorrected = devm_ioremap_resource(dev, res);
+	priv->qfpcorrected = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->qfpcorrected))
 		return PTR_ERR(priv->qfpcorrected);
 
@@ -402,12 +401,10 @@ static int qfprom_probe(struct platform_device *pdev)
 		priv->qfpraw = devm_ioremap_resource(dev, res);
 		if (IS_ERR(priv->qfpraw))
 			return PTR_ERR(priv->qfpraw);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		priv->qfpconf = devm_ioremap_resource(dev, res);
+		priv->qfpconf = devm_platform_ioremap_resource(pdev, 2);
 		if (IS_ERR(priv->qfpconf))
 			return PTR_ERR(priv->qfpconf);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-		priv->qfpsecurity = devm_ioremap_resource(dev, res);
+		priv->qfpsecurity = devm_platform_ioremap_resource(pdev, 3);
 		if (IS_ERR(priv->qfpsecurity))
 			return PTR_ERR(priv->qfpsecurity);
 
@@ -427,12 +424,8 @@ static int qfprom_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->vcc);
 
 		priv->secclk = devm_clk_get(dev, "core");
-		if (IS_ERR(priv->secclk)) {
-			ret = PTR_ERR(priv->secclk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Error getting clock: %d\n", ret);
-			return ret;
-		}
+		if (IS_ERR(priv->secclk))
+			return dev_err_probe(dev, PTR_ERR(priv->secclk), "Error getting clock\n");
 
 		/* Only enable writing if we have SoC data. */
 		if (priv->soc_data)
-- 
2.39.0

