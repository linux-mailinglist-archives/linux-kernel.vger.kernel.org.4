Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E454A6C4224
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCVFXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCVFW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:22:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5CA2B63C;
        Tue, 21 Mar 2023 22:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxDawPdMiUujV0k/4GzFjYD/3TMHS3Lak8LW0UNcY+B+uv0F3T4KEvFcHI9IDaXyPTW3MZ4TtrZDMAkrOm4NIhL/9zWU5P5Of2CaNWrKmlHtyYcKAbxnPfBZGJWyINqMZZBDMKQStJBrMGnQ8G8tgn3yIXu1h1JHalKepMm7AAdu7M2zYO+DilHhKuR5ZHpbx034cPzBcKPcx65o+jH8gVgGleAs9HYkNyQsHWroPiosPfvn+jS/ltSCSE7az454+5SDqdzGN5fiK5+g2F7oEIzXZO4SsSi1Luc2yLq+/rfOkYOSE0Rja8mSP+BgqcuOxkHMLkSnv6SgRaaCPw8epA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJNo2IgufYk97JEDBsaiPrlY61EOTpQspqwn9wxkVZI=;
 b=keCw7tCUXOCQf0TizSnmsSmQSJYDSgkDb9WIv47Ei4BSk2qYSQ+kq02yfdqtOpE5V6WCmaVB4P1KfRCs3s+UJYR1vqpJqa/thOQj9drae86HR0EHuADVLOJa7pwCMjpcuJFez8uXvYfxRa5ym2+PJwsHMddzxMbYngTRg5Hl8GawFZEZpZqfstq5plGr7ouG7XYGiTvDtYNbjG5PBUy/98q5r9myhFFus4mqOHo8Kub5xJs28v+SpmN6UZ+IAHDsXzRkQFYYsl9JA1QnyCjBrTBApvZEsMkoKU2jzlIO2MGh4xjZMP8CvKfOh2/fRmS5i8XcDCBkFWYiVihJwQCABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJNo2IgufYk97JEDBsaiPrlY61EOTpQspqwn9wxkVZI=;
 b=NReCyQ8GKHLEZfcb1ccim085MbqOhTZZPJqg1t5V6yWIHU+yTf47l+c2o+fqjgUGvF8UZfLKFDCy6tE7und1DHxSs6tqngRxpfdWesBG+PpB7zkfZh5MH4637Y9ILR9+4Gq+WeWTbRWXTgbx2WSiWkmycgCojvMSmmOHqKH8FO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 08/10] arm64: dts: imx8dxl: drop #stream-id-cells for usb node
Date:   Wed, 22 Mar 2023 13:25:02 +0800
Message-Id: <20230322052504.2629429-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 2902aacb-623c-407d-b758-08db2a952bd6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zXOxeJEmJ99Ho2oUHFzzuImsppII1x2NOitYkgpSmGxv3rYgYlfD1WgCbAlJS7xDNH2LwX52jcbyS+rnzo+55Pc9rXRybK99HgmbTPyD73hu3eF2Jls0CBRs1ZHiX5AtbFp4k0wJLqpSqW7TQggD9P3FfPHRpuHuq0BiJ8jZny/Yz6zK2Vl3/GexiJw1elFT3HuRE1Xx/v41LDf7IOgjwNPUrbAI9x/gzlatGgQbkcJE/prrtKHU1UtDOvaliFeb0klTAMAmIXnHR5LfPSgT7gRfUbn9HopCsqAEjph7rHE76HEaWtfdCmNMkykG2pEZbcSbpLE/0G6fRLeIWijr6DKXp02LdK/y4s1yHyNJhhB0FS27CR/CMJ2ocxJCyF/i8nmLRv/y8Ntp1NSG8GnDpUASJA1N3HP34kpdBc0qfheEzgcBGMnFmBU/1WPWXYxVkE0nPeTJTgk1IDVOPOmZ4kdTCHu1Hng4IyEpUTI7CwMlxW/8R/89manU8jXIqZCWj6N2PE32RFjRRuReNR3LN9I3MyM5u8VRwGdJxDvxcCONckfBUuNUGkmmkz3UMr1oKE0T/hsslaOhW6XTlrIWkbuf6us3L9fHlvaBGuM7o7hqmE09A+y/eF2cJZV9V/EU/jLEbMfe1SH6Russo91bScdqXX/fLxKQ/lw71o1x03N9XDDoNLDzAgj9k5FTJ7pk/3qBik//kIN+M4yOXgqblYK2rJ5h8+j0b2mMogCjCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(4744005)(38350700002)(2906002)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewDvXY9T9bD8hr9qGDnJ5hxRx1VPjLjC2K1Yqba4XuP++vNuNiyPnDPaPp33?=
 =?us-ascii?Q?uhqoIbIIWV3bmxHNwt0n0nxwvNjTG2RDGaRvqS4D023XxiTmPOWIxSac8HGZ?=
 =?us-ascii?Q?alEJkWA0bhqiDvgc3a+IwB/q6s3116/rk5DCeii7sKHQnJ44lRwAcOgH1i2y?=
 =?us-ascii?Q?fM+E1emRmn/pvar6PsybLs3JcG5kMpW24v+rsHCfFWDYDaTovMY6lEwwxOBH?=
 =?us-ascii?Q?kp/ayX5vIu3y3Gfa29WmJI6gPulsLEKpuEu8jQZgNCF91d5rjDsvWv8oE9YN?=
 =?us-ascii?Q?YixXME8UtCntgAiqRCqoGRfHhFOkHCrdpdbrGkE0FbmcTOkuw+ux1ltOk5BF?=
 =?us-ascii?Q?vvmGPLcOG+v4LmxSPkAW/Vq19jKyZjhDf3oVBx63WzKD38CeOWox7ObraCN9?=
 =?us-ascii?Q?ctHn4ryHk8kUJfeLv1sgH4U/WOkE1W482cT0EFTiPOsufcNzjtKHP/cfgFi/?=
 =?us-ascii?Q?YeyXpFm22TdUfVIzxjT0ealtG1oK4uafuSulBKHKIu0K5fglU31A1BQ/yD9l?=
 =?us-ascii?Q?Wvyts/hR3/ZUzBs9N7vfyW6pTfFAhT4ATgsiHrKHmnNPTVJXmHFyR1Pgd6hY?=
 =?us-ascii?Q?eqR/ZfqT4OGDMOJOyKMYtKer+pzreb8OksFjvMd6WuQLwLl4VvQ8oes1egc/?=
 =?us-ascii?Q?tzIocNacpoo1X7P9mxfqDRx0QGARsf+W/eobcl8ii27iXbLPCEw+87/PJthE?=
 =?us-ascii?Q?w5GyXUrBQKjjMc3TbCNlrCeK4OLVLZa949He/s0WpkctywhkeBl5tw4nrf+I?=
 =?us-ascii?Q?5guOdZU74Z0ak1duUQPW0/QpQRB8qvNFgvJKZrwhdr0ylAHoHJkisWCSoSNx?=
 =?us-ascii?Q?0x1MA0WlN9dApgnX2LnTJOLXuTueErSBmhS9OD8NUOCFQTK7/cJNxw+K5eFT?=
 =?us-ascii?Q?UaL6503PqQ/T/6u+3jlkfg/Qrt2FLl2MGsIPul2s2s0oWPMKzqbx9ihKZOhG?=
 =?us-ascii?Q?A9V6f2UZys+5ZVvQ7EjG0GtAYsBQasmGHForRT6p9NUe2ss/Xcsbo6K7lMhw?=
 =?us-ascii?Q?EoP9oE8tkGeL5En8TEHqdVKagLeH/2ekjrWOfIhcg6ctH5D1Fkg8MIQVM44B?=
 =?us-ascii?Q?AjBLE4Pd/g5czpXzCCcxjILBySrc2hVY/GgNVQPbyDO3JJTzSIa1U4E0fgTH?=
 =?us-ascii?Q?XWGSLr2GBsnVfdypfkTFf+9rwlFaRNJ2aXy4nBO08na9duu+P9LJrf1Fcz/U?=
 =?us-ascii?Q?u0UZ+BKy+haINwiSrm6VJn8EaWMgssz0dxNx/DlqiUpAD6rhMQoOFnNP1SEc?=
 =?us-ascii?Q?u6rfj2NDY7ebNJ3FpAxplFRki+hheHK01LIh1f8vJoYuUuvM85uVAH0PF3ry?=
 =?us-ascii?Q?ItbXRc89KAoJ2lnMtBf65AdKZWr6H3XRoX3y3WNblfoEt5AXhM8qWbOBFFpw?=
 =?us-ascii?Q?H58/WVEYK3YRJZLdrExsvgMBGAYe81n1bSI5y/C00WiLFveOf2JcKFQjq4mE?=
 =?us-ascii?Q?S542g3yWYp5tOgrajrgxY25Udt7smUMW52vlYD9ejs1OZq9CeprjtXcTmFc2?=
 =?us-ascii?Q?FNjeO2DwMkMVJMQ5VSv+l70r+uU4GfiRUBghnOq/t7HfLAy+6nUEAkCr9uE+?=
 =?us-ascii?Q?Mc0fcFyCBdAQltXi8od6U7NSWUaYZP6BiXIqfy7s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2902aacb-623c-407d-b758-08db2a952bd6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:38.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh82nX3WRjBhtrqn+f84QYjUNcCNV5JKM8KLVomBGxSxNfUNEAkxLeEuN1Wumx+hL7cdiEkO9KDN35qGTiHR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no SMMU in i.MX8DXL, drop #stream-id-cells which
is for SMMU-v2.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 88913869ae9c..652493ae4bb5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -49,7 +49,6 @@ usbotg2: usb@5b0e0000 {
 		ahb-burst-config = <0x0>;
 		tx-burst-size-dword = <0x10>;
 		rx-burst-size-dword = <0x10>;
-		#stream-id-cells = <1>;
 		power-domains = <&pd IMX_SC_R_USB_1>;
 		status = "disabled";
 
-- 
2.37.1

