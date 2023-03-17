Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1E6BE94D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCQMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCQMdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:33:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A177E01;
        Fri, 17 Mar 2023 05:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBzsel6kN1KDT0kLkAGBefnWeu78ibGekzipyHH4BWAOp1DICKSAEFRIIL2OEqmA7IjlvtTh5iWj4V5pr/mqFByiq8l3j2ALgLAIzSzP5A2tXRseVoqsSIVJ91vubgKvLNlFjDuYF93HW4Cwr04cUCAmiN7AACb0YnZJX1qaPWjNai6I7nYtiaWrzutbuZUbZsgpqsEV9vt8djwI3bUXqqC0ftoaCMUmUVPa+T0XqvnzL444pBgi8DXTVZhBrKw0EJBzxm13QwsZKhy8lCiGYy4w6t+NaJ99O3O4aRapSBrg6uJOlKJtRtm2LcIFGK4KaRVMRVSC7ZErZmdgxTuWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+kWn2/zyuSkvYDxSmH0uAGWBtqyfe3BswA1Q9kAVfI=;
 b=A9atj4K9ve8cSnK3qGPfXZj3d/XUZHzaAshBQp5V2r2vs832PSIF74+n/eOjCWs6zHvpd3odJetjPDRAM7gBeB8H1KzXCaCXinBoEKUpflMhD5plqMtIxmTosPp34VuvOtUQsjaeMU/RxwAk1ZOEYXgIu1GOjUV8ApgV55WuukQK+MD5+2sEBW0u5KY/605Omw7/gCJwF6dYzmR+IwB4YzBRsFL4yO2FW3c2Visz4A+FY5251Wb+24EC3XtDh9EmGquIHlvuIHCa7NNm/eX1U45stFf/3BB6z9FfVqAljeiSuKupkJmsa2XHFrpTDahm5Pjw0rtFr/Q4cYhHOCSS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kWn2/zyuSkvYDxSmH0uAGWBtqyfe3BswA1Q9kAVfI=;
 b=mXFhZ3IIuW9n69Et/9ot1PYc4YUWkju+V7G1rnIhhyGiAqtH1bzzxdgQRnNTalNM88DtCkLMwWRMjZ6p3Gg+DHVLKicaakD/vkNTAkK0bSOYf/i7e4p9eMcFqJi5+lmm/9rMBZTnSV1jlkDUPrnpRiRH1bssE5zBdWLoc1zLARw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 12:32:29 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/6] arm64: dts: imx8: update usb compatible
Date:   Fri, 17 Mar 2023 20:37:07 +0800
Message-Id: <20230317123708.337286-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230317123708.337286-1-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: a67a51e1-c813-43c2-0cd5-08db26e3aa69
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeiMz5Q1QTPm7vljZpIfej17YpEcyDA7Z1T/iEs/3O4cDdOWHgKmq5y0QEX2E6ExNlLNDw3hRhPyCCk5BXEQRTr7/ZL+bSzWTl+ohq23XvptQFDLVvTxglfKtEpip0V+c8dW7ugC1E0JF7MfxctechI7j6OCYdhfOykvLAVqVZy48MrRTigpHFt34tTUEie0v12Z0jQndMEbM9zdpQx2iCfa5xGTVccdidrNYYPSiBbv1gSp9y1LDQc836gCCdcZ1OXlqZ4PtIMfyy0ktacfLeFUGBoxpxdY+Cjm3Ql5QDInKsC+ntLoNNaIYDTqr07V+XpjlF063dJsi20Mm4sdjMmOEjj6DKQqk3wnKqdnxFcDsIsR8C+l3vufjpu6PrVhs3N/WLGcI8TiknaOD06KROSwvFp5L2JzwkboBvDI1doUe1xVDf6190wmyTAikJ6YeyV2/lhUVJFEiIbNPllgt0S8l2ui9VN4OUOvouMpd3Q8gplzH/YWDnro0md0R+ZoHwd/ZMvxwFW3nPx0CCDnG/Wr0DvRDNBkiP6OOgahqUnqJt4bwoxYX3YM0dJuNnJphOO2eIvFbkPbiZrzFnlxIa2iglrelv3SEsbOlo3CWdmH1p41Y9MBWYUEX23PBRPUqBHnwiEeAxpm2CL8Ct2AqfeJQR8+Wuext7zeG3KIbVlX1LH+A1MwoN4nZcLeFzkkwslVYZqQTSzfIX8j7ivORg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(38350700002)(316002)(15650500001)(38100700002)(2906002)(478600001)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(8676002)(4744005)(83380400001)(7416002)(86362001)(186003)(52116002)(26005)(6512007)(6506007)(2616005)(1076003)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lEWIXr0GDowpDN3m5etzeEiFY3QGXKrFtX+Pe69cKcH4cGr1k4f0Hw3yOose?=
 =?us-ascii?Q?H66aztKjls+/HHLvHS28Sy6YPchqTaGoQukZGysHHNg3o0zSsPPWSXFRi8Hn?=
 =?us-ascii?Q?Yzu+hGSlGbq4qdi2INA8Upnkck0e9ptzs8iYN272MXGWCDpdC7WmIDM9shfc?=
 =?us-ascii?Q?VGdZnYzRAbdstitAGJJRaYSMwnefH1taxUqwNNZP94GfG5wQHS0fFiYPUFKf?=
 =?us-ascii?Q?s3ceQ3H9YPspwJp1VjI3xs6gEIW1X+bggJddsqk0H6KmGJJm9qv8ELEijiFv?=
 =?us-ascii?Q?VgVB9nnd0S0b1ZZ97kDKM8YcTMJV/PZRbtR3c1shqchBVVngm/+zfyhQ5pd6?=
 =?us-ascii?Q?ZdKNhp0rpUQVcVhl0ga4prn3wYVBN8mqUxL62+Yfe+jNG4arM2yBB4lyutlz?=
 =?us-ascii?Q?J/vMREtcwNGN24ARz5k1t7Sh/79RyTotRNNYaqAzDf04bN3tT4Z8o7i8OTuf?=
 =?us-ascii?Q?FeAE4UXIDKJPP/j9vIXXrUJqNk4ft7K35fARdAuUTcXbNzzVgywE5Zc3IfpN?=
 =?us-ascii?Q?ueM97p2a8rEWIKQUXorX19tE38SiTd1d1M0Ly4DcTkm1HTTAXC3S2sVzavKd?=
 =?us-ascii?Q?G/N36DU+MrlkRbJOMbJVestEQlMhCJGUQEJvPGPYDH/eG+K1Yac7NwoBqJjl?=
 =?us-ascii?Q?9UfPUprs5kftXQjBks2+cG+4l+Wa+cuuStBjMVjv8jVFmGUh4lR4WmtUviNZ?=
 =?us-ascii?Q?LUwzVlari7bAaMLQoYZrI4PpxWnH5Sd6S6yw24NQ4i7VpRTLpa9AViBP0Db6?=
 =?us-ascii?Q?BhM+0vLr5UbtjyfIgLPPpdiKECHJnmN9N0sRSaGcwGykgtSql3lFAgPwwHvh?=
 =?us-ascii?Q?Csg+4MfpwE0ArwYZYVEqiVxJ4IJlLMMi+hzorAMzpGf4bK2sOq2pma1zlayA?=
 =?us-ascii?Q?8ZePlqh0gBXNnDF+KtgCnmTCNfO2MaaHKOj3R8WO+6yatjhxylMvqoJVdKcF?=
 =?us-ascii?Q?Z/Di34SMiK5N2KavaZCGYC8rLtFOrC3FdO7xm3wHGD+sKnF9YvHLifZG5eML?=
 =?us-ascii?Q?ORaCFdmvOWycirmcKdettr91GoMQHXpkbdg5ReUZdHKzWKwg3nREf5ZLLfVs?=
 =?us-ascii?Q?hQ7THOhe8x+IWxtm6YQRznCUsxKOHV6CKiq+IBlZ1Wr249DH/H6vHeC1qjZX?=
 =?us-ascii?Q?W1yuUzA62K7ZmHi7AHN+KIV04nt7lu1OGd/7B6E8BDQpOUshjDOuLc8ewzmJ?=
 =?us-ascii?Q?D5gZuKrjIkph1/auAyNLvTMtZosJ8oj+2V9sKSRxPFDZMZANtzHDbRzwxvmE?=
 =?us-ascii?Q?5wvtLaoxS22oCwyXhlkDNA+FU7xMNQFOYsmXq+y1EkiUFNjdJez6sKWSNM58?=
 =?us-ascii?Q?uD+hH8yWrfdtUEpDvXfWmpPDbzvbuPyJAJgo2B8y74jFrjRgQytebilknjin?=
 =?us-ascii?Q?6ih2FKm/S29DEAq1ZX8KIdU/1Y50LmHRMKV80wbrUwF2gzOFCaCcYgzBEARw?=
 =?us-ascii?Q?hP0rYrNWGbX24UjboMQLKN+iAY9mdFbqgnXW47oX/6Sysrlu6pep9g8YuYkY?=
 =?us-ascii?Q?eLUrqpIJW0jLt3+5vI2Bwz77OskmFTv1FUykO2PlduyW1byWY6bWIY+MZM3u?=
 =?us-ascii?Q?VXZXlO5+dEan843H0vo3kPTaDPR+iMFsZ5LPw1HL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67a51e1-c813-43c2-0cd5-08db26e3aa69
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:29.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAkJeHgMwwtehpHYxha9E3K/8C4/8+MpxtqVfW+hNB3NK6jlv485wLdwiDNK/0GQQC4h+4irSjDAnwMXWwr3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..6f0d3cda7808 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -51,7 +51,7 @@ usbotg1: usb@5b0d0000 {
 
 	usbmisc1: usbmisc@5b0d0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0d0200 0x200>;
 	};
 
-- 
2.37.1

