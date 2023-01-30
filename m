Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2266F68063A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjA3Gs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjA3GsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:48:23 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04261B1;
        Sun, 29 Jan 2023 22:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvwGkng5psnCkUJrKmJcgVz9SUcChXWxWPEcYuVWZUW/tEvuZ/zKD0RoxvEdZ0cdbBWMeUHLtpEoEUd9CUhZdTi4nW3tn5QEP0y+R2PsRNX/d3+p9a6hn3Y/+poMXHivya14Ft9xi/fZREd2xny79XDSs9Z1WkSHmt/pgrwC3xDAu2/6s3YHiRLcTYNfNRAzFkwA4WfEfH6Us3QubxLckiFXylX191b5er6+njcrYDcY96fHnQdgNH20iWYGSsmZQIVcEyOBEVtfvlzH2EAAIW4A9XnFqUbVHjh4NTxXuWPx9z0jRURySJgCanSqwzKMAh6YCHl7p5nk5h+KUEptHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiB68H1+pC6UW6RkLbd7eF0FPUBuix5mh4y8ZG6/OK4=;
 b=XW8XmmDq0OBRqmvyv5S69wK3Bw29pMZaoMjCh+6m8bSocaYiFJewhleNBLP6glczAYKH/8AJYC5STzU4FKUSMxFir29XpbLEJs/u631Ww1+4NCpmPcACaXkze7cIbntmedfc+8y8Sxu5Ym45b+SCaa3AvRliU+KkI83o2bKnozBxjM1ofxZjOjmtsZj6Exfc0a9w2oaJXcxEH26tgBxVT9th40uK0G7eZXoYueJ8lGa5qrKdeWkrgJpG84I6f2zUrZcOPDv97DS+I35o7ngpQ41Ez3WiBcNUwRmRhzfAaE0IfTfhHrKWMimvc9wDStmBtH5fBn/zADXiUyMtHV31gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiB68H1+pC6UW6RkLbd7eF0FPUBuix5mh4y8ZG6/OK4=;
 b=I2glzUmrMB3WVITB0mKNqgCueHcbm4F6Zp+QpVjWqm6WCovLROAJBnTZtfY4SfdHcPqA/FFdBkdGOtx74P9hyy3oPv6HkZb8Bs/tcy+Do1qzqvo2iR6SvcHkwN1AAIhJ3YmB0FuEEz+InqBboiuq5za7d3o/kMWPnwYrHVvriXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:47:54 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:54 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 6/6] tty: serial: fsl_lpuart: add imx8ulp support
Date:   Mon, 30 Jan 2023 14:44:49 +0800
Message-Id: <20230130064449.9564-7-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4be3f948-2745-462d-35ca-08db028de9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSP+OQy6l/eFDcy64BmouMNM6oolJQCH88QVyfGSSYT+cqLDVQ7XfKx6DbyDWxuqMMeeA7imSst5Z76DZLmERIOMe3KyA8yQMmHSM2BoAZuz6JxMXe4qceijiGvKBwwM3WdYbVqnD/bPSCnoZVmd2MVZuEAf8dmQutK+tW9E3Eq3F3eM3j7JJtEQZ4fkDqbL7+OhA4ewOD/CQFSg5J8oT4Xfhg6yAy9ztDL7EYCeRxs7YmRfXdK/D3GeqR6bf/DoOnnFOTcY2q5NxqEfpWvCtCpWBtx/0JUAL7tnPIrWjBzDCk5AYGEIMfoOznYXgp/ELEn7nUf8hAlc9QY1hsX6CvD2LQqghuqxwvhcizLsNceTAzCBLOkHPCNnmp/p6hyf7TdwL3+eMZAQi2FlTowQEAm1ZCDKmmW/EEaFo2+4YI/FAg9MkDjLHe/q4eHjMfV3xlQayb2rn/HBomPClA9pfgYaTMPHR+ulax/DSkQyVhC2mvfCOOsj4X/tZtmSJ2ebHVC/2Dfw99rqLXyC8xAkg5YFgij7va0dSrMtJaXFo+Qr/FLjgqbnMdz85WJYbrfIph4n1uYlD6KZ6nrwk1nObO7+33J5Mu/i1pTPJXICGGLPbuRZXW1H7ZvsSeZ529m4Ploh0Dw7B1s2QYT46olktLnK5pg92/P+cg3fVs8WSW8LBce7G7wiU0Tz96cnGpaf602/plqkbXsW+PGxYvI/i6fiqahD6JZkZs/c3cUqO8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(8936002)(41300700001)(44832011)(5660300002)(66556008)(83380400001)(38350700002)(38100700002)(86362001)(6486002)(36756003)(52116002)(316002)(4326008)(66946007)(66476007)(8676002)(478600001)(2616005)(186003)(6512007)(26005)(6506007)(1076003)(6666004)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwJQKwvZZwGvTARNRSriNhQgDNqHBh9PD808/HBD9o/ohrAZjN3HeHXWDoWz?=
 =?us-ascii?Q?b5tLC+PwgSdJ1d7VdyO9AqeBO9GsKMULEAHRmRvhituiotjopU/cMEMIwcPr?=
 =?us-ascii?Q?ekfYIT/gP66XDAAwr+q7HpCvtjvTChNyybaOW0o2vaugW2H4gddgwLtHibbR?=
 =?us-ascii?Q?WrPa0wfufFMBn6mCOWmuuc8rULOVe3DaRzstdtYTcb8hHmgJWpTGfiox0Q3v?=
 =?us-ascii?Q?nKC/ehT5b/oyujxhB4JDvljwMhjDRwHQuIlpSs1ZA9azhZjarDInntzoOQja?=
 =?us-ascii?Q?tmmLFAtmRX3pY7VscE01IFBkEEYTUTDhCtmzv845K+juyx7qO22Imypg8jlv?=
 =?us-ascii?Q?Y78DkP2UuqjQnzkpdVeYM1E9lLaMcK2I7pFHg9SfKIZ1W6EwF1L18azRTUJh?=
 =?us-ascii?Q?8CjqbMNbqPDIvmezhUe1b2JtgWmp6vcBTnamqHL2F9u0yE4reYaNFYoBgJBQ?=
 =?us-ascii?Q?mExNc9vOqK6KxS1S8KKIsnvNnJGr9n67rY4V2hRufCDPyInsNWAB83PjyPUJ?=
 =?us-ascii?Q?gJSVk2tfrThJp/hszrG+LZRBtbtUpa0wDwqtzayQvAMSxmbs3HGq6qa/BXUf?=
 =?us-ascii?Q?m0AQ0/0Wly58eD4IT0fYKOiypxPqGcK38DLfro/dLCrIOAd/CimK3+lr29U3?=
 =?us-ascii?Q?twnlhAha8YHyyE2oL0BGD1EX9j7d4yjwpW0xCFVlfJxo2q4o18hP2Z2COUkV?=
 =?us-ascii?Q?WXL5uUXLyJOlu703wOHek90Ws38hwpr09czgv8t0nSSdA/Eea3tvwzpxyh1H?=
 =?us-ascii?Q?+o0dqEh1YBShKmcMNrx88bcSnwIidRtt8xb32FLw2s5JANTz/w9fYbYFM2cS?=
 =?us-ascii?Q?UQnav1rlSjy8GMVgbPwP6sYbwAFLUNmyYM/TSOaTL/pg/fhCcPsrgyZocp1/?=
 =?us-ascii?Q?ro/RVIgKs89poHqU9U2AND287fwf3IH211A9upp1H8nLMnZh2C7EN6pG4Lk1?=
 =?us-ascii?Q?dYQDvuD0Rstm3LmMmqfW8aXa+GOKyAg4GHZ8RGNPnr7fe74erZx5QJEGq8yO?=
 =?us-ascii?Q?XVawuXlXTpkHi3XR0xcVNtir/TIQeUBv727GJKp0HWcwpPhUd/QfEL6eaBt4?=
 =?us-ascii?Q?zVad426yl42mlZfMeEFB9GlcFvWa1svCgiaWsS9VJw7/uWX9Dv/KjxJdKHsn?=
 =?us-ascii?Q?5ugoYcfVNKo2zoV62P+jJESY9gYxs3/5wRtbK8B7qQ4DQ6S2C1Vbz98WBJJR?=
 =?us-ascii?Q?NBZgjjKLxFGQOCaXVGEAHfdLD1W+sUms2V30bqKB485FjOfBVfomjhPzJq2G?=
 =?us-ascii?Q?y8o92EJnqcTZOBd7ia8GUmUDokaOJUllwbrhQybw0wUimxgsaHKfCxB0yU2E?=
 =?us-ascii?Q?WDkVvO6iAgjRfMSj2DQIKybSHV5YtwRknE7i7+PzomqOL4uYhfjI7hhhkVKz?=
 =?us-ascii?Q?Y0690CcVqjdab2tfQyQkxoTXOYNOyTBp7Cz9xtSMtouXfEy6ENG9b0uLSL+r?=
 =?us-ascii?Q?3Rs0kmp69yScazwPQsQK1E4rt81vOOgezV7y7XLEIbVgPyYY2QLLiL61yDP2?=
 =?us-ascii?Q?QPxpqr1tzKl2eMkvTA5QDYsPRN8sVliVbatsKzu+2rAIE3N0tYawpXhJr+2Z?=
 =?us-ascii?Q?gCyRaf5V/6wGIqt60UjF6yj7wYQq+ATcs2WHAb7U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be3f948-2745-462d-35ca-08db028de9df
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:54.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX89Gg/VHMhn08KHnJTXHQdtS0aA6Kb/7hL1faPAXp7r5H7jvEE9QU/jL0LiAtR43/skt0CJHMnEsgl8Ee8Ykw==
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

The lpuart of imx8ulp is basically the same as imx7ulp, but it supports
some new features based on imx7ulp, such as it can assert the DMA
request on EOP(end-of-packet).

Here add lpuart support for imx8ulp, and rx_watermark is set to 3 as
imx8ulp RX FIFO depth is 8.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c35e49a09bcc..644827e97cb0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -252,6 +252,7 @@ enum lpuart_type {
 	LS1021A_LPUART,
 	LS1028A_LPUART,
 	IMX7ULP_LPUART,
+	IMX8ULP_LPUART,
 	IMX8QXP_LPUART,
 	IMXRT1050_LPUART,
 };
@@ -319,6 +320,13 @@ static struct lpuart_soc_data imx7ulp_data = {
 	.rx_watermark = 1,
 };
 
+static struct lpuart_soc_data imx8ulp_data = {
+	.devtype = IMX8ULP_LPUART,
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 3,
+};
+
 static struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
@@ -337,6 +345,7 @@ static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,ls1021a-lpuart",	.data = &ls1021a_data, },
 	{ .compatible = "fsl,ls1028a-lpuart",	.data = &ls1028a_data, },
 	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx7ulp_data, },
+	{ .compatible = "fsl,imx8ulp-lpuart",	.data = &imx8ulp_data, },
 	{ .compatible = "fsl,imx8qxp-lpuart",	.data = &imx8qxp_data, },
 	{ .compatible = "fsl,imxrt1050-lpuart",	.data = &imxrt1050_data},
 	{ /* sentinel */ }
@@ -357,6 +366,11 @@ static inline bool is_imx7ulp_lpuart(struct lpuart_port *sport)
 	return sport->devtype == IMX7ULP_LPUART;
 }
 
+static inline bool is_imx8ulp_lpuart(struct lpuart_port *sport)
+{
+	return sport->devtype == IMX8ULP_LPUART;
+}
+
 static inline bool is_imx8qxp_lpuart(struct lpuart_port *sport)
 {
 	return sport->devtype == IMX8QXP_LPUART;
@@ -2691,7 +2705,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 		return ret;
 	}
 
-	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
+	if (is_imx7ulp_lpuart(sport) || is_imx8ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
 		/*
 		 * If the transmitter is used by earlycon, wait for transmit engine to
 		 * complete and then reset.
-- 
2.17.1

