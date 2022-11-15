Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89617629419
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiKOJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiKOJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:20 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9222B29
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMuwIVJ8nM42QyISjMFzDLi4db7xyo/JvaToh/hUkDIZNrRee7rtyLKNKnYHR13neRk5/9VJ4Q0VbyGpXw1KRP5ky4HtIDwtyrNdkiB0uup+jEjiMGOjHbI2qB5+L7El+nxIC8l06sScayJn2j4VSTSz+4owijS5tbmIoNUdI9oOQZNDN5zzcftAYxdqwqZCGMClTao0ZLGNiMHAzhx3Mjus9P6LW4FHlKYx4dGA+yIJBb9iGTsDjel1p4xHxD89liKXM+jzjtW60a9WQ3I3GyQg7ZOLvwzHkIXdrUz5l1SqJUXlaA/AthWXWUloK441w/6fM58cPLsQfqlVDgIkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=SrEiAzfviofU/O+EGfBaVktKnQ5B0DU2tZ/RUNheJkSIndVj/AyHXHXnewyO4vyq2JzLU66a2nFqCNbt1uCtD947cC4A9JkLaKx9oVOBwW7depkrCJ3oHnzONypTWjdlIsVytRNfGVr5LgHSVwmFQtbvtjZrSaXltTbU6nT4xswnIHh3hGccK/fLvU/0SNjM1ETokwEFXedjWaylq2DmkoipSBbhkM6tFUoFlzSmx7EVIS8hFIJ5ozzNsTBTAAiBEda0XGa7LjPdZC3fgMYm8Y7+gnx1zrbXkItK3OsoVwC7y/0uj/hEhLaAHpnzBd1EXFCM4ypJxxFGIhFOrk53Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=RHYa4AVgYeP8Bb5xz9LU1vW4eBiJVQcGDgn+TIGK23Zhlbyk0kO7Lrmpe88pzkTdFSd+MfnlTKiNLhgqShpmlpQdaLkRdTHkipunxxu+fL0W7RSaTrHuj/c7tXjAkeMv/cQKs5SqWYaQt5ba4I27edUufCMDKSB01sFusU4E5a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:16:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 06/12] arm64: dts: imx8mp-evk: enable I2C2 node
Date:   Tue, 15 Nov 2022 17:17:03 +0800
Message-Id: <20221115091709.2865997-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ce593-9865-4784-252b-08dac6ea04f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMsfZjLS/YmwjOkzChHo2dSdErORFgbuMdz66cjv6ScyuzmlSnow4snjTtpYqeGNWbZiy0uxUcMUO0pCbmdcmQNtnnSG5AYwASZGoyQhLO0FboRKpEBM6OCY+u9qlWYnP+BE83kVPnFFi1ccm27VsXu5CIrO93IQNCUrDFyJ7kOTdBtWICSzSbgbGpjJcHXZi2+y/L1pzBJzrwA/WoX3/BGqXEl5vfZFpn5qgOQ6Ar9b48v188CFcywXQcwDY+7sjFnly89LGa2hfZKpv22TkYihzZL6Dmt+xFmIXZC00zIB6fMfWdKNEWChes+YT+Th+GZ08wUeZM+5KEVGjj19ESJ11Kcs+xnSnTX2HU9BEJEgpi9D5gIe5sMN042vBXtMebgfoqtHoE5o9SliKzimJTZWE5BU/3Fj+oBB0FT5fSsyzx3ztd1n69zWywU8QdRjVitP4u5d1Nz0SLIBckaqyqIUA04ZZ5cxbYFpE1IFvgFFBDVwa2MOAW4WD9phQLMLFL9Skzy32RhBsswPOnSDxE2nb/AbhW7J3v0JtSlBxBFrf6SwJbcN0+oTMs8r+OiWj82T41x5BNViBHz/i5z59gxiNgeVcN9jkYIYTRKA5fHeS823haXpfUgbP8i+LA3848Vah6QKQ4J0Hn3qHvL7hN8sIT/RVNuSc1xWJdeNaAvkC68IDvHwxTm4uDNTEsuoyBywF+GKL6MZlaE66J3gGidgE2u0T2B/k3Ey08LtrxaTCAMf0xpothn4kZKPFlB8Jlo/oIPpTLr9hYzF7fXqk/Q88B/TAFl0iv5JcNrbPMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(478600001)(6486002)(66476007)(54906003)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6CGi8d1zHNVEskEO//elZxrVtlPZLoPoqUEJupPdQO8KaVqjjqNxukLeoYQ?=
 =?us-ascii?Q?9cdlzmsxqfWFi/BVshNdVteo2P/s4mr92XImwy7CuUpux3NgqYLVFgSgx6PF?=
 =?us-ascii?Q?MilbEHVX2rVFwoM+V9gOOIWGgszIfQyRPKGhAS2WnDC9kHQG85rFbZUmKh3K?=
 =?us-ascii?Q?/NfU9brVFpfHRbePaCUvtgb3aTF1rLOpGRRtj9ZLw29bVxFBeYKQtxWYEoop?=
 =?us-ascii?Q?oFtzGM9jP1l1FeDCcVtxm2G09qk4yvEZkt9NHWtaMigHyPqrBH7PFQjZd5/P?=
 =?us-ascii?Q?V7FR1lixi+dR6NBMuGfEFeD56kzGGCIcZu89ZK8ApB0/lDlwnjPlk/sfaiHw?=
 =?us-ascii?Q?2Iz7OpxgH2nRqewku5SpZdYBdmBk2YGZ8/uqo+qBlTKnmiNmTw8vJbQ+GcQK?=
 =?us-ascii?Q?s05aaaemXYX5oYUT8SFJVKcdN6lOSsORUgQeslF4RBjOe5TKB1r4ZbJ/QbkG?=
 =?us-ascii?Q?Tz9D1v/uqZ4WimEB7Gu4xpz4jMyPqKYYSpOQgNBWfA38v+AYdn4GCpiuQg1c?=
 =?us-ascii?Q?y9EOKALoOG0JqEul8+I53WB8fzgGIqR73lTugCXa5uQtgaKJsu4G0wykPCwf?=
 =?us-ascii?Q?LzrqcFw8uuJt6JI+lcHI8A/aI6WkCCIaNCIP0kBDATt1KrfTwdEi1lSUfLHe?=
 =?us-ascii?Q?0kdxbgL+q0UL6h0n4Nvu5R+mkIH2+Pw32ms883g7nsbMzC0i8i/TK980gUJr?=
 =?us-ascii?Q?T18+IFi33RL1XxWCgchY6ekUaMS2kVEn2moyUAcgweBADaNTLqajoO8V7Kgk?=
 =?us-ascii?Q?7jx8oTg0MfkXs6IYzr18xVN7KTOKk1/ElbCc9sxwFqrV9zgd8xdFr1DBW4QF?=
 =?us-ascii?Q?zFIY1iVUoXrBYS+MVfRa8dHSoAg6QWiQO2x3ZIDSReSR9ooBg8McNTjCi9rv?=
 =?us-ascii?Q?wGSUizj2PWggpPDNPEYO0BWVjV+fqOzwUFK2w67Y6irapGYJ8tQ2Fe6zrLcd?=
 =?us-ascii?Q?YRX+DtaQFSjNGjfrSkfytf9VvuRKxAVegGsoP3FS8Xdgih2iHQtb8l7/2wHZ?=
 =?us-ascii?Q?w7MLg57XNNEvZuvNBA8NXs5uVIXwlvcJinlA67BlNXDALCZjW4r856WssSCi?=
 =?us-ascii?Q?Hv//hOBH5GIRFbZ7aTUrSleF08YYlaRw09UF6YDb7HLviuoTSCnSTpu3xeDn?=
 =?us-ascii?Q?o5dCOJ34+kadutpG3rfA3FrrYmu7fFhIRj46gJorHH+mdu22Q8sXL9ElrQtz?=
 =?us-ascii?Q?byqaXfeus8q4tw1J8go1AGYgaPoCHeAsWs59F8xDqRE7J3NYt7TXm1Kwr1ab?=
 =?us-ascii?Q?iWnyUQhg76PsSCAgagfPGzJ1ylxmpkSZOfBUYs0DvRfOvw9srDLxRT4D3OuF?=
 =?us-ascii?Q?gBL/E3YrssXhjN7KgCKuQ/GhuEwgKxahJ3PagIjllNcbeW07qdjF2Qoc4u9o?=
 =?us-ascii?Q?zAOyU1OS+r62LQ4AZitULx+6ohtEZn8C+O3YYaBsn/lxXMi164AOLji7W459?=
 =?us-ascii?Q?it/iTcscyO1PNfqyLJ/EqjF4s0aDBoCQZuDUBnAR9NA2/FXG02A06b5K6/WB?=
 =?us-ascii?Q?i2kOFqxW//TFNea+0PW00myVFtiILQM+MuULJoWYjXwNysdg0PN1Ho5cOPJx?=
 =?us-ascii?Q?9B3YohYAH8Tb3RZRj6hBJw2AqJr/Vb5NX/iC0P1O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ce593-9865-4784-252b-08dac6ea04f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:03.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tZDRMLSAMeaqNLpP6HLxVW8oRpHPwpxWflqudkM7k5bkokzIvZvgy53NkZdXKDOnmAQaaRnX40LFWhv7nsZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable I2C node for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 4164f69a89a6..878d4a752090 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -331,6 +331,13 @@ LDO5 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -589,6 +596,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-- 
2.37.1

