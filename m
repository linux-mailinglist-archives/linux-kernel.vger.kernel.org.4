Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9C680633
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjA3Gr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjA3Grv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:47:51 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27B16329;
        Sun, 29 Jan 2023 22:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz9oz35GHgIMCanF0cR3wOZqs4VKyx7X4OTUxknXWAxDdjgpn0BbKkncQAE1e85xeTi8wH0jk2L9X0hiPy9YHAEjKd8MS+sdWkAxp6THMa0fllZqDZsZnGWeQeDmgi6P6gzGztbkEyVYgfIAX2HKBoQ2JUxZkC7ttxCT07g/r5nVDe38lPf+3tzwNihr5eyGgbWTS+ouzTB1DJlKskamFmoSRyLnHAYaLSn2QZSvMNppqayuU1yW+Baon4wf0H0z/qh4uMbavoacWeJUc9mHMIblWwG4DbCE1MC2lRI5wBh8GOtC/pZhoa0K1EnlJDh737NZIAuEJVNVXRxZnZRAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZgKhBwcW4L8V6MPAjx2fE/0uMYGx/YEBhDyNo4B4Mg=;
 b=aNpV6JqcDQdL7eCTaj6XQXYbKqI1CGqE2dkExahnfTxCIILkOoQRpu9BghmNB+OCJGc1Usv3oyWOR9nRT5rrvcu5iUY378YwzIm5RGuauna/oqiDOJHz2E+PU8eG/JMfj9vz56dva9my8rc65Fn1klLD/cPT91nbMUR1fSHTCJJEzSftMdHQuPioJ65dqWmjwEGcz9SnOFlPBYWZk0p2SSSQwwcQUwpIaYjmhYlx6WlajqVPEGmVf0Qey4ObMXPn88PKk6IC83LuQEPlHzEl5ag12NcwZU2EL0pUwJ/h9GY6Ils25a7z7nRYNSpXjv2bYU8UZWPiJ9GiY24PY46DWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZgKhBwcW4L8V6MPAjx2fE/0uMYGx/YEBhDyNo4B4Mg=;
 b=YFP9XmrJsr67DH5YrO/eQJ18STQxVydUfp65yOsMq4qCqtMCTInEHcSRZNkBfBZXxdWbQUpmcvsYbgZQdrjd5PP3NONH/3d5UPo1sGdTHxoPnTD0LYq31NWaXGXJNdxb/pVT6UQdl7XiXrzg+geQpkh5K5qZWVFNKoo8z1Elk9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 06:47:32 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:32 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/6] tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms
Date:   Mon, 30 Jan 2023 14:44:44 +0800
Message-Id: <20230130064449.9564-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130064449.9564-1-sherry.sun@nxp.com>
References: <20230130064449.9564-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PR3PR04MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 561faa10-2822-4347-ac25-08db028ddc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II0VQrovt8VBv3AWLlMfweev1MZrXpOijT5yDbpvIqIszn9gtcasOfdpSzqKQ392zo7Ks7swaz6BOT1gR0IlrzErfWVFVEAnHAZHTMB+jGcMK8s5wK7lgrxmUI7IFi1YqqaCemY1hsH5tmHgkcnQi9/UzTsU8st4Kjgn1UCRlhpzMlA9QjY5r2UTJFDrctoIdLV4uzlnGuqac2kjQ7zPnIzBJALHjJtM8O1JTGRYw5Va884+o8wJLptpAppbxwkb4tYDu33OUevBiaebVcXWoD16IeJdc6V0z66ur7KBzHutS9VlHt24bYxDwcjXKD0HNbpjAe/5SP/IFG4sGPkS8HhdsF5wPrP+1utjXxJQXkezaNi/tiMXTemEll8ZHDJlj/os33pvGtqy2LQBdQcVY7ggKclZ/GykNqy+DArTUT5j5J3Vg4+J9+dI6KMi0jirEdVMPvTbXNfcRCuo/9hl4Xir1n3YnIP65fiekxh+a8z0N7xxDAl4+fNGkUX+2f7ujNRL3Pwl7sS7z6Ubt70CfIfSAsmlC8eFYB+WCfAqjH0uO5YdgZrUMSiKFTzsvbCEIya6bMwAg5f4IZaF6kn9h2N2WThLGIm5JjiCFLpzSI1b4PWsZQq8D97DVYlLiN5xoi40Kx9+MPV08Co5raJgM6JkCarFC84rbSt4pGpYL2G6bO4DdUBXudoep3RJo3A/TyEqBPiPqK+XzvrRPBv1kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(38100700002)(86362001)(38350700002)(36756003)(41300700001)(2906002)(6666004)(478600001)(52116002)(6486002)(8936002)(5660300002)(316002)(66946007)(4326008)(8676002)(44832011)(2616005)(83380400001)(26005)(66556008)(6512007)(186003)(1076003)(6506007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jL93J0FAUsCjCWlJFZOu+MNKcBv9GPhFKaYNIQFZYgMUVJfLfi36GFQHdTX9?=
 =?us-ascii?Q?VEMOIO7W43n701Bemg+WpKmuiyBdUqu+vMJf9/OpMQDG4FiKWUpmqr6S0MKh?=
 =?us-ascii?Q?2p2/8V+8Idr+NMnSc3FAnGOzQleKfiT0uQeUw84MR+3nDhRr9+up9nGKa6ar?=
 =?us-ascii?Q?XeO492xOVjRA42EU6VHFBKTbWcwA3O4J5LWlcy2IkDH+51egpjqSuxFZOAPe?=
 =?us-ascii?Q?fHZcs7BU+AttnaDmnwrLfUwBl2GHs5Bpl2iZmaGaMQBbRWTvbb//PRqxXKQR?=
 =?us-ascii?Q?v92PLFpR0Q8r46ZSWz4svwtk8C4CBl/FXp/uMgL2pmtMZjtxf6hHQXWQgfxZ?=
 =?us-ascii?Q?JsLgJfrzn/WKzv67UFbPjFlQAN8g3iRT+1ty/qmyvC6mRoS2fYJZOqDO5W70?=
 =?us-ascii?Q?Y2yJk7MIoAizWuKFaQKutANJho2FXeN89RhmkyxgN6fdZMkuWfha3ALfLcgW?=
 =?us-ascii?Q?QdowtaUG3VE2erimZ+rlLBiBnWLwaJYCHBTCO7BptfPoacZeOdGL32UDDxJO?=
 =?us-ascii?Q?5HVnm3ESFmZGcOSD6Mj4ZedS6texcgJxWYX7yy07Fc3ai8yKWm4Mh/pZO0Hj?=
 =?us-ascii?Q?ICWyk8TREOMvH62Wk4pwLp2M+pFQ1Tux6TYbSAkAZEC7+OR0QP5YxMiHd/P3?=
 =?us-ascii?Q?lVLics4HyVQDFvu5YL+tjkGo/DZy4cH+0wVaBKZt9aUNmLBR39C4kIFpth3z?=
 =?us-ascii?Q?w5t6kDJDJtgLiKZTJ4/C/Kre33yE+YmPpiajRckX0orjW1xN/IB2Cicirej+?=
 =?us-ascii?Q?/mxa9gS40BK1KuhqvRu09HyXfgFDCgeagZuMEIzpZ8xTtPatyzcu8PXFd67u?=
 =?us-ascii?Q?xP+UYpVh41pQTAsHFMPIOBX0+3wOKRlzc5U6BdHTGXzq1GDyps7ho95ywuxI?=
 =?us-ascii?Q?oaaKSDX1+6JiiqcZ5BcpWnEZnQCbib7gWiVLUzZkTi0KlApYo4Z+PDexOMZN?=
 =?us-ascii?Q?DkvlUsflXFhYrIrI+21oMD3pSYgxYu9PDEnyzyNbivHBTzkYn+5L7RlWD5Ei?=
 =?us-ascii?Q?3xaLPncWa9EqmNG267JN0S7yu0rmLjCYckr8aZmFzSOqUDJntJ3vEm6rqR9f?=
 =?us-ascii?Q?LTuN/CaFqf8yL99OAzkfarqSbOW9de6GOzmQsq5PbPDVZ/g15+96tYQenqW2?=
 =?us-ascii?Q?9AhvO9uI2gXX2EN9sYLk89WaJ2murUYs+zMAHI9GV/v3koBt4DAVSI1WJqnQ?=
 =?us-ascii?Q?7Os5UYTVURfc6xqvMHLUTKitWOGFBAKBmGZXooj2B5D3GckCQphxHrtqNYEB?=
 =?us-ascii?Q?VjsdKJyRAP4Sgxs3rqcNdZaQHTioEKJ44SsxkyDZQkE/I6PsFjofzgGICSYk?=
 =?us-ascii?Q?0ZizHe24+3ndeDv+VfNbcrEaR6FVi5R/78jVmqMxpj9nIly/lL7WpWe9UKxN?=
 =?us-ascii?Q?4f4otY+eWFPzQ6uQjXa7OhTv9DFpZ8FESDa5YZ1o24sY2SVgLdbAQYOhpPsS?=
 =?us-ascii?Q?0W49fl1R9HghQuA1jSTpsq00Of3/TA7T96luF6klMRNDSWrRdMcPG/WoiQgp?=
 =?us-ascii?Q?5n5blj/9bQEQeoRB4+F/X3Oe/RBnx2QAS6yedkriBDy38ro2oF3mjXBtFmhx?=
 =?us-ascii?Q?jQsSCsNY6MXHvvHrTVu2Ba5lqANi9Brvn/Vi2cpF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561faa10-2822-4347-ac25-08db028ddc75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:31.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zh27pbEfi2KCR/jVvaSszffWO00MpYljhLYON8/S/kAxnOUIZWyTlJT2NT81EvurB9voTagW3Ath4b0j9E2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rx_watermark parameter for struct lpuart_port to make the receive
watermark configurable for different platforms.
No function changed.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index eac5243a9db0..e4aa161e61bf 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -262,6 +262,7 @@ struct lpuart_port {
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
 
+	u8			rx_watermark;
 	bool			lpuart_dma_tx_use;
 	bool			lpuart_dma_rx_use;
 	struct dma_chan		*dma_tx_chan;
@@ -288,38 +289,45 @@ struct lpuart_soc_data {
 	enum lpuart_type devtype;
 	char iotype;
 	u8 reg_off;
+	u8 rx_watermark;
 };
 
 static const struct lpuart_soc_data vf_data = {
 	.devtype = VF610_LPUART,
 	.iotype = UPIO_MEM,
+	.rx_watermark = 1,
 };
 
 static const struct lpuart_soc_data ls1021a_data = {
 	.devtype = LS1021A_LPUART,
 	.iotype = UPIO_MEM32BE,
+	.rx_watermark = 1,
 };
 
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
+	.rx_watermark = 1,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {
 	.devtype = IMX7ULP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 
 static struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 static struct lpuart_soc_data imxrt1050_data = {
 	.devtype = IMXRT1050_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
@@ -1520,7 +1528,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	}
 
 	writeb(0, sport->port.membase + UARTTWFIFO);
-	writeb(1, sport->port.membase + UARTRWFIFO);
+	writeb(sport->rx_watermark, sport->port.membase + UARTRWFIFO);
 
 	/* Restore cr2 */
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
@@ -1555,7 +1563,8 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, val, UARTFIFO);
 
 	/* set the watermark */
-	val = (0x1 << UARTWATER_RXWATER_OFF) | (0x0 << UARTWATER_TXWATER_OFF);
+	val = (sport->rx_watermark << UARTWATER_RXWATER_OFF) |
+	      (0x0 << UARTWATER_TXWATER_OFF);
 	lpuart32_write(&sport->port, val, UARTWATER);
 
 	/* Restore cr2 */
@@ -2731,6 +2740,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
+	sport->rx_watermark = sdata->rx_watermark;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;
-- 
2.17.1

