Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6047165DE16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjADVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjADVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:08:29 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846B167D0;
        Wed,  4 Jan 2023 13:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkgN/w4SAspHuP3M8MjbC++j08UWBpXtpPgpyqGg9/6OLjx9yipb+yMBvYBfkdfPCJVyDjnUl/PAV5rXeA24ML7zcgLDpMyhHjFRtVbyoptNYWasvjQwdpcCgkhqOXj6GkMsbY9+ICsPbC8tl3iRIJgWjAlevAsc0yIjlMQ4KqrYGhZ+Manj914oHy85ihKoowSyyBynIb0qakQ16lZ8IVCIyqLvoWFaK2RhXniASCBlUlVLwQHURw2mGOXPUpLrHsIKWI353lQuPQwlpAX4nw9oMmA8npI707DK4uDpxOp8fPk/+LewUCDfkgHCx5OHOvEtKH9uM0Xfv40NX2MMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiJdmvNzzTdkjoWcSHYbDUU/IxU0ietQTQrWnGBHt8k=;
 b=j/RwItEqasdfdjMDyfGVDVL+fRzwayssMDJOgNcMNZXLWXZh44wJ/O0FpMbeH11m9ENAlW6geImucFjNwfEristm5ROYq0x9kXt5gohVF45MTtqfwAd/gJOlqKQ3A2jPngXVYz+MToFnFbG1PAv9F4qdgkAEt5i8tKF6lJdo9yIxBxxG87SBVT1YY0Doh0zopNUfQUSNftjBJN2QV7Q+lCicNUbZ1VEsb4hUMbrUXKXnTgfUX5+fjKZxLkEA6rG3VsW10INblcFTr0P0zedGyD73NSBLI2aeNJiIA/c7b6JOcQ866gmy/2bTKSEUS9aEpsucR+Jzc2vbPJntZpI8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiJdmvNzzTdkjoWcSHYbDUU/IxU0ietQTQrWnGBHt8k=;
 b=or3ZM312AX+bEV0cMh4mVxdxCddQIH+jfFMzysfHBj+sRjUoTM2YJmuUqOYe4nDNsYeJa3vyLsgkYWYrLbXZVzz4Uu521TnYWeNxBSU/DS3fkdmZmO0oHkJa3pC8O+NHnpsLMtNl6ugQtyjtX1+XFGw+QfEMWodfKILhk74nCdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 21:08:21 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 21:08:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Han Xu <han.xu@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: freescale: imx8dxl: fix sc_pwrkey's property name linux,keycode
Date:   Wed,  4 Jan 2023 16:07:40 -0500
Message-Id: <20230104210744.2357777-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8cde22-3e1d-4b3a-e6ee-08daee97cf12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8nke67D65mSaR1087v2TH2gIhTFzLYVG6WmlVHDk+cICblsH6P6OuaZPhDldMe0C0sTnTUKQq89PMDW83yEbvy/Zgr9svz69YncAD8+W+tCEwgOIxSnfdO5HZCZRJ8ZBbX6oPVftQ74C/MaQ++2ejN31uQH3v73Aw1gRYwOBG87u0fKDdRr9e/Zzd/NPGadzjVGrs0vAZD1gg/47/0J8ZL2a6D0UO0c9AaQ5HXiDyRREL6/msA8/XB8rDX7ppaMQU/OtBJOdGNaSO5jPWHon8XT3ywRVUMoao2TsQn42NP96vKQ/DYIdqy4nIu4cTcMwx85vl5a4NPOxt6tfSmbhcVaq5KCo2gUR4B/U0swTuhcYWi2kiDmsa6q1l18hnZlNIjfVlYzvDpKG9t3S5VRreS9DAnywzdfk8IQW4WhXLvDk0ZtRsBl8JUi3v+x7oA0tiM9Y/sUYh+nkBOlgw+a/HjOh6seFKx8/qxxzKKy43ovGz+idMDQ1nJTw69urgFXwtEu8R3FFSYWIXNv9jweMyYdDTLywcoKWNQ4dUZdtIV5r9u9Keh3J11NxryywmGtD+ec15F28mgXrHcN1/OWJUw3PQ+fXHQY427qSgpHDdnzWMHcYGGbdMylj51ykPNtXSJY+BsZ83vx13wVXtH86BRQwd9a/p5qsVmQF3apPUyy5zR9iREE6gH3mzsW6dyKxCeup5Pa5pnXwqpy0v/mHxvw5ycmJEbgLi3y5SdrESTuTdKF45RV7yRZKjS4Ro1d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(186003)(26005)(83380400001)(2616005)(6512007)(86362001)(921005)(36756003)(38350700002)(38100700002)(1076003)(316002)(66556008)(110136005)(2906002)(4326008)(66946007)(4744005)(8936002)(41300700001)(8676002)(7416002)(5660300002)(66476007)(6666004)(478600001)(6486002)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJ/oFDuBZnZMA7jpO1Q44U7jPVisTGWB6KWgyZGgjiDKlFB4zG3E7P/xA4bH?=
 =?us-ascii?Q?nKcnxpyRXX3zRIFnVpq9KAoltp4BDYGB9/4pIXmMII6yEAfUMOo0FqrsVPK9?=
 =?us-ascii?Q?PI740eSUF2OxPtKJr/vNU4/d3MAQBHkjqzhK2cjYtjiIP8AotVxh2PPsJwPi?=
 =?us-ascii?Q?bu3yuB1RI1vLoCkhT6helACR0jeDTp32auE2Y1m+BvxC+1otmWFeDDt7Cw61?=
 =?us-ascii?Q?P1JdaUHq9I6VReUlQp11MCbIXiJ/DQlGC0YbTRdtKJMX7swJKg+/sw9l7YTK?=
 =?us-ascii?Q?q0B4Wjx/wcErg3ombE1v+iMIaF9rMF+tj0Gzc4Lx2npp5PBzelxYyRX/oWwC?=
 =?us-ascii?Q?+na4gbnWmq9KrO2q0Q5fHPhBnssWiGDVztx0nbaAr/DGPTY1Fehn9HL70Wv3?=
 =?us-ascii?Q?Vpbud/hftdBIxizmuOpdMhOyfbt9ftIriHgwD6f/6lH5ZDI38ObhvJNIhnUl?=
 =?us-ascii?Q?B24TICc80m7+JKjcFQxKnKAEKp60krybh/W9ps1F6/xaSiuWpx8N+aVmGRSp?=
 =?us-ascii?Q?2QDj+2gXS88HgJfrogyJuV5NCB+BUTA0xkU7BptY13LXwzKHQIXwZSGTCYea?=
 =?us-ascii?Q?GGbCc4+7iNmWNk2SGHUbDKqeE89MBk97Nvxmr87xxyzZabfa8saSyVf3Kj1O?=
 =?us-ascii?Q?dswPMaCxue2Nqb16REFzcX/em2qwDOnrV1Hv8StB2JF1EXI7K8ulvx87aKwj?=
 =?us-ascii?Q?sqlrwOEh6/KVe9xpQqTidJ3Nt3o/YQ+avTNLlPj+54Lw1KeAMQqLWkC7qyVG?=
 =?us-ascii?Q?L7sZPLDzNohKMDqtmVG5lHPN5HBEY1iF1fe8/w+jVVq6TC1N+uOPe4hAsYXx?=
 =?us-ascii?Q?g8bh9r5d/yTDeLOcPTyGz0d0RSWyuo4aD1TWs+Ex9yFKyzQkR6GiAz25OpTv?=
 =?us-ascii?Q?DTj3Mq/32IKLhvxYGqf90yWFARNlT+2U57Q4h4bVkD36jWJRc4O9SRN4glUE?=
 =?us-ascii?Q?qSeMRPfUi/muk58qlifBKhyRSNueMs+e8y1T5TDzPLFHf690jsVxBiecYPfE?=
 =?us-ascii?Q?5xX48DX8ZZdFK3YgtLqqm9qTWpGvvdMWRMWkTm8lPN7UXBoJsIwYW2iXRV/8?=
 =?us-ascii?Q?Dc2Cgv24w1Nj0DmCdE03oq5Nky48C88mgdXxRbXMgih9aHD2aah8CGy0JF0U?=
 =?us-ascii?Q?U/g8dwjzACJzXSGt3n308+nIP+y+7gWtcco1s4KDEkIYnNc8DG1r/P4wVDgP?=
 =?us-ascii?Q?UiRxPoGwlcM8qrTR4DGHlq0/Z+0n/7uJ4RxSGPMBwQOFNYhgpwtwyOVhwjXj?=
 =?us-ascii?Q?Beza/EE+/3iX3oxqxvUOJnbZ82Bk5C081FbS/HIAztr/WQXW5L4+GScAWt9/?=
 =?us-ascii?Q?5PB84qXYSF9FyV21RePdy6KzpC+dg55BYxEvBuAoqMf08j0gkl0GE/rqv8Yc?=
 =?us-ascii?Q?II4mUhVcT5tYBff3k2rhSvpotljBp9ymEDRktJ7HoHzdFVsfnfM2GZ30nra7?=
 =?us-ascii?Q?NzrdMANjfudO6LnuSerwrZ7AUiB2Ff9GfBTcomEl8f73Jf0VjOkMXJRphGuv?=
 =?us-ascii?Q?KybBHsKe2qdHkaVqwZTv31ZFJqjCkmqEQtNrmjxKyqcRn/9OvB+D/W4UVMhr?=
 =?us-ascii?Q?DJx3hTg74AZTWLEVe5tpgAwlJNPzfi30hTf09OpL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8cde22-3e1d-4b3a-e6ee-08daee97cf12
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 21:08:21.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDmynpjbRqkdCEmeURmQsUTbiIw0wtL/uoes4UG37+jyHEU+TndfYgmdJSXbvOHST2HmZgHBp/EEUTEktFhjHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux,keycode should be "linux,keycodes" according binding-doc
Documentation/devicetree/bindings/input/fsl,scu-key.yaml

Fixes: f537ee7f1e76 ("arm64: dts: freescale: add i.MX8DXL SoC support")

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 39020b4629cd..6e2be05f5739 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -187,7 +187,7 @@ rtc: rtc {
 
 		sc_pwrkey: keys {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
-			linux,keycode = <KEY_POWER>;
+			linux,keycodes = <KEY_POWER>;
 			wakeup-source;
 		};
 
-- 
2.34.1

