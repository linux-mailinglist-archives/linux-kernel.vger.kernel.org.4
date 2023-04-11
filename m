Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0626DDF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDKPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjDKPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:14:18 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B965BAE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwJGFf1qC56lIm/PFN0UFU/nsiFgjsb2hjHLWhMSBbEkdKA0uNCio8PFV1Rzgv2l51CouQhA+6jB2iVgUnFFGyPiJWm89D+9xAWZDs3ROtU4T8KQHgVUmijXWGe/D6dh3LhCIqRY8iyzcdlNKbYWZMZXRiyclcNLr6kwxqHX1GuAF7YUoLgq2iJjP2WdImjcNjUZECklx1u0/k6v9rddLQEZXQdMMi28O1Sq2Mg1wDrRgMAkNjPhdE44+SNhwh7RjIi7FXq9/VLVbhNYAsk6Pggr0BN6cVtZBegXrTaNsapdLXcl+3kfZ4YgnARAaTl+PN5ImkjywcF/xAKT8OXmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDes5gh3xEHbJOjkwKYafxKv/aZQlBHuqB0mkO+7hwI=;
 b=kyhIwR5nDsJNO3d0trK44shMj8Ii45GkN0w5ZoOHugBOK65vw+SWd1eXsCIXGHPEBoDmURPk0s5dqqIGuh/0aJCGm2gSQ0+GZ3CHcPdZrFE5Apv71x8Ruj9VZvdJse7ZLoNnwycNx5/MGDZrRt7tzNGRGfiq+bAQdTq3Sa7tqUDZR1e7YUnEPdERu0LMu7A0YGJaDSxubZ169mb/ZYKGczETPpVRVKxXg6k3VIxcPV7YNvG5CH5aj4BmfPPUJ0sRyYoiIZ181/w75x4OOhywZYZ6FdMxLluMTJ0/B16PisMjgCjPrFVPw+e5Lt8JBzV0DQ8o3e383fCPFTn5WKzmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDes5gh3xEHbJOjkwKYafxKv/aZQlBHuqB0mkO+7hwI=;
 b=IOQUJvZ2YVBgPyeE7dTK9LMgZd0pwTep+xG03ZK80H0U+m2NVTGmGOaNKiKBWwDAr/BtY9odB+RYGmijYyf71R/J3sjsvbPDTGos/FW0wefNzf4T6pmxC5NfB41gvflTu794O463QxuFd+kJDEZWcYjx1LrtLECi8AjEsXO1RQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:11:47 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:11:47 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 3/7] arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele-mu dma-range
Date:   Tue, 11 Apr 2023 21:55:32 +0530
Message-Id: <20230411162536.30604-4-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a61dd2f9-791c-47d4-ca6e-08db3a9f1195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O67UK3lcO8Ziua366Zu4XRauwIpydVbpDjdLrUxaJXeeuoRDiPAWiqli2WsWpBKORxMuiJtaVokWZJ/R0R4ofpnfNi3mkVSxkjzJcjhhB9kHVtM1iXCaUgN+HP+cY9u4t+tbGZ1cvkwq9ZY3T4j8dzj+zpuFtchGMXQPDyo10nXwMui4c/8gQSSXDXbfczA6WHIT1Uec/UW6Myzdb23JYKGpxxrzS08cXNQ/iEdwB0OP+XrDptHWGCAzSh9jNAEoOqIVGLNqeDOtXrl2ipb/92p4YFhDGVLiuteFxdPWuk3sOZ8Ps4eazlSmrNRaFngI6CPd2LCBmNAOYZhooucI3hQjiZvS2Y3YI6M0HOo8auNCd3FsBaEFv1DOJYi+7bcjbmsC1fQMHaCAmVJnirgYeR6hvwMT/fINNPhG+NFAszs0MF4CFAsn5UxYhWFz3b+u8RnDTfQKCfDQO8ggvPJioXQoLNs2/6Ol+sQ1nPaNW1dVl9SzCkAf0ylFYR3tjaOB8OvNV79oniPzuYoZPxggLJt/3yJQfP+flh+bHcoSaYPtX9V6Z8wyZA2rBKXRaiqnSDh4J1CXxeiVkToDqnG7YHBO7vU7mW9YTavEuO0ulwytswVUpgB0/qnG8tK1L9Wr/8n2ilvl0dUnCpVgZZwrNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6486002)(478600001)(4326008)(52116002)(6636002)(8676002)(66946007)(66476007)(66556008)(41300700001)(316002)(86362001)(36756003)(83380400001)(2616005)(26005)(1076003)(6512007)(6506007)(6666004)(2906002)(8936002)(44832011)(5660300002)(38100700002)(38350700002)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZns1isWpvVbkkrGO4ufpg1TP/eZXWdvdCqv+s4NrNqp+x0dHe9ygk3qYWYZ?=
 =?us-ascii?Q?KNFpklVyVgGG+0vxPPPcFkprrZypv5K7SX712ofLencNThmuhy2WH3Vs+XTr?=
 =?us-ascii?Q?7nBVBbwYFzRW4YeuAY5ZoM6mPxWoplz6h4Sp0JTK8pAmXtfvSB3By5AeSQtG?=
 =?us-ascii?Q?SFic7s+TAAXQ6x5yO1kZKfSv+6vMk0VA6Rz59+ZbnQeO+P8kyuwRFwTd55pI?=
 =?us-ascii?Q?3MqvgWsM4dXeo2c6v/2mLxqZMaAFS0qkRa0Mp/XAzXfynAvBkeCIgNtMVk58?=
 =?us-ascii?Q?OwvYHJO4Y6yhEWs24BxfKFdlXP+RAT5Ml4BDwvrm3+U3W1NYfF345o1aFrtj?=
 =?us-ascii?Q?yl1Sf/DOcpq2VR+fGFk8XxfYkKiLxLr1y2Ww1l0QkNTyM59HT7r+MnXXTJdz?=
 =?us-ascii?Q?Qi9eq1OvNLBkKD24+IuIgowc6ziy+ExPnE4/ec4VNYSQWNbD/R3+8z1volmP?=
 =?us-ascii?Q?mot0Ik7gcuAJbpmiFmSKYMoGqrk61ac5bFzbzvDDOoFZf3oHD+f8KRidoYyV?=
 =?us-ascii?Q?/vykz8/uX0cTe9rrQB20jmAqJHyuQunRUyDPzMLfptuYqwCZgRQB78HkrLMg?=
 =?us-ascii?Q?0P/8bGXzuhUAknyokIcZ0k25j48xuzwvjVyo6HecuuxF73m/ZEPsalTMfJTl?=
 =?us-ascii?Q?wthVAdiO5TIZSCFLQw2Kl3LwVnTjWqagxeoeVtrGgtkdarH2ItCjf3li038F?=
 =?us-ascii?Q?Ycpx2eAlNcvvYVlh9Y/3YfQOafEdEAgxQkvfTDpy5wMPe4l3PAommVDTvtwS?=
 =?us-ascii?Q?y8Gu6sJEEBfRv73jVR8/NjyEhZG9MW9DY0o6u4Pv9Bg1oJI1DPpYDtRFfpsP?=
 =?us-ascii?Q?y46WvpVr47kyUDtMKmz1BlEO4RMpIWsQxKyHwrhsBZp+XCxqG1Lv8Nh+sRji?=
 =?us-ascii?Q?iAEiAp91K3MLRdDa8Ug0OMJfr+uL2m+ztUQqCQUkI/i9mhaXGypVBiYh97wz?=
 =?us-ascii?Q?Jj6BtTziqvwHG54Lzc/E82gMBT68cfuUKre9DDBoq3v+q+LEwd/vuw01hYjo?=
 =?us-ascii?Q?CPk2wp0+I4YBaL/VIz+Rw8hjFtXGsD1JWrgNl8XAI+EeD1EFszc84rTvPiFb?=
 =?us-ascii?Q?hu3CJrwDLX6BplJpogWZmo33LJzgRWIeNCJGn/6PYCHFBLggGSxchqXnP4CL?=
 =?us-ascii?Q?BIu5nKqATbarUfguM3RqxCZgz2x7RL6EZWeKjW5Dp1U7Kn+bXF3qeo7Khywd?=
 =?us-ascii?Q?EIeeyG9Ztwte+OnLIP9S/vOKF9ddhFi7dxjHeb5bZ/3svfjb0NubvRj+NTzr?=
 =?us-ascii?Q?iaoSowNvmpjGpPjLdN+yADDrbvNC/7Bank+l6fBBG7HBt6r8Di14own7VlPd?=
 =?us-ascii?Q?pNB9hMtV1ivy7r6Z5YWkseKe4L5KkqMmKNrb0QHvNOlcpvoBQgbYVvFvvY0O?=
 =?us-ascii?Q?4dnJb4ErldlM/P9RzIqbZycWkOE6hiBnXBffNh/U79Gchb4b5GEyMObVPgOa?=
 =?us-ascii?Q?8CuSiFfCq/223M9evGywlyp1/PmCGXraKx2sawW8B821NWOqdqplb5t/vhKY?=
 =?us-ascii?Q?frDcjRISV3muClrIiXtDJXENe8uIwTcAa2EJeE2NqaBD8Ajt3KwhaDxYqE1l?=
 =?us-ascii?Q?TTpXeVxQnkH5d7VsPRZrnbJuwmVhO2lKV2YqyUVS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61dd2f9-791c-47d4-ca6e-08db3a9f1195
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:11:47.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbbYr6AtJWrQ0v8VPF1oYpJD0phRC2BdaJ5WwGJi3B7wd5ly1JUmt7F24oFNuOVnvxXDlxEb2RlBOmyySvZEAw==
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
index 477c146f985c..2e2c26e38af0 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_mu {
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

