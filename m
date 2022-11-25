Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF73638775
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKYKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKYKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:23:57 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F0429A3;
        Fri, 25 Nov 2022 02:23:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0/HJoKThkGa98/EdClVrur5a2DhGYeQNMeyrcUx5S9tLK+wPrIDOdy3pKPu94XazhwVLFkVbNeuyVPm+PZie8KOd3j/o60xg7nvWhE9Kp8JiBS4crHvLT2wJcPt4qxrz77F2J21yppeOdi+NcSh8XEBvvVFHhUneS3AeP6VdSNzqz263nRXhBo30ChEUur3myzLO+pseXJf3TcT7rJN8YFEgt5k2DOiarZ6GdFqlrrqVwv1N4cTk8emHLN6Fy/LXJMhn9+GB1b2fIN9AikzCQfMLN5P+27nJ42ryi0KpCnldSSo57bJTgFWxGC1ZBHEs+6T6lMw4VWJcZ35jgKV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnIMUkbp0my6Hu28wLzDBKuIilcpbwCPevUq3Vbw9mc=;
 b=oR7wigRH01glU/RTOqhB8losuZi/y4hP83q0pES25YuOYBBK25uQBEcjgS8ZuXqs5ubXkWr1GiZEgtAIKLC3xfxnPfcRDehz78FIAQIHZ1mwp5BThQmbaxZK3t/zKrdw0oxn38wg64e4LdYazyQVPr/trcZfyMVa3+gDzlpjZ4wbTwlgs/+pncTO9uSFvVWPvdfpg161aXiEEQ+jp6vzwZIGs6hZMUHJNoyxznGooYoLBb8aiJiNGRlfk12XF3HFxafpigmhEobgIOmQLqbgs2j02+39tl221NJM2WgslITTMk+LabEFt5MuJFXaKTc2teAjqoqnnIESN/rdv9xGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnIMUkbp0my6Hu28wLzDBKuIilcpbwCPevUq3Vbw9mc=;
 b=fW1HJ8P4TJBW78VI5DzEoiN6V14WgLI7u9rqu6IdvRTnHKGKLfY0yOEDCfPtxVGxNVdF7P9sSOEUm3OT/XlDZVMYT//z3XpZHFX4r2uJ8dgPQo7JGEpJtJONJ7w3VMkKno/fcG4kPwHDLtu+SMzrPaZc/XNmALV86hFXVPryubY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 10:23:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 10:23:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, atsushi.nemoto@sord.co.jp,
        tomonori.sakita@sord.co.jp
Subject: [PATCH V3 3/3] tty: serial: fsl_lpuart: clear LPUART Status Register in lpuart32_shutdown()
Date:   Fri, 25 Nov 2022 18:19:53 +0800
Message-Id: <20221125101953.18753-4-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b046075-1771-444b-4234-08dacecf25b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqMfR3NIMdt6DryqCOeiycjV+/i9GDBs+gOjHLBPu6WzVbbOdOSf9UzOAE96vUedbipr6WcZ8nXPDq/9xon3HmsRerr8viuTWhyfYQyiGfII5udjHOfcTmGROha8r55aYlYsl90SatxpJQeJfMtkPGO7L6kfTNv4kiZCuxUSLdtxpcBR4azuc5sftfm+bBLAa/Jfjz3ysDw4j9qaBw4wBdvkVNNKcN61Lpeui/7FCe/5saYfB27NwU6xMZXAFWWDTrnq3RvvM5ZuUKoIeATiVXctRcPHQFTpgQegbw9Zb9SCrZtUZ91fiTdmiAfu9J/M6V2uWxgR4L4Rmy+iN9D8x7FE9cFk57pKVhiEaXT/Sik8RK66LP4x+SZv1Hg7EPLEgMFzJ9yIAGcieKJ1Pr5t0pgnWWxusIMmvUGOWg0jaMfTcwixwQiFFcRSS6mmpKsG+8YhQK+YolagsJqfcileSIlYbq9w5loJbvKu+wJdmwCyzzSFfOYONwLgXayPjpTa7t4UEd8Y7pS7afMSAUj1LglN7jlG/Z/536POYOHe7Q6Lf/9lWO9/zqMEn0CtBp3nJrbG8kQtoWi0u2TiNZwAQ9KPshzDP0P+w3sHbW3mvTSI2KmmzFWjsCKQqILPQmKpNgh4ItBGykK96JCS5ALDSNnjCuozr2a12oEYmPqtq4MTcfemoy7b/fKh+lJxn80IiuT4s/hhlSggvql3ak3X/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(66556008)(36756003)(6506007)(316002)(52116002)(6512007)(66946007)(66476007)(26005)(83380400001)(2906002)(38100700002)(38350700002)(4326008)(186003)(86362001)(41300700001)(1076003)(8676002)(44832011)(2616005)(8936002)(5660300002)(6486002)(4744005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMYYkWa35Hc1lGic2HQiH3qO9XNot9/OaDvmjsL8Oopn1NIqkFX+n5/DSBfu?=
 =?us-ascii?Q?ojeroxmFl9YcNDnjlDAfvEei0CJ6YUGMhYB3K+GDhiXSa80odqFF2ukIUuqB?=
 =?us-ascii?Q?Hz8N2r7clGTtyJu0Opr7IpDVmroO2VID0ojfVIIp84xmtLpoC90cX2oN3bO3?=
 =?us-ascii?Q?O0QcbWuzTPX7WU0Au/bTaRtgOIIbWr1T8Az9hgqWYbGCv8d9mLiVc3DiZ5w5?=
 =?us-ascii?Q?ww5bYifHcOnVLd9qzQpsV5FyKMklBsZIlxDuk4RyfxzGroHfxA3VZKidJYMH?=
 =?us-ascii?Q?40+loUJz2kR26VhMvRzR1VBMWiL2KYF7SVT+9IZffmUkqJMJGIw+GpJa7WCB?=
 =?us-ascii?Q?uYG++Jh5xyCLALMPiBpoYogwbuYLaB0eHaulW7VgaVRChE66S+aLjouLu5BK?=
 =?us-ascii?Q?D8CgbXEQhDeCoG3VDh+oAdwiMioa8zvP8LJstDbVsbGZUn6wnQ6vdNFzmGy4?=
 =?us-ascii?Q?u0Nh6jy8R+gRE5XoCSzFNIH3Y5H+d0eA8vp/bk/b++Nmz7AANl6aGyaPt4bA?=
 =?us-ascii?Q?0rH1cnH8rkSdwXn73n3xZwpwRXBOd/2MWPzox/NjVnIb4UvlkOcMcNmmaSw7?=
 =?us-ascii?Q?tkS45f3AMqZAHyKO3XN6ClHYocISabo1qkWkwMLpKIcWTpkAG/jB9NrrQc/9?=
 =?us-ascii?Q?td6XvXr7QxGqWVAUxYW/iSjYeZf6BFSeWYoNgJX9k39HsCGlTrTtuFVkvdHV?=
 =?us-ascii?Q?+lEipbYKwpv37OzUzqylOW073eodZdccph9Xl64OX8m4VGB6Iq8H5tmdCMSu?=
 =?us-ascii?Q?edfVkw64DA2iPr79z25TZBxV7T7OBEVtGL7rsX7UQ5iQOvmDt+ux9+2Ir3DP?=
 =?us-ascii?Q?RnmUctvzcbog6fWcCYtVBOtO50Y2Ep2Z6vPoH3V5PcpZ9YKyZerIdaHyFD1n?=
 =?us-ascii?Q?QniTddcHHgCyLriodyq+JhwgnIqCsK3k7N16R6TkEqIgK53/h3eAQr+VAIwW?=
 =?us-ascii?Q?EQzfmBGxM/p9m4yww4pvu4qW6YMcvm7OEkgCKosjjPh4IakXy0mevJDRsNVx?=
 =?us-ascii?Q?0YPcNLn6EehxRsNPg55spKEbDQb1locf4ME1kbBJsD4WegVZSnURReYoECyJ?=
 =?us-ascii?Q?j6BUp/BNeh2I04eTUMz9vUaTl7QLMHzUkme7YBzd8ehYUg7z5Sp7Vjqso9Di?=
 =?us-ascii?Q?fMrO+jFTwIrQPXC3lXZZ/OWrBp3ORZSBK9gGj+B0x9uO4SFkDC4ucuiy0DP6?=
 =?us-ascii?Q?7GL0fhYBxED9UkUwvCW5elTcBy41545VuT+DqDbdc2fnhhOmXQg3A+gQJ7cA?=
 =?us-ascii?Q?CA3rWRsVptWnz7x/oPQU1EBMsuoL9xlRdsl4j4PRndzBYVeYNw/n8SLcCotl?=
 =?us-ascii?Q?NV9vc0elXArq7kka8XB7HBiogZX8Z/Gfgotvaqw8L34YzxqroceDfg8gAoVn?=
 =?us-ascii?Q?W3RMoa0wmE3xufpHn6ndr1fiZoBPSU1hjARpSij7bXOWioRlziuQzmqZCj5K?=
 =?us-ascii?Q?HhgBmF9ZmnejG6dUgzG62VxihaMM0pYVkLID5FD2qVZrkKILnIL2hyiQrkLt?=
 =?us-ascii?Q?DlfqadlpVVv8FR5ml0PaA8E5gRb2sbBuHtzp0WODQQsrI4FI0msLrORnlJVl?=
 =?us-ascii?Q?beBWHHhiOsmxfoNbbce7k/CK3ydKOQz2SiERVoNT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b046075-1771-444b-4234-08dacecf25b0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 10:23:51.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLvqDS/nQwLtUk7+yxQnkeOYuordR8FK3dIsa/z1w5yOnjX992e0l8fM2rFtTraPohGGRfrkB03DtOKwlVeKgA==
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

The LPUART Status Register needs to be cleared when closing the uart
port to get a clean environment when reopening the uart.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 88697ddcd8c4..8918e08bb19e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1799,6 +1799,10 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	/* clear status */
+	temp = lpuart32_read(&sport->port, UARTSTAT);
+	lpuart32_write(&sport->port, temp, UARTSTAT);
+
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
 	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
-- 
2.17.1

