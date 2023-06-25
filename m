Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1A73D036
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjFYKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjFYKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:53:26 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C35121;
        Sun, 25 Jun 2023 03:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnOGqa8f1EheHl9Vq4VDwFunFtVmDN5YMNkbSGXiK7nY7mzGcz4Uac1zFToBAQUpURftO4elreAIF+YaXYzyHQwerZXFL2jLxKRasrGIxtHMX3ncY18OliL/wiuYyfOMSf7jI6cK8a2rNQeRnQaWQGLmEyuzcSEPUwy/iJtGE5Pn64B/Vfdy/ZydRnxCaByIN5i5dd4SrfeTyIti48aFqUQNuh76PUlhDapVt76B0R1kTRSCo4kZgQFMJy3/FHWV8nWHKpTMo5E5Nz2+kKIGFhWYSXdGtTbt/4tOl38cSwJaUZhw54VXz3joxneS3K54m1/caGdA5yD5w88mGE1x9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yASY+dZqUTx28FEahkYBblZs+6xPmJmYVcGPfz0EgTk=;
 b=MGMQhduVVBHZOyCUDAF7dW5L/lPgF23S07u8KIGJc69k3/sHqmScuYVdX6VpVV3ZyOYqCeIk+fcdxKQQpJMY4RjuCR8OGj73EeAGiPlpsIaz6wEiFwv+wt5cspp4jLSqROwWPbgttyRxzia1CSYVlMTrKE2tR0P4V3E5RCqhBwRbwfHfiipX3XfKzLEwueIE50OM68zyd4mj2iWWoFDvds4i66+tF/IsInI9Xglef+xXIoUBDcO/S+94YoJnDhcmGAd94RWcsh62bcJPAIy2/D8WQnh3lHfUg5XFTVpBwC8VEYc2GwJ7+YZH3bE/FbGWf43UIAfuQ5XHhMJhdRy/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yASY+dZqUTx28FEahkYBblZs+6xPmJmYVcGPfz0EgTk=;
 b=P796TU49KYEeXEhauzpdy1Eux5j3FHm2GM4sL/4+98BFu93SLpgxUAPu+zOtims8HAGtmVpeBP9xOsx5/CClHsCTss0NKy+vNtJgMvAtORupEUqLlbQoDHszjXAFxK0/Pcl80vO0J987BY4B5dJDb3rCRxizOaobj1CTFaisL6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 10:53:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 10:53:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] arm64: dts: imx93: add cma area for i.MX93 11x11 EVK
Date:   Sun, 25 Jun 2023 18:55:26 +0800
Message-Id: <20230625105528.4057850-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
References: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7bb3db-b111-4243-ab16-08db756a63eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERQu30xf/JpSloY3l4YTiqtv4QXclPPCaK8WbZN3CAOh2Eg6wCZHT64zciD7Co8IUBUMef/2+KmSlwtpz5bKD02jhRnvrbUi3c/5bHpxuMVofoYkbKhJ6rleeyJBnY2ENA2SJ4JXwJ5ivdL5M1sgOTbW74Q+6LFUaW7XQFwqKK+E5OIrk7YLkaFUQzb1aQxVqvflHwQyNfOb/86BVp9Gn6cEmQncn30DdyY1NRfkkQNblQHNYd+sat/nsS+TxPFi6S8Ff3zdHlEiV9xipC8Y8af72NmEMp7InURRr243fFwiwMP27ceFljhmKlb2rnw0MfyJYqel8Ga5gTmxWsm4cRxJU87pyES71e5Nzd2GW8vyWAvViTkQGBqa8666bhoyGu7sZzp41adoDvjYyA7K26AH01RbiiCxYusqvMlcBURoWC2p6tuOE5If86EfpAM2K0sEzW9W36viWYD8uuZyp8u2ZgtXu55c0+9KX/WWM5VSm8bEq3MWttsgKzTU7/ZGUPFg7OBinn0O4NHjkg7tWdTiPRofdVi6kYS6zolBnqmGWSw7Sajc2OhNUxnYNY9FcXFPBHEDd/vutyqdhqbAPcbVr6o0I5NZUtLpJg87g0pAZPRespL0BLkNoOO1gN+k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(5660300002)(8936002)(8676002)(86362001)(41300700001)(52116002)(6486002)(4744005)(2906002)(186003)(26005)(1076003)(6512007)(6506007)(38100700002)(38350700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8r5wUmjNqS5MJR7E7+pR8QvT61k9o/1nRdB9pF/GRnt37L0EIuawa4UaTit?=
 =?us-ascii?Q?QZBD5uCCoxIWw996v4ApvnkrmNxdxoVKg+56w6rytozR4dA44GSZjsZ1SgoV?=
 =?us-ascii?Q?JSDlzFHQExIaKQ1nVLpFec5I3U3U88a37af0iDVtKa+bFw15+h6XnJPJOZAf?=
 =?us-ascii?Q?oHLOS3vFl5VWPN7k41koB3nMykjLNM4dQctosBs+x9OxZqLiruIrjV+RhYFe?=
 =?us-ascii?Q?0Hg4v5sImAvHAnRB+alYvtpqW7+cszrAv2nitN+bTS6zCijjVDpKWxq0WQwF?=
 =?us-ascii?Q?JIz5T15hYl15JfGV4wnEYD5GdNAPUKFhJNiEHMHUaFfMEznU8unvnr/9sC5Z?=
 =?us-ascii?Q?Ok+6wIc+akzCmErbKaBSkzeidLHFnlHyCxrmN8NAG6PEHCu2noYygiEMBss1?=
 =?us-ascii?Q?8yOrRGkEUDLeKb3ZW1ptlfybZexXwjO5NnweMsGKj57zpw8iQylk0GeFgbvY?=
 =?us-ascii?Q?8aTM3c/ds8uJlN9WpRgxU6oKv1X06NUbbuhbNtcSA2Wai50em4tKvabkSbte?=
 =?us-ascii?Q?rMndGwPVI4xe9tkfjm7+0c4PsMrB+2cLCHjlC/Yt+qVzV4joBP7pIj9alLAo?=
 =?us-ascii?Q?MeSic0pZTiVs0hfjdzjlay2WjkV4w9FLySENKCjUjM60cWz8JEdUrrpGn3jL?=
 =?us-ascii?Q?0dkFLUjVYylaJsy0zwxKEWxSZnasxyAuldGS2BozDFKeNh9aq5x+wllt3Jb7?=
 =?us-ascii?Q?q+KQMMUJtQuQFJCgGkOSlF8CLZ4v5jsmdOXD6DSD0K+mRT+/WZZUhuRnGY1N?=
 =?us-ascii?Q?5ZXoQuaa/ccpUmuf88vZNwO+h/EVKAVrvpZMBId3I77JqITTdrUjkW4slZDs?=
 =?us-ascii?Q?wtpaTo3o1GXcgUoJe8nA0y6vw/zwSSDkVdKHoeoqSZezSZrQqSauIhNQqobG?=
 =?us-ascii?Q?GqlJ0wsrfOVuITtFuBEbehG4g85tYFeLaOUm6ED6tQz2nFX7i9IjTrbr3iNR?=
 =?us-ascii?Q?NGumAC6dwU8lUnyTfNe7/xFqUCOn41UWwS6WtCs0kF8XK6ywsKTRcmThuXm4?=
 =?us-ascii?Q?XX0pJPsyhYa2uZSdm1O5jKAelhHd8yHfQOFkiFpvB8ngWK25kIJh4hbeB4Ts?=
 =?us-ascii?Q?gBuC9PSY0JrfZxWVPm9WWO5rmSTkG2dH9IRIzifAI0hmZbUHgsC4aLeDcOft?=
 =?us-ascii?Q?r79HXG9Dv5y0zvf4jJE65yeOicNqyJ0rMHasu8Z+4/8IBsMat9IsjrwAuxl4?=
 =?us-ascii?Q?/5GRATbPhSYiwA4ZbL3yGUcb3sqTY86D4+RHrXrd/yvseXbkDaxrkqCSOKLP?=
 =?us-ascii?Q?p/WZ1C70IyMtOIQHlHfO86NBYgMmJ/nLQl8HgozTxzC3Txz0reFhyiy7+jQx?=
 =?us-ascii?Q?jpqcCyH5qurxoRjAEVJv+su71KpYu/kXGAo5qoAYhU5VYUNvg6fBJ814vkge?=
 =?us-ascii?Q?eDfXwAJuFYoV/BRdzMy2vzsY4q8qMw/zvFLKlOkzKZF/TjjYpVfnKBgZXIax?=
 =?us-ascii?Q?5qJ8S/3XuRvYWVAPLssE5tL1ALSzk0yLLK5UKuJXU8Eos6kMeLVPFVxn98Kw?=
 =?us-ascii?Q?FFcz9zMSQpDfEiZJW//+6cOxzKfD5s030wtm3dU9UgNPRx4RO6XrJS1wv7jR?=
 =?us-ascii?Q?lqg0E4YTGjBLtwEH+wrsFsO0xiiVtDXsPjXjWQ8k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7bb3db-b111-4243-ab16-08db756a63eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:53:20.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLCPeUzn6CBHa9QaJewevyePX227RT7lLgpj6n49DShV6H3xWiKhGHmdYXeFzhyRSN2G/9sNtBb8RMhWlYE5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add CMA region for DMA usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index c50f46f06f62..359ae86f4e7e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -15,6 +15,20 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
-- 
2.37.1

