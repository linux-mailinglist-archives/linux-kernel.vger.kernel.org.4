Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEDF6C2D08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCUIuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjCUIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431C64616C;
        Tue, 21 Mar 2023 01:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVBgA0nqVYMyOvMPZjw3U7gUi2lrXbVPiw+878QkeEmu9gGW4mDid0TjlX/KwV1vW/6Z25lQYO/E8MI0xzagkTsirpEL78S3d0ptNbxEtsBYOoDlb8ysNAqdBNkzuZM9xp4UA36YD5tXTx/26KS/JG534yE7iV5jDLmqrnga7Wg5e6Z07z0BWdzSs9EyA9b+MS1u3ULqOKw8ohm+ZEq8Ku13NCgevZf9wsFqkdSbbRjDYKyrxC+cNWM+vkogmpNs/Ghz8R4YkRD6hNSTqZcGyEIrUnP+T+a1ptayoMOpOPbYc9rFd2GZXlCXOmmSknEMsmKSquJR6IhNlpR9MytTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=T7mA/d5COuYCk1qfKPUoKUISlC1T2EN9uIl81iFDRInnIClD+OQwwHuxGqg6KdaTdB6YFDUWAVhIZWtwvzu2ksRXiGqvm/OOhIKc4Uu3PgIhVJpheySmyu3EniQBtkgLDXxbDY2R5zRs+oad4+2A6P5e/vVaA+cUSEay/lg8zf6IO7+eWuPN7E80bX4ySZ/Y5iwIxDV9URbd4/SydyHQxn0qFn+IJLtM7mgNVZpZH7HD81tR9iA9+NlGER5L2il4KYP8hqSP/FsQJMs0HBc9Nt7Mo8bQl/AlU9TC8lcWIN4W8pINHjiDeiDKclD7JNfApdvcg7kC9LdsZPRikeixkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=Sf8/OvSmj9eMLFC8XfKvUQykD5IYfcvvmrtcFfEw1kPOL51ZqvrUwjmLpLxn6e5HVU99c2Yg3es/t3/X5lAT6znEC5UhPHbcN4Hja0XNHHZuGs1GFsxSr3egCcUByHLpTsWKfOH3yYU6XIVFPCKFDQJ7J6BVKrSIvV1rRw+NuW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 07/10] arm64: dts: imx8dxl: update usb compatible
Date:   Tue, 21 Mar 2023 16:52:10 +0800
Message-Id: <20230321085213.1624216-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cdcf52-98b4-4b58-f2be-08db29e8f04a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7S0WRljJsxyeac0kBIepdWRsvVZsfR3E3VdxgmDysK8TrsyXAndeElN4cSidhv6Jf3/TBSF2uPlrN3vwinFpOQUN9kvDcSgnnSfX+onPWAck1eRtbZ3gXnl0ZE6GBLpozcSq3034BztXJCmxV38ravMrmPwtQDrY+3uSN8rmnYYTa1Q3FWU9kwXDvCJmfh9f1jkwzNf2C8XXiThfGR9aIki7m9lssRVb4mFDRhwoEkiTz4StWUHXoJyBwgup3EXTWi2Go5un/bwOzCUBX1fd+ThBv5wQzeRss5kx5qjKx0GdG9mgXQP7Ibwzn4vZvUH1D6YgMphqFRaxNQmEyFjUSy18mFl674muk7hUesqs+EZlsNweCoMao/BGQSUyQ9d4uSh9zT5vPaqqenMx34clVza2fBKZ8y/TFCiBhD0zt06zqulHwXUrliSiEVQDpFPpXHA7J7iGVy7lPaildTt2tcCn9evpaZZJePRG0wszpoEns4EPAdj9OkAnmWvGbFJVWpuWRS7lZIEuDs/KL5gLrtLpSWeNGJbYFC1Fa971wPVItl23LlRdEv8fSsa3cTEaMlw6pYWdz+6BEu89zGTCIzgiquA4+NPR1LpQ7vmfbqWdGuPNQ2cnAgtypl3XUtgzygqeOPIvKRs/r9s2NzFk9ThBXYu9ocU+I//fw9/s44o84ydnWhkcmi8XgLsm5lF+xg92dBAp3YZbuVyEo4FRMNJyFh0uE32YHS3O7vjThc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199018)(2616005)(186003)(6666004)(6486002)(6512007)(6506007)(26005)(1076003)(52116002)(38100700002)(316002)(38350700002)(478600001)(2906002)(86362001)(15650500001)(83380400001)(7416002)(4326008)(8936002)(66556008)(5660300002)(41300700001)(8676002)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+E8mo69X9MYGcuMFYLFL7BJ+weFpT/PZNVuLrGdXmkgCDVlU3HZ+n6R0dpeZ?=
 =?us-ascii?Q?vs4hHL27Mg0bATs33Ip59T6YE0n6i2WeKgt99eLM4kXb40ma+CfsHcuq2lvT?=
 =?us-ascii?Q?EG04R/ow+F7XcISNj/fwKvwBtLcoF9sFEWO+ZZLy0FQbbt4vu/urELOEqSIl?=
 =?us-ascii?Q?XiRVVdwMKL0QmFDTUjUymOWf79W6KCJVhuOfAL8T6XU+cRveR6YLE+ciG0/S?=
 =?us-ascii?Q?NIJfYCFdjXGrfYQAMigrjuboyFytPXsgYoRJS9Jv1t0kv2ToqL2LzGXmsZxn?=
 =?us-ascii?Q?+5lxmqRPtDT/tal0fo4Z0SeuZ/HXUqjvRqPydwFYZPzsvfgES+ufy6qfKlEX?=
 =?us-ascii?Q?zhgxAIHMiv/4F/i9vBHvzVNfmhZoKDeA+5HQeakv7+0Kmwrcq2nTbx9302Dj?=
 =?us-ascii?Q?w4ev8B2ZJOHoWxOCGnsXF0Y5jUYgi3ShWb1+2reBUPWUpZTvHk9FKFkIbFMI?=
 =?us-ascii?Q?+plWImPsW3dGuHtmym1s9LlQnYKSdsoEwTgeA82yAQPcAnfa9q6PgnHb2oGC?=
 =?us-ascii?Q?IOgC/INeZ9CoFx5BX1+x9+ZhxwhPisrazwNsIlz9SK5suv1xoBS79IXM+EFm?=
 =?us-ascii?Q?r4pWqHw5qG+CJPdAzD6HstywqRQksW77n591jgL8A4ZwVjuSaTsKg6Y9qtUG?=
 =?us-ascii?Q?9dzB3t37K1J6WYhKl5nefaH6sPnYM3oTQYgNM8vygwJ9d72Nf3/cne+DyrSL?=
 =?us-ascii?Q?u+wwMGUMdbMXJOLZyIAZqEOlHDhiwRUKL8HYBXkdTV3v/pwYrwXJTF76nk8i?=
 =?us-ascii?Q?5vd4a+haxWbllobtfEwvl4IxPbwITJsoryGLOMaaDFB/NNeujTQkPJ7VLojb?=
 =?us-ascii?Q?nWCva9x5uuXpdbOLti9u34Ny3WGV2F7z5EvcdbzHzSHl5fcSeX5oNONRsBJK?=
 =?us-ascii?Q?KUsHx1qUZblTd6jqioK3dvIuhSlUNIpY397EgzNBjeHFMmnvMHvTVYsc2rav?=
 =?us-ascii?Q?aVK9DIfWwJZMK+xmYoGbgnpoA/5DdRt1limhuKdR83UZHsinps+VPXGBpsFx?=
 =?us-ascii?Q?3BCQNpCtQacw7s3JUayV65o2wn3N+eUrK3XFNaQBw8ZLuOi8a8X3YPikJKD5?=
 =?us-ascii?Q?MprPmKa/SlcBDXjNX/PwxdjmcARF0lW2/WqIpgD9kHJL2TUy8yff4Zdt1RlY?=
 =?us-ascii?Q?4EDsZzF6Hxg7oV0Bir2znTqAY91qgj5h5yQ4S9/lAfVZyA7M4ndlpq6nkIIw?=
 =?us-ascii?Q?n+eX+lm+Dmak0QsJx4xrbxvvqh4+R+ISEXjhxpGgYVIabfo/sjB1cadZcobR?=
 =?us-ascii?Q?UVdMTeldA4Un64AUgo/elFklIRlyjAFX41n3013u2d5s/QxB56twHubA7SlT?=
 =?us-ascii?Q?ln/Qqfs7ZahFMSSUagtvCZcqvySDCM1WZTdnLEjWmQ662S7+Ou7Y8KkMCxoO?=
 =?us-ascii?Q?pPaThsghf0KN5B9dXP6zHyqBpSCkRKDdVY/GAdFOOqt+GaQaX73N+7X/d8h6?=
 =?us-ascii?Q?39nXXHbZyiDaa0Kk/9VKoS8i8YamUQBjqEdNXASfTDBQnc4rv/yaWbZRoeJt?=
 =?us-ascii?Q?u3rqxbHfZ/h3Ie8HcyOmxhZwwFzZ0D/bmgEbqa/j8ng0mRbETS9ENZQk3Re3?=
 =?us-ascii?Q?8sSGh5dIJO0ac1GAPGwbL/4cmIhvuLE1/uE+png6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cdcf52-98b4-4b58-f2be-08db29e8f04a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:44.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVCCPBia0L2+nxxfImyvu0dXrjBA3mgDvT39C0UmarOCm1eRkfCNk8I6fkMS8sMzcth9/VJ39taqc2iHmAmjTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index ca195e6d8f37..88913869ae9c 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -34,7 +34,7 @@ eqos: ethernet@5b050000 {
 	};
 
 	usbotg2: usb@5b0e0000 {
-		compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb";
+		compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
 		reg = <0x5b0e0000 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
@@ -63,7 +63,7 @@ clk_dummy: clock-dummy {
 
 	usbmisc2: usbmisc@5b0e0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0e0200 0x200>;
 	};
 
-- 
2.37.1

