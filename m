Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14000605BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJTJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJTJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7531CFC73;
        Thu, 20 Oct 2022 02:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+pnJlGfXZir7LXZGqQsKJmWzCRa776GOydfqKw82om46iuxoWb1x8eDK599OE4R5+0/u38jIbviOdxT17Cyg1VGwLfd5Rdp+9Ht+ZtpuTqebZiVDcamcS2pUYvlhdvHhz6feMiq+9g2Y+noj+ikomjWE3Q0wVpqJoYLCikAb4g6JHb0/la8MzSOITzohh8hqcNjZQ+b5JTHojj6hzrwmyL13N8vmd23iMOHrT1p8d4UxhWOlVlqkcpTwyGwKt+1W79lGzs6ApWV1BSt9iPvTWBqAZyQlRZ+JaIBSaHjelvQaOOOVKjC/ZmPZksO7dfvdQEVKM4d1KyHOmzlpVQ3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY0Rx4VByFGan/YiKtlgFzqM94uUgJEZrzhUq19v7so=;
 b=cfbuwP3ZvayeudKHOmYvEOjispoxQ3oeZ1DAmzaXcOiz/AkoFpez7GIeVrDBFlV93NhFv+K7QMghh/6sDcpuMftZOjiUhQnaCanqxJyuoeZYZ8K3uzRezvhyoF+FokzqfQ/QoZRi5DqQXKmkwOKjduyB/u0vHVa2t5rk+QGfJyNHERIxFASHeiL+9VbINiBADkCE6AMT4r01QZInD5P8e8SiBhORu6MQ0KeOgbI4U0ueQ05uzE2S7hxrL7MjYwV/K9MDRKvkY1oxrsUGz99D+g3Ge1Sd9T1PSRL8EyPvAr8hY9QwjY1yJQfzAMa5GMtnlaJJHNBthL1zI/Jm1k75uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY0Rx4VByFGan/YiKtlgFzqM94uUgJEZrzhUq19v7so=;
 b=ZNVS2SywsfaqggRntXVRKU/sWUQdBDcurLe63zXBfO7zR8nmwHdsD0J4rZEfgl2uhG4Kh5zdrptNfa8PouknT11dIYGxNkHD+43MnYcIeOo8DpGLp5wRLVVXq3z8Yt6Dc/H7X8JUq+gIvrX3Eu0P/6rwxeObJmg8y4zIjNDICgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9320.eurprd04.prod.outlook.com (2603:10a6:102:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 02/15] arm64: dts: imx8mp-evk: correct pcie pad settings
Date:   Thu, 20 Oct 2022 17:59:21 +0800
Message-Id: <20221020095934.1659449-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 792c51b1-5e13-4a6d-efd1-08dab2819f89
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZ4JFGuXUI05gdYV2Rj2ISNeedwHTNIc009yEyX5/VDhpgxaIffmcHcR057895nDc6ui/4OLrnfhr2LzP92J/1cxyt2FsHL/T3nW0Xn8BAF9M9ADAqqS6C7yxLAUCfe9j55PwwilxNIjvaY6SONM7OqnrC/zBplD71hXdFG/XR1c43GhdrAseoE9W5rpfvk6EkCWBKhLr3zqXmqMcbg07KqjvbiuOWcQdUMHKcJ7JWy2QomamT/BFvivyzAKKTi3KlhEJebNZRyJq6RGqxHwDrW/kBdirVP+G+pF7xz/F5YOM1qfjYMREeI/RFra2Vrymg2W+Lv3xzEyLPXLtZxURjH5aovo5GMXlg8+cIqfKstTCERZkiDMPtFfcpRITjAgvrZ+ATHu6HhpYMMlAmSaeAfIfNk5dtzl7yLsaO7GxUE7bN53eIW5gTAxPKgd3CjsXz+uKiDhDA7+44WdO0GBoguL0/9Aan5BPSaCGofc23RCt+woDmruZpDGGlCFQB8V4ORIXfQcw6pSCU+O27QO02Bk9bFOitQmW+teufiHtMu/ozC2ABEwP3E/pO6OATtPbD2+BxaULpV6NOsd5VgAQzOCwazZ28qdjQpLKuOnFMUscBYUcv+fminJfhZNI/bTtvReaCXdvpxx0oDHAY2Oa7id/7ve0ecYIZvrCLvA2zPIJO/nlSis1BnJFuMNEt+LoYjVdKbaeGNQsX4mYPfvVeEzrnIkMJaq+uq0TiNsEXJqxHoMdKQDj86zJtAGdqfK+YzPe/wXAypNoaQSeJ4Rwe/DGbOw1s4jOWrk4H26rNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(186003)(52116002)(38100700002)(1076003)(478600001)(38350700002)(2616005)(6486002)(66946007)(66556008)(8676002)(83380400001)(6512007)(86362001)(5660300002)(8936002)(66476007)(4326008)(41300700001)(26005)(2906002)(6506007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQYFfeaYLQk07UuwnXyqq1WbgRxQSoHRSzxWSJG7t9XBedh942NbI5Rwgopv?=
 =?us-ascii?Q?+yapV87vWEAtoXny0CLzbCSAshFEtakoZM9oT1NqojgUj6pJz9r4TN9RltIw?=
 =?us-ascii?Q?KKcy4Ma1losYN5AjvolhNRNFyLo3M2y8LT21RcGPUeAkBYVT7f+XSYwD/f5I?=
 =?us-ascii?Q?QgqZpZNIRK8eMBvPCsgFkCjM8lngxypF84HDim59kz3yYueMKqj/zkAJn4RZ?=
 =?us-ascii?Q?JVfkZmWKxYHStE1BmT4Gziq6FxEPVnwXF44f2BDYd3zQ8kiJNcWQFl/JzT4E?=
 =?us-ascii?Q?ZTtS/+rm8yXXtGgxYHcnzz/miD8otAG3H0jlvDJ7DCr/7XrKzvqeuYdAU1Bw?=
 =?us-ascii?Q?bbqJF3eVZnDQctZ4gQMyiexlziMXGSdrieLADO6qOHNJD9ltTtuui7ZWvTfA?=
 =?us-ascii?Q?bcn2OTgPlmwxwwSG38ThNDwDHM/3hEfEZhPUfnGsxINfpCC6apU1iJJ3z3uN?=
 =?us-ascii?Q?SBt8Lp9OQJ+Cn8GU6GjV9J4Qf4YiJJBicNLs/kbn/qlWoNotnBV5TmLOKadT?=
 =?us-ascii?Q?rtbgFYhHl0fpo/FjTSO8NOCho44WOHZ7hB9xiE56y9ksSgBU3mwsuI4wNIqx?=
 =?us-ascii?Q?M5vE2X9JnwOyKbzfcMsfqAa4CkT3j1RUIc9HuRUipNqteshfjfFIomMgm1Ss?=
 =?us-ascii?Q?OXYqD66Id/i5BXgvBivo3k8JPiFwLTWjZlxqio2mGH4Ot+OXGxHI1oNjEsa5?=
 =?us-ascii?Q?ZHP2aaHQyQbw4G5Tvowh1Tky/QZD0IWjYT9p+N6uUYvIZJFxvh6sW1mtgzUQ?=
 =?us-ascii?Q?VU99pN1swSGBVpuRp7F2JPAlz/obMuZkBCDYQW6GsvW6qfSU+2Z3E9N3JpIi?=
 =?us-ascii?Q?P+oDlCgYsUG8I3B3w46GIEFHMXaCsHBAKF1AnA8oKCkmm+9kTU6RwCDTk6YS?=
 =?us-ascii?Q?0dus8phsWqMS/Y0xUp3KNKNXTPDw54hLVE9T5sxx5O2o8ZsYDoIpHPNdh2PV?=
 =?us-ascii?Q?AENNT2kR6vsT6UgRNtqP++thAeUaOoNJh+ilv6VIkQr49VkTothBXtbrafOP?=
 =?us-ascii?Q?OU/RvDqwiUpgU89iJ/X1GNkqzqaNydyTEr9RqdDC3/5LCm5pv9yQLOpojvQe?=
 =?us-ascii?Q?x8aF/ZaSuje6Fs5ZHaqhGA9shofSsxARo5yJxYxZXg3uoyEh3z6k4GUd0J+G?=
 =?us-ascii?Q?GWvRVa9b44aXB7Uv/dtoHFct291oFgaO5c4VPE0ARc78HcDtb6y2QjjZLnOY?=
 =?us-ascii?Q?TroFRXI2Xk6jtyGZivdARqmb5fJCShU65xs1sATthfmttSsTYvylVXaHjWJy?=
 =?us-ascii?Q?voPq9OQhiKX9cqaUaytj2RcVu5dEC20UYymEWKW1lk4zYwr9ccGjcQucRlvi?=
 =?us-ascii?Q?sRS3tZ+U6oZxv2C7u+3oSpkkamhP2ZdtDQWbs9WSb8YbdHESAf1Xdjj8N+vH?=
 =?us-ascii?Q?YSduRK8WAoigwsbLprs2m6XPDmdNDQWdcunUbueT/uTZN6HYmRldjJntK4tx?=
 =?us-ascii?Q?GAiTedBhBnZdAffsd079QFzGatv7H2i+Bj5lhBySPeYNcwJDw3/z70tQGvYQ?=
 =?us-ascii?Q?qn8qcQP1M95KjxNa3xvk7ji4S1vrnOsgy350+S1fsXASs06FkBewCCmNbKnd?=
 =?us-ascii?Q?1/ce+bmeQlfoPQWgPWAVEtLSl/ytE7bg2vedq2OT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792c51b1-5e13-4a6d-efd1-08dab2819f89
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:22.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn8/Kcyga/WbKKj0mZ2i5v6CXiqICMr3uyH94fJdM9CKg+SH3bjPgygEyE6XDf9/U/CinSbo0Nzlmg2khdNp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9320
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
  PE HYS PUE ODE FSEL X  DSE  X

Although function is not broken, we should not set reserved bit.

Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9f1469db554d..b4c1ef2559f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -544,14 +544,14 @@ MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
 
 	pinctrl_pcie0: pcie0grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
-			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x60 /* open drain, pull up */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
 		>;
 	};
 
 	pinctrl_pcie0_reg: pcie0reggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
 		>;
 	};
 
-- 
2.37.1

