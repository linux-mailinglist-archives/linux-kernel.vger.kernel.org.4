Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F209C6C448C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCVICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCVIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:02:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752A5D24E;
        Wed, 22 Mar 2023 01:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O17E+GM1MU5Cn7kcNpmaUzgmcgJLYjAnt1IGkV17vIwzeq/xcsyHcAaTzDJIi0LuJUayyRsd0UWG2CkpwjbxBPDmVqkZ32RARlOBJQGh/MabPCiTqr6tyxZ8texuIlR1/Ida/aLhjRlCgZHhEG8mSsMA9nYbBW028Q6ieOfU8rNPWtb3P94WIRDtWOEkFJ1f6X/1SeUKXKQQOA+36iKPkpOIKlDrfQ+oVUter4CeCmwdZmg4ry0j8yVvGLk6LGPR4DWx3hqtvmhj26WY4vf/8WsCjOlz5v40ASW9FqBaRhfw8WfPtft+yi5xKRdQ5QnbQaxviDwqm0ASd7i4RBMNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q905g3HN7RK+TEt3xechElkjrnsTKkLrT4IDFwmSoiI=;
 b=IFa2ftvdlDMyCjwTjwCt5/DpRmYsMMSx1ZovhHs5+GflFcp89vAfWsUvrop8gGkumsjZJi2LGnmVB8hxXPbyuFL0UdWKzf+wQYfYScERWM3moS9+fh/9Rtldx3sxGAAOXkYwzUozFCU0cDF6q//xaVf1C9xl38K6YwW6rVe/zXGNGaU3EzshfwGUoAPh7vJPqyEW3DnY7Tt+oVCVCWBaMzcWX7I0w5Xfpw77et172IdOoI3vGxfQBL6GLaLyWjChZxKEgM/AhEtAoiRh4qli2wy3nbN+ha9FRPYwRdr7aE0psgzsXurqPQWDm7ckPCNhCsCsglBcRGNWy/6q9W2k8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q905g3HN7RK+TEt3xechElkjrnsTKkLrT4IDFwmSoiI=;
 b=XPM5x0CAEQRfLThTQ3F6cteYmxf/axg1r5A1vwNYH6PrwtYlKr3iVq18x+61uRyF6IaFe5ksWXHKkAmVRwZHczNOWW7j0jOZb56ZC7RulxIC5WT2Sp99PyaeAPNU7KCImpFN35vCPZrumrplfaugeZjF7mf8EpYGT1D3DNWGtgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6921.eurprd04.prod.outlook.com (2603:10a6:10:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 08:02:23 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 08:02:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcel.ziswiler@toradex.com,
        alexander.stein@ew.tq-group.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8mp: verdin-yavia: drop disable-over-current
Date:   Wed, 22 Mar 2023 16:07:22 +0800
Message-Id: <20230322080722.3054508-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322080722.3054508-1-peng.fan@oss.nxp.com>
References: <20230322080722.3054508-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 66438149-f451-42f7-f869-08db2aabc44c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/yPUx56y0e3MtGlAqvAqc5K6Z3+2RAhfRUEFEgkO9swye31DEWkEJx+SyEoekWARXdB2IBGds1iCqAKof8D6R7+g+VvCbnuTeLLEGEFKBXPVwZzM+w34VnigL/QJPD9Pf777EPeHTn+5+wp2tAhp036W1YLR68Eg1EeGk7az0I9CMfgC8ZF79CCMpdAjS7C1AmHczlsJ3szHXOEns7yaiyAMUJn4jfSyhmb3px3fEf1Id5jJochv5/aC+A/6kV8Zzf5VOpjbnNyFXeYOiatH9x45hRJLA5QgPKG2phSmyPQ8JG9l3ffjfzBw8zDzPvJgQ4Vn6ADfTHSiHA46cm9Vr0uRxVmlhj6ifXfP4Ym42FkDDKMMaBwfT1gFVvm0WSajKSLmHYb6EUqqvC8lxX8CbnYwiQQs0e/HtadtLBuo5/Thh3E5CZNmqLw3yivG9A/SwBah0yEPsUiEk83MnUra0YxOgOyp8XdpWRasqdkQP2AbFKfC85OCEi8l1TW07PoSF+ptIpXpSIY9aGun2XZcbWUHGfsgsokweOpGI56MDb8etPy0jOFsD0ePLnFctavaM7t2Xt1HUYlxznyAs15fcy8FNlNfSHyAe2e0ZmImMkKLmH++C+QbxspcdCQ2FAhVRer2S0/GcKwW9d2M0/ktdDPnSo3vm0VTIRsuD9Y+1xSepnoGQ17nEsRczIji69BQY2hzHP2zetBO6QqJmdIYi0Sv6MnH2Yb76ndm5rk24E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(6512007)(2616005)(6506007)(6486002)(316002)(478600001)(26005)(1076003)(52116002)(5660300002)(7416002)(186003)(83380400001)(38350700002)(38100700002)(86362001)(66946007)(4744005)(41300700001)(2906002)(66476007)(8676002)(4326008)(66556008)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eewu2o4eY/QBFd+b+WW4E42wR/kS7aDufw03j6NYeE701huyY0hTGW3Nn5nA?=
 =?us-ascii?Q?AEXKgPky6sAeD7hMvnLzvhCUlFluGzOETGtE1HPOxJrvZkR+RGYi/Mz3Sjdm?=
 =?us-ascii?Q?2p+Cr967cRkjp86thzl9jppx7I7gzj7IydHEgqYQOyEWo9a1GiwBxtkyWDe+?=
 =?us-ascii?Q?Aybj9QHkiVWt32le2PIYwFW3GT3doL74J2jybEEyCWTZP87VtkBSL2foWNrL?=
 =?us-ascii?Q?NCvx+q2QJg7gNNUCwvTZX/uMyV0AwwOfDGZnS3gn/zSTMjHQzeL5h71tum+t?=
 =?us-ascii?Q?XDhSViPezleJXaWltksOIYWEqOWpiANMd4TJ9fyz9giVZN2l5fS+kCQE3rGK?=
 =?us-ascii?Q?Mlpi0xqROb8ueRQ55cxhREDS3OIPvBho/vjGQ6JPVEY7TmvKS5XPS3HmJgN4?=
 =?us-ascii?Q?hWL74DzRPrzoSDocv/73iGzNIL3wR++AUXUVIR3cVMG+UZmYW9ekPaZubbhb?=
 =?us-ascii?Q?rqVU6gfCI43k7Dq1PtchUU7CUpxuKhhOD9H9ehpjKMMMoftQZMZ0arYJn4aT?=
 =?us-ascii?Q?sAWZdg4uvvG9g7NT47FyEs/IkQBBx05vmTaorGOQUIzq5rBYVIBOYUBaTc1c?=
 =?us-ascii?Q?GAaoDQYgGTXUn01WlyQzuKjLV/TA5TlGt4BFz/QB6+AQp1b5W23kr5oeLDtK?=
 =?us-ascii?Q?iztWI4oda2Ap/OgYcT8VuRleHhKmQnsValQttnR8LPZrg1+wY61fZN8olBli?=
 =?us-ascii?Q?Ur7dMNz76JfwiJDuG9Sd3Eabj0vlEq358scUiCieQ35FShHfOX8vMQiy99j8?=
 =?us-ascii?Q?ltM+3oSFWpRWYFrdPgQY8sG08bzZvXqKZCRb4qJ805yLmqyfjfTrNMycy+O7?=
 =?us-ascii?Q?TFmA6BaXmttP+JILJyD+E34pw3kk6KOHoc4th+zkag5Uh7yav6huN9x7J/k9?=
 =?us-ascii?Q?uTgHpd/MroZYCI5eFG1ZyEYphFORRy/tdjdr4LCDhEcHaeSyLs1o4665FgVK?=
 =?us-ascii?Q?UfwAwyTDA1EGdW2F6vXSAeUztitCHXmIKB/oI+XKladoZnJWZ1l12jfE62XY?=
 =?us-ascii?Q?NtiI2reDYP/jg8+rQVK6GcCUscRCIslrjgUEPSLGRLlpgQbPVWNNXn0a5qMv?=
 =?us-ascii?Q?AH2OKInwSzW12rfJFoOOgspr96I0CTeF4xfLCGypSTGKItEmqGv4AbIL+kGr?=
 =?us-ascii?Q?N+JeU9r3MWZr/+gUO4p9G/3srrnbusjO2tb4PRHffVoTivUNLsFbTVK9tG+p?=
 =?us-ascii?Q?fHzdD+mJfK297xgBLXT4iFJhjBcKyUB9defvKXAf8Kek5UiLkH6zMkZynLj+?=
 =?us-ascii?Q?YNI0xKPVQc2gbar+EDmw8WKtXVb82rOHdE63nb3hXThaBSW9nNszJBRVcHWi?=
 =?us-ascii?Q?1kzwQ/bPTavGAAsE6dF1mK72M3/Rxz82palCKWSVackC70kxp50EkUZEPah6?=
 =?us-ascii?Q?xF9p4r85Uo+tfTznvJUCzqmb1vpEvDsMIr9/7wbae8esjrkImJ74wpy5PmgG?=
 =?us-ascii?Q?3tkmlCtP2iPzc1oNzaDFU9Ss8aZP+OWt8HMnKty+u0QrrsxtQDmQmZTP/E4p?=
 =?us-ascii?Q?nGIDHvOuoFqGvpSuBWpdpRU+7teQMGpneyxHf/QKSl4qiVpSMv6I1OZ6DavP?=
 =?us-ascii?Q?jEKqvAYk00PF/7I7a/21Mv8JLczYqv/jEw15prA+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66438149-f451-42f7-f869-08db2aabc44c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 08:02:22.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1SxLs0MIz9tm3f2ETzVQ6YR/bvF8mnMVGwA2BVdH5q9X3UuY/BkCM5C66Iu5oJFjxkw4wPsF9DIiwNUwyyaMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

disable-over-current is for chipidea IP, i.MX8MQ use dwc3, this property
is not valid. Drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index de5489c2b3e8..db1722f0d80e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -183,7 +183,6 @@ &usb3_1 {
 };
 
 &usb_dwc3_1 {
-	disable-over-current;
 	status = "okay";
 };
 
-- 
2.37.1

