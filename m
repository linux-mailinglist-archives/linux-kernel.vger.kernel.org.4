Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79173F110
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjF0C7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjF0C7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:59:09 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1A19B0;
        Mon, 26 Jun 2023 19:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBbTjwU/Ujnvny+D6Dxg8RLu0o6DhtHuTo4YdxjTsBac34KOgDLi5K58pMOFWIKZY2B795M/69tdZH9j5qH282MZpv/Pq9ndKH/96JJwzdHsb19FsXBYOCi0GQ/WllELNJ1djSolUuE86kD3TG1D3Z8ujqjEVxDkSxbWY4Yg8HDUJSNEOrUhTakt9gyiTbl/faYhQP8VmevMR6ba+lFcIoSWoYZPq/bq3OBEpDSssAralnuomXIOSFNoDdXK7MxX2kMmNF2rA6EAZChiQvuqLBI7t0bV8Rhk3lzdPKTNVj3WnodgYXEfgEE8HGtGtl6p/3HWVeBOb+g75ESB5BQ/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=CCBKRci+mwAXN3V0e1M+o4db2V5bDXgY+Crpe4MpLjFJJLubHlvaXXFPttwbYdB3l9kMa0sAdN8A4nf0uaviOEcigddsfjek0dpX9LhSEYKaMJK/rgL6slaRf9TTk9RDjb6kue8oHwjEDxikbjNXLf9Q4YTSYyY7eH3Naiz3czlUrNwXNNAHco/OdKNrAkp4k2TJFUfieMwHG6d6q89d7SSYdNoNV8VJ6yL5z+b+TwX7oVSoYDPngQRXTyvOzAOEJfQ8UwNDo9Dl0OKggbzmS1tRdyPtFfigxjpImVttC+VpgiWGEZhCybdUP4Y9ZY2GkbglVlQGPjqE+AsVflHxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=SF0P94KUYh3vRdakwFL/TB1ysBnoFQCmD+E4Fo3V/z2rim7LWe2TULdTXIlvOzOfi6lWtvqlSFmXdHc247UlY0tx39lukFz/e86alctKh5aRBvPzKVCdkj0qK/HPr2L+A47cUcf3iT1ZTc2xI2sRSaUS8ctNIkPaeefaHg9UDuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:59:04 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:59:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 1/3] arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for imx8dxl
Date:   Tue, 27 Jun 2023 10:53:30 +0800
Message-Id: <20230627025332.11133-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230627025332.11133-1-sherry.sun@nxp.com>
References: <20230627025332.11133-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: f80e8eb0-16ef-4a91-6490-08db76ba7788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhjHRbQ0ooRwWoP86HcOmds02ffHs/LObMMvW6aJIPa7fskvXi3a1s1sG/nicVAxzVqMRCu/RDaaYY5jAM13L4iVBXGR2S/9xWAZu3EiZRW3ZlutbszUUBuUWf2HGCSJ+DKH74Cnn+8IXHTsZLWCsaryjK2VxfAcKErJfLV6mDmB5uVYX3W1d2ads//Et8xMbR1Y7+v04rBYGct4ski7Mqul9dK3HbUyDgspz6pvgL/Sll1/CJI0axYxRu7uuxEM1ZrIOKRRbC9T1dQGaM8pmWbZx3YhM2WHJo3bICQwC9BU+RcU/5jsusDwY/UIX4bsej5a/1hSUPbIPQdV0nZYJ6nOEOSDRX0CRAqjXAH55pVvxln7zpmMzfk1b/+Jye8n5e21/UhzgZPu2Rx5jnRbNSPTOtvweVfOQEtUT31GOmhmiuHAHCt31TlJgdQdfoQS6IQWTQW7Uy5m/3lwtuITdG7tBjNzCTWK2PgEG0ZLgMJ0FtkFs96vlQAVyT5FJMQ9BL4f2Y+neBUPYRl/sbduSKHDR0kcRwzxs4a1d9GZMkNkIm2ZRuw/GVpm+AU0W448kYRHn2212Gajxz5Ah7RkwPqvaPkhFos7qWLsN/+FC+17Q1F6Gwk12l6MK8DPgMqt0087aMrCqFh5Amu7wIrYrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(316002)(66556008)(66946007)(66476007)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(7416002)(44832011)(1076003)(86362001)(41300700001)(6486002)(2906002)(52116002)(26005)(186003)(6506007)(6512007)(38100700002)(83380400001)(38350700002)(6666004)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8qlOWgFbAW0cyhZdG+QovQIwFHblldTVNRn4wC5/KcaDTFzR9mhQKHoQcEvF?=
 =?us-ascii?Q?zyEDCURPypncr6Qnp0Yk29iiogJbfWFQl/zCVbXnzbQfx8tXrIL9DxGrNdPd?=
 =?us-ascii?Q?Y7jSZSbBgSx2F/eqFW/lor+0tg863wVPn3zPKYfaU0h6yZdk+wL1PCWtwuQy?=
 =?us-ascii?Q?7PDw0myqyqOXNuhjFG02TQxwvJKmkZ3AxHcCZAqUssevLEMFE2OTRTI4I1L9?=
 =?us-ascii?Q?h9BrxyNwor1OjhJ898WVIjW/lYVEdt98pKfu5YqPLP+0Hh27/gJzArqHhtuU?=
 =?us-ascii?Q?ydSm/R0bj6aoJ4dkbKA9YUjeLMLnlO+i00aDn12rNVt0eE8YM9FpugVpu53F?=
 =?us-ascii?Q?opJiMz1wAu0Jyvrpo0I/JDLZFojRJT0HmQQqta43hYHDUC60ViGew9LQFMoR?=
 =?us-ascii?Q?mJ9z33s30K92TtlP/PgyogUxkfGeS/xHuxrYHVHE+9aq7r2TBRb3nCa7JfmA?=
 =?us-ascii?Q?W1o+Bg/Zt9xa2weXkZiXoUVAy/wCB5HhP2cRSK1G6BtxsB2q4wwrJDENL9Ka?=
 =?us-ascii?Q?99R7K4NadEb4ImuAxJtLQ+V6HLqJE8ocYRg0LyWxcazrWYk4L0GCfST90Du1?=
 =?us-ascii?Q?Mo936a6rKshXqmoLz6wUdD+4eVYYvgyIGu/27BOxowxluR0rcIyeAc4g3L/R?=
 =?us-ascii?Q?1i1+1IKjaLwx1k5bjkOiB3fMoyFcKu5ajmZfQCQyud1wgrLiTEk7Y7/yb/0n?=
 =?us-ascii?Q?z2cCnPAaszTfWgRq9G3w7TqRHjEXww62/Mett8YatHIB/Kc/SYeZmbOX/qYd?=
 =?us-ascii?Q?LT9OM226Nopn+RQQCe6SPu96RDzX0MKPVsgH7i9Be67oPCM5OKDTmIaSk4Av?=
 =?us-ascii?Q?C9aoOyaaprDH/8/qGR5elVwczkmyR9x9dzt761+LI4yVb71dQ+ak3LSjTAYz?=
 =?us-ascii?Q?KqOpndgobVDf2SQhm2uEoQdf+sUrBvjsY5B03xRIMQ/4ccEnCBxceATrfkEa?=
 =?us-ascii?Q?ZS+PW5wzxfdn0LlkakpiA/k+RFSCjeC0VudzZukLVf4RTMNIKT4bUDoIzI9H?=
 =?us-ascii?Q?McuWxFDVcZN4c7TgpYddWEGRyzExdFGQwai/fAzEsmT53dH8fe3VQmAXGt5t?=
 =?us-ascii?Q?VInsdS4yDOVri0nMsP3Rw/pyZdAZ/LWcjiZDH2BIGG/gvTuw0usAdn1haAQT?=
 =?us-ascii?Q?w32T1BYeF4RmT2cMHQUetj/rKDm2vHnEBp+TWONMUu9cHmdLbqveiNZnJIRH?=
 =?us-ascii?Q?B6AfhTNDtnfE0S1V7qAT0e0/Ky9BZuImwlvhDd6IOu8nZ/KC+E0w3EYBCIgw?=
 =?us-ascii?Q?JlU4PNcrS7HnltsQrW9oIFCkZt52PT59l503V2fnxLtMZTiHV2MBuh/vFuhB?=
 =?us-ascii?Q?sN4GhERCzTHp+KV0KRRmVqc98+ujgwa4HBsjBU8WOEXyvfYzg2H1tLVmIdAT?=
 =?us-ascii?Q?fXK3sU/vPg0x8oSLkmr4N0/YaCvMHqWF6FIi2f7Jrln4otDmXtrmyoz1ljsh?=
 =?us-ascii?Q?Og7S5P4vPbqFW6jqOUSbr09qDLMNYIegOKe69yaTWhaNq0okSo/XC+3cFesy?=
 =?us-ascii?Q?2n+j/63xLfN2YM0HbYXJuJ6GwUdka+AnupdKtWiI5snrN2Kp/VYrA/j6nLGP?=
 =?us-ascii?Q?UtVxrE/IF1E5aO5VeN3h4mVzEUNtOZzENBkut9F8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80e8eb0-16ef-4a91-6490-08db76ba7788
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:59:04.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI+02GwsSlRMoDg0t9D7e0pIHR4WxoxxgCMPqc4PYQN1cY6FQRI0zlG9h9pD8S4vkm1HBOB7k5sux7Izhg5d2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the i.MX8DXL backwards compatibility with i.MX7ULP since they
differ from clocks handling point of view.

dtbs_check has the following warnings:
linux-next/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a060000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
        'fsl,imx93-lpuart' was expected
        'fsl,imx8qxp-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
        'fsl,imxrt1050-lpuart' was expected
        'fsl,imx8ulp-lpuart' was expected
        'fsl,imx8qxp-lpuart' was expected
        'fsl,imxrt1170-lpuart' was expected
        From schema: linux-next/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 6881330ab4c6..e2eeddf38aa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -36,22 +36,22 @@
 };
 
 &lpuart0 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart1 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart2 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart3 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-- 
2.17.1

