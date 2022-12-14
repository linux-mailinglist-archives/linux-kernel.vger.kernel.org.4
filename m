Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DADE64C299
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiLNDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiLNDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:13:54 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A18186DF;
        Tue, 13 Dec 2022 19:13:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxZFQ0HPaN7vxKtotKzYbuH+LOoyfbUHXOjAAbswOVVXseXM6s1DFBAbSSDoXonkeUA/ECabgLqD9Y8ki6qmIuatmYsJtseFEMIajUQjZApZ/USPfOYREfZxRPRaLO0d05CbYl0KtDpRcMGouGNRUikZSACWPmR+SJxfuCN3SzSeYSM6jgZ2w8V5x39v3QlIl1glH5IF8nTUbW+6Z05u/orxgTTKMFRe7bVyY+xCDRAWVUsnaWoZhaBhZj0W65xBLzG3YaxlPOzPsTgPU+qGx4hBF72clB3nuEV5ESuB48MljKymUqRkTYyXc9TwrzRYoU9YkEayh3yAjzwiw4C3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZKJCUvnSsPAVC6hr+0PQOGpZigHZatHCrNPVTm/luI=;
 b=obLIWTPHX/ui2FKPQ9UIlsHUmQM1jeDDqONyUaQOfzEd9soHSFQ8WGShpvN3TLoGoZts+hEy8ErLJ1jsKXdKp/EECsv/9sG55geE/cMKbCLT+TpxYiSKUu5hYnTjtaO2yHgQ5+a8LWjytkQamu9axlBOIVSr31NhS3VeqtYg7v0XB8iFTd2I3nmFo+d+5kVdXWIVgXRgWiJ4kn/Kr7t6IYyYzKvb4kpPRitGgYg/LIaM6tm4DmYHdgkE6WCTsv8uCdMNwPX5S/8gf+2JIYknKD/VtYV8MEY3yj5Ihwx8rg19htFnFVpIoh0RA6C2SLJuIj1MKLPydsFXD0qRRIQpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZKJCUvnSsPAVC6hr+0PQOGpZigHZatHCrNPVTm/luI=;
 b=l3IHVSIVnJ3VACVJAy5Tt+x/LRPmoypg5f7apdefqn1iKohSuWtcJ2c6vfJHtUR+8SxWxNFZq45wr0Fm3AfDeW/FSFTQA4JGzZNdtmRycMHuslycoR31Zeygy8ceuLE3hQjRLxOAt0buf49ZsUIfGQS4oqQAXXaWt6rigma5VpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 14 Dec
 2022 03:13:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:13:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/3] tty: serial: fsl_lpuart: disable the CTS when send break signal
Date:   Wed, 14 Dec 2022 11:11:35 +0800
Message-Id: <20221214031137.28815-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214031137.28815-1-sherry.sun@nxp.com>
References: <20221214031137.28815-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: de5d7df3-40f1-4ecc-703f-08dadd813881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeAeepqo4rJvC+xKRH8JG7gIa8O5Jc6mnUef8QJgmZ/X3BhUxgOiKgD/r+ifdlKW2FQTphcP7NXLG1xo2JwEot5XqGSQkPCjtslXL7HgIVicTHHH3S1bgwh+TDQUc0g6fNDe3U5uuhyYYBRveKRgcTrqRkrmNISpacu0c/+Pk/l2sQlijkBPc0bVFS7pfZaS/iejUWVn8aDpEoQd4WdTYtdj5F3YztIfcsEFzy0vbQqpnQf3amLLS7p42goCIQpVyuOrE+1PUu7H/cZyoTUb8OZMvcGwcHN5ap8XRhPHi1D/Z56HgGNXBQ9lFhyL281MQF/aZ6+/eGt7jcWVZFa9DZ74DbiyYZ71L8wQBuHv459qbOZp/HnG/YzfMasQRHDCqcc+WOfi0D+U0PvO3tJdAP10ImOaUhw+L9rrbl27bnbxH4RqAh+Bv7Q3Q9IElC36UM1qhki8dfPMyF1R3h9vTF777L7n6vyidizVFTFg6ZebC0xBK0HRISo+tM0Akl7daIbZW8pfngt/fFVWdtYrSdt2q5/J5uDauv+wDHIiP5DxbB8kHXZ4vQpYuRuuJVEF6tpkTW/Ifqc4xp8cNxI/IPXHuQWvG84Z4yKsqnlU0Czwxyr/pOXF5QbhKe7SskiBZ+gJZDwZRlvCGdduLX/cBTtbPs7fVafW011zJL27C3yIXPrDNx2afvSz7e1+nmXdCYYwTcT6peUiKDlJ7E949Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36756003)(478600001)(52116002)(44832011)(6666004)(41300700001)(66946007)(2906002)(38100700002)(38350700002)(5660300002)(86362001)(6486002)(2616005)(66476007)(1076003)(6506007)(8676002)(316002)(66556008)(4326008)(6512007)(186003)(8936002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfkaSgxLTwUzhhit6Q25C7kigO3bMSvyDd63oRWlTt/aAq+Dw1CV70WgLD3c?=
 =?us-ascii?Q?POQHIvUHLXfqHWCBHks9/1iQCx7qHpSdpO0atCdDXB8PRZytwUNBngzExIU9?=
 =?us-ascii?Q?kFEgLtu+e7fC4iTjqDI1k2zNeqtjX/QGP35f9ogYYRzEkm99r8M6b/GwP3pN?=
 =?us-ascii?Q?0Y/OZgLcmS5RcrzzkvdzjLCXhiSUeHqVpoQTW2/eQ8Z31rJHLPg40laMH5hT?=
 =?us-ascii?Q?eBDUJaeIfBvw8/3ar4/+GE1dFTbPuH4zk0ewXqRMtU502HZTdrWq7cxUJlpX?=
 =?us-ascii?Q?G55oJttad9qkH3BfQth4hqnVGBM/nY0c5kJvzLffsHsWSp/y5qaNGwN1wOEb?=
 =?us-ascii?Q?YRq2g/r8OTcEArD2Z2qHoJC89megc7FIDSl0GPyIhI7AASvIKectD9JRIQkH?=
 =?us-ascii?Q?CTuoHP4+F/4CznVnLyB8d9CrDQhgi7eDJiUetXnmWCuydRK8A3Q5T0XOvSZH?=
 =?us-ascii?Q?JOxJOtWyuLlQ6ygx4PofMZAwpvYIvKMvwhcDOGXd6mcCEMLtxH3ioDjxfkma?=
 =?us-ascii?Q?PzBqhpexCYcxurahYii3yKLT4P2JDOLaN9kkJ/ncAlr7d5p2EkwBQGuV9cZr?=
 =?us-ascii?Q?oohJf+6cKQEtmZSd/dWXPbl7gIGXmhfml4Iu6caKgwsMSxlnoXz4Xh+IekX7?=
 =?us-ascii?Q?D7NvQa4o745OjZioU9ATnnO6tBnrwYmCzod9qU/UW7pHrHv0vw77O5Hi1DPo?=
 =?us-ascii?Q?pKKC/GQHnAOYJ+MyhDKFx0qJ3zmbF9joVsEUkTJUT0cBWyZqA8ewGFNa+t3a?=
 =?us-ascii?Q?XF7Ltw0myhngZjhQFMjb1vB3RMd3fJTIt8VZ1QN8/w7X/jCbT7F1ruVMpwPT?=
 =?us-ascii?Q?+qDtzgIOv7GKRzHg1CHArZucImq9e5qISLSerqboWBcmwOx516Ruj0mUYmGJ?=
 =?us-ascii?Q?5t+Ct6ui+u+YkHsTfVgWNRurUUBjbjsCT9SBnP78B+nEDYiaAz/gkFMLohAk?=
 =?us-ascii?Q?Y8CKGSK9EjNnTfVvhM6+IvOIahgdjsHSQHl5H0UEBig+udMrhA2KbPuPACoF?=
 =?us-ascii?Q?QMoWOPeAIBdqeJwYC2n8i40SKHZvEeCoC75I1qagr34sLvpcGkMxiA976FFd?=
 =?us-ascii?Q?aBcVcRs6G8ArszDxiacGEkNc6dJKE/LoA2NlhLCNZJGGOtGuStW2phyELL70?=
 =?us-ascii?Q?QHc0Qk2YNqBzCzeM3SDoSiI65NnipG79oAOUYlIP2g+aaXziR20vb8l8+XyP?=
 =?us-ascii?Q?dCnY7vuvaJORGHLai4f6IVcw3Rddh/u7m9uIf4s2SXQaZQoqbZ0PVVdlonIV?=
 =?us-ascii?Q?2Hy3Q+Y7BiHGrh7w+qKVL11/ZHxxHfjVFc9LM6I1pxWuj2tshAAQIOX11rdv?=
 =?us-ascii?Q?OWrhMU/9wb4x4n+cmBFDG//7dhh31sv6x7fLm3L6KLGha+R6xssk9bY9RmE0?=
 =?us-ascii?Q?93utHU0+c/FQD1VW2eAGvBbI3V0ACqEVFj6dfyGkspssL9SGXcLqBPEr+tD3?=
 =?us-ascii?Q?IXXPe0FZKARowl391iILRTJnbRDi5mHJie8Zb3XJrVQjqC6XB3AArRnIF8RX?=
 =?us-ascii?Q?zm8tbw0/ORBRR8xV4gGjb+Dc0Bzw47mrZb5wsGJS+p4NHGSVMC4gOcSFlWP0?=
 =?us-ascii?Q?APVwL5/dNNmgPosTO30xm/NAE9N2kZwPN/MEj0Fj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5d7df3-40f1-4ecc-703f-08dadd813881
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:13:49.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL+ESSSfn5secDYBfdqz2IRgMHiFlmHtrEZwlXxVntLFooyC1hRIgB+MXhllNQtPePJe9R4z1QSM0g1pzMgI1A==
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

LPUART IP has a bug that it treats the CTS as higher priority than the
break signal, which cause the break signal sending through UARTCTRL_SBK
may impacted by the CTS input if the HW flow control is enabled.

Add this workaround patch to fix the IP bug, we can disable CTS before
asserting SBK to avoid any interference from CTS, and re-enable it when
break off.

Such as for the bluetooth chip power save feature, host can let the BT
chip get into sleep state by sending a UART break signal, and wake it up
by turning off the UART break. If the BT chip enters the sleep mode
successfully, it will pull up the CTS line, if the BT chip is woken up,
it will pull down the CTS line. If without this workaround patch, the
UART TX pin cannot send the break signal successfully as it affected by
the BT CTS pin. After adding this patch, the BT power save feature can
work well.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bb12b328e224..f487d3d2effe 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1464,12 +1464,32 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp;
+	unsigned long temp, modem;
+	struct tty_struct *tty;
+	unsigned int cflag = 0;
+
+	tty = tty_port_tty_get(&port->state->port);
+	if (tty) {
+		cflag = tty->termios.c_cflag;
+		tty_kref_put(tty);
+	}
 
 	temp = lpuart32_read(port, UARTCTRL) & ~UARTCTRL_SBK;
+	modem = lpuart32_read(port, UARTMODIR);
 
-	if (break_state != 0)
+	if (break_state != 0) {
 		temp |= UARTCTRL_SBK;
+		/*
+		 * LPUART CTS has higher priority than SBK, need to disable CTS before
+		 * asserting SBK to avoid any interference if flow control is enabled.
+		 */
+		if (cflag & CRTSCTS && modem & UARTMODIR_TXCTSE)
+			lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+	} else {
+		/* Re-enable the CTS when break off. */
+		if (cflag & CRTSCTS && !(modem & UARTMODIR_TXCTSE))
+			lpuart32_write(port, modem | UARTMODIR_TXCTSE, UARTMODIR);
+	}
 
 	lpuart32_write(port, temp, UARTCTRL);
 }
-- 
2.17.1

