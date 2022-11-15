Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67362941C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiKOJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiKOJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:35 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D2220E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/PEF8Rwj9MxyhIW9OALEPjAx/9fJO1ICK4aAcC4XsPf6s72DbegP/RJAPFY3lDd0PEVnGet45K6jFAnsf9hvH/o8MXAAvqG+VH7CASFYuxOkRxzq061a5s9Q6QaBsUh4a86aGuQhdox02X+BtpAYy1XhSNi7G5q8VvqeQcLo6uEfsLTubMvK40PqEyhJ3T1uhSlzWFFPYt3IfOxAdlFm2LZ4edVNB4hZn14BTbgOY5rMgjz5OCtKSYcvx5Hvjw/UIKyfViAuf7uAsyciR9n4tb0Xix2j/cpvwWsTAbPVVCoQWld4mYhfbt2rLe7PF8/oNW7NRP0U0jLbKie04qMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=E+HWnhrWOSQJpUs1GGVJeQQZ0wr8/iyA1Xv36ydyPlr4ApaGlNOXc828cclRgI4qY4Hy84Af6dV5PD+nbAPHIm/0zlRTuuexQ1gBP4BxQbK6UueEer8wH82woYn/JDwMK+5eYdBEefyr8RD60OpUGORjKqYC6zn5LHWvOztECQjoXdDboW2/BrSwn1i5O+bdO/usfzztgYtqQZ6DInydkl4dUVQWiQa75Kos+TX042Yed0nU5HcS6aD6CNB8EFIQBm8FUm2N+DD4tDD9jCpKvELNnG4UVzCW8MqdDgvM+K5N9SiCNtdw6d6P9pxcYYq9CgZQG9XYt6amieGPX2vAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=EXxrisbSaQFM1ko7rW1uYxkz8bWXBtWVmWM2ttu23zNIxG4Vo3yTOepR78lthUHlI7IDS8V4JxzYDTYNcBPhVNiyM8k5LFq1oqVSoMebF6Zrg7XJCznxCYVCZ3m/cUV9/rUJNWb5TS5kspXHD5N2h1ZXcYqDgTC7Fba+GG30H/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:16:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 08/12] arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
Date:   Tue, 15 Nov 2022 17:17:05 +0800
Message-Id: <20221115091709.2865997-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: a503dc12-0bfb-4593-2060-08dac6ea08b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPy6g3JhE/zxQtpzy/iiqN+psS0BMKVyWoQDOh9MQt0z6CEMKRbZZEFxdwseYZT9+Z9xTGuiaCFzdFfvb6/Q8n++Nz9FX6KmRPVWLte+Ow2sNkKJGu988H2q4Xl4wAKubvwg4Lg/Y/4jDhx1GL+FZ/D21EeWog+g7qs9ASZFK6cB6fNP/uXK/DaTHRZINR8vugRMg1c3ZbSHdhV/FoBgGFEWkCdzJVEM5M955xO3ZQcjzbb+mksLkcO81nZcsRU2y3Pgds92xlWlNDi4lGfUdVi/GL/5K7AegmnPRmSPd7vQAhvAkf2GaNGVc3Rb3U9hs+3hPgVwktsP28q8m33OrHSYU2BwcH7c1w29Rbyxe/MdoXe1fKJfBzNPh4KKoJAl9rO/h3AbF1Ay85MyspjEwVUVoW8BpuV8nQO6QijTKDKTKo7r0dWXJq56KuPLNFH05kdN7tfX8Wg6hQiRFfY3pfghIWvgGdJHdAfMu99wM9rEy+s4hY7tYwNNIzf4OkGyUpr3az+2V47U4TP1rlFt4mnKhxHr+SRrb+9nw7ewCzNMRJvG/6pDMFhNK+X11ny0NvNTHcUbKcOBLuTIMcQbdU3ugrfaIDjqFOr/hJfGodN4SSnDJvEBnwNkOZNBLbo/rAvu+5OhL00ZtUKhkmFIOC8CX3SL5W+BX5ep/xNrTw6hhd73Ty0KYpkl8ZxR7N2BfDmUORT2se4QT9yg1GSslYHxOZ8sKQArGT7FKHG4l2lG9FBpmuT8pCnfSuhvd2JT0Vjver4v1seqpy69U+MUAzVPtlAZxHtknFROtgHdCsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(6666004)(478600001)(6486002)(66476007)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIn5j9F24BiBp5xThsq0UpBm15hBLgbMgARLGNR+da5Q0QMVgmcFo5byaUB7?=
 =?us-ascii?Q?rgEW/xP5xX9TcnXsPH+5d6CWYEIuKeAliJnxFzU9Rmod21i5R9Xtd19Cy+bo?=
 =?us-ascii?Q?ApZ4SiOzr8hWewLJKahcgZnQdsiOsYMAiNnKR0xGFh3Q9L2kcboS8mwekGJc?=
 =?us-ascii?Q?C2gKwKC6QFdN1EzatYPvXq5UVi0h57IIQi1z4rpyZVLqzwHHUjhZbDzsB+1t?=
 =?us-ascii?Q?3DjPaHXo2aqUOOuHai76P3ebf1Ssc4+4dKMYfwBO45o66rvymC+JbGZfIMv7?=
 =?us-ascii?Q?nd4SHSMmAfb/9yuJ2IKarqvSZFBwZP9vH/sdXGHkjHQbh0wX0fRd4BkVtsG3?=
 =?us-ascii?Q?ismv/wszo3XUqIpgRHYH9zF9i1xze42yQ1ijMU47FYiZ6EhmxEKuTQELk+Uw?=
 =?us-ascii?Q?ogjbR+tiy8jl2tJpbve8OMozn5qPfX9GYQIbvu0vjpLhr5k+P1fqYYM59Ivx?=
 =?us-ascii?Q?pCdDXHn6gRiRKwys0OZNdzLPj19DXGR7PGrs29XGIAfHopS1na4SFPBJfAcA?=
 =?us-ascii?Q?5pgGjbLAJ6e35GvPhJlF96KaB+hG/zqXD6ASV8AFjgFQ0b++GzaBwIuIGp5Q?=
 =?us-ascii?Q?HaU4ZmpdPnY6zZ8Xm0Z1HkE6sVnYKk03VwPF1we7miQRnMjRVHi2csXu1pe9?=
 =?us-ascii?Q?FUzyKhwH3sjby3LM12mNyjPFjHaz4FDt5fZIqXKMKpJIHqgTMhruHFmvY2DS?=
 =?us-ascii?Q?Vbhy01XjNcEvU8K1qPU/slt+ukzpuFr/j/Np+o9WdoY9JVe4j+DcLDHR4DxS?=
 =?us-ascii?Q?PA3xlWpc9Q7141efZ7BKjyFAkj5d7eHNIsUYcGoHGUa0cBKfsW/gx1+hIeNM?=
 =?us-ascii?Q?K/0SD4yYaDAfRYohMRVWUNz6ZBozThozV+X+xbrFMbJWms8wENDbqTUzEWwT?=
 =?us-ascii?Q?URxls194cGJ8TcSu17OsKBNpoBF/4zt2O672pLqQS28p09fwJIFginOw8JfR?=
 =?us-ascii?Q?iNykeSIf/Cc1xR8ciCCGqaAAE9tgVquUwHn7/2/ggpZNRaY0lstKWRNpiBfk?=
 =?us-ascii?Q?U5iPC237F2lzuK9m90SRlVYCsqgwjP1dU5Tym+Mgmppn8ImtWrWKReAfKWFj?=
 =?us-ascii?Q?P4vLsFi0+WDMm6L0rSvT9xoU2USnoSjpfxBHHLFyryd8aUqdLB8yOiL/zedX?=
 =?us-ascii?Q?s3zyTSKJTnt7iURo6dvH/08tk50Rp5FCbq3nT266f82kZJR5xwORpgiVt4Lh?=
 =?us-ascii?Q?2YBFvsB+l6gq7ZND8e527A/mStRVgOiNVAjwqoFNOFZnDCdfig4abwkhDKLF?=
 =?us-ascii?Q?RG4bgKrOElSxemwfut09N3tIfCBznNj3hmEAy506q56LnvZUXo8aP5R3VjOR?=
 =?us-ascii?Q?nWF25sXYmyIlhPlFD9741TYbJrYGvS1HhgYoEb+UPlTmvMY+Nr/doQE9Iilc?=
 =?us-ascii?Q?zl4wqzXyUZj9AdOM6m8pYFpsIbP1t0rJRlclOKkX/Ri+w5lRJkd8mOGBfSci?=
 =?us-ascii?Q?tXdwCMpMA0WvXwu6R9ZB3jVXf/xgbdy2kgH97cB6nl47gwA+S0hvSIhvOhL5?=
 =?us-ascii?Q?VPpNgxUhh0GP4JwV3GFSV4gsKFNss5gzLBwJpVikkvBOgLvGu60mp81l9awa?=
 =?us-ascii?Q?5H+SS3LTxgWxdE3fqEGKkWGMD3XBYjXMQZ9GZhMR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a503dc12-0bfb-4593-2060-08dac6ea08b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:10.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v/dlRnbdQ7Iqi9KjHWl1yJny6m5//WSHjj3jQPEyZCj4F5+dRzhhqT3AfA7wlhP++oesTaD19AgqvzVIzYDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 261c36540079..2b4395854283 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -36,6 +36,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

