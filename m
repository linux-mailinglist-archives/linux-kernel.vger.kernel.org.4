Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB7680630
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjA3Grx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjA3Grr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:47:47 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0931ABD7;
        Sun, 29 Jan 2023 22:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoYcsTo4o7EkGb6MOvso1hG7BAWAUWeDHS+5gLEGfhGz/+n8BSSZYWhuLWTRwm5s9ELmr6prvN9JFDufLQbhMBVi95+zOQuRf/S1lUsVR3xsQfyHKIuUoZEuMTx1d2HGr1V6QLgbsFhIVOWboIvDwaDa0wq8V2XMTzM3zFjII+NXL34PBwz60qmHZWMTLlsZBGGK91tbPRknyrKWiL3Kr2qKKUAMpRWcGUPpRIozfPVEsM6yZHKgIVubUQWGp+PY4fWMyAwRinyrNSQ7tO/dmq4f7jpBpmL6gJbdflaoKUbHMGX3mav1rMgeKVCg/ftm55t0ms5YIl/jfsgJnnWMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkr8b0AVluO0jmwJAQOT1z7hvBwwu8cmChezZaf2l8Q=;
 b=G9DIRqob6Og+IOYWD1/WZU2Tq2sFbvP5N5DsHRtdt1xyot6iDuI1hcufQyghYycUXkoycVEAZhnqrPsiIGSCrN7ikpMcNqp/5IiEHK+Z5BJOpd/pO0q7y+7yaKEpYTUihMpoXS2m40H0R7f9543jCvG7e5PpnLN75ahy7kDAL0ePiQ4ym+S5MoPnKMSZmjvctDDqf/Fej//O2LMKcwm735wbNBa8qqY4DYzQqFz0X9tERGIOr2E5kTTbbq4f0htid+gOT8uj1NElVPLZfPcf1Z73PD6oc1wdTn/lsGQyQjTRQ1hUeupWiEATyItrw85mnkoAwKSfBVEAtBSuIbCRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkr8b0AVluO0jmwJAQOT1z7hvBwwu8cmChezZaf2l8Q=;
 b=Oh6UtqYzY5iBPRhgILcf2pTl753ejnIMqPqLTUl7abq6fUPs9RqP8N0S1EKsCutfEEAdup3j6Exc3AqP+OQPAVaJzRSewjnXBgfmKUcMXIzF0+3BOuD9meKxp7s4KSiptjQiM6jBBnNyhcZiilK4FxBvWLTRrHCTSBAxYOrcL5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:47:38 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:38 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/6] tty: serial: fsl_lpuart: set receive watermark for imx8qxp platform
Date:   Mon, 30 Jan 2023 14:44:45 +0800
Message-Id: <20230130064449.9564-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130064449.9564-1-sherry.sun@nxp.com>
References: <20230130064449.9564-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0963f8-cb49-4da4-b734-08db028de057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jIGcqJjN+YEppyhB7FXymiRLLiJwo24gitWA03FFbIewXbIpfk1LmLSJiMjY/EH1MDILoFBFYJ9Ml6ASK/WfE/6klFoZitmCJ9lfeGIL7RRXhSW51t2/IdIfFyQp7I2bywxr5Ois47m4dmk3Z2e7PY5VsfkeNfVHpUsq2mh0qd3d0wXzlBNGSYOF0VlMcZH/JtDlxek1dRej7Bl4fHtosshqaNiPyb3RY5jnhOLnQEEYn7sCsTEFPj7WyneaUrERvB2wzBzQ+J9+2t0dXohXinfa/FfIMe+rkJIKvz8Ge7ErND2FPG0sl2Cp5qJbymjRrJf/uwKoHbyyQe5v14d2T9+vDZZdfs4s6VOhOErIghL3oAM+ftyR8+0isq2OaGrJr2suy9fI7JcQfBJTxdIFw1gtEerEs96e0vZwQmeL+zmPjz2fCWqI1xMHUPR7hO66TkJp/w5OcMUDVgqUydat5iD0negWsY9BXSg5nZxdD6NpfEABvJSWmNZyieIH7qVXxiF4c+nQALyN8xnwL3SyaFFIma3WgTJICCjHxTx8LTixIv8QMjDSoXlyYNT6QMFDQS1YAeUdR2Stxij0XVoUB3upAax5bWrihQwLOk99nIFLKi5CHV7ycFWgqLuFU4mcTNa65tx5jfofkwViSveSBC8sDler8q15SD39qDuz5CwFlGcioMm9p5PYCyQjg0/tsJAkL1NFrmsZri8tXEtE6/HAXSA1KFmjnKYktK3WaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(8936002)(41300700001)(44832011)(5660300002)(66556008)(83380400001)(38350700002)(38100700002)(86362001)(6486002)(36756003)(52116002)(316002)(4326008)(66946007)(66476007)(8676002)(478600001)(2616005)(186003)(6512007)(26005)(6506007)(1076003)(6666004)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kq5/7/WvfNLxFNEzq9e7Fhzm+AtDUp4LXbMvjFlrWc6qM4+BuZTv1BnO7SB/?=
 =?us-ascii?Q?qnOnSAs1BjNhm+J1ZjhIMrCefGzz0n3VjnHj47jgIqh+FUKyKDwQIBgNLapQ?=
 =?us-ascii?Q?2/3klmYwuFGzdelqaDKxbvJEqfDGSqS4HqV8NmC+6sLKp0gq3wW8W9Tl7dvt?=
 =?us-ascii?Q?9nesluuq23vWOlNPlKakG20gesgkKkDdMkE34BT0nbULd9hOjxs8DkIXH3Gb?=
 =?us-ascii?Q?LshpT4hjrEvJ4JTXGcuo0meXhv+P9KufzIR7VBwlfjITT5PtTUhA5itFSZm8?=
 =?us-ascii?Q?z+cBACyvOrS3DZ8Ei4yTwpEUmCLt+15DWpo168JUjdyMfSVjpU/8QXB779xa?=
 =?us-ascii?Q?N13mMkOZqxPT7kKr5XLUixzbNw6cKUaO6M/yoD7GDUXC9D2LxQNW0YQOMRn2?=
 =?us-ascii?Q?IrLY+FOiYDOqscZ4JQg7N1e+3iwt4gNK0AVMyNUOUxpFpIIAED8uWLkjj4v4?=
 =?us-ascii?Q?SyOhsvLVeRUM5shblyKKFVSVtcKAdxNrzVueQCQ/74YXlgt0o8wBH9Jxm6Zr?=
 =?us-ascii?Q?Rzx0g/l5J0bQJf89YodtZZmXXs6iI14pLZLsmmR8/RZAA/4q3ecD7PJyMrHM?=
 =?us-ascii?Q?X+MdmxjXttGqzd/HSgq7eioD4vMrF0p8mut+Gb7s/Yb6h8QCMySUQgJ4EqvM?=
 =?us-ascii?Q?36sivi+SeWDMMiT/LCIkNo9UpVTgSuR2WU5/pw+ynJJR0Kh3iP2AZcHJKukY?=
 =?us-ascii?Q?5UOsUMIONAH/L1z36ZjJwSNbtDw6lpLdtfN3p4ueX1lYWinGoypoufv/gUfn?=
 =?us-ascii?Q?FOcrYX1hTUGPxvGprV3jGUyFCkH5/P0N5TYBRylcgwYpSI6UXlEBD5XlIVeu?=
 =?us-ascii?Q?8nvDDaetwEByoq2XdYnZqc79+XXr39wZu/zNgdxolJIqE08NtOIcbnYn6k+h?=
 =?us-ascii?Q?fYsWO5hEb9Agd/8LtkKW1hmq6fdNr9EdObQAIZlZWMvaOXpUkWlk2L5JXMDa?=
 =?us-ascii?Q?76ggVyCB7OrMPBE9TcPuoEyPdvAtjtpuILnh32bmp1GWnEwsyaRzdA/AlTtH?=
 =?us-ascii?Q?JGjBSsr75gtIYOfhc0OXfx60VAqNhelFqpyl5TBZbuwOcREYtOLtbj/zEOrK?=
 =?us-ascii?Q?b+sU/SStjY/k4PfP5w6XLP208PCs82bFhfnCl6vf2pFBtSwlykFeICp24o19?=
 =?us-ascii?Q?s5N2rXKtEANcoCBHvv0NLqxwmCroj5BDlwLKRboTD1iv8Fx847JufqpvgoBB?=
 =?us-ascii?Q?H8Ljice8P0I+1/RcGTm3XiTJfP4glbwIiz/SblcoZ+QuEiV7oog23JQkuUpy?=
 =?us-ascii?Q?XO6HdGt629S2Y/pQWxDqoTrd+v6sr3aadPLTBc7bJYpdVAEie2yzekqv69CG?=
 =?us-ascii?Q?iHrl5wDpOWZnZ2rHNxipvcvyI8qwDFjN4ZnnkBCD5XnEAGq0peB9tIbZxYq4?=
 =?us-ascii?Q?+A+ZEEnNHzebeNv8CDOPH69tL5qHX6BuDOnnrOEKKVugwJdBuc3vXOAdtOHk?=
 =?us-ascii?Q?hCHoSDWi2mdc2BbOfpK0Ir6WVyTIqPisbeDyrLae5wXaTKxYYXIpTcOKPHzp?=
 =?us-ascii?Q?9ocyi53XTQZIPNaCCTpmLm0Crfy1yqs/xr5ZKqr0jifoKgs1UcFLNCzUlVhW?=
 =?us-ascii?Q?1TNeMwvsTJtVM69TqZ8XNumamKuFL3Ik9vBQ3wXZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0963f8-cb49-4da4-b734-08db028de057
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:38.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 075NZQkmUZdXBnE5rLUAZv1VDSwqK5CnWL8ywJrTf04Zv89n575gf3FWNZxzIlJV2XAU1cMYSGFlwBshlWNpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since imx8qxp RX FIFO depth is 64 datawords, it will be better to set
the rx watermark as 31, which means when the number of datawords in the
receive FIFO(>= 32) is greater than the watermark, an interrupt or a DMA
request is generated.
Also keep the console rx watermark as 1 to make sure it responsive.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e4aa161e61bf..868c2783d2c7 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -321,7 +321,7 @@ static struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
-	.rx_watermark = 1,
+	.rx_watermark = 31,
 };
 static struct lpuart_soc_data imxrt1050_data = {
 	.devtype = IMXRT1050_LPUART,
@@ -1527,6 +1527,8 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 		writeb(UARTSFIFO_RXUF, sport->port.membase + UARTSFIFO);
 	}
 
+	if (uart_console(&sport->port))
+		sport->rx_watermark = 1;
 	writeb(0, sport->port.membase + UARTTWFIFO);
 	writeb(sport->rx_watermark, sport->port.membase + UARTRWFIFO);
 
@@ -1563,6 +1565,8 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, val, UARTFIFO);
 
 	/* set the watermark */
+	if (uart_console(&sport->port))
+		sport->rx_watermark = 1;
 	val = (sport->rx_watermark << UARTWATER_RXWATER_OFF) |
 	      (0x0 << UARTWATER_TXWATER_OFF);
 	lpuart32_write(&sport->port, val, UARTWATER);
-- 
2.17.1

