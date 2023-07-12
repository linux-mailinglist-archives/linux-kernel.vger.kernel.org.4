Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9917507E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjGLMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjGLMNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:13:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4F1FD2;
        Wed, 12 Jul 2023 05:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHzRXPelaNf2rnzLLxLpHN7frEu5unMph7MUm1qVAQC8ueqre2nw/jaiBYsJD06HU1ucrZlW9v7pxBKobFdHx8BL4hpsoI/8iWwunmNoJatIJjo/T+krLUyZ6W10iGDJzckBSCvvU9P5cEWIc5CIBroWXnD8y4RwaNqNeLI2AHnuzVNEbA3i9P/x0qXfM7Yah7L47kUOWrXVNCTlmE8To6VPEFarkmVW6K5dZGVCZ0nSefyKSAJaQsmNRSyPOwKiU3XDuT3xKfnDEidMKbzyhQGaNbeY4g52y5JFYy78fvlFlI6aS2B+CL0jhlJYuYzkb27FPtYQw211WqFk3nQDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ri6NEoV1A0XeGDVQ1ZGnsekr+xNMC1qBTr0Zta6AGc=;
 b=Yt9RFysidSfmhjx2tuzD2gHC+UHri3G/rXotkAgJnP/5sMYMdMbhivSe5Tbmq3+bxO+UYGUDybEq3tlWErOV0yNAys+wIKXXBTmYT8Nbp8x4T3kaQ9MZBEvHBnKXS89UNA9/dsWjt2rIIxH/OvNkfLddI/j5uS/euyuB5+3itc3AWWV1s2O/wc6lP6dWgj8P+6hhNrbeGXvnkVg3XeW7xGtKRhyUqqyTbh3GtAtP8xib4MD7WUZLcw7ZvRmIb9mOB0XUTjw/L3yCd538DZRB+v/obwSHTpEgRzbbxbAGfYcxc9r3SaGgC/yCZwbT2kq2nW6XDDWYwYpdu11TjV3Okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ri6NEoV1A0XeGDVQ1ZGnsekr+xNMC1qBTr0Zta6AGc=;
 b=WSrsy9Z/F7l/x00B0CYcbDeTFe9n6ml3Ex3kGQeeYnyfGY49bmkHQmLi5g7r1twTlkDtbToT/7TOOOL3XCZOL8+eUSdQCP0qBv9xVFWpc53bTrZumIDOrtVWoXnBWGJhkKz2rK+JWIiDuiedYGTMyKoEWxgdufkKk8SESL4sfO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:13:25 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:13:25 +0000
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
Subject: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
Date:   Wed, 12 Jul 2023 17:42:16 +0530
Message-Id: <20230712121219.2654234-5-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06045483-117b-4a24-1913-08db82d1648a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXPnVqJ/5mnNYA51W1zkGxGvMG7F1WDEFCS3TjYImolqkvm53VJyw3eZ0GT5W7Rx1MJTXsd3TaRYCpD5zoFBzRC7UjKYrbbfKCAJtUiYHrxWBgxWo6zvVJ8Rrth3jXy/Q3mkHx+XxO/6+07RQ/ezpQQwvmOejYzG9dnKwAlaOnleYb0xsAQ3pgPLfXYtIFiiU1NFqr0LHn/2gnvEuAHot+wmBlVRbl/fme2qPG0yiUyKzs89Q3AnbtYJzoMa5hKw9zxC9lcKqXHGgojXajQs9A3ItIPjmd2Vgv9o26kKQa7OdF13czOABlGXF9nMTnqWkW2a8NtavT6LjnDYr0+72goeiDU3wxbkw6EK0+I/fnIs13MZyCsnyyC7RDaTanyNjefEQ7iqCfvBdCxfYmVcvnDKS8tHHYlT4yprYwNXGD08hTTACFLgS9BsiY5KdWakJTlUW/HQ/ZfewCIoiSNWItZX0+g3Z9SeHGUjLZzBWy332+E92WBfKqZVpx9BGuMXLRQ/16oeL57eQMrhY+wPp2j0JcEmxksAGmdNxGLDSYZKly3pQ8zXgRhe8OjlkssEChj4gddlPHot56f/qVIv/B9qd4+2yN9p9wfWpKiLoIOnVa4J2+0Cc+bR8eFpLwJxetdZ9R0TMELUazHO6E2t9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6666004)(6486002)(6506007)(1076003)(26005)(6512007)(186003)(66946007)(4744005)(2906002)(316002)(44832011)(41300700001)(66556008)(4326008)(66476007)(7416002)(6636002)(8676002)(38350700002)(8936002)(921005)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMNWojLl7io80TaQOB4Jd4BEon7K6RVZBwa6kDOKBs8auT2/Dre7YRqCNyxG?=
 =?us-ascii?Q?RkPTUX/vMd1cUHcmhOVyxZNKQdnBAsGLQIpRXINwOkkhp8DKklkpvvZX9qJt?=
 =?us-ascii?Q?a+1DLPJGu2RTR1s5rEQ9YsNU5b6FUB0NmOJX7q/wCSILNAGbNkON1POSl0cI?=
 =?us-ascii?Q?ufQWVgc9fXw2rK6DcwBkleD0wrre7DYjK49W6FroadeVPx63TIrbbIkphz7y?=
 =?us-ascii?Q?fDX7DH7UzYsn3K7kFcEUgaKnBUT1hH9EfNENrlfLbEOBuhK3pHvkaEctB09A?=
 =?us-ascii?Q?352XuJKOUSj0Q5UUOtKSwJklgBkNEFvh+EdDkknmhW4ALO6R8FwKG0moFBIV?=
 =?us-ascii?Q?gYxDY9x7u8TzI0RE7epZ8Ch+asVtKHmxknVQ/blSC/MvPtwWrkSWn4YPCjuL?=
 =?us-ascii?Q?2miMEb9zPELExr3qEIbQ2m0d8dYUFwfgBjsj/5AHXshgoCDzqLJhv7YGx4wT?=
 =?us-ascii?Q?Y2o2d0EoCxyy/OIpzJJDqGxVcM8eLhVur7k76IQHhsWdEUMvpplu1IlqLMJR?=
 =?us-ascii?Q?G/5UGhci+N3DyNzD3+loTdG+vd/um9Im97a6K8FJ0B/Y9UAc8eCPZIbt5BdC?=
 =?us-ascii?Q?tUFXcqxHAEw4RCuFMdT3RgXozkpetSHBrVBtWXsJRn7vtmUSDs+E8mAZ5Opx?=
 =?us-ascii?Q?Ta288FwYT38SISZ+/JNmEtWzE2faUKndPoSNQudrp8vOHU5GTarZBuEHb8Lq?=
 =?us-ascii?Q?kRb9/1ZTU8hu6i+ZBCXKydclVO37lI4QYSYis++OzgcWGS53bIiz2bGqBPRl?=
 =?us-ascii?Q?HUHUBkj8Da2gzJ9DJ8WyAZHAQV7ho6xFXKRcxPDhQnzyrT7WN8J5wq2ZLn6y?=
 =?us-ascii?Q?Msk3kF65VP6wZWSWoZRjBJxsGuwlxskUD86wAXflnXvSCVMKzHZQMz+lvnO3?=
 =?us-ascii?Q?bUho2lmnoxYBYkLwhCV/X8f/sIgRfjhiRULiCskI7R9vfXJRF6Y1AXQ1/xHX?=
 =?us-ascii?Q?VIGzF/TCYegaCyond/+92X/P4mEge6kj7TgIR+jSGgzoTQuUA/y+X6H/0h29?=
 =?us-ascii?Q?TkN+0cTWVXyDAc2GlUDXCM0YelgA/SXmfSIndgYM7FS4XTlImPWiVTPKGWm6?=
 =?us-ascii?Q?Ra/d4Cd4jyQ04bL2XkkzADQtAXe1eZw55PNlzB0QUdteRUfd9pRL/E1Bkt53?=
 =?us-ascii?Q?EdjBvUfxSj+bgzQw8q3INd4nVS5OtmtT/o6CCo0cueI/BWXQsl4CYSsbUeKJ?=
 =?us-ascii?Q?fXvHx/hE3oZaDESby4seLaEFPMVHMvLjUIaaNtAGep7fQ+es7MScfiKYv/ov?=
 =?us-ascii?Q?/Fv7DpIS4fez4h7JJihnv5hLqjvsILkyK4aXPuM+wuR9HONPHLk9Yy0OUkma?=
 =?us-ascii?Q?zNuQ6fOj7GJYKFWqSh5NH6AKfJpzoIbrsriLB6TFWp3dcbM5xgyQ30Mi9dfn?=
 =?us-ascii?Q?R+dxuH4CJooCgPXA5lgsdfEKhzq/6paCE6yH1qe4kI9AH2a8rXaC6OqkZZ3A?=
 =?us-ascii?Q?69I25Ax4sbUKAXzJhlNlAun7+j0+HshcYFQyliS6CxeGkmx49CxliucOXOKX?=
 =?us-ascii?Q?81AacBToMTsBNEQJUw2MkxO2quzpHH6kNqMwODognOmY0A0sm5swf75U796U?=
 =?us-ascii?Q?Blp6wbjBBKBeLYolNMCVm5Gl77WgdkEQiILtfBvW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06045483-117b-4a24-1913-08db82d1648a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:13:25.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33kCVovrTlKMzlCIPKYrAhdIIfKn382flSJ9sZ4G+BXbX6TUNrKbf61XK6VclR2kzR/p0xbI1sK8hB5Vc02e+Q==
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

Added support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx93-11x11-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..2b0f901d2709 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2023 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -863,5 +863,14 @@ ddr-pmu@4e300dc0 {
 			reg = <0x4e300dc0 0x200>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ele_fw: se-fw {
+			compatible = "fsl,imx93-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,mu-did = <3>;
+			fsl,mu-id = <2>;
+			status = "okay";
+		};
 	};
 };
-- 
2.34.1

