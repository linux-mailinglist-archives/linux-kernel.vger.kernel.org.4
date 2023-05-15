Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C237032CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbjEOQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbjEOQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:21:23 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0CE60;
        Mon, 15 May 2023 09:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ5FHH0ReA6OGFsrbqEiVD0N6vI4cPZMHQLU9sePqQKU+XcWfj8QPj3y/CppQXtgA+J509QEoffqTeQn5pw1ByyWx2hZiz4yzkIhESAruDJymJzvDrNi25XS15JKIx/VxJr+LbFortxMLGyObQKg4nmlJKYp2c999EARnR5IVmwpqwNES4xDJzOQa5PAaajUWM9PPU0ZmhcDvKzNA+4u7x/t4lmtRfozWUtXHKVsVV/2IgiH7ARzqCsCXV2mg+REGL1kNG7AItL3Ttr/z5Mr2YEj68RoJLEg0OUza3mEHVRYrOp9PJUEE+jySit2notOyWhmsHwNJ91n15XmQB6EZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37QHTv7cLsVz+4ikoYkrwSpGRxKyw6m7AM8VdGcCJfs=;
 b=Wtvvw3LJ/3j71nubiVIaDb07/adw+JijY3D0vmx2LIJqweeIbK/jEgyJ3bx1KcWncPqzCQ9oB/6elq01xfPuWJ8Ca6znwA40N0uRxjKj2OYB4imtmRnLdrcELjfL/RddEpErtb5w0A456XcJNJoLMY0yYVxtueYa5ZFHZIAgBxhJfqcnRfJn5fGlkidvSWVKnxV15yHBLi3u9+zuzJBfvOPZD0mepOlMliCTIPOSGMInzQQEdBjVTnJ/U+jIIFVf4hIHxNr1sa+BV/mLZIpiFyIqs20AhkDg+4192gU2ksXKc2P6AEQBGD6sPXdEzemZEKOCrYs5sWj+vIZfvf1j7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37QHTv7cLsVz+4ikoYkrwSpGRxKyw6m7AM8VdGcCJfs=;
 b=LNhwJbMNTdeMjNbFnDsl3pusZSbmKY1L7oHmileHagrvEVFvIawHoocnhleZSwt1nokbIo5628erRweGjHeTD7VGagEJscBmJCP81SsOQx7nGNmTRKsx5mZbqMBUfiC+9C+E8zZyWZeLgJeuuGwarGmA6370VKpPeY86JfUsa4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7371.eurprd04.prod.outlook.com (2603:10a6:102:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Mon, 15 May
 2023 16:21:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:21:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v3 2/2] arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at super speed
Date:   Mon, 15 May 2023 12:20:53 -0400
Message-Id: <20230515162053.2825405-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515162053.2825405-1-Frank.Li@nxp.com>
References: <20230515162053.2825405-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc7ffd4-1e0e-4fc9-2505-08db5560680c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1x1+zWRd5VP4qpBTHXuZoHA0cECr5EBBAbQINMBBcriLXx1p42ZKgZ7IDs8hmTiuBnb97xRUgs4YNCBHLuT6bBbP3GP/nKVyNq9lPK4J36l9q3f2DmoINJcke1fgbAQcR2GNdXfgWYt3eVEMYoZSmiaXAZi3Rw3wl92yvN6TVDynnuU4Gv/3GIJLHLXM3YdKrNgXH6D+vcRSmpZugJRhFNsaPqCbCBmG5JyF5ExZkMCi/DqlGYuHpT1JsmKYy5C+fqn1iqTDepC1jUG9MXPNnTb5ZWxZSU5DUCmybh8ofbnjzz85p+RpPh0UKN/4s47AA98BKXpAC2490om+j3tVHylUzhH+STTsjYwnDpSLh5H4YjEPaFZnteZqaDPL0e+le90jpRnrm94lTJtEXdb7fGO1XLLjtWES++wCt+vxZb3uSjzuK/AUnn9pOiw939Skc9KbiLHoZ6dDvZpV7HX+sodOLf91icv+CksGJ2UDQVZIWRNXLN2a+BMaqdzi1HTmYczGcRL9YYNHtFGqfAk3EnobSc1WM3T7Zxt/BBWpJKz0AXnXTamVnJzeIbg879bfwoaEeEVTN2sxiKuPFN/QenAGLlB8MWqZhm6X22KQ0w4T/UJdYm5vOXw8cMuhn9IXSGyYFrIlqJvipi/MA1aH7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(186003)(38350700002)(6506007)(38100700002)(921005)(36756003)(86362001)(26005)(6512007)(7416002)(8936002)(8676002)(2616005)(2906002)(110136005)(478600001)(41300700001)(6486002)(5660300002)(52116002)(6666004)(4326008)(66946007)(316002)(66476007)(66556008)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YxEWddRIm/wHZ/MFoPAJSzeasgfkidaa+4iLw528mgJRSaPBiJmk/rGPdSek?=
 =?us-ascii?Q?8Kr59ADdQ4ksdz+tvGDLWVmf0eU6nv39EOqihADUj+wRHFlVkatLvfPXeVxV?=
 =?us-ascii?Q?ZEp2vWh76uFOrc7qFs37CQMPr2SLgQUojQKc0ByFyvgYscwtuyamgofY6RfV?=
 =?us-ascii?Q?JRWQJwdyloy0MUhNdqBh+8gRMVTfRKtyjIXX2Q1x2XQgywXRF4rU2yapkaJt?=
 =?us-ascii?Q?MkmjCqcaOe0PQqZSUfKA1YkdtZGn3/r8v+WFlzGUy96jGNnud+Fz0GoHFriM?=
 =?us-ascii?Q?QFz9+EW8hnmwHnSYnOrM9UFhyn3+wlMRVYtpxHEoqyrpaTwhn64XHfGEhKGd?=
 =?us-ascii?Q?QxN2YHygmaAchPth+YJ7UyNnk0DmG1J/cA7kTMeoVFva9AzMqFVWYVeu7NM8?=
 =?us-ascii?Q?Aq1LOX9MQwPyQtwfa1qkaZ/XYp7YubVMVnJQGEoZMVAE+RGPXE1Jd/T6JUWF?=
 =?us-ascii?Q?/WmFP1BJhzf4HcBsn2jxdB8tBu4+GlOndJjRTpv8YQDxqqry4OZhRnEIbmLl?=
 =?us-ascii?Q?jbQxm10ysy1Ag9ZhcVbkxn5DOpiW8+jYcdxgpyevToScYR0X14Wj5kF5HEvZ?=
 =?us-ascii?Q?2U4Eid2WRK5ZgkkFEAhOb2y6x7E/RQs5NkKj+3zPYIxxMtI41OxdpFL8Kya4?=
 =?us-ascii?Q?C+oBdoNt6hFgydGkSfUcvZj9Q/SM7/GfZsCgQO9PMPEftVz4XmtElVaiJx5d?=
 =?us-ascii?Q?gyaO/0/DcBixUdqS7uPmS3xSC/iL1ydc3IUhSuXfKNLOt4AXDJFbRRHkVffS?=
 =?us-ascii?Q?1lFJCTFHgnaQNfHtYP1EXprsrB85GIPuc20KY0AMsVTiblzZXnWsmUwslHQj?=
 =?us-ascii?Q?XKA1ETCErH830TRyv7s8e7YRsfdNOVhLp91Tx+24gOcFvE0Fxtn+wsAnjkCa?=
 =?us-ascii?Q?V12XI+PNIzWhyeQ+rETDqMIaTZV/SDX28bJRIfregj6WOZlGlGz+u/FwLYLN?=
 =?us-ascii?Q?zypOdajZh8t6Hyx56DjlvNZ0mxw+D3LOMF3uqxT8/5DxZNoXWtP350OqFWBI?=
 =?us-ascii?Q?lxia1fw/VfO8mpo2vqC+Vxo/lGiDVpiOCiU9bGPpsvuWmWMhlE4mpRyiOUjS?=
 =?us-ascii?Q?lpRwrFjbIZR1Gc/MtTI3tGmAsIslTHUytEtHBg78DISLqZSfqsjklN8ocQqW?=
 =?us-ascii?Q?foioH6+rWWBL+BFGfpCWiKIRq3q6YdHBsy+kFlysTyNf7LMy/IlTQKD3TddO?=
 =?us-ascii?Q?Rk4LBFYv0TUsWDdce82yZQnBfY/9wyEX9vBaaR5fU6C2SGfdauEMx1crku8o?=
 =?us-ascii?Q?jeCFrTNV4VXP2Kzgur73zgJLTbT0PdAq8AsM18pETmbPEp2bZtbqndVsU9aw?=
 =?us-ascii?Q?tYGMKXcOT7kuep3HC3CDEjx70GaEQWTvIQ3vsEPmGBGf/liTvjodRRh6KjbB?=
 =?us-ascii?Q?QDOOTp96SiZwNtQaEV8Nc/eBl5LS2gpns4QQBG8MtJrRgHqR1JpHWso/9pW/?=
 =?us-ascii?Q?ulwVtKmOJW1PKMYIP7p6ZrAWN0+y3Tu5OW5AAKZvmUbJ4Lf9+BoG/u1aGLAx?=
 =?us-ascii?Q?E50ZU1SV01T2WKrZcLsOs7YewOG4+pRn6fwapUdsO73zAc8Z49/Wg5KC3rhw?=
 =?us-ascii?Q?MG21BjLb2k76Fg+3Sjg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc7ffd4-1e0e-4fc9-2505-08db5560680c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:21:15.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e3c036nP+ozL2Wh/k8j4hg3gCLyUTkfED4Da8eIuwQO66uAKQgXRghps6akkEWGFBA19gxarXQx0cu5C22Ubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with
single IN and OUT endpoints, like mass storage devices, due to incorrect
ACTUAL_MEM_SIZE in ep_cap2 (32k instead of actual 18k). Implement dt
property cdns,on-chip-buff-size to override ep_cap2 and set it to 18k for
imx8QM and imx8QXP chips. No adverse effects for 8QXP C0.

Cc: stable@vger.kernel.org
Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
-cc stable
change from v1 to v2
- fixes warning from check-patch
- update dt-binding doc

 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index b32c2e199c16..030c273c8be4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
 			interrupt-names = "host", "peripheral", "otg", "wakeup";
 			phys = <&usb3_phy>;
 			phy-names = "cdns3,usb3-phy";
+			cdns,on-chip-buff-size = /bits/ 16 <18>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1

