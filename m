Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3A5BA0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIOSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiIOST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:19:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E19FA83;
        Thu, 15 Sep 2022 11:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXpYP39nqcrjXq8YOHT1pFDg7yPOhgUPeXG1UGiScqghywDq6E1KFwTkClTQBSmd4jk4x/fMjLp7ySSPMLJuO7NrN/SKUglRxj/oYHQ+OPvry1z8d3ecibiWdXAWlRPv8vDpHwWblobu0FHDg4suFuSHtM+Q5jr/xJb5QWJ1Jkx2ubtEckqXokFs4GTt+7Rh6PWcgIoyShQPMsICOkHTODmD/YNf2dCh+9InfQfAcnIrZvn0X9ns0SIeX8Ixef0b/YvJLANHapzARar/WPQFxyllB3WXzIAG3pJsq/z+7oMfKSWntkVCvVt6T7Vw4iZkMntAJ8dADZ/71d4OKT7TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R32mGIv4qJ4yhb46PF3+ELONbRhPx5WWN6AM/T2ppI=;
 b=O9KTcsoJccB8dti8rrJkrgMaAQfdMoz+a7A+Nz0lcNrZH3KMlA5qGv3jBZNGPXQk6ROhHcpbStbWpkqvbG+iPlN4EPTUyaQaf02M6yw6O2YLmiSfmEBL6t7bzBtSZTymn3QJIb28LZ5BUeetWZ6Hqdr/XC7ObtWWMarqWPBhperwZpkRAFaL9CrsHQZVvAKFBoQw8J0cQwZ/KW4hhZMQaYS+rpRyu9jhHRB8xOoc5AVVjt5LxJtgc4MwI3mNqZhkInXsGY6fNwegOVz3Q9H9qZhYDOO21IJovbNG3NLs8u2wGeDA0gJ/Uj2tFcqRX/ghLNb0DU9vUkO2zLXY4rpxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R32mGIv4qJ4yhb46PF3+ELONbRhPx5WWN6AM/T2ppI=;
 b=mpWFJ5pNmAj9MZHf//JIgZkkHAXRtIppyrL+4tbkcS4ibTiZCSt6l84O9LpKkTmygWnmece1n4V/I7tNzW9b4yIjLyao8HYhuRgXoYd/sGtCgz81nCEP/ZFQRIf7NUQ+oMz4JxCcEF9jahODdv6clYyPEUQkPGWkU2qBqAgqG4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 18:19:01 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:19:01 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: imx8qm: sync with SCFW kit v1.13.0
Date:   Thu, 15 Sep 2022 21:18:05 +0300
Message-Id: <20220915181805.424670-3-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dad174f-db92-4a2e-11dc-08da9746c367
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPmB8vyzKuh7ly98bZAJ3WAZhEQHghZ0nvhVkgEL0B9mY+l4T5snFY0aERNenURBw1zrhcUrxhDaMbRZNf1/wGIkAmcnH6L2THG6uqKGG5ikbSTocZkSczQwv02r+lnqXQIB9N1STc85EwIADvRR5YZxFif0Oi7wdZpJPd/Gq8aXfd8FptfDJeNaTmJycEUn6zkSU6vYBURBKxxdT4X5UOPUs7uv+kXoTqCEcR8sJf/Guc5Xb87pGsktTxvkfPgCZwN5KcrtIRpVjNKlHSZZbsKo7pO33GbnJ7Kr/p/J8K9gil1Vn6DJXYrQ2TM/Y2jlOSUsTHcmMg0PpntYoFAH1vYMS6ijz7SYXtRlxF8ru5drQgfN8FFEFAVbMpO3l1Hn5T/7oqF+AEGz/2RDPYRNEKgMWtXuDwTktBgLpFTdN0i8L80PvOvyPWJm4K+0unwrV3opBNM2cnyLxZohNct1DD83e+SzIpIxvYs1c2pjUaiiC+amgb2MpYEvUCXHH7rDZ5Puu5CK7Ygdu3xL+rt6t8Rbs6O4SJUKBSNqvBiwbPA82Ax+yKO28g1DxNK5WD5e787arNX842r9BGbRHCdc1plovTgjNacpd2WoIYtE/ZtJ7Lcj6whM1NFZGP5pdZi81oyPvhVer1TT6XOej4LqfuOO6dMbJWccpBWMLyDwYDJ9kCYG2i9uHE82EBQBpbOKsKVh5yw05CkcrvPYZ5ovtEpjApgE8AO6cCxNFkdtQ88qTpfXSGcM54gl00AtowdELkK4fXUcbadC8Euzur61w7qV5zDnBkjtfEmscGcl/jIKmZjxZ3wIkGjIWJ2PflDTU9l1u9Q9nA4AAZRCnOwiJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(5660300002)(8936002)(4744005)(2616005)(8676002)(966005)(2906002)(921005)(316002)(66946007)(110136005)(41300700001)(6512007)(86362001)(66556008)(38350700002)(6486002)(66476007)(1076003)(6506007)(38100700002)(83380400001)(52116002)(186003)(26005)(478600001)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cmFmwrNqbGGUY9kr19eYqrUNwXomH54kZkXmZ+h5nDsJIS5Rz/a8uF8olz5?=
 =?us-ascii?Q?I0WPj9G121hP06FGoKGJGfsZdjBseq85iTBYgf1kYMHmAZu1XCxnmtKYp8u2?=
 =?us-ascii?Q?q1P5iUC0DvVExq6JqRmSVq8945qMs+J9X7uT6MAfwuDc7gJL/mL1b4Vid1ab?=
 =?us-ascii?Q?qESgrc8K/So8qqEMyV6hw4gzygZ5QLa+YY8jjWbOOytJBYVzXT2kDkTE9cDz?=
 =?us-ascii?Q?Tq+ID3o6sc+HkVbXq/Ob+iX8eF8wkqejmjko7jxmoU8WhmKC/RVcSpuAI2gR?=
 =?us-ascii?Q?1MDfBc3roimbzoTDLQOjUJ0KdUEPkcQF2rksusHGxdp0Lk7BuecSBW8Xnmh8?=
 =?us-ascii?Q?INBbshkQ32CuVb4+q28rncJqxtTSmbIN9KVLq+p5L9j76a32IkGxv+RzqNCK?=
 =?us-ascii?Q?KzN2ngRu0iXMVh0UNpWWERKnGXlYqALkyiV8cgOc5NVEGM5Qfu8JTSzww0rv?=
 =?us-ascii?Q?xsHxxgNVnDGUjv8KdwRdDXjUW58ia/Kzs8P/w9N1fHh2+yYnVAjqqScYKkba?=
 =?us-ascii?Q?+bkyA9kVgxwLP7gNzduWTpqlMXxauJLH7VewNd/3ws8uXwOyck232kqzxAYG?=
 =?us-ascii?Q?uy6J9yklWc4ELad83f4z+ZRY0XAkTLK6DB6iezcQd0Y2I3F074FLPWxw7mU7?=
 =?us-ascii?Q?YD7+QGwy7JCSjPJorRPj4YmH4U/8Oy9/JxLQ1/i+SyqcbT2OSI6yCOknIKGd?=
 =?us-ascii?Q?ZwxDnusdhtkyAm1dkpkFAMMGOmSpQNNYhGsLiygJ/zPzEk1JKinWkFWgBPrC?=
 =?us-ascii?Q?vuLrsRquewJxQ+J7/0i3fTm2WeMsXHvOFI5DyMMHf+wTaKzZYbGVjZt06+nn?=
 =?us-ascii?Q?nz7CASK/VGhQD2gJ8pZzuEAf226ALa9DU7TX1I/uLtlzPoHJejg5h2gQXFpL?=
 =?us-ascii?Q?Bc+8iw7QFCODYpt5XzDNM0ovUNnazvz23UNK7hkOtVKlApVsLrU6+19x1rRp?=
 =?us-ascii?Q?zD0B7JTcv3IuHjoc3VTuj4pHOtX7MTNKXDaQ1+9/WPfByn42EEYQ9ErFmK43?=
 =?us-ascii?Q?V456ey1E0zZTeuUKumz++nFVzquqWd5nJpitN2RpuXusjLx7mIuFkpOa8gXl?=
 =?us-ascii?Q?nnPSOkDkdM23PMJi2jPXmEannVJyNvyLxwBacBzvAx6vtw6RT4p5VlAASKZa?=
 =?us-ascii?Q?mPPUN26/LxrNyj8TZK6MhY3keHTb0TfVEGZ0v92PoX1kEnXUvebzFpD+RFcn?=
 =?us-ascii?Q?NUG8QuTRxCeMohGaS934XaEm0evUALPXMLDKEaQYReDS+FPaa04UJphuTXR7?=
 =?us-ascii?Q?tD9+a4rK6GT62/V0LNd0sxHM0R52kWoB8bfnArbw1XRZT/p8o6hq4Wp6e0+0?=
 =?us-ascii?Q?BnN7oBunsZg5393BEOSXwsglJQ1ty1ONde85ao3FPemvQoMwvKHrlJF8dJ7w?=
 =?us-ascii?Q?Dk9U+PvLg7SPxAG4jiNC8cKVZiZqDivgJEd1YbTPRVPBaNHUOdwB/zLs1gIR?=
 =?us-ascii?Q?iZzxHZ9+ZXpGbvx7+vRKk5g0onbEGRFeZgAK/3O0rNzR0y14OHM4G2xkcne2?=
 =?us-ascii?Q?GFC+Xz8q0CpumFt18F5j3lS3Bb+Av15fZSE8skUsPXrFJCM1h9ttYhj/W0/9?=
 =?us-ascii?Q?cToxR2b5j+KLRUFL7wmEQ2Q9hRor9qPyGlJL97kB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad174f-db92-4a2e-11dc-08da9746c367
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:19:00.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXZ0lcQUGF4sngxOc6v4Pm1STqf0ZQ5/6N5FunABMrlz/+48oSGR2Qpr4HnExe9DeBujU8ZN+ZAs89n09ttfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Sync clock resources with the latest available SCFW kit version 1.13.0,
may be found at the address below:

https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 drivers/clk/imx/clk-imx8qm-rsrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qm-rsrc.c b/drivers/clk/imx/clk-imx8qm-rsrc.c
index 87e0b6ac027e..ee01acd1a181 100644
--- a/drivers/clk/imx/clk-imx8qm-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qm-rsrc.c
@@ -79,8 +79,8 @@ static const u32 imx8qm_clk_scu_rsrc_table[] = {
 	IMX_SC_R_M4_0_I2C,
 	IMX_SC_R_M4_1_I2C,
 	IMX_SC_R_AUDIO_PLL_0,
-	IMX_SC_R_VPU_UART,
-	IMX_SC_R_VPUCORE,
+	IMX_SC_R_ENET_0_A2,
+	IMX_SC_R_ENET_1_A0,
 	IMX_SC_R_MIPI_0,
 	IMX_SC_R_MIPI_0_PWM_0,
 	IMX_SC_R_MIPI_0_I2C_0,
-- 
2.37.2

