Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575856E79B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDSM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjDSM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:26:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EE414467;
        Wed, 19 Apr 2023 05:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcHfq8vbFUVQGA472Jk4xAnoxtBzxAXyU+067I+G1qb7r9F4Py+vpo0LXE0SRRm2tctSxHBaEqCkzGAF39bNfw1onOnGWGlseAOjp0v4CzItt9djVeFnnkKcq5M+7TInplXtdjgNewjWKfDh12wU2YvQOnuwpEpmOEkgMULXj6nscxWizfD7VaZRyf1dLlTGvw6qYaZJ+tDb/aRziqLVfA9ZYM4xyBFcrX7nh/y/mKdkk9Ig2ptoBVdM124fZahJEJdQKVRp38O4IJHkxju/BzEwv97Q0z+9TcHlbtLO+QlpaaZ/cha76VVUbA+n80mR8LXkwkFB6rfBaoJpY345DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK3gYCfx7/FOWcDGJ5ME50xiIM16l2zl/gfsC5pwF7M=;
 b=GGfpEylGN3+PX9bi5HY/hMyOxWr67sWB1ERvdgGa8OyBNfZm1Fa8q0jV9ksPSmFDn149DlGFVe0R5/7gm0BSuY8+RDzrh2TvE9a4pjQ0pHr6hocO9KehhNsN9gdH8Ow7u9oOkcdm/7d+hPyEMlhPl1nSjWufxxJUNOu8R6X9JroIeqSp2m0FBfKOMHBf+d7ypkIEN+akJMT+9w17AqhY7zE2Ib+AnJ+vs11JpoOlJTDBekBsXLXiE9Z6doDtRnuPAvL2ZPhep5TbUil2g3EsqrSoobJYF9VHtR8LEIZtCZf1/QP+rCfyRJdV+ulbk385DtvrS7WrzEANcuJCu2P+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK3gYCfx7/FOWcDGJ5ME50xiIM16l2zl/gfsC5pwF7M=;
 b=Y5qIsNZXIeG4+lcJSbI1qeRwRaQeDyS3/dSBWgqFX1mSCC4JxZP1GKi2cr4ZcnF2mjMyB0bn9qSPhiLMak43gJMLQnMegJyIYfQD8dIFhclgpI+23rkzGZ+w2SV45QAVv4yYTJ7YnZWEupLk88hKtQbmCs+x35E+Pb7tt6lox3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 12:26:30 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:30 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 2/7] arm64: dts: imx93-11x11-evk: added ele-mu
Date:   Wed, 19 Apr 2023 23:25:33 +0530
Message-Id: <20230419175538.855493-3-pankaj.gupta@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: cbac9f11-c518-4557-8ed3-08db40d14dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pcwhofFTGqxWqXQA/bZwbXuZWALISY0V2FfP1dDMVnkkda6fsesyxVrs8pzJxNY3a+/EHR55kPEhOcGa58i3l6aWOACI9tY1IcMLEG78gY8js7Qg92QXsbU3f0rThYv8aIYfxfyLg2xyhYYupu5MB6ItgYuRe0VoA2xoDLeX8dRxPlNnXLzSaPcXtS18dlf9VF1ODMpbAPfvdf5uVZ/eh3lrdO+hwzwyXeQ2i0a5dSq6ccCvhUWrsFPzrAWyV9cMG35toePgTGlH3zJPmZkIZFon4ys/9UBlaCdAkXVfyy7Kpi6pbtQw24eLK4kRzK1wUrrErRnuskNiJCwlDhrR4zdJE5gcaIGWGOeOONunwETXpSz4Qgx3lc2PR9hH+tEsWD2bIKpHMJoev+FCvUxHROJhc0FEMk9FV9R2pNnEjw98AQIbEjkN6qS+kpS5y77HFTvFirUqc/D2AuLN0zt6xeA7zPcwsLG6bV41ANDW2FOT2xElx9jBNIYq4M+0LxbJwrVV14Exy+TPgHw+iJfwEiSrtliZQrQaaayJGg6JUAnTbVCun7tew322AiHj5bup6eWjLjO54QYSAS5eCQC03+zmI8vRHvwiVje/pblmuji6ccYYh58T0nVbdXuL3uH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(44832011)(5660300002)(8676002)(8936002)(41300700001)(316002)(4326008)(66476007)(66556008)(66946007)(4744005)(2906002)(6636002)(478600001)(86362001)(26005)(38100700002)(38350700002)(921005)(36756003)(6486002)(52116002)(83380400001)(6506007)(1076003)(186003)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SS9ZeEDgK+GjkKz3za910MtWFynrRsU8HFXn/fgWkRnZ1C52EewczigT7s+r?=
 =?us-ascii?Q?UyhCwuB9IegrXigABkHJuTBsLGsZvbC6AsqiaXIH9tYrVnYjkb+UompJp7YZ?=
 =?us-ascii?Q?ZwnSWP2M2mcl0CkyMksxdHQKGRno5UTXV4xTjA/N/qimLBrNzHrxyfTdTn3V?=
 =?us-ascii?Q?fytZ7zRI6m6CUDd/WKteKX+q18b7oQjbOzWEBclf2KSP7E+gFrbnOWMU16X2?=
 =?us-ascii?Q?HjuI8XBpy/9pXadd/nE5mgxT78tMmfVDiUz6erx+9lLjbhOyToOyd3zIThfH?=
 =?us-ascii?Q?6XhyCgG9Sav8PHigMZ/S1W6r0SMbUX8/N9a6WsVEV8g7Qwxr+N7Pt/vvULzV?=
 =?us-ascii?Q?57muGVSkh0vEPhDxo9xalOPzgr9CyO4LDj99Y0IqemcE/bQiLOHJ9YyJgiqp?=
 =?us-ascii?Q?bNssadfwgB7fvZNTGYUhJNcoO+CN/QRthNL4HwbEbLuRhdMzVv4C/qpeSMTv?=
 =?us-ascii?Q?7vsqEbWitwS3lwbn+li623mLuNGr4u5P9HjE2RwKxJH9SGlisg6xzar07LDU?=
 =?us-ascii?Q?6ZIompcO2xXWxNRvZRBlBgFnlmImbN/ZFEgcsPC2a3/RUvUq77w2SYqdFZmS?=
 =?us-ascii?Q?dD80gYYMoxqcpYx0tSGlRMAyYkZeWydFZHpOYOBqPDfJnH+WGs7QW57G0Lf+?=
 =?us-ascii?Q?C5jlAZVCw/xZ1tOclKec8SdZKMPWdiEhxnYK5vcGgfocFTU5j6u54t7byaxy?=
 =?us-ascii?Q?bqe37KCT9DpvbsaRBPEWubhcYb73jG17ONLes5CFtx7FpOvOqizxZk/KUv14?=
 =?us-ascii?Q?mzbs+LgWFyGcwHsL2N+Fjnb+bbnbtSgiktKPmtubAaVCHjDqMOrinGR7ehqw?=
 =?us-ascii?Q?KSzGykasgBWWd7AyRlNu0ptPC4HLoWBwTdeFqQIFJhgrusezFtZgZ5kNsdUQ?=
 =?us-ascii?Q?fe6k0hF+RD6ki9gdEWVH6ShExgeyQzOV/9aGgwSXgzCNTWRaQgpz2Ca2bWfv?=
 =?us-ascii?Q?pag/O6/YtaudNU3o7F5QaFVqBfjpofuF0P/EqxoSJo1Xm1i3OliAYFwy5GDe?=
 =?us-ascii?Q?Ym57BR/HVi1ncMJPTIC7KvPuCpz91AVr6kAnRZxp6VVFEqo+WYRDZdOrFW3q?=
 =?us-ascii?Q?S3rALL15We8gXdGCxkuiuxetpjrKyYsmFplwAFtoQcns5T/6wU/HOkG/T0R5?=
 =?us-ascii?Q?gluSsMFkTvSLCGh1Tz9+TkC345rYmpLVCRInNQUOcEpHsJA7Jz4ZLh6n4Nsl?=
 =?us-ascii?Q?7hdRCUx48zAqr3LM9J3BI7dt33KgyZBkgsy3f36ISU46i1mPWtDcoSUzsqst?=
 =?us-ascii?Q?KMLjJJBB7E/anfEAIeX/SgVKL2r4nR0q7C2BqSjNlYPBk+6nMV2CNU+B08/5?=
 =?us-ascii?Q?wKLdgy+3om3VKuI455ssU+Ccpi4tNoCeUARKTwbL02hRrAhLIfpgiSWjfLvm?=
 =?us-ascii?Q?0H+cRBiskL8wvz9cBm6w3YW7DFuRs86u0Okm4Fq5j2g/DKE/I6SBCbr31axX?=
 =?us-ascii?Q?rX61ILLprZ3hQBUDuP5MMaqMDjk6diTmvCL53FGoF6TLdhPjrG2C0kdfZFZR?=
 =?us-ascii?Q?Hzz67ZAewqrHI6gGb7kSBzRH39NWSJ00CN2v9EYh6DbwZXbEJeFbiBrdgp0H?=
 =?us-ascii?Q?QBgBc+ZSkkFK0cChY56TCYvMli3RIU7On7QJKiBy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbac9f11-c518-4557-8ed3-08db40d14dd2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:30.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxTLJONY9NVr36LpkmtLvlgj00xFNsWxU8jZFdIj6MmjXsTBbjWYo165JEtv/TrtBGOjB7YLbSb2sKBGDpzK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 41efd97dd6d6..ffb7cb8ed228 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2022 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -741,5 +741,14 @@ media_blk_ctrl: system-controller@4ac10000 {
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

