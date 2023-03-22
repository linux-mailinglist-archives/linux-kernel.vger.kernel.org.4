Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25D6C448A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCVICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCVICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:02:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350C5B5DF;
        Wed, 22 Mar 2023 01:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XySYai5WphKe6XcsyYUa+2DofhoxgkjZ/7eapMg1/TSW/Do5HBq0BcZe2A3wlYJPivEWbQ9kEqrI4hS0TS4uWVtBhFhPjaIavKZMlnt3sNYKNgZSWvAgqWOV/tYWk5S7/ZExu9+kVA4+DETjV1cIk4SM4jPkSvtLtHZHFA/5tF4/ose31CLqrSexd5Sa/WUKkRCRXbKFC1dq9tslhm6ZOZWD6vbiypn6FLSYzyyxSo25wWbZbquP17Q5ZSuUep+ADrqgwq+6LgKKdWuyI1io7KMY8+Xdi16Rrv7o2g45yPVaUyPZmSB5OHw066CUTe/9qAnznBtyWBA/6SFGiIBLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2YIqoCKzqq9+8Pv7YubZ7D83YzbRV83HPTI6+WInKI=;
 b=GAH5/vIBa+AsRXBm1KvlabYgsjszCxtMKXQtb8/GA8EtaUIKSl7ZAkA+i7rICvfAIxCHL2Qvj2/3PD0EckoXIJ9CpLRegY7Uj0gnttp/q6XH6NV/kc1w/2VBEfIbnZGaWJN5/bm1796+QY9tZOxEh/laRm8nPP6A9F3BOB+tBavsO+wWgATBwui8rFCwVRiVYBLpAZCbyfJikZLx+yoxCMC9Fq9qW8+4+Kn5QyKFldYgtn0dyauPQf7hSxP3d5hBZHBNFfml0OemerT5dfy1m3jy6pcURqbaF2P+FUEB6hlYDJ2DCa0RWSCf1uZGOAs6h3UrpluleZg8NUpv/Gk/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2YIqoCKzqq9+8Pv7YubZ7D83YzbRV83HPTI6+WInKI=;
 b=hd6FEXpAteCNqR5O4ysyf0q5EFPyvEJoSUaeOimEV+r+YNHaVHUwpfI6XVD06Atqqu33VQllWzqm9yrj/CvBhfKLIkzw1Gx9TNJ+jSW8cAMsCx/+6p5DQaeuvoGj4yjEGdpFrFXSbbHmZVPBkI3CPfrIGVlpQBvAa1yI608GrEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6921.eurprd04.prod.outlook.com (2603:10a6:10:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 08:02:19 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 08:02:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcel.ziswiler@toradex.com,
        alexander.stein@ew.tq-group.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx8mq: tqma8mq-mba8mx: drop disable-over-current
Date:   Wed, 22 Mar 2023 16:07:21 +0800
Message-Id: <20230322080722.3054508-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fc0341-04e4-43aa-0573-08db2aabc1ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnaUSEHiPsKHCisJ73SwC5mSdEPh/2sd8QSg9SVzwW7uzawhr7+liZjgBxgU11/0ONSQr6BvMVx/Usv5n2bkN3JzR9nFuCpRQwpzzNdHE/4M+d6o4Hku54ydR4GFtRRcEcV/RxLFmAz17/U/YgT6eiHnC66PXd/ZK/nk8ZMj1iCbsek6errtXHu9zHcSOT5wgUNYh5z1or/kcHAp7sFjH5OsO0J/6hhfAgg6EOW7f9UjF8xc0V2Wqoqr+9toEWN5gXAW7sOMaFOUYH7Okp+RkNYdrvFjktUVLu2ckRLpnaX9zXWk0YT5B7d8Dwpg5UCStXvSvFtz4Y98NPKdMdCq6KeZwRu9u+t3kND/rgBFYhzV+sw9g4mN47eeXmBIDnAOlorVbeg8QzW9EXvxo4OlJ/WtCCowfo46tk0OqR0RSeQgJ2vOHu/uRirLBXVMby+WlgLsWz5fd5oFPUUNFdFm77gv1GFIQwJAzfBNEHTT5HlAmSlM6rVXHIqbHk5eoaSn+0118djLeko9GnDmpoGRUMBh9Dte/iyx+PqaJjLelk6IBAAgWEgpTtgA4YqsENcwmtraJBzmOOvEOTdCpoj8kdkljGLBab7zHm/DyexpNPdu2f0JUcBiMjlTg+z6DqXztVog56Z3eMJQk1l2z9WdDPq11dvQDZXkT3zKGSkPtc0ZW76BRgK+0TAle37XtjcM3AQewcCf4aqK4qbGpXD55m5gJ+GFk1jsTBODJjqXFqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(6512007)(2616005)(6506007)(6486002)(316002)(478600001)(26005)(1076003)(52116002)(5660300002)(7416002)(6666004)(186003)(83380400001)(38350700002)(38100700002)(86362001)(66946007)(4744005)(41300700001)(2906002)(66476007)(8676002)(4326008)(66556008)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/yKfgcsdAB/VUjfIBBSVOKYm1xhxhisnjwN+D1YFCTOsm5GmgD0uni9TRvy5?=
 =?us-ascii?Q?VZIiUr7CSJ0eQ0BA3q/zZ262200mGzDhr6LEfTnArqg6StJ1/9rrriNdRrQM?=
 =?us-ascii?Q?/vQixMpEUCrTGWEBZXUZIxNkNuc9CzsxEChFoxnApMxp/PTazuB+UoOJ+rsa?=
 =?us-ascii?Q?dH+snKDiJxNNkTDgVS8g/2PcVxm56SPTbvU+YSvo9DgXmXucGgf9BUpiQ6y5?=
 =?us-ascii?Q?4F63V72eppT9otBFXQf7xR8xRcMvBhj10qexUsGZro6/sngVZzLpTuLrBQ88?=
 =?us-ascii?Q?3SecqwLq1zrGg2mH2qFFRmZBrbi6HkPDFztp5dK0PvpvyYlMrQE4UM3xzpNO?=
 =?us-ascii?Q?DcVWXi9g9gRs1gn9rX7pCo1xY4Mik+eU62eWdUawHokF8+0z+J2kTjNoiccx?=
 =?us-ascii?Q?REuKgGu4HzPPz77xoLz03q/QX4hXN0sov1ExH+3RkLFgNq+adCSgiL9PIeow?=
 =?us-ascii?Q?gy9wQGXm3Ym3unCXW5MdOgeCMuUhPRD31c+zBy5zWOF9E6Z9nQk9ShqIfLEQ?=
 =?us-ascii?Q?JIvcL2BOh34ZtL7diP4GJ+QdHSIcpcGK6YNrQo+iLKFgk1q4zzGJ1QuBjrjw?=
 =?us-ascii?Q?ts5123M1ItdlrTnQo7BRzjllT9FBMOKD4Tzx96sB/OSdyKMtJN6tfm7Cd2JR?=
 =?us-ascii?Q?k5XSEbbRBjAAonUZyHPrc6LSar6m9Bqs+MUjk6tNaCtVXgbjrkHnHaTvxMqU?=
 =?us-ascii?Q?TLjQy+/+xlCxfUD7ZXPQgvvp09V+gXEEdoCiTQ36cnmmfSFltSPPVqXhzGZm?=
 =?us-ascii?Q?Eppt2snh2ulyOj1dX7ilbiljlEFjtJT2zDfjdrhBxza2eBPi03d1eeNE7IAF?=
 =?us-ascii?Q?T69Q+O6+HCqRbW2ZiIm0hjz6L3k3UyDOfk4Z/LJMjeTKMNXdP93LIb3PeuBP?=
 =?us-ascii?Q?zPKw2VBNlDGeahCwNRKgBI8P2G4JGdXfMAtQl8d8QVyMpPRPpDokxl5bsjnQ?=
 =?us-ascii?Q?MtSSmzMQtkNuLt5alebA2fnMaDLa2pI0POq/vqExhdJVV5skpvDEe4tWRnCR?=
 =?us-ascii?Q?KVNGvsvB7CdWwDtgnEryZfYvJ54Kapj2khjcQfBk/eE1ztNCpdvb4lRbC6Fg?=
 =?us-ascii?Q?bXOxX9He2wQmsxRnO8/U2p+gM2fpHco70HWrksZJPZmvwA8bMTlDulfC0h1u?=
 =?us-ascii?Q?xE7T1xKZEMKeMAC4m1WQV39tjS/pJ1McjMWV0C7w//3H3nhmR7uHS6kvudlJ?=
 =?us-ascii?Q?Kye2OXS/9xMFhcce/F05YYXAfnsPZ5T3ph0AZUzJInpE+LbdPq9yfR6xU6Sx?=
 =?us-ascii?Q?rZGc4DIHzHm1aGAqyasor/sfZmUVC/E+8x7iJ2384HHdCP/mR0Vqy6IqYYhm?=
 =?us-ascii?Q?63O0jqnN1EdMaruL/K0kJsgXmeVFc4CiZRNX7h+vN6sJ/c5NhjQUChftY2UC?=
 =?us-ascii?Q?qgQ8e4FUEHdaGHeL1WfzXI4PnrBuI/TlvLXjMyIhxbZEb9NgtOcYIiZAlwmT?=
 =?us-ascii?Q?KxIkD93l2Jv/5ucMr6ilLN0dKj51CjKeIc8EaC8zH8l+q1uQ0A+RRRTJKojM?=
 =?us-ascii?Q?UuMBBnfYfeQerxVtNb97jH+C7MypMS9/SQzI7gfR0RPcOdctBVJw+ss+6Md4?=
 =?us-ascii?Q?JJcOpKzZoHPE4vl6ByBGpQR4rL8yWNrrbNJgBwBA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fc0341-04e4-43aa-0573-08db2aabc1ca
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 08:02:18.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyEy+dREZ65E96UVSiqefj81+KcckKfi0xUTSQDDzRAG6+6YtzbwM3HttxDtjiZ1sOubrrh/5lzp/R3fEctTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

disable-over-current is for chipidea IP, i.MX8MQ use dwc3, this property
is not valid. Drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
index 344cfdaeb1d5..c5244b608524 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
@@ -169,8 +169,6 @@ &usb_dwc3_0 {
 	hnp-disable;
 	srp-disable;
 	adp-disable;
-	/* OC not supported due to non matching active polarity */
-	disable-over-current;
 	dr_mode = "otg";
 	status = "okay";
 };
-- 
2.37.1

