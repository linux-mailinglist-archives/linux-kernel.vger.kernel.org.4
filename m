Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D05B6A93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiIMJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiIMJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:20:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878436143;
        Tue, 13 Sep 2022 02:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DREt/GndIpeTKVRKMqZ3zeKYr1WLVz8G62cqQd/V0K3w/Vg3EN4pmj5YG38yQcKz7assy8+gbGYKRMRNk0cI8+8AmLof1oKFRVb5l/AJ0NDVBXiNnmNpgyvMYUFlZeY2KJY4m7xr5lhygQEFHHpUelSLHuZhXhcGltnXEw+9wgWHq/5dc67hTxPbbI7MyckkHTDHyVGN/dHsikET6lrluZ84r1wCLL9+SwXDMusLejgkYVpx6BpBvX7E9sW0Ncx6RknaR+o3M1yOIFJ4b7BBetB/S7ZPn5p573by77YTJpRf9h47beNal26yjLk6mYW93BiqkLmPtzD3AuQSRnur6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFG2kcgxzzhWw1weqy9pIBpeiI0Vn/DhJnFgbO/aBAc=;
 b=XFtlzN69DkW11w90feowypY614SGpcQUycW00kCxB+IYF38ashXwwZbeHj92lfABVK6UlfTcNe/oSnFQUXfUN5hNAyovIBEVcetSB3XAK+l1cLHIlB2omgDzYz3qM6laoXuXkBqhzq2nlsgjOeWR8eh8J9jeH/9gD/DOO+kSlV/E5RNtwXExzsVaiE1qmX+722CbGfUsfC2SfsK24mgqkPaoWHqlm/7Cl8f5rlbqjJi+0qHBWvi5sTd54upplz9C/5r91htrV9QxJnuRTdkr1mieSLnhrk7MJbbYgK5k0d4GG8Kog7hKnf+EA+PX99OLzlxhC7fRT/28GpEqkToHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFG2kcgxzzhWw1weqy9pIBpeiI0Vn/DhJnFgbO/aBAc=;
 b=advLmYKQJeKiYvGox6d6RClcC+/4ke+tvA9xwfQB1tTz6Ncfxx49wfKroBduftMgn3MfQL7cQ9ln9GEzMwzNLcGS/s0b2QTL8OwH6qhTZYjlrKChFt3N6Zqc9Yz3pHBufHWHSxQlvfWhaRpVh/WBAIu0025Ek1FIe6jHoQzYcjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 09:20:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:20:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: clock: imx8m/imx93: introduce fsl,always-on-clocks property
Date:   Tue, 13 Sep 2022 17:21:35 +0800
Message-Id: <20220913092136.1706263-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e39ff9-1390-4eb3-430e-08da956926ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePsFNRLysJLP8rf4c6lmnZVxet2jW2LVvtyrevQjJ/XXI8Q23UV9PnzZQw3pZQnxNO3sQQQQOmfLNg4iSSUq20kudJpsnklNI028zA0ca2LjFA6/kMnWNJ0R6gMk7T7dGsi2XS2/Hf+RjcSckVxEaVNXHs44CmX/4+iBGqn8RpR5bchxmpKtpvuOpp8kPhBvBN0b1ZGQVW9q0TcDpLzWDU97jiEMx9J/hApZiGakUe4+SJeXt5V8WcIyq+s+6JyXjhgHMpKOOfxRe3uxT3TJCq/TJz30m9wBjyQ4BzebeiSmXQZ5mKNpG/UBY7V/rSS2s84DEcDwI6YDllkqzdP2Q+tgjA7a3HnhFQOIqjsx4GcaORlf41pV8/agVtaEUh8LoXhVCg1xAnGBsNPQpgKc1T5D/4IMy0kxI/pLmg8Rq5AaQnO1gMUfUmYT42nVQ+V2svioqiWrvI1lbiqP97kx2s4Apj+X7sKwMWNQgGrvSfLFR75PjUpMkVk7V6MImN9pSH11yNQkBGF1EEzqBCR225DA8SsBQlp0idYOCsWWZ3kqpxtm6nJijA731ESzjmUoWDz2rh43zkCfvS2qhWSqhi09GN20XNU4SF/LNBXQb+WiCqUpAHocOzx/Q88muqDUL4KJ9Ukxl/UUOS2wZxCyO+nL3M8m1hG5R8af3iS6dkqBs8Oia5Ik8EHUo31frcKFW7FLbPmbDLmSahSGFK7luO8+rCWEvtsbS/BNsDN74k5StU6OV36+1rMeZDxGY2Lu/MfPZp4FNexq4tdbtkLoLV+JZBGcw44IHo/TYdEYm2gr/EsxlfjdGBtqFC3a5fah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(186003)(6666004)(4326008)(316002)(8676002)(41300700001)(83380400001)(6512007)(38100700002)(66476007)(26005)(52116002)(38350700002)(66946007)(6486002)(86362001)(478600001)(921005)(6506007)(1076003)(5660300002)(2616005)(66556008)(2906002)(7416002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CsBfYFze/6rv9azylppL0ZnziVKrMNHnIOEkEyrroFfcYERqe1MyOrClYO95?=
 =?us-ascii?Q?hqNBGK4h+jFJVRtv/Pdi1ObOwcw4LTz/E/1m8xxwWE6pwRK1R1m4+xRphvO8?=
 =?us-ascii?Q?AkKphhlfHEcrN1hwXIYoeF0LYLQ/vGUT5kIjoLxmn91jFz6yfX35OaSQ1pr6?=
 =?us-ascii?Q?nnpPSgpy314Hpge7N4pxZe5hpOMvqxtxobg2aPY1XF9lBQoSTcz47hr/b19b?=
 =?us-ascii?Q?8u9m5/arPHz4PW1+lJRCrzmmNbR/EKvBo58DY0Lw4GPYYVL6DBnMYHiArbtP?=
 =?us-ascii?Q?QcNZOeK8LyKAt0rZktLiFslqJYNHRloaqR71PH8s2k32DzAEowVfhnqvwcRD?=
 =?us-ascii?Q?dOreGdJayFkR1h3A9tZHowK3ZL8o8L9MLmdzqt1BDyAi1pUJKkHb6fkIizOE?=
 =?us-ascii?Q?K7SkzwBCAxtXCGBKBDCqwEQ/91xEbAAgX+F/ALJk4MnAV9o8jSmP4KIuMhjF?=
 =?us-ascii?Q?hQCx9BiSgy7oz5kreXlFGu/pALg03KB53VDTa++4eh2W51uR5WdWaTvL1C5H?=
 =?us-ascii?Q?+FNuVW9pnedwJzHuVcWFjSiB3ZHqfCHgPXCH7ADL17+k1ES5AEkpcF+VHKXE?=
 =?us-ascii?Q?0HOT6DbTrTW3PIn0hMliCEC8z26VV1LODHom2UqTOYMHH8oUmenPBB0tj2rp?=
 =?us-ascii?Q?RUUymkd3KYMkFK1jKj3kHbWWPZfMWQMk44FvKj7NLfmrEIgZyJqFAGUnJ3Tp?=
 =?us-ascii?Q?gMEwZQhRlVdXUCAAblJ8ljf7INnZMHPdGbfbXjreZQ+V8v5fkvaLnfbtH0tJ?=
 =?us-ascii?Q?AnZsUlhWBrhbypBxMoJk9FPXexfemu/esebqH7hUSZvsFKNcfqkUETJ23A8+?=
 =?us-ascii?Q?YiUQf9PocyVlZFgltWA1Cm87hC4eG3JTJUy6ecJJuCz32L0jSOvCpAZpLhs6?=
 =?us-ascii?Q?sAchixZu311cAGT8x3gtwTNEf6/t/mhVkDwjMnN6ZzkwpE5b4iZ8P82Bj1MZ?=
 =?us-ascii?Q?W3U+4RbuGd0heDxIEXPb1JTgg38LL4ngTSCf+XgYmKHCfNA3bMyPVgRKrIfY?=
 =?us-ascii?Q?/elcuKUkSGFctYWsFDoA8WBPQQOMBh7Df5h3lc63C7gNJaKjAFpi2CbfoYmb?=
 =?us-ascii?Q?71XY6ytUfJaqCCeQbVCj9zXakywbqQ2C3uOpaBIJcgUCH3RN0RTk0GSfU4Zf?=
 =?us-ascii?Q?a4LbRooLFL+h/Dtnf90rj1w309PUH25SSgAy2qC9h0JdTq1r4JWo0Ixsoavh?=
 =?us-ascii?Q?2WcESOianw8Sgv1PiCvlqEdIT9H4VgyEEhhNPPvKGPlyhU6evjkOsPasLYa9?=
 =?us-ascii?Q?WfnuUbT9h9t84a4JQ1kx4sag4UHm6flVgUl285LzEtjr3AZb8DtTloRZbz0c?=
 =?us-ascii?Q?F4R+MMRTpwbcGNnpEpu1W9xSMD7Y/CFrybqoETmwzljLWln75wHWOQaT+rH3?=
 =?us-ascii?Q?Opy7R6UhVuzzvJboSf1dOLkwl9TXqz/wkP4G/FgSmix6+lHcbNONd84v9kzB?=
 =?us-ascii?Q?PHoHAeR2ZhG7qZnle56m6CBMjYpK6LMFx1CA4Gdsxlrp/6Gwc0ReqtCCmsK7?=
 =?us-ascii?Q?4ayRRrBIcJrkQNEdGVYOqHcOKvNsW7PA2PCTXCGOV5tg7LMTxs3ZZDJoT7x6?=
 =?us-ascii?Q?D4pb+x8PjB08EcrNXQ+Gt/y9TFZ20S4aNixik5NV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e39ff9-1390-4eb3-430e-08da956926ff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:20:08.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN9ArakaLVvBZEydW5NzB1aab6tWkXArbzq4B4fvfMfJPz8jPXkFbpWiRKkUgvkh5vWZaj8XPf7sQjvKrkRpYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8790
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M Linux run on top of Jailhouse hypervisor, the root cell Linux
should not disable clocks used by inmate.

So introduce fsl,always-on-clocks for above case.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
index 458c7645ee68..4b481737895d 100644
--- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
@@ -39,6 +39,10 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
       for the full list of i.MX8M clock IDs.
 
+  fsl,always-on-clocks:
+    description: List of the always-on-clocks.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index 21a06194e4a3..2b35e8af1438 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -43,6 +43,10 @@ properties:
       See include/dt-bindings/clock/imx93-clock.h for the full list of
       i.MX93 clock IDs.
 
+  fsl,always-on-clocks:
+    description: List of the always-on-clocks.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
 required:
   - compatible
   - reg
-- 
2.37.1

