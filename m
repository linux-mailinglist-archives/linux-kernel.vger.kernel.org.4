Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC21A5B89A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiINOA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiINOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:00:09 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB81A83C;
        Wed, 14 Sep 2022 06:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr6NSevDvto/KXSvE1fyUa0YD8aDUklwQPGn5sPDCJ3flSwL22N/1WB/K9EB6lNtzFj0hlN9OmNwSXw+A3PodtnwpGGQJzD55xrsoiPmpE+/ogVjZkGuq3ONNs7M/nUcy/n5cYEoyZ2i/yINDsB5lyMNBNocJJARsrYKj6+24x5YkehyZiFuE0kTZdfXtvhXZYTj77F8H2AYsDKkHJqMv5pDBwa7d4SQdb5sgZOd9oMYoCOO8XFxNz7LaL0p+W4ccSMETOfKK1PXgbxidfcZCTKvuRCikwRxrSN8mmR67lpoMlRJ9gVSBXw+nSEpmdNAoVdP8RN9QOF7Nodm1jlBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=BnJOXzaOKZF9jDpbKXDzV2pbVxIR0iycy/Q6JeHfgXTcf1+8tNjP2hbiB5d+3pS4n/S6B02T7ar9i1NzULXL6MejjGci3mtVu6pUMq+selANwIy049v6A+GT+sXxpID75WC+QIfsLgEEeV49p71g2ECHK68FzISHor5GXsINeMataIKOcXakzlf0ICy/sac/uiq+04Ux5aPkgQ575dKi4SdaQfu+aXVuFj9VJv9Brz0Hpoczo3gPtJjwI5Oj1z3PzHG4ex45ca0qQkBQbvNDjD3Admos9Pwm6XIFwwrotXDMcYp3YvgK5wuQP2N180nPqKEfEXRsZGZQ8hXGboC4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=dZDxqL4tei0eTkBl9TeZ6DlyJYB45gzQKxP3GwyJQOX8+HS5wuB0bh9bGilg9ApbXfYDOmMgQpKiB1OnuFjXlIHsHf7fo7EgSH3RZ/wA2dCphHn0SwQTDgl7Q5ixEhBJ11wSDoMsI5bS7Osw8xBgK7eiUJc6kaJZvNIAlI4dzSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:59:47 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 13:59:47 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH v8 3/5] arm64: dts: imx8: add a node label to ddr-pmu
Date:   Wed, 14 Sep 2022 08:58:46 -0500
Message-Id: <20220914135848.118616-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914135848.118616-1-shenwei.wang@nxp.com>
References: <20220914135848.118616-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44)
 To AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9176:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f8d30d-e7bc-43d2-3a20-08da9659623e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN9YntHmhY6TTIswEP25lwZ/OQLYmjx5IqSOl3OfMijjtAeLDH9d0h0vr+Eln7XIpVBlpU781HC5Hhrp49MmqJH8A+G1JgYXQaFXhL92QMiJpVaSXtM3j5MtOHAC+5tzbkKtv95cGl+g3S+5sUOyBXxez5JK1vqgF+aiR2vQaTWXEMVUJ7jvx60XF5CT7OBquHIQpzFqibakvyFG4WGCfk38n15L49uleErejBdP6efp2iuuDa/YaOonqcK92qGJAAkHV82hfKr6bf2i3+gdSAXrGFdGxFNb1kTzU8nlViuFFhKQfqvYHFrYdOups0/Nl/jJsCR+8RcD9Haqn7hhF2bCzTNitlvVWRt4WNNhMHUiI70Zv51cuqLCJnB9cEfWbY7OXJt8cWOP9nbiM0SGwpjxeSXf1kMzcm4/Q4+tW4JNtTAOC89y+4PRR7eI95DegcqmPUwJTZ6ERSboSPBsivZ8WFj3IRGZkrGIOWVdRN8AUXLr6bzUc7ClYTRvKTbLq4o6jtTRvVDjh2m6lGjB2HtlgLZlQi3yHm6sHFuuZdcO87rpzxMd9PVX3ZaR+V6rcs81lY5zEM+nvAw65TvPghhtF4N5P/FEumvB2vzLCgd/xKNhP6SP79gbZULKGrMoUGkjca3lZ8HNI3jSxnxVYWWWH/YDYP15KV2ekGi5aSgVcfawc+s/Zof6sg0ioduD+wanNZz9hmRD7tWw/BaMgrq3OR3HpNinW2Pj/DjamyQFy5LaiLyjt4wNCfkPZSnHe+T7QwGYI/ced8VDj6pB3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(38350700002)(4326008)(5660300002)(7416002)(66946007)(55236004)(1076003)(66556008)(38100700002)(8936002)(8676002)(6486002)(186003)(4744005)(44832011)(41300700001)(66476007)(86362001)(26005)(316002)(110136005)(2906002)(478600001)(54906003)(2616005)(36756003)(52116002)(6506007)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECFHUGbQDEicwy7X9TQGDev+ozl8JBmHIWVaNN09qfyU3Ui+G6l/qckBqzCt?=
 =?us-ascii?Q?bl6fGDCbXMzzUbu/c7lciB2DCo2y0Ue+ey1mlqII/VHoDUwBRRvreI/CxMKG?=
 =?us-ascii?Q?5dgze9T1eQBgkqEKgBIwUoKim42f13RV5nxTV9LzklH1Yrw7NEM/gU6o3mjm?=
 =?us-ascii?Q?Nf3ysqgpZPTK8mjM4yAZ2qfBJ3EkU2X9DVbEaImu3MxTxYSf6ekNoJSX1Eob?=
 =?us-ascii?Q?4rk9pnn7E5piX2nM/1Sxn8qwQih4FBrWM2nUB4fMi9OdcEqXlfj+IqnTWc2w?=
 =?us-ascii?Q?lwchr2ZqVXLXTzUZeZoyxReZIwHgqizfPp+vhkipm24Np+HEWEKuvEM44vnX?=
 =?us-ascii?Q?lLmt7qfcsw/hYq13WMmgADDFzpI4jDJsuJeNTUdjaD3OXMHKwLYZXlFNAXvw?=
 =?us-ascii?Q?bvxrRPCNJasBJeWTTWf613TcbaRIBzG9u1rhf9llK6KYz2wEsDfHKs/PNnaY?=
 =?us-ascii?Q?t1EySMcCYVBmkaWUOgY5WjCqdHSlYMDUYP+MpU5LT+/l9XEYUKrVKH1iz7/q?=
 =?us-ascii?Q?XF0cv8HEQbz6eG3F1LYkIujOnEk2Fd3C1fT+HIo4fh2XPzPdu8WHJ+iW/1cl?=
 =?us-ascii?Q?QndqW68HGzUwLnfJlCPm8zGC00mZoXw9XwnlwgTchMVESg94XndSZ7oz5x06?=
 =?us-ascii?Q?quwh4NEbgtRJk5X2QzezJcS8jUZSbgSJm+qCyJZOKie+6OWUcrbgbVly9dP/?=
 =?us-ascii?Q?yhrT5z9F+CgeBN+Sv9vZSW6HeE6rTrSULPB/vYrG03H2nzSzO3Lnn5MNzBMW?=
 =?us-ascii?Q?XMLnkBYCIEp8KdW1hgUvs7YoKmFmOPlcoVniVGCqcmFM8pm41AyWmmmMYbqZ?=
 =?us-ascii?Q?mujvnnkTdksTwz9uc2w58pZNiBN5Ue3ClecZevQwgAATFMYsjvq3qUiY3HQ/?=
 =?us-ascii?Q?cCN2WUOnpjav313xFEOVmyQsDF8YLJ6kUsjU0lCEa0sPRuWV30K04Zk53Rn8?=
 =?us-ascii?Q?WGJXgAcBdbyPqvLYB1cONaDUxUHD0FSllvIIfzg38fdWeYJ1dv1SvwL0z7eD?=
 =?us-ascii?Q?2BcPHgXfBUZT4jkofFuP4NQeR5xGE7WHMAeiPvkD7TDcBiqB6HsiyLRUmd+X?=
 =?us-ascii?Q?82gROuoeOTcUByyfgTj+8MH+rirFpZD1jODK36/Qdq1NGmpBku0lUY0wXw6I?=
 =?us-ascii?Q?3HaqbsEfI9/HeO+0PK8o+i6sDpMPxNJru9oA5xMpLQ633vdCBcZwjm6fw/Fl?=
 =?us-ascii?Q?Knq0UViBIpH8vLkoF6/AwdukwODBo4SlOW9Kixe1LT3an7AKVaR4gKVolDl6?=
 =?us-ascii?Q?MhyyquEip71kYqaWmm4i17zTUnShCkJH4mqrmLGmhofx8p96a+tAOWwIOCB8?=
 =?us-ascii?Q?rhTw8nwe9gUaFSNYmwZzQ19PmXnlS09/Vmuq2PMcRbmqPpSuTlkGR4M1KQm9?=
 =?us-ascii?Q?WfB+4HqDksfAZ5NjsTHcRn3n+QR2ycGHRIGCq7hCdfKCLyFzA+xF73ZTtNdp?=
 =?us-ascii?Q?w4yxTcTDEgUAuFz4rbH1TSAXdxsh7Fk1Agp9zq9X5ENKS7zsuUBkth5dhORG?=
 =?us-ascii?Q?fWJOgEUxqmgl+o9a63xss1gZpl49tP8kOSxzHVfFI6S1TRMlzhLAZMaxuB6d?=
 =?us-ascii?Q?0y76SK7DZdAPKp2obs8iKk8ravWy94J2ON012pkn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f8d30d-e7bc-43d2-3a20-08da9659623e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 13:59:47.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz3Q3Wh26nVOihx+R5zC5KNxAoBxJpjo87ha5SGuzcbrzzkiMxkjdKjp+gYFPE7F8bElPG/vJKZ6NLTUDU7SQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ddr-pmu on i.mx8dxl has a different interrupt number.
Add a node label to ddr-pmu so that it could be referred
and changed in i.mx8dxl dts.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 8b5cad4e2700..7d5183c6c5be 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -10,7 +10,7 @@ ddr_subsys: bus@5c000000 {
 	#size-cells = <1>;
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
-	ddr-pmu@5c020000 {
+	ddr_pmu0: ddr-pmu@5c020000 {
 		compatible = "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

