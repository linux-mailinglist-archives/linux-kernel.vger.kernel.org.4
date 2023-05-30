Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC62715676
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjE3HTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjE3HSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:18:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6918090;
        Tue, 30 May 2023 00:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy19LsoI//d94LT0wjD5pF/CVo54yelbUEsZp/DSJedTLYNpmUXEI1FFqmAytTLOmJQ4BTli5SuwfmY3JR/Ms1jjgBHKGgApWjz1KmJvPhgrWjBWLOACbyV4jlcsEGuozd6I9ol5J3KkTGOKZGiUckNRktBvf8WUhVl65TQqxNqn5vwQZRwFR9HjCUgjPKupYRsxfuKzw1HLOtuQJXtBJbtVnocRK1uBsL8MGW1hjdhVl/K+UtwOE5u51JvyVqS7vJcceI1APGlu/7jBSBx/UngInNlHk5Xmq1gFEijSirK7f2nb7biidmogs6tI5GPeQCWhfY1wT7UmhbAb+C3Yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bEuT3Akp62ZfYHy6luVNNKX9T0bttqvL2nGd1nvaRw=;
 b=Ls6sRgk9sNi5kFyp+D+KrXvZ1i1qzMw9N80aFqQDPCMJnTjS9vWVkeQN8ane5ULpSgKZDN3fDtdNfeXYAPazJ4N3Q/SmOlazrSShli3/irF2j6dF9Z5OBCDNKRTlpT5pNToukklCilJ4Gp9+nDFfHW8FPpEQwU82KniRwl4GqUcn1+ilsxqpKWOu8WBegx/ZJANfIjUYYyfvFczQz2R9qjMYlVq2gezP4fXV6qeFCFAC6M63WE2X2s00v1y/dofyF00PpOqRJEmYuLZum1urgg9isiEtxF/uo0B7dNPsckYyQT2iZjcTvQVm0U78Igl4h7ZTEY5peuaWFX9gWCly7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bEuT3Akp62ZfYHy6luVNNKX9T0bttqvL2nGd1nvaRw=;
 b=oDvIihwmAN4zBagv4Fr/v+hagi2AZ4hsasyFVoRnmnNsmpgg1Sb6my6gzKIxBKoKwzLa8uUu7cb2XKmol5oxKEQ01jgR3+yoXUYWlmy2RCPBUv9uKef51aK9rIIXdUbtQMttXnNYT94j6cswTa2AkY/huKtrT8YfILmEm9MNHE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:17:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 07:17:27 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder
Date:   Tue, 30 May 2023 15:16:31 +0800
Message-Id: <982f26f268822a5f4e43847f15b1c40f6ff537d8.1685430841.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cdadb4a23697fdc97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com>
References: <cdadb4a23697fdc97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 177cdc34-929a-4116-ffd9-08db60ddec61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1q2Xj5zvHbzHqUQw1LQvGSP6l2R3at2jYHCQzEN1foEowlGwIWyJWEZqlsKRZGxki+VNbBFmXGxoFAnCF4jrH05AAZRg4IdWLqR+wly/eJ3lcLkczqrfPNL0t2swkjNH77xGQ7eAVkX7lPxH39e3HmwCPxd02NEvYR3xCKsBFsrCqRKdq8NuGqvquLoPs1C/sLw8N6c5ExYCzIkOsYqR61vBj2qMt/stQQ24vcYTBLHYKFNqu4yqm+9AKNuqxgtFONeeJshouCTuTfF37FmVXzXY/uZ+hzQ0UR7w2duNaKNFqPuWyEyYRPwOn81sY+MEzbO94iDgCSxUgILlijD9xIIDML06IPCltDcdOq/hoW4PMa2GPuMlpOCcxPHHVF4kdc0/Khj86Zc0yAb9k4Qbzk7HWq9ynV1UTuTMUprTQuzLfazIeSGpY6FA8ddrZ+UuTuzvIOyfxvcXKyyYax8n8MhFvhY92Fr2aHS6HM8pf6FxdR/wM/r3vyP+yl7suKY/lroKI0U51lgDl2YEz8V5/csGlVz7xQ0vKTDJMm46/IXSMBjFEYd4aILgxeTNweZSZfEAeAHMePCs3RjJlI+k8+6DUEHpNjDmpz45kqtxqJUNTFt0zPeFru4OLJO6phN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(4326008)(66946007)(66556008)(66476007)(86362001)(478600001)(5660300002)(41300700001)(6486002)(52116002)(8676002)(8936002)(7416002)(44832011)(6512007)(316002)(6666004)(26005)(6506007)(186003)(2616005)(83380400001)(2906002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oko9lWj6Q/UbcvTxjpCOpKUN3dHjB+6SgofRqFkh/nMSsNaSOq7Lb4p3rdbo?=
 =?us-ascii?Q?bDhF2BVytrAGmrg6iyUA5FQ4pfMyK1FDsyrdC2X1oebjuLIFIi/jS1mlauOA?=
 =?us-ascii?Q?5YVzGjssjtqiYN1es/xsZl94xv3JTCDpTeXqhrjtvn7Z6YcP/I/QVtgxgwD3?=
 =?us-ascii?Q?dULndxpM3TZgNlGVyBibSxCbRHEyTbxubeire1XhTmJE+dcFa+t1vsdYmIfc?=
 =?us-ascii?Q?+Bjq87x0LHKsvAtFVs73lP3d1J9qTXJk+3eXIXRmaJhcxUtkra2HQ1Hp+Kpw?=
 =?us-ascii?Q?g5vnFwHIlLonhvSYa+xrpnMGUPug3RBYcSpO/zh4Hi5k/GoRdbkaVIVUiCYv?=
 =?us-ascii?Q?9G5OiPf9g17j3Qi1iLevJAVftpx0KWEPzC6NIGFzTGXDkJ5mS2D0hXFl4Igo?=
 =?us-ascii?Q?GsI7Jtd0dtlBPMho5tX9eWiizzLcYcHYeHmJxA6yxEflgKfNAZN7ecKFAWEK?=
 =?us-ascii?Q?cI4wpPJmw4hQCTaV/hjCNDiBLOrNIqANnHJSz+klZjI7qOK9ZK39IXNunxWf?=
 =?us-ascii?Q?sJqECRqEOGHyYut6ySz9QOq3SXOh6G1psGmqxTACLCg2wDFtp+9sL/0YPRBI?=
 =?us-ascii?Q?elGvA19XlS6fcRAm9GSqM98YY2nDwlAQCAnvsTGy5KqtSY2n8q8MGCniT6Mx?=
 =?us-ascii?Q?k6QiHL8I65eDQNy7yyJc7nW//6PbUInnyxG1T4FcjovKuS4lUmpqsdxyFNT7?=
 =?us-ascii?Q?Nk3HkEDnTRZ6yb7Y/Qphb+MdaZBxg0vnyZUVNEp7ShlobgfL96hEOtJqf0mo?=
 =?us-ascii?Q?MRjI2OLfOBrZ5zaGoul8AP+8qBuBXhps2IwPkUAkDkc2CTHADjDpnO3Czh56?=
 =?us-ascii?Q?SCu0G8qeHx+YnHnc9eLRdz5eWEIG2WMXnLd4RjXlzltIxP0BxcNszeFF426E?=
 =?us-ascii?Q?34/VGZ/8yA3fbMUjuwb+IZpMdQVPEf77Jse8pVr1msA/pVCFiqMGNEcbcfsI?=
 =?us-ascii?Q?bcuW2TgMmzzMrEG1LJBjQ/n7gHKFiOUCr/zXr8ZKkicndF6SvJ1n6Ti5cYAy?=
 =?us-ascii?Q?kBO+ztXvAexSE3efe1vUOly38lzD8C2FdnFUmK+eeqKZ7n32DZY6RpNNDqiw?=
 =?us-ascii?Q?a9kvSaN+K1ZrNRlf5V7HEMIa9RD+IzzzyKqasgiJAYr2H+1vyZX7ZHiJ+tpI?=
 =?us-ascii?Q?2mXtGYaPw4imL8Ft+pT/ABkvZQvJk4RqhFDv4RNmWC5kmqWODdrPKDN8QSIP?=
 =?us-ascii?Q?v56jPELEzlYm5oMSkwp+m3/a8OMtE90k7u3MLiMpwgcdUNRM1khm+fGTN2X6?=
 =?us-ascii?Q?lykP1lB2xhKzdVW3ZqGEzUjSkriphLptmVXUrlpkOOzIEeyvQUn46YoIOGuD?=
 =?us-ascii?Q?fZiQJU37DktGTdBPq+TxqD6xnSls0kj/IV90DotUq6KsjYYKKkPubyC93JtN?=
 =?us-ascii?Q?qr5KKw3+0z2msEBER1VXJNugSKsE3SVCFBTIm/CvWnrI3rOfzfXwVz9guWwa?=
 =?us-ascii?Q?hjRVS/Ib9DBMQhOLs4hO5EZavet1PAZ3ikAS/pwEg8THoFGHM3PZmfisFAqB?=
 =?us-ascii?Q?u3QXOUlYMGQzUrGxhk6Iezo8MxInPiXGSIrY+gFYX90bdDTerQrcN2+8Po+S?=
 =?us-ascii?Q?hhLjTcWpjm35SUMvDJuP5tkw+XwpSoNB8lb/mCe+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177cdc34-929a-4116-ffd9-08db60ddec61
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 07:17:27.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ptey3WVae1D5A7vvDYDvgU/3o+oYeinyTdgRKHVCYpBJEc2jQ7jngI4iuY/AYc9BgVvKDZYOttrLX+T+DFmnYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assign a single slot,
configure interrupt and power domain only for 1 slot,
not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index a90654155a88..176dcce24b64 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
 
 	jpegdec: jpegdec@58400000 {
 		reg = <0x58400000 0x00050000>;
-		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -29,18 +26,13 @@ jpegdec: jpegdec@58400000 {
 				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
-				<&pd IMX_SC_R_MJPEG_DEC_S0>,
-				<&pd IMX_SC_R_MJPEG_DEC_S1>,
-				<&pd IMX_SC_R_MJPEG_DEC_S2>,
-				<&pd IMX_SC_R_MJPEG_DEC_S3>;
+				<&pd IMX_SC_R_MJPEG_DEC_S0>;
+		slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
 		reg = <0x58450000 0x00050000>;
-		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -48,10 +40,8 @@ jpegenc: jpegenc@58450000 {
 				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
-				<&pd IMX_SC_R_MJPEG_ENC_S0>,
-				<&pd IMX_SC_R_MJPEG_ENC_S1>,
-				<&pd IMX_SC_R_MJPEG_ENC_S2>,
-				<&pd IMX_SC_R_MJPEG_ENC_S3>;
+				<&pd IMX_SC_R_MJPEG_ENC_S0>;
+		slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {
-- 
2.38.1

