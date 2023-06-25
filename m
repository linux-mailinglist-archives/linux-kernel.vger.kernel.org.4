Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406873D109
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFYMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjFYMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:40:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554710DF;
        Sun, 25 Jun 2023 05:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRRfKyi1AgxvSRO2XL70oS8J17m5UBvjtgsZCMPkmDSWNKO3Yi1Kqk2F0clfMTpa6aSwmU1zfb4aoG7pa1eHX+V5NFSd7d2qNEOoWUl4sFvfkXBd9TzozLaaBzQKnTH4YWECRhBI1E1aR2JtnEVR0yPru8/8Nwj8Ub5ccBi6RtYFW+sFCk56Ot9ICvax7dW7oHN0XyqyUBMNVgdJqwFuYN8/7PmJjIkaXCqQBGXT8FX5TaT35E3VjonZMN7Wmr2/CQCKI1V3IDP/6k0g0o/qGXcpBJZ0QnDJGVfh6/n3uoF8WjYye3GzAHccEq/nffRqA9f0GXciSN/bOdRvvyI52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qA/qXiWi5TRwuUnrp1Dps/4yFIie/oDJS8G15Gwk7Y=;
 b=f8H4cvNgfbnYisUaUN0YNbb+I6yeMbIVjgvdt6/kH6fqlAKy+O1r2QsltWmlEqbUj59zSSb/knZDFTu3MbP5zW+hbyXmRNrz1pEsy89k4rADayR51NvSOPJtmpBPTF75XdvU6+gETEJdbRZgpDQwgzM0T9NIJ9WKCCmhCOjA/rcBGzWXtsQblrCS1Qr8uBXM02VsQt5pxmY0d1oL09YcO168UvMDGja8vIjt9Pm3a5eX0DaCW6f6vTLqV5gFIazYrWCkibYbwsax1XjhxLIPl+X1PpVWoQIbi5XVDIYLJoyx5LqRJ5HR8JHeyzX8tGVtAcu8n83PByts6j2x7BGmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qA/qXiWi5TRwuUnrp1Dps/4yFIie/oDJS8G15Gwk7Y=;
 b=FIbyMxysC0D03cF4Z/eT2diF1JyM6HpOQR3fa8jOtv85YvrOKlfTbVcBDDXPVLaJ5sII838Bhj6vtaqaQieuHV3TDpG02s+vTPclSph7l/KAWiGqe+Ve2SgsDp5sSYlkHIk0oCYdVFe9SczLs7Tg4lpPLgY4yNkUZh8Orf51bBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:38:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 07/10] arm64: dts: imx8ulp-evk: enable CM33 node
Date:   Sun, 25 Jun 2023 20:42:35 +0800
Message-Id: <20230625124238.4071717-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b93277-e71c-4c86-a2cd-08db75790b3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgsOZdhbKrfmJfrZShhAgmCiQL3/GflDo0d0Rw1FyZw6yzTyuH0D13Q3TzaF749XlfsJs2g733bGyDpH9P2jUJ53Y7k+tQv5fLiJqOABJHiaMKhvQAQDrxrH52wemF9evpFgYhGk3zVkMZ+WKjXlj1/UTHIt+tCFbI5EBMAu0SLLcCOp1rr5hyxMKVkSKeGnbnhAk23GfxkOVWS4iwahk5slKMSsQGSUc2XOs711K/VKxUA4FuIElEzRcBWoOLkl3HU1ZePhzn9q/1BOYwf+nZxw1fYn75EbQeMCrFGGkAOivVC9Hpr2QP3464dpq0C7kWSBbY8EG7Tzn2VL9vKyBsZRxLbmtjKXWdePKO5qR9t0n8sxNES9qRjBXm6w1OeEKJ4M/6URzGx+hJWahD6x8iFOBwxlBVgVyTyYTMJiavsl62PM87oGgnp5uwFn6snxXF1EN336wWV2SnOB5QRKN3igtpvTYtesx85PCZMrpeR/Yi6RDLRaC6kw62HDSyp76m6JjQenaPflmk4/srvKsl9RDb1UtN8jj89C2W6AGfUw/VHLCwTIIX72nSPHnCYt0a1g755E7oBm6OYHQV3i80fac4JxZw3FWWP/mym+Yh7/vEoT5smT8SHosBVOqfstz7z5miwICmtOfpV4z4dMoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?guFTctsoKlZlUuyqvm1LkgNEqGxaqCqejJhsAqhgpAqFhD91hkaa8EmPcmv0?=
 =?us-ascii?Q?baSEGgzrBXtaXwAqHUPn19aYv2GOSLTqn9N8TzW7+NQ0m/uHCXwIjZrwrxDK?=
 =?us-ascii?Q?Y0SMo91vpq+M1xs+9XR7pFl9kLPIVSDkCCsjVEKRS5nHasQK+BRsJ2gRvRAm?=
 =?us-ascii?Q?jbtkFfsRmEs3QxQubeq3UTHMRXwIeQeROSj/RAEcmaOS7x2lL+npYCvoLxuh?=
 =?us-ascii?Q?HpDfuupXQGzTV/yEZRKQoVpXd/IUtENlvNhKgDObpLJjMFiOvzyI/pvClG+c?=
 =?us-ascii?Q?rUP14wr0GppC2meR6dS4AWLVdgbsriIkkqCPDjJPi2ICjILo/gM0mQ6AiWlh?=
 =?us-ascii?Q?myGD9cvC4jJXfJH3/YkMWMgTwYa3ZRxgal4tkvRo+iWIEX/uqi8i1rnUyPaP?=
 =?us-ascii?Q?xdzg/4gKH7dDWzILYI9S2tWP+4LVDNT8ThyiT1QtgJAVwOPZCnrkOgGcdZ0M?=
 =?us-ascii?Q?tvYS/0gzPJ0iKL/FUO7bMHbBea3mtJ1PbIS76v/sw3GIzTCKviU0XSflUDt3?=
 =?us-ascii?Q?D4G6yCDOxG3XbPCsbOrZHGbUneiahakYxp5gpMcZJ7Fam0v4G28Ep0Y8by9W?=
 =?us-ascii?Q?WwvFewxzsG+bLq5PCt+DQ6I/FMa04aDCpZGtM1mzwLvKNN4eUmYPSLyp97gk?=
 =?us-ascii?Q?kZDAGaxPwoDHkLeZh1UZvuoecrDaBd729HTq0CE44RFOg3ayvYlSMPHwALyt?=
 =?us-ascii?Q?UFqZZCvqYiremln0cFXIyQ2OOqHexOYuK3qVTlqZUoz3SpOVrpqDGLThLCiR?=
 =?us-ascii?Q?a2YTlLNthA5bF604XHpVRlSJee0QaPAHakE7WMf0dXiXeb5Sy2DQunUMa+c7?=
 =?us-ascii?Q?gvGhh3q+QUI1NJDn5aH9FgwV5t9n/HWf51JdCDPwnU+D2+Y5/pxvXrC+p9Nk?=
 =?us-ascii?Q?HHfrZc45oLOsNOh41UwzpLv0G/tAJn1BZ/HJhUpq76A5e/Uk9/RSNPSItGGj?=
 =?us-ascii?Q?zgoEaR4YND1RK6QkAnEqoTUOVeaEzob5hCiLNXq8qpqoCuHf+LX5RU5dSs7/?=
 =?us-ascii?Q?kN5dARr9BbidSyQYkFGjP3O76d8/gp/cIVBxnyjDBxe/GDowOM9vIEXqZjiL?=
 =?us-ascii?Q?cl+/KTsuFT6JVa8IkOWxE7yY+9UhnqXX/lOTl5543iDYp/ataNfETab9TGnI?=
 =?us-ascii?Q?KnNjf3EdFQz9yWcUSno7Y4In9FWV7UdR+rdX/xitY+NSlxj/F51NtX0/gRkg?=
 =?us-ascii?Q?vYEXL3Av4Q0BMtRthjnkI9/9lbz0jO+b4ybFN0p+FSBIfo/0JgEhXZ8p5y0+?=
 =?us-ascii?Q?peAB9bGrjHIRv27/wtzSkrzB8VF/9KJNC99870l6ZrnMuumIuCO59Rho/dQo?=
 =?us-ascii?Q?5LQSMOEXLp1tbI3WDcCEMdOohbSa45i+9SmS8jusmKrtMKIBRCMpFPNPPT/c?=
 =?us-ascii?Q?Ls9EN9yVt3zJAvXRLkmMhHx8JutR9oiJH0y8ol+j9FyCoi1AFiD6hHLf8lJA?=
 =?us-ascii?Q?AMqqAwdGwXes9H3sUEad7WyXsnAx62sZ7i4U7sZgI7UFGdwJuo7CGH0pQpcz?=
 =?us-ascii?Q?Ft+MJRI4RUsU3fjJduejN8/R+e2UlRjDUhDFyz40Qc2tCRmDdymXxj9UkqC+?=
 =?us-ascii?Q?N1zwyegUBZDXwWOJGOTD10+lZVPoyDRPN1SfxINP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b93277-e71c-4c86-a2cd-08db75790b3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:14.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNPV279yDAEYpcfBa5qkV7eUSfDFyJFraevLv69E7MIgD4+2o8tg9NUzgkaipEF8z4yKm7jxs1l1UkcWn2v0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable CM33 node to support rpmsg feature. To use rpmsg, also need
to enable mu node for mailbox doorbell and reserved memory node
for vring, and data buffer. And reserved a piece DRAM memory for case
that m33 images loaded in DRAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e171390a1888..d66e31cf83fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -31,6 +31,42 @@ linux,cma {
 			size = <0 0x28000000>;
 			linux,cma-default;
 		};
+
+		m33_reserved: noncacheable-section@a8600000 {
+			reg = <0 0xa8600000 0 0x1000000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@1fff8000{
+			reg = <0 0x1fff8000 0 0x1000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@aff00000 {
+			reg = <0 0xaff00000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@aff08000 {
+			reg = <0 0xaff08000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@aff10000 {
+			reg = <0 0xaff10000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@aff18000 {
+			reg = <0 0xaff18000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a8400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa8400000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	clock_ext_rmii: clock-ext-rmii {
@@ -49,6 +85,16 @@ clock_ext_ts: clock-ext-ts {
 	};
 };
 
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu 0 1>,
+		 <&mu 1 1>,
+		 <&mu 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
 &lpuart5 {
 	/* console */
 	pinctrl-names = "default", "sleep";
@@ -92,6 +138,10 @@ ethphy: ethernet-phy@1 {
 	};
 };
 
+&mu {
+	status = "okay";
+};
+
 &iomuxc1 {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-- 
2.37.1

