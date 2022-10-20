Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448A606172
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJTNV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJTNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:21:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140081.outbound.protection.outlook.com [40.107.14.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768CA152C7C;
        Thu, 20 Oct 2022 06:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw0eJJgmxrY4fcdwmR3kgRezMmpHYceP7Hn/68xrjoTts1JUjo5sE4AJQSiEmOrWf1oMN1ezX0dOpb3b5cFEaQc9K0v5KWYDvGBmPRGXzz7fhUo8cav9nYVsNrfK9Jr4QAB8R8xwTqYBKzPVcPEhwMYItQ8mbCaKyg1EDGqt/TewqSbFauMt+X6lGbPlweyAJiBSCGaKOhGt53TohIaKbvskQsFrkkIKP0cT2ux6H/hK9hf3ytmb+2Q/zz/o0JE/6g/Scmbl4Ae2OjujEybSnTH4YMpOyHftUe/CWtREdQ9IlWBIydmRpNL/1t49UmqyXaY9ptSXT3+jWY+h/4u0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV3pmMrujOspTetlu79XoxyVbGXkDxxjfk0oIDHZI6Y=;
 b=D16WmcthNASD0FpSSudWIUa1MkzVfQTEHKyl2d9qi3ySdNXGoI6DJqnRtzXJxn2u6Rn9Kcy8ZEjgYkFVNjHDnp4seGn1bJdQUwt6iyYURHLDAzXPE60yBPdr1zQucirMrWVAvJw6ADOdgc9aZRQxF9hyAylHhgXMDWeQK/USMwR0puOrEJvnMI6ksN8hobe/FTlrjlVTQshrwvmh7EPsBpv1Q9xypoGAHUVK5MIogMBFhVYCxOkmKqGXrOQnQVVW4QnhwY6xN4AQCebOunxHba+o1wQ+3rwB6S2ZBIY9S8O5415DhZZ5mzLm/4qkLTtL1rWTzU8MEZUB6OjiZw3OTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV3pmMrujOspTetlu79XoxyVbGXkDxxjfk0oIDHZI6Y=;
 b=dVYKyXJeMciyN1RZw5LSjxnjKG/pcCPPmzhkzVM9u5YupnzagkepFF3Hz9xAc6mH6Pf2eRqMO2fZLK3Rbq50NTho2JApE0WXUoytDoOYPpXIBn444cslInvr2lBv5H73UtyhtsFSadwBrKy/wVTFbGd9nE0ziYWUy7y3bu/mMbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8699.eurprd04.prod.outlook.com (2603:10a6:20b:43e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 13:21:08 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 13:21:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3] tty: serial: fsl_lpuart: don't break the on-going transfer when global reset
Date:   Thu, 20 Oct 2022 21:19:38 +0800
Message-Id: <20221020131938.32454-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AM9PR04MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 812e99ec-f74d-41aa-2cd7-08dab29df2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdfIb0hhDtQ5hNTwgREfR3q6u880m4Zr0vXwCbTCAs9+kelWqFmn26xmBmW1LaQANffJDZWsV8NgktAo3952Yyma15DdrW8+qWfj1fj3o9ovGshbyzGuJt7tRZ1reTmKDee83gEn7FYj91+4KpaFrbfIGVyBajGG+97OmtRTe68N0oP43Yk+1fr9OmQHlsam33tpaKst3wNBMNYuaHuhCsi4WKLkMV8/11A87htejC4LyzwmjjAS7UKh1R+EYcEt+RLeD+/APdHhUfbrq8WbYkzx38be77dsy0LDdf/HACCYrndan0Atd2+5Cla/ztk8to0avQUfW8A7EtxiDOzpo7SvBrd2hZd/FrpYm4pEI7KLLuHA0hs84e96nXH4wID0r4Qy/lnVGTksApC51iMeFNdOwth8pD4xahm6kbhXwBLyJ4z5wev9LhIMwvYEVAx3gAypkS8Zf/TWiz9yggWf9kLPBBuIXK5HmD6rwInwsWIGXwx8PwjOBBkE3BPdeqJFHIdl9SHK4+L52//gdQXGUNx+/WBl/s5Pc4/JfH9/r4Ye6JfvvZDzsj93cEJP+8QhdJQWv5yBnpG7ba3kH+zAFncicbIUarUmtpLJT2Uba3sPv7wZLVhaFffnzbkFOXo5V3KXJS/XuzAs9R80qXl0fgpvsqcD7+QIFXszqCDrx3LQjjYucLwuc3g4B4RySdj1CtTfx0lVpSuVR0W+kmrzaecmXkYwQet9E0MDxlJVAwKemTSq/+7kCke8yIe4bkhMvJGGv794nr307ybQ89Rqvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199015)(6512007)(26005)(6486002)(6666004)(4326008)(8676002)(66946007)(316002)(66476007)(66556008)(86362001)(38350700002)(38100700002)(478600001)(41300700001)(36756003)(6506007)(52116002)(2906002)(5660300002)(1076003)(186003)(2616005)(44832011)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0jxA9iTBCufgX96cG/ShgEdQOaxlR37B/SQwNkX7V7LnzuCBneeSsT1p3fh?=
 =?us-ascii?Q?fF+Y/BzptP7XIi7nvv1grL0RrxDk0nS1+Pt8wz/shJQ6gTdAh/fKPzYO9vwL?=
 =?us-ascii?Q?ahqWInUS/keU1YOZ/4mIxWiheCyTfdAr+3c2M1Aj5xl6oHrVK2VnlbnRYQwf?=
 =?us-ascii?Q?Gir1BWh+CfbQ3AMR5OXPDUB7KoGCJijGbAc+Ql9Rs5A5l8i8UbTZ8KWfLti2?=
 =?us-ascii?Q?jUcwY7jQIuY79RMzWX6oxLn5T5kmhPug4RkF5RqCUZDVhdsMH2X7V3DaCBMH?=
 =?us-ascii?Q?QVBlCXEVU6ATuGiBjSdN5RzMnBVqoYMkV2uz8dBPm//R0mta6C7PENzfSgAk?=
 =?us-ascii?Q?HkiJyqw0Pwq/bvSVMwu0/gFsBipuFwDqWSzWrnsWafens6QNezyYICmI+Zv+?=
 =?us-ascii?Q?KxKFE/+WeXxKJlIrlCdex7rFUekjVUnkpvIHVaRg29AwroKEzDn6ene0sqrA?=
 =?us-ascii?Q?HxksZYepvFIljD5F3TDcsg2CnOk6vApTJ1ViE4y/xBcsCwzWzmgrXF3KkZ64?=
 =?us-ascii?Q?A8KvTi9sg6g3LkXSi6reWpKZApqXlQljOjE6HTa7OLZ2KSHfDSZhZdSvo95y?=
 =?us-ascii?Q?gvtAwczAMrOI939KJMIdxmqO6zNyB3VkuAMI2WU5NbuFYZUrL53ZSz+6eCdo?=
 =?us-ascii?Q?zx9CTKiSuqhM3EwsH7MK5PLItkJriEhXwpQRlG0OO42vtAEhDKTSC9RKVUYg?=
 =?us-ascii?Q?qohyPnwSW05itE0ZvfNhR7Du18dpgDaD2WeTZkvIPrDvmNPIJnuJ9cwKTX9b?=
 =?us-ascii?Q?puHMYNMcubthaJRqycCjCTdnqijlYg2eZsPAZbrE8Cw0av6i7OaYmYuA8anY?=
 =?us-ascii?Q?uUQ8GCRJbTZOUS+pmwiZ/jPGpArG6d66aik79v1X9mPpEkrVinN3jALwf66O?=
 =?us-ascii?Q?NnN90iLlw+3ERsF805GNB8a5dNTsJT0R+UDEkUvzK61ktIncQh3S4PqFws4b?=
 =?us-ascii?Q?d/sM84SLf+o4VbIDlmU0yYT+4ksuZMRqcDPLCOMqr3fe9FUvq7l4KfVN5gaE?=
 =?us-ascii?Q?U9errTmdPhI2JkETwylhMeV/oHnhKerqZMxmBFFJ+vxla3bjsWPsesPRXKdQ?=
 =?us-ascii?Q?EO0LZQhmM5j+W1HT5XSOFG56mHfxFXzg2fMY99pfiSaa+JYmtwH+30KfEk4e?=
 =?us-ascii?Q?KBXarsO/FHMCOoY8p4P5SFOY03Bi17WjbWLgWtYT0rPsLdrez7bT1PeCWlar?=
 =?us-ascii?Q?ZbFhfGyCe9PKL0BVAAaa5wSFWR9Pj06jz8Ii2yi1vsy+qXzQYqVPqk6cV0CF?=
 =?us-ascii?Q?47uA4Ssy57ldoWXTwzqIPSR2xN975/BxL1GgW3SirVh1CO0xvs5ywADtg8cj?=
 =?us-ascii?Q?BkHsMS36z/SXKys9DwFotwJyjz+3mFtSgciIcrWk2Mdk8azZ4TwTZW2NqFBV?=
 =?us-ascii?Q?NGjcVF+eJsX0C6cjfXmVDl+CEnfWFXR3HRm2BpMDlx9uGFzIfDS7nBsxsabX?=
 =?us-ascii?Q?kwEwhRuC8Qmm4hgEWaeMMLPKkdJIzC+OLurRVl7/FKtCLERsfk9fastUPcMW?=
 =?us-ascii?Q?0M2jGFrZri6/usGmYNtWQjvWr+oYs4O4lw1SL0n6fJIGHHyCIeEF0VL201rW?=
 =?us-ascii?Q?XMPD+QB4EZ0ZGW/+/zpZUhg4AA99aaoj3UhmrL0B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812e99ec-f74d-41aa-2cd7-08dab29df2e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 13:21:08.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct7PAOTy/grmoMG2Eqha4HO2lbpjdmTNDD40hXXKMPQL+mvBRIuEA1eIGt2HeRZnPHZMp/sos+PRINSjgE6O4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8699
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart_global_reset() shouldn't break the on-going transmit engine, need
to recover the on-going data transfer after reset.

This can help earlycon here, since commit 60f361722ad2 ("serial:
fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
before uart_add_one_port(), earlycon is writing during global reset,
as global reset will disable the TX and clear the baud rate register,
which caused the earlycon cannot work any more after reset, needs to
restore the baud rate and re-enable the transmitter to recover the
earlycon write.

Also move the lpuart_global_reset() down, then we can reuse the
lpuart32_tx_empty() without declaration.

Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V3:
1. Replace "engin" with "engine".
2. Use read_poll_timeout_atomic() to add a 100ms timeout when polling the
transmit engine to complete.
3. Restore the whole ctrl register after global reset to avoid any confusion. 
4. Move the lpuart_global_reset() down, then we can reuse lpuart32_tx_empty()
without declaration.

Changes in V2:
1. The while loop may never exit as the stat and sfifo are not re-read inside
the loop, fix that.
---
 drivers/tty/serial/fsl_lpuart.c | 76 +++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..be78c61e8a0b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -404,33 +405,6 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 #define lpuart_enable_clks(x)	__lpuart_enable_clks(x, true)
 #define lpuart_disable_clks(x)	__lpuart_enable_clks(x, false)
 
-static int lpuart_global_reset(struct lpuart_port *sport)
-{
-	struct uart_port *port = &sport->port;
-	void __iomem *global_addr;
-	int ret;
-
-	if (uart_console(port))
-		return 0;
-
-	ret = clk_prepare_enable(sport->ipg_clk);
-	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
-		return ret;
-	}
-
-	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
-		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
-		writel(UART_GLOBAL_RST, global_addr);
-		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
-		writel(0, global_addr);
-		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
-	}
-
-	clk_disable_unprepare(sport->ipg_clk);
-	return 0;
-}
-
 static void lpuart_stop_tx(struct uart_port *port)
 {
 	unsigned char temp;
@@ -2636,6 +2610,54 @@ static const struct serial_rs485 lpuart_rs485_supported = {
 	/* delay_rts_* and RX_DURING_TX are not supported */
 };
 
+static int lpuart_global_reset(struct lpuart_port *sport)
+{
+	struct uart_port *port = &sport->port;
+	void __iomem *global_addr;
+	unsigned long ctrl, bd;
+	unsigned int val = 0;
+	int ret;
+
+	ret = clk_prepare_enable(sport->ipg_clk);
+	if (ret) {
+		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
+		/*
+		 * If the transmitter is used by earlycon, wait for transmit engine to
+		 * complete and then reset.
+		 */
+		ctrl = lpuart32_read(port, UARTCTRL);
+		if (ctrl & UARTCTRL_TE) {
+			bd = lpuart32_read(&sport->port, UARTBAUD);
+			if (read_poll_timeout_atomic(lpuart32_tx_empty, val, val, 1, 100000,
+						     false, port)) {
+				dev_warn(sport->port.dev,
+					 "timeout waiting for transmit engine to complete\n");
+				clk_disable_unprepare(sport->ipg_clk);
+				return 0;
+			}
+		}
+
+		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
+		writel(UART_GLOBAL_RST, global_addr);
+		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+		writel(0, global_addr);
+		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+
+		/* Recover the transmitter for earlycon. */
+		if (ctrl & UARTCTRL_TE) {
+			lpuart32_write(port, bd, UARTBAUD);
+			lpuart32_write(port, ctrl, UARTCTRL);
+		}
+	}
+
+	clk_disable_unprepare(sport->ipg_clk);
+	return 0;
+}
+
 static int lpuart_probe(struct platform_device *pdev)
 {
 	const struct lpuart_soc_data *sdata = of_device_get_match_data(&pdev->dev);
-- 
2.17.1

