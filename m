Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91FB638773
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKYKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKYKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:23:49 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498FE209AE;
        Fri, 25 Nov 2022 02:23:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPL4K6gbkfg/CikBGrwUfQkN567S16evDWMKHxr4YnB4HBjteYtLSz6Rty/CjDSAkbB2NihXqsu45Dp22+DnL5TyA+NqlsHt4fKTro8kW2ZaI97c5Jv+h1YNQvWCpjiaNscmHebzperGMamgCTs1VBnHYGMUo5f22QNfQW+qGq7/IklNRWBnfdQp0KzLLFHsrfIMA5+3OlnH9Gr3fUSdvuOJxf9aowzG8GUmgJslD7+5QhKe8u26CEAyoH5ng7KB4ril+7BvOkIfaK7QokVVaDaWlyCjxsxxnNNZhAF0FxbjLW0PPXlrWPkVu1BXncRLSgOFpVSFSpiv52H38+3/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmMgmnR5BPlOyaBJyIvJi5N09JYSTiOO8T5t81J2LhA=;
 b=WstZzhXKKFlHIb6GKw5947FT7QZKZ9OH4rR9DjlD3gxkRDKDX/QIBfvpOkRp+KpsodOj/tS9QudPIggm3U8H3lzAywNtKEBRX7kyXLICyBknME4whIUoT3Mg2WgrB66NZIJKpDCEhjwqC7IF3JRxRQiI3R8RngWlymC+lC0D3BqqBiHEsXMFP/gYHXtk0oTvPcq/GCt39WwJB3R+7xmko1dJWZ+e1iSDrfvEagHGv/iMwYrcubOs/v9xvucIUal8bDQ27EVhWbAeULh0ZoHjPh4Ia5DiWPIjy2AvJY1w+8SsqKxcBJJf3G9v2oyzwoiykpwCpH0ckMWS3ghASGHV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmMgmnR5BPlOyaBJyIvJi5N09JYSTiOO8T5t81J2LhA=;
 b=J2O3BqV2TmeN/kawS1kOHkzb0r9kAkuGmmTCJxfRc8ABosFySaAmSxh72gz58Sjg7C54tdEgXkjq/imxPXDng7ehjINYX1fy1aixj8GaP1AHcGNgrMGydE6iP34KLP3vugdKeGw96EIWhi06l1nDSqqqSjPzq4rZCvI+4xrMHhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 10:23:43 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 10:23:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, atsushi.nemoto@sord.co.jp,
        tomonori.sakita@sord.co.jp
Subject: [PATCH V3 1/3] tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma case
Date:   Fri, 25 Nov 2022 18:19:51 +0800
Message-Id: <20221125101953.18753-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221125101953.18753-1-sherry.sun@nxp.com>
References: <20221125101953.18753-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: c088ad8d-9402-4608-8d9e-08dacecf20b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkrIFvZP742K5RaWAsvhwYezu8l9rYbT8P5pu0jKK6A+sd83nnGmj1gY0CH/lTxxylkMXpVxdkCwI59cb3QOaXZdVmJkjxuLjHC3HUSwK/VsBvBv2NQ50hiWiQCOiBtgiY9psWvZSVmkDsyP6jrXOnQnjCzasyyqF0z2JI676Hrcf3xtNBFHRb0xkQPDsMXHk2dEqmyXM0ZCZFB+C0+h9vrOL2dN7ZSmXlCmwD/e0lG5gqXoPLafd8qvZiwi3UB9H1s90rx8VHNT1MZhoEn6vktsUxHtdIBMteiKGPUYI+4hI6/Ndojfvp/rVaSx0cEmwY9K3tcX7y+c0vkLSjNxXl0rENwY3ZYA0KkwQl8gQTu5la8KNzT9wCWshcONlZ0yjbxmWuwsZ0QKQQ1upcNileddz7KjlqRmpNzeaxt1EJmg35fDLE8eeDgJMJfzejY6Hfjd8BVnQo9QZkA4WcXx8X0hUy/Y3aqKd2yWZabRSZhI8FZY8RrcfDVdoOjotPK6O576fW3sJf3RJQna53ZdtfnhOVhQV7Ts2O96Rn100zJjE4eReHLudLbzjauLv7vuVohU7sBvGkeA3Lrvj0lZFNjmVrXNx+0gQHoRMr3DsTyC4GUUCIGe7oXxDo+oBb2VCyXQCjJBzlFUcHExm//RwSaDoMh7nTP1OjYYJs3pAanGmBEB8T98FvPDjaKbr6CBm5k0vY/UZXT2UhU7vMuaMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(6666004)(66556008)(36756003)(6506007)(316002)(52116002)(6512007)(66946007)(66476007)(26005)(83380400001)(2906002)(38100700002)(38350700002)(4326008)(186003)(86362001)(41300700001)(1076003)(8676002)(44832011)(2616005)(8936002)(5660300002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ymxXAl8i8TbLJCClH6nM9vaIlNOGwiz2TeKQUDAYB3nFPGLCPDV/b5aWTsn?=
 =?us-ascii?Q?CqwnT/yQIxbMZ9lN2BkoU6jEEg6vtISlPLdHes2s656EYxbtKRk/tgyAHwVA?=
 =?us-ascii?Q?bvgFWIw79psiiKgkkp8NOTdqodNF84YwuekoBD57bgqmjJBa5I4tBfSZgvCg?=
 =?us-ascii?Q?uf4I+yEKvqZJOMaAL7EER1oaBiFWrG30z3ybbQuUWpqHqKVavBMGL2UzSnkc?=
 =?us-ascii?Q?HBl5yvOh11TMtepoiKBJds9/5gZHSIXWbcxxCCRxo2VATpC7ZYMFbkNQiu7l?=
 =?us-ascii?Q?+kYQ1e2WFM5XQAMQN66ZLODnqKV6Q+n7FKRKi7270jc3CPut5n/E2B5pchgm?=
 =?us-ascii?Q?sEa7OObJu5XLcfVpugxZMsr//C2DUnsDQVBR3E4ywcO/Wa2WiaxlX6DQ0GNu?=
 =?us-ascii?Q?q7W3Q/FQHiIeEVKPaQUAalHvn/D+WVK+5yCzdN+fukWrd9bzqynRhAa1ieMN?=
 =?us-ascii?Q?MjnxWRdQmxF6FdRdh7uJBstrvhLlgsRmV6f6RzpvmvtItueRcw6ug3n8Haag?=
 =?us-ascii?Q?GpPcQ1dpvXBYKzs3+3uQ+O/wiQtlmm9hCZxQ+Ujkje7RbYz5RBUKf8t5K6Vu?=
 =?us-ascii?Q?x6vc1qd9gzDGzith+Mgl2fo2Wr/onZS0P0wT+ZtA4yCfmEcUN+be0nCqRU9X?=
 =?us-ascii?Q?jH+uQNED7WyeGuuP+8Q+LkMNWQdieuxjSPNxDyNlrvD2hAPiCoGnlbXFeTnW?=
 =?us-ascii?Q?QBIS83Zllo7FicfGBiI9v4ZTQ26kCbZhCrCYIG82QIwyqhckL8aW/CBye3Ba?=
 =?us-ascii?Q?Uy97QRXFCKdf8JGImurHA+RHkW+4nqgkV78/mL3GlCUTncVaY4ofq559TSMI?=
 =?us-ascii?Q?WTV8R3GaEtItXc/rNG4wVMdoHQUjv0oO3/M8XDfjPGS7IE53z865YcDPOxTE?=
 =?us-ascii?Q?bFIjed2SpjkIbTSRpy9JfYPBV/7t5jIubUjF0hxBiY21jvQpXa+DdYLDubds?=
 =?us-ascii?Q?imLsv8LL8l6AMbkIOerKL89NR6QT4FRfqT5PehC1C+cHU/B9/EBjX4lKtU/+?=
 =?us-ascii?Q?k9aQxtsyyA6RaY+7MGrEYHnBTu6dXWzjn2oijOxnAvtKbc6oAitHGJl0egOY?=
 =?us-ascii?Q?kLjKMS9+ZvpWfLuwYjNBRd2Zmv/IV5/r1VdXXoteBO704G1ZK4oYYVWZgr06?=
 =?us-ascii?Q?RM/mMTJ+iK8LQOfZC283+x+BeuawdE8HQJWPU/yDQ+SwEiWF6cG5MysJh3d/?=
 =?us-ascii?Q?MLnkBZzVv5I3/TOy3k5Q0VC5TNNs0Bam85iSnm0dMexHi539tRY0SSNBYcnb?=
 =?us-ascii?Q?2u5jBmJn4/ImeCcHuwO/AaDTUukGu1z73DVPVc7DOGcWxC53KSqtZ9CnsOk4?=
 =?us-ascii?Q?dOhSCqvEkAW5sFSyVkSthjhsn6Ri5L5CiXejNNQr5qvbH+WSIqjlBiN+4NQ1?=
 =?us-ascii?Q?2ySns0nU2jy8nqva9DQR/nw94c2G3X66xRPI+gaRf9QNpEXnwO+0LKZH+Pkv?=
 =?us-ascii?Q?4dlM8OjWXOMsH7nFwmA5A7/0Rk2Ix2JLnYqzWMw2/4I8qIl507yokQHpyd7w?=
 =?us-ascii?Q?IyQ22aAT4fdzSUwgsEmbt6UMKIRU5aU8Ix1n0qmv6QnwXIce+9o+PHy3LIry?=
 =?us-ascii?Q?xtq0SalpnIqN5M7sZKLJJ48cSCblqbCwFWqQbdHW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c088ad8d-9402-4608-8d9e-08dacecf20b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 10:23:43.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHEPv5TMqre258gcvMsCeDtOuJixSuMHz9uK6NES/yeXrMJWsWnpJYk8olrrCMwRIIuf9WmHeJw8BNnE2oP9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the lpuart driver, the Idle Line Interrupt Enable now is only needed
for the CPU mode, so enable the UARTCTRL_ILIE at the correct place, and
clear it when shutdown.

Also need to configure the suitable UARTCTRL_IDLECFG, now the value is
0x7, represent 128 idle characters will trigger the Idle Line Interrupt.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5e69fb73f570..9b8d32262f1e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -5,6 +5,8 @@
  *  Copyright 2012-2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -181,7 +183,7 @@
 #define UARTCTRL_SBK		0x00010000
 #define UARTCTRL_MA1IE		0x00008000
 #define UARTCTRL_MA2IE		0x00004000
-#define UARTCTRL_IDLECFG	0x00000100
+#define UARTCTRL_IDLECFG	GENMASK(10, 8)
 #define UARTCTRL_LOOPS		0x00000080
 #define UARTCTRL_DOZEEN		0x00000040
 #define UARTCTRL_RSRC		0x00000020
@@ -1523,7 +1525,7 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
 	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_TE |
-			UARTCTRL_RIE | UARTCTRL_RE);
+			UARTCTRL_RIE | UARTCTRL_RE | UARTCTRL_ILIE);
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 
 	/* enable FIFO mode */
@@ -1547,7 +1549,8 @@ static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart32_setup_watermark(sport);
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
+	temp |= UARTCTRL_RE | UARTCTRL_TE;
+	temp |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
 	lpuart32_write(&sport->port, temp, UARTCTRL);
 }
 
@@ -1691,7 +1694,7 @@ static void lpuart32_configure(struct lpuart_port *sport)
 	}
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE;
+		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
 	if (!sport->lpuart_dma_tx_use)
 		temp |= UARTCTRL_TIE;
 	lpuart32_write(&sport->port, temp, UARTCTRL);
@@ -1798,7 +1801,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
-	temp &= ~(UARTCTRL_TE | UARTCTRL_RE |
+	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
 			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
 	lpuart32_write(port, temp, UARTCTRL);
 
-- 
2.17.1

