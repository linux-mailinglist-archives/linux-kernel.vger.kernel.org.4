Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F31623D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiKJIUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiKJITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:19:46 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20077.outbound.protection.outlook.com [40.107.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3B184;
        Thu, 10 Nov 2022 00:19:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzGg2HBlficf2FnJvSxnWmjYHY3NxtlBA+ci4xuGNArUi+GiaoBJVqTfzSTOttCf4/tET7SbYPLnxx29Q7Mtt5cfPXWWc9SdmoOEOqM/mQAbwo7Mop7EcRHjBnnbgeNh2vh8+iWfLsYrc5eoEOrrT4dxzFykB9GgyjPlttyjwAvABhGzNdN48vgBva7Seg9vcXV62hanX1GDjj1LxQHH6IfSq95J2qKAW1L4AvnNg0gEzSze2Oyxxgl468i+st9Shms8w/0PIkOyXG8A/G114+n1AZKe83/dt5kIpzU6tEVpSPZcm033RZ2Ou/WUxiCxwR3hlz5pv6PHNxPtgELy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b1Y2EtQ2iAPh+mxExuyLOBHsj0n9gfMEGVN1y2L238=;
 b=nCYDMxPqzqGworexcjWEC4pVvYNgG5FRfre8Z0EJR43hpW1gx3k6RprhE60JnHPdMxocFXC3JrWQkH0QiBI+cZAUA4v7V6MQzIxBslsONiuwiISAyxExJOzpLx92/1U90YbDLh+KEeYfpn3JubY/AdwlfLcNzyLDHOvrviocWbLcqISbJZl6grSWkDpMm1Vlqd+SEe93iRfoEzzBoyYhoh904vbP1JFTVXjj9IJuXFul1ALyDNF6SX79QdRLRX4fTxDvfx43RMjOxqbTv/ec4XRkDbWzsCFgnoU2JaygR2jjgKtTmlAKKom9r7l0am82J6fc7Hpj7ITqP9EBgaSRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b1Y2EtQ2iAPh+mxExuyLOBHsj0n9gfMEGVN1y2L238=;
 b=FMfNT7sKpheeU+2wJO4y2PHRSQKI5C2hYItg4bwQUjCXsJGVvvgzdgcZ0nlBuGALH5a/9lHGntSb5EoN0eTLiIFclkM1aUDQh8qYHy+WKyaA+N6CSuj91e4fEogYHAhddmD/xXyib1yttRSmRRYrhDj+du8qmW+kAV5gV/c7he0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 08:19:39 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:39 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 4/5] tty: serial: fsl_lpuart: disable Rx/Tx DMA in lpuart32_shutdown()
Date:   Thu, 10 Nov 2022 16:17:27 +0800
Message-Id: <20221110081728.10172-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110081728.10172-1-sherry.sun@nxp.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: cf058292-f10e-47bf-c8e8-08dac2f44f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXtlI2wg/0XOeBWBKlfxDeOSnM2q+nQo5GObqF+tG5IlXUkRXXEUVYZRXnhnmb87XxWSnY+ISYHMkAQMxd9b3j9ljcK8FChXc3WxEGykoHCf0SxxKp9SkVKhZU1tdmVZ7b5pi7J73cePcC6Iv5gNlGxMJV01jKI4JKD8zNz5JYIrOVZJ4541xZ2lVzy8n6Lrnp5XCh8k1hfLqYaRHuy8NtWlwFZDAT7SOVuHsxebXV30iAhJi/64SncBNb9w5ToxcFv8vM891CW3+P+PJ0w+0l9fc4FGDO0Gqx3Wi/Qu2aW72m2536Kwj8Oh/fPz7TnVIzEdUIBG87y9h1PGEqvmOgGlwJYtIHBG6+U0oBWy1CPNtOCkjpgdI2VUFmGrxuXeqTk9IAxRV8yJh3M0DL0hy1d+LOpFJ+fJhhwl9VejPJZh8NLp2VncYskvL45Mrf/pR9yAkI4oe4ikf7oFq6jWiOfy5Cpmz/Hm489wT7RR9HMscy+IzHu1r9AB/9gquTBdKm4RZ/XsDaRfJgZ5mRxYhRO33C3g1nEUJISpEc8zz9SJeHCc854KWssRL++9wwpUEwWj0UsxorSvdCuTLtFv0pRI9kc8SRSx2uLXHfoNUxYIhA6TKX44nRTE5TMHA02CSzDChTsWJgxNIL/Xl34nrYvBQCobxcxfyv4U50SbhDwz2JXbQ3VGdF6Zs+M6/2O5kan6o0ugW0rXRIMwLqPkQ9wkCwbeh1HL8aw7r9bFpakDUt++V0jOe5Q2X8W8hfj2qlj1/K0SmcfxnV8G8lEnLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(6506007)(38100700002)(38350700002)(36756003)(86362001)(26005)(2906002)(478600001)(6666004)(186003)(41300700001)(6512007)(316002)(66476007)(6486002)(44832011)(66556008)(83380400001)(66946007)(8936002)(2616005)(1076003)(52116002)(8676002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLD4upmXYB3a6iRcnIxQ0O3+Zkb1kgD/37njQosPgJBez7vivlX512kDtER1?=
 =?us-ascii?Q?WPdyruoFiwf99TlNUlMV5LNbR4VxjtoiFjxaJGyV2ra7UJmFs1CU6sbGO8i6?=
 =?us-ascii?Q?ikXI1smjuSWeLzZa8xBTUNPu1Oi6qDi5KkVWwrWXUtEroGq2PQYdiSspXA0f?=
 =?us-ascii?Q?si7d7DiyfvrBU+KPWwvfaLObJEPv05L1VrtgaT78HV8edX0aPg3CAWyO8rlW?=
 =?us-ascii?Q?l0WjIP9CufVPa1Op1ci26m5Q0+NkHe9XdmOwitD5d/9uE4rEcr/JT/jGnAlq?=
 =?us-ascii?Q?DdV4KQ23KCqXIQGxe98cw/hr1+CId8jqlCBSfxnxkafiFPonAGZVSiMGrrF9?=
 =?us-ascii?Q?GUzVJTHI0Iw0TMPK6DYOCPJ0S2qvbY2N+RArCcSO4iSjkQ+4hH8jVyZqVoqA?=
 =?us-ascii?Q?RKhjU9nCbT1sNY2wMbQK62NMf5TkOuGGSIvfQiTfutxAyK4F2dRqauVkx7b8?=
 =?us-ascii?Q?mHu0m8MMQ9MgnuWxwUBjPTy3egzx73xHhSHcJiU1glBGD/kIeuUemTJG8raa?=
 =?us-ascii?Q?yEJMU+t4trkMnVNj0Hj6kUWmqZm4x6xuCp9SH7R0u4Si8764GMYjP224FQb5?=
 =?us-ascii?Q?5bBxCNrBlkhQgtZ+4BZj3Jor2uXAvZPpOBrcN2ZBv4G5fTjzrHb2JRIqLdqv?=
 =?us-ascii?Q?drDyrJHAL+gIPuOL4EjYvR7PNNRZYILfy9/OQaaFsgrn2tHKqM7zXadVkOji?=
 =?us-ascii?Q?8ai1C5b/xmGzRG8rUmMW6zGd/5d5yVVaWfL1lE9IIlvlwFHxz1J5IN3jTl6x?=
 =?us-ascii?Q?mqgC3TMZyrfB0NB8rMPsAo05oT9D0NEfcvBXyerWnBM4n0qAxWFWCtcDFND2?=
 =?us-ascii?Q?W+ImA289v6pAhjF/4jU1oP3k0yTdRbX4iWAk61rNZjmPyBt5PgxNU6fowL9C?=
 =?us-ascii?Q?AVNRntAqk0YHRSqCmX/jgpPNhNTrbwmIxUdbcxJtsY0YlT9Qz8clM8OpFbSi?=
 =?us-ascii?Q?MjylaEzs48gIOB84NBRUzcIBXqB8MkhsuYk7UAipm5YBYaA5RoszznzytPwh?=
 =?us-ascii?Q?mt0HbFL4Uk8CF9+A19kw0PWAr1roV9Ehs2ID+0zKhKSGbwslUroCYRmRm3mi?=
 =?us-ascii?Q?gwAYdXsHcOPtf+KStnoWKVvt+gF4FouGdLnHcjH5ulVTnwNQaRQwsaJWAmKc?=
 =?us-ascii?Q?5d+i3GO1Ga/fH/mqYxOvNgouqc08a9nztMOzQYHj5Ln6V/N3OQ2r3dkJi2uB?=
 =?us-ascii?Q?dalFvfYcoaiirLyT4C0LH7xweq9JuFq2vzNhqK2ecfqFIGV5dGp5DXNKuwFF?=
 =?us-ascii?Q?Gu55j5vOAWg/QbRlZACc1lPJSdNpY5nD06KbU67jvGzWrLO2G1y+miNSsGBf?=
 =?us-ascii?Q?FTKUaqlv6cwrrCNLJx/rdM3e9rZgGl6aqDBtqafeUzaAHv6pDaWN8VluvBHA?=
 =?us-ascii?Q?kB919bvV7lMeLHWOvsXyXsQxJPhLu8+xOVddFwAYhwi5ymxiXq1wESYIMoQw?=
 =?us-ascii?Q?uhP2tJYtv71OxHaRSiafiZnxI33oAmb8wOjuUNcuQ58u5wmKgSKQ+mndm5yW?=
 =?us-ascii?Q?h78uRo+YLoG9Mb+D9QA0qhLM883XOv8t+9rK/9dmEpEpEXw/uLWoQHXoqR0O?=
 =?us-ascii?Q?83diLGhCvNYKJwLG7IaNAxfk7ou8XP578nVaJr7m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf058292-f10e-47bf-c8e8-08dac2f44f67
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:38.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8otUT0GgzDNZQdYGJyYu7/fHYsbDDEcphAlMx6geJ3CrULfSE/d/R8d5QZrBrTosu8w5EC/kzPmKvN/cjZyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UARTBAUD_RDMAE and UARTBAUD_TDMAE are enabled in lpuart32_startup(), but
lpuart32_shutdown() not disable them, only free the dma ring buffer and
release the dma channels, so here disable the Rx/Tx DMA first in
lpuart32_shutdown().

Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Split one patch into four smaller patches to improve the commit
messages and add Fixes tag as suggested by Ilpo.
---
 drivers/tty/serial/fsl_lpuart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a6f7b056d57b..c297be11422a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1769,6 +1769,11 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	/* disable Rx/Tx DMA */
+	temp = lpuart32_read(port, UARTBAUD);
+	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
+	lpuart32_write(port, temp, UARTBAUD);
+
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
-- 
2.17.1

