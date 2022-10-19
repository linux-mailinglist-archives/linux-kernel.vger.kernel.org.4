Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89D7604460
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiJSMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiJSMBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:01:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A313D45;
        Wed, 19 Oct 2022 04:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfM1ZDrxl7M7Ow+J08KrHgbiXwFC27AIvxt24ofVulrCZO0MJnv23reuzVMwhbKy0CKVMybf4+8NbbEeYU1U4iaW+zD7JiACpTyxXg+nk+7yattWnqF6h3jCSxDo+wH6QLIde4S56N/fN+E8+ZRapYDrJHrq4L+8dgQg7mtbw8rpYkeG7G99ZS83VK2t3Jhg97ap38eHmQlWTLil6CQbYYe0kOoCL9URXd5/UnKaSAl2L2XnxrolBNF2wMX3Un26k/jY5q76pzCw6RVdHoPJxNYHjJXi6I5Ldon0TqOClK543a04o7jGRRqSa9+nNssfnwuwP6m0e0QUz11oZB4NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0MHtjuLOB0x6YIhxA9jVBY4QB9MitIGbu0U4g813ZI=;
 b=NTJZWfCF6zKdzi9JZvcQXkyGBvxh87FH+gETsBNjvse+cOSWS113SzRp2wtbMLNavsBq/x312n/a9vuDT6wcj4T9xd9n2/0lTpgQiJS29AkvKsMrpFVBWqQjq7xMYEAkjYKV+666NkX2Y4IXFySzghDGfCRZSMHTOhOBq1pdf4CgnWHchrx45RUtLAQDLYKjixKYgCOCrX8QReeCYgMALA9IKyEpv86UjhCeJJHb9aNipLU9BNB9lekRJCS1/KTwJLhI8DliINZw5la8IGIEi93kRF+uo8CLPhVcSyfWbnnz8Ns6wUPWupIeB5yI76UvRnwo8gQ8U4XDDpYDjTQd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0MHtjuLOB0x6YIhxA9jVBY4QB9MitIGbu0U4g813ZI=;
 b=lUpFg15cQDvYg/dmkLvMb2qEWcppEpMcLhEPuqcPZoDnHcLZIgPmxRwgW7F4dTXOXx5tIbJ8dbeVIsS/2YF/AzcnuB3Ic3vQIYP+LJOkw6S/35nHyung4JNUlqeQyqF/eC2FVOYWcRDfwRodY3KqKnyUkJ2QEkZPhqj8dRo1rok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 11:09:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 11:09:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going transfer when global reset
Date:   Wed, 19 Oct 2022 19:07:20 +0800
Message-Id: <20221019110720.31722-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|VI1PR04MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: e9418579-eefc-4e12-2bff-08dab1c2712a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNwIfle0EQqlK0hsV6Tzr5lpRbfTBl2oOQQbx0Mj0Qbv12rPInxV/peQABmN0Yp1h9zcgkKWxTOH2110aQa8pvtcdaZivZ3Y4LazzvAChpaMEN2noOqDNAMkfkKt1AlctEgzMx4gtzMXN8WRh3rMpPvn2m4T0dNkl3hZW+Zf3Mz5ItqK8Mir/WL2Ay9nopZKPwEtgpMLd7ggKsYPs92kq623gdtTDNinRzuCfp/mC0qKg4GkEpavg+j+PNSvFIYUncbwe2+LMrUBV5mk4O2iGlAG2hXxAJB06H06RDwHYXG25IoIaSFvK6omdCdhY5uIe4MkGhWGxcu10+vDwh3zyU9CuArA40TqUeXR8rpCMPKiu/IlSpx2S/8S8F3MLhxG2IgLmAiKwqj2rbjp7rxDNNkbpNNxFN45QLQUDT5j1Uc0C/tPli8Ng+sGUTBLiiUr3eupv62pZluEjRqlKF2RCy1HSbhK30q9YR0j4rILQB4vpadH3MfVSUAkOfLJGxnB+GQH/olrG6MPvrJapJ+s9SkSWhU2CT6030iSE/rY/gyc8gs9r+VqRHOyWBL7uCVS3/RBtxFvlGMb9XaRR30fmdrnwKAfo6hdKBqVYQaaXAROwIDlZCH7S7r0LFf/+iR7gjLdI21v6nsqd3R6SX8PElOOItFR1g4ZfLgLtk4evRVHJv+/BMddTZFuZ0D/QsWAl0Y4aY9Nr03RXgPlRns6iWs+X8UuMpzshXZmewaGgyo03uPxZnk7I6YQYqCj6NkjpFGsWRkN3cqwWt7JgVTirg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(8936002)(38350700002)(38100700002)(83380400001)(44832011)(5660300002)(41300700001)(4326008)(316002)(478600001)(1076003)(36756003)(66476007)(66946007)(66556008)(6666004)(52116002)(6512007)(2616005)(8676002)(26005)(6486002)(6506007)(186003)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwiR7mdf/RTajtFdwskQ3xWXmbW4P/Nt9gsgjSp0nchk80R4xjJZsYNYwUDw?=
 =?us-ascii?Q?fwccKrutMCVKhE1fINVtpwXGNjCdtrl5xUwAmfkOGgNipMM2ONXptNI978Xz?=
 =?us-ascii?Q?N3ViqJdu8abb9IOaYayjrJdEgu8XHab+w1L2AMptZW0FbWRss917y36zUlRq?=
 =?us-ascii?Q?r9rSo8UDo8ya+16K25CwmEB5VnzKl4MsiEMDdD4zkTEiJXYq1xmVuwFGt5DB?=
 =?us-ascii?Q?7au2wvFXN+gkszMAzmIqxps8OJ+dOsgs1kmpo2URQF028FS3EHpw42NtuHZP?=
 =?us-ascii?Q?E1MeVepWNFkF2D2grBJ+akIFpYVWhk5tVh+Y/Py3o69Iylc5qz+QxZIxAzkf?=
 =?us-ascii?Q?dOJZ3FpooxWedjdOJReaNvMoD0+yaqTYA5aBEeAWlIEnsNRKxO9TTDATvvme?=
 =?us-ascii?Q?mcGvwLQeFFy31kBEORrOoOycL0mXx/6abK1UcXGC3HzfhAOIOnV8NJQKaSMn?=
 =?us-ascii?Q?PjCE8Js3RB87SuBeycGeVJoG7VKbJ52v/pm8WWRRXedhM40uJUlUG/bVFuc8?=
 =?us-ascii?Q?wuXVEhxfu/AsaQn0In3b3Vc+zbaH8EH0ZII15Cy4yvZUcYPm/4FKIc46pjuP?=
 =?us-ascii?Q?FQRXopQ/lLpqbGzx/9u3d8l7b4xTv9JnS14WpWyd9s6uNEf7nbJbyIES4tRj?=
 =?us-ascii?Q?02SBoM9/KeYHqg1GrGY9IZpRkocJ0WLGW5uPXpcHRrMUxseou3oArnyqHSMc?=
 =?us-ascii?Q?M1eHPolmwd7Q1XV7r1q/L9MCr69rjTHnbXAA/wD73xCkHkepVbESp1CFJ5A/?=
 =?us-ascii?Q?rfIK5HciMbD9H8Z7QODZ3zv8qwbOzVTIef9yV/O8I+le0WL/BGi/lqPZByqP?=
 =?us-ascii?Q?3IUnu0ozNQtssaZ+bIPpIIiGgruDiEFKZrQh+mNaEfRXafYRUUFzfvEOZYu3?=
 =?us-ascii?Q?74dOPBOMx1hht/KoPitxzxrYSsY7YoZkLDnVeQ+FPICP4w//pqpBS7mdxTUW?=
 =?us-ascii?Q?AJaprc6MaxdweksT6L3YlO9nGDVaTUjGX2rGuTrN4TGZgdJvHb2Yh2BM/wmq?=
 =?us-ascii?Q?CK95bfLHUkMAd4SQYVyiuzQe2eI2xWBKnBA0z0CC30Rsl0QAPlqcu5CkbwFp?=
 =?us-ascii?Q?ZxBmNMXgoiRXjQjVfUMqPsl8Pk0UOAmF2LWZU5qGjPeMxA1qWRBtKQBbiMK8?=
 =?us-ascii?Q?rM+fC7R0Eh8pIO5FX45eQNR/UpElg1JFVJo0iC7m/BEEOyTSf47TGkSTTA2S?=
 =?us-ascii?Q?dcS5G7a6ry+ImhjXOrt6xx0rX5Rvb/1DTN9vf7ZFh4FfXSH1oNzP8tXMcfG5?=
 =?us-ascii?Q?oH3qfusbyDf8mGmlGCwKHrv+arEHBVXgIMPchDYe1JczcpDlEWmS+kj6MeZz?=
 =?us-ascii?Q?IsOeeCQaz8CVaavQSp6AvcDwTOaOchrWdtj3Z6jIaK8AGnJZxyLUxEEmzMuG?=
 =?us-ascii?Q?lE9/0EXk3XbiJLY1TRhH1YWnaiMlQiQCXaOHMGUKfI0eYUFDMGyQQvzA0+Ih?=
 =?us-ascii?Q?iXm0jZjPpab/DANeMaekOLXngBQW5nnGxAy23DOObM+wGPDqeKVK+x90nIK4?=
 =?us-ascii?Q?40gSyZE54NVRJpJ+WXcbEOYO9MDRKbMgLiLGbz3c88scHUO5iO5u5UpHkoX2?=
 =?us-ascii?Q?91FloDfUPgqIXOnuxCHb09XrC9E/DUrayCVlEMXT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9418579-eefc-4e12-2bff-08dab1c2712a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 11:09:50.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SZ5hMFjQYoGsEAVOWKxRA0a8GlLaE8vc02Pmt7YoFeFndTDJ8udd4qzNojubjUVESxoTvHhMtppOSeT2BhMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart_global_reset() shouldn't break the on-going transmit engin, need
to recover the on-going data transfer after reset.

This can help earlycon here, since commit 60f361722ad2 ("serial:
fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
before uart_add_one_port(), earlycon is writing during global reset,
as global reset will disable the TX and clear the baud rate register,
which caused the earlycon cannot work any more after reset, needs to
restore the baud rate and re-enable the transmitter to recover the
earlycon write.

Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. The while loop may never exit as the stat and sfifo are not re-read inside
the loop, fix that.
---
 drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..9a0781395b1f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -408,11 +408,9 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
+	unsigned long tx_enable, bd;
 	int ret;
 
-	if (uart_console(port))
-		return 0;
-
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
 		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
@@ -420,11 +418,29 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 	}
 
 	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
+		/*
+		 * If the transmitter is used by earlycon, wait transmit engin complete
+		 * and then reset
+		 */
+		tx_enable = lpuart32_read(port, UARTCTRL) & UARTCTRL_TE;
+		if (tx_enable) {
+			bd = lpuart32_read(&sport->port, UARTBAUD);
+			while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TC &&
+				 lpuart32_read(port, UARTFIFO) & UARTFIFO_TXEMPT))
+				cpu_relax();
+		}
+
 		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
 		writel(UART_GLOBAL_RST, global_addr);
 		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
 		writel(0, global_addr);
 		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+
+		/* Recover the transmitter for earlycon */
+		if (tx_enable) {
+			lpuart32_write(port, bd, UARTBAUD);
+			lpuart32_write(port, UARTCTRL_TE, UARTCTRL);
+		}
 	}
 
 	clk_disable_unprepare(sport->ipg_clk);
-- 
2.17.1

