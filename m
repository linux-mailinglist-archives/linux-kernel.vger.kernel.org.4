Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63C560D39B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiJYSd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiJYSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:33:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0623.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C2D0CC0;
        Tue, 25 Oct 2022 11:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo/5rT525OVkwRxe8A4N2P4iZqzA+ld3InqqrucUKoSO4uJTPtXJ5zzBPd8d10jL2u1B4pipXyM0vPrwV5tBFZI+LMxyPcGa5DW/NWj5MznqXs7uKvv1JYyCdNj9T0uKbVrVLjCLyVVcb/0WGvPiN87uZHj392ztlmZhIbPF5Vl2MC3+awKYSpK9r445PvvGf/bhAV4mVy/fa2qAJNALdwpSmKEE6MPSCbFwyvFp4bcUCgu9hrl3inmUDySWr/BjqOF2kybel/HNXNpjoMgQrDeYvarUc7Tb0iVQxmMOwKaPmf9ilWuq0rmSAGYtO9pMDE3RpbbcFU4aO9vt7at8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6R7XbY/QK+4Jb5hG3+4tm7r/yRhLZZvVmeuGrlAlH0=;
 b=beLqv+aPR758kIq8oCozSxqhCJkfjzD/SOkMWjK98OIV+IK+zWRml2qCO3ve8lR9hcWOPfnoR5+nkVH5LiU3euspkNje4UOfs9UD0nHyR64Y6y582Z/enskqW0BjT42s3JOGm/HxRmWX08x8FdctGfjXVG+Fup3ul7dH+5HcJLpyqYF++3PBUHUMUZghjC0BnsMA7rXXi+Q8/bvpmpge+0SAxG2Hlp+FFBKm9nHo+isThR3aU8SkbkzVdZ86TwC9S8VaX80fpp7E7i9wgwSRhCNIW5XpbbsjvNDiBVLu75iJFWCIgoLpZ/EmP2oTsLK/Uz4+xEGAyUorUcnIR6EuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6R7XbY/QK+4Jb5hG3+4tm7r/yRhLZZvVmeuGrlAlH0=;
 b=lcUm87l9lhvFFa0ZlGMVhHTwF2GAV/xxH33mr4O8L0Q+PA4ULBZt5hzaC8rgwIGZ9ahI/XgzVkOeCaBCK9IJps4QI80gDuTSX8NPw45p76MyGBqwBRB1BK5G+Zm+zUFsjC/k55r+gwigb1ZfEbCq7VzJ1G6X5ZaW7ojw2PIJqw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 18:33:15 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 18:33:15 +0000
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
Subject: [PATCH v3 2/5] arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
Date:   Tue, 25 Oct 2022 13:32:41 -0500
Message-Id: <20221025183244.615318-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025183244.615318-1-shenwei.wang@nxp.com>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad5af40-f3fb-4990-ba6f-08dab6b76177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUL3jh7taGIinrO4jvCgEKeEOn9UpoccegtxNryf0a8p1rr/NX16fSNaDI7dj9HD3gJFZaeGbdKyqXqcPOOgUmSGAHNmVcU/T75gwfd17zLJi1PwiKKe0D0I77X+aD76id+oIi37h13kkBYHSjxAbkC5qGDjk6RBAMCKEkyYruDJs1CdlM4OK5oISa6Vervo4C6uPdV5NNauSFK803/lJsOt8cnQT3pOK2GmeEy7e3CFnZ/pvhX61SXJs4xYbDV8dySa4iG3V7HyeDbscYatrKz6BhvATF4Y13cxtDZpjBAlR0V91rt1AYSPLEmTijkiKo+WQHKJ0HafEN4ngCC26tmlW7GmhDFuU2U+Jhk+oiFUI8PbMuwsQorf8zYTv2HOAlYDJmUjuDdNxBww7Y99akS8fWGIT1yExvR26ajX5RpW1Qlg4r7hDPfWuTz/k8Y+WWh3qR2eigGdteFfnM2cZp10kSPihg7c+gIE5gDu3wbyHxcJIpukkH1NrwD1AVTgpmb0dkbaLpXgVgGSUH43NriglrkNszobvUVm5aSKwf+ZxgoC2ngdAIWqqna0/XbIeWzlHwWgP4EtmDuVtsKvmCe0cJqrM1UC7ggobSToSsH1rV46EHrw7J/jSDh+FtQDejUtWv9axweztnxjy7qZDvrYl5aCP2TUDLZaqT5EH/lET+ky5qLikw0w+YwiqTQIHI0O6No7U9OFyhNXtZnh06KlhpkPLavlf0qG6hBVB3zafN//eD3TkIOeovfYZBMFcgCQtul52LfJWIj4KyPmFUpzPS5rsLspUlztgFNUTzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(478600001)(38350700002)(38100700002)(7416002)(55236004)(6486002)(8676002)(86362001)(2906002)(52116002)(36756003)(44832011)(6636002)(66946007)(66476007)(110136005)(6506007)(8936002)(66556008)(4326008)(54906003)(26005)(41300700001)(5660300002)(6512007)(316002)(1076003)(186003)(2616005)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABrmuJ1kK/+N130x82Hrpdf/qGXXN2/5qeS+rHwfr6zo/vKS02je7/lWdHXv?=
 =?us-ascii?Q?PGBD3BBhhg1hvqzRBPdDUiq8iKhQWMc2v+8VuVlITRNy8m6ZNylbdk2qfL9y?=
 =?us-ascii?Q?Pd0yYELUk/uHT0qaBBacOxUmA6+7wyEOSAAoq7T1D70EXczDkymlwg5MhJgk?=
 =?us-ascii?Q?aZg37WBzPi1tb2ojHFliL3mn8sHD6G2YOfDYCaG70dUWGv7JsE+iuE7+wGqw?=
 =?us-ascii?Q?ExNMdCiqG5WxCwCHUNDgqGS9oL+gPRb9MI11Hb6wr3m8uiHYhsZeXIEtfpQz?=
 =?us-ascii?Q?JVs929DbR32uAzbCCMLDJTCJdaQsHzdYWP4r6/s1qite974VavAE6aCV8Elu?=
 =?us-ascii?Q?rK5njiZkjpyD972K1Is3F85BFTnA3WktHUpZxiNKFEXP66z6PWvVSVNoOdH3?=
 =?us-ascii?Q?UtCwUIrK57NsIYAzqJKegqjs9TvdoD6kZ5LmIw3X1qOMit2FKd7jnFkFwAOb?=
 =?us-ascii?Q?Es/zQnWcaR/GpuqCLCdwXjqBrA7eifGupOohUw4HlXmw7U3LyRX2abM4hGpI?=
 =?us-ascii?Q?9VHZH4w54HG5KK4tiOwoDuvSHsxs5OfO6FxMELMZLEzo/jPqd1U7SS7PYRJ3?=
 =?us-ascii?Q?R++W+AL7oLlUvUmr9u3DKDNPMN6vbELQeLZ5mNCjgQKqm88UB1hFEYp3FRJJ?=
 =?us-ascii?Q?D2mJTOZHZxRh97g/knJB1zK9NktWJzRkt6uI8OgLH/pAaObL5EO2CtAkc2Ka?=
 =?us-ascii?Q?yDkT4iZFegcHMnfUS99MBmfpCJcS2StQfYOvoKI1USnwr1bKgkqVhTikkElO?=
 =?us-ascii?Q?dwPXbPKLjhfeZKCgZnCbWCfDgNUcOXuC/ot8cjeg6MMCY+j7jZ+JT2ZWF52F?=
 =?us-ascii?Q?8AUo1xqxufWPZMU4vKbNz/X+2ET/zPEwCKLU5eO9xwJw+PxsSXDBmZ463XOT?=
 =?us-ascii?Q?hr1J2JN2++eDmw2pcvLf5ZRTb1XKNnH661qJ+ishr38e/Rqg+CLppBzAWdcw?=
 =?us-ascii?Q?cEw4+ZdwGHVmkI8yN7OEIWE3g2sMT+jemsinypLOOCFLDorWA9y+dStXG6Qr?=
 =?us-ascii?Q?o3+D04rbVHgYTHVwJFVtXymXRa89jZ6sW3ncQmZPMQgSi3jPzu7OJMJ+16ck?=
 =?us-ascii?Q?2eS9iSwq1xeqwuJZP4RfSvxsHRwvsYwUNyMqoLxPPj6SpQTVlSK97TCYiFUj?=
 =?us-ascii?Q?Ht7rRZRe4GRjK8/I1t3gPhFfz8Mboj81cqqBkdylqOMu4RGNU2jCHw9TWpYL?=
 =?us-ascii?Q?qdeMDLI0F0PQxJ23q6qy5gUPpMAOG6yB/+5Ke7j3CuNGRUDVIIpH/5tEMI8S?=
 =?us-ascii?Q?SyXafT12yukUp88nCHDrPMs6O32wkYy5owbpRuWSgv/G8n0FI9HQTSNg/v7J?=
 =?us-ascii?Q?RzyModnPgQzLzArhXrn3zNb9G5k0Ab3Gg0sgYZBk4lnUb0RYTfP87y8afcfm?=
 =?us-ascii?Q?s+u1JIqSW1D+1YT8JzH3LoKXsFTuex+C+Zw3bzgNAg3QNxcNHhhYqbiRxOqx?=
 =?us-ascii?Q?yEp3EMg+lkvWrthP392EiXTGKXwhlJx/8UvebilO5a6blW9BENCTBi4XoHH2?=
 =?us-ascii?Q?qnz2VCovb+vtlPdW/xFverBbLovBCktmVLKG7gxVwnkq4r700XRsM5FBg8rn?=
 =?us-ascii?Q?7W3bUoaQybqyBr5/YktK4l6I4d1vX4GqvvLr75Rx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad5af40-f3fb-4990-ba6f-08dab6b76177
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:33:15.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfofM7IjgSHRVC3CjAgpJD7LoSqS4bcjmwQdDQ9nMfavgeZBP5d7irPKp6/F5nodRd0ioacKJrUq3fxWpCaGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9581
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpio-ranges property for imx8qm soc.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
index 669aa14ce9f7..b483134f84d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
@@ -6,30 +6,68 @@
 
 &lsio_gpio0 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 0 6>,
+		      <&iomuxc 6 7 22>,
+		      <&iomuxc 28 36 4>;
 };
 
 &lsio_gpio1 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 40 4>,
+		      <&iomuxc 4 50 12>,
+		      <&iomuxc 16 63 8>,
+		      <&iomuxc 24 72 8>;
 };
 
 &lsio_gpio2 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 80 4>,
+		      <&iomuxc 4 85 18>,
+		      <&iomuxc 22 104 10>;
 };
 
 &lsio_gpio3 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 114 2>,
+		      <&iomuxc 2 117 16>,
+		      <&iomuxc 18 141 1>,
+		      <&iomuxc 19 140 1>,
+		      <&iomuxc 20 139 1>,
+		      <&iomuxc 21 138 1>,
+		      <&iomuxc 22 137 1>,
+		      <&iomuxc 23 136 1>,
+		      <&iomuxc 24 135 1>,
+		      <&iomuxc 25 134 1>,
+		      <&iomuxc 26 142 3>,
+		      <&iomuxc 29 146 3>;
 };
 
 &lsio_gpio4 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 149 3>,
+		      <&iomuxc 3 153 4>,
+		      <&iomuxc 7 158 6>,
+		      <&iomuxc 13 165 6>,
+		      <&iomuxc 19 172 8>,
+		      <&iomuxc 27 198 5>;
 };
 
 &lsio_gpio5 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 203 1>,
+		      <&iomuxc 1 205 2>,
+		      <&iomuxc 3 210 11>,
+		      <&iomuxc 14 223 3>,
+		      <&iomuxc 17 227 2>,
+		      <&iomuxc 19 230 5>,
+		      <&iomuxc 24 236 6>,
+		      <&iomuxc 30 243 2>;
 };
 
 &lsio_gpio6 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 245 10>,
+		      <&iomuxc 10 256 12>;
 };
 
 &lsio_gpio7 {
-- 
2.34.1

