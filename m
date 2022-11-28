Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B04E63A0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiK1FEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1FD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:03:58 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B252165B3;
        Sun, 27 Nov 2022 21:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsmU2woAffnNj/3DY6WlZ+D8NdXnj3GIAYu6f6PXWnMRuzKCcP3WLWCraGom3aClDM+DpRY9RYCWsFUovx0uJm64w1MDVbp6zySCkiwFRDVPbqSJH0wrk9ZSkFGLf87b7tUe4ziVAA+dQAn/2YMwql+9OugNlZD1fy6nV6dMpu/j0UIfg3M8QHLjyT6Rb9VLff3LIIAjyK7GCLZJTiu9ZIvBt8PpMRN3mKzfyVUOr7YvF3QFAdWZ4pHZBz/hVyveUeuTHO5M6iA2WHaoTz9A5aRM2nYkNhWhK21KZQWI07dAxYv49VQjAPUmL7xEmt0pJYAOu8kTctsEKWSOAYMoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW/F2GEdLB23V+7ezHfkPoculxIGDiUWyEZwAyBm1gk=;
 b=nNdMO0zSn6O5agQ4RjywRjTTfaSY38gHiNk4lwcTYEp8eS7AvsRe6699E0JRqhQPx/GNpMWJZ/7T3Sx8WDDvQULYHnSRXz1QuPMJ3YiDLU+Nxsd9glI2Xei46pqXr55R0BRK8KM+jJ12DfKNc+bK4gXUNVHGqVtbl+N477hubCHVoPUZIjaxzAfjG/Oa2Tnj8e7FQLo8GEc+zweulmN2n0jxeCvTBE3JZGToT4LgxBytrYou8xEeuC1+qAmJP4V9pimhMucCE99+UwuBONK+W0ULS+uOnduqFzwa/aDBYxpEUTcWOjZgzxVtn8ZkAbULzltXB1mrZIsYvpLxTkV5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW/F2GEdLB23V+7ezHfkPoculxIGDiUWyEZwAyBm1gk=;
 b=XA8o1EAPky2Ydzdk6kbvnsIaGaWWyz6DL4gHhliJwMAjsY3fV4rWKBo0nrN5+UDgJMWH+EwbaACfIf1oco5GznMwMv16iiS7BwFQ2FO39Fja0SZQKJPXy8hUkbqBXE+pM6k6Ll95YCg1x9QGzeroT2I1DCy8zL2GpczLu55obXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 05:03:55 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 05:03:55 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: don't enable receiver/transmitter before rx/tx dma ready
Date:   Mon, 28 Nov 2022 13:02:08 +0800
Message-Id: <20221128050208.28086-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DU0PR04MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d14aefd-69b3-4809-b062-08dad0fdf1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC+LiECCwk+DLg5H1atqbMAi+s80sWYhDL8NpcuHoTbi2WM4yLWXVHLc9P2WTLG6QppT+Id8ydYSoAA2pYjg+2t2JqzNWX84ipwlf7pD93wJ3KT+tBvXxwrErmBKDHFR1pIGclknfXaaUPQ0pvf2TgXwjNKt2ScMo02jELblZ1IyustLzSJnv8fbKJLu0LLRnyszPVOTM3xT1dTpWxjFoacr7+9WzpW4BaDG4ejeJyBrHGn++1P1Xj3+xCPO01UwcD4YsxKcJBlZb1VDhUa8ug2UCtAHFRujyenhfYg3U8lFZpPSQpTHuXKl8DolxAd/ARTVlsXNTylafpDbjwraX3sy71yvo+Vl378sRxZ2P4G2tDyGf+F5YoEuf5B5Ckr7yvNzYiU9Dn2VNgaJJI62YIGhM/65vHqK0sNJZWg1CkoCfp+Osl34qz89kGFBF9r80QM21brqOqELzrTb9kJUWInjFC1Xq6zf0zhSXsZBeF/wp33DkpBTRg2kFNFwKr+b3fHOt1ZXRGz91UvGf95gXDqNZ6sY1B3msrK4+MXBXi8GnDJyTkJK0ufpz+fbJNpq4+tuzDm6D2wXw2yFmVvK/cjY94Ce8DjB0RCYeNIcHjZhrwi3RdbiLJ+LiArSKBJh5SguLdTjhi22UzbTL6qUc/nd1CRe6PKU2DEP0Qx66wWC/okPqE51ugYyU40Q54xJ6fPFQw3N7msn+8Pdi17DPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(36756003)(38100700002)(38350700002)(2906002)(8936002)(44832011)(83380400001)(86362001)(66556008)(66476007)(8676002)(4326008)(6486002)(6512007)(1076003)(316002)(186003)(66946007)(478600001)(41300700001)(5660300002)(2616005)(6666004)(26005)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V4p+R3rA2UaLs4CiOBSpAI0Z0gPIjwFQLCA0Uk14lnEEj4fCE8g6y260GYwj?=
 =?us-ascii?Q?Iv2dGkm9gyByqcsJeMtMWZUFDi8t0oJSyeT20crhJb1D1MxuwR4PKxxON/DP?=
 =?us-ascii?Q?9yKcxmIjcQdQahIXDRpq9kXLp72ZnHCt6AOGx2kfVkeoaUO0cf0paxKbk2Sc?=
 =?us-ascii?Q?lwSktFFMg/5vhYakvMHpvVWpIToM+U+PNx8ddfcFnFR2NisYMXze7jymRvXk?=
 =?us-ascii?Q?k7182cCFtootQyHNDF9UYWPX2R7prnTEiD4Mm8xJ3Dgfqf02W3B+mK4KIKvN?=
 =?us-ascii?Q?IRszz+ni1qZDXdZ2PJ0gAxj/aTagQk8W1OUMTEwtVchqABiaKmo7xtvYb5UZ?=
 =?us-ascii?Q?lcD1AuDZFoh9YZl9VnPcu6lOGuTWrKBGWleZgIfJ7d39CyDhWdFoAINzZioq?=
 =?us-ascii?Q?M9FWIQ+Odt4x51wO2Z2+7+UZs2IcSpY5SN7JNyaWTy38Pj4XdKth30y5ECUO?=
 =?us-ascii?Q?4fW9UrI4g7PuuKTnE6GQuu+yVZXDhN6s7jy4Qce96yzsbNQc7kQ63b8n+8Sy?=
 =?us-ascii?Q?wd+Z/juJUpX9TNAwzZZxOtBQm1km9z2WA1E10ej7+MfFvSq3rt/PVCPBLVVQ?=
 =?us-ascii?Q?9sLEmBI+D6DyfLu9kI3K1TFfqQtHfEWK8tfJwlsGlm/9yhIShpWz88dCTLi7?=
 =?us-ascii?Q?/H/thMrjuIw92KuhZcZmg/oep9ZyYiqS/9ObEUXU03uSHqmh/RLaG5AuXJWH?=
 =?us-ascii?Q?Yb8o3/s5b6P8PFCI7flnxt8yjivPhv/w3usObUTT59Se9tWi2/WCXH28c02E?=
 =?us-ascii?Q?9ATkWmCH9Aj27IW/Mhmv8OsFUecrogkSi0wssC60qwzvz2Z8CwDct72yuQiO?=
 =?us-ascii?Q?aX5547XmPOj6r2BWdD9mKQj0T72Y7OQ8NGPVlYLNtBAEkMUUCoK85rh3TCMY?=
 =?us-ascii?Q?r2bzh/tpyqvLkt1sGs2hzchSfYbv6Dg3P1nwzg9JeEmaTrTiNC5aO7N56hqS?=
 =?us-ascii?Q?S/9B/VJQ6Ji2OyLL9u2sEPMhf0r0H9V3OZLKDopU+LT+ZqTo6+BqU+bTfKRF?=
 =?us-ascii?Q?6k4CNMe06pkbEh0rhOiLSHpaTfQ/kJZ4u3Y6aeGJpM9Kf++Uc+xWvz6vPGVM?=
 =?us-ascii?Q?FRkcg5Y5zJKAEVgW2dFlBJg/OjlQaz11InI1nTcb4YVzxfrL99ZFlETmNLzq?=
 =?us-ascii?Q?+sf4RlUJKTc+CKkFLJPKkn6MQhQRUlo7nKdcOqIGf7w4NjN0fsFDy3a3aViY?=
 =?us-ascii?Q?X6mWSpYe+0gAyu45bTGOrIS/ZHVM7rdWzyTk7SHg83I08AUkqtbMValPifon?=
 =?us-ascii?Q?s3aUh5hUf4fpYw8OG0tEYQD+zGHgvehfA/vl5uEXuM3Iql8vV/focvUrD+AJ?=
 =?us-ascii?Q?VRATr/14biyVpMF7D8BhHhduTzytfn/mYZb2A6kNnxZCUC1xHD/Jy6PgV3VL?=
 =?us-ascii?Q?gi27D9YAUGZVaG3ATVKvBmS+P1YJrvOoChX+GRa+6lpYTCQyofityHT2tzKA?=
 =?us-ascii?Q?MsOCzGzknShvg+d5Ej229ijpMiV+YQ9+ojh1iyAht2Nv6voHUj7I0gb5X5Fs?=
 =?us-ascii?Q?ItekzA7W/x05NZLDhUAlzgDhdrbuwyqzf6hYBK7NCql9Ulj0h10x5XTIGiZJ?=
 =?us-ascii?Q?YFqsEnmtuuwj7/2TU9DfxmIaR93cFgCEfBgMk/g1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d14aefd-69b3-4809-b062-08dad0fdf1d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 05:03:55.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYsYeRQw4lTMrpmwguy3yi1TOPnbhoOaRJPnX6clm+y3q/moCOFw4zNgJzOi2WdBL0UOhX5MJT4YIVuIGCeazA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index 8918e08bb19e..bb12b328e224 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1682,6 +1682,16 @@ static int lpuart_startup(struct uart_port *port)
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
@@ -1706,11 +1716,12 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 
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

