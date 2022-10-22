Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63F7608B82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJVKWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJVKWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:22:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA1A31DAF8;
        Sat, 22 Oct 2022 02:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVArlX3cAqyMr1bdc9R/XQdhUQzmlG+ZZOxjvgikpoBTramfeuFQawNRLVTVuo2zQnz+7XOkO8GDU2DTASlwleT8UKaaEv4gs7FJbWSEniYkgQTeoUtLuw4Zaaq2JdbHSqdnfvy80Kgw+KLgIHkCMdccj4uKIk5aZYo6LxcigzkVgiVO5i6YeHQmrTRwnQ5pSp7Co4DxegKL/9vTH5vUC13GeJe4n07HGGioHeunRIOqLA5tPEiEAUYMAm6BM3le4CZEmHYV5yFjXX2lwj40Q4ePoClsSzaqFWZnzW8KFRP2x7pFIuOI29ctyEQdxXxO3Gz5uqpysq0JuT2d2aaN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=NHLd8nZti2+Uw9WmelDP/sgMMINxyQ9WdbjZCnKoM8GR13vW7aXR9RJTTc5BI98FIVt4fPoH9Wu+sFc7Bv10PxB2S+EJu/1QyCO27qIm1HPCEhyFOWRpyBSgusmnZXPlPFehQ8Bpouf8Tis6gi2ud/WfNUovr8CvkbSQCa6xBIUqrZqewog1/rxZbW+7418ZiigCGl3vL3D5A2DKcXqPfJZSpStvh4hg483UpkgBcD+rtyHH+u/AoMxLeD2yst+6HSj/YrNLme3OrX2/XmsWwcPQJ3BoQUwEO3V1zBUkhpKVKX4zYLKSZInAJR2U2AppeacwMVTjt8AdHBEH6NRf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=syK5vhKMT/rbdMIyFUUvjSic9Sl4Go/DJhKenMCietKuSMA3kAToRc5IO8HlzBD6Pa42MTO8EF5g/zYKblNfZXtw8/2emeoqc7pb6VsHJuRYIhBAyMaxgLyUFMVof6IY8z5eMflxyA2KoWaHN4Gkrq2UNVlR5pTQUHR6Cp6byAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS4P190MB1855.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:506::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Sat, 22 Oct
 2022 08:26:46 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 08:26:46 +0000
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
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 2/2] arm64: dts: marvell: cp11x: Fix nand_controller node name according to YAML
Date:   Sat, 22 Oct 2022 11:26:26 +0300
Message-Id: <20221022082628.23876-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221022082628.23876-1-vadym.kochan@plvision.eu>
References: <20221022082628.23876-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::9) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS4P190MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb581e3-b792-4b00-70b4-08dab4072896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpJP/snf/FCuhvzaYx0Ypk22lptjz9JAw5tcmKUXynUBe/yWWcvIX7NbZqhBKzglJlpAQzb7o3Q+o0bFbUpG+CEL12S4uYqzuTu2ID++XBlQ+Q1FCC6A/sbv1nxxW3xOf++89XY+y4MKsKXqFxANuAGEN6cxpr6uTy8LCdZFBYHgRJJtJgaRaARsNJOhcuJr0K3V/rUL+Q1NSw5Emw3eBbmu4Dk7Gtc8QmkMYn2D3VKLyE/sFNcTxIrPLhLJ/k/O5VqcEPCw3oAXNr2Vmf4RTX102KVavw+oeNBUsY1rRgxOvFWeU+3sAfb+v93F7EqDMhRJrw2pgc1z5bphgkbqSKKOCwi2KMdKXyrOiwXfQ1VWaO4X/GdgnX9VezV66cjmhLZC/UvdmJzz8hPJxlmdhvL3czYzH+jJgUYB5v09TlqA0pW5hvEK0K/KujWvw84Uv0FCBasdqqEP5WwcHz/uFXrLolyKQ5W0dPJfdszG85+5hI2BhUywToqVT10aK+6euU746Vs2J8Nr5GlMiRNeZuU0uhA9AADW4yDuu7t/bm+8EVYePLLfGY8qQWYF7fLp607izDB8U2asV7xW2r+goHR9FjaSIow9pX1lwtUvVYk1THuYhvaZzGjTQKnOoI5FOKCaQ6yO8snUUp2UtqgIzDxs/YdDaWhV18dCEUpGNrlADlTbaXQhGsDRgH0QjRiTMsV4DfeSrXCWraGwf1M+q2XKXHAN0yCgAZ016mWHbZwLq7f3c7TtP7TxOL+JM4iWwTLClNNedy5CL+MUdt+9ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(136003)(366004)(376002)(39840400004)(346002)(396003)(451199015)(1076003)(186003)(6506007)(52116002)(6512007)(107886003)(6666004)(5660300002)(83380400001)(7416002)(4744005)(26005)(44832011)(41320700001)(4326008)(2616005)(508600001)(54906003)(41300700001)(6486002)(8936002)(66556008)(110136005)(66946007)(8676002)(66476007)(316002)(2906002)(86362001)(36756003)(38350700002)(38100700002)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUo88qt6FMiv37TsrIeKI22htIz3QIEFlcyZyN74EkCs3KxTnMfkHgNLcFm/?=
 =?us-ascii?Q?A9RmyMxPNkCGfWS5PBb0gpy41gDqZVgMCznNxAeuVys+HA6anTNoijG9fsYS?=
 =?us-ascii?Q?dVXGDF46pn2+vYY4QsZic6O8j2chvXSkOAhKUGkLNjCvTYb6z+GBOenWoOqR?=
 =?us-ascii?Q?uNQCN3KE6Lqb5LGwMWRfKfdFFZIN0gWyLav545NmJr4Y4iLFyZdjh/ecbgHV?=
 =?us-ascii?Q?wqZqhKEXaf1+exWxCF276ZoCdQP3Vmhz9XKD/TmdwTjxOPG2FLfY+NxVV/uC?=
 =?us-ascii?Q?InBLuIUCFGAWWfxIclkCZcdGO3x+HL9LHA37FHsuwf5Eoxwn+wOusgUOpB57?=
 =?us-ascii?Q?UyQyWFILLD7bt3JUrBgd/0Maz1RL2KqpOlVGYX2UPAuJQL0R7rI9PjEoLeme?=
 =?us-ascii?Q?fL1HcH09Xpm8xlBv5dpKf688MoIqGypftgpKCCWNUvGm1k9nwoB73HfnIZVH?=
 =?us-ascii?Q?qLkTwqDu+aMtGrtd1LeLaxHLUfOxihP2OT0xpJMMq6gZds5ry7kjoysa26zE?=
 =?us-ascii?Q?pNQXEWbMnDG1fh47YxgKzNGK+R444exQJXi9cP707H24HorScxW6RL8dOb/l?=
 =?us-ascii?Q?stwSNIOlWV1juFojDCH49M8dNuGEN7HwCd7f3SYME2d5Ea9WsNghzZbsXMLB?=
 =?us-ascii?Q?QNFshg5bysLP5gTyaKmPeYtNTyVDwk4BOE+0pmDV0R9YIKad1d9wVQTOv81U?=
 =?us-ascii?Q?6Piq0U0sXNAIEZC6R44WngAgv94dIo+vvO7oLX0C5A4QogIJUbhev6h3NZdT?=
 =?us-ascii?Q?sWMwNI05W+CYkIdTnu/jrEjGA8I37S4SRAxCIwlXKcqcrh77FCMemSv/3PlD?=
 =?us-ascii?Q?IscdnhW4fUx71G+2/r4JlrEojXOT7XJh5SqPJiUs+U4yTdvo/Ju2VKrQcurL?=
 =?us-ascii?Q?bFUsMMBS1CaqnHpVgdCAlRr7aXDDmMEQZrZQcbY54IZbrfMybro6eVkhYdyJ?=
 =?us-ascii?Q?PcrovjgeOCXMECngkf3z6urwVKh/tKikCEJWE3oa0XTvlYd3loWcg+Z8zF08?=
 =?us-ascii?Q?LJgAbqB6wEjEnTO5AgYQ9gvAcaILvsbXR95/sb53n690sr7of+M9ocLbQfNp?=
 =?us-ascii?Q?Hn6XFh3XbQ8oCctq9ZbTwxYSkFywK1uGcvnA0QJ+ZmHi0ODG1izG5rayUwHk?=
 =?us-ascii?Q?+T006txHii3BMSlftPPdW4ZpGd0dLirz6TNitykGPYMrBhdxOkHjCE0+ctVW?=
 =?us-ascii?Q?gCXV1lYshlbGLAAZfcY1QkgoDTxieFMn+QwCSWbePYlFCWhVn4MhESAFpxfL?=
 =?us-ascii?Q?ZD+DAU/6wr5CpM49/TBS3PNtoGD/eoZ0kzvwEIkjhMsKqSMDyicOdrdX7d6U?=
 =?us-ascii?Q?aqB61dA/+X+me9J+iVwkj4kftks7j4g/kpaQR0tw294QTm7OisDS85PPUeKs?=
 =?us-ascii?Q?gLCcT8uIB9Csf0NmTzDwqSgL6lHJfDWuzrSVbvtIlo7mrXXPMFXAD1GCIoGG?=
 =?us-ascii?Q?LCpwRy/HKRAFJ9PnHkU4XYjLpZDkWBT7DG/IiWgfu/11N66IFdf+Qmje5/Le?=
 =?us-ascii?Q?Z2WJEclWvqjDew0mxj9gsThfLVgkZYDMs02o06P2c2cbSGhVU5KuxLg7F05j?=
 =?us-ascii?Q?wcc1eP+UEdGJfbD6InfdDo6iotX8/F3whbkm7CLP7rPmMW0j88lIilBnDTeX?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb581e3-b792-4b00-70b4-08dab4072896
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 08:26:46.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1MjkxFBa3KIKGqNiJHcJPzMMGDMz0lYUiOTy5eiTRljOMVrtUaYcPJJqJLFlG0f+y3tVjuoBuCGF5cDicX2cNG4cbI5d7cyGy5mnz13vNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1855
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

