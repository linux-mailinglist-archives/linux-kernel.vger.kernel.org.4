Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5873D0F8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjFYMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFYMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:37:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3313D;
        Sun, 25 Jun 2023 05:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGsk2y/f5U5FSUL+F7yIQhBth3t07SqeQHjJKdBGVatJ9lsscl+fKH9duEr/9KqrqoK5n/8omIhzdlmztkNsqVm85dHtKej+qkelbNZU1NSWU/rkbdrt6nYwRTOxU6nm6T7enZ7lE984XONtbATDliaccV2RtOScwF2MLuNlwZIhJjJmoLeDZTbCTLwRN09KGaTkOdWU/An7saD0GJCxk9PGxPZFUx7f58OTX1LFGnW32jhzUl4DMd9/uK0QK7sdd/wRiPtOUeCZl0fjqQjxloADRODdvUYOSEiBJVTZN3npiUg1hmhadKcKaYe6sPf8/XoZNMi8+gA1izQdEQS0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qBYLl1V5+dLOQSOMlz7Uo02efyrB+5NEOS/L9RS/xU=;
 b=eB5QtD1U+AZblsg1+SqfFy+xcFXvhIoX0XZQmKPcTBx3/CZO3LgblgEvFA7TYRInklrF6dOwc9UnGSJ7xhTov8Ss4V/278qxCP5Xb3/w8BFNH86o6+RVBuJcFcyzgqCWHnLLRtmVg4u4lTqY0xwXhEwPlhGD81aE6OoBXXFNXR7itmP2QtfYJyilaY/cFTT/dZZRq4fP2ZUdQ+t9asFN84PBWP9HMlokTpyL9zfieSPJt/9EMIpv1JIaJLBpL5jfkJhLh+MX5WFU/a7emW2iYkJvnvihMFcU9wikzzJWDMuVES/ZNdYWpkLPKX6e3f1uyO48HAxczJWPe4XHRNz3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qBYLl1V5+dLOQSOMlz7Uo02efyrB+5NEOS/L9RS/xU=;
 b=BOgXkA+9LJdeOu1k+248RnCu4WEsz9twhm4KlFSVjSSXFzS5OOSNWJsc1DW5XgVpnU60vFUKcGxlKbTAHaAFWzN+pSSntLKrpC20MJhcpzAitBv1G4SxezWRsYuZfNVBNKB8YQUpETG78ovHUyaMH3Pxo/rDbWVXI2jNx1aD/IU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:37:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:37:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 00/10] arm64: dts: imx8ulp: add more nodes
Date:   Sun, 25 Jun 2023 20:42:28 +0800
Message-Id: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d02ff83-0ace-4728-a905-08db7578fb4d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04Xeekf3mUj6PKf2eeBgvnx/n5w3dUHhxArDxmttFQEfyNRePAzXSVomL7DGXVNAh6R3veYC9ou1pZf4M+9/cDIk3IQD3FVKNkIkjBOnGWBcF9QT/5UD8nOU7nyPBEAuzj/PNL3jEurEH2NNq1W3YCDRS35bx/f6wtNKLj2MiwF580aUnMS30U1Sp8coKOyW15pKSayHZ9dC8It/TDe9kV8gjULnKPBw/JCe7V68yiObMLi2TyPXcfNVeQOT0a3IiiUNQUcAsjxVQOQ0Ai4BdHGp0xj0cvt4Z+8chIBBCVjVOwTg/WG12vMzoLEdaEkEEzozb4joLJULUeUsz7VjBPocoPsOuvF6eSR2UHOWaqY+3EvDhLZ2alJmGvYvt/s0XcDQ0dktKnsGSBW7HWZZsp6TF/pJ4NiQMxNF7LRQpsUji3zwNE7mnch03X8zVUNHRMdtmC0peJRupWAgsJGjHgYYd9wX6yWuJrIvb4gqW6nWJ1BjfbS/2PmHbHU8znxzsVfqfeYz+0Trg2FitoVZmtpWB01jQNGUgbI4kmu/KeXkE8IxyUkItqLkOKrrkYIfkWdQFDp7iDpvMyNAlLr5Qu8vIDIdo81D3lNBADIX0Nt929KVdjYkDX1P+8Yv/c1N5U4b6+fmCSNVJklZwrxM7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(4744005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Lk2Z0g7hC7D2Xz5RIPWJaGCDddqR/4074NhmYir9K++q3I+OEyOuGN1Ocmp?=
 =?us-ascii?Q?QDLMWqhVkx5yhhgBax9cFwFlAlrzhPGPiyIMnS0bYDmQWBapjj8HOOFh8tPx?=
 =?us-ascii?Q?wkfiLx6t661+FyvW1nMmISQE6ntbqX57OdlrmOlab8U9yErRsG38CNJ+G2f5?=
 =?us-ascii?Q?CdW33bxNbxwG2khrDhEt0ZuhpmIU+4vcJ1wmJ2FD7wK9KseNESVormRg0E7g?=
 =?us-ascii?Q?+e46DUmLQdssEnUBU4qFsLhzR3V50eHzxyIH50JhiCkHxs1BE76oecBP9grM?=
 =?us-ascii?Q?OCKfula2ewIiCDQAqyuzh6mG8qLg9CiifHCH+8Xb+mQOpdq/Z4rhvMiYLytQ?=
 =?us-ascii?Q?yYDCRW3zZ8/luaWQA+F0gZWY/fi08+RgaERGekHIijSBW2smTiAMpzR8qNDh?=
 =?us-ascii?Q?b4uu8/lYoSqWpodxgzGaC5PVTT91e/4lXWG1zuHt+9CYegENk4y3MalmJdu4?=
 =?us-ascii?Q?YFGSd2vM/J81pOVh8s9s9ASOc/33bMtzpqxmwYTLJUepfK0LC08tPVezcLig?=
 =?us-ascii?Q?dTUSNytPgSsCKloY5foixQ3V2iO4Y4uGarpA7004MJYipiNgps2y1LhEaIbA?=
 =?us-ascii?Q?ArdqPyDA2FIO+iaRO0kvMsDc+t8rc2be7EyuPtrwOaoIP0ReluimK+9+hHh0?=
 =?us-ascii?Q?BgdT62aqrN93dACbs0KS/oxLHlSpIRtficP8b38rxqePY0UHrHnj6zUXG/NP?=
 =?us-ascii?Q?Ru+A2ngBmv9LoTtQm2Veii5R6p2dYnhffn1op/20LNvgZea3xd6akFkhmcEq?=
 =?us-ascii?Q?wWDW4VhTpMr3G/9U7BFmYyy7DCabfhbt4JSvWPQ+9rMZEzUKpuN2W97L/Nx0?=
 =?us-ascii?Q?7xcy3q2BzXDo2hPytQnvExzQtG5eJikssXvm3IBPJpJ7AnUeuYuiaPktHITv?=
 =?us-ascii?Q?uK1f9LWA7Odud868yAfNp9MLMvdHnvfTN/E/Fw49LwT/8PA3X6Rv50f0Ffo5?=
 =?us-ascii?Q?qEDA6wd7DUecf/iXwv6skBJRl7wZ0i8s3QVngyEZAsxaDRaxPijD2rH/kWfu?=
 =?us-ascii?Q?+5odVmLcA01o+PC1+pMZJr/KCLDa8tYEmzoPoFnsOjLIanIDFuWoFGEuY3qF?=
 =?us-ascii?Q?2psnNOv1KKkOSbFoDcRrjPYoBXPyh0SNtcmH/Om0ZxO3tqNSwbnaJ5ET9thn?=
 =?us-ascii?Q?AAE01USyLLW89MjnpRPht+dLnB53cU3wvQrQ9CwDmtfPEVSXxZWWgge6s89v?=
 =?us-ascii?Q?cupUgNws4pD2LxlMlBgeA1yFT0qYidw/QfxHt5lNHGGUFOVPqoW1T5r/EXd7?=
 =?us-ascii?Q?lRv+EiHQKTs+HnL7x9zvcwJdBWJnbWMkNzEIV3km9ebqRuFhFEEw7VVZWb8q?=
 =?us-ascii?Q?fLivnU+FhRUon+RS0EDZisZhna/Wcx2Fx5d1kasQ+C6ZsalSWVtJY87uTfHi?=
 =?us-ascii?Q?NRrOkd7HuCmjSmnWzLBWnoSEGLqQgk+Gh11U4YOMm9VIm5M75UOe5BycW2WO?=
 =?us-ascii?Q?EGghn9/9AI2fHQNSo8cdQH6pwh8HsE7TlFtz2+9Yech4Mu1s6IVZB5lZr+XM?=
 =?us-ascii?Q?SJKIEg+Z+7IW5Ezb/uA50H6dTH4iZvhjypx4Pd+ObE7TTiYUhutaxAF45QbL?=
 =?us-ascii?Q?mvvUI+KXC+NPv5mFT1iqGO7kQhcMQpb0YQFJz1ne?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d02ff83-0ace-4728-a905-08db7578fb4d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:37:47.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJ/0mtLb9Xgo7v5MFnfgOmPwiDvGFW+f7+t4vrrxNqVpVF45PuvZdD2Q4Oh8Z8s+2+LF+8g9wi6Aa0mi4oHWPg==
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

Add flexspi, cm33, thermal, cpuidle, reserved memory nodes
Enable flexspi, lpi2c7, spi-nor, cm33 for i.MX8ULP-EVK
Set default clock for SDHC

Haibo Chen (3):
  arm64: dts: imx8ulp: add flexspi node
  arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl setting for eMMC
  arm64: dts: imx8ulp-evk: enable lpi2c7 bus

Han Xu (1):
  arm64: dts: imx8ulp-evk: add spi-nor device support

Peng Fan (6):
  arm64: dts: imx8ulp: add cm33 node
  arm64: dts: imx8ulp: set default clock for SDHC
  arm64: dts: imx8ulp: add thermal node
  arm64: dts: imx8ulp: add cpuidle node
  arm64: dts: imx8ulp-evk: add reserved memory for cma
  arm64: dts: imx8ulp-evk: enable CM33 node

 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 147 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  72 ++++++++-
 2 files changed, 206 insertions(+), 13 deletions(-)

-- 
2.37.1

