Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE66D1C72
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjCaJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjCaJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:32:49 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC911D842
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EblSntRxN1pZhHDlXn+BqWbiJNya1eR/rMzHfrgqtWvt907ygz0b+tm57Vdteo2q6Z77HtsofSm01r2LjxoL/avdkzjoIEae9tlOOhJa5McIBBk1DTEsIA0Ejvhj1yM3LOaTSg1NboPS8ya5t7dCeePJ7THERHBhRVvMkzAPigg7LXcokYa4+FzPf8f0bQv6I/chVLleQlpHnyNbe9GDO4wXqbX2T987Dcy3s4fu9+2Gr8GskWzxpcU6gCPLVCW1unNisupZn6s8y/17PH/yW6uJ/bPaJfLrde/UByhkCmkUsYPpFMfs7POZd3n6RhfdT6dUTAisfL0XjBF6n1RePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsYfAd40Z/+uVHwmyJPIO5QJuhGH8Q76wZV3jKMBGs4=;
 b=fe7g9pJfADphGLhNbnnlx4YG1v2gntA0830gmkW+SxI9oOEfwLcEKwlzhHFr5iOnj9oGQxiZ6RbGNPWfOmWFTajGJRcpEBoZ+VY31XcVN4cOtUtB1PEJUfMojfhbB0trZitewvo/bZLHObk8WXHHgPkSXVTTmOVPc2I/sgUmjhfiV69B2HLwNsgCW7QJ5D09PhYhXsL+AtN3kV7/3F/TGwfc/1GaX1nP7j69JmYQmODGgCB7nflIZ3uOyus5Havnc7ZfQNYw8HRUe8IVlOTZj52z1wL5KUjhfvbcYGayYfaTH461oiOEuruCwNoTLJbVw2W1HX6lQv4oKZAn+r+XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsYfAd40Z/+uVHwmyJPIO5QJuhGH8Q76wZV3jKMBGs4=;
 b=ZbV6S68kFr9f3Yxf5bLntpQTTjOfpaiJv9R1XTOXeFAtSdlRTXSSHeNFU4gx0XByCTG7yxg4aTrTWW9ZryXN1Q37E7F1NrDL7Z0rot1Nw0YdHyxeZ32iOuzQo+lAkhvknz+oW9EF30JRU/BFvKqvHA6Mo6amAv9hTAsHEHJwQZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 09:32:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 09:32:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: set LCDIF panic read hurry level
Date:   Fri, 31 Mar 2023 17:37:25 +0800
Message-Id: <20230331093725.2505035-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d621a3-a0d6-42ac-a2da-08db31cad1fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le5H24guGNJsn5keAWLqDwipP7mDT3xvJACfBvk25UBt1u5XR/ceCtiI4hXTJRJl8/J6sIEs+r9hnFDPwYn/3S9VBYWPnDMCa7k5sjgeYBc4Cthf2I9yOlSGudvQvChfdJ5tiqmMG48VX4FBGE3y/b3sno3qWywQat8Jb9l7KOUK/HHwuONFSanDxQ7uApuCSJQ0nqJ0gfSWo/yfziZ6ag0T9aKA8+SgnvO3Z5NH3KwpblHJ5Nnqq2VcoNQ/JcJGwGdiaG1ziWJBkN+KAcw1491UV7Cx+7owdL3tnFGpUalgHIoTENIvbiCWglVF+IavVPPybU91M90g8fPXpv6Yz3PiIbfivtOAQt+wBmujT+tigO+XNAV6OVbOC32gxuq1XX6oS+L1K1XBsdqAs4f5xKDgca00peHJ9N7hpz6f6qrSPiv5bEQLn28uJs1jq6QNUt/2KbuIy32+6wDwjJ4QI6zlSKeJVQqkqLy4CRl07MbR5v+POJF/stGQ6N9pFH/cp8KJb7ZpEaP0bHa8cTHgnRmx5LYsyFdkR9BrSjKSBWjNCdKHh+eVkcuzJTfRcmtdwEbM6Px/yLUWVPc5NiOzGgrIwMoY8li2sXqKxz/vtMTlZOkth2QgIZwPgA2YfxuIHc/4L0/ANUNOIkqzcCcWg4oDt3P87Te3lAG/CSwwS6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(186003)(478600001)(86362001)(316002)(8936002)(6486002)(52116002)(38100700002)(5660300002)(2906002)(38350700002)(66946007)(4326008)(66556008)(8676002)(66476007)(41300700001)(26005)(1076003)(6506007)(6512007)(6666004)(83380400001)(2616005)(21023001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2GAW3OqMu2AvYZTNl0w9/OI/lB/uP39eqJ7YRUu2POGohr54WGMJbJn1lj/f?=
 =?us-ascii?Q?JLbq0KZnQHHJKi1vRKW6xJDpE5EEWllaL1eW8fvEfjYg8k17zhXVaCzN81+M?=
 =?us-ascii?Q?Yr2o3hz9HuB0wCSeS6tLNTO9MSnNkvMhrRY3x1f5wx6f/QNG/js9KA8C/ejz?=
 =?us-ascii?Q?zjp6DgeLFMFFCGoOukF5AkctaDDRmn7t5pZmBCWkCGFtABmboJPYw3lZo/i2?=
 =?us-ascii?Q?5RFuefZUDVCRzx1ltXCVma/kTNccAfnK/p73zoI4p8uilwD2b72g904S/dnR?=
 =?us-ascii?Q?tiOWg0lfTQVPp/a0QLGaJg4HQae728MoHgvfHch/AZcX9xjqFOpxOMGTtT2W?=
 =?us-ascii?Q?QYWMem6dvNcjWjhoUtwjlkWymSnIy8PRHZjg440+Agp7UpGnK07oKqMEi1JJ?=
 =?us-ascii?Q?/sJ32rTsPWzczOM44ShtDevdzjpRdBHFAAC/pIoEKppteuu2+l3sbHYTIkin?=
 =?us-ascii?Q?ADSEyyz3g9FZTTx8q+kVzwzYVRV1UqGtb5qY1m84OFhiItMJu+2fyx+SYSJy?=
 =?us-ascii?Q?Xp5bcr0w0qlbYNa1XqGr2ABpYBH4q33Rlq0QynewI2QMnJvjulnePKpqDqS3?=
 =?us-ascii?Q?08VMl9Tg6oFZorEURqOfD0bJcPjG4sc3kzKL7miQdEnFcAgtLLW+/ftAjoYo?=
 =?us-ascii?Q?a2hxnk+bKbdvCoGyI8BIaxG73ZKQd1yFggQl4hpzXfAswsQfrYXRf9VJEXIv?=
 =?us-ascii?Q?WzZ7G09yLjgSU+MNLO3US2hhs5pn1GSmPkf7lKk07r4zHrXfhfxeCG5jDXs/?=
 =?us-ascii?Q?yTVlHRctgoKbx+BjqNfoneTaQzcmH6EKzZku0IURWW0hJH6iBzhgDA6zyjDl?=
 =?us-ascii?Q?Ysi2Vc9he73+kE95VOmlakvKw0bZu7zV9ybICNAzivVEigUlUgWY5/XGN9PV?=
 =?us-ascii?Q?H2VmZCS3pQuSLw1ebCA8MVYrbLEAagtwmRHY0OzTGdkOKKKvvWgwCQ+/qOcY?=
 =?us-ascii?Q?w93TsZI84kx/aVaUltonRriHU/2hLSDPncCRh7Eg0/a2UaYhMAUKS891jH66?=
 =?us-ascii?Q?pe6kOmcPAgH8lbk3aBuI5vUgIUzbS/37EufbXl+R0B74AtoNRbBomwJC5cb0?=
 =?us-ascii?Q?paRiAOEmzLZQ9rap7Y6QezJ2RG7jvc8FgZHnC/kxpgoG+kyYQ9hT0p1a1rP2?=
 =?us-ascii?Q?0tqii9GfVlJmlwbAVeT/YIlNKfK/pd9ChFO3Ae4hk9iaxb2v7m4bYD2Wn+UW?=
 =?us-ascii?Q?DjI0EyxduyHir41IezGHDSvtCrK+N5bdtNa2PZkhxSaYVnEDPwqNvngUaIv/?=
 =?us-ascii?Q?Je+Mj9db2LPf1FJ+JJG6OEmANJ5DYeWOgaheLlC/CmiKvNgqjqgEdpjNmqL5?=
 =?us-ascii?Q?j75dgf25KlQM4jftB2RMIQBF1Mvqt5uEgYuS1E/N8UlGQbPmM4az31JbVKDy?=
 =?us-ascii?Q?qqOiUvr9elG+pGvn8wA21QpLs1MhwQkCC+z5m25YeppdjoCCEok0r8yACpml?=
 =?us-ascii?Q?4cUGlUnkIQjPZjokabOrN3ia4u8JQAw2zdGrIv/wJS1D7t+DxIq8dsBJcakx?=
 =?us-ascii?Q?2oGxQnCXUl1hH8TBuO0+1ZodpMARHjTerxM2MS+mDu9IZIc0aMBmUW/1Iqgf?=
 =?us-ascii?Q?vfsFY9wpNK+jFEQK+iDeShK0Qergx1LTP2huRw7t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d621a3-a0d6-42ac-a2da-08db31cad1fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 09:32:18.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zonP+7FEEWJ78idpectScUf+2oV/HvSi/fBhEMD8vl9PZbkWwUFFvSoe/tkRruaSIveSBAmJjsJMtrtPGLxHYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The ISI block could signal a panic condition to use hurry level
priority. When the bandwidth is low for ISI, the hurry level priority
could be used to avoid FIFO overflow. The NXP downstream ATF/Linux
Kernel sets the hurry level as 7.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 If anyone has setup to help test, that would be appreciated.

 drivers/soc/imx/imx8m-blk-ctrl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 7c4045068804..eb13829e5dc1 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -690,6 +690,10 @@ static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
 #define LCDIF_ARCACHE_CTRL	0x4c
 #define  LCDIF_1_RD_HURRY	GENMASK(15, 13)
 #define  LCDIF_0_RD_HURRY	GENMASK(12, 10)
+#define ISI_CACHE_CTRL		0x50
+#define ISI_V_WR_HURRY		GENMASK(28, 26)
+#define ISI_U_WR_HURRY		GENMASK(25, 23)
+#define ISI_Y_WR_HURRY		GENMASK(22, 20)
 
 static int imx8mp_media_power_notifier(struct notifier_block *nb,
 				unsigned long action, void *data)
@@ -720,6 +724,15 @@ static int imx8mp_media_power_notifier(struct notifier_block *nb,
 		regmap_set_bits(bc->regmap, LCDIF_ARCACHE_CTRL,
 				FIELD_PREP(LCDIF_1_RD_HURRY, 7) |
 				FIELD_PREP(LCDIF_0_RD_HURRY, 7));
+
+		/*
+		 * Set panic write hurry level for ISI interfaces to
+		 * maximum priority to avoid bandwidth issue.
+		 */
+		regmap_set_bits(bc->regmap, ISI_CACHE_CTRL,
+				FIELD_PREP(ISI_V_WR_HURRY, 7) |
+				FIELD_PREP(ISI_U_WR_HURRY, 7) |
+				FIELD_PREP(ISI_Y_WR_HURRY, 7));
 	}
 
 	return NOTIFY_OK;
-- 
2.37.1

