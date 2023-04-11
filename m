Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1D6DDF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjDKPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDKPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:13:28 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437375FD8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpn98CScQo4flTGepuHvwrKT65BeiehJUspC/pRGgegbN07QxJ7dS36iM8zwQ/6QmmPbU3GqgBldmzCAFrCtLsxjp/xYjohFPmrmiVb8QaWAP4urjCij/TciaDD+G8h+U7ECSGC8yL+iuhyOw18xun5R2VmJ6Mb41KWmRn//QdVmArb8GLlhwS5nLUihmiV3wbVUp8LVwrL751Kt9azZGfWVJiSiQFyu/garnTFHY3eBmOwPhWApgXjZilF/6Yn+D/Ms9k1pFf5fwn+GYaZzMEXj+mT7AlkIHY38buedvay+rSfTtAQfBhD9E8R+rtmLqAVV+Wt7Y1s2+NxuNz39sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhEn8GQ0u26a9/xB0Fl5KKa03dIKffc/2IBaCND6oHc=;
 b=LD7mjIhVpYzRbjNa0ODsczf1lKRmXJVJ3H2M2tBgAE5iUFw4fnsqAV/Gtl7HtSE8g23XmuY222SSFnUpeCRG6DpgcENNxULO3E1ZKOdSX6R6LuMkbttPde4t0g326o7oKRmIEdac8cnsyFU8Xfad/EnM3ZLzYTuBIe3npadGD7VntalB+mhltxPhWvJfd5B5gwi8wSe5od2UkwNSuOw2qD2nQfoF0AWjH8va33vTOdrvNzChnf8qZJCkdhOPfWMjhbWMWo071czLGSF4rqtXAHxzn0vBTea7vhCrNeHwnAQESS0WdXxYfURGomKwrXYJW8wbx7LumCHU7ZkMav09pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhEn8GQ0u26a9/xB0Fl5KKa03dIKffc/2IBaCND6oHc=;
 b=kWo8FxDG1AxYRSyzFY4Qsq1H9k3iXJTzt/YAaqSNEUWKlRBu8bYa5tPPMH9nkuQOCnw4DoLbj5RWvacJnCyOR4ss/M2PrBRe7K/ff0TAIFiyV4Xt83ps8kPCG8E2utHjuSPdmfVpvMfty2QcWpnMhH8LJkwG6ORNyKOapiH6PtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:11:43 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:11:43 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 2/7] arm64: dts: imx93-11x11-evk: added ele-mu
Date:   Tue, 11 Apr 2023 21:55:31 +0530
Message-Id: <20230411162536.30604-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411162536.30604-1-pankaj.gupta@nxp.com>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 29269079-5f4e-4934-bfbb-08db3a9f0f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+pPnHjhNYIwY7DK5S/Q++VWVr1t0a4xLPKcpo3JwiqdjDxXr3fDZOk1D+GdfNZRK7BzWuGJviERKe2TWqYbuv+NV9ayS9oZjX0/k5XEDSIMndFw/QcclcHHjkXzw+u4HtpZFiiVWrKwI7z1aVkRxNedZWb6GpFTYiCD1wdDYIN9l3eXFNsK1wQOUPWhpXltacFkG+VKZbeYpeRHDe6hdjS7nn/oYS7K8rz3feREKExIYOLzN1tz2SddVetI6K9GUn6JTRVapIQvIXWjx60u/FLzWJOsnkw55+2Ubl9NYL6J8XEVYFfh8LUzHncldkvk/cYpZhxpLoS46irNRy8ub1/pTp6BKfg0g9OUy9HirJEfKDCANDMGArHJVU0+iwh2JHFObRO6Cck1XEzN9Kl14i5WpxzRxIeucKhVtgKLw/DWiYRk9Wv5yxYxmyHDsmtU3I2HwaQA50GPnYPUaREZZWwPUCbUyu0qv9KRnkV2o80GL0GgbdI6ViEQ5JaUe0+DwgFEnIsl6r16awfzwarR+mVD4MmKa6Ulya/jynjkepMMchgRIRei9QGg3t1w83f0l5Y35x4WQUQvOTPclXGy1wkvKV10WUaG0UWWZ2Z4NM4wD1Dnazf20ZWh1YpGNzIoxl/qhK6sNOrX7TOn1iz3Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6486002)(478600001)(4326008)(52116002)(6636002)(8676002)(66946007)(66476007)(66556008)(41300700001)(316002)(86362001)(36756003)(83380400001)(2616005)(26005)(1076003)(6512007)(6506007)(6666004)(2906002)(8936002)(44832011)(4744005)(5660300002)(38100700002)(38350700002)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A4km6jfPRd6zBEI2xuIHxxA7NfTGD19T7wvnhTb53ZPMOwkbQ4MUHLcokg92?=
 =?us-ascii?Q?52Pkq9tsmhTE+QCG1yuRuYh2vfhh+6CC7F11d85ZY5M/uVrqCXd7kSY42t/R?=
 =?us-ascii?Q?xqBol9O0bwLqAG9XQvBh1t8xAU8+xmNFKAr+4P6ePD16ZgxL5ZDSVFB3JT0t?=
 =?us-ascii?Q?Ez6D7wRo1a7yWFARdV2pl3FMBfm6CGlETwsPDuSRDIbtYCPxR06RydljrK3z?=
 =?us-ascii?Q?FWbczIVAYlu8uPzSHJKq2KOXoWPw2Zf1bVIa0rsfXZStH+tdvoqOqg4o0vix?=
 =?us-ascii?Q?kjrK/MiWBt9JFGJwygiA2WjhSBOwheX+3eZPK3LLu9HmYOA8x8GvG0sLixNI?=
 =?us-ascii?Q?YHBfNE8rikH1Zvd+vNcG5SfL0Kx+SI6jR2IPOPDWPsVtuzcJMS/d9+GzsDtz?=
 =?us-ascii?Q?x+zwazZHm5qGPLonOdEcAb+Hoa4NZXIVFWxLYZ0e4L2bTPbpjHoGpRYZl3Qw?=
 =?us-ascii?Q?1SaPiMy0YKQ+E1jTJuspwSD3o1WHvR+2isTE41S1fxQFlcdZjWetvgA6jI+G?=
 =?us-ascii?Q?Yy0WTswNA8YmSu2hZ9/y/Xh73bP9geHXokdMagQtfLxnDTqI7eVXUqVYr/RM?=
 =?us-ascii?Q?A9N0KhAtTV1fvdvJ4S9ZCjeo+HA/llHatr7s0aZlUgzuHMxdiSbL52JsUDsz?=
 =?us-ascii?Q?Wuh4iSCGfBvxyocQ68pEiwD7GGjJoqqGdoBI1qOcPU8fsVP5ebXb3J0gf/aZ?=
 =?us-ascii?Q?04oECB43S0mAfinbifEi5b35Iv4K9UMSYqfmcHi+3BjJrQohD6ibnhnRlrSd?=
 =?us-ascii?Q?7N1Kj310TXLsnwIwON/6upJi7PgEE0S73oEdsYTFJgf2qCiSN8mhu8KG8Zcx?=
 =?us-ascii?Q?RNSx+s25aY9QcC6lEv7VWAq3fi98bBnuDZ3XfEcC/N+X61bFMyHj+BMUWGEp?=
 =?us-ascii?Q?rlAnz9+yBBeHTmWvOPFmJWCQKTgARoADbktO+SD73sWf7ac3dBf2Coy3j5/Y?=
 =?us-ascii?Q?vwascQDRR4qK80CzBtZYpp5s/VM5lYiGIGWPDUIOjYj9q9elWSEvRS1Syny5?=
 =?us-ascii?Q?ZDIyH9y9ALDpRvVApruJkWHEe7FyGcY9ffxKgFe6dtS9ER4DpcoZQJVWYnmL?=
 =?us-ascii?Q?ndrSN3bYb2AEe/+qKvLXOd2JUnyFaW97ZioXFHMhQJ6Rcu9Tb5yiu/lBx/Qs?=
 =?us-ascii?Q?wOZZ1oAz5f6/N4doSPSeMGPqOCKSD9pcqqZvJM1vpjYNmoiM6ALo2kW1Tk6S?=
 =?us-ascii?Q?bUy9+WIPAeLBwXRThyLm9W0GvTJRc8tfHgKMop4gu12fofJNPti3/B3cGwWC?=
 =?us-ascii?Q?n4AbVsXxhpqK+92+DOswrzgOYrcukjazSMUBbjg/MEIXYO9TO1g7W6KbKqpq?=
 =?us-ascii?Q?UJWeb0fNYhhMc422+YfZDB3nEgs20qhuu+fVWHxhFQ8z8zOV8LFYfuSM80Qf?=
 =?us-ascii?Q?W+fAfFxYco1RopufOCAs7gieDoTX7huX57b2GxKpqI9qZ5xem+RuiVRsdJWU?=
 =?us-ascii?Q?gNNbF4B5hHNdnviXZMiKgIfxDhAunjI8KkjtxYIxKxcuWlZmZwPRnCaCDzqu?=
 =?us-ascii?Q?b+ULFWHgJNUPcPM9zBwxZrOzpVf1ldTpNtND1/2P0VpAjga92sFdqYSniKnq?=
 =?us-ascii?Q?DvHq2eswdTO+wVee3B8YYNBe1uD2OVvjo2c3nIHQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29269079-5f4e-4934-bfbb-08db3a9f0f22
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:11:43.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DMuTwd4h4+tRhnMjI7ZdrdmFdnFwkRM9S9jcmbsjMLZYGz7VXH+Z+M8aJopTvj4oRQ1b7ASZR22YqVsWB6+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adde support for ele-mu for imx93-11x11-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 92e93c8af7f7..8ca2f08b7caf 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2022 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -725,5 +725,14 @@ media_blk_ctrl: system-controller@4ac10000 {
 			#power-domain-cells = <1>;
 			status = "disabled";
 		};
+		ele_mu: ele-mu {
+			compatible = "fsl,imx93-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,ele_mu_did = <3>;
+			fsl,ele_mu_id = <2>;
+			fsl,ele_mu_max_users = <4>;
+			status = "okay";
+		};
 	};
 };
-- 
2.34.1

