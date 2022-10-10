Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DF5F9C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJJKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiJJKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:08:36 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E4A6717C;
        Mon, 10 Oct 2022 03:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FphSbqq7aJXMSK81qW2GcUfRkDC0I9GPiv7HSvKmbwANl4ho+cSHoDgPfU9k5UG/0OMwAmB1fxUU3Nq2ehv8lz1owu6zY4th4Jd+L/RgWCgrRv8Do7JYAx1IfUElzE5rQipR16zR8FFv+mMEbiz3e3zSDVe8GOKQAjpMw4kI1PbeNxozYpcHWS4uttIs66Hv5VZuYEzrMhWsOZCYQ9DnaVeiRooCYAKRLkWhX0Xb1j7EraGqvwEaYpfcYQIRGlmkKXKL2tPiWG44cZCs1akMnffsh6JKK+rGPXrUax2vHHBzxao4S+uCZJTf830tWn07oJM+RrQkFhApVdwDg1xdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkTaHiSKg+6bk8GDzz5Id5SPi80MOGUA9hVwuBHbWmM=;
 b=FppvQzIJdyZw987NcWotmlTAZL3QBakPZbc9+92IQ+axZMjEJYKLhjUqWdYO803HFth79ypmKlUtR+oXztFYrYLqVFptw4czXNuICpUS7E0A0jplEgtplEWKFSmM925Ij/hYdnTu/tV/UyIBfp4F66A2qHBQfCnH3RH56ejFGHS1tvYnMIcXcI7H+S2a3HunaLgkEB8zXG3Q151b/uLeT4uMfCAFwvxEnYVJt2opVER5F3Eq0D5RKbvaG+xR31nDuwvhd4Uhp4TwJ+MH63gGoTkWP83yH+Q/ZoJb7d0nNEPpWNF6/kv0Nfne8BtWtvOBXgCNqgEZe0Ra4x2wqzeRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkTaHiSKg+6bk8GDzz5Id5SPi80MOGUA9hVwuBHbWmM=;
 b=Ur5FuSDMGBa1WUUHcze6kmwYErj1J+VrDYANN5ItT6SOWVgYfOrdd15WiKtRPROkmIrFz3oODl2FCwQKNenSBVz+fYJ12ELUcFGeIrMjIDRvMepnooqLEzZmncpRZtpbu3P+1tCoc8uZR2Iz4nN8Zh1QUmbF1fLz5ou0AH5iR6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8930.eurprd04.prod.outlook.com (2603:10a6:20b:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:08:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:08:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, ulf.hansson@linaro.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: power: gpcv2: add power-domains property
Date:   Mon, 10 Oct 2022 18:09:58 +0800
Message-Id: <20221010100958.290307-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eedd5a6-4e8f-423c-a504-08daaaa760f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dH7F56/fICnYlPO6n5J1rzciL9rKbxT+k/G9xS5TYd9V28+RryhQqcuty4iiA135KJWvyEYq3zDX/rpGycJ7BV9YscrjmUsFQ58np+tmFFaYWgrKJJVAb+uJZGGRs3zKhQXIb6Rtat9LwnHDhUCmtzXGItzNoHw5+T1qgJVU6MVZ9/n+kg4iEb9DkKclHCAJQLfJEKfDeDw1CvFFak/x2+9F/5LMZfaUw8sd6/Bpe2EnHexQtm86PtciakMouMJbsMFwRD7KmsMWcXQChl+BiJuMied03qs8ZPid+/JF59ZR0GdkvDsX5RpnZCVJLMODGj2Pl1P3RIexpZlb6Q7KrtJHK7q4T0m2jhuNubDKjQFTk1rGkCTVGbq+AFwy3NvroHQSggSoA//1erkYw9qWJ8Ftt6eeHrGv50RXS6EaegTUYbntN3MvHwktF7VI6/D6nxrD+JUCIpEDPj8z5P2Jp9hGoYGgM7isOxrjGE5Lgm9qvfANgsqAd7wDN3XJldLDzKLB9pj2YWSBDiCshajF4qq2etnwa5BE+sqWw2jTVDmV3egQvjZkivJvtWt9O/Lg/2ItcLWQ0XlMuX6XTkWW9Fr1JR3CF3hRbJ1v6qGhVd2pQaY1zeSFMYO/ouJWqXCrhCy2vfRYe3pZSNxj1R0OGfPNzP6i+hEW2dv+I5+PsM15VgM0TFnpb332EHBa7qe8OVmnke0wwQ7J/HaOEqMnnZ09/QKYzHhoy2sM91vWdmCVynUPH5D0YQNdNQN+r9b6KpuJq8CaTy67zJkLGKTEeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(8936002)(4744005)(6666004)(7416002)(6512007)(6506007)(52116002)(26005)(2906002)(6486002)(5660300002)(4326008)(66556008)(66476007)(41300700001)(8676002)(38350700002)(478600001)(316002)(66946007)(186003)(1076003)(86362001)(83380400001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8D/ck11Ck3A4Ge8Ywq7Mlbulgwdxk9GICF/zfdqH1AC8CJ4LK1xkkD0x+vi?=
 =?us-ascii?Q?V5ksJp4LldQFhIVXTZLqvEp+oF1RnN02m5eG5rvwOjuAKudfU32Z6kqh485/?=
 =?us-ascii?Q?mlx8CZaVg4RTpA3VEdH/XoejPuQ6deIM4UJQFfXSqF/LqTNwgZShhzGhd9X8?=
 =?us-ascii?Q?g0tJsVVw/Kc1Fs7oa/zoKr+NjPY8PRjESfd3VNb79ehyUmmQc4nGs+daNfwY?=
 =?us-ascii?Q?FCIpm/NoC6aW1aVtixG21bODRi92o0yqlN9v7KuhRWu4kGnR5O81qmPWqXsQ?=
 =?us-ascii?Q?tgJlXlk1668aPzKF76Hzk9KfbVyWT6D7q0/D+YHgRZBpa9t0A+VNgrpR98Cw?=
 =?us-ascii?Q?r7ewtYmHtKoniqojxeOuyoou7QlXxphdqGQDljsuPmJgzxkWSB/GfANLC/Rp?=
 =?us-ascii?Q?M6z8msiIeXxGjLILETQ2x9qgIeIcUUggdV453P3WJFtw5FyyZBdopk4nI9Wt?=
 =?us-ascii?Q?2236hPd43UISKpJX4vj7IJ4Bdp/3NMEYFXufmBUPYncczQyP9WWbsOAXyZSG?=
 =?us-ascii?Q?V5tF0WsmCFI+uIU3lTHLqaRh43AzkJSta9DJIi8MjtQFtQBB1JAo78OO6ylp?=
 =?us-ascii?Q?xhPbhz/u8CrTuAYpj/XgkV3ae/rvKDb9AP8e/2WHdlD9QIVzNivhJapjjBUG?=
 =?us-ascii?Q?LIcxZBcFVQfrn/SPhFZcKavRTIilWtOKAB2PwwLzFC/9yWaoGEdQLI5YVIX7?=
 =?us-ascii?Q?fG/D4qY6SrnGWopwrKNkuYhPx6/Ig/Wl8xUDMLXNtzlPbKaAsdWrWIqZP2Ee?=
 =?us-ascii?Q?5KEl/nXvt5/CDkVQTcaH7eqeCyDiqdTs+zld/rKeTL/Ki4CT4zaLbZC8GlKS?=
 =?us-ascii?Q?3K9hG/EQFuSR2J72q3gYR7zaqFclJbTDYHzEz1lVLivHo6pYEu4ep3nyNzAk?=
 =?us-ascii?Q?+NaZ8nA1qAtmJmGi5K+DKsTWHtbtAu70KonELQ4E8CnEiT6QTNzwamY+xRri?=
 =?us-ascii?Q?GOyu/kx9ri6y6b46Z9Rec2f89faGQ/BjuBrB/3vxFQXX7zpfW3PiW3tCJ8Jt?=
 =?us-ascii?Q?lmrgynMfSyMrHeU6CCqiyDsRkc+TsdutcyBhyfSmd9S+NF1N26T/ixkaf0I5?=
 =?us-ascii?Q?in5dVDHYBjy/gkF8j0qSebNF3k4fkmWfDZqdkJ1ye1eU3R11rNjgIXAuxkzy?=
 =?us-ascii?Q?oaFN605td83r9y9ELaGZ8o8NOiemmxpLctDJy0akWl/tn1TkYaC0Cv38yo3Y?=
 =?us-ascii?Q?B+6PX2K6ezp1NmbCCa3WNMDVlI1c9L5QHiVjYM2mc00+V0m1zA0ZA/OA0LtT?=
 =?us-ascii?Q?uGxBBjLXE8wn4udGnmvAFxdaGjBefy3Pofrl8Pu3G1vRMF+PL+yEa5MBSlJi?=
 =?us-ascii?Q?H2v4jDsv3sj62ltD/5aoBsUykx6U6l7G+lzLBUQluV2lunH9nRXmNnIytOmL?=
 =?us-ascii?Q?63E+cSRCxNqqtQX8ZUlYj/V+KJ88MJr92+6LURXyTNt9MhvhRlSAFPXrdmXn?=
 =?us-ascii?Q?W9TxeAT+i0IDDV4c3tgAHDWd+QK/FHzYVcmZDSngI6o5/Sp9Rxg0JDHNExdT?=
 =?us-ascii?Q?mRcyS0k+F38l+lYPYD2mqxo4dA4GpVLiJMRh1kacfHT/3RQjkKhW1khzPXSa?=
 =?us-ascii?Q?oFTsgaDTUG4W3oc0wkWXJrhQ8jhCYa/i7B60B1Hs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eedd5a6-4e8f-423c-a504-08daaaa760f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:08:29.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DexYj4vFzbre/8+S67WjzIthUv3/UKvoWhzvY47rO8YCPtuMgmV/ip0eJDfwWHT0C99tn2xKva2rXx9lIrohww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Some pgc power-domain requires a parent power domain, so
add an optional power-domains property, otherwise there will be
dt check warning:
gpc@303a0000: pgc:power-domain@1: 'power-domains' does not match
any of the regexes: 'pinctrl-[0-9]+'

Fixes: 30af8513bdb5 ("dt-bindings: power: add defines for i.MX8MM power domains")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index 58022ae7d5dd..dfdb8dfb6b65 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -81,6 +81,9 @@ properties:
 
           power-supply: true
 
+          power-domains:
+            maxItems: 1
+
           resets:
             description: |
               A number of phandles to resets that need to be asserted during
-- 
2.37.1

