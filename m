Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075873F57C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjF0HWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjF0HVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E712D68;
        Tue, 27 Jun 2023 00:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlRmUT6WppfN2YgDf8q5qTWXAT5r6tBNeZ2nPCEi4cZHksZoyf9pLlFxpg80JbhPxfA5+seZmaaKvr7Hh91dj7LrhJtQME/6hVFoijOOf2dLHyauY63kYc34Mr4r3lF98XrEcXHXshrod6bG8rluRMOXe9J8rAGqniJumXLTFdwKtV0wM1UHBGtdpXHw68FDES9R/ZtcK6FQyqnxHjufyy6Uugwmx1ZZBZOv/KJQU7kj8geKn7ecHCyDMcNks+XtsXgF79Pi8QP3kXEtu1Z1zGHNk9WpmV+FkMedd7mZ2RT6xCm0SeKx979erhQ40AJwEr7DUm8cg86NneUeqasAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1lPWSoUj+4n93p9hQ5/F/hpSG8PekLDoa5JhYpOPEk=;
 b=kP/2EIiHQNQe57BcLBcMhDJRpDl+Irzj53boshPtQhkYyzlGrzeClj19fKnSpx9HEgnQLh0pvvgWy6X4VcYH+fzxpTRjtR2aTOtpIx4egxonT7etnXVm76mC5KLiceptllx62+6Fj/4SGarj/8/vwNf9HfAXAkrjezJr/3F7A4LsAZkLsCGRSXGqCPEIR7zfJtjvvmEp+yFL+QEQorK3WaXoiXBxZ1Asw+DgpOnrWILMTDOkirlAPZ5FDTJFjDG/2Lceu3Yh6EaneF9fD9n9Bxx/pGTL4Nyf/hkRwfKNphSmVw7706p0NZKLyBWz78MzDuCTrTHYo02BZCWDQs4Xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1lPWSoUj+4n93p9hQ5/F/hpSG8PekLDoa5JhYpOPEk=;
 b=BUNqF7z9CTn4HGB0bGUoEMxpDrIQs4+pHOR/9fZ05AfShatGEIOwVFcFGjnn6e/bWOIX25lbeRaFLa7keHMEj3F3ykoz4pDieavd6owXnn6HY0ZwjytUPchEnw3UjAXHlQrmRg7u4pNavuKjyXaFlyIfSsp9rc9/6eruFL6RdBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:56 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:56 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 03/12] net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
Date:   Tue, 27 Jun 2023 10:18:44 +0300
Message-Id: <20230627071853.106215-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: a81d93db-4da1-4a53-efb1-08db76dee876
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIlaKAfrgqz73dV0MxFbJYLxiXkBvky8dwiq9xIJR8dkn86l3/cm1s/atul3Bkh4Wg4hILA+GB1kdvn7Nlz6L7/tisuxrTkRV+J5xdQhIc8nG1mik21UtyYpRBYLriDG+NpJ1DUE057x92zY/DSAG7s95LhPkfNGwdFkuk2G6CgJQMkbn09u1V8UoVCP9L4p6EoobH5kTA01Vm6y93yI+5OxLwuLSMSH0VWK1vBsVq0JshMqhBUjTW0o9Fj16zC2i+9ZIRAMpOih2L5PG7a3ks9QCFD4B7CQTewiisp6AEfz8UIuToNPK3obnsu8g0o2B+uQef07cA+W74WzLCkTcx90paOSZ/gs2G6ZyRzEoTUPNsKZxMy/7HyOsR2IaLTBZDTtQBR/eZODO8uRD5ltxFytNXs6cmfTTxJiizAcaMjfQXnHKWbUKxk7ELE5lQTJJA1pdoGuGF24OK372/buvt4Au8SKYxi6zJweH6zSdQiJ0FyHUc2GWV+3qbUTFH/3NRB5goMOlReA94hchpFsO06WdZ15YYcJxbwK7jU9UiarFMHqwEay5dpM8IsibQ4V6GC027okoW6StYIxbmKirwUIJLOejjqjj/jFt7Eczz/CZJZV8xxfeuTHSeliASm5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(30864003)(38100700002)(8676002)(66574015)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIJm0zuTOnLP7lX7Ibl7BMe9CHeDldDnKTIlI8kTQW83WCHek3Qp7QoeUrKi?=
 =?us-ascii?Q?Sh2hfUTC7QXeu6hh9x5IB5vk6G4fdGRCME6kcD8IOx341MumRPkBfJM4pLJ1?=
 =?us-ascii?Q?nz8gQnW7I5pSMipmwPQDUEPYqmg2/abcGbdAbobDqo4nOHzoHNQR7n7XXVD3?=
 =?us-ascii?Q?PgZLDFkyXE5Q4OsCJhKI+c+VuNFy22FAbtmOGlPVqhkQEJkkIdnEUx/DjFXQ?=
 =?us-ascii?Q?RoBF3y4OIB/uFny3VViZZyn719mng38FKZFc2Dvfmte1P0xkPDFSuqP/Ixnz?=
 =?us-ascii?Q?FF7CbuWADCWoKOBn6KMZQ21TN10yjZERhAbxJEpKJu1dxw7P4Y+8KUSUGMVW?=
 =?us-ascii?Q?1djwXNw33PkMHq2XQaXp9GCW7q9Tzo4vq5H0tPKMvVRWQY6UTpCOprq+0lAk?=
 =?us-ascii?Q?WrKNW7xIVWPnn2XghbDhKhFMphx3ws/QTkEJ193Glg7+yF/SjGlZJJb/h/c3?=
 =?us-ascii?Q?8P/feSSRqmh8swvb2CRqxqgEhJMkC6z+tzz4nspnt+BVtLk8L7vijSWfa4p9?=
 =?us-ascii?Q?y430NaaWh6P9IR2EGXa+K6b0DmAhEQCwKqqbRfsPTxBXH1hzoQ8NAYkJz1ZS?=
 =?us-ascii?Q?oJDnIFVH7CK6VaWd+4fXbrlU/44I19Pvv4FMhG3NZzA8WDNNj9r3iS36ix2+?=
 =?us-ascii?Q?u8Jl6zb130a+/UaYljPp2Ak7do+icHUbEbbr21M4Lx9v9DOD7pAlhOzD/zpM?=
 =?us-ascii?Q?/CtlRPq/5Wocut3UCkLFnKPlXCJLdx1PcuPjjv/OMT/IzmBKs9CLoGInmyuA?=
 =?us-ascii?Q?mcq7Q12MbZTVkYLMjyLtF79K4uurUOuhueUdkzmFQd3KvAVklTP4wKuTSgk7?=
 =?us-ascii?Q?JA5mR0P1hlT5itzmfYt70kpXCygoawhHxJD2Vbn0/+QVuRX/U13s2gSuzdh/?=
 =?us-ascii?Q?WLHzDrW1gF6hqBDIvWxR+CNRw09kJpkocp2Dw3OAEbeflWcyT4h0QRuyNsDv?=
 =?us-ascii?Q?C7gJseh7CJLSlw6xpa0vF1MZI7pxrZJ6uRNyjqGNG5VtqicVTlRRzsHSyKZq?=
 =?us-ascii?Q?ImIbHue1Xst/DyRDAWTTTExAiLYn5CuGnsssv25i6RugTFv9+NLzf4FwJzA2?=
 =?us-ascii?Q?pm1e2HsqzRLyZtRej74vPnuV+86xX35/Sgsx/uTtKIbPLoTr6/ZTcuh7y5O8?=
 =?us-ascii?Q?zVH1sKxPv5hNQTuGp+/3uyW0ezfJyVUPtPmq+T7IbTmg8svf99qS+hVuNnaP?=
 =?us-ascii?Q?k7oz4lTcK5sd3gv0f2s4R59YRpWqdPpnT89loWMw+s3aOXL34zp/WL6qWOpy?=
 =?us-ascii?Q?GFvNnM6urUGpz1UPoGxpK/kT1ogeZ0Ug8Uj+peyHtbsLVC5cBnU5FBpCp7ah?=
 =?us-ascii?Q?Tl2qbeirt0im8/qaOKLMXJZBcLAFmvxDCWkl5u3ipJ1NVPva37bggO5+OiPv?=
 =?us-ascii?Q?pxhdxfwRqMGNjWdntGs+uAbHN2V2M/FKNdvoHxBDLej+mrnes4QnuSkHj3dp?=
 =?us-ascii?Q?flVwoADiKw+8HK1VBuVWYhtbk6D/o8sH0HSb9nXmXvpr9rBibJMdv4YJhu88?=
 =?us-ascii?Q?SNXXF3q4KVbRLXVQiLJZgJwyyuSr1p9tOwHPfV8cXZ6J7ag0ibPjWyjGbFZl?=
 =?us-ascii?Q?44Hsq8DTrzAokhfX6x/00YI8/32FOejMX0JlFfw0P2bnoLCZmMZg12A3JsOC?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d93db-4da1-4a53-efb1-08db76dee876
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:55.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwznK6/JJLCLIwFuWBwcARQO1T+JQG5rLxah92UEBXrX+vKt9yMg+QqW7YwtKTRsPsZawEfhR7He5nG2qOipvPugyU7E5zAtCpsQJ2MRXKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between TJA1120 and TJA1103 the hardware was improved, but some register
addresses were changed and some bit fields were moved from one register
to another.

Introduce the nxp_c45_reg_field structure and its associated functions to
abstract the differences between the PHYs.

Remove the defined bits and register addresses that are not common
between TJA1103 and TJA1120 and replace them with reg_fields and
register addresses from phydev->drv->driver_data.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 572 +++++++++++++++++++++---------
 1 file changed, 405 insertions(+), 167 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f1f15a1b6cfc..162886cce08b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -41,10 +41,8 @@
 #define SQI_MASK			GENMASK(2, 0)
 #define MAX_SQI				SQI_MASK
 
-#define VEND1_CABLE_TEST		0x8330
 #define CABLE_TEST_ENABLE		BIT(15)
 #define CABLE_TEST_START		BIT(14)
-#define CABLE_TEST_VALID		BIT(13)
 #define CABLE_TEST_OK			0x00
 #define CABLE_TEST_SHORTED		0x01
 #define CABLE_TEST_OPEN			0x02
@@ -89,59 +87,18 @@
 
 #define VEND1_PTP_CONFIG		0x1102
 #define EXT_TRG_EDGE			BIT(1)
-#define PPS_OUT_POL			BIT(2)
-#define PPS_OUT_EN			BIT(3)
 
-#define VEND1_LTC_LOAD_CTRL		0x1105
-#define READ_LTC			BIT(2)
-#define LOAD_LTC			BIT(0)
-
-#define VEND1_LTC_WR_NSEC_0		0x1106
-#define VEND1_LTC_WR_NSEC_1		0x1107
-#define VEND1_LTC_WR_SEC_0		0x1108
-#define VEND1_LTC_WR_SEC_1		0x1109
-
-#define VEND1_LTC_RD_NSEC_0		0x110A
-#define VEND1_LTC_RD_NSEC_1		0x110B
-#define VEND1_LTC_RD_SEC_0		0x110C
-#define VEND1_LTC_RD_SEC_1		0x110D
-
-#define VEND1_RATE_ADJ_SUBNS_0		0x110F
-#define VEND1_RATE_ADJ_SUBNS_1		0x1110
 #define CLK_RATE_ADJ_LD			BIT(15)
 #define CLK_RATE_ADJ_DIR		BIT(14)
 
-#define VEND1_HW_LTC_LOCK_CTRL		0x1115
-#define HW_LTC_LOCK_EN			BIT(0)
-
-#define VEND1_PTP_IRQ_EN		0x1131
-#define VEND1_PTP_IRQ_STATUS		0x1132
-#define PTP_IRQ_EGR_TS			BIT(0)
-
 #define VEND1_RX_TS_INSRT_CTRL		0x114D
-#define RX_TS_INSRT_MODE2		0x02
+#define TJA1103_RX_TS_INSRT_MODE2	0x02
 
 #define VEND1_EGR_RING_DATA_0		0x114E
-#define VEND1_EGR_RING_DATA_1_SEQ_ID	0x114F
-#define VEND1_EGR_RING_DATA_2_NSEC_15_0	0x1150
-#define VEND1_EGR_RING_DATA_3		0x1151
 #define VEND1_EGR_RING_CTRL		0x1154
 
-#define VEND1_EXT_TRG_TS_DATA_0		0x1121
-#define VEND1_EXT_TRG_TS_DATA_1		0x1122
-#define VEND1_EXT_TRG_TS_DATA_2		0x1123
-#define VEND1_EXT_TRG_TS_DATA_3		0x1124
-#define VEND1_EXT_TRG_TS_DATA_4		0x1125
-#define VEND1_EXT_TRG_TS_CTRL		0x1126
-
-#define RING_DATA_0_DOMAIN_NUMBER	GENMASK(7, 0)
-#define RING_DATA_0_MSG_TYPE		GENMASK(11, 8)
-#define RING_DATA_0_SEC_4_2		GENMASK(14, 2)
 #define RING_DATA_0_TS_VALID		BIT(15)
 
-#define RING_DATA_3_NSEC_29_16		GENMASK(13, 0)
-#define RING_DATA_3_SEC_1_0		GENMASK(15, 14)
-#define RING_DATA_5_SEC_16_5		GENMASK(15, 4)
 #define RING_DONE			BIT(0)
 
 #define TS_SEC_MASK			GENMASK(1, 0)
@@ -152,18 +109,11 @@
 #define VEND1_PORT_PTP_CONTROL		0x9000
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
 
-#define VEND1_PTP_CLK_PERIOD		0x1104
 #define PTP_CLK_PERIOD_100BT1		15ULL
 
-#define VEND1_EVENT_MSG_FILT		0x1148
 #define EVENT_MSG_FILT_ALL		0x0F
 #define EVENT_MSG_FILT_NONE		0x00
 
-#define VEND1_TX_PIPE_DLY_NS		0x1149
-#define VEND1_TX_PIPEDLY_SUBNS		0x114A
-#define VEND1_RX_PIPE_DLY_NS		0x114B
-#define VEND1_RX_PIPEDLY_SUBNS		0x114C
-
 #define VEND1_GPIO_FUNC_CONFIG_BASE	0x2C40
 #define GPIO_FUNC_EN			BIT(15)
 #define GPIO_FUNC_PTP			BIT(6)
@@ -181,8 +131,8 @@
 #define MAX_ID_PS			2260U
 #define DEFAULT_ID_PS			2000U
 
-#define PPM_TO_SUBNS_INC(ppb)	div_u64(GENMASK_ULL(31, 0) * (ppb) * \
-					PTP_CLK_PERIOD_100BT1, NSEC_PER_SEC)
+#define PPM_TO_SUBNS_INC(ppb, ptp_clk_period) div_u64(GENMASK_ULL(31, 0) * \
+	(ppb) * (ptp_clk_period), NSEC_PER_SEC)
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
@@ -191,6 +141,21 @@ struct nxp_c45_skb_cb {
 	unsigned int type;
 };
 
+#define NXP_C45_REG_FIELD(_reg, _devad, _offset, _size)	\
+	((struct nxp_c45_reg_field) {			\
+		.reg = _reg,				\
+		.devad =  _devad,			\
+		.offset = _offset,			\
+		.size = _size,				\
+	})
+
+struct nxp_c45_reg_field {
+	u16 reg;
+	u8 devad;
+	u8 offset;
+	u8 size;
+};
+
 struct nxp_c45_hwts {
 	u32	nsec;
 	u32	sec;
@@ -199,7 +164,69 @@ struct nxp_c45_hwts {
 	u8	msg_type;
 };
 
+struct nxp_c45_regmap {
+	/* PTP config regs. */
+	u16 vend1_ptp_clk_period;
+	u16 vend1_event_msg_filt;
+
+	/* LTC bits and regs. */
+	struct nxp_c45_reg_field ltc_read;
+	struct nxp_c45_reg_field ltc_write;
+	struct nxp_c45_reg_field ltc_lock_ctrl;
+	u16 vend1_ltc_wr_nsec_0;
+	u16 vend1_ltc_wr_nsec_1;
+	u16 vend1_ltc_wr_sec_0;
+	u16 vend1_ltc_wr_sec_1;
+	u16 vend1_ltc_rd_nsec_0;
+	u16 vend1_ltc_rd_nsec_1;
+	u16 vend1_ltc_rd_sec_0;
+	u16 vend1_ltc_rd_sec_1;
+	u16 vend1_rate_adj_subns_0;
+	u16 vend1_rate_adj_subns_1;
+
+	/* External trigger reg fields. */
+	struct nxp_c45_reg_field irq_egr_ts_en;
+	struct nxp_c45_reg_field irq_egr_ts_status;
+	struct nxp_c45_reg_field domain_number;
+	struct nxp_c45_reg_field msg_type;
+	struct nxp_c45_reg_field sequence_id;
+	struct nxp_c45_reg_field sec_1_0;
+	struct nxp_c45_reg_field sec_4_2;
+	struct nxp_c45_reg_field nsec_15_0;
+	struct nxp_c45_reg_field nsec_29_16;
+
+	/* PPS and EXT Trigger bits and regs. */
+	struct nxp_c45_reg_field pps_enable;
+	struct nxp_c45_reg_field pps_polarity;
+	u16 vend1_ext_trg_data_0;
+	u16 vend1_ext_trg_data_1;
+	u16 vend1_ext_trg_data_2;
+	u16 vend1_ext_trg_data_3;
+	u16 vend1_ext_trg_ctrl;
+
+	/* Cable test reg fields. */
+	u16 cable_test;
+	struct nxp_c45_reg_field cable_test_valid;
+	struct nxp_c45_reg_field cable_test_result;
+};
+
+struct nxp_c45_phy_stats {
+	const char	*name;
+	const struct nxp_c45_reg_field counter;
+};
+
+struct nxp_c45_phy_data {
+	const struct nxp_c45_regmap *regmap;
+	const struct nxp_c45_phy_stats *stats;
+	int n_stats;
+	u8 ptp_clk_period;
+	void (*counters_enable)(struct phy_device *phydev);
+	void (*ptp_init)(struct phy_device *phydev);
+	void (*ptp_enable)(struct phy_device *phydev, bool enable);
+};
+
 struct nxp_c45_phy {
+	const struct nxp_c45_phy_data *phy_data;
 	struct phy_device *phydev;
 	struct mii_timestamper mii_ts;
 	struct ptp_clock *ptp_clock;
@@ -217,13 +244,86 @@ struct nxp_c45_phy {
 	bool extts;
 };
 
-struct nxp_c45_phy_stats {
-	const char	*name;
-	u8		mmd;
-	u16		reg;
-	u8		off;
-	u16		mask;
-};
+static const
+struct nxp_c45_phy_data *nxp_c45_get_data(struct phy_device *phydev)
+{
+	return phydev->drv->driver_data;
+}
+
+static const
+struct nxp_c45_regmap *nxp_c45_get_regmap(struct phy_device *phydev)
+{
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+
+	return phy_data->regmap;
+}
+
+static int nxp_c45_read_reg_field(struct phy_device *phydev,
+				  const struct nxp_c45_reg_field *reg_field)
+{
+	u16 mask;
+	int ret;
+
+	if (reg_field->size == 0) {
+		phydev_err(phydev, "Trying to read a reg field of size 0.\n");
+		return -EINVAL;
+	}
+
+	ret = phy_read_mmd(phydev, reg_field->devad, reg_field->reg);
+	if (ret < 0)
+		return ret;
+
+	mask = reg_field->size == 1 ? BIT(reg_field->offset) :
+		GENMASK(reg_field->offset + reg_field->size - 1,
+			reg_field->offset);
+	ret &= mask;
+	ret >>= reg_field->offset;
+
+	return ret;
+}
+
+static int nxp_c45_write_reg_field(struct phy_device *phydev,
+				   const struct nxp_c45_reg_field *reg_field,
+				   u16 val)
+{
+	u16 mask;
+	u16 set;
+
+	if (reg_field->size == 0) {
+		phydev_err(phydev, "Trying to write a reg field of size 0.\n");
+		return -EINVAL;
+	}
+
+	mask = reg_field->size == 1 ? BIT(reg_field->offset) :
+		GENMASK(reg_field->offset + reg_field->size - 1,
+			reg_field->offset);
+	set = val << reg_field->offset;
+
+	return phy_modify_mmd_changed(phydev, reg_field->devad,
+				      reg_field->reg, mask, set);
+}
+
+static int nxp_c45_set_reg_field(struct phy_device *phydev,
+				 const struct nxp_c45_reg_field *reg_field)
+{
+	if (reg_field->size != 1) {
+		phydev_err(phydev, "Trying to set a reg field of size different than 1.\n");
+		return -EINVAL;
+	}
+
+	return nxp_c45_write_reg_field(phydev, reg_field, 1);
+}
+
+static int nxp_c45_clear_reg_field(struct phy_device *phydev,
+				   const struct nxp_c45_reg_field *reg_field)
+{
+	if (reg_field->size != 1) {
+		phydev_err(phydev, "Trying to set a reg field of size different than 1.\n");
+		return -EINVAL;
+	}
+
+	return nxp_c45_write_reg_field(phydev, reg_field, 0);
+}
 
 static bool nxp_c45_poll_txts(struct phy_device *phydev)
 {
@@ -235,17 +335,17 @@ static int _nxp_c45_ptp_gettimex64(struct ptp_clock_info *ptp,
 				   struct ptp_system_timestamp *sts)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_LOAD_CTRL,
-		      READ_LTC);
+	nxp_c45_set_reg_field(priv->phydev, &regmap->ltc_read);
 	ts->tv_nsec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_LTC_RD_NSEC_0);
+				   regmap->vend1_ltc_rd_nsec_0);
 	ts->tv_nsec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				    VEND1_LTC_RD_NSEC_1) << 16;
+				    regmap->vend1_ltc_rd_nsec_1) << 16;
 	ts->tv_sec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				  VEND1_LTC_RD_SEC_0);
+				  regmap->vend1_ltc_rd_sec_0);
 	ts->tv_sec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_LTC_RD_SEC_1) << 16;
+				   regmap->vend1_ltc_rd_sec_1) << 16;
 
 	return 0;
 }
@@ -267,17 +367,17 @@ static int _nxp_c45_ptp_settime64(struct ptp_clock_info *ptp,
 				  const struct timespec64 *ts)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_NSEC_0,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_nsec_0,
 		      ts->tv_nsec);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_NSEC_1,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_nsec_1,
 		      ts->tv_nsec >> 16);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_SEC_0,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_sec_0,
 		      ts->tv_sec);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_SEC_1,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_sec_1,
 		      ts->tv_sec >> 16);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_LOAD_CTRL,
-		      LOAD_LTC);
+	nxp_c45_set_reg_field(priv->phydev, &regmap->ltc_write);
 
 	return 0;
 }
@@ -297,6 +397,8 @@ static int nxp_c45_ptp_settime64(struct ptp_clock_info *ptp,
 static int nxp_c45_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
+	const struct nxp_c45_regmap *regmap = data->regmap;
 	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
 	u64 subns_inc_val;
 	bool inc;
@@ -305,16 +407,18 @@ static int nxp_c45_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	inc = ppb >= 0;
 	ppb = abs(ppb);
 
-	subns_inc_val = PPM_TO_SUBNS_INC(ppb);
+	subns_inc_val = PPM_TO_SUBNS_INC(ppb, data->ptp_clk_period);
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_RATE_ADJ_SUBNS_0,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
+		      regmap->vend1_rate_adj_subns_0,
 		      subns_inc_val);
 	subns_inc_val >>= 16;
 	subns_inc_val |= CLK_RATE_ADJ_LD;
 	if (inc)
 		subns_inc_val |= CLK_RATE_ADJ_DIR;
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_RATE_ADJ_SUBNS_1,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
+		      regmap->vend1_rate_adj_subns_1,
 		      subns_inc_val);
 	mutex_unlock(&priv->ptp_lock);
 
@@ -358,21 +462,25 @@ static bool nxp_c45_match_ts(struct ptp_header *header,
 static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 			      struct timespec64 *extts)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+
 	extts->tv_nsec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				      VEND1_EXT_TRG_TS_DATA_0);
+				      regmap->vend1_ext_trg_data_0);
 	extts->tv_nsec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				       VEND1_EXT_TRG_TS_DATA_1) << 16;
+				       regmap->vend1_ext_trg_data_1) << 16;
 	extts->tv_sec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				     VEND1_EXT_TRG_TS_DATA_2);
+				     regmap->vend1_ext_trg_data_2);
 	extts->tv_sec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				      VEND1_EXT_TRG_TS_DATA_3) << 16;
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EXT_TRG_TS_CTRL,
-		      RING_DONE);
+				      regmap->vend1_ext_trg_data_3) << 16;
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
+		      regmap->vend1_ext_trg_ctrl, RING_DONE);
 }
 
 static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
 			       struct nxp_c45_hwts *hwts)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+	struct phy_device *phydev = priv->phydev;
 	bool valid;
 	u16 reg;
 
@@ -384,16 +492,18 @@ static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
 	if (!valid)
 		goto nxp_c45_get_hwtxts_out;
 
-	hwts->domain_number = reg;
-	hwts->msg_type = (reg & RING_DATA_0_MSG_TYPE) >> 8;
-	hwts->sec = (reg & RING_DATA_0_SEC_4_2) >> 10;
-	hwts->sequence_id = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-					 VEND1_EGR_RING_DATA_1_SEQ_ID);
-	hwts->nsec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				  VEND1_EGR_RING_DATA_2_NSEC_15_0);
-	reg = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_DATA_3);
-	hwts->nsec |= (reg & RING_DATA_3_NSEC_29_16) << 16;
-	hwts->sec |= (reg & RING_DATA_3_SEC_1_0) >> 14;
+	hwts->domain_number =
+		nxp_c45_read_reg_field(phydev, &regmap->domain_number);
+	hwts->msg_type =
+		nxp_c45_read_reg_field(phydev, &regmap->msg_type);
+	hwts->sequence_id =
+		nxp_c45_read_reg_field(phydev, &regmap->sequence_id);
+	hwts->nsec =
+		nxp_c45_read_reg_field(phydev, &regmap->nsec_15_0);
+	hwts->nsec |=
+		nxp_c45_read_reg_field(phydev, &regmap->nsec_29_16) << 16;
+	hwts->sec = nxp_c45_read_reg_field(phydev, &regmap->sec_1_0);
+	hwts->sec |= nxp_c45_read_reg_field(phydev, &regmap->sec_4_2) << 2;
 
 nxp_c45_get_hwtxts_out:
 	mutex_unlock(&priv->ptp_lock);
@@ -498,6 +608,7 @@ static void nxp_c45_gpio_config(struct nxp_c45_phy *priv,
 static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 				 struct ptp_perout_request *perout, int on)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 	struct phy_device *phydev = priv->phydev;
 	int pin;
 
@@ -509,10 +620,10 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 		return pin;
 
 	if (!on) {
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CONFIG,
-				   PPS_OUT_EN);
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CONFIG,
-				   PPS_OUT_POL);
+		nxp_c45_clear_reg_field(priv->phydev,
+					&regmap->pps_enable);
+		nxp_c45_clear_reg_field(priv->phydev,
+					&regmap->pps_polarity);
 
 		nxp_c45_gpio_config(priv, pin, GPIO_DISABLE);
 
@@ -541,16 +652,16 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 		}
 
 		if (perout->phase.nsec == 0)
-			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-					   VEND1_PTP_CONFIG, PPS_OUT_POL);
+			nxp_c45_clear_reg_field(priv->phydev,
+						&regmap->pps_polarity);
 		else
-			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
-					 VEND1_PTP_CONFIG, PPS_OUT_POL);
+			nxp_c45_set_reg_field(priv->phydev,
+					      &regmap->pps_polarity);
 	}
 
 	nxp_c45_gpio_config(priv, pin, GPIO_PPS_OUT_CFG);
 
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CONFIG, PPS_OUT_EN);
+	nxp_c45_set_reg_field(priv->phydev, &regmap->pps_enable);
 
 	return 0;
 }
@@ -725,6 +836,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
 						mii_ts);
 	struct phy_device *phydev = priv->phydev;
+	const struct nxp_c45_phy_data *data;
 	struct hwtstamp_config cfg;
 
 	if (copy_from_user(&cfg, ifreq->ifr_data, sizeof(cfg)))
@@ -733,6 +845,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 	if (cfg.tx_type < 0 || cfg.tx_type > HWTSTAMP_TX_ON)
 		return -ERANGE;
 
+	data = nxp_c45_get_data(phydev);
 	priv->hwts_tx = cfg.tx_type;
 
 	switch (cfg.rx_filter) {
@@ -750,27 +863,24 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 	}
 
 	if (priv->hwts_rx || priv->hwts_tx) {
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_EVENT_MSG_FILT,
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      data->regmap->vend1_event_msg_filt,
 			      EVENT_MSG_FILT_ALL);
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-				   VEND1_PORT_PTP_CONTROL,
-				   PORT_PTP_CONTROL_BYPASS);
+		data->ptp_enable(phydev, true);
 	} else {
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_EVENT_MSG_FILT,
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      data->regmap->vend1_event_msg_filt,
 			      EVENT_MSG_FILT_NONE);
-		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_PTP_CONTROL,
-				 PORT_PTP_CONTROL_BYPASS);
+		data->ptp_enable(phydev, false);
 	}
 
 	if (nxp_c45_poll_txts(priv->phydev))
 		goto nxp_c45_no_ptp_irq;
 
 	if (priv->hwts_tx)
-		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
-				 VEND1_PTP_IRQ_EN, PTP_IRQ_EGR_TS);
+		nxp_c45_set_reg_field(phydev, &data->regmap->irq_egr_ts_en);
 	else
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-				   VEND1_PTP_IRQ_EN, PTP_IRQ_EGR_TS);
+		nxp_c45_clear_reg_field(phydev, &data->regmap->irq_egr_ts_en);
 
 nxp_c45_no_ptp_irq:
 	return copy_to_user(ifreq->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
@@ -795,57 +905,79 @@ static int nxp_c45_ts_info(struct mii_timestamper *mii_ts,
 	return 0;
 }
 
-static const struct nxp_c45_phy_stats nxp_c45_hw_stats[] = {
-	{ "phy_symbol_error_cnt", MDIO_MMD_VEND1,
-		VEND1_SYMBOL_ERROR_COUNTER, 0, GENMASK(15, 0) },
-	{ "phy_link_status_drop_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_DROP_COUNTER, 8, GENMASK(13, 8) },
-	{ "phy_link_availability_drop_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_DROP_COUNTER, 0, GENMASK(5, 0) },
-	{ "phy_link_loss_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_LOSSES_AND_FAILURES, 10, GENMASK(15, 10) },
-	{ "phy_link_failure_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_LOSSES_AND_FAILURES, 0, GENMASK(9, 0) },
-	{ "rx_preamble_count", MDIO_MMD_VEND1,
-		VEND1_RX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
-	{ "tx_preamble_count", MDIO_MMD_VEND1,
-		VEND1_TX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
-	{ "rx_ipg_length", MDIO_MMD_VEND1,
-		VEND1_RX_IPG_LENGTH, 0, GENMASK(8, 0) },
-	{ "tx_ipg_length", MDIO_MMD_VEND1,
-		VEND1_TX_IPG_LENGTH, 0, GENMASK(8, 0) },
+static const struct nxp_c45_phy_stats common_hw_stats[] = {
+	{ "phy_link_status_drop_cnt",
+		NXP_C45_REG_FIELD(0x8352, MDIO_MMD_VEND1, 8, 6), },
+	{ "phy_link_availability_drop_cnt",
+		NXP_C45_REG_FIELD(0x8352, MDIO_MMD_VEND1, 0, 6), },
+	{ "phy_link_loss_cnt",
+		NXP_C45_REG_FIELD(0x8353, MDIO_MMD_VEND1, 10, 6), },
+	{ "phy_link_failure_cnt",
+		NXP_C45_REG_FIELD(0x8353, MDIO_MMD_VEND1, 0, 10), },
+	{ "phy_symbol_error_cnt",
+		NXP_C45_REG_FIELD(0x8350, MDIO_MMD_VEND1, 0, 16) },
+};
+
+static const struct nxp_c45_phy_stats tja1103_hw_stats[] = {
+	{ "rx_preamble_count",
+		NXP_C45_REG_FIELD(0xAFCE, MDIO_MMD_VEND1, 0, 6), },
+	{ "tx_preamble_count",
+		NXP_C45_REG_FIELD(0xAFCF, MDIO_MMD_VEND1, 0, 6), },
+	{ "rx_ipg_length",
+		NXP_C45_REG_FIELD(0xAFD0, MDIO_MMD_VEND1, 0, 9), },
+	{ "tx_ipg_length",
+		NXP_C45_REG_FIELD(0xAFD1, MDIO_MMD_VEND1, 0, 9), },
 };
 
 static int nxp_c45_get_sset_count(struct phy_device *phydev)
 {
-	return ARRAY_SIZE(nxp_c45_hw_stats);
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+
+	return ARRAY_SIZE(common_hw_stats) + (phy_data ? phy_data->n_stats : 0);
 }
 
 static void nxp_c45_get_strings(struct phy_device *phydev, u8 *data)
 {
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+	size_t count = nxp_c45_get_sset_count(phydev);
+	size_t idx;
 	size_t i;
 
-	for (i = 0; i < ARRAY_SIZE(nxp_c45_hw_stats); i++) {
+	for (i = 0; i < count; i++) {
+		if (i < ARRAY_SIZE(common_hw_stats)) {
+			strncpy(data + i * ETH_GSTRING_LEN,
+				common_hw_stats[i].name, ETH_GSTRING_LEN);
+			continue;
+		}
+		idx = i - ARRAY_SIZE(common_hw_stats);
 		strncpy(data + i * ETH_GSTRING_LEN,
-			nxp_c45_hw_stats[i].name, ETH_GSTRING_LEN);
+			phy_data->stats[idx].name, ETH_GSTRING_LEN);
 	}
 }
 
 static void nxp_c45_get_stats(struct phy_device *phydev,
 			      struct ethtool_stats *stats, u64 *data)
 {
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+	size_t count = nxp_c45_get_sset_count(phydev);
+	const struct nxp_c45_reg_field *reg_field;
+	size_t idx;
 	size_t i;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(nxp_c45_hw_stats); i++) {
-		ret = phy_read_mmd(phydev, nxp_c45_hw_stats[i].mmd,
-				   nxp_c45_hw_stats[i].reg);
-		if (ret < 0) {
-			data[i] = U64_MAX;
+	for (i = 0; i < count; i++) {
+		if (i < ARRAY_SIZE(common_hw_stats)) {
+			reg_field = &common_hw_stats[i].counter;
 		} else {
-			data[i] = ret & nxp_c45_hw_stats[i].mask;
-			data[i] >>= nxp_c45_hw_stats[i].off;
+			idx = i - ARRAY_SIZE(common_hw_stats);
+			reg_field = &phy_data->stats[idx].counter;
 		}
+
+		ret = nxp_c45_read_reg_field(phydev, reg_field);
+		if (ret < 0)
+			data[i] = U64_MAX;
+		else
+			data[i] = ret;
 	}
 }
 
@@ -884,6 +1016,7 @@ static int nxp_c45_config_intr(struct phy_device *phydev)
 
 static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 {
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
 	struct nxp_c45_phy *priv = phydev->priv;
 	irqreturn_t ret = IRQ_NONE;
 	struct nxp_c45_hwts hwts;
@@ -901,8 +1034,8 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 	 * The irq signal will be asserted until the EGR TS FIFO will be
 	 * emptied.
 	 */
-	irq = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_IRQ_STATUS);
-	if (irq & PTP_IRQ_EGR_TS) {
+	irq = nxp_c45_read_reg_field(phydev, &data->regmap->irq_egr_ts_status);
+	if (irq) {
 		while (nxp_c45_get_hwtxts(priv, &hwts))
 			nxp_c45_process_txts(priv, &hwts);
 
@@ -929,24 +1062,28 @@ static int nxp_c45_soft_reset(struct phy_device *phydev)
 
 static int nxp_c45_cable_test_start(struct phy_device *phydev)
 {
-	return phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_CABLE_TEST,
-			     CABLE_TEST_ENABLE | CABLE_TEST_START);
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
+				CABLE_TEST_ENABLE | CABLE_TEST_START);
 }
 
 static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 					 bool *finished)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
 	int ret;
 	u8 cable_test_result;
 
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_CABLE_TEST);
-	if (!(ret & CABLE_TEST_VALID)) {
+	ret = nxp_c45_read_reg_field(phydev, &regmap->cable_test_valid);
+	if (!ret) {
 		*finished = false;
 		return 0;
 	}
 
 	*finished = true;
-	cable_test_result = ret & GENMASK(2, 0);
+	cable_test_result = nxp_c45_read_reg_field(phydev,
+						   &regmap->cable_test_result);
 
 	switch (cable_test_result) {
 	case CABLE_TEST_OK:
@@ -966,7 +1103,7 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 					ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC);
 	}
 
-	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_CABLE_TEST,
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 			   CABLE_TEST_ENABLE);
 
 	return nxp_c45_start_op(phydev);
@@ -1005,6 +1142,28 @@ static int nxp_c45_check_delay(struct phy_device *phydev, u32 delay)
 	return 0;
 }
 
+static void nxp_c45_counters_enable(struct phy_device *phydev)
+{
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
+
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_LINK_DROP_COUNTER,
+			 COUNTER_EN);
+
+	data->counters_enable(phydev);
+}
+
+static void nxp_c45_ptp_init(struct phy_device *phydev)
+{
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1,
+		      data->regmap->vend1_ptp_clk_period,
+		      data->ptp_clk_period);
+	nxp_c45_clear_reg_field(phydev, &data->regmap->ltc_lock_ctrl);
+
+	data->ptp_init(phydev);
+}
+
 static u64 nxp_c45_get_phase_shift(u64 phase_offset_raw)
 {
 	/* The delay in degree phase is 73.8 + phase_offset_raw * 0.9.
@@ -1182,31 +1341,14 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_LINK_DROP_COUNTER,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_PREAMBLE_COUNT,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_PREAMBLE_COUNT,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_IPG_LENGTH,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_IPG_LENGTH,
-			 COUNTER_EN);
-
 	ret = nxp_c45_set_phy_mode(phydev);
 	if (ret)
 		return ret;
 
 	phydev->autoneg = AUTONEG_DISABLE;
 
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK_PERIOD,
-		      PTP_CLK_PERIOD_100BT1);
-	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_HW_LTC_LOCK_CTRL,
-			   HW_LTC_LOCK_EN);
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_TS_INSRT_CTRL,
-		      RX_TS_INSRT_MODE2);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
-			 PTP_ENABLE);
+	nxp_c45_counters_enable(phydev);
+	nxp_c45_ptp_init(phydev);
 
 	return nxp_c45_start_op(phydev);
 }
@@ -1266,11 +1408,107 @@ static void nxp_c45_remove(struct phy_device *phydev)
 	skb_queue_purge(&priv->rx_queue);
 }
 
+static void tja1103_counters_enable(struct phy_device *phydev)
+{
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_PREAMBLE_COUNT,
+			 COUNTER_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_PREAMBLE_COUNT,
+			 COUNTER_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_IPG_LENGTH,
+			 COUNTER_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_IPG_LENGTH,
+			 COUNTER_EN);
+}
+
+static void tja1103_ptp_init(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_TS_INSRT_CTRL,
+		      TJA1103_RX_TS_INSRT_MODE2);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
+			 PTP_ENABLE);
+}
+
+static void tja1103_ptp_enable(struct phy_device *phydev, bool enable)
+{
+	if (enable)
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PORT_PTP_CONTROL,
+				   PORT_PTP_CONTROL_BYPASS);
+	else
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_PTP_CONTROL,
+				 PORT_PTP_CONTROL_BYPASS);
+}
+
+static const struct nxp_c45_regmap tja1103_regmap = {
+	.vend1_ptp_clk_period	= 0x1104,
+	.vend1_event_msg_filt	= 0x1148,
+	.pps_enable		=
+		NXP_C45_REG_FIELD(0x1102, MDIO_MMD_VEND1, 3, 1),
+	.pps_polarity		=
+		NXP_C45_REG_FIELD(0x1102, MDIO_MMD_VEND1, 2, 1),
+	.ltc_lock_ctrl		=
+		NXP_C45_REG_FIELD(0x1115, MDIO_MMD_VEND1, 0, 1),
+	.ltc_read		=
+		NXP_C45_REG_FIELD(0x1105, MDIO_MMD_VEND1, 2, 1),
+	.ltc_write		=
+		NXP_C45_REG_FIELD(0x1105, MDIO_MMD_VEND1, 0, 1),
+	.vend1_ltc_wr_nsec_0	= 0x1106,
+	.vend1_ltc_wr_nsec_1	= 0x1107,
+	.vend1_ltc_wr_sec_0	= 0x1108,
+	.vend1_ltc_wr_sec_1	= 0x1109,
+	.vend1_ltc_rd_nsec_0	= 0x110A,
+	.vend1_ltc_rd_nsec_1	= 0x110B,
+	.vend1_ltc_rd_sec_0	= 0x110C,
+	.vend1_ltc_rd_sec_1	= 0x110D,
+	.vend1_rate_adj_subns_0	= 0x110F,
+	.vend1_rate_adj_subns_1	= 0x1110,
+	.irq_egr_ts_en		=
+		NXP_C45_REG_FIELD(0x1131, MDIO_MMD_VEND1, 0, 1),
+	.irq_egr_ts_status	=
+		NXP_C45_REG_FIELD(0x1132, MDIO_MMD_VEND1, 0, 1),
+	.domain_number		=
+		NXP_C45_REG_FIELD(0x114E, MDIO_MMD_VEND1, 0, 8),
+	.msg_type		=
+		NXP_C45_REG_FIELD(0x114E, MDIO_MMD_VEND1, 8, 4),
+	.sequence_id		=
+		NXP_C45_REG_FIELD(0x114F, MDIO_MMD_VEND1, 0, 16),
+	.sec_1_0		=
+		NXP_C45_REG_FIELD(0x1151, MDIO_MMD_VEND1, 14, 2),
+	.sec_4_2		=
+		NXP_C45_REG_FIELD(0x114E, MDIO_MMD_VEND1, 12, 3),
+	.nsec_15_0		=
+		NXP_C45_REG_FIELD(0x1150, MDIO_MMD_VEND1, 0, 16),
+	.nsec_29_16		=
+		NXP_C45_REG_FIELD(0x1151, MDIO_MMD_VEND1, 0, 14),
+	.vend1_ext_trg_data_0	= 0x1121,
+	.vend1_ext_trg_data_1	= 0x1122,
+	.vend1_ext_trg_data_2	= 0x1123,
+	.vend1_ext_trg_data_3	= 0x1124,
+	.vend1_ext_trg_ctrl	= 0x1126,
+	.cable_test		= 0x8330,
+	.cable_test_valid	=
+		NXP_C45_REG_FIELD(0x8330, MDIO_MMD_VEND1, 13, 1),
+	.cable_test_result	=
+		NXP_C45_REG_FIELD(0x8330, MDIO_MMD_VEND1, 0, 3),
+};
+
+static const struct nxp_c45_phy_data tja1103_phy_data = {
+	.regmap = &tja1103_regmap,
+	.stats = tja1103_hw_stats,
+	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
+	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
+	.counters_enable = tja1103_counters_enable,
+	.ptp_init = tja1103_ptp_init,
+	.ptp_enable = tja1103_ptp_enable,
+};
+
 static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.features		= PHY_BASIC_T1_FEATURES,
+		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
-- 
2.34.1

