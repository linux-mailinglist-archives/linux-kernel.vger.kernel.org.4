Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCC654B97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiLWDJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLWDJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:09:00 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B41318B23;
        Thu, 22 Dec 2022 19:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC8BDKv1P8b6KYHOIle/wo+aOpUc2C+oFztJ/44ORWLMSRqdc6pKNI1kSsYyhj+YkCUozMyiEgpfMp68SINc8YVm3/NfeWylApcDkItecs056hiTA3sTlwo0ScIYnG8RscAkJrL/dOsQanMcVgP4j/PWBI4xWx+hI7d8gpzbrSHRLRLGal6pSGjaCK6sjxXiilAD1bH3RY2+i2g+t+v30HMegFtkRnYKX9xcbkt81TrBE9Um97WqDQuFLhFMLP6twEtbcBZ9D1YUwU0/nCyZ79hMvO8VDfwcXPUSUO//RqveoQPohp4PvTrV9e9UW013++UHyPIC2iPWi7lYncyGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8DlfgzcEEA3TFPGdiXC8Q9zjjvCekS8Dr1odem9iAw=;
 b=CZgRWP8NsKYCsFgv/FnT87F/UUe8mJ1X7ui2aKGkOBEufqWezceWKvZ8jFSoKqBcPXwC+hTHXQMVDJDu6fGlIbeuxAD+sUwYpobM63ATAEK3UMLF2cANXLp1fhPo1ApikUFAO2ZnVKbBszXxP9ezVMDZ3p42xuLCNJwHpx/Qru6p5GVEGCeIR1i2/tRO3MTFNMm9I4OmFJBsvmqm9fZsy8kT30eMl9EF6W/1ErKDFLOQaXnHaFRSaag4sKtpsn1LheSZPC7B22t3dj7ZwsLTyzUNSXfZz02RkLgV9OAk5htEFxpdbIJA4fFCyYajZ+vKh1vXEbkNsCU8c40GdO+U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8DlfgzcEEA3TFPGdiXC8Q9zjjvCekS8Dr1odem9iAw=;
 b=cqJh7HERDRZfWiP9BeAum3tWreaozE5JH3XDPl0aJbV7doPigzdscq9kLpjUbp8hwHf9jxw81MdPXEw++VyDy2XnNj3rKqhyMkVhl4oZtsf6utmpyA08CJawCLn/P5fNWGW+ehgscqTVzsdoYHY5SYvJAWwsVVfDY+ft2s6fIbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 03:08:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 03:08:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] dt-bindings: usb: usbmisc-imx: add i.MX8MM usbmisc
Date:   Fri, 23 Dec 2022 11:10:12 +0800
Message-Id: <20221223031012.92932-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223031012.92932-1-peng.fan@oss.nxp.com>
References: <20221223031012.92932-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c76ac03-a2f0-4c5b-2fbd-08dae493070e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZThk2+swZwnbzKTnX2wcoKaQeB1oxoCijbrj5XJPxoF0AeF9E4fyWx17OR7iQ080CUnue22sohKRGo45E78cTkcrXNUF58L77DjmNgDvI6qScM8kHByfOrIbYzbXcuaPRJ5tU8RFSW5skv9Ln/MBji2f3WCALPz/9gCKBXUgy+y1NwVgXssWbohF90z6uIbcf2IRpEKQHA/s7tbTDZDiS4jcSQgh01owI6ntDTNJdEXyRh0ZuGDYtFFTUAvNYnQbACxCEIYcCPNSMhHVw2P9F/ljPC6k+p0tuli5iOyg31Fqq+xnGN5UGVIQuYsgI5d+MBBiVmYck8VVYENMCeRMVm1Ad2LOJ1g69ueY9gfkzyQMutoVX4MbQ7GzstkFrQtRRr39WNpyIzpyinJaEmZQqoCYOaTL2YgwzBnntc4Hzg8mu2xI4Fu0b8btvJfJ6gX7rzcjYXjMmsg8S4szhTrpgRGV8omjBSQfmCWISdP3MeNopr3nfP1yYjThkBeiwAgq2CMF5F640YcCRLsBQZS+59yAe/erkEl0aCKetJ3249/Px6Jravl/9TfnA/FTs4kkKzCvJ9S+myIcub+eizwivdPdV555NSkJE2PwoEOus5QS58CzEulL8PQxeMkA3GB56QlxI/iAUGA6BZpyD6aRM671+fsNoCUN9/1PLjHTPlkfu+23XYiZNwJOlF/gUiBqaaRAFeflc55jBisylx+jLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(186003)(8676002)(7416002)(6512007)(66556008)(66476007)(5660300002)(38350700002)(4326008)(66946007)(6506007)(6666004)(52116002)(8936002)(38100700002)(83380400001)(86362001)(316002)(1076003)(2906002)(4744005)(2616005)(41300700001)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKWtLkJ5UH7BnQQ0lw6rd+WFxC5j7HLE7WdZanWm9cgLPvcIgZkHIfEhoZef?=
 =?us-ascii?Q?/565znoF3fSSV3Y7myPpexX87aZZP1jQ2c0r6LFJCzaeUJEMXn//FLxzHqrk?=
 =?us-ascii?Q?5azhcAIovSqEZXMC9dhI91mPRa7BZvJ7ZexxHZWafQXYNBNc0scsBEe6j1Jf?=
 =?us-ascii?Q?NOUAINjsNr9dq//6CnUb8TJR8CWeFG5ff4DtpLE60M8LyrUG93ZM0ASxKFmi?=
 =?us-ascii?Q?Py8eaNnFYqDydUhmsLqYvV5tdaQD0VRl8stwRE/JxpwOws9PAG2/RQGtdPiz?=
 =?us-ascii?Q?NQkxFqf7/+FixWNwUA7B/Fm9ggPlO5uTwaEKusOaIRqbGOspkM4EDMLs54TP?=
 =?us-ascii?Q?B2qJWy6qMyBEe1nMNU6maM6aJkzl96RHMNQOeaiWPpLuz3cycUz8h7cIyJy0?=
 =?us-ascii?Q?9QtdK/ssjAlWixfvGwOjC3ekfI7rQM8q7jXu0FNIPKApyF7+PZnmbyjBfBMG?=
 =?us-ascii?Q?3C1LRWV6FnNAiS/rRvFXhQPqMv8ZkSsuEyXZWm1itRP8Dfr3+THPkBKejzwH?=
 =?us-ascii?Q?to2Pb/V42a3bHkEpP9iRZYPgPEhfDv4PNTZ4L4VLrovjzbZ4WinApuQaRwSz?=
 =?us-ascii?Q?kyzUiTeIhAL+8AZEAND00Ob/3hetXNUeb1DOKtQNLiNDuH4b3dWPd4A134em?=
 =?us-ascii?Q?A+J9m6qgkLIXn8W/8IKs3dHX4kLUZWIRMvgFrApQerE/SDp0MeFBqPLqkCQs?=
 =?us-ascii?Q?Nd4/ancMbB0Wt0uwgdoHI9/qvYl7LP5h82ABmWV+UywD5H3C3GWuCtxDpBag?=
 =?us-ascii?Q?wmEgg+VU5qOdF2ZtbGZS3QIoQa8M7hrfhCwQJ82CA1ojHqB3RJmgYKT8OqrO?=
 =?us-ascii?Q?3yr+jJsSd9MuFgUq3+ha0sKW64FxRxbAZRQ/+waiamqVcEg++czAOqKQpT22?=
 =?us-ascii?Q?NttfUs7LfojV74MZEASC5d530DjbJXzz4WNhFiHHarjt78Hsx7ordswl8ikH?=
 =?us-ascii?Q?R5d2HXxO7z0nUkmpCGBpzPMzFuF83ffy/FOQFBLOgRW0MU+ZaLUAPcm/mk1W?=
 =?us-ascii?Q?msCLgDUhhP7DJlTR2Pu7poetbQEjv1nCq7XikLJZFb1aqYufFBuVXADRmdua?=
 =?us-ascii?Q?8UUhCUP7xTwQrHSzTb5e+qONS7Ia7kaSTokX+ZzJrdYp8Ndv4eYhdpbqIs0p?=
 =?us-ascii?Q?epucFjsR67Rr5UQnlnS6Al1xP/mhGrY4hiRDUl3LdTUsTDjwHue9dz2G6o1/?=
 =?us-ascii?Q?n+xaQ37VP6H6wxhOB/TtUMFl49eq1OOFrqgKjVqK4svwmuvc+vGgJvGppZEW?=
 =?us-ascii?Q?Uw6Uex/NzQS+jparfr/GicDPN+iBg4ZZpJ5fDMChQC+ePpBVYl1kKE9I+1B5?=
 =?us-ascii?Q?hW/pFqF7jUxsXTU3T7EVu5LcfAuyzFteEe3g7umghSFmZ99xstpF2hpS1Qm5?=
 =?us-ascii?Q?mHbIkTonR6WxudgnRYl0u0pcziGRREM0lbnKuyZG2bhBuv3AiCyuoRa6g60U?=
 =?us-ascii?Q?FHzw/L+7VEOVy78mHB20rBWEymqMjUSiAIsU84XqaBduCZ4zMfWZZAQVQ9cT?=
 =?us-ascii?Q?fnhHW7fl8fmHgO511HaTqvEE6qJPj0A21+1KkLkvI7Qkhn4JT9thFi/53pGl?=
 =?us-ascii?Q?2DGJMdkuDwBHkFvxkzqs1sBQQqpZ37RG9ILRnPAl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c76ac03-a2f0-4c5b-2fbd-08dae493070e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:08:55.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5n07yhN8I1ApADmt4QkiIpa+JirfSZmIyNKx8gBC7DLTXoYBLlafRGf11Wp+YeHrcuzeqR9+R7SjuSwKH9viQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add fsl,imx8mm-usbmisc compatible for i.MX8MM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

I had a V4 patchset to convert the binding to dt schema, but we are in
the process of ARM System-Ready 2.0 certification, directly update
this binding doc is the easiest way for now.

 Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
index b796836d2ce7..29b8f65ff849 100644
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
@@ -8,6 +8,7 @@ Required properties:
 	"fsl,imx6sx-usbmisc" for imx6sx
 	"fsl,imx7d-usbmisc" for imx7d
 	"fsl,imx7ulp-usbmisc" for imx7ulp
+	"fsl,imx8mm-usbmisc" for imx8mm
 - reg: Should contain registers location and length
 
 Examples:
-- 
2.37.1

