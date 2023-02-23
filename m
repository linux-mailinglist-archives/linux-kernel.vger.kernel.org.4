Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889C16A0524
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjBWJmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjBWJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:42:20 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EF43925;
        Thu, 23 Feb 2023 01:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Dnz84Gnzj7D7t4swqL298hutsOXHC2ltex2z/TOh/JOn6aX99OapBpLHuxvx1w0ZQqOcpX6r+lAv/BfZT+ABnkStnt4HoNczbBuY8I8P6rdR8N1wr7+ydzOWts7XDJT5+hwLF/5FMbgHSCq2FQvRNH/CZ75Pz7UzluWu3xBlK8GAlHnjUHAKN806d2WZwsxrjlfAhAZjex4CTzWp9SryAkdnXDhepV8gX6hFmTUHWRIf+PrH2aLGpVil7XYeHS4X8jkrbQmiEvQJvy/FHg8f9FWcWpDyOQGH6znvKn/Ynl6tKKS5qs/2GpD8J/59tAZNWhymX538snUUdIoGaEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPt/Pz5/4hJ+xBG1HaScEJ0pc/8Wg9pdpikmyYbPvL8=;
 b=m48P+5F9ChPlFmRt6hp5n+xBUHOCxrfltnlTbLS1lv+hw0lfqKJjeLe/yzEyQxsV9wnZge4tF+b8Yjh/lONZ0VrE0yDRKayUanHZClQSEhzZAmjsGFoVHZormyxNreC1MqHQvsacEOBmHKLhUxGoGZ/WpGGzaWFDFR3laH7NwAt4ck4l8UPyBmrLYADy2I1i3R+zmsx5zDeE+RzEWyiJwd6vuBU4sCjnzUpT9oGGtGHRBJd+Js94X5w4UVL/4+YQISWkseeRp20FBuJXnXrkm+M89CNXgFPoSehKLwqKWc3n5b3P1wO8wUUU+aqgVEfba0ZGWq7XPORgW8k3dKAqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPt/Pz5/4hJ+xBG1HaScEJ0pc/8Wg9pdpikmyYbPvL8=;
 b=cLg0P54U6b/8oujdTrpGrxcNBtdynTxO9ht2+fHx8L9APh0QMCQYj0n0oMioyiXtHLrUSvX/tfcoMjU4hCIpOFw39v4tSxP+scSqLGJfWO49oXZjzed/AqIe+ASEOYdf8Skj8IFP+JALANCRuc24ZMvVcgfx4TqxnUyKvOjmzhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 09:42:16 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 09:42:16 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: skip waiting for transmission complete when UARTCTRL_SBK is asserted
Date:   Thu, 23 Feb 2023 17:39:41 +0800
Message-Id: <20230223093941.31790-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: a8935851-87c8-4c50-ab99-08db15823f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApF792noZiVFjLInTk4hKXxnw/ypyeT/aRqzPLIQFmIU54JJbvjmD1iGr7MLoJ/iHJmsWqi8fTMAR/jL8LWAdJbKZqPxuNuMP3JSmFJKRAFFy/PwUX4MLlwnSckMnHwGzedvKkD0RcHQEyk4CM403adCFPUN/hEMflIfmEZY39JVvDUp817LY6BITcdbVgPZZMH8lGdL0HU9JIV8bSzOERS1mS5CpzzgKPr1Q3pVgJKDLC5zMAsUAfVjnSuO5EnWeVzSsyIYcaL46cFxlaKU+RkffVKYRMi1jVJ3WXWjxpD6zSYOim0iYUafepgt8gFTxvD0y8Pl5StFucaywkPnS2YbiHt7HC4q/hKQ/2l9Mk4u+QWorrhR/4US6qc8K+ZLQrczseZ2xGNZZ19z+RjJfQkmTb4FZxQK6TT85JdP2lWmw3lUd17AYJGzWbpz2QB9yPrr/9Rgof9jRGeKiw58v8WfO4uSkpVzfn/EoNUUlsCBt7EVng5LknsrT1mFpvTi8k7ZdRuKnHXTZUp8HyYSRQorQKRmgLGNeCzL8/hfWuYm1UtTEF2ale0YbBQzfv74VdBKobMeZYDono3dveSRHoDYsZ82gT3r24/NPDg0xhQr/T0UgFKsvg5XesdN/vOlVxeD3dYEdtIMDqqi1Y3bM9YG42TqpbPe2SUPkHUiwNPFelIK1LxFXQRAUjWPottzvfFZy89QGqgOAMuRYfK3Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(36756003)(52116002)(41300700001)(6506007)(8676002)(6512007)(66476007)(66556008)(4326008)(186003)(8936002)(1076003)(86362001)(2616005)(44832011)(5660300002)(83380400001)(6486002)(6666004)(478600001)(316002)(26005)(66946007)(38100700002)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rEcjjXeIL/y/6iY80DvCZK/kQym5v9HGrkWeIyxQGcry1b4yommf8zc2swe?=
 =?us-ascii?Q?Mc+VEM1qkjeJWUkmXxOTm9rewrqTe9dXTte1Tg26CGxlyQ63qDpjEcFoq+HZ?=
 =?us-ascii?Q?VQ5q7whMN+Ct7FC9Ou9w5p5xQ+iYsVfE3TDuxclOxObrNhD49TfBynZj7liD?=
 =?us-ascii?Q?Ci5ODGFTO6K9+y8s32BwHblGqzFg8dqRlncNeaENlDz3fl8NyDkh23Otzpvr?=
 =?us-ascii?Q?DORU7BMAE1QepyBRihOlsILHFhtekEPVE7FZGhVroMEXSxvoS0q8kOPInLU/?=
 =?us-ascii?Q?Zya79HWO3yWpN6YMjo++z9G5IODDsnM0dVYGL0MwJc62uAovnqQZ1uO1vdqY?=
 =?us-ascii?Q?8I2108lUovPnGxmKuQodtSbkQOlQKQudX+83a0/l9AFJjBu0ATrgEwnYKLoT?=
 =?us-ascii?Q?N8BvFMjOxKFRkBFTP9EMqoWIurpSQr5bg0eHs55Fw3lMnm5BwGClihUQDvll?=
 =?us-ascii?Q?OhwUslz1Hne9Bn8FY4P29q0r3VQZlu4qHU9nFvySK3IQocbbBF8JTP4/SJUl?=
 =?us-ascii?Q?dweVhDYIQ2pMzfzg9eF6om0lhzNC7H30iXvOEu/LGGwiLAj6wfq9lakk5aQ/?=
 =?us-ascii?Q?MSwl+D3G47+Kha9ajfL4CVnbal/afMm2150Vv/muJAZA76QONPMXAyHmFy6a?=
 =?us-ascii?Q?rNy0mrffnbsRTIgGYnnCsiE1M8TyKVNGdUXyPd8DGoUHjNjjtd3IJH4PKdR/?=
 =?us-ascii?Q?AwUDF81+G4XnNi/Z0BUmfZVa/galR/9zhG3pWlVzaU6tbagOpjEcrkGH/Yel?=
 =?us-ascii?Q?OUGqtkh0i64qmS/wYrWUWoSwymuakBTmQO1E+RVe5Z/fh8sdnmJlstY7uwgc?=
 =?us-ascii?Q?0m6iBYu0Ux8AjkIS8kLeGLa9aFLHEBJtMsfF+Zw0PPaXuDZAAPAQDqFjP6TG?=
 =?us-ascii?Q?IjncRU7lOCIPDBDtEZ7cgrp9npeuNCb9MoIWEb7KSLAxeOSnq4ojgNZt74vq?=
 =?us-ascii?Q?yew2dBuJxw6K2MmTuPWtZyQCSq5SrqXAUT6xKq+qv+aTgYyLA3VIvySiDwPv?=
 =?us-ascii?Q?C1kWOaWYRvEXn79fjxPCl1Z91jX5QJ7nM1aZj736Z7m8g0x4DfCfH1IgA0vv?=
 =?us-ascii?Q?BcNApkD/1YGLhOzAZRKTXL0e2SpWtoc3IUxM2JSt2LAAiKDm3+zCT379LyN1?=
 =?us-ascii?Q?q0HejiVa3hBMNMdV8GqpRebRyP3hWZSvT6mKCNlVEwrsXcrqw982AsiMoQOh?=
 =?us-ascii?Q?gMMd9j7EehzygdiY9wu9Y/98uSwUHZO7bzUQeiowte+EwQea8JB/O8Dd93zj?=
 =?us-ascii?Q?M03YBUjdHZNeqJ0KarDmh1fIdY0Av09NRIQvsdqnWdDFqMLvgl+O/bGrBeyq?=
 =?us-ascii?Q?k8GQRx4T7YQd7nDCV0OR6gNmna/x67tVY+ruX5wjOqinWs5wDhl6a0jQODe9?=
 =?us-ascii?Q?zUMNb0ZvWUzG8V97Bp7cGU6bwenY4O9UFJ+08vN4rdCuQSAE+4caVuZCzXeY?=
 =?us-ascii?Q?6fWZOAW/7KqI0yV4YRXJqtxsd+QLocfS+ng83N8kVZii3KDg0YdgHgkVSLYg?=
 =?us-ascii?Q?lPV8+fyuPXApMb2ovyJotbRwDM+xZhMkg49J95CGL1QC3rIBNVuqw49lSAxN?=
 =?us-ascii?Q?21YXz0k7xYb2rZ3ajDTYVGwV2yDWaFLoqALJXbEQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8935851-87c8-4c50-ab99-08db15823f61
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 09:42:15.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ015d4oMKr5Vmivy93QT4puS+/dLyL+VG4SyS9jJWuei+efBIOqJ84YQ2ns5dxnBqgv1QY453BXf9op8apM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to LPUART RM, Transmission Complete Flag becomes 0 if queuing
a break character by writing 1 to CTRL[SBK], so here need to skip
waiting for transmission complete when UARTCTRL_SBK is asserted,
otherwise the kernel may stuck here.
And actually set_termios() adds transmission completion waiting to avoid
data loss or data breakage when changing the baud rate, but we don't
need to worry about this when queuing break characters.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e945f41b93d4..f9e164abf920 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2240,9 +2240,15 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	/* wait transmit engin complete */
-	lpuart32_write(&sport->port, 0, UARTMODIR);
-	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+	/*
+	 * LPUART Transmission Complete Flag may never be set while queuing a break
+	 * character, so skip waiting for transmission complete when UARTCTRL_SBK is
+	 * asserted.
+	 */
+	if (!(old_ctrl & UARTCTRL_SBK)) {
+		lpuart32_write(&sport->port, 0, UARTMODIR);
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+	}
 
 	/* disable transmit and receive */
 	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
-- 
2.17.1

