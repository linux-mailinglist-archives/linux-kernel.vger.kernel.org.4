Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2356A6525
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCAB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCAB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:57:21 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01338008;
        Tue, 28 Feb 2023 17:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lolJYYFm6sF0V5CrIKmU3foXcAoyPjsubqyHmg/PwsuoVmMTwRbULa3eq5MvOG+FBicJPxK6JUslQHzVy271rrSfQlCioqw/jOQOYPQ9V+NCpCmSrNcHUEfjZN+kWxrdbtAdL3HV9GxIMECX9qqLwNTcDCMRWhFaxna5ZWM//GtL3UNDHUgEDQTJn60ZP82aEn/jmZwAujeeKVuC1w44GpJsJ1AbS3a8IGR16BJRIElkzjmIsuK3QNGGm66z8tIrsKHqjUjr2AjEvZ2oEvQqthZioYj4+j8DC3hTSFQh/C8ga9UB3CNC7kIp5eL5nri7h+a5cwmL3OXnYICZCjZHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsaFysztIPVr5PV30IugbUGvJxZRBi8wRMfoRRjUR08=;
 b=Z+x2NH9w1oP11DErQeyKXIwQoiY4Wwd95FBt44WQnDyqxPQnrSuJo7CKMWRFy3RujMBBrjmygDU04oU+aJuvYhTVOULXEOFWEirTpZ/GV90A03jB8AYiILrWWp9l2HuoK0MOjtx0E/omks/CocMJ7GKV/1lEptYzUWP4EsojWsNFI65rg/JVRlDy5YTuQC4onvuQZpfqsONXMNUmUj/GNsJWOWlizzbXRwbdIMKQpL74J8Cuel57xaCY0xnIXYK1DSZK/zIsbFVldokkX966tX+XoCE6m2BmSiJTq3aB3t2fKLmnT31jdHSw64H01I38zzLhSJQ/6rQWFAEpBcv6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsaFysztIPVr5PV30IugbUGvJxZRBi8wRMfoRRjUR08=;
 b=Rh+y5dq9olTuFgXnMIHW6xXuQmXRUvwgIXGCyq/nnJ8+zldGOKPz+kahmOVPcsO59QEV/hUB8kuEMVOcdDz4qizN7xvwvjG6gggDi6VPBQg/Qe4R6LychBbh5RpeyaI65L8yf5d4At358uQ8wirtnkj6SM58gCOGwSTLyWWAfIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:56:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:56:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Date:   Wed,  1 Mar 2023 10:01:22 +0800
Message-Id: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f318f2-68a7-40dd-b19f-08db19f823ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rv26Z3c2AlAIJK1ek388gn25jlFm/TXmJVKLvAL3PFqpRvTsmkD1/yr0EBz5POAgZr/bpRLfHQm3hQK0V+RkHJYZTA56kXPr0nQ13iRHsamD2kq2EWKuFWWh0FeVsdJtll6vEBaO0o2+NpVUzpe1Zar+54eqokd2lZBApeSO7nJ2bw2hhQzSJfS7r+q6jElWgmqHVAan6WaUjQJfr52EHsJFEFdKHh6t6RAeRl4M3UBFhjBS7vV0O6dRi+iae6bRxzkmTtq0izINc3q5YrtpgJbeQ3ecEIe+cX1XcV1nhX4VTsuqzxNLL7T0trel2yBjBWQj4/hQhz+ohkayhOpkJVWw8Vp+yGAmR6IrJDj2+ywkAP7FM4t9uJQsPtpYS05khdLGF13E1LNQI9y1SWD8qeI12RJhKw/tAFkwIuQMrH+pyATimnoGJOxmppPWNtr6fEOHaauN1rLSM4HDSYIMyxn9CujEspSW2x0d+3reu0DZ9ZyAm+Ej5+JdfwirYvcCOaszYGgpJzxQxoVL854hcK+GtwuKpjGvPCs4B6u1kDnVMEz23ixJ6wvvCmFQizPM8qegYmkktHZ30zjneRmFkTPXjwlbpD5zB3y0cATNI9RYlRMWHiZz7nmKs889faE2pKE59UPOxquaO9csH4pv0kn5weyVrwtSVg4SgIORL5sq+XX1RhaCS9PeLHgP5OtzpV750piITRuGGlKVKax8+8CnFAr16xQTopQent3bL3eTiGON42I0vaFpFr+cMASC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199018)(6512007)(186003)(26005)(6506007)(2616005)(2906002)(52116002)(478600001)(1076003)(83380400001)(6666004)(316002)(38350700002)(921005)(66556008)(8676002)(4326008)(66946007)(38100700002)(41300700001)(66476007)(86362001)(8936002)(4744005)(7416002)(6486002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2185TQH4sym7R6t80uDxMEMj87/4wO3haFvQas+DddVLOLAhN5CItWv//tp?=
 =?us-ascii?Q?HEq+Zq2SZsTSHscheF0cRQ2BTJmP2SK4csQkKss/Gfyqi/XDyWPxaz4pJwml?=
 =?us-ascii?Q?gVQm5i+KfkyLFKxVawFKC96S4KBZGAsgMPOk44TuXe217/cVJZOUPWF0ZEsG?=
 =?us-ascii?Q?o2fYTMplqDiksEAJHWaXvnEUNHn8VpNqeKVRQXXL7ShDMPYbGMASNXsI8ZCX?=
 =?us-ascii?Q?pmI4M8q2NrDhFeFkATz7foigb1oNKylugH+LWlhFNGT3CkFARDyUNXhdJgYo?=
 =?us-ascii?Q?WadS57/mR0fcl8MANRxv6Vnp8IIQMhHIHSWOh83T6P6TWfyEzbdcEnsRQ4g5?=
 =?us-ascii?Q?JzW5VgtshgTrteYVemKmBn3lNJgELGaKDRQ8j8OyNRyzt6fA9McYupYFvJ64?=
 =?us-ascii?Q?cPZW3Lupz5IYxG0a85PZesU0VUMEqaD8h1z/Xh3LOH4DLY0wjLjEbKUlaSol?=
 =?us-ascii?Q?EmvN6KZtCNGRcWZz+KHLkSq6h8llGu5VJyM5NdWb2i59d7lCIGNBT2oX5PV7?=
 =?us-ascii?Q?dwhzuxErXQakI7nqgNfvv3FWytJmKIpqwlqkkv4Xihquc3acD4rXRCQijIMX?=
 =?us-ascii?Q?glAr3uW5KfRbDbmNe6M300GJQYQtj6kRlPBpZ1riWOzARnhRrfZ5qep/e0Ad?=
 =?us-ascii?Q?AuV95HHKOlUTe7QA4nEDxiAVvMp6d6SBlUIlxmciPufGt6nJ9k5fIZbFXszG?=
 =?us-ascii?Q?OgXHHfIHoaY2M0U1maZyYuX2/1dWp/QBIeKcHK3+hbp40/qOMHOzyUV9u76u?=
 =?us-ascii?Q?mLBPQJq/PX8IbXHF2Nj/ic+05gy4sWcYVVWdTCOZ/ijX+UUg/0HyccykpyoH?=
 =?us-ascii?Q?RIaf6yt5g0l84R0ayuW7dn5kh0GcSr8aKoQm2CzzDbpkncnNELj4TEeCir2w?=
 =?us-ascii?Q?9nVYy9Eh3xCj8rJucOxkcxlXFOXKtRL53WMnHi9ezXtZc7fs0s+drqnriqzo?=
 =?us-ascii?Q?zh7xA1VVhxtrkUWHjD3gq9+gAgj2hB6r6yfzLALKHlmRdIrtPcPJAmNPwpdw?=
 =?us-ascii?Q?C4hkA4qHzUydnEZ6dEKtRlaECz3n68/NeUbD/esosqhXRjWb2HsqK74+Nw0D?=
 =?us-ascii?Q?+DTwuKBFHZnN+vkInK3Gkbip/opca9Gd5xzJPbS0YBN2Xe2Rn23yM6XEliiU?=
 =?us-ascii?Q?zQuPh38mp8X9zfF4tBQP4u0inXSOhQRp450PhI7SYvb4jxh89Ph6uzhoIdel?=
 =?us-ascii?Q?QYVqqHc8NTmj4P5hM6tyZSC8kdcizoWDKVlM8+CA+t6Hkx0k5EbQePz80AEO?=
 =?us-ascii?Q?hM2H+VGVF69j+6MMG/TUd/Psip8/LdOxJ63i6gTuYstWRMRdUlbbAkHDHCXy?=
 =?us-ascii?Q?Jt35MKUnJw4itQHfzfyKgqB1ZBfvlC7LozY60i/Zd/nXBnNDcG5cCum5z/2l?=
 =?us-ascii?Q?IRVGp/Yqi+N9pNuBPp8FJY1kM/sqiPvpeu0ghgTIaDzHVMOwpDfe7ABaWmHK?=
 =?us-ascii?Q?pk7lvUBPKsX2qpZ9CfRSpTRBmaUQ/nEBWk64y3ffodRESghgpJ+Sda2UWVFb?=
 =?us-ascii?Q?oZMuukKM+y3ntf/EKQNV6GuAkWHwZcQOsUHcMKxR+8B9FopsgSkDHy6qosfd?=
 =?us-ascii?Q?6i7WAcmvRtNWjEqSXa0JUw1LxK6SrFtk6o2fQ6AE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f318f2-68a7-40dd-b19f-08db19f823ae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:56:14.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceq0udj14z0tp4pw3V6uCjpvwNUfTP0vb4j/M+ZEd5O85+jYlwize71P2/ewhYvdaG4ffCp1l4b3ySUXIURr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Since the CCM module could trigger interrupt, so add interrupts property
for i.MX8M.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
index 0dbc1433fede..ac7ad8459c79 100644
--- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
@@ -39,6 +39,10 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
       for the full list of i.MX8M clock IDs.
 
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
 required:
   - compatible
   - reg
-- 
2.37.1

