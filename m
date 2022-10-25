Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5460CF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiJYOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiJYOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:42:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42B162509;
        Tue, 25 Oct 2022 07:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc3MBIeXWPr64Pdgw70poQE9p/m9F4Skd6Xgh+bcXkELS6juADLwQUNxQ6lMvW5600N7T9uVvrqxJOmZluVZ4KBhzsE01fKtpzBazKoO1vPrRtfTtjGky3Y7RZH76wBm/QocbgTA/dMxS6hVH5Y0LGym8RLVvlDMkwuspSqgUulqgalig5/TeTM7F/lzZ3RhTUhcirykUopi3cjhh79n+DYgYeFIEInf+LmLvg2pwsLILycSoHG8kYtI/K/J+gVu91HhRuqvjgbHOLXk2mvr4rZ/3+p+Q9jb1g6j/OVcgSMt/ffPK9FhL5gpTxm3nnA+aiGKzNftJ7IrxCCM6QFz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XERW+2yu1opiwNufNFi1Q4go+N00rvKoZmXzRXbGIOU=;
 b=cJWqD/wx2sUTjpHeaEBRlcZKd0dEHiTHXvzcFw1x7alVN3HKjfQ3acOdpFCEk5DZSQEJfOSMNGSBa62DgGRjaJqx+KBSf90qbB/nmnRdpeOvUBktqXlrMSqZEvetoIeyyl2aHBiom0OpS14Vpnsls6uwBhP9BKyzPfs/jfLe7ZvrKoq+B8Tb38XLxJJkPUaTgB+DiEaL+UJxgvGBjnx+7NB58DfXztq/xgeyWtbuL9j+3gNlBUb2JK2Z4pjVXVweLaHmFjQ0phegmSaynzWeP2CeXp+5WAezAA+5Lmr3CSQa+tgeoOwlYY9UAaEGRwTvR0v1AHVjpkdySpfuHO2wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XERW+2yu1opiwNufNFi1Q4go+N00rvKoZmXzRXbGIOU=;
 b=ovQZqSvllOnwgol0aMmMw+DlsD4oVGjFeZGq8C+rZ3fp3rJcrOY8B/VjJKCwnIDv9qo6UO02zZxlIRuQ9exqo/U/Y3R0PD2H2RFjyisCCML67mJp0axrIlyKUp6GT6TQl5WBCMMo0J/523zsfqXBI8kp8d8MkwYGyqb7zeeJZSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com (2603:10a6:150:1e::22)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 14:41:55 +0000
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a]) by GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 14:41:55 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rmk+kernel@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] arm64: dts: lx2160a: specify clock frequencies for the MDIO controllers
Date:   Tue, 25 Oct 2022 17:41:15 +0300
Message-Id: <20221025144117.1010488-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
References: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To GV1PR04MB9055.eurprd04.prod.outlook.com
 (2603:10a6:150:1e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9055:EE_|AM9PR04MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c31b38-5dfd-497d-9e95-08dab6970fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4visXgG8BMpAQoHyO+S0bv3/uyN2IomKjMNr2bE9jn3Pjxb3Ms557oExKy7ACsSTkJDPOOvD4yotMEXwA5wzretDT95b92+rvSmaNKWWoY43/HP9FoQXXZ18LHaMufm+BRzYoZGV3ZN4wA2Q0ummIbYtud8IAy7nXyMXeKAAMI7F3Z/RMytuHlHAz9I/GURJey27sgYXeJwTsw4jUwqnEbuy+xbVsjDaCk7qNAJm7zjtFgZ/o9ekjJeEdlO33LIeWCMZz9iIfTA4cxwj2Pd8Vh5tzM+zu6y6C+quB1+J7eOgFSicwGmvLjCvm4rbu5PPNvs/0/kYMdGFbcVRyYblDuXkKpUqizhuf1UpJGfhq5NhgSeiHd2V7ppUHp38+7pp3tAjr5YETUCgL1L5bt3SXKKHBNquVPfLJfG54KBn/XZZJXVmnKC6WIXD4h1u5mrCwf1xVUM9zwI8vFOmfMJus/H8D6DetecJD1BW8hXmXaUn8T4OTxix7vv9Y8xgple2keoZHkIQa2iau2CsYo4yOs9s8c1titPuioKtGlEAt3Wa4hC2zydZF7bbE/P3i1J0TK3PJouGcnThMVh3GekrC2DRDxj+uJ6SLlMaATKfyiFIhO/qQAVlOJsWDRf+ud1tTIFBjKuHiZTULjoPG2B9tPkp9JNHhVS7UxQRFL/XMlj3EIRW48/5so1CnqwJE0Gg1YKawaL+uvaut+9QC87CsIN+ezZzgIaBs5dz3e25+00NYCD27eojA/ilJEItPK/F7GPRBJ45ZM0wpxMzzBXjRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(36756003)(66476007)(44832011)(2906002)(316002)(66946007)(41300700001)(4326008)(66556008)(8676002)(5660300002)(478600001)(6916009)(6486002)(8936002)(83380400001)(38350700002)(38100700002)(86362001)(6666004)(26005)(52116002)(6506007)(1076003)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8s0s2J+EV4hyw3VlxZsC72y7oBuOs8EhS0BzPbEPC0mAg7v/pfz0Pc5f75XW?=
 =?us-ascii?Q?fl/409mxWUmgPQ/q377DOWqBrDrwIJfYckhe79dYn0HmmZkdZKp/sQUsEeVM?=
 =?us-ascii?Q?zL+kUK0F7HBxsz6npnnnEdv2PViF+QGGrFDnWyy8/Ri7MEvJNHk6lpByFivx?=
 =?us-ascii?Q?302Vc6W80lmXvNQZp+bwwsFvV7oFqSjBTnhum8rf4jhth3hmi9159GIg/dYO?=
 =?us-ascii?Q?5JOUS1YQdgqkyrc+5j0JODp7poufL5KvS/OQEcM4Fewu0Ne2k6lYSMRP1Dtn?=
 =?us-ascii?Q?CQplOp2psOE7hBu8ExNJFyZHD1GGJKd7FMoN2aAOxQIN19dOXR89Tl2ZgmW2?=
 =?us-ascii?Q?ww9FeGu1Sy2MCnhWTHHYt//9hhN85wzHAi130qaOVwJdxTiXpPpwxwIZs8do?=
 =?us-ascii?Q?vWRzHphd3fnbdY45465cs8gYRukNY8kMrbP47LJe+ZQ+YgBsWpIGIDDx5aqC?=
 =?us-ascii?Q?F66rae+KSY0thpIkGMW31Nvy4n8pgoyeyE23VG0ytg7gCwlC8L9i6n6d38K+?=
 =?us-ascii?Q?jeHWGfbHR3jvPWjKDKI/+IzYmoO8WIKzBU9bd2P9al10xHUlWiHLiZkxTTQL?=
 =?us-ascii?Q?d/dSUZP4LfqdM/mpP6UNOZLs0qNGV1wvstmQl9es7jlQ1oZHH0GrThmrS4KY?=
 =?us-ascii?Q?oH2PMQvJNfQfVfvhC0YPL4Y8FWO6QYlUKaB8genFvFaxW6Vq9N1b/Xha7qiI?=
 =?us-ascii?Q?ELfuerLBt86s6tkDrKiXkytU5szlmAi4GETsASzPh/Rbpg/WWP9nB/yj8t6z?=
 =?us-ascii?Q?r895EAm1W2W+Vo+5ygV+HjxnUwqstjLdyx14E8L3Xjj8FIONJJH17FqquXO5?=
 =?us-ascii?Q?YQ6bJoex47z76JM1wioKgnuylfxatNLs7ENX+0jRHevaiz/gxCUR59ukHwzB?=
 =?us-ascii?Q?aMQv6Paps3CVhj8fDxrJdgZBk03xBNqe4LJ6Hp2fmlAkfKsaKNXiSctEk738?=
 =?us-ascii?Q?bT3k/qXsICnuCatdCXNM36Rp2sWu6NkhA6B2b8igQwDCzJDFSIkOQslTjkPO?=
 =?us-ascii?Q?tAlFGsJYTMjNZBTA/PvG7a/eUUlxpGh0UZVXMW428GynU390xkTEKAW4ZJYK?=
 =?us-ascii?Q?p7lCxKj1bPqUONHcO1Tcslgfeta9OVWE0LVXxVyMA8sPkuvmc7lLnrMoxQNg?=
 =?us-ascii?Q?m2olWLwXCw3jml7DK39VVx/N/F7uXAxT8RdgubVHoN0Biw98qfI0opSXLghf?=
 =?us-ascii?Q?1g8pjqmiaI0pZHSTlLsLF26YVzRvzndGv57RV9HrDwqAXACxPHQ3R5RVVD7t?=
 =?us-ascii?Q?KTIVUJEYu16kSvc65T/zDntjJqu/NnnawjBFWbE7qMt2cTcXs1LwYVmB9CxQ?=
 =?us-ascii?Q?eP1wN5/+yypEOmEMkJf4cvqk1qVpBkjgZetmHuOf/cu/WppicLbJTXquXa9O?=
 =?us-ascii?Q?7egFV1Z7rCpSyImjMDLFQO/j2ioxAG6xvyg5bioBDW7vODsN+1MYlRdWVs55?=
 =?us-ascii?Q?ajPfyp8r9a0GKlmHstQ2rSu6mxEQ6iemkQpV/h51nqUVai7t6eDuNq/irupt?=
 =?us-ascii?Q?TqQJJefcwzKhwkS41FIg2FjnqY4xn2UsB/hzQgg7uqECyyDVgZM0PB3p9GXZ?=
 =?us-ascii?Q?i3rB0/UeGayWmIp0cZpxqxoCmvPx4aZzaZk2sbGtVpip6lDpX7NGlWcMQpRy?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c31b38-5dfd-497d-9e95-08dab6970fd6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:41:55.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cnCMPtt5je8jEZy6JWFEWdSrcIG+HOrRU4ghKOKX5TK8kzjclro1MNk0Py6CqGc1WgA+zeQqZLPCinwbk6l2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the external MDIO controller frequency values relied
either on the default ones out of reset or on those setup by u-boot.
Let's just properly specify the MDC frequency in the DTS so that even
without u-boot's intervention Linux can drive the MDIO bus.

Fixes: 6e1b8fae892d ("arm64: dts: lx2160a: add emdio1 node")
Fixes: 5705b9dcda57 ("arm64: dts: lx2160a: add emdio2 node")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6680fb2a6dc9..8c76d86cb756 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1385,6 +1385,9 @@ emdio1: mdio@8b96000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			little-endian;
+			clock-frequency = <2500000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -1395,6 +1398,9 @@ emdio2: mdio@8b97000 {
 			little-endian;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clock-frequency = <2500000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
-- 
2.25.1

