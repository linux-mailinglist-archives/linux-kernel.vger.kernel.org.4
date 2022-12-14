Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF464C29D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiLNDOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbiLNDOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:14:15 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C927B1F;
        Tue, 13 Dec 2022 19:14:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXYOZOFEhDQUa/cECzlBHCNxq7bCva1YswzurstzC3jujKEPuxGlNNVwXllJAb3VIrVnKQcfnWN9lwgN6Vg+EbUW1mUKEIEsFPr6SnPgXHIdYbcxTmcgGi+FyY8buWTJirY5nooSuPcKj9NBpgzxwFOXPnnaVEleuJIRi7BAHQIH9y7UoW8n6Ea1KReOj3ynqxiUB+zxphpdaot6rDdeyPnNoPNMxYC59XSPz+MZtE+vgfw7QM+QUpkXt8slJ8+h4wXsduElRLIXQNlAqPFeGggWJp0c0XbGXfxR+2Eo/8KLVG09LdgeOT4+FJzyZa6g4ZS3aZR3lhX9vqaKkkwS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlvzC77b68ow7y3+PFr6IAby+vveemqBqw/XYJriVjU=;
 b=J4c6yL2EAh6MVra9qDajgqFEJ+MQbDJmKblc0vgii/46NDUuAucTvt23Va3v4mbKQbHoQZvNQekHuakodEEfh8VBQ4WM2WZlh7wFNSj4gRjpYPJy3cnzZkSVzGIJbeEP4Rc8wsEkqRCNn65wEovaJi7hVppOAwmigV1D/3RLFy/U8uoF5GlzybGstxmH4G7wK+5wRyj/BGwVK6funxtOWJ2/0nSUHLLkVk/jDTdCU3GGur94dYEoG9dS4JkIZIRR/83koCbcV8FsURf7txZaIzLWp5iH5NKeGgBkJ6Uo8Fnjw02JWsZawTYdt7bgPmaIPpQP3ewKXdEypTOEqiAVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlvzC77b68ow7y3+PFr6IAby+vveemqBqw/XYJriVjU=;
 b=COVdFPc+2SHHXlwY9gDfzJ2K21tBDxMDDEANbKjMmvLKrlws5ENsRKhLDQk3Y6xoGwYsYyQLqeHqiJvmA+puoTYrMR7CljUvmxQR9HHuC7qIY42pxhZcNu9pQupFw6oGCvNgQmwxInqogaVKNcT0gwzSutGKGnpUtPwr50Fqfz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 14 Dec
 2022 03:13:58 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:13:58 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 3/3] tty: serial: imx: disable the break condition when shutdown the uart port
Date:   Wed, 14 Dec 2022 11:11:37 +0800
Message-Id: <20221214031137.28815-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214031137.28815-1-sherry.sun@nxp.com>
References: <20221214031137.28815-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: c84fdd24-ae7b-46db-4ccb-08dadd813d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0Z3Mgk7w277KlVQ79l77KeYIDAUvWJ0Ui5p0ODhWtMqYzNucOenddw2f2LPv9xbu9N4w8ihcJmY0u0DK3ELeVXVAMmINhEt3of6QTLFcmrtiGIDECKLwPArQGt8eUwsf1gR2fFeiCtyrgAhV7WGolnth69FCVHnmHKnIWai5dBKPnJ+UO/128RVL/MiYA7TLgUN8fyK0/e6uJAWYCFvKxP/IuCj1zurJzSeXwaEkcNI8vjFlzD/XPSzp6JBs+KqWWQEV+nKwcwFFKLI7UJZNLKkDxpbJDH86RdQhvuKV23WB7Tz4kFBoziHWAGAVuhUQKwyEAbCPwxwhe28jcFqz/OR0YRWdqay1TE3xiRub3b9+EGzR7i2r9DT21Dz2c3/pXnhDrndOG9FJW8eJcXm7C5JyNhYmORfsnuiwHGsmFyXBAVoC09XrUTRCeVFG6xUoZ0ZNFMVBDF1dbtoeOSCX2ii9Ge8tvvf4R4pTC1flHp+yJoOJpsyec1SB0uUUM40vOj2MWPad9GrXAV2/2sq0vH28mvjuX8EhXg+7u1kH62coL7CeoYRX8FXeswJ/bYhslr2ZOZfZ0+oAE/y5DDgSPQn76x7G7rWUZutiKpd33hXHOxGXWmCwl+P5JjaGEKME4uvQSLBMsogAKkxHFVdy6I2aOumCMEt5A0t3VLYopJSFuBFI0jAxkE9x3OB7BL13ypqjDH+dnjTUdks4HaFVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36756003)(478600001)(52116002)(44832011)(6666004)(41300700001)(66946007)(2906002)(38100700002)(38350700002)(5660300002)(86362001)(6486002)(2616005)(66476007)(1076003)(6506007)(8676002)(316002)(66556008)(4326008)(6512007)(186003)(8936002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfDYCHQHHm5SR6tpHmbbkwUrjNIGU0OUbwbrRLfMAbDHxPX2ME35bTNqRGwH?=
 =?us-ascii?Q?mUzNmIB0JGEznlMy4YGg1r+Ma96qxQQ5v6P4E3lkJpXR0j1297NDaa5pyfm0?=
 =?us-ascii?Q?z98+lmonyHBiQ1eJIMgeAES8Lap/3mgueg1DBWFqvkV/8p5cphmtDHy5fyAf?=
 =?us-ascii?Q?wD7vbeAE6cnM08MyahuQNRKqCwboejhdOcHtv4mo6GONOOApjzTSyrFpUT37?=
 =?us-ascii?Q?4yoJu4/dT4Pd/xnyOyyfUvF4dK1Xn7+B8NsbJWWVDzVFV62ne3j+RNubtduB?=
 =?us-ascii?Q?MdIPlIJMH5hSDTHdCbQgo7QADWuvucgRESYDiYyrXLvUE2q3Xc8d4W+NESrc?=
 =?us-ascii?Q?6C7/qoJDjFyi9F4SfkdZUfjUs/AWPWPfyFVCz1jm+3CiFiDMumbka2UefVzc?=
 =?us-ascii?Q?GTUsp2OcmAjMIgqYWdgw1frUtOmkaCPlRCuC0jaSpFJc8fEWe5OU4YaayhzL?=
 =?us-ascii?Q?wrc6dYEZ+z93bNALuSKkfcYUvKncPjyJj5vH6GzKTmPiAPyEfrRs6GMcdKTf?=
 =?us-ascii?Q?zl1eM9b+X6AlY6xkOkcIy2ytBMAmOgOml8UKM5UWyalGPWONoZ62yHJwv4xX?=
 =?us-ascii?Q?2uiZlMNk+BXmPBdGXvVy3/TK6RaeuOI+D6OBvJOZ9TJN3n3N8NiMF0URl/+M?=
 =?us-ascii?Q?SC5IRItJ/xLb2ag1MscROAUmq/aFQh40aBzFaRpmL2KKv6e+BTSFNgrkwROY?=
 =?us-ascii?Q?7aVZ1RyQzEqDL2idVyfZutGdq+jmLzTiM7mIRwtQAm69vprioP3O7Eqy4msW?=
 =?us-ascii?Q?VFdhnepbF3w0kByDZfDLfBk1WtOrlgPJyvrpHUHhR2HcVxbowyRAbp0K4Gei?=
 =?us-ascii?Q?RARKznjOMwY+PujxnyzmQDf+4gCiX6NLQHoJjOhAAHU6yBBZ9Vh7ZEOwfm2d?=
 =?us-ascii?Q?lhlQBWZVtN903/HT4C4qXVIjKs1chvPajV7BDk02W6SD6i2iPBY4DpN/YaRv?=
 =?us-ascii?Q?ncgcW+hgMZHf/OCxBOf0jX1nLpn65WwhP6yFJB83Z7vZ3tiorV8KmOq3IzLT?=
 =?us-ascii?Q?QC4ED6rAKoh4p2pT6p9c2+M9PeQC0C4DqUp+jOxBzMzGbw4SJPsgUIxtFP+T?=
 =?us-ascii?Q?tOuxqpYH4gJR7OxirBSXL2iRv1H5q8KncoYjxvhGLJc0I1btryXZdy4nmgSU?=
 =?us-ascii?Q?FSn4BH2ufl9gDMePcA+rN2/SJAlEqIBqlS0/XbUX6O7cuTfoYY26ZPJE3o8M?=
 =?us-ascii?Q?4h7Waf3k3LFjO9nqo3xzyQygCWtaqiQcAriKVEownbo0qyLLWA5ukpbir0Dr?=
 =?us-ascii?Q?r+8SslI1viZ9RcipZ9O7gmvzIp24qkBXEx/9Bg+oDcve9ACk9vfo5wz+2w5l?=
 =?us-ascii?Q?LThSbMSZkshmG+g7TV+cE4p5cF9RRJyLfqRm43UWjaeF5vz/wZhqKKY54Y/q?=
 =?us-ascii?Q?9YeYXslcDoO7wPC16AWj5FxjE4db3bNz6+WPyBsW/pFWghWGhFvLlWYyiFdm?=
 =?us-ascii?Q?gdsQ93lswSUSrUb0Oc5KxPhh17obT5wiMjomycbESJOtv8aUSZv+BtC0U15l?=
 =?us-ascii?Q?IcdauDesBuZQKHMMAT7SMSnOjBheAzBZ8m7SH1bUNJPxRCDe6zWT5ne3PCMP?=
 =?us-ascii?Q?nGKzHPHrGKKcmXrauiS83/z3oZ/ZzIwo8FaaRdcx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84fdd24-ae7b-46db-4ccb-08dadd813d6a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:13:58.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOXE1OjpiVSNeBNZu9JjRBbD0Vx7wAhLqiDx3rOdTLda0KVXONco9WWsg3UWFfk3MfAcD7Yc0InxzvdKiWH7tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in imx_uart_shutdown() says to disable the break condition,
but it doesn't actually do that, here fix this by disabling UCR1_SNDBRK
when closing the uart port like other uart drivers do.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..74c9e68fc3bd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1564,7 +1564,8 @@ static void imx_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_RXDMAEN |
+		  UCR1_ATDMAEN | UCR1_SNDBRK);
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-- 
2.17.1

