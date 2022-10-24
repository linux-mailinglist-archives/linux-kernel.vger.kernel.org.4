Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601F60989E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJXDQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJXDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:15:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7BB7962A;
        Sun, 23 Oct 2022 20:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/kNaUMaQB16JDxnU9I4u+G2ZbK9KXwl8OyM0IsNf2hH3TDW+7ODppzWcayFNEvEgSfLnX3hpv5q3GbbuYbzjyeRDHAMrgrIO3FsYGVJsNlbgNjKWCSqULzPyvBURZztCa+mLTY7+N9SicWgSxdKpsL4AXChWteYkjlucQabusbmS27zPvQWET4tPt9PMTdClPWZTQ+bqcopTyuADl6cnFg39r0jqv/mngplXu5vwaq1SzaRlOmohxYes6nMmXn5MYH6qN7Zz30GMgmBKAcBmOUOmlUNsOAB1tdsFh/E14d+hZWRj3KtD9glVgNP13lBf4HmHv+hce25YaUPV+GngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Q9AOHQMXt4wCkcqRDZ4U+/hVLe3JLkndEzNEt0LNc=;
 b=jBl6XOKkd5SqrkXD4DoUZq0v2yN3w2qZJXKgnKfcUbwytkuP+cjukFynsIhvssdqYPrOERVoBOv15WWgn42i7BQkGdbs7c9qhPPfK2vV1dA/Eovpqzj6ZStqAIADHeOB44iTbVrh/2USdSsL/YucYL/HpZ+vr5WhSmlGQiTynXSMaYLbMWYw4DY57We0D0xijyCq7aKehITz3gCoYVhXNRupfpXGz9B8CSIqFAFcmUAIrzR1pacWMMDFcLRV0XdC6D7vGSD7ycy80YtLcVhi50LxF2C7Y9lBWMUgvLC5hhx1mCb0eZvYnkoQeR69G43IiioSeCuH8gl8O6tQdD8jMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Q9AOHQMXt4wCkcqRDZ4U+/hVLe3JLkndEzNEt0LNc=;
 b=mVmD7OJCuOtQAlsGk77n1FGYv4Q2ZiaThkTccJJVE3kBo5TgpCLkD6BXh8KkZ0QFc3vqJ0aJIv40Q6lkNWxoN8khBF6FJd1rqPg4sRhCxDiYzT0F03H+2oKVjrutuu+8sBQfHkunMho0zYdgrjIwibgHb3y6O3eEbA9LPbescac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 03:13:11 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:13:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 14/15] arm64: dts: imx8m[m,p]-evk: change to use off-on-delay-us in regulator
Date:   Mon, 24 Oct 2022 11:13:50 +0800
Message-Id: <20221024031351.4135651-15-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fb9de8-5fe5-41eb-240d-08dab56daea7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko2ie+FQpjsFAu28WcigI56a4728+zvQ3M3SMigbR6SWLINPr6GJx4n3cmJSKO3BzUHG+/eJ4SgOauSQSbDAfsW9oa683LQVOlsOkBKBJmsBU6cKhycd/yvlXRRi2VyesAbA+G973Q5ABKxLY1wzv50lY/aO2s70phmYdzv2pxOMX0F4A1gcFKG2QIZLJCSLI4zqZKhZN7Lu/5eitW3Xu/Zw+Eq0PUp7kdc/FRrsVge8OdV3lV+rCq/olRHy4ZIfTNQTwWh39P4LHDrMF9/2jIg4l5v560mrVC01FIQFTbtrgNZj4R/44qjkS/YT4gRUiGWlpw47H8KeioerXqjdA+28e3R4L6scnN45HyiBOYtC0cp+BSTqw8UUhjHGmhKByDhUoo9JVw/V+g5BQO4qRqrM+tC6VY/byMboDyPM/HQK7KTkWaP+/mO9IA5Rygip6oaIZCWLmxieBPP7kJO4IZyIdeATSQ5TLDrW76+L8fcJnEthqNRTzJEQPEk0rk5fl50/fWu161qYZ0N/B5njOhNCGxCUlGOkcYnDmDkpND70Zrc/5RLI4Bh2ryUd2eEB59jiSNYLueEuoeztDv5hNKsmOBaKi2P0NN/LArkn5KUbNMV8n4C8jw3bBwOCgUtZpR/u2n03F5VGlxpA/OW/r3IB7smbq2xYkzIRcc4mj4tqn+Mcfgim3B5C4YobXVw1+JjypIwvixGSGvigc0uF1UuJV5wsiorwgpWKwImXSDQYZvF+TMtk2KFzxqQMh+XLD8V1UTx29p24e1C2U1bqaZZNHcsUYeLIz6PBllJa4/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(186003)(38350700002)(38100700002)(83380400001)(8936002)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(5660300002)(54906003)(41300700001)(86362001)(316002)(2616005)(6506007)(52116002)(26005)(6512007)(6666004)(478600001)(1076003)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3Kh7G8cl98C928xJuDOmKcuICR4XSXpztUYAc2GDbI5EExLEAPEzhpgiXNN?=
 =?us-ascii?Q?Jfb7iDedqnmhwFJ3SVUmszjCxcUQsOG0IDZT1gI3Bh485v3gXfgoiN/PnPOF?=
 =?us-ascii?Q?WRAWGC0Jz0UntY2kszSITNkACwxdaEhzDYZYb/h99Pk0jcdXaayiXBSv4V14?=
 =?us-ascii?Q?eZS0uzWDUYFcJhuF2BOVCEH4SzBZB457PXdUjTRO/WVitrM15cFNdkqDEqJ7?=
 =?us-ascii?Q?gqEOXoRpveVLS5OwAZ/PEb09tPLPySmOajbGkl1DfGNQ7167oIRMreTV+YAs?=
 =?us-ascii?Q?spQvnodWIwQR0SbXJGD+GmeX+0xsrbk6O/QeBybY87Nwe1Fvuu0+8PSY1a5U?=
 =?us-ascii?Q?ptPwyye6sJoV89EaVicL/vxYFoMo5Vc5E7WrWSRyQpqI+SXECjNkj1QwEiSl?=
 =?us-ascii?Q?zNP7yL/V4ppdxkWYaNmgaU9HHdwX4jQ02JosIr0QPiuQnZCL0NpoL/CbJ/8z?=
 =?us-ascii?Q?uv+DU3NGCEZPQixgdVkEa0p6O3iB46AaYqXKWptLBSbSYCZ3RZIyF+t3SOnJ?=
 =?us-ascii?Q?JxVrUQZBoPBKBp2pFH2GlroY6j7e/5BGKoBvKP2indZ/4JnlGH/12UE07DXB?=
 =?us-ascii?Q?/A8HhHaAeetd+OdfMOX0CPAnGaleXvYMjCxyVgqmVx7xQ8ZrLNOMnq6WIXuB?=
 =?us-ascii?Q?xQ1YmDW/6lIXnUJ+7kVbHszELW+Y2UJS8v2B8gYScDaxpxbkWHX/+WJA0Snz?=
 =?us-ascii?Q?v9cLqG/47N7pmiRkb3+1s7BZyylnao/SgUMNWyXCze22YFbK+rNI42k6a2Ac?=
 =?us-ascii?Q?AZiWeW1IjCfOQFU3IuLR2hnkXYD+k08JwD56uHcy33EFMFplmALgQlY4Lz8l?=
 =?us-ascii?Q?wS0LP3qYvF73sScJVkpenXCZMLNqECo1zBdDIvh+dWzkE0U0/YvWvj/gJe4p?=
 =?us-ascii?Q?E7N//2Ixr03nebWk2icdqTr/fyE5JQ/vTO6KfLjUq2XhLkog7oK18EkA8HsA?=
 =?us-ascii?Q?rs4qi00qO4CU2quzssLZRVFiwrd2Cm5ldLlgXp9pZ/pSrzn+AmmjwvicBs52?=
 =?us-ascii?Q?hhxztxA/EhLh47amJzi9aduUvQ0rOzuY31aMybLKGMtnvj5EFsrTV95su4fW?=
 =?us-ascii?Q?cm1iZ78za5Aq9Ecs609M3VEkopqVajtNFW0VSeV9b7rIGJhaoxLg4q9FMdw1?=
 =?us-ascii?Q?irX4Mrpyqh/3ilsYDtMGkc2mwE0sFpkxoaRvhmOgM/hxSAAr+5JsLt39KVjl?=
 =?us-ascii?Q?qImRZIkY8Ym6CleJYoUOb2AF9zMZtIbqUGmQ+1mjY5UQzdOosE/VZT5mXsvt?=
 =?us-ascii?Q?noXikSZzeJSxDYKs/q+6S6J6TZvIKgPjB9C2INTynexElYC1DqoOFLGwWERD?=
 =?us-ascii?Q?KSsnz7fMERYCXilwChThwH1+fz/y6SQ9EEj4feY4RMS4lTQT5sb4UI7t3bsM?=
 =?us-ascii?Q?/eP8LMc+F94phTT/waUUsGpsI/TW5RH45kQbh9CMADgKEGjKFIMBsETLbrDG?=
 =?us-ascii?Q?Kxxq/aQqHuyINmfbCwCVeyhBEweD2x/9r0uzvhiYvbF/FGsmYWfWa14MRjuP?=
 =?us-ascii?Q?yHlgOXUWN2jh07IC0jBxXKFgih1s54+6fIGr7rCi1eJOsgDinpsLMEcMe6ZM?=
 =?us-ascii?Q?wE8L0/oeWq1f/ouZp0GGxhJs2Rc31zrtGJnr9WDf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fb9de8-5fe5-41eb-240d-08dab56daea7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:13:11.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9fIAuGVvEo+YBzOdikjo4Omb1AImq4sYmTa08y2ydKQe2FczvLcxL6ccBRJPuHOdKa3mlJgfDF3zeF3qX6Mag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Some SD Card controller and power circuitry has increased capacitance,
so the usual toggling of regulator to power the card off and on
is insufficient.

According to SD spec, for sd card power reset operation, the sd card
supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
next time power back the sd card supply voltage to 3.3v, sd card can't
support SD3.0 mode again.

This patch add the off-on-delay-us, make sure the sd power reset behavior
is align with the specification. Without this patch, when do quick system
suspend/resume test, some sd card can't work at SD3.0 mode after system
resume back.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index c93387fcd498..898735965ac9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -22,7 +22,7 @@ reg_sd1_vmmc: sd1_regulator {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
-		off-on-delay = <20000>;
+		off-on-delay-us = <20000>;
 		startup-delay-us = <100>;
 		enable-active-high;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index ce450965e837..fdbcd2483efc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -56,6 +56,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 82387b9cb800..07d9fb2aacf8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -46,6 +46,7 @@ reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

