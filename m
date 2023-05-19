Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C409709422
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjESJwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjESJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:52:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2CE6;
        Fri, 19 May 2023 02:52:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCFj+e+/1ay6YoUBCiUZCwYvRLWbKMvhV0nUe+OT3sgcM7cwqGWzekGRccRCNZyFbmphNBeT1PdLEvPUcPKGVugE7JOZ5hoFME1p7Ixan+dLVMod6ebCxrmeDcf/vgFT0TxxphuKVum8JbvflgofvY+GRvfPG/V6kB/Po/WQPF4j5OD7sJqJ8ZcGzk3uBdEKADKdMSt0bxAkvleo7Vh8w0zPJnBK3Y4r0mVLVoffUAsm83ae4SyIXpiG2hR1Vb4GRRvmpxfZPUf12O9NVXWn+AvvCjtS7UhrxBbu7KKz5UhE2aiuWBbxDscl/SXXb+/0cnRW5XFajvOikHI6XRhoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrSoyS1Tg/AYlqxA2IF9qrDpTz+AN+p/ar/pPQIlNfI=;
 b=WHJI5kDPr0wrB+VP9zc3zls+60AF9zo5VTL39p6Ea5xM9/jUYXYuCY+l2JkPtg99B/ZCW6VAe6Xs9oxneYGq+IqMLkvdyhn69t7cHDw5yF6rJif+fdcWXhb//sZb36l7RO6z04d3QHvT7B7bNdDTJHP23U3rzRJsJs+ciorKs/XFbEOIyeGFwBDoLltDmY2dVreA1kMyhGunOIiHY6dqxjjYXkmjzGwFsvQj5ZE8HArKSZxRlZxUYvy4NXeGknsGfCM06qjqD8po5Od0/fXgFr5MgAUT/jCHcx/TfX6Cf08Ti1xeAPIiTFV7bwYA72hm0lb9jRpyCoxfJykLw0hT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrSoyS1Tg/AYlqxA2IF9qrDpTz+AN+p/ar/pPQIlNfI=;
 b=SAtkjP2AhUeLdNKpqRCCubaVq7TilkAGun2aU0BjzEnjYFF/qogFG2J3TqZ9rVCUcR3EHWHsNxGaD3yJ0TGYLad5O16SJWGL6/eHOjnrQcYckXcU+Mh01zvhSDAgL2U4HKmsWZxUPiQ3Sb8aSTnR3CmH7QXa3rgx3y7hutyuMjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:52:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:52:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK
Date:   Fri, 19 May 2023 17:47:51 +0800
Message-Id: <20230519094751.28948-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|VI1PR04MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbd2eaf-7898-482c-a905-08db584ec65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpPKKS2p6jx9NseEpA6uCKnufutl/0alXRa6kr4obbPiRB9SWMU0JaqBMbd3RALccLdzHjWh9UpR9zo4R/PWZlMuvikBK2WdIrw8ShFSin8AMWOh3gKgsbHy450qiD9ibfov58hg7OQeZSUY7YpJ1njtIW2vXkSPa/Xte2Z2ZCqqhELp/STLWgad8vuX97hINPHZWbAkk+OTB/Eag6HaO1WY+p3vNA2ABYpg5mh0riwPkLkKpryboHJCf52Gdv4NBOsygfhhlauZnsjJsXMYqLsoc8qsk7wz2C9egWgfKHuBvXv54t/+FNrA0OUuGvarTlAYSuQxI1KdtTvJc4i/pdk3oh7hIrHf8qcj2e0YLPmO/dJmdNVnhC+A5Pe7j1OvF/nVIz92Dr7t4Fan2BpYKBMh8cTdL3lN/7h586YVEQOBUUwPUHNHR5mUJ0v/UDrNRpO0pSGgO9DikmEMxJUFi7Mlda1/oE2+GkKhZB/11naYIuH85PQE0vbb3pnPDo6oWg8RiZ18Y4aXTgcpw+u7igUWtyG+rWDax8TSRokAKw50/YIfsXUwsWjnw/b6mgfxX6Oq3qyV8fTuKYmTu1xUikGyJWbct97DXEiz2uX8tSy+HRHGc+8NZRhLLx8emmax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(36756003)(86362001)(316002)(66556008)(66946007)(66476007)(4326008)(52116002)(478600001)(6666004)(6486002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(44832011)(38350700002)(38100700002)(2616005)(26005)(186003)(1076003)(6506007)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5HND9a3cdJu+dAXhEhQs7pgY2oIyTExGDv/UQMNkf5OJ+zLExok9PttlrnA?=
 =?us-ascii?Q?lH4KV4CaODFy8yTzFNmUmqdgr5K/E7hx4ZvpVQ/IZ6kz5M83exEd8KEBEZb8?=
 =?us-ascii?Q?mNQQSU9pHiY9hkl67IP70c2NmeQ6RRPahni7BavRpFyXWtXK+06UEo/bIl0u?=
 =?us-ascii?Q?r5ZbLE+Qn+FYT5M5B+vP53L7A8yezqAylP3PZlDOtzN87o+5J+lQCMiOI2Ty?=
 =?us-ascii?Q?0osAkvMczTD/Rd557UFgGXvBnukyYjoKEVDGVDsKde4CTk1t2TOXrj8/2Nlk?=
 =?us-ascii?Q?/bUu36ipl3522+OHlCcF6pT1STuvJ+StaRJiVcxPJo//vb/3TPJQRIryz/bH?=
 =?us-ascii?Q?/u6KClZvQH1gnRNUIeKgNTN0gddwwQWQhy60DwJRtmgcUNLw4+u2p9TuBrVS?=
 =?us-ascii?Q?ot6FXwFGNxdzPzgA5vguJLrPA6F3KtB59hTW+IcyzHqZ0G2X1GULbDHf4V5F?=
 =?us-ascii?Q?beLfJYuaaSQco4Q7DVMEiOO7mg5a9vtP3iF6Ol/3vr7eltJ9288E6lTb/a8i?=
 =?us-ascii?Q?7lhaYg8lyToi3FZs/G5DtPJY2v5z0U3CSQsYwZ5BZMh2HyP7ko+vAxK6ks9s?=
 =?us-ascii?Q?xCm08BZCZhN5JfvtjwFI07msxty54Qqdg2iX3PGwq24raWKeRTSkfiNb3nQd?=
 =?us-ascii?Q?ZjYWlmiSviU77sUz8D/+5aEnlWMwyBdb8adH9IQyF1+vkgowIyh0TjbLZq9M?=
 =?us-ascii?Q?Af/5wFwy6zxQF/d+GAzd/N43YFKjgOGqO7cqIYlpSV7ul5GUBdSmuMJ9eVWC?=
 =?us-ascii?Q?NRuDteWyiEk/UdfIRreWUE/V55FxaTxBI5Yw7DTv+HuCrhveqiFHY5/xO1g1?=
 =?us-ascii?Q?bNUYrmltf0P6tU8eHmiaPDqy3SlMjOdFyxlXkk7HL+1v2BDkmptEatjfQFiQ?=
 =?us-ascii?Q?HKrrC1IF2Kkg4mXnAJS7cOkcRkFlAz4Rz+45eheEZLE9ChsbVUWNkFohroUr?=
 =?us-ascii?Q?NYA6cc3vyRJauQhYIA968v+Zq04Pg/P3xYMnndnwt75m/cTbTSoV8mDzyV6o?=
 =?us-ascii?Q?Uq7paQggI9vgtp6dUrtPcvPMVx55jno93ZnOrHcr/RwNznXDOnhrs1Pj5lex?=
 =?us-ascii?Q?6ije3DOFVjxi2bgsZ4ilPHGz26cBYJo155g1Gufzgd0TvyVQ+fViTFeHzion?=
 =?us-ascii?Q?IoE/X+07/YHko7Zv1gBErymIGZLPCbuqGtT8d9vBPdH80zwUmF7EjQ0gFFVA?=
 =?us-ascii?Q?p+5BIT6Gq3PO+oLTY5pOYDi+QzU1sZb6Ako8Fa1D9yxJkSKSCqSLhDqORgQD?=
 =?us-ascii?Q?/jKFYuJutQn9ixem+z1sCDDBoqiy5YcO0Cy4Yf85bYupq3Vg7gwZn31+GZ+I?=
 =?us-ascii?Q?Hfga5SriAX9GVJOb1kYiog/JVfClX+7j0vQPzha4NjVNVOe9SXe2RlrNyVzW?=
 =?us-ascii?Q?wux260QZIUOpRtlWYqPujnr3sKRz7+crL9Q6m+tjXGnGFDGYQTd/QdLKrVkx?=
 =?us-ascii?Q?tqmJvBkI87tpCQPHGbQRjz0OOO5/8QUtR4Vqcc9MrWXYfO8GRPV+tgG0Bx60?=
 =?us-ascii?Q?LXayXOOSExBmBfRqW7xJE7T0ulTknbYrvOZq36qeD3yzvpE23ZaOJaYzE5t0?=
 =?us-ascii?Q?PzPYBu4nYYfbwK2BFUXzkR8jP1OQSxHk0GMSfEzk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd2eaf-7898-482c-a905-08db584ec65f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:52:36.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9Mx9Ngb+GUCJmyBh7FAok0JsV9pWgswkw/RBJb+qIAmh0PU5f+1hdwv/IiNyY6ZTXA1ywtKAh5OxNmuO7+Yyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPUART IP now has two known bugs, one is that CTS has higher priority
than the break signal, which causes the break signal sending through
UARTCTRL_SBK may impacted by the CTS input if the HW flow control is
enabled. It exists on all platforms we support in this driver.
So we add a workaround patch for this issue: commit c4c81db5cf8b
("tty: serial: fsl_lpuart: disable the CTS when send break signal").

Another IP bug is i.MX8QM LPUART may have an additional break character
being sent after SBK was cleared. It may need to add some delay between
clearing SBK and re-enabling CTS to ensure that the SBK latch are
completely cleared.

But we found that during the delay period before CTS is enabled, there
is still a risk that Bluetooth data in TX FIFO may be sent out during
this period because of break off and CTS disabled(even if BT sets CTS
line deasserted, data is still sent to BT).

Due to this risk, we have to drop the CTS-disabling workaround for SBK
bugs, use TXINV seems to be a better way to replace SBK feature and
avoid above risk. Also need to disable the transmitter to prevent any
data from being sent out during break, then invert the TX line to send
break. Then disable the TXINV when turn off break and re-enable
transmitter.

Fixes: c4c81db5cf8b ("tty: serial: fsl_lpuart: disable the CTS when send break signal")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0e56fa64b4ce..92a3bd0f4158 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1536,34 +1536,36 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp, modem;
-	struct tty_struct *tty;
-	unsigned int cflag = 0;
-
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		cflag = tty->termios.c_cflag;
-		tty_kref_put(tty);
-	}
+	unsigned long temp;
 
-	temp = lpuart32_read(port, UARTCTRL) & ~UARTCTRL_SBK;
-	modem = lpuart32_read(port, UARTMODIR);
+	temp = lpuart32_read(port, UARTCTRL);
 
+	/*
+	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
+	 * break signal, which causes the break signal sending through UARTCTRL_SBK
+	 * may impacted by the CTS input if the HW flow control is enabled. It
+	 * exists on all platforms we support in this driver.
+	 * Another bug is i.MX8QM LPUART may have an additional break character
+	 * being sent after SBK was cleared.
+	 * To avoid above two bugs, we use Transmit Data Inversion function to send
+	 * the break signal instead of UARTCTRL_SBK.
+	 */
 	if (break_state != 0) {
-		temp |= UARTCTRL_SBK;
 		/*
-		 * LPUART CTS has higher priority than SBK, need to disable CTS before
-		 * asserting SBK to avoid any interference if flow control is enabled.
+		 * Disable the transmitter to prevent any data from being sent out
+		 * during break, then invert the TX line to send break.
 		 */
-		if (cflag & CRTSCTS && modem & UARTMODIR_TXCTSE)
-			lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+		temp &= ~UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
 	} else {
-		/* Re-enable the CTS when break off. */
-		if (cflag & CRTSCTS && !(modem & UARTMODIR_TXCTSE))
-			lpuart32_write(port, modem | UARTMODIR_TXCTSE, UARTMODIR);
+		/* Disable the TXINV to turn off break and re-enable transmitter. */
+		temp &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
 	}
-
-	lpuart32_write(port, temp, UARTCTRL);
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
-- 
2.17.1

