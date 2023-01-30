Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5489680636
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjA3GsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbjA3Gry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:47:54 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199944B8;
        Sun, 29 Jan 2023 22:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo4NyXcfXQm8gpH3KDajZXQvirV8qVLjhgzPrJPgH5iIFPq8QYOy+53rlwCFliNq6pR4CbQ3XssaWwoe3+QhE+hGjYMSxJsqKOAtJX8FeMeCsLsAU902p/wyZrnTa61OjOcfFhLMJo1C7iGD2gBLM7Evx7ly2HKfDzLBT0twByI1w/v+K3ENBUGeDj5w8P+VMH48/mITo6GbKb3TMZ9JKpwIyeqQRyuK/YEDjusEP64jCsm/YFBTqXY8L902XeVBiBpZQTVm3MswyiIeUoAuMrgCUb7N9tMb3o5hUpsOK6+FgCxBaKdSI7HGQLgPvPWVNhanuqww6oVpa8SwVcyBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgY1VOdfacmuJ2RUs1jsVcpi7vxYdSiAdaIDNiAz4wc=;
 b=VknpQpjbfjE5iBXjOWcHXTzKiiOMsV9bMULOHBI0bbew1plKiAkzD4BMWxzGI4xOsb/OADuoVGEMNSgPbcDSLdV4LO6WEvzRQV4PmZBAbIdOh53DIafjSWkBEKiyt22Ktk5MdpPNwX4kIvpNu2Pc6ILMy4uULV6w1CjBh46YlrH+M4UUIRNgwvuja+YRQ5LEQoitNaFk8iVK+aWsmEPJ6f/+LyFAWYkfwqRxo3qbzotomLx6yMwpHf4GxALjYklzaZyovpo4+6SxW4h3ET6wNQO3NFgKXy0CSevIWI9yHDZCzxe6kh85TQbsm/PbtbtpsKbRth80tpeKOnGrHHWa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgY1VOdfacmuJ2RUs1jsVcpi7vxYdSiAdaIDNiAz4wc=;
 b=cG96OggQpSvMkx3Ihsve1Wsyfkv94dGqit7U68x6bF2DSvtboCGv4i7+PTUybh71G3HnC0wNqi3DtL3ao273c4ohjZXakiddTAa0UFBJiaiBKjW/C9/yx81vyYoh0yAGaB4zIWKnjtBl32BsESfN9j5w/DIN6TwHx00UVN94odA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:47:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 4/6] tty: serial: fsl_lpuart: Enable Receiver Idle Empty function for LPUART
Date:   Mon, 30 Jan 2023 14:44:47 +0800
Message-Id: <20230130064449.9564-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130064449.9564-1-sherry.sun@nxp.com>
References: <20230130064449.9564-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4a3a99-c2b2-4fe9-1291-08db028de482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAGL8LuH3A3nbr6qEk68T9ji4fhlQ0FCbMyynIpvSuM7T7UFobrpmzW5RwqwIota5IdC9DjjWhEjuEW6uT/TxfiW2NjrZB1n/EmNydeVfZXyo2u9IU1065LgQVJB6Pmk3+WhidzFoppdAMUaOkn3MM/Mr38YjkPIOSl4MiZvYQwqynMcFxAm77AFT+FBL//t+1CpBDA7mEfqiG4q8w5cMPfnyy82xTK/7Ql75znxc1lfLEvAaXbUUSQCEVFXSEoMgtWtRNsZPZkxagybXj/M9YW5Mytcpuneq7FqTj8tVhm7k9ll7jUJeb4EWBVgloscTwvdJwaF2nEkDkxMabtoYJwTPStOVrI+RsK2RqNbhKEK9F1WBHdVeU3Lirlg59MY52nd1bDGH2Edh43BM+vbBVdz9CVlG6gDmMnC4m54P+wYHMDx04tBELQfi6+rSPgp+YjjluQh2kKOTK4baMvooKGK9y2AEUtjYOKQZCJWOI2QozEgNvRL9VwNgkk9PsdaKlIrdUg/Tislandv+/C6pgeINonmdrNyzu178MxyjjOYyE0jYzlGImWCnx1KbM72VUJDTgDRRH+OR2eMI8XoC7HYP2+UHFOgI1uX6kX54mtLjYhVU452Fn4g11pguWpcT9faqBM7vHppO56/DfK8GgPig+lj5ZF1lqCOuUzMrU6I6rRhogyh/OB8HAECc4T9DBiZlC//3phEPT2zSog13w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(8936002)(41300700001)(44832011)(5660300002)(66556008)(83380400001)(38350700002)(38100700002)(86362001)(6486002)(36756003)(52116002)(316002)(4326008)(66946007)(66476007)(8676002)(478600001)(2616005)(186003)(6512007)(26005)(6506007)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSl3izzVnK6VpUT8Y6Qrwsdb3uqdaJp7bGJyMHk3xZZYqyTXLw4NGpQK7rbJ?=
 =?us-ascii?Q?dFiZsQZiOsGsaQ5bvqNdjnDOFuEQZI7faPOxtwr7wk7Ylnl+0i8SmtZhklkR?=
 =?us-ascii?Q?Dg9XMk7I2fc7GcN4oTf48ifC9LvevI2ajORTbvHXs8DDimAQr6Ic4TNFC3jX?=
 =?us-ascii?Q?cUiGp7v6l0vg+L0/AovMqfyR5XlIoQ8KJxm6UxsXZ78VFz0fbAxL/RNHlvdo?=
 =?us-ascii?Q?1FdSxc2aU2KDYDDmg5a4c9VwjNrj3Ake5bkpajcW0XEZfEkoSmyGM/vsZst9?=
 =?us-ascii?Q?vgbSd9Daz5C/hmxT258uEH8CZSfjoat1mEBFnJ7BwTMhvHKEQNmZ1Po0idfv?=
 =?us-ascii?Q?edE5Q8I04shp23OzpclNkN1qb4nFIr19Q9Tq8oWuozCKU3Uj4w2++VlIZNU3?=
 =?us-ascii?Q?khJ0Wa86zUspU9WP0VNXpEE/XiQe2hAXNFWePz1Rc8ikVEBvSc/h6nPK67zp?=
 =?us-ascii?Q?emke/IfNsru9pqtarpZfss7hh0uppGJw7S57isIbskFXW19r1emY6l0a1as+?=
 =?us-ascii?Q?XlubO3y71zpLOe8D8c9M1qGQSvam1GYUCanZ3sdols7ntVDReXL0jhfx+L/H?=
 =?us-ascii?Q?TxcKT7VKGxVGeyMpUH4m2lE+gTGmAVOreKoRV2o4y7Hn9y9pH6l49pQyQqSd?=
 =?us-ascii?Q?UwH8u7xQnNPHX8D+1bINq/d1IR+sxhX6g5tlJKCkN8yJJ3jc9sGNC6pP327c?=
 =?us-ascii?Q?u33MMsaWHzQaMIq0rsAlOahDgwAAkfKBRfvswZVZF64EhWzdHCFotI/a2n53?=
 =?us-ascii?Q?2p5PKcPI/eBUKcrRYU5d9w2N+e9FGXaJqVzRVOQoSpeT6nhOonLMnieQuH4Z?=
 =?us-ascii?Q?EmMXaHahI44mRcu6YOdEkBETu0e+cPLj8U0SAWgcpAihfgXNvh9oQxF9H5hH?=
 =?us-ascii?Q?NjHCm58pOv/PTygHO5jmTZqunEFd2+2f56i9wGnXTnz1j55z3I5gS1ZCoFD7?=
 =?us-ascii?Q?U9PECo+uxXT7ucp1cGvKHQh2shsvJnNh5DnDbzWYGW8uUGBvyaw0NsPiQg7h?=
 =?us-ascii?Q?ISeRcwVTgICT8h7roIMIuksOHVx04a2GMyPnl3ElKFeXQ062D/11mhkITM7o?=
 =?us-ascii?Q?ngXYgR+N8CVi86+Ddep8gQhJYDL7YQhOO2XUro4Z+1EBZc1o/7PXTsKSr8cG?=
 =?us-ascii?Q?Sm+ZLUzlDjZ0zS53RWmnvQlXv9YSPxVwHcVqS/5a1KYGpr0eVWUn6Axtv2ll?=
 =?us-ascii?Q?BF8vMWw/EPJAbKXFnsqWm6O86h6GARugHfvIvCG8rH8HBoktjRbZaK4N8/xo?=
 =?us-ascii?Q?ztLzEAN4S/H7I3wIZwkVMF07WrZ2YFOw4BcirMfNue5UOfSZ96pK+NQGoYEX?=
 =?us-ascii?Q?f5g8oZwDnzPnTVPOW5Ttd8qXRrimhl+2owJH4Ps1mAY/GtFo5V8yEW0fmNrx?=
 =?us-ascii?Q?/p0CLE2FA3kHvCOm2h22MLxLETVo7vLtZ7VGvZYv5QG+SINvLm+Sfwgc1tRW?=
 =?us-ascii?Q?j5jTdKlThR3pXGh8PyZkrXRUOHJidCbfSgRH8sYREyEy/S7NpKmtodYmrt7C?=
 =?us-ascii?Q?ZHgqFSVRkLpjJjSPRTDvluoQHsfzpjUlert1QJ1VrKy0Yk1Yn10Fdw0/FqJE?=
 =?us-ascii?Q?zUnabAFSanJ2LyhmXz/5LC2gq3fZjSX6hiSoRjTE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4a3a99-c2b2-4fe9-1291-08db028de482
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:45.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnlSaLmZm03qh7RcANJEjUXYj88iYbHn/J/VkwOFXvM1XfhVTSysxSl8B6YWa977qdBergBG/nyPyTn9B5EyCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the growth of rx watermark, it's useful to enable the Receiver Idle
Empty function, it can assert the RDRF(Receive Data Register Full Flag)
when the receiver is idle for a number of idle characters and the FIFO
is not empty. It will generate a DMA request or interrupt, which can
avoid receive data being trapped in the RX FIFO since the number of
words received is less than the watermark.

Here set the RXIDEN as 0x3 which enable the RDRF assertion due to
partially filled FIFO when receiver is idle for 4 characters.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ba6ade784ac5..2789749d3d0d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -214,6 +214,7 @@
 #define UARTFIFO_RXUF		0x00010000
 #define UARTFIFO_TXFLUSH	0x00008000
 #define UARTFIFO_RXFLUSH	0x00004000
+#define UARTFIFO_RXIDEN	GENMASK(12, 10)
 #define UARTFIFO_TXOFE		0x00000200
 #define UARTFIFO_RXUFE		0x00000100
 #define UARTFIFO_TXFE		0x00000080
@@ -1562,6 +1563,7 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	val = lpuart32_read(&sport->port, UARTFIFO);
 	val |= UARTFIFO_TXFE | UARTFIFO_RXFE;
 	val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+	val |= FIELD_PREP(UARTFIFO_RXIDEN, 0x3);
 	lpuart32_write(&sport->port, val, UARTFIFO);
 
 	/* set the watermark */
-- 
2.17.1

