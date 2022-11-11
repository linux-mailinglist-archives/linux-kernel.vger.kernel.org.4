Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646886251A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKKD2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:27:42 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40273654E0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp3+AhZe26Hr9NablFQBlInrw6Ow9o9jGHK0Ms+eHhAsvLk6rbv9k3tZG/GfP0nQLBk+JpLzG1lKscMYv6VXs7y45c4hNf5jCDGAauIp4gRAl+aflvRwdE1bqxJXV6V2a17F+NRlUzabokFGUhMZ8WVjHkFU3I8JD+rb/8a01bOywYEh574HhSAb4ca/6jvZ++lFvac2mU4n80yMBvFrHyGqdriIDkX6kMqPqzWiBgfoZK1t+XfkszzHFaSOVH4ouOrmNsWoScJlK5SYq4T+JXow7ta/W2v9gbzWr0lhirVPI9GdO6Fy45/nqGysHGofcRwFj34ROYJ1w+4ux0pXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg/jhz3H8+lip6RxfYxeA2p3dei1/Ocw4YUx/Gclv0k=;
 b=HfbL3uswBKM/HF/W9IQ6byQQy0oe+vI3429rqbeeycA2A/wl531JiOPSviLk5NW+SiMNxUWNwctuOh8svBzt7/L4w/wVbAzYcE1IkQToBRJD8f+ykVjevSV+gVBaIkR5KxMoUvy22NEEjDLtXAQXK4O4x8gNTrM2zDIIFHhaBg1i8yyMdZBtgKaBKogJebQwdKEnPGszo5AUZY5iekGIbiHJfMHLiXDEWYyDfRtSY+U1n7qIYrH38B9cjonRahsa7Xw2hQ+2SpeJp3syQnRQ5rLE58CQr1ntG78FoXK6jFY3mXo2UeSFmoh0qHZLd8A357pE32lJWPBIDBfClx22NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg/jhz3H8+lip6RxfYxeA2p3dei1/Ocw4YUx/Gclv0k=;
 b=KissAjwgmN6hYbnEjuN0VucFReh2lJg8pZ3fWmLf+lMOADMB+UoUPKR5XgnNxr/X4T71iod4jdVmk9WeYXTGnCAUXpt+/Q2UZrdRajaiIDOGbj+PZK2GXZvq/Sd8XCTsOV635KQaXHQLoYDZ5PqcxSG56bWCB+b/EeQKfn/Yxgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 03:26:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:26:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 00/14] arm64: dts: imx8m-evk: misc dts update
Date:   Fri, 11 Nov 2022 11:27:57 +0800
Message-Id: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: c512cea3-ca7a-4016-b5ae-08dac3948e4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpf+vIZ2/jtK6XhSD1nrSuLldg6XCOzzHRzd6wkx/nQvFzhmub0Ct2XL4Mhd4K4I34clswraV75AT9FzVDFm2kr7yp6dRaboPzELJe8UcdaEQFducU/0uxP6qFnl6EnH1eTOqO0+b+tOOVXHUEwNOdDGFVqyMIE9Ri9PrgXNXORqp05EdUR0GaSkqb89on1mr14h+BfcnmiKs+EzGedwM03Lbgia76xM7+7fsHZYyKEp10FT/q2aguA+/cOjuhKh4u5J1kgWxbnc7CLhIJ1i4PRo0PIEAOora/2uWY2k5m4lrl5LnfJqJ0tEsYD1n2JIprX5VqZDEOk+fT/o4vMkQIRZAhBAtrRcn8o81Zf6SnFsyKRgGXURwRg+kxnbnCT5VM4+v5N8eZ9wDqncp+/sx/YuQKZTZoha2FPtU6XTbvRA4ZwUw4rCSE6d65JWLuLxstZTFDmhEHc6yk7Af2NAKQ8Bv6fPX+KjttLd5YvrngeRTTwIoiKX4uJjD3L0AXFbBVAWcq54D/YDDTaWeNWDTc9m+1vwIphKNuSPQC6FjOLHsdQrbDLGHB9S0a+KpRBBlTdYaq2A8+fBGUEtDTqc/5kT0ItdkJa4wz+5/wHXNQKw/sVYX612AswcM6eLAwjI/jUT+B4E+x4uZ3v3aemNJJZpS280aIEz8/mzaxIzmrPO6LvLPjBzNSADy9aUk33FGG1kC9FXJXQTdDzIgwE5XGLMkoIDig/cZI5zbEN4A8dZ9GYX9TJAZ4DW+fxeCptpyumakjyJeYKJ76Id88XDjZmRuqoSdsbGes9jig+fn36o/3dU+s3mM0Wbnq4lkP1lIw1ikZQgSt41yeaTa91fK8vtWeZhCherxZBPjyF1MEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(83380400001)(86362001)(966005)(2906002)(38100700002)(478600001)(6486002)(26005)(66946007)(5660300002)(2616005)(66556008)(6666004)(41300700001)(316002)(66476007)(4326008)(52116002)(8676002)(186003)(6506007)(15650500001)(6512007)(1076003)(8936002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E64ZuAbkEUVrmhAyGHGW1hgPLBIyGnT+CmfIXsZkamDd7CvHdGafOuIfQNaE?=
 =?us-ascii?Q?/XJp/V191plvwAPKUzeMSdY8h6jbV5IvO37cH5aR3ryqk9Ekt+4sdwW/2515?=
 =?us-ascii?Q?7TmV4vFk/jG6SNTJB896QO7l/EH1oBopWTwJZ6ieSNZmebflrdp5u1vSbIvI?=
 =?us-ascii?Q?z6/W/+RW3zkXXLbYxmwI3+Q9TxHB0b5GZFwXTEWReMzdf6S3wZ1fyuM7Es3u?=
 =?us-ascii?Q?mSLKm0YQfzu+jqN3lcHAKHa6yu2xZXM61jVSw9nhuPs0UotrbO+ySNn8rQIt?=
 =?us-ascii?Q?ej99BnnsFYgIjIpwZpdbnCtZr8rM8WkQ4eWppTZT0SaCEBeqJBKIzoSivt+I?=
 =?us-ascii?Q?8jlkU+5T/YJ8P3yjdW6kpq8ued5dJpBI4YRvUWV448XFj4V5+0Jz/Nq7f1ym?=
 =?us-ascii?Q?ifSvqTdZD8alx06zcK3oDbCriqgB8wdCGl8UBL0lAPsY14GDzKnxWtQ6Lt9y?=
 =?us-ascii?Q?IUlHFQQbJZILrEhxqiGhmzRW+BSPDmg+6OzrxFMWADqnPNDRDDKnLlmRGqQe?=
 =?us-ascii?Q?D0AeRm/GaQ3cGteRwNf/RgS7v09TkOqkGpgKY14+E1lfpRsBATQR5JJV02mu?=
 =?us-ascii?Q?bWUeU6jovdCxC6YE6vm4dDwUzeHuElVH50PRtb/c7HI9xCa0KWgl005y/ddx?=
 =?us-ascii?Q?DVnCS2sUdUEiV8ebmT/rIV1eI0flz00BWHo/goNfjGbArKK4mJDzVCPP9E7e?=
 =?us-ascii?Q?jbZ7gZjlwpAbyXjdbtkbI78d7vIiSqfqBqcVhUDzf+cyejkrV58rXcQknULk?=
 =?us-ascii?Q?aVrpe0docbJjeAAoVrIXsOGRmI447qWe0UhuVFKPs83MzE+gxkmQ7vINJpG2?=
 =?us-ascii?Q?biRVabjytAx4KbwZf6K9/uS4S/EXdKyMK52xB637Ank4veFO9jR02PzhFmeH?=
 =?us-ascii?Q?ohGCQrbTlXqUJH5m6Y2i/LzOuv0ZKwE0c4k9I8oDYvkGo8vRQHF/uv0//yPQ?=
 =?us-ascii?Q?laGySD6fitWGGR7X32p1keSMZuef4v8+1+M7WR1M5CaSnlYfem/T4RyxkF02?=
 =?us-ascii?Q?jygKOLJ4Yw1SXxDNLexpja9OhSnCC6+icM17z1oZEYTKl9Kq6X8XjGrgIjEM?=
 =?us-ascii?Q?pdbIdpVE21+rse/9UcNGewV3wbKu0i9r/Kf/sHTkclvJ39uO/D6pCl9WXCEq?=
 =?us-ascii?Q?NHfNeD2HPBQ91fsRUPRboyozMUKBf0Vnh6sF7jbih+DuIS0mhdvWsXoGTPws?=
 =?us-ascii?Q?yOVtQ5FEUVbBWa9jykM+2FMqnYN7AXGJOAx+noRKUlWftO9Yb1dAXVGroqog?=
 =?us-ascii?Q?wWMk6rwYrhiESEbTApKk6956CeHKGwbcPZveY750qSnOhD2KZdtiOmQ22DZy?=
 =?us-ascii?Q?33eS/JKlt5/b1v/WRZCOLdYuJK6lLkjvFtTXjX0VCT1Tg35O74vqYadQPtJk?=
 =?us-ascii?Q?GDS8CeaLfYq0l2+GkXgHcM8eOc/W7JtnfQ9s17Lo2Lar74mR0ALGvhqnHl2+?=
 =?us-ascii?Q?K+F3Vi0q4youcTuF2EKrmlVPNuu1gGbAuaFD7N/n+C0ADHaH+QTJcGqD1Gfz?=
 =?us-ascii?Q?/ybApOXz+PWjeyECiH3yXVU6zBVgxCdxfpOn0qWb3BI3JOCu9Eb22nNnZKuF?=
 =?us-ascii?Q?xGnTz99ck3Y3zBgk6PXJ5h1WNlLuTSAHq0mN2DGY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c512cea3-ca7a-4016-b5ae-08dac3948e4c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:26:44.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/r9wyicq/SKuNo+6pFgvxJPqN0Y9LTiPoPdmjxrIltg0vQPZq+tlP7dQlF27WPcWJGHgKpzpExq6KL/KIxGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Use mmc-pwrseq in patch 12
 
V3:
 Drop patch V2 3/15 
 Add A-b R-b
 Sort order in patch 9
 Update commit log in patch 10
 Drop #address-cells, #size-cells in patch 11
 Use off-on-delay-us in patch 12
 Update patch 13 according to patch 12 change

V2:
 https://lore.kernel.org/all/20221024031351.4135651-1-peng.fan@oss.nxp.com/
 Address Marco's comments
   Update commit log for patch [3,5,9,14]/15
   Order iomuxc in patch 4/15
   Update flexspi node name in patch 6/15
   Increase i2c speed in patch 7/15

V1:
 https://lore.kernel.org/all/20221020095934.1659449-1-peng.fan@oss.nxp.com/

This patchset includes several dts update for i.MX8M/N/P-EVK, with
only one dtsi patch to add mlmix power domain for i.MX8MP.

 i.MX8MP-EVK: Enable PWM, uart1/3, I2C2
              correct pcie pad
	      Fix pmic buck/ldo voltage
	      off-on-delay-us for SD
 i.MX8MN-EVK: Enable UART1, SDHC1, I2C recovery IOMUXC
	      Update vdd_soc dvs voltage
 i.MX8MM-EVK: add vcc supply for pca6416
              use off-on-delay-us for SD

A few patches are directly cherry-picked from NXP downstream which
already includes R-b tag

Adrian Alonso (1):
  arm64: dts: imx8mm-evk: add vcc supply for pca6416

Clark Wang (1):
  ARM64: dts: imx8mp-evk: add pwm support

Haibo Chen (1):
  arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regulator

Han Xu (1):
  arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk

Peng Fan (9):
  arm64: dts: imx8mp: add mlmix power domain
  arm64: dts: imx8mp-evk: correct pcie pad settings
  arm64: dts: imx8mp-evk: enable uart1/3 ports
  arm64: dts: imx8mp-evk: enable I2C2 node
  arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
  arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
  arm64: dts: imx8mn-evk: add i2c gpio recovery settings
  arm64: dts: imx8mn-evk: enable uart1
  arm64: dts: imx8mn-evk: enable usdhc1

Sherry Sun (1):
  arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  27 ++++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  41 ++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts  |   4 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 110 +++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 117 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |   1 +
 7 files changed, 301 insertions(+), 7 deletions(-)

-- 
2.37.1

