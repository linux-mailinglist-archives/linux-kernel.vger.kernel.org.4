Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2C6228EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKIKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiKIKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:15 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512B526540;
        Wed,  9 Nov 2022 02:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ388bEBMKSK0GqVCbdY2dQFdhLFGY/4uZKETx7RJ0yAcUzhZ8nN9iV2zAl/zyB2xuevbXDOAl2xsUUhNCXZNguf/PbDhgzpcQNG7Kz4odB6thQQv2wuccw52IxOihNjlgjZyq5GhkY7ZxKpL6NbvtphZanin8RMTAKTkMgyN2VEwQTCVk41cuMMiPWxTAqTxR7wmMWcrlCP7OBsWNUJL1naLwEjtW+mJS8zpaBH5PgwgVttOHCAXRTA+SrTaVjVh+BrZ1cIos0ZPYvTzeN0Vp/HuPHqgen7KUUjAsIK5cAGRUZ+uJKIjGv8112B0A99UhdwrefVfvQUqRBXdTHGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FEg+nizusv6kMfkTW84XxIFo0C3VygwiekzqdTNfks=;
 b=VpodK/V8MuUblwuTCyMIceIbhYljx5Yc03Y0PRPGr4txoh1AibCa4Fh6HpNwoRz4pa4MiGtxsBpCEllnTcDIh2LpyZJ2FhNkgablHA5gO5QQgqdp2vm0rcQGCGlLOzZQwx17+1FquFecNbkeS1Xi6FTdFS95LIS50+aVBwZCrmIkcxeFpnalX75JXNTznKHboTyY1kVZjEA3q4rDNpknbOkPZVy6sUiX8aAFN2afLGLxNVzFMp7KRCTWInqxIBz6H7QNxvIm09jhX0cqTcOvRzTvrQ3FWkYZUhFmLj+raqzClUaA0k5WHBuczVVdhMjiB4GnVZCDA6KcdP06Hg9JYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FEg+nizusv6kMfkTW84XxIFo0C3VygwiekzqdTNfks=;
 b=BXNL9TJFe9ooz84ev0qBIRVCdKpp24N1dUO3A5X5lkO6ohyaTxJAtfeNjg1dV5Z/eBJ1BXGmDYjeBKfc6BXsPaaAZFAS5eGm6aztMB2Qv1wg51VHbzJrEzHtDgvTj6M9ftE/nRQpHH2dKVWvMs14mc5Mnear61EX2f2vcVDmHtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8406.eurprd04.prod.outlook.com (2603:10a6:102:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 10:47:08 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 10:47:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: improve lpuart32 registers clearing when shutdown
Date:   Wed,  9 Nov 2022 18:45:15 +0800
Message-Id: <20221109104515.17266-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109104515.17266-1-sherry.sun@nxp.com>
References: <20221109104515.17266-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed131cf-7e55-4c40-e517-08dac23fbfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrtNDyt0DjLgx6E9gbvFDmXRMlWwsrYSEzZyLVHfPfrYPQjnuhcbHrBO7DC0rzN9sLeIpnzml1mGKrTnRE42LgWMeHl9SRqidNYox7aNfkMt0BEYK84LOxYUh8t3yaQmCMSMkn0uec3zaHhR/1pJmz34NmRNbxD5pE+MOD1yz8usQAG25uVDPFq1qdOr37fktdp7bZkdMFYmzGyTCyJakgAhIz4p5g4vGto72W5oEBdG1qZlKSNeY64iXs8NNG3vIDTdAjzsDAELAcNKKyvXEOwGMk8wN3cq8zuH76hlPJ8XsVUjmCReQPXZwMaOb+fZ/zJL1YQ2K7XObD+9WiVlkWpjb/bZlAT3ryDd2FUiBwQNX22FzosKSI1UdKJ6QvGSvo4fVz+AqIxFEvB/haGdcW18HLCRNsyA1VyoGhgBwqEjrgGzA3sYBXhgD0CK9VPtlpjN+CoSF58f/rwhH0Sa1/9i0O4XnoKgkPF5Jj5UL1QA4yBInKffZTo5RscngM5XQBuTx/oMgOlJuocnVMr7rVYTEkMKXwZM63PUFS/qF/H2yQCwtXQG+Fgu3EhfUY80/vaU34hOwyrxrGPyX5luF30XIhyiutFn/gryebwziWBnIyahYrv/H2yOZmphj9/hx57MpiJp7Zg5j1TOfU5z0iE2uXBi6MAsvcJjxhf+Ouj8kw5S2WnSfcmzW6+DMcGfgL4guXz/eNxLWabSwhOZA1tAYiZz3xNOLpEuhBMO6+N3DGU47UfWYihYToiSCX6hHAiDimPEFIfZcvufYPQQBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(86362001)(36756003)(38100700002)(1076003)(5660300002)(44832011)(2906002)(6506007)(52116002)(6512007)(83380400001)(38350700002)(2616005)(26005)(186003)(66476007)(66946007)(66556008)(316002)(8676002)(4326008)(478600001)(41300700001)(8936002)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5iJq7dLIgpCj2OuFoQ3CJltJO7Z3zE0cRlTinwguGqSjenU58EnB7nrR/2dM?=
 =?us-ascii?Q?wv/Zo8KXwa6n4ZAm9jb6pJ1ESCa9QWhMpxKikiInRYCcjrxW2g9n6S0YxiKN?=
 =?us-ascii?Q?ANUF08+65kDmqKrSEsHfcR/WAv2VyJ3ZVwInynQZZgxwkQYwC0HOmH598PGH?=
 =?us-ascii?Q?OqxNNFHjK3Cb1/59b8AuzOK4+T1VfFeY8+YJ+KRFP2G1YNuKciFwm8xQ5T6C?=
 =?us-ascii?Q?zeTtqClnTE4iSDpuZoKvzKlrT9C9zZQX9pLyzp5qSLbZ1402NMn81oCW19pt?=
 =?us-ascii?Q?UTtTyAwju3E7DmqdoxiSsiwTHFmI9TvanFJbWpnx/dAkPnHbGPP9NjunN6a4?=
 =?us-ascii?Q?nG2rgW4gTDn+a/m9TAORaeeyC3peVtnRm67Kkg/9RGmjD4QJVIYtVinaz1u9?=
 =?us-ascii?Q?bi13IUxZvvcmE4Y09jXyVylRurdHFP9zQnsLnKu5Fyaqyu/32SB/yJY7qTtn?=
 =?us-ascii?Q?hVgMRcmHnyMF8fM4igy6t2kBruIUqWml6wn8D1kFC047zWgMEMKvIfcjQiot?=
 =?us-ascii?Q?kYtoU8cqQK5/F7Z8XHtINHzekpAYKqx92fgzOnqwX0olDD3aecsgDI4pD5JA?=
 =?us-ascii?Q?KG9vuht5UcSWXILnG6Q8fdOXSpz+xPPOhfD/sYJeI35R6eAk5S6pQKa4zyDd?=
 =?us-ascii?Q?ga3VDrsVcUdWqgT+wty5S8MBOjOtKQ8FZK6PZfrgyoLY0XX4MVgBP10Ynwx/?=
 =?us-ascii?Q?dU1R2krgxUMqRUAZXjSC1QkMRChjpTfGibDybDbcqqu5MqMYPBSAEXjWg1mz?=
 =?us-ascii?Q?RTj7PtFR7bDPosoaenepgpaTzfbqFTP1921bWrmbd9vm8zM8nud1NMhcBp22?=
 =?us-ascii?Q?eLUjyS+/JOAOI7aTJqYDPFgkDi9i3BOWReB4cBEN4QCkuN0BeboLgk7cRlJH?=
 =?us-ascii?Q?SWn4gIyDbHeHaiQZpfP+h3zu9YvJRkg+vzoIasvPALIzmE02188ViDCbDzCE?=
 =?us-ascii?Q?mADLcFBwFPUrgqv7uyJNCaE6lfjhgZsYP7spQZJGiq4B3Ld6WoX5/1stQARQ?=
 =?us-ascii?Q?Ct/LXkjfPu48TPCYiabfyhDIsKRXCAa7QFyPBmaQqKj06dzJIqdwS58I1mzL?=
 =?us-ascii?Q?WiFnN2Sds6VoGq/s509CVWJflaPQOWHHGGDMD9V9t+4SQBFqBSrsZ3ELEB7V?=
 =?us-ascii?Q?fAJ89krQUWiH04T94etMucHwnvtzYMWGFVviHaWhySbIoPMmcp0ISZ0PU8sz?=
 =?us-ascii?Q?NSNBG/WxQyKuizQMKqL1RDvWFOlZ4kgEu3zhRthZwW/UVzOa3gSmGuhoQ70f?=
 =?us-ascii?Q?bDkIeVqw7lgx045YqVC3snrNvC5n5cHcqqdD03dLeaPxnznBPQQV7kxgKJdP?=
 =?us-ascii?Q?eymK3YUpt2FbjFU65PF182x5H9DU8MgQcWJjW31ZdhA2yFko4c8heBGXx+2z?=
 =?us-ascii?Q?qBz0Wx5tcCvBxvCc1YHekq+pY/p8vTzWWPGpS1A52JKzomIjs0roUWpV8fkn?=
 =?us-ascii?Q?fXLug7pr06YYcVN1KvfkVdiBZjvDpD8YuzyhBRMIAEZtPFxMZrfoJgBuVoTT?=
 =?us-ascii?Q?vHbE6zZQjIp3iE2wfnb41cRAZHUeRM3le8Rqeuc0WY03LKRJzLhUgWcOUffJ?=
 =?us-ascii?Q?h7ZQxQDTqGZeOK44BUcO6NPiBhrcGA4bjjI0SCjC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed131cf-7e55-4c40-e517-08dac23fbfe9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:47:08.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7RICl7Mmt9+1p/H4OUEAujuQjcO8zEQIxobtzsgwiVkMLpq8oXcKzE8B1bXrjevgZ4zq9PnjOwBbIXlM1tc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to clear the UARTSTAT and UARTMODIR registers when shutdown the
uart port, also clear the Rx/Tx DMA enable bits and loopback
configuration bit.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f5a0a14fa366..43d9d6a6e94a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1771,11 +1771,22 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	/* clear statue */
+	temp = lpuart32_read(&sport->port, UARTSTAT);
+	lpuart32_write(&sport->port, temp, UARTSTAT);
+
+	/* disable Rx/Tx DMA */
+	temp = lpuart32_read(port, UARTBAUD);
+	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
+	lpuart32_write(port, temp, UARTBAUD);
+
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
-			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
+			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
+			UARTCTRL_LOOPS);
 	lpuart32_write(port, temp, UARTCTRL);
+	lpuart32_write(port, 0, UARTMODIR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.17.1

