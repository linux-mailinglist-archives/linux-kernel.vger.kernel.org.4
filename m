Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12F4705280
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjEPPoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjEPPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:44:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102249C9;
        Tue, 16 May 2023 08:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfRWVQjko5PlPGEVDmjMErh6ed3sJRho1cBqwVE4rXWZe85g/dwCD101bnWB3iL2akDnnW4V18YslQP96z4WhbRAZ9pOi5BU6wQV0WEWhRlGzSZvBV5LCygREBZ+/ioiJwJ6UQRI5k0BuRyRde2xQ6cDW0FOwxP23jcw9TUaM5E+BPuk5nQcTfjnayZ6MfAJ6QpSdu9+9+vK7jbBpQGker6fgTUiFtBaG26X4xIggRgEDA6Gxvz3kQ6FQQNzVUSw7yhN18yHQVQcszAYxV5jTXT5Zlh7ApMYijdA8bHU9J5UWvoQ5dZaRv3x53bPEIch3MnNz/PbmzWf1u6PiRz81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEKcMWrG4j00kLtWuBqK7mtLn0v5TER+fvwsd9rWV+M=;
 b=PQhPmgpethAie1odyoEuuaXqZ3gO3OxcJZ0jHPfwfifNq+OLfZFeWtsthovYUaYUy/Sjsr/samedPTVZVwNIAaDa4kv6DxDbeyxvzEsI9nbzoBOvdtfqp8ElKZmNP9x9ctfOHk8EnAff2C0LaU91TQrvaVv/8tkQrhNC20wbxIOn58TOhZznhQ/n80yioVSNPP/BEQmm7EMPodetUbW8titnDU8nclnpU2ieZ4xX8eHpGzqMWebmU1b8Y5lWhSbswkdpWug3k17gf4ngJ8pDUwsghN1f2AMItEmLM2asxC+1aI8HA6YY+IJeA0h6g3fTkMPPyKdTMoAkn9IFrj71iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEKcMWrG4j00kLtWuBqK7mtLn0v5TER+fvwsd9rWV+M=;
 b=hGJFmHALRt7yfnZQEW8T2Uh7pDSOnkxlkXY1d82wgux8WEdSIc6SaCKLBr/wOs2KkpS3E8iq5PpAIzcOEh+KUyNoy7Cr1QT2WCCapkdjc9OpyVVSJ4Ri9jkdU85Qx2ZCyhpwJW+QvDE80lxA6sMkiimC3RjV1JPgayAqdBf4nic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:43:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:43:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 1/6] phy: cadence: salvo: add access for USB2PHY
Date:   Tue, 16 May 2023 11:43:24 -0400
Message-Id: <20230516154329.3155031-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516154329.3155031-1-Frank.Li@nxp.com>
References: <20230516154329.3155031-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: b1805898-f912-48be-91d8-08db56245ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CunfwBvdYxcO0kTQ1Xhx1gUlOhrBK9OPBVQtRKslHojOohHPIvT255zWczkEFWM/q7JAWxO1Kk3mfNz4EzPnH5mKrxVxU1Rb154CkW4TKYfmNdcpCyB5k1krVWqpU/SKIYsle2omIjXhNc04YvY8O/kIsUWyFX2/NuN1jmoyJzv7hzm5tBxVtsdBrEgokscxKSeEN4bfIZZ8kjbkSEKfXGhEZE5CglqU8H10xax7IuDJVAxjEdhGysy6Qjlbw91ZXWazuPBSiPFkm5UZEOjDzQxkemMVjFMeNYp87jQEDZ878Ug1e45EMb5Mu5qOp66VFjJYasXMS7pWtiL0eMhtQFvRhlew1AldF7P6w4q//tNj52qG0sC6pmwpZTrJyRJat6yxXL3gosoIP9ojBlTAtlz7qMIdmNYksOipCjtUO7TK2yyMNSb+mjb6AFR+4g0wCycqAGXxPsaMA9RXszHMq1Wm9zAqs2sEfo269AnPNHVTiTILjxlMFhJq2teKR7AFde9DJhIK+GDa6rYD1V8Sda7r4iIQGFbAwdNYmjSVIrbS3wra7DzpZ/pfrtu/Rh489a+PE4SSJT5vgfrKCwyMw0lAsDVqPre+A0ivEMOB2FWeXcwnBhpb3pEMqjCpN7lS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(316002)(86362001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dV15GRvKBYwQ8/alpAEsXZqQu9i8SrtN4CVj8jE67awW1m/JdabI+Vpn/3fY?=
 =?us-ascii?Q?8mVcqWPF529L7TiSfCfYyTnf+XnjR9AgMpW6KCbCoRhZAj4AAcArOyUh/9xL?=
 =?us-ascii?Q?cGl1uUtsmsMu3NrQMzHe5CaEVKjoNDmbt0+EdtIjwjlKrgz83s17tIxJIGCe?=
 =?us-ascii?Q?o3UsyaLpqj6iOT3sEyuHbLRNq10TtrQL00Opk7uTmP/hC6z8tFqoMnhW4QQt?=
 =?us-ascii?Q?pbkAw971JXiyBfysbT9e35W6qBU5/qdiBKBVdQMqXb7g8PdZ/AHtIg3cEDxD?=
 =?us-ascii?Q?TcQN4i8Tu38g1zKUvsLcKuDMF/6JX6J74a8Wcx7gB9oUStO0SpB+ZPFtOMn5?=
 =?us-ascii?Q?7GGLaqn0naLe7h4uqbJdoT1rmF5XU19U9cc5zYIRS6DvchUgE3nPSFc+PXNU?=
 =?us-ascii?Q?d1EoJ4xGzT+4ScD2H0/YLkNmJR4HcGlXZR5ozN/W67/BpFRzIVOhukXkNf95?=
 =?us-ascii?Q?VKnVHb+lGqnBLJNGlLnUzXWYUnAhYJ/0VrLn0uw6MMtJ8vRAV+DuoDLefH1l?=
 =?us-ascii?Q?llUX6DkNZd2iRknxpkXyRVHnQVVNuFg3QlOJM8IE55w8+1+8wFe1abYleEaU?=
 =?us-ascii?Q?nDh7C2YvDChGd1nOW8DInEaPu2YuyjdRcZL90uRXFKZVCBo47WpE9PAsNc3Q?=
 =?us-ascii?Q?lVYk4Nd4IJ1k/75iO9UG0YteaQFCmkpeq+Qd+DEacSXz50POPiB4iL9YuW3p?=
 =?us-ascii?Q?bUZQ+bSgD+y8bA1qttNnfaH35xTsbCYe2Bicf+Jk/aZEjTvQR3rZFzaiN6N0?=
 =?us-ascii?Q?p6+lpaZbsSSlnTpkPus0Ynu7BwjPn3f6lgIHxzce4PRd6m4Ahhy3nPgQLOKb?=
 =?us-ascii?Q?PdF5hohApiZ99ZiZ8L9bFKTO/i7JUjemIMmL81RiAe/NVxDzONnPelQG359a?=
 =?us-ascii?Q?pj8a7ulffkbwB6xbwnvQRxQoBDwGF0ERjIKH8dHNNiU7vdyK5zVeIbC11D99?=
 =?us-ascii?Q?xDgIzu8wylw3ijA5R9SrJLatvYU0tHQxcjvmxRTcQb0TTyoaA0eWW14sHLrD?=
 =?us-ascii?Q?5RdMkR60p1AWTf8UGvYiR7d1TXN3RekCi3f6JnTUiRLwpAavIXtKAmEQiu37?=
 =?us-ascii?Q?phxgoS1TfkMdA/HQfNmYmMa7MNrJMFPU5+VlX4kj3HtCKKvtB0FvSsG0XrAf?=
 =?us-ascii?Q?yjsYFgAXwy61VsFkJP3qQx5JFlVl6uklPRS4ltbDbOjBLhriHKsxz/hO15gK?=
 =?us-ascii?Q?dn6WYcd1GslAtOlali9ipMb8VSwOnXePVphHKqEDHPKfO0owcdCae0zoWZtC?=
 =?us-ascii?Q?sk/O7CS5Gg3Vj/VGguLwXeR2xDkMOrPAOFD+lGPDRtf7JPU2WNnf+j2/0A32?=
 =?us-ascii?Q?MvuwPgj1O5FRzpJwphJrQnUCuJ8fMegMJgr8PJ3EvuiESax/eEW7GpRERXV1?=
 =?us-ascii?Q?qY0SlNPwNk4Eb111FGGi1d3FKCq2qVq9hbRp9/2osxJEffh3JzU8zi+HI+A4?=
 =?us-ascii?Q?ML95wRp+JkgAYLOoiGtnCEkrtHM3xpCXS/OeXzq4C6j/K9VUCzGYekA8dk8b?=
 =?us-ascii?Q?G3EJ18a/zsbp4x9HqUCeMpUAe6HrHXC66jVxtuDJMspstbQ89vWrYXKnkB1L?=
 =?us-ascii?Q?yqU7BmVvmEUpbuPC0FlnkHiWo97alLROjbJLPSjO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1805898-f912-48be-91d8-08db56245ca8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:43:57.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtvGta3SAaSO76PohDZCjASqfkAv0xSM0H0q+QH6T/rpN51sZyO0szrxs4BARcz68LoBWiQNDYNlxByRnTD6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

There is an offset for USB2PHY in SALVO phy, add offset parameter for read
and write API to cover both USB2 and USB3 PHY control.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index e569f5f67578..06c5dbdb700e 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -15,7 +15,9 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
-/* PHY register definition */
+#define USB3_PHY_OFFSET			0x0
+#define USB2_PHY_OFFSET			0x38000
+/* USB3 PHY register definition */
 #define PHY_PMA_CMN_CTRL1			0xC800
 #define TB_ADDR_CMN_DIAG_HSCLK_SEL		0x01e0
 #define TB_ADDR_CMN_PLL0_VCOCAL_INIT_TMR	0x0084
@@ -109,16 +111,16 @@ struct cdns_salvo_phy {
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
-static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 reg)
+static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 offset, u32 reg)
 {
-	return (u16)readl(salvo_phy->base +
+	return (u16)readl(salvo_phy->base + offset +
 		reg * (1 << salvo_phy->data->reg_offset_shift));
 }
 
-static void cdns_salvo_write(struct cdns_salvo_phy *salvo_phy,
+static void cdns_salvo_write(struct cdns_salvo_phy *salvo_phy, u32 offset,
 			     u32 reg, u16 val)
 {
-	writel(val, salvo_phy->base +
+	writel(val, salvo_phy->base + offset +
 		reg * (1 << salvo_phy->data->reg_offset_shift));
 }
 
@@ -219,13 +221,13 @@ static int cdns_salvo_phy_init(struct phy *phy)
 	for (i = 0; i < data->init_sequence_length; i++) {
 		const struct cdns_reg_pairs *reg_pair = data->init_sequence_val + i;
 
-		cdns_salvo_write(salvo_phy, reg_pair->off, reg_pair->val);
+		cdns_salvo_write(salvo_phy, USB3_PHY_OFFSET, reg_pair->off, reg_pair->val);
 	}
 
 	/* RXDET_IN_P3_32KHZ, Receiver detect slow clock enable */
-	value = cdns_salvo_read(salvo_phy, TB_ADDR_TX_RCVDETSC_CTRL);
+	value = cdns_salvo_read(salvo_phy, USB3_PHY_OFFSET, TB_ADDR_TX_RCVDETSC_CTRL);
 	value |= RXDET_IN_P3_32KHZ;
-	cdns_salvo_write(salvo_phy, TB_ADDR_TX_RCVDETSC_CTRL,
+	cdns_salvo_write(salvo_phy, USB3_PHY_OFFSET, TB_ADDR_TX_RCVDETSC_CTRL,
 			 RXDET_IN_P3_32KHZ);
 
 	udelay(10);
-- 
2.34.1

