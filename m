Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC575B6A92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiIMJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIMJUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:20:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CA10FC5;
        Tue, 13 Sep 2022 02:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGpxdR3yppi2/uHMzXWFaRCPhEL03rxOdNJfe5ewx5H6EHhO7ET++OiW/1lKGRF+mvnauOibf8i9o3avx4rXmKC4PG9mxANOpYBPWhdT5Gk/BW+UmE9VdOsOIiaX4fuTbM4PdEtaHK40SLctgGG2LQn+Urhf1m7eBs8KRO9eNtEJda5siU5DU3KWstYadqa+s4lVN2zMpzqR8EUuttoFtwRN/1u2R/OLtRlOfmYWb6dbsT/WyS3okWOB9ZOVd0fqwMTQAkJO/iievVSGZNwm2aZXV4L3/xa3crz18ooYMTBHeXWmBZmmTCpn6oSmoAFoYVeljFb7THziP2EThUQ3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IBb6lnaXNJjq8IoQFYUSG7HUItQo4M1OYaH1DPwSlQ=;
 b=VQl4YIxnWE1KxmtWNh7h9Xtw9scrNWdd2bT3Gz+28pKMeIhLZ6EU7hjdofwmDm8QCcqUFwjQBWbVRfHWjWMhYWl4kW4MvbcIEjyEkn3GnN51tPtvZfvYVvKcuZYV4eXkurzPpTIQVhwE5HDG6qT/nt02fyp8AIh1FdItQsDFKTsM9fjDOYO4th8/Zg0LB6pbV8geKyM74uFJqloYBmfC7zRdgnweGfd/LvvW/YOgAgCTPlBr7BpIqd4TyfrBfZFIptmU6RgAckM8YHUVsa3IuOjMuRviaPDQczl6UwZMxVc947spvswm6YO1ehyejn2ZTPDtomhgFzItYni6bhl0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IBb6lnaXNJjq8IoQFYUSG7HUItQo4M1OYaH1DPwSlQ=;
 b=PwxjupuQtWwHk7s3d+tJOThmMhyvboIaO5cnhxPy/XAVMiPgI/OIxo1Us3JU25pFgpl1b/mQ8qoM5Ov92Sw0JWLoSZqTTan3oK+2mxXoxkwS3am3C0xHn2P6Z4On5zve4ovkMufmMU2FD00hMM1w3jhjP5E9r9qd1yaCz96j6oQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 09:20:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:20:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/2] clk: imx: introduce fsl,always-on-clocks
Date:   Tue, 13 Sep 2022 17:21:34 +0800
Message-Id: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: b8efc3c7-6086-49e3-723a-08da956923d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ediNQxEzkLOe9DcEHS2lrrFVPV7siQuwJJwHRWrBpuPuG60p2p6wrwOJbD+HoPXpP8bLUB4u8o8Rhq0hrrSxUH6NMqRDxsXDSA3oQ+0I2/SXt53NVgw+vrRUnJrSRt+a9lxfk2y3gZzLjCu0tqVc+zyLTJWSObXcL1WY1tjJSvxgepJgW+RESm42e3eD+OWOZTGb91HEyiudFAD7vWbifaRh+1Nwih8LvImGuh13ip17+bx0RtjCEm3Wbk5hdddTKMbg1bfAVUZleNff0w7SIbp3HZePsP7HI1IbpzqSOTdYd5yC9byjzgdSZlcwSkCW3HbOAH9H0CI/prT0iYA64Nx/95hSAPSjUxXxc/blxrVQSbbEI4VVvUjkhPIloreEct59xRpOh9ajYTp5ary6IST68tvK+G0Tr5BTc2w0+4eoHFMGExQL5RI6IjV16f7U1xLm1dwUrULCbfRByc91Rwh5Dfc9wBeHn5nJUOGDJT91Gf3HlzJ3SmSSrK3J81dH/mMxgYnz58SB6xZReLwzf+9Hlywk59frCOMjbUt93gjBw2BD/AVd/gA+5sieWAs3XmWk/62q/7CRUTDzzuPYagkQkD4CKhwLR+YmJa6e7HcpQAd5ZDEPrdSrSGffHxEX6w1SOpTctpkq26ybLJtx4e8Qey1ASHurjCogXSj0OSreO3ii6sUK7jchEqB6Xtdb0ZpiPm4OhEqJcx/BALRvmhEpc1WMakMPmrJskDRAlHuMN1Nkjlhyp5bMUvxObN9TLGsheAgslPicWmdec1MGb/3mTIptLKoYlr6BRl6jcbrauwfP21aCF0bj3kOB0oCZ/3g1MdlCnzMimMlNRkvNtZK5pB3Yi9vHPVvv1XsWw3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(186003)(6666004)(4326008)(316002)(8676002)(41300700001)(83380400001)(6512007)(38100700002)(66476007)(26005)(52116002)(38350700002)(66946007)(966005)(6486002)(86362001)(478600001)(921005)(6506007)(1076003)(5660300002)(2616005)(66556008)(2906002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+JPVDgB/67f2oiDAgKrdZOX2MhG7k6l0t/nMB9cKDiONTb6EOX13WLO/zDS?=
 =?us-ascii?Q?N7NpIrWlSzzqAEfn/kVtpxk7++rx5WwreKnQfMH0K6Jdo03SMOFRUZIS0J9w?=
 =?us-ascii?Q?XKMvjwX/ZOHgS5BiLkttUuqVbDgNWeQeAUKVXRlTHcUS9VpbIwwZOSB5jQAR?=
 =?us-ascii?Q?P+pwQxE4axGT+aB0Pfn8OIvgJqm9zgc/lUfRcMdt8LR2V1mLK6Aj85rHwYQZ?=
 =?us-ascii?Q?RwtcGYxdVAk+DxY0paU8IWOY4dzNtSaTAEJLxDltqmRZwlBbC9cE2m7NkqDT?=
 =?us-ascii?Q?UMnAnJQV92DyYP8MANnBendYOX7OF0b4BEhhdH/lJpH1Nl/EemaEbabKSIau?=
 =?us-ascii?Q?ZkkthgfSIFlpiUKW5Zkw+/nLblPyneZqd4YsFflFKVYAuM4svB22F2j2bfwM?=
 =?us-ascii?Q?yG/ki6297bxCFK7EEgl+trI+fAulcX7AytaBoFQ1tQEmJ3yrNBrB4+Ezqt+T?=
 =?us-ascii?Q?ngyjWX0KqXK8VTj18iP/2JJLyszem0+AG4hxZSNh8QRGeJ9hUWzAKpCFYtYi?=
 =?us-ascii?Q?WFi8DDzwZYWkYqiPnLwLoI8nLMNiegnIQat0EwUHzhfoM5DSUF7d2ZGUvTYB?=
 =?us-ascii?Q?Xk3YpWfbcd9BJ8osDffeT/kabVWzw/M1PBStkUK3R+dN62cKS6bvMelO1SHW?=
 =?us-ascii?Q?YjOXgIUCkIcPIlUd3p82OW72duKA3rSVwMjNFbVb2gWT1ph1FfJDRSCLtrJd?=
 =?us-ascii?Q?JoEH2iK90TMV2Xeun5ovu5yj627MlkbiPpl40lYkmSniKtqF+VnN3Kmbm4K+?=
 =?us-ascii?Q?ETpGtc9s5tOE2VGLlpcdWa4e+H58GgTWPJY5EA/Zgzq3npw+kY8E1DMx6IHm?=
 =?us-ascii?Q?t059KiUQsl75tERMd7/kFx27BhZxMSUAPhO9SCkpO0/NiuCiCdIim4GO5fVd?=
 =?us-ascii?Q?e/zJJoelIMYTti1p4g4g+R3vlr3oTduNEzn4CH6ALCaSjOgbgWpdF0+2Ix/4?=
 =?us-ascii?Q?i8BfO8/S3yLb1/heUKN9dbKab2j/hwCeazgSx07DP3U1VGzMWgLodQceU6Z3?=
 =?us-ascii?Q?5FbKgYrQnHp8o6B4H2HmAQece+H+lFAEM8OZAASB+Q2yC1yMRx/xTsFKVy/Q?=
 =?us-ascii?Q?R2v3XTfk3SFl6euCJ0DWZT43/CjYY8B03Sfh6jteP8SU2xuwBe8+tj7hxnVq?=
 =?us-ascii?Q?GdMao4yH9+hkHYWeq/B9e7puee6mqxTvqcFbAbr1rWXvqitJbADiPdhO8oc0?=
 =?us-ascii?Q?xy5spGSoncNUp63Kv0BAHMKSCE2KMVERRovtefLry7OTFj5O3qxyK4zddhHd?=
 =?us-ascii?Q?6wBRnADFlZ5TaRx3EwcUp968EguSGcfxnVPUCqg0BfKVldDZcSSlspwa3IDZ?=
 =?us-ascii?Q?I0XTVbyXUOSLeLwescZM1xDH+U0+njyBpw+r7ZXStx32w1rMgVEt9PyCDWRE?=
 =?us-ascii?Q?0eKIawZtw2q9wFWXPk1YtOPpalzDvGto2oAIsRo+u5rfYFP/RVD3WquQ6tOb?=
 =?us-ascii?Q?fh1QUHJgOiUTXyLjkm8cvY/3WXQ4HMBXti+heY1QFssaDDF5W03IxmNCLM7r?=
 =?us-ascii?Q?Z7llNthnnKSIeU0tDq24sTDheVXQKcbvJFWtF9d/Y68aep/sUtycr7pxTOWJ?=
 =?us-ascii?Q?MiVz0lwJaYlUnoBJGF6H+4ESpezRopuW+th++AXK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8efc3c7-6086-49e3-723a-08da956923d0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:20:03.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pQ7Kxs32jDniEJvGILMZhR9gumDy4ACLVi7A3QUr19/cM4W0S6Gs8MU9nYOk19swmIjqdX8Eqxw7sck5ZfhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8790
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Rename to fsl,always-on-clocks 

V2:
 Use protected-clocks
 https://lore.kernel.org/all/20220816130327.2987710-1-peng.fan@oss.nxp.com/

V1:
 Use fsl,protected-clocks
 https://lore.kernel.org/all/20220815033632.1687854-1-peng.fan@oss.nxp.com/

There are two cases that I wanna this property could serve:
Virtualization: root cell linux run in parallel with inmate cell
AMP: M7/4 runs in parallel with A53

The major case is:
Jailhouse hypervisor only support partition, so devices are partitioned.
But there is only CCM module that provides clock, the CCM is handled by
root cell linux, need make sure the root cell linux not shutdown the
clocks using by inmate cell.

I was thinking whether need to provide a rate entry to ask root cell
configure the clk rate for inmate cell. But NXP downstream not have it,
see https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/clk-imx8mp.c?h=lf-5.15.y#n690
So just leave the property as uint32-array.

This patchset could also benifit AMP case, check the two commits
commit 19565ea12d61 ("clk: imx: add mcore_booted module paratemter")
commit d097cc045b64 ("clk: imx8mp: remove SYS PLL 1/2 clock gates")
Although I not plan to drop the upper two patches, this patchset
exposes opportunity for better power consumption.

Peng Fan (2):
  dt-bindings: clock: imx8m/imx93: introduce fsl,always-on-clocks
    property
  clk: imx: support fsl,always-on-clocks

 .../bindings/clock/imx8m-clock.yaml           |  4 ++++
 .../bindings/clock/imx93-clock.yaml           |  4 ++++
 drivers/clk/imx/clk-imx8mm.c                  |  2 ++
 drivers/clk/imx/clk-imx8mn.c                  |  2 ++
 drivers/clk/imx/clk-imx8mp.c                  |  2 ++
 drivers/clk/imx/clk-imx8mq.c                  |  2 ++
 drivers/clk/imx/clk.c                         | 21 +++++++++++++++++++
 drivers/clk/imx/clk.h                         |  2 ++
 8 files changed, 39 insertions(+)

-- 
2.37.1

