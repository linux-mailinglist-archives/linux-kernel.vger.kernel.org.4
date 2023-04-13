Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6B6E0682
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDMFno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:43:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2A129;
        Wed, 12 Apr 2023 22:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwfk6jnpiljbuh4oaPbQ0XEqiX+Uro0C86SHBukZhd+CKjwgk6l6ubifJUaY9NAawpOnnViKnlN7S37tW1KpNZRMcOLpZxZlOsV289xAuhXZS9Kf1Wm1cKxOD+qTmOKHm//s9PGU3CnVS3yRprp28NBf3dH72DpwwbrfPff0/ReWILYEj8WbqkKKc9f6t1KgdeIvfokv6d8/Hhwb1dhe+EELlCgTgVrpGmHm7a8LEoFIXWmc0sG+bTibg5VP6E1fZ+Z4voLlcFFyya8iCIntN22W3VEP5urnZbHtmxdiY6ktIKR+apzSamEg0l/Dk/3JfDNz8zVpncsv2T57CxNdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TCIsEMjz5vn1OaaNUgHF1iMtrSgwcErZNFG0dhscJE=;
 b=cs+W5/3d8URNNmIt8GjQHgvZgp0O9r5V1g6pa6ZVB5Yctl9IQ6tgh6T819WDKmnxuNo9kCpZTHtdORfo5FeyKiHYfgVYBE1CLyG5W11WLnZgtlVzTyfwwiHyvb2xHy/R+a2IH+VbTyFyjV1UiuWWis7rEeyirnba01vW82FE/TVvDeJxTYj3du6gvOdgwZ0CU4HieCqQH2+OD6aQ7MWL5p1JIVRm6gwiWcZTVv0QpgOM15iZ/io/pRB517FhlmZ0gDds+3oZzP3GpHKirwIx7/ovImWXyfW4iBzhUhgtpYeRjTfutVXuxRvVlN/3iTWrmEvFrWv0lE4/j/xHEFaPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TCIsEMjz5vn1OaaNUgHF1iMtrSgwcErZNFG0dhscJE=;
 b=oSEJJNy189GxnoW+tL//Q4PCuSzepAxsGX7UBl30c1nzKZiJq1iXn5bpGXnYov+WQmQXc8ay8dNQYhPiRXfuRF3LYv4nctPDV02Wuy2IlAGrEBFptiAkVsUf1HBiChrxics1hRe2LZQQ8r0U4+96wJ3NZLfDHBcqowrmXXvnOTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB7608.eurprd04.prod.outlook.com (2603:10a6:20b:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Thu, 13 Apr
 2023 05:43:38 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 05:43:38 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        philippe.schenker@toradex.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: use UARTMODIR register bits for lpuart32 platform
Date:   Thu, 13 Apr 2023 13:39:08 +0800
Message-Id: <20230413053908.17702-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 1103f139-5ba3-4dc8-0551-08db3be2079a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xA1HuUUW03NiPeVQsjyF1ty32POoz+IO3Nl+PxoIRxGwpqXcs/Y51DnXN7y2nopBleExI6pRGjL/8xGDYu7XPKQLtwUMESt8DrmC9aQJAj+1m8In1NICSwHPlTFKNAVOfdVQuYjiBwurI2QX3KpFggLXPDD8cR36s7D64FxgMd0m0uEcs3mPPbXUP8CFCIDUOat/rVBvHDTZUO2fgWB0gn8mTuVUh8J9jcI0bpdIKi+/YyK712hYEhHOWqV24NoVa5XGmUQPJqZLA58KRIwmsdtRMyKHKp3/1mGUu7ccap6iYGH9kKI+Z2DwWQDEUGDRQkrW/PjRdExykBcihxwi9yS8JN8+FUUByVGp760BDjGsvtRcPHDJqXZfqJivz+G5EVEyfUOFwT5RyxO0Evvui50B9J3KshvWrokdfR9S2JgjCia0Y6RuyxN6Or9WoZhTPQbnmyKNaz99YKcbvUwQm5EXOD6OPpZ1NOF1OtY0582fyMcmkvDF94GXSPjQLPPyrfUIevHe9lWj+Eg98VnQgPP6vpA/fFd/dL4i60gN0GUzFk1JY9y+cQOcGIC1vEO0PuP+Of0RbYyzNh7+GcRh0qQqpt5JbhMk+lj9oKip4B5KgOxrqC8sjFl6af41aGVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(83380400001)(66556008)(66476007)(41300700001)(8676002)(4326008)(66946007)(38100700002)(38350700002)(8936002)(316002)(5660300002)(478600001)(2616005)(44832011)(36756003)(186003)(6486002)(2906002)(1076003)(6512007)(6506007)(6666004)(86362001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZsbPWv8nD/UC26XHsG5nlYAF1S3xZ+nmC6+VrrBuvUTkMGPTnOg9VzrGGJC6?=
 =?us-ascii?Q?Ypgfx3g/OWn0Ffc7ulvVpGjB0TRxGYCHQ3wGQAKEpMO8XNqM4sZ7bENQeD6B?=
 =?us-ascii?Q?6nm0dk7Q1Zo2QvFPaNoHeY50tr9XBGjsJVudtKQXU5H8dDiwBAxGG2zg33AC?=
 =?us-ascii?Q?K80SqtQR1SH3XDld9FvkeO1Ce8oCJ/uFOmimUK6cJjRbhETx3rSG3oUFJH0O?=
 =?us-ascii?Q?odfXNBuWuCZ5g53Q+TG7jLhhCCJe/uG1B7dMpFTfcvRgV+PQPlMt92BkefO+?=
 =?us-ascii?Q?ue00pqt7PlHu711sv15alVwbokgbYTS0fXK8tCOrbbB1l60znJS7Ae33sVPf?=
 =?us-ascii?Q?rmqip9NTDeilZHgXmWG6tt6vsYeuWuHtjWzDYxLMEVRJ62N/9xRepJb8yQQq?=
 =?us-ascii?Q?O6KFiV7/eODE1VkyHjR2oH0+0HxBjghz4+tLf5uUlLkrNa78hcXgtC5UAq5B?=
 =?us-ascii?Q?GhhKOImKDtF/4xykFF/iE2BTC1uQ2OQrBpruK6GQtlWYVUcwV9v6YRv+GXD1?=
 =?us-ascii?Q?LkavD5bA4QYkqygf7zRtPBw163w4UJO+NDdNsYLzgJ8x3qEZGEfjdLwR69XE?=
 =?us-ascii?Q?eG2U4WvagEEZP1zKkP1OaPt80OQheC4EbBB16kH+rzWFXsTi2PckpJKY8drb?=
 =?us-ascii?Q?leaDdQA5qMupxLuyMfdgvmAhAKgvwx7JqdPw9XDSzYL9/jCvtX8xmoPLiiGH?=
 =?us-ascii?Q?AO2dycZ+vqQ71oilcqANtMBo+NTFCD686t6Y/YtGjExc1WULpdoM/562uYXT?=
 =?us-ascii?Q?VkHPT6ujGeglS2U4iirs2gUqUnF6++j3nio2k9tBuqBto1wxPtSKCGzzcpYS?=
 =?us-ascii?Q?OI0aX3BBU/pizUEJq5rDnoCENOShJJ1CAmHtXo7bJsQ1nX/gYjwhWQyuKFlM?=
 =?us-ascii?Q?PkWGlvkTRdCF5SGOaW56YeChylrp24ZCWc7yE0DDzE6Vj1CjFWTlMK4sHOu7?=
 =?us-ascii?Q?dRX5vEGfpjLBB0CxTn5x9Xt6S8tcjQS7fSQi4vjLUgdLjyP9dX5yUoLwcfPZ?=
 =?us-ascii?Q?GJ9A9UtLcCJvYLMxYoEqb7H27Dzsb+fysZVbj0uFTfEBwZZPrjuUbJ/eyRRc?=
 =?us-ascii?Q?S5f6Jhe1Pja+PLWf23iiSPNIq6UFIJfHkH57afmGGUiEEkjrWTOoUHDDUO4R?=
 =?us-ascii?Q?AGoLnOXAVATlhYMsfVORx1Ay3Pfttr4z9JNDl734nIISrJbpxYgbFw7tvezG?=
 =?us-ascii?Q?KNJLcBEQLmqtnoqgub7MYiLTl7i0BaViqjGnsEY7TWWsaBsvs4NpQ4iMs8//?=
 =?us-ascii?Q?mSPCQ8mALmDGnP8LyaujEXKcXFXIRb5jHQ+SP5UVp5TuJ6uxiMsTd+V1ipqv?=
 =?us-ascii?Q?kYmjbyyGzBtJlPc3Tb5SMIeyL+8nIifxhmAKsHjnItga8P23EPAKN6n3QF51?=
 =?us-ascii?Q?w0TmTW25MsKJ+kw+vR/Z0esmR+VNud+dAD88BpTeM6qJx1uLrp6H+I+qS66E?=
 =?us-ascii?Q?M4L7GJtNpxgsO8DNqAJc+Hlxcx0FecOXTr7WE1SrYIPHffbDKfMHUdHdN8Fy?=
 =?us-ascii?Q?7jsC8weDtUsTstH1D75areLokLJ++BY6qMr+znmjJOOOo7m5bbY1inO6X3Qu?=
 =?us-ascii?Q?5IUTDv2GfBQNY5EeWqh14AM20dqFdybx29e6ZXEm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1103f139-5ba3-4dc8-0551-08db3be2079a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 05:43:38.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6+3Rp602p7TTcvrSIc0r7G6fn17ImuscBCNNhqnUU2+vDg4Mp1sUtLhXYCjkAbM+8yQMehdeaayoyf8ZaSt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7608
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lpuart32 platforms, UARTMODIR register is used instead of UARTMODEM.
So here should configure the corresponding UARTMODIR register bits.

Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 074bfed57fc9..9845d3f5b84b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1406,12 +1406,12 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 			struct lpuart_port, port);
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
-				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
+				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
-		modem |= UARTMODEM_TXRTSE;
+		modem |= UARTMODIR_TXRTSE;
 
 		/*
 		 * The hardware defaults to RTS logic HIGH while transfer.
@@ -1420,9 +1420,9 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem |= UARTMODEM_TXRTSPOL;
+			modem |= UARTMODIR_TXRTSPOL;
 		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
+			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
-- 
2.17.1

