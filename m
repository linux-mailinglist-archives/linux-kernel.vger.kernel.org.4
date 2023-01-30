Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308BD6805B0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjA3FnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3FnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:43:22 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E622CA35;
        Sun, 29 Jan 2023 21:43:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CifAxPbRN/EjISkrK4/3B+0hWdLawm1poFn044KaISsu8gwRNUA18SAYOcEbVKCNwkHyJ7o1Ow8ZwHjqzpTjOKAS7a8Hrn+g0hMhADbBtZxVRs1iM5Yq198O+VM9DyXhANmGwbXAwt/WGk85NuBILntlghWGmUHmMiEM7wma6EauvOGPrbmeTPG3NtnekNqd/dX6zrTdseXlhzXV5/iSW/0/NKIamL1RLO8pRzjupXzL60nWodeZ+6KcWcOrf9mBP8MpVR2Z1zL2uf4WG2cxyM2ZQNtQsvkIQh1n6fU5gfXCSvAKGplSgXtk/Qx6t1+kR4ahO2r1/VLxTTnWGt8c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naEjFzEuNi+66Bmo0RP8DXwCeLCkq0MSnkuUXA/qlw8=;
 b=B7ND0ApWqn4dH0E3FNsXSn6xfq270RuH1pJDyC3raEegTHwJM+1QZuOpkEYTaX7Ex40EzPwhkPgtbQ7ZLYqLmlGWqsYyghncO9YGsaudvQnFd9FpoMbMrj4ETp/Dq2gdVmG+oncp7MtbDB4SBh+Op8B6B6Otjmi5Z5H8Wg6CIlaG1WkMdzUiK2RuQMG4k7jElG3uLvInLsWz+Zoq21yYeqzhZwUH9aDDBFUZMBAzyax+RqV/PdYYW6zGSF2psBmSVWpaz1n9gNWiG/jy2+NmwLb1ZhPmw0DqYoi2JKSUd4dh7Fl+Xmb/zEYsbzwwYiAsMy/rg6W8OXsZibz5kdHdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naEjFzEuNi+66Bmo0RP8DXwCeLCkq0MSnkuUXA/qlw8=;
 b=bXBznJJmhQLnAHVftduxECG4FNLIWMnIXY1N7saf2mjXPamgpD67nDDhieYCkJybMNaTmcGf8mC/YGNH7UTgYUNUOqsWl0uHQBE4/fyyH3KfSmQbwa3fHVPTjwyc+/1HyNz9egSVV4keG8evqP1LbtR2hQK6ZM4I8PwRVkCAcgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Mon, 30 Jan
 2023 05:43:18 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 05:43:18 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH RESEND] tty: serial: fsl_lpuart: don't enable receiver/transmitter before rx/tx dma ready
Date:   Mon, 30 Jan 2023 13:41:07 +0800
Message-Id: <20230130054107.9119-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: f151616b-46da-4d0a-3b64-08db0284e3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tf0UOU5UIpiJzqaM/jPGTl9xtmPDSqs9yvCJbox6oacEUwcgy/r/bcy8J7aiTueu9GgoaLC4YGeZSXVYmGqxB0+9FPc/3+qr+qy/Dz+YRZWkQbFrvya3RbB96R3z8nKw7FzjVXFzz2M6z+/k21nr76Op2I77V+Cq67rPsGBKgliJgkwiHqFlnQBGkuoehcSoKZc5LH2yn7wQx7o9wwlh/l4atOz033tSIkYr8D0/ihdtXegfkI/vukhhB77Dsg7Cf0SLs7wxvG6nnqO2kQmZzTk5q/8WAom7MwJ7VD2pOAr41fEP/TslGJF11PYKLMKYsSX/VrFnKtLZ6kcX4OOivgFk/cZrGRRgpM4LoAu8W3i/uXW9IcNOPCd/WN3ESt58IdtEQBK88vu32GoAQG180npqPWBsckPCVmQ54ySFgEjyeHJ3tJ5CwH75MBe1cNDyahc2TcFD8LzXmpE2IOO5DdiSlXYSuDo+cNv67PC7Ksma9Q84SPFMFdlyn/1hemCfiYKY0HU27kbWt0mfebJ7PMd8JOnhUWJ5zem/+rBtIoznk9bMG3ZlGl3HimH3bkpbhgC5coymvO9eTRQcGu+3jb78FWEAlz4XTQWV0DKb0UcqQiR5A2L9/RDCguEs+5Ewy0z/Q+WDkHEtxr2fetm1b7eyFlFEN8d7WsABXf50oX1XhZzVm6ygap6JcsL/zv99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(2906002)(86362001)(44832011)(83380400001)(8936002)(41300700001)(38350700002)(52116002)(6486002)(478600001)(38100700002)(1076003)(6512007)(6666004)(36756003)(26005)(186003)(6506007)(5660300002)(2616005)(66556008)(8676002)(66476007)(66946007)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o78uVfN3XrJgtBKzQczfbJ9tS8wFx+yrKIqJktg1vvq2tRYgbboiQfhjjTTk?=
 =?us-ascii?Q?u2xWJRo7LwmMYLfgiz7jQ+tnDyDXebdhgKojWngGhE8SPQ4yF2OqqQY4fy1l?=
 =?us-ascii?Q?yjyUUWQ9rF2L2Foo/jActdQTrx/32eveW0rZ1VoE88guIOKhh2DMk1iChkbp?=
 =?us-ascii?Q?7gwuJlLnCWpAl1KdV8qa16gA/351IpGMXeVlm3dkIjcuqsi6PC+gocSmwltM?=
 =?us-ascii?Q?34jH2SgNFl8u3qSjMPlq0nUhURmQc/dBsTXaGT8dvyGuzrXXfCzBZF0vHVbS?=
 =?us-ascii?Q?dLu6jJZwebqYPDXvawupUwGA2C4X2c9T9Qqz5A5g8zom5LG0hIfBfnCr2gEy?=
 =?us-ascii?Q?+b5YNmdopEeXrfPdXL9Dr63iOD+3hwNDHggk8vX21cl63vasBGDTccQuNeFo?=
 =?us-ascii?Q?LhE2qvgV07404awOY0FXC7uNlExTpajiqc0no7I73UTg5luToHxicx6SxHbO?=
 =?us-ascii?Q?MdefvqU3myNsjiW1mGR4R5SMkk4uN6luVXoNvUZEVKFOqLLMuG+Vvje3wI9P?=
 =?us-ascii?Q?An+rLuuYN8Vlrw8vMIaexmjtlOFb5WNm0wXUQSbut0f7HRC13eufEwmB9z9m?=
 =?us-ascii?Q?b6DXNypUejn+FEaT6ZKZpnewjTVQSJWu/ofJosNmAeu/l5vrcNVEUzBI8s/5?=
 =?us-ascii?Q?cV3Uw2I32XAIQTMZumFwOEhUjakwyAl2fT5NqQ3Go3gZ07+m2nf09PC+jnpE?=
 =?us-ascii?Q?+VctGF+pUOhWGs9wez8czfBMByOI5QMbP80Q3QRnmRVEqYmX2BZShvQ5X1Vv?=
 =?us-ascii?Q?icdeCj943NRVjYRTLwTfsfs1ZArRdM5R0GeIU+aMEr3HbdK4xBnecQtJMdDD?=
 =?us-ascii?Q?+DDTVsmrHD1FODboFW9T81EJ2CKmDC1uDqf7nhTjxACb96yP42Woor/NSEGB?=
 =?us-ascii?Q?RsR2poxUp90uoTA8DwOPKcx9yP0FWk5KlY3NZ3oEqXk7O8G8xCzGfh8OBH6O?=
 =?us-ascii?Q?ATLj2YSCtxJvUK2iqq51IkZiA2nuv/Lrbpxj4rQpXXSUQHp3QKF537Us/SRX?=
 =?us-ascii?Q?Ld9MQ8Thmz1lOf5lTNsvkhuPkLGrP+iy+YavWydAwWfqIxTg9AEU1bs8+hlo?=
 =?us-ascii?Q?ETYeOvszMFfXZnQ/vdWiZUMoYlVFRHPmzPxfoXQDqiTUbntB7uB+h0IMflZM?=
 =?us-ascii?Q?HMS579p/sUN0OPtOMs+In9WK2V1x8+Xr//Dq/eovm2QIYrnzlbk0N96KAB5z?=
 =?us-ascii?Q?3pIcviO6S9XegpvoZrQxq8fwYyLaW0XOj7hs9ph1bMl4NF4qK7/gsTG6pRc1?=
 =?us-ascii?Q?UT1ziuhcjXRiOExCANaRI5dznF/o7yM48W7MS0HoOxy/ZvESQmd1A9NUwIRr?=
 =?us-ascii?Q?oo4sSGrn62RqLIoMkw202vNefyth7B6JEgPCIjgc5JrgcaI6xWbl1GQGvvP6?=
 =?us-ascii?Q?SnZ2p8ap5DNLvSixoBp71z9E7z349NXUBS7CmDgkjLKM6gXQ73Vq9KIDMPjx?=
 =?us-ascii?Q?WPn503WAZO8NmPTXEHG+FRliSkUZ1pdT/9SH/G6DHZvOFVmR2Mza0qkhbHmy?=
 =?us-ascii?Q?0Orbxqt58sdw/X70LZRrIdvi6/r+KihOghoNIdEnsHfxrHYNpkXPMDTkhco3?=
 =?us-ascii?Q?es2+sITBTZA9JY39EVzdWdOb/Gp0Ho1V6o00qOid?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f151616b-46da-4d0a-3b64-08db0284e3ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 05:43:18.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txn3A9EoFdOOov6AO0NrUnkUfq+tbh5g24xkiogiuRBlCnWX+xx5BmzEgYDTc3RUzdhZiatfcv63YSg5awuL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart32_setup_watermark_enable() will configure the UART FIFO and
watermark, also enable the receiver and transmitter, this should be done
after the rx/tx dma steup ready.

Also add lpuart32_hw_disable() to make sure the receiver/transmitter and
interrupts are disabled during the dma steup.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 04fecff2fa5f..eac5243a9db0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1702,6 +1702,16 @@ static int lpuart_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart32_hw_disable(struct lpuart_port *sport)
+{
+	unsigned long temp;
+
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
+		  UARTCTRL_TIE | UARTCTRL_TE);
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static void lpuart32_configure(struct lpuart_port *sport)
 {
 	unsigned long temp;
@@ -1726,11 +1736,12 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart32_setup_watermark_enable(sport);
+	lpuart32_hw_disable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
+	lpuart32_setup_watermark_enable(sport);
 	lpuart32_configure(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-- 
2.17.1

