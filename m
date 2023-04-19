Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308176E79B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjDSM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDSM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:26:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFC15A38;
        Wed, 19 Apr 2023 05:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCYw1KfVTsEr0TsW1LS6T8ede8LtScvzAgnjPVlx5zxE1EhV7NCC2VqKSJXaLLhVf0Lrq3fc3D4OZDGumy5p7xJZB/cUBqiuWacn/wRAdGbK742f2ZKhQpOA09xwczHb/d/nYhSYnDFSx9/vklf+QK4UWzA/jSKnCvL4uHoXp4GBk7pktckeqFm5S2UBkvcW1Dhy7Tid0ij8kb5WCfgffo5JTpYVCV8TdRfCxBT6dR4ItwtOz6+iaWEIgth+rHuUICXioJ4U0Evs9x54zYUP12rhTDGpEsVoybQwSpVoabeS1q4LEVLFJRhenPmTt9ImG5uEBZVnAWoxx4+cH7lQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnrCKd90iOlJl0Ik0f4N/oSjQZQQUwzhdJYr12QdY+4=;
 b=dt9nEwaQ6MFLwtHVDIg06FDaeCvrBZasw28I9L0NhxcJwOpKhYTltU3MkRk2ZSBBlhANqjGQThwct87Z304mnjqHKKYjMYRiQlWb89hpJ2PsLNHGJj78f/bqNkcKBHRJo1etPD/dlsxU8dPyek6V7akQRpWx2sj1FfKom7od/NQNSlDFTQqKecLvwWpilVqYKrRYY6oEQSvOPdpIrwSh6ul1sqQJRhi1P6QfZFdi/gW3uf2ZBf+358w/tIf9nQEHUcXNc2GcsE729DOVb8e1wgGXHpP18cv4KTzfZzqFY/asyLfi5BXGQwpPFkiaAtGJ63DmbwMy0WF9fe8TnAwbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnrCKd90iOlJl0Ik0f4N/oSjQZQQUwzhdJYr12QdY+4=;
 b=IO4Z/umIBY3+CrxuksaAmq871kEbJNBDNnrtVdwbx4mGqqtHQO59hqvJuKxxm4ViPloE2vJJrqdpKRDpF1yhFw2i580/+3YtpOOCnUBrdATnw5/rfY+EUDwcrAFkzNkne8mn0FYsjlH5FMGOskqeFtO+eN7LKGbWxoNvB6RdiLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 12:26:36 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:36 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 3/7] arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele-mu dma-range
Date:   Wed, 19 Apr 2023 23:25:34 +0530
Message-Id: <20230419175538.855493-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419175538.855493-1-pankaj.gupta@nxp.com>
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e0bc75-5063-43ab-479e-08db40d15188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkuZm43+Z9HgVs3rChKit0ZIuiYS1iuI93Cy0X1UVSeup2Fwm5HdQanR2G6axV2CjAEG6rcMZKHYx3QKX/LuwNmIyi0EZuUKofGNWphiGUtEH9l8TRWIy654RkPUYhCVjPK6iOzj+TE9gUaYdgVLfJczept50r9Cfa4e9MmhceXgK7q5U37LxA+lByTM9fa4CKJlzxy9eKWdwB0hnzNNvuUUvb+wHsBY88TvPNv9AM+/cXSyiQPemTWknEbixgOh+oe/xYlgLelTjdRIRfY7JgIKqUZ79b/g8lVgfPIDgHggDdf5QF8hUQlkHn7Xt3oGOtTnQjcPb2z+kiqJgYzxg+jKMmlWrarnrpzBrpGW6ArDJP+jVnGkCWzdRRIKr57Ua7imZIa5j5OfnpX806SWznLbqMIUR2FTXnQLixH84b3OcMhPP5p8gXnCWocJsyU77Od1B3oI5V3cX0YDo7fVp5qtKbecD5R5Y/e6oHAiVfdDgFsNxI7kjZGcRTgMnRInAhsDuq0w1g3GcCUhuZYda1GWtqUndBrRWqsTOuJQySgVIlsNHoYTfQnkIw+2zE6Ev8OG7Z+JkMbVTrE/GwO3Ka301m7HelK2mxBoifrXxQiudM0e4C7DoLfMcPsac6w3F34oepW3uvcH6VtAFTTn4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(6636002)(83380400001)(478600001)(2616005)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(66556008)(4326008)(66476007)(41300700001)(66946007)(921005)(316002)(186003)(5660300002)(44832011)(38100700002)(8676002)(38350700002)(2906002)(8936002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwC7yKQkv3vHNyCDLfTlTy8rZcbfSbp3HIqX0wfp1H/SVDWR4z6OJ95azs4q?=
 =?us-ascii?Q?qxEbeUOFavYLd22YVENZIqdzyd0m3ipGciwnR5xz05dXkr6rsWLaUQmAqbdb?=
 =?us-ascii?Q?2dVE02jyLeWlpn6TCi5tBsPNMVWWF7knWU5k5aKWcqaezGaRZBUToQZIvl54?=
 =?us-ascii?Q?JlwgzW5xaZxhYhJLB3z0klYxaOvIwSrG2RPNmypzCVxj0NblPGOpCN3s7Qp9?=
 =?us-ascii?Q?/CRdQs6mk3ATm4wzAeK3Op14e941GiV20Be0SocudKem3RotJjdgvD/g3A92?=
 =?us-ascii?Q?Rs1rFw5aEhPcXi5xxVmG6I400v667rTcRJLnZrMrZDkLcD3c4/QYROVy8Vaa?=
 =?us-ascii?Q?R5RRQoIzqAYCombR12nCG+v17PLYnaWnZ5evzO1GkX1YmyDnjclM6/eXWQ5g?=
 =?us-ascii?Q?8S/ZNN1zflZGp0uQn7FWC+l6mGkbxPA6hrqG3GULtUW2CvjPo0XVyQGs5C3q?=
 =?us-ascii?Q?Qmu1iXzH30uUSgRACQ9IE435zntZnx9qUs8JUpCRCi/nfrLc7KiASVrVUUHM?=
 =?us-ascii?Q?4VKmojsd0wFOBK3Gj426vO0P2pRXsFBxF3KHPYkeOeWWoZz8hlIXAEuf/1Vl?=
 =?us-ascii?Q?bup9Hd+xuOwzwgCWkvD76RueO95hNEtatmQBKY6/fds6krasCTHmIJMt4DgA?=
 =?us-ascii?Q?ECMh3xpXebUjugOtyCdtAlZKvwzWzoCfos/viMldm2kq5v1nwz+vcLM7tqx0?=
 =?us-ascii?Q?3joGtDNaRpi1d+esLZfGiwJRULFGoVc2WmQlvp/kuPZx4kG8qbCZaeYwyPUH?=
 =?us-ascii?Q?7PzvdZ08daU1zfKcEkQQc+c5c5+qtoebl11/FgK1mOc+b4ZaJQ83pg0DzTAJ?=
 =?us-ascii?Q?ZQzeQYJNQhD3U5c8ksVs9jACUYwX6RqHdm0Fk159BdXbGB0ZX/1/pbQ77edU?=
 =?us-ascii?Q?YaZhcNQeOZew6K0cxmMpy3J745r3PXEqYMp8A1y2c0T450O0Gddg1pfqIqRN?=
 =?us-ascii?Q?o/w6mT0LocLAOQE7boVaYl0W3zvVxOJkIarl9B3X56q83L8NhuPU9036dhjL?=
 =?us-ascii?Q?bo2ohOX7DZNEpyOwlttzWar5zSafHlitun/ue8ZxXJONmD8pDGbOHpeYFyPb?=
 =?us-ascii?Q?Gg7X6b6CaZI27q8O1VSm6mtOtghXPdo9//NqbLEJAZH5Hk7a8DoTGMkgW+dr?=
 =?us-ascii?Q?3vrWqtD6qzshfxbXvD3jaQeUPd5CQMXqo6WJMhz0nN51BVuU3V7iwJBsqIWY?=
 =?us-ascii?Q?XtCo+G37umEBFDcm7mxKDc9QhHGnPxQmxyQvD+8iUV8di6Ok2ZygCXXs4UYC?=
 =?us-ascii?Q?i9mSjJRghhEikb3s+eph5PZ83iiY79nwbUXw3CB8tn2KQPd5gmG13fw4W2Ct?=
 =?us-ascii?Q?hvKCgCVu7Q2l8ZY+wCkB0NCtdzE/pZw/98iWLVsIJfL5J6PEmJDfXnoKwo8k?=
 =?us-ascii?Q?G5fBVAvHqxNiTf+QahZYxgRosYxMoRUwvIp5VIXpCe5nqMQCbCky8qgXrBUn?=
 =?us-ascii?Q?7249PyrdN2BIxOfYBmlY3wVxY/IWp7SONryIsQb4I13wfVgMm8FQKkFf2ZLm?=
 =?us-ascii?Q?GF8FD564DT4Y45O5JEqU03P09LvtC7fw+lm208KMRBHJTL4VhWxYVEhNb9Jw?=
 =?us-ascii?Q?WPeZvHrnpbKEG1GnUe6l3ja1sYg628TxXshZsd75?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e0bc75-5063-43ab-479e-08db40d15188
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:36.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg5ox+H0iRZfnUIKDw4EQKHZueBLWj/76lPCCrs6mF8+xSuhD2dUSOg9a6IEygU+1CixgoHDHZSR5ah5gAmSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x80000000  0x9FFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index fefb93487291..bb090300829e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_mu {
+	memory-region = <&ele_reserved>;
+};
+
 / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
@@ -22,6 +26,17 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1

