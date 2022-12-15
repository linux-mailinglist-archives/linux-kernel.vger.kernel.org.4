Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62F64DC90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLON5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiLON4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:56:55 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC732F675;
        Thu, 15 Dec 2022 05:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5jXl0sGFvHeZWKRvGXL4svvMJHlQLl1HUts/BdlX+XhrvqMptETKvGuGnqLeuJgG5A6CXI0+vd4EohACzR/toIM11o0soDViUKn97OoO+tnrbgqXWnMjMV7gLwU+9rBKh981/gwqVNfzi6szElzKAhRstO1/KQt5QGKmSH00nHf50MqIYR8jlb3bCGM8j6abpAtOW/wqR0ducbz7FTytrdSshhvE4m+M0+ZUKNX0Xc+XUK8vxkQcrGr7EZ0wAIujEXBaQoUBJ8miKBst3QouoUnpSqu+DFhGdVWeizKfdL2KXuaRJHjqP6TyQwApiApVk4VwvPWpQ1JZ9yFo0gZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrT0Ja4gT0OblzbqwCqLKJLffImZD4+knJNuGhNnmB4=;
 b=H+DhgAY5ykZZh61Pmmp3A/56FA/bYLmU+1JAbPxMwJdEAfI6FGYG61WFScBFFWiFAzCr2WXexm3JQR1c5QAH9qk4N6wSeXZWTShZnHNbWbLAmK39klkDuyOG/ltcr5Ag2QrXvM11IifkIAG9kDHpD0N4j1i4tsEDoA33b0DYyCj9EycHQO886g/m2FzYYglTwOz4r9ew1c+NNy9YxyvGW3aTngZ2TUncYqRhEbk0QPzqAtMj2kBvdKDYfXIhzDZQQNPatk20AvvJtbEkntb0RL5gkRDjS39Wkzy2PqSVJZiBeojrzCexU+e+EHT+pIsAnU5XDmCOKRe5QjW7/GdYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrT0Ja4gT0OblzbqwCqLKJLffImZD4+knJNuGhNnmB4=;
 b=g0JOQD0zVQn5hNQsia4pqY6/D2UO6cJPcMTFdSL+DBW/rKQHuEMP25LcvceA7Raw0dvq9b2n9Aw24U2ecrMWY7TMJSYNNIQqXG0eAkXuntQsZsDgiX7WK4Qk2GUYljTU8ezKA1MUg7VF95m4ascN2Jch5ZHic4NaA/jIODw4K9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 15 Dec
 2022 13:56:51 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::2101:60dc:1fd1:425c]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::2101:60dc:1fd1:425c%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 13:56:51 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, iommu@lists.linux.dev
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/2] arm64: dts: ls1088a: declare cache-coherent page table walk feature for IOMMU
Date:   Thu, 15 Dec 2022 15:56:36 +0200
Message-Id: <20221215135636.3684026-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
References: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: f22907bc-d5a4-44c5-c9a8-08dadea43783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cYJNVjJrZrBA6SosCmA1/4seq/T8KbGyBIZ4Dwp40UQxLC1Q0CXThHJhfVJ+JXFmbIapVm7Vt0hAf+drxfUB5dgPpp3Tmxlub/KB95KNioM/WpDnHl2CVhHSGTd+4oDsepfab5drHp76uRqslpbwCQzPhJerBEYE1NT8ZaQZa2cU34L23EqdqK+BqkWDll9mnk3R9ytGmwdVKjOwBbTM0xhKWNyraCgDub6V7b4bV/WjwRXN2Igmi84guF9Ufw8r/qcueqWv15ouft35KcziR7WimfhsRJEeZHDN+jkfxrHyhrnTo9HnDYv0HvvKCvGa2wq+hRBRLN8mCAoLE1gmDeD/5m2Dmc+6zB5QhkO1nkq0Wa0XbpBgFWB/h+Ggyw+l5XxSuo0GbeIG7tJ7F5V65NRW86fKgD/RVwAdKhFjASDsaCe3muFK/ekQB7Oag4Sm2oDakq3Nx4GdEMQRrhzMuknxEHJ1IHEASn9XgL5HOc7liNBsNyzp+OA+TpUGh8XzFMYeCzreyFPoGpHtEaHDlgCfQCYfdxbEtA+OO7IzcynCIDPNVWKDRcNmkqzzxQpwZsdfEE9ALKdiUYNmVyLBb/fpQrQuqitax8ThGQQILB6uu9atUqLINY2t69VVJtLtbY4lXHkECTDOwnyb5kc4NmRAac5QfG2PQej9dynYkdFFtHL9iRw3HvjBsZaa6UeTZFzv9kjYyMwrFOLowMiqoM+NFNLX7Or4wUyJM9u1t4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5121.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(38100700002)(38350700002)(83380400001)(86362001)(54906003)(8676002)(66476007)(66556008)(41300700001)(4326008)(316002)(66946007)(2906002)(5660300002)(7416002)(6486002)(2616005)(6512007)(52116002)(186003)(966005)(478600001)(26005)(1076003)(6506007)(6666004)(8936002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWXNjzQBr6S+UQHQ6xlvmmFWq/uIfY+Nv4lQbICHkgQvwlLLSSWKtpd9oFg+?=
 =?us-ascii?Q?Pb/OvMfSuB/n7OkP6Bec65VTR3iD6co26yD/q0kp5+2WNKaZrhGw/Q9sN/sZ?=
 =?us-ascii?Q?cfBktfPNAhX6BQoeW3Gw7AuupDTlD7ckpH1PgpXV7rG+trSYWwe5E0hCrfTI?=
 =?us-ascii?Q?pZouko7UZsAyFmf0+22QGDgcSJjUZFTqS63hAPZq1J3fIW/rWp3eCQ/MinAr?=
 =?us-ascii?Q?/olY2S+xKIeaQg5Oxml+/GaVb3qsS4vbwzogbd/6jgNcMNX/QHJwMVITNNmf?=
 =?us-ascii?Q?JqWdv81xK2fYeSmFyKQA8DKBY7YsAECzDmMM03nCKOdezwmovlMvTz9e6Jhs?=
 =?us-ascii?Q?2FRwUyPK978iZOIW+mPV439Gu1/c3GLicV4IiK0+Qtb2UEDiw6Vis51w9a8F?=
 =?us-ascii?Q?liquw99RPWQLqm8ThXw8IXB2+2j+c0Rkpwvy7dL0ChfszGnQ+7IcI1w0keyd?=
 =?us-ascii?Q?Sz8+5uPcX7Z5d6B43c18IZ4gxbEPzNznwC+v93JRNWrBtY7fV/uJmZ36Yzg1?=
 =?us-ascii?Q?G5fGUD4UMUQEQnjNr8H0geaeFpHOnzBiYLmBVBmTs/YBaRQ7hHjj0fA1uWLN?=
 =?us-ascii?Q?NYqNpUEiyRQ9HZbRKG5htDHba7/YuBbLPJhnteSWvQx6IOZt5CNhrvbSsctV?=
 =?us-ascii?Q?PeAvwvC7laKgeHh4GCkGaPicfkxmlsUiOyR7peQpfOMXv3igNMKEcccFxOtD?=
 =?us-ascii?Q?9V8XHr2Jse1V3vFdtGdU1OXaZ5KyvkKYkeCEb0fdZazQ14e2bss5RtHc86AX?=
 =?us-ascii?Q?ApbMZHi4KmAgI/6DQbIndiUJtjzJbRKiHKPjPHQ/LKBfC8/NLPY2HLaF9R1J?=
 =?us-ascii?Q?7Uuo79cQyRnpcuvwP5Jnguu7DKv0sGUWJUw4MzW58CqE4o8eK8sWiLjyBEWt?=
 =?us-ascii?Q?x0nK32eLSGJ2NP1E3Q9HTQCgJvu+ceGH8+lt+tJKkNhwu4DRhmRLWbw56s6r?=
 =?us-ascii?Q?23JV+XRKYIEXwxgLkcTlWSPZevwcJiEQJE1jTwBGEH4txJQk9XVQPUbjjH+H?=
 =?us-ascii?Q?pHmQUIP+4LkbNh9MLSrtDuje0r3tVlSm/8C8U96iPLC4suA4bGEnZzSltT6G?=
 =?us-ascii?Q?iczIgDL+u3DnJUsHyYQWrp6aMhnJL8KRQhlCVqkcsYEqoQpOk71TWnkFM96D?=
 =?us-ascii?Q?7GiEY4W9HDHsAHyL83iPzzt6WmWVHPWpEIZz0I80rDgzvgWsvutCG+3jwiSt?=
 =?us-ascii?Q?pXMR1bROcbWMILjW8bz+l1zrp8oFnpd58WyEoZpzkLnuJJqCP+7kaBRCRst/?=
 =?us-ascii?Q?D8FC8mwjIABXCRuRKd7jB2/Tg9EugTKKhB3f2myI4b+kWtar7dXAw/DYo8mM?=
 =?us-ascii?Q?4JIo8BvZUmlIG0XTKlE/WOhicInG1A7ZV6R1kYz+IFM4sSK51FEeawMFBYrS?=
 =?us-ascii?Q?Po05mYiHc9nEPUkyzfpAEzYQa0iSVdP8Uqc/LNMoETO4xYRBTsGWSAgcVJEf?=
 =?us-ascii?Q?PQPFnKoVze+OklwhePcvUfMnEgJlH4N5rB03rpzCCsDG+7NNz6yC5tD/cpRP?=
 =?us-ascii?Q?+yyyQ4f8KoYSuUkrgPXbsJCu7Z9/gnmoy5ia+GKgtAlQIvgiuRHtnoAwQ/D+?=
 =?us-ascii?Q?H+ftKLXi2ZplF5FnIvSIBHjvaC8zpdFpwxInFQWD8P8B2m4NBFdZYBq7Rmk6?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22907bc-d5a4-44c5-c9a8-08dadea43783
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 13:56:51.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NW9bSFLSf31QtJhkzwb4kr7b2el8EmM4kbir8I93dbu7RjcdjV/RNQUp0P3oU8do0ffhPTMudfskIMd0IZ9v3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMMUv2 driver for MMU-500 reads the ARM_SMMU_GR0_ID0 register at
probe time and tries to determine based on the CTTW (Coherent
Translation Table Walk) bit whether this feature is supported.

Unfortunately, it looks like the SMMU integration in the NXP LS1088A has
wrongly tied the cfg_cttw signal to 0, even though the SoC documentation
specifies that "The SMMU supports cache coherency for page table walks
and DVM transactions for page table cache maintenance operations."

Device tree provides the option of overriding the ID register via the
dma-coherent property since commit bae2c2d421cd ("iommu/arm-smmu: Sort
out coherency"), and that's what we do here.

Telling struct io_pgtable_cfg that the SMMU page table walks are
coherent with the CPU caches brings performance benefits, because it
avoids certain operations such as __arm_lpae_sync_pte() for PTE updates.

Link: https://lore.kernel.org/linux-iommu/3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com/
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 260d045dbd9a..e5fb137ac02b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -674,6 +674,7 @@ smmu: iommu@5000000 {
 			reg = <0 0x5000000 0 0x800000>;
 			#iommu-cells = <1>;
 			stream-match-mask = <0x7C00>;
+			dma-coherent;
 			#global-interrupts = <12>;
 				     // global secure fault
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

