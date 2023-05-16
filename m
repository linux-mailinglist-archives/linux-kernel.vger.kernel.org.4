Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF98E704A47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjEPKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjEPKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:16:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790214494;
        Tue, 16 May 2023 03:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enHUBaMQXIRcZcsvfbGDsY0e+zgKEor9Tydu6DWbSH5J3nhBju5b7k+yb/9VL7S3eXYsyZgxWunqoC8QZczO2SCDYQfBgaOEUmVByUyLX5y21uSxv1Yq9msSSM8p9GIO9NIbzpYe6hbiHFn3FvMNa7n6q5LNVDlpQQfPvkI1Pv/oFLtX/0KXrfpnZRB2TITlsyrIvFnJVgu6S0Pv4//Al5c6zsmxDerDmbJqZRT8I3afv0GBAUQNlhmxgrauA3vOlom1Lio2UJJBgOGTLyiW4ZW6s+N+kQ2k3NzxFrEbpKD93lfXckNEp3/qNDXtNhY54K3F0kWYVmID+Pja54UWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbvlaIEOok+xfw+k2ssg2oof0mhplIQcJMInjqSHJPc=;
 b=JcbruSaPMGfMOwboGPluUC7ggTdxbiVV/UnYds8xZaIlyvgaZeFbVMNScpqUM55CgIyKSFNmTKAdIJP9MnSpOynnGQrtSLoCj+T3GH6BK6e+nL1wsXLjPGm+Xe2dbYUAHq9k7gh8fK/CjprNXG4WUryP2QLto9VB0Pw6OpZyVjeWA+X3QjqfJ0Srpgc0Sc9rU4nEd9pY0YPhx9YPS3W+Z2QpLHOXhq+l1J/cKJ93uDdY4U5qVvGKLzC/5lILPUOCH+S+AfDymSqsC4Pz+NURHksHusft11t3nklgBOsxoQ+TemyIv6eR1BpdB+3NHvGsLex6uyzrOTsBO3O2IvW1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbvlaIEOok+xfw+k2ssg2oof0mhplIQcJMInjqSHJPc=;
 b=eImw0oouDuHozSdH1jy7aVNpyWhx325II3/3X4PC3J7BCq0M3Ba2RXVmuor9hw+v7hGLHthHeya7u73MwEAVbnozGEm6FdzZx0JQq3Xth5nYL/O6pHd9ZLkZIAjbrx3cgLp8XdroT9xVg5wrRqfmrWOmRBAuYU0p+s4XQe1wTic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:16:05 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%7]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 10:16:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: make sure to turn off break before enabling CTS
Date:   Tue, 16 May 2023 18:11:38 +0800
Message-Id: <20230516101138.24179-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 2503af29-fd7d-4868-72e3-08db55f68e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kmwt6pyjqxnyRqdvHs5JpIqHart/SsZ1VqVtgcjxoRUQFePOVpCCPHXtIk6iR+hLmgL6VDgqt9u6VhTVL8C8TIjFoM7FRt8cXusNHhf6gkNrpZDJuKIJMZBT2RV1kQaCAkVaPIp6Q1LMxcKB7yyLbfx1wpKhKwbl1Ply9QnVIdZBSRjDaB4qKINZkGv0CUGv7qdR/20uNpnhUmNBqpwdNbdrqm/z0LCFsnIWZXX/fsCBJOA0LlU3Va8YwuBKcS5pgkav72d84w+i0P1BsTOY7JozSbmwGZVOCK050DOBLYEENPsizVT6+9o4ZeM9PHuPwfnMFWVVEy1bh3QAjqfKpzj4ybQfJNr8RfLVYbjobXfq8fWEwAopffrD+aEYZc+qb614t+ni9WeaSrp7IcHQsvjWrXp5znVsTpwjlv6aFbZNtf1rKL4b/p+ujQyockYgpt9zqVltCfYf0tPCJSL2/CCImHZtX/HeX+Ie8KE2wVFBXM/SlIPpmZzaqXTfChuiiookPyl7COUAQBg8qunfl3k8CnDn4UJXDw3G+Gu7Vr3YKvcw7lXRqxg3R7rqdIDBC1eyl17hwJMAXOkDW+U/opmvHNX7jhdhODpVxC7ZID9xPam2Gn1ImSqWQUijuDD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(2906002)(41300700001)(478600001)(5660300002)(4326008)(66946007)(66556008)(66476007)(8676002)(8936002)(44832011)(316002)(6486002)(6666004)(6512007)(26005)(6506007)(1076003)(52116002)(186003)(2616005)(36756003)(38350700002)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hW/GL4MAoqfFhSASW5YaKoylVN5cDFuBUMc699ExgLDZiU36vw/DG6qoPii?=
 =?us-ascii?Q?brfmti4zRdXnJ46hipyVRjvNay/xWZNmn5y90h1QlBUCVxa1CwnqkkJEx2U4?=
 =?us-ascii?Q?MCYmDjCmuAUh4OnFc1wuKxbmzkQNXvHNK09nIif+kK1WKiKsazI9c50wR7fF?=
 =?us-ascii?Q?waC0PCuHf1SxHuV9SCz+7gSMC4V5FGYK87Bil1W0ULN7uIJPi/ffI9n5syLr?=
 =?us-ascii?Q?5WC9dp3BjphRAZDVZmRLq2zR8x0wM/ICEw2pLHcl7lkG82614KaoQD0sKRGq?=
 =?us-ascii?Q?r9MfXDBWC5kxiWEA3FWEB0G9bX0TcMwSrWWIMQTCSGwrSKG4Lhlyx6V4xoI5?=
 =?us-ascii?Q?zw4dG5ury+DUPjFk1QbCToosPRbVa/dAJy+7SIxTM9FSbCThxrOxrWETSU6D?=
 =?us-ascii?Q?NjWm1TYPHdV3Ai0/TjEF2L5QVyIkvM75o6a3dighnZgqQpD8kvYws92GuRPn?=
 =?us-ascii?Q?dR7z1FnYxUfrXgg868zjI9bzvRU/rFhD0JkuMFOf1Hev3VcjBrPV8fFWf9f0?=
 =?us-ascii?Q?QB/7wTEP153fRzr0ANoFGJdDjUgUttJLd+d+0Yf+A4+Ue4XojPNp7LSnMswY?=
 =?us-ascii?Q?is+h76bHKhbudJ7j/LwqfvR1LvHcXl5DenxnmMaNiFnFwpK0tFYLrItwwyAn?=
 =?us-ascii?Q?DkU5ST3fnTd1bQbSZKEFjJiSyr3lEYmCQg+Uu1gfeujmKYvrJB30N2cXiYFE?=
 =?us-ascii?Q?6TV1/qi23bvHYCAjQL7OipbOdG1+zTzZVqXaOVD5MQ9uDqr35P+hrPw/rjbo?=
 =?us-ascii?Q?BmtK0b3APo4+pJtwe9rHp8Si8/m2DURfF1Vw/XgVzBy80rAtP3M7QZtnHxoC?=
 =?us-ascii?Q?1eMPIFk4u9bI5mvho981dDXfgPubr4pfe/iOKNyhDH2+JUTBBD56jOi7+Di4?=
 =?us-ascii?Q?ArO9N1FVCqoQjfJaz2Fhw9p6IeG/nM2yxnpqzWtCxco1jWfRtFjF/UZFntp+?=
 =?us-ascii?Q?dCCPe0k94rhsiCm/nrlO3AZ1FZfq9RQY5/A4rSWveVu7gMZ5ufXSAhC+9Xb1?=
 =?us-ascii?Q?Nk5uK3vOtbquvzLF99IhMjfBTke1exsT+z1O434FWeJCVCYNmkXEO5ttlNDk?=
 =?us-ascii?Q?uYBDl2Ux7Hig1eXWQW2Wx4VVl7LGwf+QfSMVGzlfE3YwTjfU5gUQFXZ+O2kn?=
 =?us-ascii?Q?blxxUUYSIsvQMu6oUTsOepghWD1gD0uyMC/7prmljpfy+2ZFnR6ON3hvkRe8?=
 =?us-ascii?Q?YRmWvIb1dOpf462pbwimcbUG12pGT4Ys+5vt26aJmfoW2Nz+56u0QDnXQPTs?=
 =?us-ascii?Q?FZnCDq4khB98fCERRJsWchY4OIgOp0UnCRK57R3wb6JfqiLTwB5PK/KtZXfh?=
 =?us-ascii?Q?bDbWQobiSt6dAqsIicYhAJs9C0gxhKmxzwGVBAII3vrcLShKSRFFZXrgFrZJ?=
 =?us-ascii?Q?vFOurDriF5XPW7kVNsfSveoso2Q7h6mrxT3PL54WHpCvDBhgBmRHxHarq0am?=
 =?us-ascii?Q?NsZ99xmNyZdvTzTmTqa5+9Rs7MG3FQSmvlLOrX4FyeQnaoPQgLyPPe9SDD8D?=
 =?us-ascii?Q?9zR5DqIDOy/t1oK4nDW29aAZssPUa67oZGfMSrE4FSXePb1zsB4PqHYMhp7j?=
 =?us-ascii?Q?b/NFlh+mx/ULFC+tOyjH3d/NA96emSArTvvwhjaV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2503af29-fd7d-4868-72e3-08db55f68e98
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:16:04.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X82Q2wV0xpYSmRrZFPC0Ecx01JVZO+D8XBIva37i5zk3vUMhWi/musU8oCwc7IuCkqHbhHkD7J7yo0jQyH5rAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to one LPUART IP bug which treat the CTS as higher priority than the
break signal, that cause the break signal sending through UARTCTRL_SBK
may impacted by the CTS input if the HW flow control is enabled.

So commit c4c81db5cf8b ("tty: serial: fsl_lpuart: disable the CTS when
send break signal") try to workaround this IP issue, it disables CTS
before asserting SBK to avoid any interference from CTS, and re-enable
it when break off.

Here we enable CTS before turning off the break, there is still a risk
of the break signal been impacted by CTS input. The correct sequence is
to disable CTS before asserting SBK, and re-enable CTS after break off,
which ensures the break signal won't be impacted by CTS, so fix it.

Fixes: c4c81db5cf8b ("tty: serial: fsl_lpuart: disable the CTS when send break signal")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0e56fa64b4ce..d9e46f7b80e5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1550,20 +1550,19 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 	modem = lpuart32_read(port, UARTMODIR);
 
 	if (break_state != 0) {
-		temp |= UARTCTRL_SBK;
 		/*
 		 * LPUART CTS has higher priority than SBK, need to disable CTS before
 		 * asserting SBK to avoid any interference if flow control is enabled.
 		 */
 		if (cflag & CRTSCTS && modem & UARTMODIR_TXCTSE)
 			lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+		lpuart32_write(port, temp | UARTCTRL_SBK, UARTCTRL);
 	} else {
-		/* Re-enable the CTS when break off. */
+		lpuart32_write(port, temp, UARTCTRL);
+		/* Re-enable the CTS after break off. */
 		if (cflag & CRTSCTS && !(modem & UARTMODIR_TXCTSE))
 			lpuart32_write(port, modem | UARTMODIR_TXCTSE, UARTMODIR);
 	}
-
-	lpuart32_write(port, temp, UARTCTRL);
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
-- 
2.17.1

