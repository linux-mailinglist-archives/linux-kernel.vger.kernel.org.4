Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C564C29B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiLNDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiLNDOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:14:01 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D3F186D7;
        Tue, 13 Dec 2022 19:13:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc6pN0uHnZHkSF+oOxZiPdteWuxzBMt57smcD8ZeXLqplE69OyxO4CthNv9uv2G+MT0ccemHlXJdWExKnpEvJGoE7DrGQaywD1bLUxO+XvUe29L8HieYddpJaV46k9PodicbrsfLK6hxB45Gt91XiDf8eqAE9w55HProPilgAlcB5Q7yDqyKaR7oy2nVbWiGplPs7MCZwm3Q8teiV2YePFs6pPwUSUkBOsHPqm7se8BV3tFziFxC56L3K6CCNYiBELAXh8kJeirf+auxwyCObwypJDJk1eRchkuWS4/8tuEgRZowBKxBAm9YBWD/UIFzOueNI2V4JH87goCZwE1QTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrFISmB4lMk+DvE0eAeSVmmX1sCY3hUAveXWjtP8BYc=;
 b=EgfbK3ezucynvyV3F6OfU6/oZqRclAbKsuGuAOtS74tLUhRyZi4SFbYJJWRbraw90lDSQbnx2NbjLsKANW/e13xBy0mQQH7fkkR63dmRx7t2X0icPqREsTGb06kWMyMXPVibJSWNHgAAJi9YwvnkvNNpGHUk3JW2AJcYLH+bi7qCF9UwqATXbbYs9lpAOookt5VFYTM1QznI5zzeKbYygrpGZqKAFkXji+W6+TZwUSUHv7XtMrigA1CbXj4n3Irhamo1n20g2c6g+/gIsDygtPgRQUj5YxwlzN7L/y0cxK8JHukuvylrPH9xeX5wb3wLRQ62qWr6cUHmBw86riYp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrFISmB4lMk+DvE0eAeSVmmX1sCY3hUAveXWjtP8BYc=;
 b=Tur0dv5Q1oKk6hPBxjcD0k4pCygWvIpkyDeRzQithomRhbpcdicDXJ9rlnxXVV5zxpq3+1w/snfIuU7oltBtN0ksevT7seihMp+SWO+mBiCEtXnTPvCWyc5yeSGunvcczGLY7y2KqC/TevRmDM1PCaP9jfoSd6gKFL5GBkHRDmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 14 Dec
 2022 03:13:54 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:13:54 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/3] tty: serial: fsl_lpuart: disable the break condition when shutdown the uart port
Date:   Wed, 14 Dec 2022 11:11:36 +0800
Message-Id: <20221214031137.28815-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214031137.28815-1-sherry.sun@nxp.com>
References: <20221214031137.28815-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: d688fee5-0b37-4ec4-c5fb-08dadd813b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJQE1wJlOFYGQXUSBfBwSQq8XWpb0DCA3FlE9qDx2S1tO3QC9wjTZ/RHO1qzeMMH9rYdrxR0pHPpQPU6mmSnOky3K0K/C4hm446tBZqBQr2CKbvwB/sBQ4URffm3SJzUkO28D3aRAUz8z5q6lXVzwmZSxQuv381S4aWn7EKqIGI2iFl9OWoYjzG4u7jwKT8S/GHV1XX/A2xFRaApMwhUvQyQubPjSS3EhDMfLqPeM2tFg0UxCwfLrRISnyslT7K1J6pI0YfI4j5MHyqQ3dXvnCKrOZfWD4W8+536un4ycOj4JIxTpOQrCrW+VdgG1HOGoEuuL3Jg0KFE1TiW3sK5GU6fb6i+HiYrZQmak8S5qK5K6PKxO+g8OhqX3m7F1B8ZWv5hQBdmKllFCCYSWZfJUsIycOxkW3hS9cyse1WUUqnNCpd4sNjqfVA+re7haeX2RVWmLWXJYb1bmJ24qEIM2UtO0WQXJQ20PGsXshPLJ2ju+SQ0h2H/3LpRE5o9I2QxJPbCjy34GO6n/zutzrA63jKBoXnb1u086VRDok1GNmdkx18kUxkl6UfJFuE8Rh+TiPky4EaCm5O/Go4PHt2A/RPpyu6rZSH9pRFQE6EbkxdXBVaLi5jmXKU3Z6kGT4L8GuqiD6WqNQsF5CCsRLbBL3VrVr3aoxDDU2bSNhfYFek11m4occmCwo5q8GX1l/DtR5dkCtUzAE3PwAHP5BL4yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36756003)(478600001)(52116002)(44832011)(6666004)(41300700001)(66946007)(2906002)(4744005)(38100700002)(38350700002)(5660300002)(86362001)(6486002)(2616005)(66476007)(1076003)(6506007)(8676002)(316002)(66556008)(4326008)(6512007)(186003)(8936002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNv/PoQIG7UY7MjYGoBjuGoxyvooPGglPYVpx2ioEviDMT/5gVUd0qkJQRZe?=
 =?us-ascii?Q?x9eatxNZDjOvxc9X9kU4TiFvM/3o3rgKXFfBv4WPrMq2j98iOKDwSlZrMaQM?=
 =?us-ascii?Q?dDrZizOvbGYbK1EPh3/HSXOrHDFLczIF4GuyZGZJTOqLxkVp0XiC99/8ZByx?=
 =?us-ascii?Q?f7l7ULOvgkmF+GJ8rZ1JtPMV8WdHsSZ6l7YKWcG9mV/b73Dv7wNE4Qo/Irdc?=
 =?us-ascii?Q?P2YYwYE9Hju5MSfDxVcDEXQY98sb5/Fmsmm3AYS7G+Qzjazt4LAGJmSOjSlC?=
 =?us-ascii?Q?MaAojLwDMWFAymtgTBBI3+RXr2HyX5Hkguhr3MX2oJWkz+sgJYUhFsoek6h3?=
 =?us-ascii?Q?aIQiIe0dPSKZ3iH/QBpawYmwmW418TK/q0Mk/5u/nCF4Nm8k93lYj4dHNmoD?=
 =?us-ascii?Q?TrerzQymAJAaS6I+J/NmwZXH43+OEplxGyy9Wcz8DI5qfNvu95oNum9vab9h?=
 =?us-ascii?Q?t1oKGGLUPDIxD+1eywR0rUaGBYFh/qwX+A3lMoBB7Thc6u5RwtATbrM7nELw?=
 =?us-ascii?Q?SBbXeP5yUNSUiP1ptbfaN5bzN61vDTzTAzQOU576AwS5svmILl1xw4FIuTR0?=
 =?us-ascii?Q?NJJS0aqpzppVwiwLzS3uCwmvlimK26fJrmu8rY8uR38j+drOxndiv6ovnbMo?=
 =?us-ascii?Q?VOx269hCw8CHC+RafbzY0xr9rh9h/6c7M8mTXao1wHIT7tKVH9cDFAZ+VLul?=
 =?us-ascii?Q?7VLLSrrBIY9UHj1EmBlBZvkczWuZ8t2q/wpFl3KgAEZnAeTnDyZwA/6EZ26+?=
 =?us-ascii?Q?/Mf7YUpVrAopKkAF+0gvKxmlPtbl/3sqnN7Zl10btjhoRkDkg7yX/dOByhT3?=
 =?us-ascii?Q?rUtZFSyX6zuaDoBmrJhWtftG5ooq3cXu6ibEb/QCydQd/b6HWCDOFxYqKS7f?=
 =?us-ascii?Q?dET20OxJW30q6ZSoUoywR8rKZ5eqiglNvQGQxlT77//O7DejCLjB8w8RBxeK?=
 =?us-ascii?Q?p43KVgywCXjUhaQbLtd0Ynv+tO0E5Pjtf0L0M+EajsnehpZpY6op5VIAKIWH?=
 =?us-ascii?Q?3Yym9IjTtdKA+Yjp4CCAtLEWmcsWm9UufI+9P61ftMaFpPfmy5BVTUXxM/ir?=
 =?us-ascii?Q?3XHAf3ZXi7KOUFijwbsOyq79GA8M5Pk/DdfTm/w0wKmU9QbZYRXtrDJUpVkI?=
 =?us-ascii?Q?F7FugL9DGE3RpJd3M6jWCVTA+Iy2nerKztNVsjt5I7DVUFekVlhJAIDRH7sE?=
 =?us-ascii?Q?XrP5fg57GclKkNcNdfa3QuKuA1HWW39GJTb5vy4sKDhPriedZzp5VxO+gcsj?=
 =?us-ascii?Q?bGzYfZmeProPPYjLZJ3HDEFf0l4DBfZ/yGN2r2gHtj4JpXr365pTa4Xf+egt?=
 =?us-ascii?Q?ew8XIEhrNs24tw0NmIR7jDmm4TVi1db/IkqxUuH4KZ0Nmg2yWMcyEgnffaWb?=
 =?us-ascii?Q?TsZjHqxk8qBsIfh18AeRg43mKR8sXx+w0znDV29yQs6fFoCxh97mgIkKGnkr?=
 =?us-ascii?Q?3KyulYZeFsKAn3d6RlyMvfXQEp+eh2bxH1eILCvlTOQVwYDN4c23gUsW051U?=
 =?us-ascii?Q?3cdueGbDo7+lEymE7U/1h8BcZtNkiMuJgbFE9RmOGsTaAarG8fOkaeoWtK6m?=
 =?us-ascii?Q?e3QDCcwq1vonhkgBiYErjUMtfLuNpYYMgD1llR0/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d688fee5-0b37-4ec4-c5fb-08dadd813b77
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:13:54.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTaGV1NEpAYo0fCIasx6W3gnl3gDCORsq2gFxtkw5YQ6v2Ri6H+eTa1+rre+BIhZJBnxYyTeVhgsm100Ju3gJw==
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

Need to disable the break condition for lpuart driver when closing
the uart port like other uart drivers do.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f487d3d2effe..584b26e0b947 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1839,10 +1839,10 @@ static void lpuart32_shutdown(struct uart_port *port)
 	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
 	lpuart32_write(port, temp, UARTBAUD);
 
-	/* disable Rx/Tx and interrupts */
+	/* disable Rx/Tx and interrupts and break condition */
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
-			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
+			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE | UARTCTRL_SBK);
 	lpuart32_write(port, temp, UARTCTRL);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.17.1

