Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0726241FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKJMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKJMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:10:00 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2343E6AECE;
        Thu, 10 Nov 2022 04:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D617CfwiVf+szqbjSKtqnOKwRtZn+YFXShmI/e68kkTd2gwoI72J2LQoZ1Ax6BfRepvg2fw1Z+3en+xG1Okt/vFvFDWaBxhvyqhqygvY+5E1X5KrGYnepExe9rdSmsLSNU8xjqpwGJFs/cv4AdxyfuD9ZrfwLiDjUdbVB1PUMxuTl9fuE6p4T8++rMzgrncLegrG4PDMhacoUD4gTWN+Dh0uD8IZqCQQVhBqqiAfHkos84Zv9ZKA2iCRclHXq/fq+6t99EWt6UtZsU8Ura1GBxKrLvF6iHsvOjtIZh4YU214UwBwol6s3RDmDpZ8xUfqG4FyevJC+WDC3n5qwmgU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2Re8Y9COKv4Xe3HECOet3HjC9ciO9Ls/P7GyxfLjyo=;
 b=NDVkavFceioKbAHXbbj7Hk0ZnFVipfpmdtyAJrlWasJ+BcT7/4AkU2ML+yR/mcqI5WUhbl88itfyIlV8sntTsSBcFrSb9JBUtynj7gRIxvFuEoIGNGf72/K1dhWwy3s3Ly74N9Edh9p1PUoVG6bPrKnD2j+HQBUbZycn0qHWoZmkfFY9jVOcOZBA6d4WWLNFqRvYUV3QrpX+kAP95njkXTyP5jMvlaaQ98m89qkjhvtBGGy0PZiXOklWVVGAc4Bmn9YqQmQA0NmIy1nFlpV1tDStLxcnqRP2G+kOlylw+6n0yk9L3Ec1+GWdSC+baU2bhUm9CC4dCUQKfbXEuDKpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2Re8Y9COKv4Xe3HECOet3HjC9ciO9Ls/P7GyxfLjyo=;
 b=E1B7aL5/tImUUeyaIhK9753NCv9kAGatiw6WioyTfDmDat9sAdcuZmLps+abGn3eipTMCT42fsJqy3dAnZVSb/A7PxBlOjQkH+BueYLwFNZwWRDw5GLmg3GUmOOL/EXrHgyTsPuj9VKebQO2Lx0dtnwzLVqBqvDpfF+WSSMSUqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 12:09:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 12:09:56 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 3/3] tty: serial: fsl_lpuart: Use pm_ptr() to avoid need to make pm __maybe_unused
Date:   Thu, 10 Nov 2022 19:38:59 +0800
Message-Id: <20221110113859.8485-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110113859.8485-1-sherry.sun@nxp.com>
References: <20221110113859.8485-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 308a4a0f-2d37-48ed-1e01-08dac3147b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7dYKwxhlKvPq0EW8av8QxDu4kIDlaUJHcvclTnhXw4g5Pp4nHPEnSWhwwI1Uwbmf1XVG39QkJ6d4Yrhi1XN3Sc5Hd7z+FqrY3ZUKkkU5lSXAQLXdAG+JqOodbXfgM2x2MXkLyaZvRamSlb+OXmt38acHAaXlbk1InrJWpVa7qV0aIOkI+GdPxg5cY1k7pPMV74qhfNuhRPnQLN9W9UZyEkDB4sKThC1BVWD4WH22bp9vsNgwA5lM2xDdTLUaYuSHP3jz3P3wduNIJVAHvj0BDmqoJ/alxvmnjQAaJDKNyQ6PIWyy3mCtk81f2ZaU9M3lKJG7Abh3hR5a8L3gb0ATIzs47s1JbQSnUF/N9FvLG4VSJGk9eG9YsSYhN8ujvCx8QRt+Sg4mlqueMCAVn6uk1gRVMywxk9MBdy2nmajbA5dnVQgd6VDK9buVcGOTFdLEMAw9v7AVILItcWtE4cWr3AEIGr8snYUeaL5iOX1kb1I5u22Ug7y7p1w0jbL8aoNUeExFUWMFwzG+9s7x2A4SUonoMoLlxXT8LKk+MzQqUjDctpb1PjS2LVWJCZ/HNeRoBiSPolyb6JCUVM67MVks7eWlsYkW+i9sfyULsIcng9plhPVm15E5Z+NBzQuMt0pdyBT8gwgqVk03wBExeCu+cQ0wHEv56sQ1PKDCSBuUnrZnrbuWZpPk62lCm9SCQqw6lZ3FALUDyGDtMQBTo+CJCh2WbkKW/CVoXATV7NhB5pv5hVb/q/if84jYTq1KwEg1bAekAXzHkyCnNO7d7It6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(38100700002)(38350700002)(6486002)(478600001)(8936002)(2616005)(316002)(52116002)(6506007)(66476007)(6512007)(41300700001)(66556008)(66946007)(86362001)(36756003)(26005)(83380400001)(44832011)(8676002)(4326008)(186003)(1076003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/OlPs83pw3+h65Af608pw4PQR6vlBF/Ev35O94VlP0XjiJvDk48k+oz1TQd?=
 =?us-ascii?Q?xusw70FJiUEtsQGdRH8dRpjdn1t+iLIEZH0kS0uBeWRv6Pn7xMT2GPAn2+fl?=
 =?us-ascii?Q?HUj1TswhmcZIyqkbdfqyvEX2AqJw1Wh6BlSaeSoV++wcOn/+D3vxKPGhEXiA?=
 =?us-ascii?Q?nsnyEVdk2hVGGiVJAnvjnFTPMcFjDBHbr3giCckhQmdo+O1NfZYQ4bnEur+b?=
 =?us-ascii?Q?n11qYq47U5h2AuiX1eirF6M9UjWWmru1rEMMzwxhjveXcBROgfJ1D676Zn2W?=
 =?us-ascii?Q?HrJp1BU5G4RX/qTNYHGmRQJURw+1e0tzJWLid596mSdPLDygQJOXNdPEGe/6?=
 =?us-ascii?Q?ekEZJKCoxKq9ILjXzz3eDJ3h0u2/VHDT64mHxiObbxF9/i/+hJqSYxjRqBBp?=
 =?us-ascii?Q?o1I82AO6H/yu24bTD299ZPrkAHw7lAhe6TFTRmOvSd4SI8QS7dBzSh0m+Tt5?=
 =?us-ascii?Q?EClvphE/hkxwliDQaB7Iq8WThQnII8rT1/fZI5LNIfXKF4ot7tQYAAEch8ss?=
 =?us-ascii?Q?wY6akBphhsrtvbd+bfcDRLuB/yvHAxSZLOYf5G/td8ZgnvtgEDq2bH2ohMKr?=
 =?us-ascii?Q?jIi097UinnbwMX28TczwSHpDO7gNi1du4WZQ7zL96lS/7eGjLAmtubsxwerc?=
 =?us-ascii?Q?b2zK301+JeiVlrZiCvxC9Gy9l1HXs9ME7ytl1jBzPhUGBs06nhUjiGciuQSf?=
 =?us-ascii?Q?dPNvPFhmQaED1C525wOaPxayx6/9aNCHdJeb4WLhyfHDNh0XE3hLObJu5lKQ?=
 =?us-ascii?Q?FIfVtMRqQuHO4GDHic2U6QC+3mHWHU6vWDCs6dJNCaDJAeD/7ZFrWl7yfFoQ?=
 =?us-ascii?Q?CvZk25i/fXpXfuokXWrCKcvVFS6khG2h0PXkW+zj/iJt0YL8fHLhinyCBDHi?=
 =?us-ascii?Q?QTPE3iKI+5mEBNLXrkVOuehpeFPnEc3EMYCOfvDPaZ52hVok2V+WPDG2E56p?=
 =?us-ascii?Q?fWiEZkOciEn6M0w6czKm2JU7kn33abQAvgXfDBHdJfOJi3G11BHjlB6TOxz+?=
 =?us-ascii?Q?aZqDMKcn0mh+rcZq13Th1YT84RgzEOF8ioFQlThSLjkH5cVOuKyvbrJmPruk?=
 =?us-ascii?Q?Am0FrIH/OLfhtA0wDG4SiUdLwkLCBstwgFHgT/d8UjEjmgLeKQWtLAKpBAKz?=
 =?us-ascii?Q?RJymQ3ZCHbuNO1YaJ2aImJwxaU2Ndy/E/TqVcZXmpHZZIyzmr6yCaEUvvS87?=
 =?us-ascii?Q?CdJQogNjdAXer/B+AyRqUiQwYi/RF62tgkVHvcZWwL4RAbTtqQilQQIasxVt?=
 =?us-ascii?Q?w+B0rqX67KilGUbCu/uQx/UiJtJ5p+gzLS3qK43vTM5d0ktZCParJJlET/G7?=
 =?us-ascii?Q?tFQb4SniMOC8xdzyC4A+jV+nlCS/pPoKIKi+/H0CP54yeUxh8XnDD3SL2xcv?=
 =?us-ascii?Q?Ht3xkoAJaM/orR4D5CVdGmQKJ73L0vidAoz1QcU2+LbFkXKs07MUkYy4yMrG?=
 =?us-ascii?Q?0W1ZkDuu0kc6GyF3iFdfvvaFhcfJh8MXRZFbrsIp54bLts9ZRXQmEjuKQoGX?=
 =?us-ascii?Q?srZ0861DFwNnU/r+f2RB0cCy5llLoZOvxVaLSCDcpwU672Ot5a4RiLNvood2?=
 =?us-ascii?Q?j7DODLXF9ogQQfUw6juwN6OQ+bNZQG7DWWHpZuwj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308a4a0f-2d37-48ed-1e01-08dac3147b0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 12:09:55.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl6OAsw+7/qGX11zwBMBXK1UMjIgpLFTrFNa9njx1Nb8eR2yMx7pgKFi/IRdbZCjdZCAGC2aBIU6pdAsDO1Nww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pm_ptr() to remove the need to mark the pm functions as
__maybe_unused when the kernel is built without CONFIG_PM support.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. This patch is new added, remove the __maybe_unused as Ilpo suggested.
---
 drivers/tty/serial/fsl_lpuart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5b3962bb0de2..20e3027c1a55 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2819,7 +2819,7 @@ static int lpuart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused lpuart_runtime_suspend(struct device *dev)
+static int lpuart_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct lpuart_port *sport = platform_get_drvdata(pdev);
@@ -2829,7 +2829,7 @@ static int __maybe_unused lpuart_runtime_suspend(struct device *dev)
 	return 0;
 };
 
-static int __maybe_unused lpuart_runtime_resume(struct device *dev)
+static int lpuart_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct lpuart_port *sport = platform_get_drvdata(pdev);
@@ -2888,7 +2888,7 @@ static bool lpuart_uport_is_active(struct lpuart_port *sport)
 	return false;
 }
 
-static int __maybe_unused lpuart_suspend_noirq(struct device *dev)
+static int lpuart_suspend_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
@@ -2901,7 +2901,7 @@ static int __maybe_unused lpuart_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused lpuart_resume_noirq(struct device *dev)
+static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	unsigned int val;
@@ -2921,7 +2921,7 @@ static int __maybe_unused lpuart_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused lpuart_suspend(struct device *dev)
+static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	unsigned long temp, flags;
@@ -3017,7 +3017,7 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 	}
 }
 
-static int __maybe_unused lpuart_resume(struct device *dev)
+static int lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	int ret;
@@ -3042,11 +3042,11 @@ static int __maybe_unused lpuart_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops lpuart_pm_ops = {
-	SET_RUNTIME_PM_OPS(lpuart_runtime_suspend,
+	RUNTIME_PM_OPS(lpuart_runtime_suspend,
 			   lpuart_runtime_resume, NULL)
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(lpuart_suspend_noirq,
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(lpuart_suspend_noirq,
 				      lpuart_resume_noirq)
-	SET_SYSTEM_SLEEP_PM_OPS(lpuart_suspend, lpuart_resume)
+	SYSTEM_SLEEP_PM_OPS(lpuart_suspend, lpuart_resume)
 };
 
 static struct platform_driver lpuart_driver = {
@@ -3055,7 +3055,7 @@ static struct platform_driver lpuart_driver = {
 	.driver		= {
 		.name	= "fsl-lpuart",
 		.of_match_table = lpuart_dt_ids,
-		.pm	= &lpuart_pm_ops,
+		.pm	= pm_ptr(&lpuart_pm_ops),
 	},
 };
 
-- 
2.17.1

