Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0676D6E79BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjDSM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjDSM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:27:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1416B0D;
        Wed, 19 Apr 2023 05:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OepVoBdScsGKDN+mXs6YOk5bbGaZt1kbxObLe9Hz1k2+5rljQ3xhh26Xciw4m4fawu4jcI5RQn8a9axNKvvhViy1T3/5AiMSRPs0Ldxek6N9aVLnA5WKmHZrFgJ/JJ8z54Z12aQDT+FPjyw5bESDi7DuH7IBKUlx0keUSKcx9XPqoBb3+4f6hcOOo/IETandB9IeNq1J0vZ3Fr0dUy/ebO52RaL2wp/qN/E4p0ChNb9Xw9IbnMHp8J0XF3LhBW9163GskeiEdMTfiqgC49uWdDJJo4kUZsCXWVETf04O2T6j07ZbbkxgwvV1cvvOecsfGqGYB1/z8vxwy66EavaOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFyzIxZnvOaPzlmylq1VEd/n8LVahEENfFCZeDmv1cM=;
 b=SynpDb8EvxLv0LYAkocBl02kcxCguuqsmc5se7SVunIdT5Sxhmc9CSu5OShD5hTY4vAAxQuxMvyHsndqIZ2KxjS/UtdYzZ9TjzFeQ1c5QMa6Kj4R1y7gB4Cp6UMQ9dvwGHVcJLveiBE3VIjxTJLCe0pn02vcMf4c8SuPdpfE2cSpiLj4oUH6KWcP53+T6XVS5ukg+iwY2hkRIXd9tcHVAK4TKj0QSJHdgYIdyTX1BdD0BcdRS4SE0FIthAewspzjaGqrTTTzWl7MVymCraRk/vJ/Qex7nBPHPKTdgLCjho/axLN1cyZUfes50ZI2qDVNGVKyJmMuLxoWdyaMx4xQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFyzIxZnvOaPzlmylq1VEd/n8LVahEENfFCZeDmv1cM=;
 b=Il0YP8fdDP32LGv8gNfnbx6xG+VYMtuT6zPMcRAtXobYY4Lg42doZkURtH5zgNi+oR/N1Jpy0KtMGFBtzs4dYpU8iYXzbPdtv84y9EI1RofwlO0CUrYU6mjxaZQbMQ1iQdF4snR+qqpdubLbYb7gZj3AjqSmhN407ilEJp27ylo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 12:26:47 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:47 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 5/7] arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele-mu dma-range
Date:   Wed, 19 Apr 2023 23:25:36 +0530
Message-Id: <20230419175538.855493-6-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb127714-519e-407d-f7c0-08db40d15813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIy1tCId79T+d6yZuxhpUlQK5bYcitnyiZGamxUijpWzkjPEUuL8525NkHF3ZAX7cBcYqdtmE4gzjZaVpYAH5CKQ+nTxaAGrVg2lZa4T+Qq4WZQBYHgIdOhkfok9u5UeOxRI2E+r/SeDOvpDKYkl5XlPkRwauC7Wk7/DllGMrlbfv0fqvNNTwPIYBRmIgtwt+ur3TUVbcTWgQKHsci3JAyrGpJiNCdwryz+ZAns2Riyw+G9+CbXMp4ZnZJhLkvOoTeNvxCIivQewXaup5tscZnu0UDrj7qG95clmeXE9f6MJknxBSbCKVKDAQ+oW/wOTUXDAmB+V+rcCBB+dHG9bBoPEPHg1y/sJyve5b+12bSFfMUPZHRrT3kQVpSkxB89an2cJoeEH6oYbffjnfGeyE9R3kQPZlPtWafgYRFOe83aUCuiM/M1OBVH0lz34Gf1r4sdOJUKQ/rt49EnfniGK8OCWu9cJAo9CHZcUFLSqKm+wJdP9DycDfjFiAWySVnI2gV9rh+15eRraJd0HKfhyFjVLHevIF6fkdrf7Y5moI3mRog5JoBWx0pZRwdY9qcro7rk6OxJ0sYe3ijwe+J0l4Z3IJJu1cepq/g7mubVCoxn1syEm5hK5aqlsbNrT9yR0S6UZ0pg97gRqUiu4igMqlVy8niSdISTaOXSJhKCmfPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(6636002)(83380400001)(478600001)(2616005)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(66556008)(4326008)(66476007)(41300700001)(66946007)(921005)(316002)(186003)(5660300002)(44832011)(38100700002)(8676002)(38350700002)(2906002)(8936002)(86362001)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8w/PVDPnLPJxd6BEMHnbmQGjnyeaSV+ZgRdmXQFrzWLLf4xym+8UqaYpYkd?=
 =?us-ascii?Q?8k8cqHflgokHuLcEAl3eDUHW/pw3efrEOj8ZTaybTyfnWU6nfnz12wTORNU3?=
 =?us-ascii?Q?o9Y3rD5Y1wRPP85eemu0pCmkXgKwqcTUluG+09ABe5+YDbvkyw18cgFTXzW8?=
 =?us-ascii?Q?ofz3vvT8zwXTw/gnOtVcf5kzLAm7ml5ihMC+DNV4m05+IqEs9wcEPIW5Mq0H?=
 =?us-ascii?Q?P9tpr908FvzZFbECjBGT8zs7H1Z3hYdDoDxgSuB4jSaYfocYY22HisBQYehF?=
 =?us-ascii?Q?KHZqrAIGrYg2DJZPdZShaV33epKuqcEsZgn8jH2d7SpGZd8Hi9oQCI4yHYMs?=
 =?us-ascii?Q?ZqYbju74qPyBqsTR2Yf3GU9mRn6OF2fBmYpL9NSJ8h/qqojrnoxBb7O+2Ahz?=
 =?us-ascii?Q?tPoYWVoLOYBeAxVgchTPFrWxWeelgvUZajTF1vBN4g0fsegQwFz/bzZDj/+c?=
 =?us-ascii?Q?cAfxq0bw9Wfrau5kgtplSH++Tze6+FTm5BF8xPp301ZxojA0Ls1UxkYO7aLE?=
 =?us-ascii?Q?47F5PKI392gqFm4x65f/O6/1FFi4yN8f4Dribj1OhwsaO4MsS9uWAUbfnhuB?=
 =?us-ascii?Q?ED/MvEGFC9o+Gwy631/672LFvD1SNHl80xotYkdVOgFLdiq/lvmLs+mMnzoS?=
 =?us-ascii?Q?NMfKit83elfvnBwIpkYZTqw/17VtstW2smt4XCx211rYU2xzVKmo9NvvC1AF?=
 =?us-ascii?Q?Y56MOXPe7yb+Rexeib09y4qVTNxv+fpNU7dX1Q8ovqYveSpXsEN7OWKyhOcN?=
 =?us-ascii?Q?36q16NuZtUTSuZ1SmThuevITaVa5lELo0ni39/GeZSetAy2AMX17EaZJ1s6k?=
 =?us-ascii?Q?NVkFO16qwGkWLwxZxqeHCIuKeEqK9mc5/rC4EUhBStq9P87OxtRfldzVTSkW?=
 =?us-ascii?Q?9gRjAMTxjS+mvdyFxw6aYSi6j7bR8gD93WYdQH9XEXpiBSSzH4zJ4XZs3q+k?=
 =?us-ascii?Q?UnhygT4e1TtVbykWaldbhQtaSi2DWR2EysD11HBrlkR7fPirGeJlJ7/1S8hl?=
 =?us-ascii?Q?VqgeWzhsXKSLk5oyHdTkOtoEcmbhtOu4nt7Kwk+efFUG9r5jteCt5YNpB91z?=
 =?us-ascii?Q?eVGp2sHiMCumLqU8Tk38ysNlr+QcxLEYg6SD1lerAakePm7s8QC14kefcG07?=
 =?us-ascii?Q?MJjaApDjnkYiwPNRh6xEA6dkfsl1xEifJJd/qw/ap37hR52c1K3+yR/4NTcW?=
 =?us-ascii?Q?qqOOSp84lzI640yGNPAdpMIksIFdMBsnasS1J2aQKXQq7hl5BXQG6TJETHok?=
 =?us-ascii?Q?1F0OE0BenCzBu6zNnlasSVq+7bAsLY7d8ngTtajG127uYHnM2Vn+DHS1driy?=
 =?us-ascii?Q?3mT3T6e7ZptqSIopTMScjHaCyaRlPFiyg+2tXYrn0D3Rwl3MMqiP99PpLffn?=
 =?us-ascii?Q?VxuBqf8jKzkA98DNznIR9po6Jw0sSNkVyUiZDXCGtDvV0YQLSje+avgWceZ4?=
 =?us-ascii?Q?Z5q2ll6Hltdq14yCf4pOv5poknklhRpec9jhlKfpbFY/XHGzwB6WV4zpYx17?=
 =?us-ascii?Q?CQ1QiOypiVCauzQL71mDNtYX0J4p/9Kflox5NYbo+DevIu3EttYRqok2o7NC?=
 =?us-ascii?Q?IO3ZFBpoxAqelSkecuo3gfzBotMJbddQzVeXrkAT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb127714-519e-407d-f7c0-08db40d15813
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:47.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLoNfYsm+ybPyMtxPr42SgLCqP0Wpeww6FFhRGBL+2zCC35IitAvS53miKYdX+mgChIQXgFQ/56gK4JueDVpKw==
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
- 0x90000000 - 0xAFFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..d2a39e9aa951 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	clock_ext_rmii: clock-ext-rmii {
 		compatible = "fixed-clock";
@@ -53,6 +64,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_mu {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.34.1

