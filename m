Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA76CA0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjC0J6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjC0J6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:58:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE58524E;
        Mon, 27 Mar 2023 02:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKz4EoLBnCVR6XaC1ROg5+42EMUavh50i4/fX+KG3ipnD1F3srs8VvPDgiQp3yBr59nBhBPCBd9r9c+ez4EwG68AsQqLRzc05Ox/y5KWsH59K7FTDP4G9oIuHdJJtwoFv8FjZ2QwgP0RaFA1UisSGVNcykFBj4bYDAyTsU5pu+suIg6BKIJXmbsCtAwz1ckduU/D7+FRjw6eZThKKmxl83h0N8auyEIdl+8wALCMsJjIo6w9kTaeJ74Wgc6gNp/pTEet+n8xQ1icV45ASooiAc/fgvb5r3vrWKgqzSmAlmPhGRRTnK1TM89NExwNHd5OcJhzhX6lrGgLN2/I5AJ8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXkx66bUn/zLwdDfOtvj/jvZao7yWAZCE8H0SbFKf/0=;
 b=DrbwNtpHdxtD8FGikIgzBp4Hkg63b8/DMRikmNUcq0u/GC4htU4fESr1YUYUdHI8GfkqGjLUFmRmGxf/zCPxc5d+Ck3zpNu9KwP9s4ul37l9V/pcVFKjeFqN1vBZrgZYIXSyWJNqPsl9ndH4U/qOxKOAwWidEtzuyHWpHF+0UTKZF8AOPN+mzAMKf1VU0BC/Lb1RDjJFN0JUgK1Guvbgc4o7XRqrSNXxUFxaDlsZD8jGIjiExxVInXVRPKCogaYF53IeOdkvSZTRp5sVTDViyVYDFJSlE88TULljNmG9a9lybC25LKJk/lypBnuJklu8YA/2O2Z5C+GqTwAVodlryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXkx66bUn/zLwdDfOtvj/jvZao7yWAZCE8H0SbFKf/0=;
 b=QjmMdaU4qPrNIPUg1E4pN/1AUxsWKPEqigGD7od5V8/mS07VSsTsMZObH0i7TDiRpkstO2resxpPi4mEJFIholiQsHz5DwSPvt7RgtHrCmEFb3ALkzoGgNGwifXE8Cs9st8i6kCopvaF2koqaFu2sw10A9k2ONHUa4tkdNhmay4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 09:58:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 09:58:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mm-evk: correct pmic clock source
Date:   Mon, 27 Mar 2023 18:03:21 +0800
Message-Id: <20230327100321.1682333-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 1707504e-285e-4aaf-1ccf-08db2ea9c940
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dgt/oC8qpoeICwGr6d6Nhiey6SzQ9HvYGCMdWqZ2CUSPR7g5uy/RpCZzpxvN4BFePhere4WaeMk/2rO1my43UBSSu1fEAO5I09VnWC8oqUjdq/h47Nxgo3Fv9EAaLjO6b4TjWF54E8Nrz2g+krSpw7onmr6JlzBr8GL4aDOe++x9d4OWmD/yGivlIJ9DJ22Y7YkPwzwCtSrIbyESSM5DdoJEjLv+CUDy/+BNo35j9HBoqH+rA6oP4sgzBXGIppBI3AOvzkEuqe8gRWrItkqkvumJmtvytnYGtpdPd+FpIxoDtYYFsHTGbq6CscuxVHnX/5SQ7Jw+GREaw/XfNUo9nuhjwbP/nn0cLHuGa0CHvIHQgJnNpnyEHCi/noYcz//3YFrVnnxjBQ/YsDvMr9OTONzvS4ZJ1gC6/InaIW6CWOMuyOD5nQQAIzI/aW10ljHsZQeAMFDB6cvSnuNqOYflf56J6P2TQZTAhzbMAEIFdBa5XI/km+p5NQQtyClIQI+ldBU9VTnp63eqmyhOGBL8yCRpEEQlrBo9mrX8hiw9nAq+4VfD1YiRzpOt7aLD3qfh5DMYrj9bI4pajxjk/+ZjuLVK80Lvx+MUJMXNddQV++fsI6gkhsaBZ/l8tTt4sn6rqc2fZSwBGDXUA9/zOt+Skg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(2906002)(38350700002)(38100700002)(83380400001)(41300700001)(5660300002)(4744005)(8936002)(86362001)(2616005)(6666004)(6506007)(1076003)(6512007)(26005)(316002)(6486002)(52116002)(478600001)(186003)(4326008)(66556008)(66476007)(8676002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBXRHN8DavU6jYSVcswDjWWfuwHQ5c2/2Wkh95aP/CEdCBM6KjS8jSR7kEJR?=
 =?us-ascii?Q?b9GW8zv+tA+tHjikYyyWuKJotPm8ZnM2slFX0lNqfomqK8xhKTir6nwBrKaX?=
 =?us-ascii?Q?doItTc6mOuuckpaYW9ED8Zvx6gKsMZh9bVtgQXIP7qN/H6Vg6DDM4atZBeRq?=
 =?us-ascii?Q?Deq4RYCHfQ4co2T/gz0HtovYNDLsz9jMIe9304RpFtWdO1I3xiSJakb4lzCT?=
 =?us-ascii?Q?yvlTA2ppfP8azsgiaN+el2oeCpCcdYpAHCr5gK2yTokvm+Ank+9jYZcD/W5g?=
 =?us-ascii?Q?T2l/gfP2/3gUDVcPOFvAaX0KMUPoDGD80zUMm/xqlX3RE2rVbDh3PfTuojmI?=
 =?us-ascii?Q?RE/rIZP/iADrBVlzUp/DipXnRtaoj4AmnjJ89vxjWeIv7Y4opWdrX54CU4ib?=
 =?us-ascii?Q?Mp2keE9XvXRZVOHoN6HRgVg1rlv2dPl1pNutG/9cOV1e/GbnAW0ghPysvIgb?=
 =?us-ascii?Q?7kEp6yAomYhljCIrMujV677jQ1Hn/4se+7ZHViuUqFQNY4PZ9DHdE8WmNv1y?=
 =?us-ascii?Q?rMgfZRruI69tTMwUCKYHlf6atjavrdrJ9q5m25cernR6StBM274iWn/uSmGK?=
 =?us-ascii?Q?WsfYufPQTknIHLDnZ+Aq2QYiDFNHM6qSTPiUqDi0fYl7JPU21bCg4x4jPsx9?=
 =?us-ascii?Q?+D3cGpvVB3WwY9j/xPMKRB/AaESpGBl14/nJrE6E9LeaOuvdeojyFI76jCrr?=
 =?us-ascii?Q?raNTx+8B9UZN07s+vzC1jiPvdwkaT8cole9aPeI0VzOR5sSFgWdbxv+r9F/Z?=
 =?us-ascii?Q?WqglmKIwjDNFPbHabT/AsVRlM7MYDABbrwHvS61LQFFe9H+JQJDVpgp8NDq9?=
 =?us-ascii?Q?/gfvCz45DA7NgnXhnpNcw8/r5tMcwEsv0hqUKquklDPcNy+KVykNWjGbQh22?=
 =?us-ascii?Q?j6WrrMuhKkNoPvAAuhuIixLv2ewLMfZ6qKH3M/PMjhyLZP9WSRSI/2QlzV/N?=
 =?us-ascii?Q?KDSrixBUv9vDzeDLmpDovqkffX40IAzhjUsVUQ5jIM9LmMO5l2sy47yT7lhw?=
 =?us-ascii?Q?o9FJ5/RUBbVIk+FaB3fS9y9/slsWhdvsj1/o4tI1KHQakLdhmPC8tAVBiS2V?=
 =?us-ascii?Q?Fan5bAS8ebkSBZuO3xK35mH9TfKjlrP/ydkCcaNgolumXPgOT9oMkCG/Dc3T?=
 =?us-ascii?Q?DoiyjGCto9YCc/t6pvbS5oSvmMdzoyy+ZSYmGtaaTvvOcIin1Jd4yEjgqsUx?=
 =?us-ascii?Q?jquUbhoJhzXYY/eXFQYgXUqRKIrZWoZWploHPP8dbTLCFxmSMVM4DP9n4SY+?=
 =?us-ascii?Q?qIeWyHV1jIIB8P4Y0G3oNNh9Rp/1p+deSxAcSHLHJZjbAZiBzGSXtYdgQ+Ta?=
 =?us-ascii?Q?YVAiEwNT+sv9mMkq5L9xUgSIV+A5egXKF3REJZyHeRCgE0OnVQq0GPiNCXgA?=
 =?us-ascii?Q?MPZ3n+jniwp6b4WRb60dDABoEArI9Db1AwSk9Gwv+jRl6FW8FccXukJJUnAW?=
 =?us-ascii?Q?HdAXH0MklVeHRSg+8VvT5w/RsPWF4bh1EeYD6gIzfOeH5Ed0R4UujRQiP7C4?=
 =?us-ascii?Q?yUmPNgyNNcHI3fEFSzEVB65/EeA9wtI6zxFoVfiTk1MDN8VTL4LjjXFS0cQD?=
 =?us-ascii?Q?g6YIpxoT5vEnFBQpYewH6rwc4rie5byebln46xUF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1707504e-285e-4aaf-1ccf-08db2ea9c940
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:58:16.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6Y1P9POoFmhBS6dpekxGA+d/iMFVfMti55M3G5qW2p4t/AoqP3loM0DS760ejha02drcaWl4C522+cpDsLfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The osc_32k supports #clock-cells as 0, using an id is wrong, drop it.

Fixes: a6a355ede574 ("arm64: dts: imx8mm-evk: Add 32.768 kHz clock to PMIC")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index d1a6390976a9..3f9dfd4d3884 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -194,7 +194,7 @@ pmic@4b {
 		rohm,reset-snvs-powered;
 
 		#clock-cells = <0>;
-		clocks = <&osc_32k 0>;
+		clocks = <&osc_32k>;
 		clock-output-names = "clk-32k-out";
 
 		regulators {
-- 
2.37.1

