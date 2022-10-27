Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3690E60F892
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiJ0NKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiJ0NJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:09:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D3E1BE83;
        Thu, 27 Oct 2022 06:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQttXIq0mmlLbj9g1d2xDtLcAKTCXXIi76Pj7aXO7dofEvMhUHF0RMXnQ6TT6ZOD5RKJl102ysbnLuIFyz4JDuXzcc1YoPzWGwaS9/ovDP82y2fyvk4iRFhem2ZiQHyLXqL0AWUPGXpeM7s4PRYAR8O23EwVh3qcTeoTbTwFJU/Bc6H9JvIRaAxT36OHYYb8XRV0W5Z6g442lOdqC+4SU04Stz2fmYhVqxgErEv7qjweZqmKGClE28uTM+a2kDztUjnUBp9eogVs9Bc3cj2IE/dQpX9eEPjZ9bRzqUdx03rowf1h6/rDpNOWGfIv7D89djYFSHBXvcsFvQEzqlHV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51WfmV3RvovoancdvUSZfJs+kVNsfjP6ZLXw2Wo0G2o=;
 b=bsJc6C/Cjp/b7stPecdsrmFghL6jH4zIoXtuqptUza03O3AsESyaUu7p8ztUTIqgJBe6/svAGR7tGCBcXG6DpzOBFTdnX1EkDJ3vX2iPusexhlYxXUUg3t+TpmPqbbDbi+s0cfM1xxY5MdPlmfeMqWEovI/sEfbRUo7/ne57yVb2kZc/C8jrDWKKC4xeoQBUkMiCw1vH8MkD+BXSr+s8jeuHi2Q6N91VlqCay+7fOdl+wcQdLt2vjq823nZSPf4v+smbKJB1JVKcf0SU6Lj11dhAFmMer00LOrSaTYrkeeY0VnUncz25gmw13XQNHWUT4hkdNxY2YXKZk346gcqT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51WfmV3RvovoancdvUSZfJs+kVNsfjP6ZLXw2Wo0G2o=;
 b=DP3H1y0gqk7PyIdvgk487h7eeMTpajVsmw2rYV/gTO9YFD0x3awFehUJuwUcrCo9XTFjk7/CYsVNsHDfDYRWq7btKF1+sLtX/MRDFoffXsMG6QnPuaEZjAZ4eHHRzvHq1sUOWnpvB0B9RrrQLr30S+fQ12VISN4mkxdw6AaFC8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:09:40 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 13:09:39 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH v4 0/5] gpio: add suspend/resume support for i.mx8x SoCs
Date:   Thu, 27 Oct 2022 08:08:54 -0500
Message-Id: <20221027130859.1444412-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fcc593-91fe-4cbc-a5fc-08dab81c814c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzPwaMZkkTfNPiZ7fqZ7GbzR7FJ57iFeJb1j3CJ2B/r1sNJ+JhhyvaCmi5TW/y0rjmy4KTMetHQYOWakKsbzJZRnvoy0U399MoWtsAbUQT1jwIOjREKv2MWBUooAx/vsl9vcZhKRP05Lij8cY4JpsO6E60tc5+XAzZ0Lb+saV4ynSQefA6/2ZstNQ5V2jU4tvkHJ60uqkX3BUW+JLYBIR5kuxAx1iysVvnQLDhVAb/u99XAJ45SdYZbZBlKjhlY2c/r2V2NmHuj0k/MGTa9djuknI3ZwnvcvWSK9Y1GE/iOsj4E+VzdevZyWAceIRj5VwiP/8Hm5OX83k057ZwxygVaLxNVPspZHdeDYBGdXKyzWkFSNO4zKh9pRYPu0v4Zh5eSFrLiC4FfdcjJQyNMVoKkI4yKOgWgp0Qv/ER4045epJoEjdD7fYVj82bh7zgasBavTYJc2rL0SAbNiZJvwBpkCr7mJylzJKl+Um88H1r/wyrywFDQi2teakRQ4bCalUBVShJ+Q7pkTsGZL4+yVSx7U5GKCv5icfdDajI2TtXvQ7j0WhM787zJJMJY8mMMLPMx1ncu6SOR/dwVRb9Sg943UvwpzH5YAVC/RTn5kco8DIQLWOX+ts3tfZ5ZJh13x51WDhRFhtvJu6WHquOFGtFUvJz/lt0IImSUD9NT1CCmR5iqZvKAfTUORIOr2pQxE5erKEawgQFu4UFAbtywxRICQI0yr8s62Qg98sueGbQ+mgUmtswpNHXqW5y5ndfi9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(55236004)(1076003)(6512007)(26005)(52116002)(6666004)(83380400001)(6506007)(478600001)(186003)(15650500001)(2616005)(44832011)(2906002)(6636002)(5660300002)(54906003)(8676002)(110136005)(6486002)(316002)(41300700001)(66556008)(7416002)(66946007)(66476007)(4326008)(8936002)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZ9AHKgk9O6DgaLVwI6ERaEmFFKQIL8SmdB1r7u5Aumex5tJhIc9oOBIN97J?=
 =?us-ascii?Q?jOJhSU7qC0GLK8A37V/uTJQ2+KWq4G1qh4j6LPdm5W8h5La3Y/yIzDIBS0/a?=
 =?us-ascii?Q?d9y3UdJWd4YhXPY+nhgzf2o4BrqNE1Q0yURZRvHSax9kLkeKp3Ul+hzYAap8?=
 =?us-ascii?Q?ClpTomJ61eiQXYRM2lxl8xZsgIuMgB3WHugsQ3+ClgfEogv/KW+I83sp1DRF?=
 =?us-ascii?Q?/TeZR0icWxUwYETcnUD6buZxSkQTTJVnLlfLD9D/fadyfgXLu7FkFXYDukP5?=
 =?us-ascii?Q?qbYH8vRziPR87AdWOwdbGdf1F11+DaXN1smBoF5yX7pI3Iu9D6bOj28Xqg2e?=
 =?us-ascii?Q?AyM0Md6md25qxJjoLDWInTV209yXD9wAzjddYgdUMnwvAu82OJESQ1htciMm?=
 =?us-ascii?Q?kzKT7wlOx/Ia6znGVGa93ElO9X3iFJBc1Qdj34A+URhdX7b2ePdI8rGVyM2m?=
 =?us-ascii?Q?y/iRiA+IXayTB8so8lk8nRON+tuuOL1fXRAyvt1Ne1FhhTvnVR0dFpOFDKHy?=
 =?us-ascii?Q?hbrI+qGoljkUlu2Ua8ckM6wkZ5OQezCuBI0rLACslmaDSpJLnhnhvRsoY8uf?=
 =?us-ascii?Q?YY25nH8SLfMOT/DfZFL2KrDqN2AruM5BLQaS+Emg/J4C1pfdqrEYuUtzleJ+?=
 =?us-ascii?Q?jO9H/Lge+2O3gaK0l7qjA2x2XQQVMUZMc3DyWQzRTJTDWEAC59kDgM8WTy2j?=
 =?us-ascii?Q?sjOqZO9inx0OPUwZHCJLVQiDUY7HUUp3Uo6Z3a/Lp0sdzIR2uV06cJV9+XIt?=
 =?us-ascii?Q?yQ7PRy4EpwujxR4cxsh6uWBIcUGGPhi4mgC+stVUlrB/3BwoE+5I4VYQOgNi?=
 =?us-ascii?Q?oGpDlyPJ5TSZ6SNixgq8Hk4OIap2OygU4j83LyIsEWQppA993Moh8hlzMcgW?=
 =?us-ascii?Q?DWRp4P4LsmfT6XCIufccSUp7kQkNYuqAvneZGYO9b7IZ+ksS3RiAx1sdwIWL?=
 =?us-ascii?Q?/LdJlqZChnqqgMCpyyTfDLNgbQUEVGOd4GN19Sor7C43QT3lECeZhK7RnSFT?=
 =?us-ascii?Q?c/pjzL/SdlxlHIbgkkBoEMsGGHu1nbo1UTfhFvTCFDDEXVe7vwgjreRvA2sT?=
 =?us-ascii?Q?IJErFbSDFQxvSRoaLXvAzol0/QZGyzK2ek9LYGgSTK1nJX23mKdsCIQySTr8?=
 =?us-ascii?Q?+7QIwU3z+1ztaM+EFIrkKG9bWAbFAJAnV0ApXAz/IFlMTmypDLeqRBkZcpxy?=
 =?us-ascii?Q?7aNQJkwnvDzM5x2Fr2pGOoq1kDSJG1VfTba3U3+pR9aCMhIyleferfvaHUxz?=
 =?us-ascii?Q?bRj0r3q3Lh7xyNZksAGFtPU4/G6jIfJNY+1p8oojCszkLNul97IFgRYwlI00?=
 =?us-ascii?Q?We/OhY+cUwhoKnKNlpMZe5H4TyEhZh+35xdrgPluuxDd3hqRoxa/lWQkJheI?=
 =?us-ascii?Q?oJ2SXj7t5Hsf4WlJCjzQl2lCD46785eeXBnOtPHlRIGWYIIKetoOaX7WEs0j?=
 =?us-ascii?Q?HtfrfVRF+HmxNXlWWh9s+WS171XYmQ+fUGGdgT5lX46pCFfGHQPfCYhBjYfe?=
 =?us-ascii?Q?HwV/Hqgsc99cKg/YFRej9lEwA/OFkRU9R64QkK4CCBn1zN7e5HJWYucioQSk?=
 =?us-ascii?Q?ugX0cZovNnfn5UOwizmMLMuSh8JNJRl1WZjdT7FN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fcc593-91fe-4cbc-a5fc-08dab81c814c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:09:39.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3ZPLMkni9A6//9UYDUIX3P7sHO5iP4Qp33xiQU7WI3M1tWnfHpd0afopUiF0MKJKu4QVNZB8WbX3mgPNK/UEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source,
the GPIO block will be powered off when system enters into suspend
state. This can greatly reduce the power consumption of suspend state
because the whole partition can be shutdown. This is called PAD wakeup
feature on i.MX8x platform.

This series of patches enable this wakeup feature on i.MX8QM/QXP/DXL
platforms.

Changes in v4:
 - fixed the format issues reported by Peng Fan.
 - change the return type of mxc_gpio_generic_config, and limit the
   suspend/resume behavior changes only on i.MX8QM/QXP/DXL platform.

Changes in v3:
 - According to the feedback from Linus Walleij, the wakeup feature is
   moved to pinctrl driver, and the array of gpio-pin mapping is moved
   to gpio device node and initialized via gpio-ranges property.

Shenwei Wang (5):
  arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
  arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
  arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property
  pinctrl: freescale: add pad wakeup config
  gpio: mxc: enable pad wakeup on i.MX8x platforms

 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 41 +++++++++
 .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 38 ++++++++
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   | 25 +++++
 drivers/gpio/gpio-mxc.c                       | 92 ++++++++++++++++++-
 drivers/pinctrl/freescale/pinctrl-scu.c       | 30 ++++++
 5 files changed, 225 insertions(+), 1 deletion(-)

--
2.34.1

