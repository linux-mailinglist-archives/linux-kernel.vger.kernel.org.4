Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F046E1A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNCY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDNCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:24:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A01703;
        Thu, 13 Apr 2023 19:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKVzMgBfAPfpYJ9jUHquML74n23fUc53t5euAjqDOm2AH5dRSXf+AtJFFIGRHhpucrKGP8GDPG0vC5PGlQMPcWmTMxvMcqv68WRjDsaYGxUZzabicLrtSU4OFuSjteRwL7Ec27PKqfuigtzcEolAS6gZQlUFa035hC3GnBOegpRqfMeU7zqzXheMuTzXp1QaDwM8aa1SRI46zLVL65Twb8K7xMPye/HCOdaFVgJrAOu3TNaQCDIJ/43v7o7yEZ/98C49D9lj0Ynn7v4qT0ZE6cDuJRAylTVJRQ4GioxKHhp/eKeFMrnzJoNKX4tZv6m6JXQ89IxAVXziQTza1FfBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a6LxWLOgRyUuYZm2uCE5m3z13QBnswXQhMwGpy7H4s=;
 b=fe9mlr1AfR/HhNeb30MklPylyhNm9Ts3Evzu8spnOwuNLaPnX1gBREAryH+mT6/85xQpnA85fmfstzJhwjrOuwz1Yx18N1QVDqozzB4XZ1rJlgw8RUNhWzaeNrQAvN9KPsJxXOTFsqmVusvyMXtNQEWPXQzwOsJ5Gy0S2iBsSxRgMV4dPCi12eMKhkQxUcp4ZdrFW/p44N0eueyb2WgpbaI/uiqzs+lW2jLdtrKbNNmUBQNDh/aArTanbf8JwNZsNhN+tsIyXf1lgSzcE2jjNAZbaZNJrbDW2tiS/vBAIp4SJXrnVeJwDeaPvgb/j2UGq8ObQ4/BJPdO5cXC8w33ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a6LxWLOgRyUuYZm2uCE5m3z13QBnswXQhMwGpy7H4s=;
 b=D42ejNebBmZFdtfjAX3DHg+suuXQ4LmFVQkGhnCP35x3vOg/bF0LuPQyWNDMhqLhb0OzAKt2IJPaN6cHSrx/48Uvu2zJy93rJPxCHbua8M0VPICl4YJbIMB4nk4HLM7H1qlJ9ihwo+t7jBj87GgFr8EMIpBYdFPEFY8LyGyZauA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBAPR04MB7399.eurprd04.prod.outlook.com (2603:10a6:10:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 02:24:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 02:24:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        philippe.schenker@toradex.com, ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: use UARTMODIR register bits for lpuart32 platform
Date:   Fri, 14 Apr 2023 10:21:11 +0800
Message-Id: <20230414022111.20896-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DBAPR04MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 961ff1bf-2a83-4699-d741-08db3c8f6d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtHQErKL6pJQwVRE7zPNlxLZkRFrr6sqPJpCpQaouEl8pvpX0c1JUFrhVZ2/zZGeRFldB4plP7UFqczsgax3C2Yjk7rzbJTv5ld/+rnd1N4j6JDtanRq1wensp2IhQFTiZZf+Wo5zOuw+ZGJJ3h6cBTFSKTNFCsgaY7xN9W9lJlW09Ds1WsbYfzeeJDcEbACRXyzzfQJPHiS5A0h1ZWamNHov4XBYAJ/9QGH7VNBOhD+iGafu69RAheq3Ru0SgDuP3xjOdAXPUhqE+7Alv420zisGT7d5DCKTud/e5bRmvCKxbBM+F1gBiv2f8QR1uR705sZIF5CXCHsU6aT2EXtmh9J4Co4qYIukO3aoyb4SyJQokKcKT1gB9a1CRXHxSAMIKHp7MIfYUMaLUlxQoFR/iV7gXJKwkBhGu760ULyTW4Ty4yvA5xfG9xegYiajhIPyB9ACEGMLVGVXf9JaF9uJ9bDhcn3nYkv1skUdKhdtXLNIQkIFAZZVAVE8Gc6N3Co759TuHt4FKOFDyroZVUUdOiIq1uHIKQLr1ZYrLdzle+wY+mzBlVaHFw2PuxmmrdPmldz2V/wwY+He4yhtnlm43wZx5+5Lqf+q+XcOsYntpFVTi0/LuNA52KytDQHWG2e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(83380400001)(2616005)(1076003)(52116002)(6666004)(6486002)(6512007)(26005)(478600001)(6506007)(186003)(316002)(2906002)(5660300002)(38100700002)(38350700002)(41300700001)(36756003)(8936002)(44832011)(66556008)(4326008)(66946007)(66476007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1FOcDE3MGtTNk1hbDRrQnFSeG1RRVgvN1UyRUZ1YXRrd2p5dW1aekpqQjRW?=
 =?utf-8?B?NEVzRFRvamlGTU1VSGdvQjRYZWY3bkN5b2FVZ2x5eE9hTDdwR0lsall4UUI3?=
 =?utf-8?B?Z3JOWFk5cFdNYzdHTm5ET0FKZzRrc21TR256eWxXSU9OR253SzlrYjk5M1dB?=
 =?utf-8?B?VGhDK2R5UGZPTGYyRjNQeVJ6b1M5c1BlVmlUMFRkbVhXVkg5QlJqRmx2U2o5?=
 =?utf-8?B?cTRlcWZpaTJWSVZWRkVvZElKZDVrK0xjQkFqbFNoL1RIdzJhYnZYSm5TcWls?=
 =?utf-8?B?TEdacHpiOEhadkdaQVpnNTBYRUkvaTFYRFAzelZBNTJqRTU3OHlqUGtwK1dU?=
 =?utf-8?B?SUhyZ1VJT3ZiVDRLT2l5dXh0OW1OT1daK1hkeEV4blpCZFg5aTBHeEV6VEQv?=
 =?utf-8?B?QjZ1SDBBY2RkcnVSWDN3VUlIUHdvU0FTKzhGS1FNalZ2U3ZxTXlwZk1LU2RT?=
 =?utf-8?B?R1doaHBBYXBhTVMzV0pSZEV1ZHRmbW5ORzJMMkx4ZGV1ZEw1enovcFU0MWEv?=
 =?utf-8?B?VTZIZXZHcFNWQnRxMC9TYkN4YjVDbjh3cCsvU1B4ZTdvVnNMNjlnSTF2dFQx?=
 =?utf-8?B?T1puZThtTjNRVGRObStEaEwwV2ZOZFpqMGdWdTFuS0s3eGtsRm5ZN1luaXJF?=
 =?utf-8?B?a1RVbGx1RXFSTWw0Qlk1TmxWM2JPRDZ4NXNRbFR5aTVjcmI2eWZwZE1KQnJl?=
 =?utf-8?B?UlVLMSt5TVF2YXk3Q2lKQVVXb0J1ai9INnZHd3I4VjZMOElNRXVoajJ6SU90?=
 =?utf-8?B?cS8xUmgzUk9FYmJ5bXJUU1BWdUFjYmNkYVEraHgycG9RWHZXck9FY3JYbHlG?=
 =?utf-8?B?M1JOUGkzK0xkSndsUHdyaERQT09NYVQ5REp4bTBxR2oydGRTdEptL0RFc2hq?=
 =?utf-8?B?bEIxQ05HMnl2ang3YTRCaXhlVElvOVo3MHNWT1p3QzFLK3E3a0svK1AxSFNv?=
 =?utf-8?B?NGp2RHdyc0tzTUtzazI2RWs0eDVkZnVkc2RNK3J0d3VKVlV0U2ZxQ1k3Z3Zz?=
 =?utf-8?B?bHNZRDFudENEOWd0OWgyWkNPSVBOS0dwdlFIZE9mNnpTSktUQVpaTGpUdHdI?=
 =?utf-8?B?dnhWUWNqWnFZclJWWUpaTVR0Q3ZqQUlEVUZWM21vS1pNR1d4ZTI0SE5oL0J4?=
 =?utf-8?B?TmdqTGtxckNOaDlhMkFCbVJGS29oSDZuVFcyUE9haFRwUHdkUk0yWmJRMk1o?=
 =?utf-8?B?LytjclRueGVoY25Xd05iVlB1NWtYS1BjKzgxSUZoNFlSbGF1bUw5RjVRU0Z3?=
 =?utf-8?B?cVhlVDlLbjVtbDhxNk9XSE5UTEZTcWlRWG5SRUdtZUs0Zkx0QWdEK3gwR3BB?=
 =?utf-8?B?ME9ZRk5lMGhBSEprMVF4d1FtaEFVOFVQQUFnMUJremNzaHVWTkVKa00rRmF1?=
 =?utf-8?B?bW1LdFdFTVYvZHRnQnl1dS8yR21ZcU1kWHpUWVJ1bkpsYUZBT1pXUTNrQVh4?=
 =?utf-8?B?RXJwTHh0WjI5YVkwNzVJSXFLczgyRjV2WkNKdEgzYTQwMU1abE9zaldUVmFL?=
 =?utf-8?B?cnU2UEdCNE4rQzZ4ekcvRmJCSGlPVlBmQjN2cHRBVTN3a2pNb0ZrbDVVRms3?=
 =?utf-8?B?T2ozN0ROYUxabVRJRmxicTZNZG9ickp2YjcxRmJSWGZBTG0zazBXTjF3ay9K?=
 =?utf-8?B?Z3JxbGtZZnJJTVY4MjAvSVBxR2o3Mm1NN1BDcXk1eUxmWm5Ka3dnYUdTS2Ew?=
 =?utf-8?B?ekdRQ1hlQmwrZ25kQlVYVEJpdk9kcmc2OFU3Z2ZQTVlLeHFOQmZxbm90eXpZ?=
 =?utf-8?B?T1hHMjRMcXlkRzBEUHRJblhES1ZtTi9MTUVnSkdnZU5UUmNrdGxxMmRBd1d0?=
 =?utf-8?B?bGIyWG96YUIzdkpObzRmTUl4c3ZoY2dUVy80cVgySVlBMmxmRHRhUG01QTdv?=
 =?utf-8?B?dk8waHJQM2RiTCsvZGdhR1RFeWVBSFJGODc3bUFmM214QU1FU3l1TXFXbHJk?=
 =?utf-8?B?bnhCZ2RhOUpBald4TDk5d1RZTDZiKzUxWUVNYTB4WmFseCszZ21WM0FrV2pr?=
 =?utf-8?B?UHF4eXNkMDU0Z0UzNDF2TUsyQUJiNzJpbUVWTytmODhjV3VKOTk5N1c5b0pz?=
 =?utf-8?B?U0VxaElPVExIVkxQTmY4cjVDejRod1lvU2N2aFhMamRYVFBoQVVCcXhOYXp0?=
 =?utf-8?Q?H5bmfOpKZEi/IsyQwXPSuzHdN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961ff1bf-2a83-4699-d741-08db3c8f6d5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 02:24:51.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWxapn1VdtvnFthwawTiPTkIfmDX5kQht2dj29cFXtNrezK5o02gA0NCfZEgGuFfC7gazBZ+qDlc3cG0UT2ROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lpuart32 platforms, UARTMODIR register is used instead of UARTMODEM.
So here should configure the corresponding UARTMODIR register bits to
avoid confusion.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes in V2
1. Remove the fix tag.
2. Add Reviewed-by tag.
3. Improve the commit message.
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 074bfed57fc9..9845d3f5b84b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1406,12 +1406,12 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 			struct lpuart_port, port);
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
-				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
+				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
-		modem |= UARTMODEM_TXRTSE;
+		modem |= UARTMODIR_TXRTSE;
 
 		/*
 		 * The hardware defaults to RTS logic HIGH while transfer.
@@ -1420,9 +1420,9 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem |= UARTMODEM_TXRTSPOL;
+			modem |= UARTMODIR_TXRTSPOL;
 		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
+			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
-- 
2.17.1

