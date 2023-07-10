Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8BA74C9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGJBkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGJBkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:40:11 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C551EC;
        Sun,  9 Jul 2023 18:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz9GfDwk+aE3ti3eJQ6QKgRf+C01vVf6IjeSQfpKqWgkUR74oW2KfcJuTYCeOCar/bLKjj0WyA/l7UQzf24I83VKdrkVIBj0A92IlQ43mfuRyNEpxstewjM/X76ZUEuBiTiVnXh5Q7scHfk+wuje2WgaXVtvmvpL0SYMhffeeTUe6VKdw9yvc/8wEXziMzOqC6S8pUlP0lDE5dF6GrU3E0doMlq2YfFDdG0AJ9mB3qz0bHNSbfC+0yZduHvLkT5kpU843C13UlwHaQCVhlqgFbLnhpiHD5CGbs0jpsnb0uxihSjHkLie/1SjKfywxnsLkbnVGMz2MINmrEPX50HpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vABC8cqGISiJArF5df4UPRDI+ZOYYfgz93iDnE6pdS0=;
 b=b7eK2Lz9KDMIYvT/6rcd9/iV3yBpppuEwqKsd8konOh0RKY6Vm2H4EBJHtGs3sNgwJidn+fLJChx3Ft3HEbZcqbMSw7B/3F/dKGedz4GtP21thYVKaTrRz1QKFqG65JVFLN+muteJCQpXP+Dqyjz3zg9f3NOYnljz7Px9ifdjjtMfO+1mWPef6s4adIL6OfNLlHTLzhO8viiBvCXx51THjUHgUxRetxA664Q4fHwqJiAkQ6ZggFlo+/YS2w3wIeGdfk1SjLgah2goiVNX3L2olIZ1aGefXZw1WGpzAn8JeEhEHvCdviQ0WigFJD1JDVHkZwV4MIAelmOsNVbME8RPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vABC8cqGISiJArF5df4UPRDI+ZOYYfgz93iDnE6pdS0=;
 b=R1P8Xf4DtgaixIb1N5/M96cbZCLsmxTll7rPHLbN9WFBaTdjpNEG2Dw0pd4PRrN7npAhqO0oVX0bKCQokVP3dQ3Ldg/g4g8HX/6BfMQzjqB1CLLdqxk8bVHJZ8x/X74xtNmZFEASZVGni2+tJkMUdAJA+9xqmelNC/hVLK+OM/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 01:40:07 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1e0a:1ed2:2e4c:6b6b]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1e0a:1ed2:2e4c:6b6b%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 01:40:07 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: move the lpuart32_int() below
Date:   Mon, 10 Jul 2023 09:38:56 +0800
Message-Id: <20230710013857.7396-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230710013857.7396-1-sherry.sun@nxp.com>
References: <20230710013857.7396-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a92f9b-958a-413e-0170-08db80e69752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNqhOZBpZadwTiASsOXxzilMxldLsPDHoaQhM3JiD491M1RBr2K5w2QD95/e7zIIcOgaSNscHZiUYpL63ogCAB7BO15G/ayf2EPHuxuQxxBlk6ThC/uk27VkJ1WDzaYeF8769wWYkQNtGm2m/iy3w+hFmGNJpt5DJScCxxHAQ2vcQPdCLrd5wmwL5T3tuW6gjhM/5CKiE7+AiH1Qx29hCUhV85K7iQ5WKAHpqx2dG+vtlDYENHo4sOGfwBWIj/qZihjWcxpJbdZJuUeVJ1p+lHTpr3XMUpk7SiUiH/268G028SctuALNfePr0gmU7EL6kgCbXmKyz3vVJFpl3WVL1Aze93SaFOTBf/O7Jf4unjxStgV2TEhTHVjALPYG8Fu7/9K0qetBcpGRyCE8gaWiISdR51FWOvhQPaCVkOLBB0jMMSMdHDzft8d7HHKvBrYOR5mhjN0GpPqp2MmUCXpnOUOB4ilCveixVs1Sdyrzcm0AlaXhxY20o7eifB4C7xRlCr5uK61oECX3rczIR3Ap8wORRTtakTrCwH8AXapw5nxYRoDQ5+bCeJnlAITctP8k3mrdnWxXVjnfvoQ3Z60VQrwHNnA7NRUXBF9sh4i1CJeIliK+29zdMbYHqhhilE7x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(52116002)(6486002)(478600001)(6666004)(2616005)(83380400001)(36756003)(86362001)(2906002)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(38350700002)(38100700002)(66556008)(66476007)(4326008)(41300700001)(316002)(8676002)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajnihslwGnE1Rn7Hf+ARUcwq8dUXmUDg8C3qeG3lXmE7Js6wlX0Dn5dg4kwQ?=
 =?us-ascii?Q?HU7pY/fS7MJDSsZh50YN+JVEXmdD0mlyst/kFkH+ym4uPWkBcoydkUYewwnZ?=
 =?us-ascii?Q?BZkW9YbpWSRBOaDd3nIPJr1thgbosk2R4VS66bDgdWr1qALn2iFuySd8unGn?=
 =?us-ascii?Q?qDEassW/ahoFwW0jYABrFODMTlT4pxcEUbBoxG1kdQJj9QLPcEgQfASROcmJ?=
 =?us-ascii?Q?a0iOkDbu2qBCIANxSLNvleVBJaKVHqk0Bv/RK5kKTc0PolRDrFY6bDZgZph0?=
 =?us-ascii?Q?nq8aHDSqvffb8qXaK8ozXz6bgBgaDUgFhPaYaTqp93lcFRRad6zM5boa0nco?=
 =?us-ascii?Q?Q0Ype11ZYi8RDl2c8m1ytrjIHc/8bERRGI0f0dmTWfJvzX3aE0hsnXJskai8?=
 =?us-ascii?Q?U8rtAyQOKx5UXMXxEdoq6DdiWRzQNi0sNh1IUXgIDvSZhGlz6b5bj3Ie+tif?=
 =?us-ascii?Q?myOhPVRcu+iCvHtWuq2cqlGPJPjq3etEMrT2we+DFYD58JBLBj1e25Iz0ZDS?=
 =?us-ascii?Q?F+z+1NmoZ/Xy083F/9Zw7pkKnuhFGUm0SJdGuAcKlWMTMi2pL9YGMFK27S5q?=
 =?us-ascii?Q?JPwHpf6Vo9dtGRa9O6E5bToJZgAMBCpiHFPkPZzL3MjsM3/G78yhvFYQtxJO?=
 =?us-ascii?Q?GAc5UK7ojexI07t9I6K7RU1cWqMos3y+GfduVvlg7ul1E02IMEwatyiVEdQU?=
 =?us-ascii?Q?32LYhXe0b8xd3Nre6Skx/AsSai70f0XDfAm2AQfTEWsCWu0Va1F6+6xVr5H6?=
 =?us-ascii?Q?3vqIXyWp4dr6U7IVhkF5p7HCIewRdwBZc2MCa18+7U+qTvXE6Qk/hyIWRJGX?=
 =?us-ascii?Q?WTg8JZ/a/Q2n+tFpTgD0OYnFLz/4r44ujU6y4vLNDlSZ5KSlmdYgaOLj3g/S?=
 =?us-ascii?Q?YwAJZCwNNdXzCDV8XI9JvjwAMv999V086KnVDspS9ohggvdglWoc+K8mzbJB?=
 =?us-ascii?Q?yrZ7XzQLwGQiDXP3ddFUMZSabq245CE8GkYuwhWU/SIgrAAl/NXT0XmSei7R?=
 =?us-ascii?Q?GeCzlhWZcPCZdfIrqi8T3J0m8c7pSbSV2QA3xFWt/eUvXJdpcm+daEE2hwV8?=
 =?us-ascii?Q?4PffY59PR16Vs/BHe58z9ad6HcWPxdJh/KrDXD7cJDkb/uCRchEhvY4R0gvo?=
 =?us-ascii?Q?6etLU0reIuTJ3eLhjY3ESpolxq39mqkJmRwaw+k1dJx5ucf750oNpozqsVaE?=
 =?us-ascii?Q?LcXdpuw8bnoI+hsRlg9C7kVtmS2j9vlShRrUJf5T3IJvZV5L9QJ2TvvlLUTe?=
 =?us-ascii?Q?SDiJGaUinok+4IBj+q7NA0dYrBSJQfIw7AsHNzHsG+Rbe/jNmqW9J3exN3/x?=
 =?us-ascii?Q?sGuW4SgSzYfbNcSUTB1+fLw7ALdTjgRFSh/tl0234ZzJwwZNyrMVjxqyTUlf?=
 =?us-ascii?Q?/KxgpBJFJajUOAPPDFeELy3ElKz8z2tOlRsj0YXO+eQDRvJuPUOl3kHR8t38?=
 =?us-ascii?Q?TfASD4asZuGU9hbMrpo71OQscpWdLdtZ3dNHt1Ouv8pdfvYAd5xti9LJhfHp?=
 =?us-ascii?Q?I1hR48pofdB+CMftikS2kIXTa+/DkZTICgISS69hqSL9YqvNEFwa2li0ek7t?=
 =?us-ascii?Q?UrlUeePygiKmIwXS2fzuC2JuQ1XPoq8BRApdm+A5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a92f9b-958a-413e-0170-08db80e69752
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 01:40:07.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iI0PQyAM/VMToV2EGFNkIOQI0netzL7CUC2k/yIjeAk6ZvWNbHs2JbTIebh3Qe9ikUIZMLDemaUX0W9An+xOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the lpuart32_int() below lpuart_copy_rx_to_tty(), this is a
preparation patch for the next patch to avoid the function declaration,
no actual functional changes.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 39 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6c652d77f566..653cf8eb5a72 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1066,26 +1066,6 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t lpuart32_int(int irq, void *dev_id)
-{
-	struct lpuart_port *sport = dev_id;
-	unsigned long sts, rxcount;
-
-	sts = lpuart32_read(&sport->port, UARTSTAT);
-	rxcount = lpuart32_read(&sport->port, UARTWATER);
-	rxcount = rxcount >> UARTWATER_RXCNT_OFF;
-
-	if ((sts & UARTSTAT_RDRF || rxcount > 0) && !sport->lpuart_dma_rx_use)
-		lpuart32_rxint(sport);
-
-	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
-		lpuart32_txint(sport);
-
-	lpuart32_write(&sport->port, sts, UARTSTAT);
-	return IRQ_HANDLED;
-}
-
-
 static inline void lpuart_handle_sysrq_chars(struct uart_port *port,
 					     unsigned char *p, int count)
 {
@@ -1278,6 +1258,25 @@ static void lpuart_dma_rx_complete(void *arg)
 	lpuart_copy_rx_to_tty(sport);
 }
 
+static irqreturn_t lpuart32_int(int irq, void *dev_id)
+{
+	struct lpuart_port *sport = dev_id;
+	unsigned long sts, rxcount;
+
+	sts = lpuart32_read(&sport->port, UARTSTAT);
+	rxcount = lpuart32_read(&sport->port, UARTWATER);
+	rxcount = rxcount >> UARTWATER_RXCNT_OFF;
+
+	if ((sts & UARTSTAT_RDRF || rxcount > 0) && !sport->lpuart_dma_rx_use)
+		lpuart32_rxint(sport);
+
+	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
+		lpuart32_txint(sport);
+
+	lpuart32_write(&sport->port, sts, UARTSTAT);
+	return IRQ_HANDLED;
+}
+
 /*
  * Timer function to simulate the hardware EOP (End Of Package) event.
  * The timer callback is to check for new RX data and copy to TTY buffer.
-- 
2.17.1

