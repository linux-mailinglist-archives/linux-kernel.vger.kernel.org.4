Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF977507E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjGLMOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjGLMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:13:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9369D2103;
        Wed, 12 Jul 2023 05:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxa6bGISPKXYjpU1/UWYp9gYecE3NWHOD/8Y5eCmTgteOQt2DTZq0h1ZQ3datdbHSSsCR4nYrfK0X/pT7kPmeG1ZuGj1dhKZzFcml2zrH4fOOVaDwYV8yIgd4o8XrFPGVxBEuInwKJdzJV6ehGULwLhzUb4qu8fHtrKsuY48nzyVbtTPbSGEjvnoUFeOv7ONjurmoA3rvyZqMYjTle9r63PvM9BH0eUFwEDec6xSi1PdsVskVRYjYvooBrWARUjqwrsK74P96H9yBsvtUsdbLr1pCz9RdR7bDw4EpkWKwjwsFQaRaSpUQVDz3PhpQ7uQv4J1kO8brFqN/0oTlqgFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEyOsVUfVI6luo3+1Pngn7uTkG0PoyWDewz2DDen4nc=;
 b=KTlOoYhMre39t1fTlc34Ltu011uE//np+WUUIaAxCj5sm9LtnD1bgEA6LAWLJ4Irm4i6rCG40uV+1rNSE/KFRYkLwszZT2xfP7ronEQq4OxNAFw2fi/m7uQV3gjBKbN3lPObDg37b37Pz8VAZAdmzfAL/7a7RTBVj0s4GoFoNqKb2ZNsBmWjQp/7j5ZpRy4eHAfUi3eU/FneDDN2mMsV3/gG+YudQ4+ZFNbmIWFO7IfrR0WS6xpqFFnfiIchxq5SKR8w5QQwCT+A1y6xpqDB3obm8sAf360P+b7zQnRA4x6qLxD0Y1RYlzWMc9PnuKJ7ZYEKstseUHnn+v7NiriXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEyOsVUfVI6luo3+1Pngn7uTkG0PoyWDewz2DDen4nc=;
 b=g6uK9xxRXdNaHy9KNMLGRWj68yQ4aQKov7QPgy2sBONoRtwzorQz3lJsBOmZefA9MZFShzpeEzf5b8ND02r74DEPgLKr9DOFgUIrlsxgC1N9nSoSjIKksnMCjy96AdFxJzu+XGUai1J6j67uX3TcNLX15ceJErtXEgbV+WiKZMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:13:32 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:13:32 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 5/7] arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele_fw dma-range
Date:   Wed, 12 Jul 2023 17:42:17 +0530
Message-Id: <20230712121219.2654234-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebc1544-8899-4299-7313-08db82d16909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFfYyp+hRXunBoIpPq0dTHewaf0DfndWmIqwUwdJUSbn8wRpuX2VWWyjjGdc6OlXF3PQYqNKmbbM82aptRyjKLeQzHuCO45B60zhGBvpbvqZV0r4nHASJj25Lgw9bTeOcATQ35WNTFpbvhnGLjhShQc5RO958bxY02jsQUbqatOrGHTuaDzDYy2dHqqHc4Lx1hmt3xwnw9/m1xRTZPm4upxUSD2kxW+XdGCr50hiN7SQeTTtBHpO54Gl5hGyZPFKGl6Z/8Qnl8rG8Xkn2wXmiMUKTJUMqYaYXMH6UB0HYlgbmQh38ei3stXCfhNuR661ySme7Oa7urhlhNbsRRFOhAbxo7IM0Czaqqd542xD2jXDnjXCFp2N2YT0l4g4j0UbiSMOJbMgR15SzJ9EtxAalYKF8AOheSW61hWrdPkZlaWPzu7t3p1QVieXz/PknKJElJEY1Dj96mfxtUFpWWHo5KAXHKwM5mO78skbkoPtOKzJ4VE8zDGfyMvcLUvOFRR0sgSG2jmbStKqiGEuIuuGk8lngQS2Gux/TGbqWjBkwg6WZsxLfK3Z1XxIuiQ1rgmdvgzm9fbBMGpKb0OKaoC5SG6p26gf8w/laK9Q6/iUBt2m2PxB6YAF8zimUeyRnsMPqe8CGbAqqUQqma3uExr04Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6666004)(6486002)(6506007)(1076003)(26005)(6512007)(186003)(66946007)(2906002)(316002)(44832011)(41300700001)(66556008)(4326008)(66476007)(7416002)(6636002)(8676002)(38350700002)(8936002)(921005)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBN4Z7WhEiNaooj+jKCuyzo76TteL5VsCU2rFiIegfwUJ4VdGSQniUcnIrEk?=
 =?us-ascii?Q?lqXtFc3kvH3ZD7S1JNK6iQ8bbZ1XHhHxhQ2aykc0JIe1kLwl0uIOwijhEZWT?=
 =?us-ascii?Q?Yow8gOdgZcDanWpbvrTRv002S5vAHYOzuXejHiWf4W+Y4EJfyaVxsOe4wtuH?=
 =?us-ascii?Q?hVri0Hyu9ny1wpi3HYvITEPAYqi+denYR1fCAnpKlylUz88VO9ozkBtIu7zJ?=
 =?us-ascii?Q?auNwQnvu3itLKHoPlROb3FRTun0IcPsdB4ae1HLWvW47LnEEKFCxjgQ7nxRO?=
 =?us-ascii?Q?oxfuS0kiAkatHC5Z/RtssGoQ2x+jlDzEycm5J9hpiElfPxPyVFC+ind5Olrd?=
 =?us-ascii?Q?kJAdqiuRKSduwUauF9azdb21jm7yS1B9IYI9s5XnR8B7seiXMsbo6u3+N+kZ?=
 =?us-ascii?Q?EC0CumLsdplIPx2P5uhIJaqvzFkrw+v+oDO9GBtdpxLSK8y8t0HSjZWEqlUl?=
 =?us-ascii?Q?jowjd8HQ7eFB9RiNXzvA+5++QqTy1CIczTNEziLzEYZkOZmRq9OLv2PqGtv3?=
 =?us-ascii?Q?y3e7NjitIVTM28RROdsvRhLQPNDDwIy0mvP8OcIQjOYAjRafp45wXtzH09l8?=
 =?us-ascii?Q?kP24hyyMYXu4igKRtjyYQuIiYjOi8I9jgO+l82Z800yKhERYkm0h80CD0+gG?=
 =?us-ascii?Q?knSUlHv/LQO65K2Ba1ANwOtYhaH6yV9TqFC2w2/tz5O0fyieYpfUXdkDIRGs?=
 =?us-ascii?Q?+Fq/5530i6H5RnXTGOell05Uy004zDtGi+ANO8+o6SMnaWV5mo7XIR/p5FeA?=
 =?us-ascii?Q?D1DLdhXHzLFCIYOMoo9QsY7SZHXswMEWsMS7fM5yqeyHaurs1hv1K0ozU9NK?=
 =?us-ascii?Q?tMo818EMN5756eCYJrhoEEe6WOqpgv7RnI6gCDxBvHZ5uRs/jWrInxPg0ngL?=
 =?us-ascii?Q?3Pqsb4mHqmp+gAQ0s4geFE+axC9BeO76U0ZhFPPEEzTw+3k69weWvCIFxcbd?=
 =?us-ascii?Q?1N2fRK3SRK4TO/NE0h7i4yYX85j37uKbV8yp5GzHN7WLI00H2cfoIonhiZBi?=
 =?us-ascii?Q?1zWKejLROqcm8Uo6/XOjpirCHu53l4i5kSTd4MhFr7hQkQTt3o3E5h6f55IJ?=
 =?us-ascii?Q?dHeaCit/z1g3NRW00wCxURpXfdUxx0M+mKsEG/LSnUYmjZZqIrd0EpMK+2IU?=
 =?us-ascii?Q?2lvEv/KJIWXeSs+dhTG2WXRh6hOcwwf5Mx6EaQ/PRhiRejzm87HBEsP0/oZa?=
 =?us-ascii?Q?IzcjTMGxsy5Q3IU9wVdbJeJ2Pq7IymbAwyDZbiv9jAPIJjEcLa//2qe4V8b+?=
 =?us-ascii?Q?yMGkCD+KH3uZ0N12YQGWBl+WWi3oN+YE29QbpwmzUPWN9vgLsSeizLGXmE23?=
 =?us-ascii?Q?eriKFXBMVwYMLLrW2u4r03Cdb29o7cjE9qYJdjI3B40E/Tsw91+8J0tqLEVA?=
 =?us-ascii?Q?lb/503pp0Fej8VCMgDhpHp6vx/nHHFMloyJkpcyewTmMfXVpA4qXLRjVuOrA?=
 =?us-ascii?Q?j/buNTdJdHkJydJMDRwVendEEnCWH2EgK0VV1M3G9p7MQ3i2sArBXffWREvD?=
 =?us-ascii?Q?bcK9djO0I4nTiPRpl1Uu4RSfFBMkiTsH3pYHY7M4CRsC8p2qRXbtypJ8Hycg?=
 =?us-ascii?Q?MhiZMswp4K1bNr0O+j8PG7Nyradl8Prg+DNyO7EP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebc1544-8899-4299-7313-08db82d16909
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:13:32.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2L/q8K6tIFDcdhlWBRV8RlPg306QjJBGP2mDcxgoTIV6jbmXiJbaW9pRkgcs4uaVpSXmdpHIlAEs2izVbOAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x80000000  0x9FFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index c50f46f06f62..950fe3e58e59 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_fw {
+	memory-region = <&ele_reserved>;
+};
+
 / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
@@ -22,6 +26,17 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1

