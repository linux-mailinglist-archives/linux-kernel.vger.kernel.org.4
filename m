Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5746228E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKIKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiKIKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:12 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0785824099;
        Wed,  9 Nov 2022 02:47:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4t67VVuRFeUDY6FfzVJo/OgFiNerdcMxbmqyRsBEI/ixBQeuvrDMlEYB2OEQ6NmOIbrxufCtzDSl0TF6zEkcC/4fWpNaWGM3hGM1pUXO9oCGJxGnwOqc/tACdHXmvGeUIIq/brtMNuS5Io6rr7yErNGzVdMA1SFtqqZtln4XmhXWHBISIeuxHK9VQ8y/GFtMz5FOwTi7G66qwjT11w4qls6KYaxOclYsvn2aSaF6K1QJFu5usWx47zp6rHlpp0hJKsJSRdqTkQdZXOZOysKA2Ppd6Qk+5v82GqjCc+zzQCEIVO1rawenctJuwaimG/xYaCNE42YMqIMJ4ANT1kPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a75+bEwNy1nTGQmnjrn2PlnFepRP7Rt9WT0OsQZt+ew=;
 b=P7FqeI46gnncWKlKFu3c7nS7bqBGIWrQJKZzYRm9Ded5otfL3NDOUL/bGqwYpb/wwIBCq5p2SfMKL3AC6RyBkn4w5Luz7kZXoRrVbbi47cvjxbwZBDrTbzMmH/2Lst/8fdPK+h5UCJq3zIyfd1tKzVIasPvlGNrqLnFHNpBRoCzsyezDJLjrrFg30+nGV/DBQoZCveD5RtISylCPGJ183bbznucbWs/ns/jvD9Gy6l8Mr38aiPVuZDImtXwpI0tfqIlMIs5ohrhGaRCi83gA4PtelVf08X5okyofBmTwpM7C1w9tuOYBWaBWOaT74eX7dw6gYAH4eaPKxx492QuDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a75+bEwNy1nTGQmnjrn2PlnFepRP7Rt9WT0OsQZt+ew=;
 b=FuZSmpGk9cwA4FImuRzygFKpgH3ZCNzhO4yQBk+HyORfv/vjanNi3sDsOZqGu6FgAtCzD0iDAmVK91NSk/XKRCWXb+qA0uclAL8zYIMEwglbYzMFmBtUt2FykZTiZMuY2KQ3ENNAQkj3MMYJDMrwTFV0O3wWU+RtmlT7lJ8i7i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8974.eurprd04.prod.outlook.com (2603:10a6:102:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 9 Nov
 2022 10:47:03 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 10:47:03 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma case
Date:   Wed,  9 Nov 2022 18:45:14 +0800
Message-Id: <20221109104515.17266-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109104515.17266-1-sherry.sun@nxp.com>
References: <20221109104515.17266-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cd4161-2c8a-402a-e928-08dac23fbd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BuzLHnUEDzxnhBAweJhsVGHabn7Naje3smdaxfnh2f0oUYwxjn39tuvWajx8pAslzynUMcnwLv7H+XccrDURlrLv73NYd69nbzu4nRJrsgAiZAw3hcOPvZmg9q+przrd7j4g0szcjGAKNAyXmRRG35pXYwk0t/fbokE1nFwtR8WmcCn3caWc/jweElrmVUaIjN/DAetby6rxhOHM8n74daimjiyXr52U5v87cq4qS79hCwByMXVy5W83H+PbyYmVi//wlWb8YjzeIkUSWveHptYO4JFB0j0XGVmhAFobf4BsHq45TQwZm3lbzyxFhgb2gdU8Rg2yRjiPyO37VWvTd6fwlOC7ZF9h1lqfn3EF+BaIWlWe2QgFhsW2AOR9ZNsDlgxkRSRfRU+vT2Z2+n3Tn5Q1181tv+rx1mSVAiNOtTTXB4ru6faoQ7vsCXHfKshVvv8j5XZBllyD3GUkP+eoJba40c5Gq5h+0F2XHHbQlRWKXjO0ur5JoeIpvqfU9iuM4GS1hwmJRMVtUFc7ys37JqOrUuYxIBr38v3mrqqv2MPejPdKoWsVLZxFW6my1tzKgzCY6UkBES05MOQ+jmz42wI+439RF/xvmVYEVeKRkMaTa5r9mwExqJYEdXbTbF6c17ZKFycYJmzrQ14QafvcAgMTYeOQ6MkkpdV/qMYX16WDxPQujOsWXTZdQiad9MvHDwSTb5s+GEgtmHmr/Vg8g5QpjEpc7OQHGSukPvMsthOk3WcKNbyVRVnCVSs9S+mWnruKJujHl3++Lpx7R9QYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(186003)(86362001)(38100700002)(38350700002)(316002)(66476007)(66556008)(66946007)(8936002)(8676002)(2906002)(44832011)(41300700001)(6666004)(4326008)(26005)(52116002)(1076003)(2616005)(6506007)(83380400001)(5660300002)(6512007)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IIqyeZr7oQ6qIgZUUf9NEbEw10rElc2AZWeJnUPy6/KYg0C10usMs2is/vSa?=
 =?us-ascii?Q?IaVef5E6zgIOQGjpyGGJOKa7NKdsv2DVPk1JLHkh15ZjpHhkv1vaY5lZPxzG?=
 =?us-ascii?Q?Gz/LAa4SMVbflxcJjmsj/3NxaGf+oTZGL5afsJopm1YpyoUUhX4umoGcRfZo?=
 =?us-ascii?Q?LJ5ZIZV3z67hrMAjsOpCrK5skNMwpxymj8CD4IDDcjIksNSutZzPGEgA4Dyy?=
 =?us-ascii?Q?ZvfyQqxzmFMsVUklXtibjZlABhIQ2IstHJzgyZUaAVyttQr5l1P6LjECnsqM?=
 =?us-ascii?Q?x7y1epAmDuc2Yl68z1KPoJhb+0gEOibnM/kiwEZG+hsUqdbpiorwkAQMN+oG?=
 =?us-ascii?Q?2uWkLuIP//J5qltzPla6zGcKW5GxXtI0pAgFk3KpeOWZruZmMxFCPOjFH+hG?=
 =?us-ascii?Q?+u8JtDVGHssOhlR4KUB5LhgkauuMeKZCLjzUKT4AN37MwOubHMZnAC/fgRYY?=
 =?us-ascii?Q?VcCaYmYPoEOZGd3+6sS+YUIYPcwnLunzS7htCfoG2K7vI+7HDdqEfvMqnpzx?=
 =?us-ascii?Q?cKTx0aPqh6GSF8H9cLswX31KKr4+1DmHUavPj1Lt+gnOsm2333CNIBG34FCF?=
 =?us-ascii?Q?H7acsb6dmongXZJOdjkGptYuf2800nRadszRbENTKdS+hRVmqtMPmhaGE1cP?=
 =?us-ascii?Q?Sa0lkRki3K/wZHGTCZ4dZi3JfEohX+DE0r5IKmNAww23RY7VP18SG++DCQV/?=
 =?us-ascii?Q?58Hn1UsdKsZgRNium3J8z020lw448uSmM0ST+jUftcrRRPELpw4Boe66d+wx?=
 =?us-ascii?Q?yfdVOHEe2YVhfO7WDZ/VCAgsuCc5G0sU2ZC0giAps5O32aFqCE/E/KaE1MsA?=
 =?us-ascii?Q?t4SCbi/BqbJiZ2oHyaYac9Mb2dx9Ph91RouYL3i3dJ/45LF+/5cUxhGk5MAa?=
 =?us-ascii?Q?CsJyA+aODO3K4GIw3M/VVh2lppIBNsQQZ5Gk2mwaf8qQVtwZ1Y2lE+aUYzAC?=
 =?us-ascii?Q?koaMAub7SU2rxX9lG4+9aTgbajPCU4xgeMmk64Hrb2pWr8YE10Ck7Csryjaw?=
 =?us-ascii?Q?nNLmJ0wBvUkbHuPhdiCFvfW1/ThcVA0Q0xN1t2EePlRPkes41j7RhFsv/r8w?=
 =?us-ascii?Q?DSGA8czrRqiG5gVFHYmHcjCd2+d/SKSWt5fqOeEa8xZtlJxgOZL4znfMKPje?=
 =?us-ascii?Q?FQX3E9zD6g2ofFORbDrHY06OIiBTRjRGdP6TJVkEVD2uDqkYMO/+CGheEVoq?=
 =?us-ascii?Q?Qjf9Z4J/DhjatzeiJaSJgwpGMgvdwRz3ms0iIPkoVBk+3nmObyO1xkFg8LgU?=
 =?us-ascii?Q?+KN+Sd63Hz1+YsIX10JMtvCVQ4wfDniNkhF29ARAhDak23zi0jQdiyfYj2SA?=
 =?us-ascii?Q?pmmDD/vw2KTOGnEPQL44DcfdXjnCEK3J/X8ovATFXaOqZ385D47T1EZ6lzMj?=
 =?us-ascii?Q?zRzDDCJ5zs6+9rmnDv29yRkRsKmyTPH/hZ8CQXv8oNA0+JQjeQRejEJm2T9h?=
 =?us-ascii?Q?a98CyO0NpH/6TpwvgAukkyd+ZFRokehvuKdrRFeDPiz73DIKl9MzjBHfxoyR?=
 =?us-ascii?Q?ngrq+WKFqcaris3/jdeIVMh3NXcaIjU5pjssjieklSP86GCqsc4Qcq+/dfqH?=
 =?us-ascii?Q?/D0s4iDFoFK3C5JAYPVfVKx7TxV6OXYy2fWUiLBM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cd4161-2c8a-402a-e928-08dac23fbd08
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:47:03.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSH5PoonnVg4wWEg6mNs+ALfSm+dUCtJwWLIS4D9ilSEwBjRKhOgeiKfNgGc0LF+5KAEDY2z/9yczNSz/AdVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974
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
index bd685491eead..f5a0a14fa366 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -179,7 +179,7 @@
 #define UARTCTRL_SBK		0x00010000
 #define UARTCTRL_MA1IE		0x00008000
 #define UARTCTRL_MA2IE		0x00004000
-#define UARTCTRL_IDLECFG	0x00000100
+#define UARTCTRL_IDLECFG_OFF   8
 #define UARTCTRL_LOOPS		0x00000080
 #define UARTCTRL_DOZEEN		0x00000040
 #define UARTCTRL_RSRC		0x00000020
@@ -230,6 +230,8 @@
 #define GLOBAL_RST_MIN_US	20
 #define GLOBAL_RST_MAX_US	40
 
+#define UARTCTRL_IDLECFG	0x7
+
 /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
 #define DMA_RX_TIMEOUT		(10)
 
@@ -1506,7 +1508,7 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
 	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_TE |
-			UARTCTRL_RIE | UARTCTRL_RE);
+			UARTCTRL_RIE | UARTCTRL_RE | UARTCTRL_ILIE);
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 
 	/* enable FIFO mode */
@@ -1530,7 +1532,8 @@ static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart32_setup_watermark(sport);
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
+	temp |= UARTCTRL_RE | UARTCTRL_TE;
+	temp |= UARTCTRL_IDLECFG << UARTCTRL_IDLECFG_OFF;
 	lpuart32_write(&sport->port, temp, UARTCTRL);
 }
 
@@ -1669,7 +1672,7 @@ static void lpuart32_configure(struct lpuart_port *sport)
 	}
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE;
+		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
 	if (!sport->lpuart_dma_tx_use)
 		temp |= UARTCTRL_TIE;
 	lpuart32_write(&sport->port, temp, UARTCTRL);
@@ -1770,7 +1773,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
-	temp &= ~(UARTCTRL_TE | UARTCTRL_RE |
+	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
 			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
 	lpuart32_write(port, temp, UARTCTRL);
 
-- 
2.17.1

