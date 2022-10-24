Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4960BDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJXWsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiJXWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:48:26 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1b::721])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479901645CD;
        Mon, 24 Oct 2022 14:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtdJzoejAGJ/Yr54ScBFogVS41LXKOV5pfJECLQHaTa/w4sOroWdKJjVFyTra/6yDBYimJmCE+nelKjLgZp023S/Ms3mf2femmGunrx+Y9L3VOlA9MTcg3JNc0dj/0N1FqfA2eFMEO1t/qUxik/8yMewhRxJZQNfJ9tICk7XRmD6N8oczA1QwgrkinWiPvbaTlhY+wZYDc02LTXRBakrS3JaVj8BdSAMKmdYsvRAnihnb3BfllSnH1okz54H/bmgdtwwANQH83PwMl0Rwe2IxKEAPJ0iuNg539lVj/cax7jhw1ewSUcRb/xigCG4GT1pxL6daFqvWud+m2GqK3DKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=WIs5u83c10IgPiFoTxjCjeHQyVRk8DLrj8N581h4B7ALx2dKA8Bp2XGANQt8ZVxpqVNISe+Pzeqe4ZDlpUNoRgCZtLiJuzVxjhdQ8YnYNXEVhVd8Et+JwKEs5wSOq0KJOba7XbPDx8g/30a5lc32frFt2DaR2Zqq6SnmYFrMDNm9CkEabmJhRHm+mFlP2esF59YLtbrpiyriR4OXLYLD1+9v0Dw+ZY4vwOR4vKemtO9MmHVCONIOdEEJALZSldsXlW2SnTYU96rPP5j0oZFb3fzSXfz1IbfC03h/t2SnOOWBgh3XG4czxs4YXpLVLdcXA5zPolfNEaGqwCZnktPXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=jMr/j3edF8Y3PtgXlg7+v8rje6CpTuEAlqdIEREDTEqbWnx+OUyU/4DkjBsIy3G+4ShiejnK9D/EIixmLmwrr0lbijxo3X+bTdGF5/6hDVcB3a4DbYTkRjrulC97YhBdRbXvZole01glvVeCzPymvvXHmRvNIlvZ4Sbl33MXclA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS1P190MB1798.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 21:02:19 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 21:02:19 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] arm64: dts: marvell: cp11x: Fix nand_controller node name according to YAML
Date:   Tue, 25 Oct 2022 00:01:51 +0300
Message-Id: <20221024210153.28852-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221024210153.28852-1-vadym.kochan@plvision.eu>
References: <20221024210153.28852-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS1P190MB1798:EE_
X-MS-Office365-Filtering-Correlation-Id: 99172cdc-a979-4f66-6392-08dab6030991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNaenSzmIh3AmSRU6phwgEndh4+MnXfPXydmR27J4mJTnXFEqfuptsPYDl747AVRolqQ4tH3YG7phL2SY531Qo7Bya0HXEJO8/S0LA4snoIdoR7tkIwj5ggWATi7acb4sHd2fqcryT7ryD5RHaeIu5HyH24iwGlXANRIVSLYJpMsHduUn9pgmg6ChoU3D3f0ZEW+x8hNzx2tlBmh0l5mA9e+OpFGe7QgiE5+2xUqUZE2CRU6HF6BA1aG/HewH4HL/1SAe5IJtpci6LPWYbUA1xU6Post/Xab+5i5tGBt18oUN58G0M0NY+z4TVYn5rhNXIBhVB+YT8RTU9n+i1zuRxwJWMBIKjQrPzmNNpm8S5NBUav2vqIgJxc0raB6NUSkRilPOL86+aKq3Ca8X++tMcCutcv1tFFWvgt7ruxqUJlEi4O6hlaXTHczzkjmxRm6CqiHvPsv2BxaMU0E83GCHSj6YkSc3X9ZowkWbeKBgP1PTvtQwkncl7hGDdREjDb6gDNcsA9YT6tt5F/ASyxt+Irvc2ulLw8qezA3XrPyTvvcIxtf2csAwK8x99eLRLZH5WFuLa+FoTNL9ryORWuZVYXQdPrzpudTad97fLZkSXVz0o4Bza1jMWhJxXC5wtuWWPfo19LwN3LibvBDvBgvap4Y0aGyfNKELshP/wAZ67wz0J1tWbgkyJSPoYAfqNu6JMFi60HN+MHAcUNd+GNiyVvgZziSMaRcDjfWgyI3qaGudVBnhas7XMfdv1h+KcCFtwIpMVdVpWhx35jpOCT0WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39840400004)(346002)(136003)(34036004)(396003)(376002)(451199015)(4326008)(54906003)(8676002)(66556008)(66476007)(66946007)(921005)(110136005)(316002)(5660300002)(4744005)(7416002)(36756003)(8936002)(41300700001)(6506007)(6512007)(1076003)(52116002)(83380400001)(41320700001)(186003)(2616005)(86362001)(26005)(6666004)(6486002)(508600001)(38350700002)(38100700002)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IgfdLWijbM2fsDd0A/hKw6bLsU+zKOdm6Afk2b6qC1OB1l8IU/rfnprMU6Ee?=
 =?us-ascii?Q?NdEDiDsv0RVdE2J5zV7F1wB8/hsJwB+H64ntfNqCuNVYn4gdxzClwbVnvgeb?=
 =?us-ascii?Q?WJibrTsNrsEdEbQiFpwMQi4LEipoXhgCLFXmrUnbS4ROXiqJk1ncNBDJs7bz?=
 =?us-ascii?Q?Jyomrh3qpjpWm0DWMyfj+XYltt5vH8akChq4QV5N6SksXGV/YcRpIpAdwXHE?=
 =?us-ascii?Q?9nTxedT0j6JggQBtfQ8YO4PY+NtX6aRKs0YgLOhbL0GIcD9cdh2rTZ4/AhSW?=
 =?us-ascii?Q?ubqxpLlSeiYw+IoKwj65+wtj4B/EwQ8jJ0kKqJtcglG5s49Y5KpEhfAx9Ybw?=
 =?us-ascii?Q?+8ZFWpse10Yee3frFXGaPDmtB1kLYhidbM1uN7kXB2m4TkxWi2H5yvy7KIs7?=
 =?us-ascii?Q?VGgYzvJXmBDIJsQhKXzAEQwPjC3A7N629IVD7xl9frGvN03asMphp6SGyrPD?=
 =?us-ascii?Q?gbSkEHSOg7TrjTe8Z3a9Zpgq6Ymdogmlx8wWXh9SHqIyjYQJS5BgWw6fYiwQ?=
 =?us-ascii?Q?S3sbZOi372teWDWn0lG2VMnrA7pVC3mOKa5O/Mbjqzy51mYtuzKQ3r38IBDY?=
 =?us-ascii?Q?ytJzaPgLIkZ8SKgQr9WYH/Nz+eeY5RUjJZofsVH3Kc7heR+yg1asJGgaJ5Qv?=
 =?us-ascii?Q?wlkerFFawL6hLf9pE62LcN2/DcttpsADHSxIhvSvNhnR/d93CZdCsXOdgq4N?=
 =?us-ascii?Q?N30fXafHBqNlrTxvbPaeK36+fV0aZG7RnX40Zoe/cy2ARIbFIY+q1QFTxWjC?=
 =?us-ascii?Q?WiNEHRM4/HbSEBp7wCSGrmlgq7MMZZcSrr0JbTXCNHsLXPfqAKY3lMrUJk+E?=
 =?us-ascii?Q?ar9G+oefUmRO7K7odXjPmyNh8QkayliNow+Itu/wFu++fD43uh4vd1juzlP3?=
 =?us-ascii?Q?hpCbiq5sKJoVURiGZMEn8/lvdPBQPnETHqKOnOIO8zzfzcAyQkmAuMYjoaq1?=
 =?us-ascii?Q?HBDrKuKCSuNxscbgo1DIy9AHjk3+u2BABxwBIff2g5G0QoKEhARDmhiWU4Nn?=
 =?us-ascii?Q?eX75Sd/ZHw7JxFSa9lR6p/Da3pGRmilp+OTdF+u8E+bPe48SnlNnzjZbD1Un?=
 =?us-ascii?Q?3vGem1em84asDDcTi7G4flZNNNC566Va1hZKFs+nrzjKtDMgH2Vdo4zSLPCn?=
 =?us-ascii?Q?MoaIBX0CHINBWY8bIMXURKLa08K2VkyV4tzMYXJmplo9mhwscjp1R4Tb7MsI?=
 =?us-ascii?Q?IfMS0U+rX8AfR8lEBiR7R5C9w4DqAtv8j6FF0fI5PlQs8M3BQXnSgbWqf1Rm?=
 =?us-ascii?Q?EQaRJ9jz6pydcfevdLrHJi57RUh4cvl1sQ9ut1qYeHkRcGMb2PhQpCRzowRe?=
 =?us-ascii?Q?YeWrLZT+2z4Wad+aJH4K+c/+81pl4jkf5wYeebLUCtl9bdH+8te2gjG7/E2W?=
 =?us-ascii?Q?hjG4on5SkeyFI1RUvcLUopZvQIcW1YSEqwvqcHty/QMftGAbbB58KI9Aims8?=
 =?us-ascii?Q?WAKDV54J9bsQ6+xnrjYH9h1hRbmf1DLr6FV2jQCMvFLc8uQcb9nyzTWaEfID?=
 =?us-ascii?Q?eHk7SqbRTIuIPQlCWka/8nXumIsuaJQPSGGYnBirH3MnvmwAK6ozARPWNfU+?=
 =?us-ascii?Q?hlycehb8FpfTCSyUaFzE4cleg7gFw5uqhAZSaGLo0dMhECLMGz2sQKRaVAKM?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 99172cdc-a979-4f66-6392-08dab6030991
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:02:18.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQq/saipNYZK6Igm/sq1WK0Pst7Ke5ajV0uwsewzdgZ1kR3E/rUWDTV1GlX/uvjcQtWvMGbV5pw6ZLbn/kChSNthRD+zsp7xsuO62xJzpnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell NAND controller has now YAML to validate it's DT bindings, so
change the node name of cp11x DTSI as it is required by nand-controller.yaml

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 7d0043824f2a..982b180b33e6 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -468,7 +468,7 @@
 			status = "disabled";
 		};
 
-		CP11X_LABEL(nand_controller): nand@720000 {
+		CP11X_LABEL(nand_controller): nand-controller@720000 {
 			/*
 			 * Due to the limitation of the pins available
 			 * this controller is only usable on the CPM
-- 
2.17.1

