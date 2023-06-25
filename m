Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7A73D0E1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjFYMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjFYMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:21:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6991BD;
        Sun, 25 Jun 2023 05:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn44t9WAP8vW03WpBEDsd/WIbrC6iYe9LYWeEmV/qUj7byAd1tMIQ9xVieJLCOFY6iXhW8PCBGfoLslL3xQzZmTjqPsDFrZXo46v3H9uKQU4nAvQPI5PMClozUaoIYDcHk/7qiVhd4yawBD7foM6JRCDAo9oc22+Y1kIonQA+mEIuhRhqj4WgnFc/jR9k9jKm6LRh6c6FDf1rWOMqYio4u5aP1HFzCNk6lQdlwfXeIoequ8CNVHtmTg9nIu6qSFm4VsQVo842htwa2j5D/OeUiqa1zu45Ef6xGIRnH/xLMaDyYx15w5uZodzieNxgxOsmsZ7Ao5IkUlQuSG/VQfDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yASY+dZqUTx28FEahkYBblZs+6xPmJmYVcGPfz0EgTk=;
 b=RIUd99kMjcQPt37MOzGJB89GWVRHXMiIhNU2KPtHN/iRttufP3q8UKGrKnZNZvz0JyqKKk9RKgP3ev45aXY+0I9l9ubcDIeO2/mK0E47P7ACQh+kbMsqOsBr5ESmv5MmoA9+Lp6PLwKJg1CewCw3LumS/nuZ/jOYk/DgHbicFtY++p9JOhJYUPCYCmDO3g4JiitNyWKL4K6nG+1HXDbIgzRFdm/vhuZ8tLgVkkcAqa/eglGNNtBv/OqYFjVkKUA+79XttZHhFZltvygr0OYnAZ7IYjKacrLKHm/lbezp6LdGLc4JDL8T6s8F1Op/NaPm6AcEAmIUXhRPo1kMGyIu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yASY+dZqUTx28FEahkYBblZs+6xPmJmYVcGPfz0EgTk=;
 b=JE78ZnR7MnLUGSoy61W7USoBeJDs+CXrtIv0td8A2JzhRAdoz/iRf3GNShm+PNijO/Z2/bT2SaIdA7x2TZoAkmd6BNX36bFW8AXalQfy5yFhoyhpIlgx7ZQYGMNOTUUmJN7VERoJoOBVhm3cFJSWFAiHLfXF3fH6cI4WtHKtP7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 12:21:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:21:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] arm64: dts: imx93: add cma area for i.MX93 11x11 EVK
Date:   Sun, 25 Jun 2023 20:25:47 +0800
Message-Id: <20230625122549.4066027-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
References: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 87457a58-6c76-4e56-e952-08db7576a5f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nd4IBrCwwWJlCckj1UiESFoF5CvuvT7UtsBXejMWyIqVtRfvM+zc72G1t7IqjHzBJzc5KM0moVuUyH2Hd98fBXo5isyOHVFqhMrihUqAn+rSvPQTEVpT7IJTNntoi1cYp3CMQeJhULBVNT4FSKxoMypKMPb0Q0vrzZKYIp2s2xyDc1BmvFYKw3keXsWhPbkCOv7xjeZ82WZy+dj2ASMYHG3iwZv4OpG2fczOqduJTl5pjSVUJ/H+btMHX0TpXXPkIdGPBO9Q7QLrAQAHL1Besu+dC6LUISO+6F41/n3oWS3M/MLpLuhYDtb/Xm4SD1lXLV6IBB5gDLE/TAEZyC6n4SGKP3vjKV8v9YhxvmcmkCdnfrgqMnrjRZzTYw0bQtzJYJhrFg+Cc5ym7clJFBD4+iL+zeqbmjKswbY6X5ejpO1AZsTrjNlYW1EdbbMTa5gaKH98s3t/SbEkOqRAFyr7rQlRJn1p699ZAQRkqHwRhmnNaVbJhzp8SKkFM75uW42rOwRb97Xmu06+cQNJYHwLdBveAtiEGq3dD6vwhe1TXpsgmFhkKl/eUQ3pkYAHsrnjeXTvc14i2zaCVrXtXTwcmAEMK27GlCreMeCHONuqJd4ptrwKqSJ+itM2FhC1sxn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(451199021)(38100700002)(38350700002)(86362001)(478600001)(2616005)(6486002)(52116002)(6666004)(66946007)(316002)(41300700001)(8936002)(8676002)(66476007)(66556008)(4326008)(1076003)(6506007)(26005)(186003)(6512007)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYF5Wa7Qa+8ueG97Kdvu6XaAnoJ/XiSvC34Uc9D6789aCizVDHc1jUooNCfV?=
 =?us-ascii?Q?Es1yYlsWS3F9IkOxr6R+wglJ+xmFHtH7hmuAkmdqktko9GvaskLHNRQGSLsa?=
 =?us-ascii?Q?x8LCy1QfEkz67rgxReM4qvLZzG/zBy4RUmXdRPmBkkpbBsCq5AwxlHPmYs9w?=
 =?us-ascii?Q?HdSrfPYegqM/1h2okqFu1sOy0sGYBdGm3ltDFb+mHHYo9hp8iM5hXQBgKPZW?=
 =?us-ascii?Q?vsP17Odz6qPFeocMrMybuxIyIQuCSakAj3uvtHONDW3ebgwS4YqxFRHBiZhG?=
 =?us-ascii?Q?2wLUoJDJodQnTR3ZEB+l+ylOm9nMByc6LGX0ToG89lgRuBpIC1T3yFjrCpiy?=
 =?us-ascii?Q?d+9+7iVR2ir8TVObjs03VKXyaizusXzdDObACIetVBe5wDITymMUWPAPAdwI?=
 =?us-ascii?Q?rH/v5R4Nf7meP1kTqeXQWADW7z3my9ZWQE8AB2/NtINSqk2BUMlrA53XFrek?=
 =?us-ascii?Q?s1JzMcTlrxMIzMeW0vtXPFlAvbarGxNhNhjfyhjm3CX9W2JsGrewo2gZSBCw?=
 =?us-ascii?Q?Hl/SOvcKjYAk3aadti+dDUcVWOONW84IumXf/wunT2+w2Nwn7KiIaA1xMKez?=
 =?us-ascii?Q?P+vMOtX77qdCC8/6Gn6ZmUAvRBE/JY5z/zu1bFy8CMMzotO0CJPe6AYfjJwx?=
 =?us-ascii?Q?qcdCXAXiqtV8P5mljHW+61bsWXDnqjSuvTPEbQu60j5BjyzcYJp5PurKafAo?=
 =?us-ascii?Q?wOhTolODAOUxmzqwpisE+D7PgH91/LXLEwci9jqE6/6d/8T2mowduQtH0foY?=
 =?us-ascii?Q?jl0IB1s+1RKQB0uoAeZxtbRXzlyVMWb4CU3suNp66guBwyW7Hhlir5QErAKJ?=
 =?us-ascii?Q?j5GdUOH2Y8ayMmpUxYp0ZeZnYKM+bxC5SDamSo3wwUtQ/lIwJgK0Vxnm37mz?=
 =?us-ascii?Q?yy1nUEPvSboNGpmAS05ESHAN/LnT4zZutPBOt5qsOmCfEtZ/8QGfyVeH1H9f?=
 =?us-ascii?Q?PDLq45kzswMwtFoaMWeDmoMru77YjDkSR+IIUT3yI7e3B74pPpp/d6GJq2tt?=
 =?us-ascii?Q?cpazn30bJWQTlHK/CxubN3KyN+cIYNwjiHguIPbNr3vbp828X3eqPc5HOlKm?=
 =?us-ascii?Q?g+6JcVcCQHaib8gb2HPPOHxh7mDFlj76CvUFOeP3PkODsTT/ZlEJxyg+M/ql?=
 =?us-ascii?Q?x203T4fBGIFdP1tOt5yb6zO7/B9PVEZB8ka3VIW8f5b2ARTlzAdHs9PleZaN?=
 =?us-ascii?Q?g+Jf4jQA8XT55/oGyv43d54R/JfiGlbe+EJvNXLq1HTZPgk41aMoXQLjkez4?=
 =?us-ascii?Q?JP1cnFH/I9azFiVoumWm9aodlrVeVGH1mT/zU6XvM7tl3Ph16QhGTCOF8Y0w?=
 =?us-ascii?Q?czvqZozJyGtXfMkw2zbc/pUhPBaW3WLrF0gbTq9u2rYSFlmsSWP2afHiRlFb?=
 =?us-ascii?Q?LCoam+1/rLJOXYhChiu4HucUe28jY80Mj6hK7/sZIq9rF6XTNu03wqTdVsfp?=
 =?us-ascii?Q?pwrKqeEvct8VZn59ZRWX7XoPyb5UnshjBsrLSx7tV13AVujaJQUQe9CGWvo/?=
 =?us-ascii?Q?BMZ+lhHeVjEIyAUfKdNhOjMHT/8TX1iC6QgK2kM46MTNB034UCX5bp4gIoPb?=
 =?us-ascii?Q?i0nEaHOOje5BLtlHzIIkSQ8xEhDpWh+t+Cmsvd9t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87457a58-6c76-4e56-e952-08db7576a5f7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:21:05.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgB6+FYjH9+4gXBmeoP7T9V6zdI1QyypL6qNKM4QUsaBRbSU/2BKgIXitwkvtYSRdcnuO//DvniTo5yUPWyu8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add CMA region for DMA usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index c50f46f06f62..359ae86f4e7e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -15,6 +15,20 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
-- 
2.37.1

