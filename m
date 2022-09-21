Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28195BFFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIUOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIUOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:36:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7882D0F;
        Wed, 21 Sep 2022 07:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIDDMP6v0g6jxooS5+bBjtQ9v3cgIL3d5BjjXJK+ge5oE7DtJ4bnxbN9dkUSKC359vHxoKSfI5k7pA/BJVP9itaUN7viYNvmYKGOeA+NIgk7wG91zi1EIv/KtKhC9Bk3AaWV7uFh6V7Zegf6iSpA4PruCl0XFaXgXOsUppbrfbZ3bceVb1oDyNjC8ZuJlnLeDERe4GAyxbhhzUNzKfpxPTe80ZDloN43FBbSpPCacoKJK4O+4PAYAA+WwwSHhktGOe0p/S0NmgS3jc4Uam1d+fRNAObssmkUU6PPe+/8Rzk5m+dn0lv4kMNPAg0+xeJ/Xw5ZimHKpQEhuvW5+BrOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeFH/JduzzkRUeDYgR6MOX4ea9EHl7m6XyOCBSRlaB0=;
 b=QvTJqL6Kuuj/X/ZNLHLNd6SrlmcpKAYafi/CcXsNh6hOrw39Biuh/neHri+wB4dYe1t3hmTuIF2HGGi5JQnBnBjB3lGjIO13oMhZ/O4UNF3RSZxNXmfNPYqT9iV47NpksgB7IE+l81AbCctUvZtKe+Hj05VSp+UzSz1iJw/ju17vBEJxpcoS/+ipk+NwXhUq3KeOkrowZOoPPrO73HrQxxNI2Ou7zenquSTzpry/oJgcGFC8m1mMcfaDA1EQEhMdGRhtsOX6HurfweN3lk4iOcBo9C7ujuV6ZOggr/Sv9ihKP7SlHRNP59GJ7kkp++MVN0FyBxtlx7qcw0MVW7tuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeFH/JduzzkRUeDYgR6MOX4ea9EHl7m6XyOCBSRlaB0=;
 b=mVbjaONRnpoDMquRFEkPapLbVPTq2OsfxyKIbgq+N/RwmwAHR5qcDQyX6RjM+VMfeTvorYq+fYWK0i00PyNgxBg4nZlKYDf3HpU5Q0oRUP0NMrSYPsqj3pY7/fMO3eEAq/E/FKcDhQsAD6I6LGegQAM9MZVpIjhgyjdm7gWNu7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 14:36:18 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 14:36:18 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Date:   Wed, 21 Sep 2022 17:36:03 +0300
Message-Id: <20220921143603.175195-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0265.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::38) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6dd6b8-4483-4a1c-921b-08da9bdea4e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IXS/XYWjMmBf/BGbw5clvbhr0lI/T2SpA6LrJBBiuNI5kpTdIsQgULQEc/08aTtwvZ1vEy6Fb4He2Mf+w2Q/dAV9um7MaPn6tqTGFEX15pLvMy/2wE1U5U20/O1zozgbhe1iqkzbhzkrFFlFW3wkKDa/9HZD7CdWuC5wdPjAby9BN7Y6P4wJRRyZCgfoKClRty64bE7sn58G/0rDvMMiOU2wSXe36Vr2/RnhoroDy4Ov4dJ0gnaSkMxr3Pbk91uHUMd36Oc91E2cF5gNEmb+Yw/I5uXGSMWQo2SrNa225LdcoAYNmpSZTeLkZNL7FSyhMwDdILGmgmB9PaqW5RQMyNAl3M8YMLxynshne5y5XHvvgNlfyGGSMPe/5Vfs3/pQ4FLuJaKAxTvYewBa3LDYZIEJvvZLLYtYtdSMnUWsBEBstsquT+QlvxUmRAlrKGYI4NW8CYwAMOmhNWHxTtU+vjBUAhgeJnIKHNTfB1uROKBHfUOtx1kb+4VAmwiZTRrw0ccTXajdwGGHLWsfzQeTbr+Cv1KfTfJzvo6HuUAHuq2FZAOcakFyhTQLcH23hBtX0sV8CAoxmxVO+zQqzpsBFdJZkgjbWLQOGUHr/t/GBqhNkXOsZwTkPkpPIU1OoDzsnjsID2iZGw7kcLUSROLq4tHxQeHsF8phw3Rjh4FLOQ65VQ5Fs50EHrYujahhJoJ/asKAK4UbZ5m+RRRTHw+mIc1Wo1ydgRrPnLUzde2EU30fGNZfpWG7FrMCkV7UXdRGu54GdI5qbZUVJnHKsMaIzQ+rqWLbSNEmK79cg18XoDFWJrZncZXw9kJg4oFcyMDyCqTc8ln67/iI0I9WgfFEwoLXCr1v2/b0TIO5bbofxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(1076003)(86362001)(186003)(83380400001)(41300700001)(38350700002)(38100700002)(921005)(5660300002)(8936002)(2906002)(110136005)(66556008)(66476007)(30864003)(66946007)(8676002)(316002)(52116002)(6506007)(6666004)(6512007)(966005)(26005)(2616005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEMJNKxBQhPcjhV9gTBKhACo43mkGGlQHWJqbOd4fyEehkhOBpXaALV+FO9Q?=
 =?us-ascii?Q?Ndxfk/CuP8nUaZW3ez4qQ916vcR0AECBfb5NAnTYTm5xjAhjEF79eemE2Db7?=
 =?us-ascii?Q?5o6ARcZZA70fuN5LswgA5sWMRBgPw56FrV/UQnE1l/ILN7voOrJsZIJYNq2F?=
 =?us-ascii?Q?bHZZ1kzHn2oyAPdlLtyJa+grUJbJYwYonOleoc4TvtSkeT7+76a6OKD6gnGc?=
 =?us-ascii?Q?X8RsFc/iYcAsZIEYF6/JRhjm0DF3xUcSZMvge671jf95K3tbeFRecJXxWfmK?=
 =?us-ascii?Q?j/wZy202xQdRhhujnT47y26ijlrJUIKhYOSk9TfPk3kxObhYgeB2ige/tuiL?=
 =?us-ascii?Q?JUkDDjvpFsRkyuN6+cCyPgRMFOVMyRpJUn2VryPydFHCY7B5lu/liUzSwy8S?=
 =?us-ascii?Q?ykiCGcDM2VQQogSjbYa0dhid19lu3GowYxlBwbqnX13G1gUt3SPKccSNtHMW?=
 =?us-ascii?Q?dy4nXHIejyQsppXxRP30zUT7NSkUbuLEm0ClFAaU5tClFSPjKhbrpdkS9fGh?=
 =?us-ascii?Q?6hcoQUPx9oJJ/W3/DneQnts0fCyeBnyEi1LF4nLuQI2SN0LtkeM3r1gtLc0Q?=
 =?us-ascii?Q?Xf5qk5LkCPDeuu4Dpl4YPtxNgHH7/Mkh8KLpwLm2SmbcOWvnITY8oQ7zCvJn?=
 =?us-ascii?Q?l0CoBXjYtLsOMdjUQnUTFtV8lKzmndMjPMK/Bpp9aDtPXFRo7IuNDW+Y/52X?=
 =?us-ascii?Q?lcJCxIYO+jR61Q9fqGo5BlzieKz+ZkCWP6w5LgHPJNXRDS5JqIa6733WSrrE?=
 =?us-ascii?Q?h/PhB+EcFpjODmA9Ds4yoCW80ubTAkYJPJqJPrlX7gROlfmqfzHEKgpXSiZH?=
 =?us-ascii?Q?2tPfiwpv8d9VTunbeN9AuUGTKen90s+XSoRzMRSzk8l4omCjGAsPEHCH+MJW?=
 =?us-ascii?Q?dZc6W7ePdN9Rru/2cdCnGXVJnmzVE6r3XEFVXYGqcYeB6r3VUfSQEDqlxAxZ?=
 =?us-ascii?Q?WSq3kZiPQFMxU2Lv4J56y0ZFrLc2EOQCMCNFRfqCY90wMmooezocljX9eTfN?=
 =?us-ascii?Q?UBAvNiPiT4mnK+m2vu0tIsNnFkCMkbTXHH1sRW9iPrLjRHp7BbGe//6trTr5?=
 =?us-ascii?Q?gmD4UMWLxl2NTX00ltf6tj4umoNZBmkGVCDjGC5eLCRThLdRbw7iheKH9ojF?=
 =?us-ascii?Q?kP8wJqvzRLwQv08f9yU/cPSRMo069bZlwQThvETNlR5NBNiG85FUMC9NoikD?=
 =?us-ascii?Q?v0L7KVDN49/gRvIEgx/R5ESzy1joBFuuX3ZOjXd4UF73WaICvR9lxnQvrSSc?=
 =?us-ascii?Q?/Z4F3SRnwuLjdV2ZyrAnvawv7JH1n2BCtSYPUIb30lmGHxPFf3WZ/vOfsSPX?=
 =?us-ascii?Q?+zoVfxVAAPhNxAo9YrU01mlv8cu81CqjPqUv48j9g8ijr52QrNCopHm5wsAs?=
 =?us-ascii?Q?7nrd9KdhBRC6Ldat862+B+05jn10Q7rMg7TOVPW/zXDntgkVUVeUnYIwSOJn?=
 =?us-ascii?Q?HR52nDPbNSBulnYYG5d/eg4q2dvzPbS/jkTP083ZIKYKKkUTD9tbQxgwJvbQ?=
 =?us-ascii?Q?I9wjiiCNw9mtmy6SQKtqZ8xjNtqC6gju6EfQtDoQ2KGRz+FGbP8Juq7zgYL4?=
 =?us-ascii?Q?ADLwLk+2b6VFKwdYqw0zRWPS+XCetHFM4bFTqKiQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6dd6b8-4483-4a1c-921b-08da9bdea4e0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:36:18.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1JuBxdBWTNAEiNO7sTaq5523HtzyHU0g8qlxWPBVjOg7d+/LeSI4QALmPZKZCPnusUubrZXAN/kP7hErIlMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Sync defines with the latest available SCFW kit version 1.13.0,
may be found at the address below:

https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 294 ++++++++++++++++--------
 1 file changed, 198 insertions(+), 96 deletions(-)

Changes since v1: https://lore.kernel.org/all/20220915181805.424670-1-viorel.suman@oss.nxp.com/
	Two patches squashed into one in order to keep changes bissectable
	and compilable as suggested by Alexander Stein.

Changes since v2: https://lore.kernel.org/all/20220919113715.243910-1-viorel.suman@oss.nxp.com/
	Added two more defines in backward compatibility section in order to
	to avoid breaking ABI, so there is no need to change the driver
	anymore.

Changes since v3: https://lore.kernel.org/all/20220919132236.264382-1-viorel.suman@oss.nxp.com/
	Added missing defines in backward compatibility section:
	#define IMX_SC_R_VPUCORE_0             IMX_SC_R_ENET_1_A1
	#define IMX_SC_R_VPUCORE_1             IMX_SC_R_ENET_1_A2
	#define IMX_SC_R_VPUCORE_2             IMX_SC_R_ENET_1_A3
	#define IMX_SC_R_VPUCORE_3             IMX_SC_R_ENET_1_A4
	#define IMX_SC_R_UNUSED1               IMX_SC_R_V2X_PID0
	#define IMX_SC_R_UNUSED2               IMX_SC_R_V2X_PID1
	#define IMX_SC_R_UNUSED3               IMX_SC_R_V2X_PID2
	#define IMX_SC_R_UNUSED4               IMX_SC_R_V2X_PID3

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 1675de05ad33..1a8c025d77b8 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -13,30 +13,30 @@
  * never be changed or removed (only added to at the end of the list).
  */
 
-#define IMX_SC_R_A53			0
-#define IMX_SC_R_A53_0			1
-#define IMX_SC_R_A53_1			2
-#define IMX_SC_R_A53_2			3
-#define IMX_SC_R_A53_3			4
-#define IMX_SC_R_A72			5
-#define IMX_SC_R_A72_0			6
-#define IMX_SC_R_A72_1			7
-#define IMX_SC_R_A72_2			8
-#define IMX_SC_R_A72_3			9
+#define IMX_SC_R_AP_0			0
+#define IMX_SC_R_AP_0_0			1
+#define IMX_SC_R_AP_0_1			2
+#define IMX_SC_R_AP_0_2			3
+#define IMX_SC_R_AP_0_3			4
+#define IMX_SC_R_AP_1			5
+#define IMX_SC_R_AP_1_0			6
+#define IMX_SC_R_AP_1_1			7
+#define IMX_SC_R_AP_1_2			8
+#define IMX_SC_R_AP_1_3			9
 #define IMX_SC_R_CCI			10
 #define IMX_SC_R_DB			11
 #define IMX_SC_R_DRC_0			12
 #define IMX_SC_R_DRC_1			13
 #define IMX_SC_R_GIC_SMMU		14
-#define IMX_SC_R_IRQSTR_M4_0		15
-#define IMX_SC_R_IRQSTR_M4_1		16
-#define IMX_SC_R_SMMU			17
-#define IMX_SC_R_GIC			18
+#define IMX_SC_R_IRQSTR_MCU_0		15
+#define IMX_SC_R_IRQSTR_MCU_1		16
+#define IMX_SC_R_SMMU_0			17
+#define IMX_SC_R_GIC_0			18
 #define IMX_SC_R_DC_0_BLIT0		19
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_PERF			23
+#define IMX_SC_R_PERF_0			23
 #define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
 #define IMX_SC_R_V2X_MU_0		26
@@ -56,11 +56,14 @@
 #define IMX_SC_R_V2X_MU_3		40
 #define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_STM			43
 #define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
+#define IMX_SC_R_V2X			48
 #define IMX_SC_R_DC_1			49
+#define IMX_SC_R_UNUSED14		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -151,10 +154,10 @@
 #define IMX_SC_R_DMA_1_CH29		137
 #define IMX_SC_R_DMA_1_CH30		138
 #define IMX_SC_R_DMA_1_CH31		139
-#define IMX_SC_R_UNUSED1		140
-#define IMX_SC_R_UNUSED2		141
-#define IMX_SC_R_UNUSED3		142
-#define IMX_SC_R_UNUSED4		143
+#define IMX_SC_R_V2X_PID0		140
+#define IMX_SC_R_V2X_PID1		141
+#define IMX_SC_R_V2X_PID2		142
+#define IMX_SC_R_V2X_PID3		143
 #define IMX_SC_R_GPU_0_PID0		144
 #define IMX_SC_R_GPU_0_PID1		145
 #define IMX_SC_R_GPU_0_PID2		146
@@ -183,7 +186,7 @@
 #define IMX_SC_R_PCIE_B			169
 #define IMX_SC_R_SATA_0			170
 #define IMX_SC_R_SERDES_1		171
-#define IMX_SC_R_HSIO_GPIO		172
+#define IMX_SC_R_HSIO_GPIO_0		172
 #define IMX_SC_R_MATCH_15		173
 #define IMX_SC_R_MATCH_16		174
 #define IMX_SC_R_MATCH_17		175
@@ -250,15 +253,15 @@
 #define IMX_SC_R_ROM_0			236
 #define IMX_SC_R_FSPI_0			237
 #define IMX_SC_R_FSPI_1			238
-#define IMX_SC_R_IEE			239
-#define IMX_SC_R_IEE_R0			240
-#define IMX_SC_R_IEE_R1			241
-#define IMX_SC_R_IEE_R2			242
-#define IMX_SC_R_IEE_R3			243
-#define IMX_SC_R_IEE_R4			244
-#define IMX_SC_R_IEE_R5			245
-#define IMX_SC_R_IEE_R6			246
-#define IMX_SC_R_IEE_R7			247
+#define IMX_SC_R_IEE_0			239
+#define IMX_SC_R_IEE_0_R0		240
+#define IMX_SC_R_IEE_0_R1		241
+#define IMX_SC_R_IEE_0_R2		242
+#define IMX_SC_R_IEE_0_R3		243
+#define IMX_SC_R_IEE_0_R4		244
+#define IMX_SC_R_IEE_0_R5		245
+#define IMX_SC_R_IEE_0_R6		246
+#define IMX_SC_R_IEE_0_R7		247
 #define IMX_SC_R_SDHC_0			248
 #define IMX_SC_R_SDHC_1			249
 #define IMX_SC_R_SDHC_2			250
@@ -289,46 +292,50 @@
 #define IMX_SC_R_LVDS_2_PWM_0		275
 #define IMX_SC_R_LVDS_2_I2C_0		276
 #define IMX_SC_R_LVDS_2_I2C_1		277
-#define IMX_SC_R_M4_0_PID0		278
-#define IMX_SC_R_M4_0_PID1		279
-#define IMX_SC_R_M4_0_PID2		280
-#define IMX_SC_R_M4_0_PID3		281
-#define IMX_SC_R_M4_0_PID4		282
-#define IMX_SC_R_M4_0_RGPIO		283
-#define IMX_SC_R_M4_0_SEMA42		284
-#define IMX_SC_R_M4_0_TPM		285
-#define IMX_SC_R_M4_0_PIT		286
-#define IMX_SC_R_M4_0_UART		287
-#define IMX_SC_R_M4_0_I2C		288
-#define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_MU_0B		292
-#define IMX_SC_R_M4_0_MU_0A0		293
-#define IMX_SC_R_M4_0_MU_0A1		294
-#define IMX_SC_R_M4_0_MU_0A2		295
-#define IMX_SC_R_M4_0_MU_0A3		296
-#define IMX_SC_R_M4_0_MU_1A		297
-#define IMX_SC_R_M4_1_PID0		298
-#define IMX_SC_R_M4_1_PID1		299
-#define IMX_SC_R_M4_1_PID2		300
-#define IMX_SC_R_M4_1_PID3		301
-#define IMX_SC_R_M4_1_PID4		302
-#define IMX_SC_R_M4_1_RGPIO		303
-#define IMX_SC_R_M4_1_SEMA42		304
-#define IMX_SC_R_M4_1_TPM		305
-#define IMX_SC_R_M4_1_PIT		306
-#define IMX_SC_R_M4_1_UART		307
-#define IMX_SC_R_M4_1_I2C		308
-#define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_MU_0B		312
-#define IMX_SC_R_M4_1_MU_0A0		313
-#define IMX_SC_R_M4_1_MU_0A1		314
-#define IMX_SC_R_M4_1_MU_0A2		315
-#define IMX_SC_R_M4_1_MU_0A3		316
-#define IMX_SC_R_M4_1_MU_1A		317
+#define IMX_SC_R_MCU_0_PID0		278
+#define IMX_SC_R_MCU_0_PID1		279
+#define IMX_SC_R_MCU_0_PID2		280
+#define IMX_SC_R_MCU_0_PID3		281
+#define IMX_SC_R_MCU_0_PID4		282
+#define IMX_SC_R_MCU_0_RGPIO		283
+#define IMX_SC_R_MCU_0_SEMA42		284
+#define IMX_SC_R_MCU_0_TPM		285
+#define IMX_SC_R_MCU_0_PIT		286
+#define IMX_SC_R_MCU_0_UART		287
+#define IMX_SC_R_MCU_0_I2C		288
+#define IMX_SC_R_MCU_0_INTMUX		289
+#define IMX_SC_R_ENET_0_A0		290
+#define IMX_SC_R_ENET_0_A1		291
+#define IMX_SC_R_MCU_0_MU_0B		292
+#define IMX_SC_R_MCU_0_MU_0A0		293
+#define IMX_SC_R_MCU_0_MU_0A1		294
+#define IMX_SC_R_MCU_0_MU_0A2		295
+#define IMX_SC_R_MCU_0_MU_0A3		296
+#define IMX_SC_R_MCU_0_MU_1A		297
+#define IMX_SC_R_MCU_1_PID0		298
+#define IMX_SC_R_MCU_1_PID1		299
+#define IMX_SC_R_MCU_1_PID2		300
+#define IMX_SC_R_MCU_1_PID3		301
+#define IMX_SC_R_MCU_1_PID4		302
+#define IMX_SC_R_MCU_1_RGPIO		303
+#define IMX_SC_R_MCU_1_SEMA42		304
+#define IMX_SC_R_MCU_1_TPM		305
+#define IMX_SC_R_MCU_1_PIT		306
+#define IMX_SC_R_MCU_1_UART		307
+#define IMX_SC_R_MCU_1_I2C		308
+#define IMX_SC_R_MCU_1_INTMUX		309
+#define IMX_SC_R_UNUSED17		310
+#define IMX_SC_R_UNUSED18		311
+#define IMX_SC_R_MCU_1_MU_0B		312
+#define IMX_SC_R_MCU_1_MU_0A0		313
+#define IMX_SC_R_MCU_1_MU_0A1		314
+#define IMX_SC_R_MCU_1_MU_0A2		315
+#define IMX_SC_R_MCU_1_MU_0A3		316
+#define IMX_SC_R_MCU_1_MU_1A		317
 #define IMX_SC_R_SAI_0			318
 #define IMX_SC_R_SAI_1			319
 #define IMX_SC_R_SAI_2			320
-#define IMX_SC_R_IRQSTR_SCU2		321
+#define IMX_SC_R_IRQSTR_AP_0		321
 #define IMX_SC_R_IRQSTR_DSP		322
 #define IMX_SC_R_ELCDIF_PLL		323
 #define IMX_SC_R_OCRAM			324
@@ -373,33 +380,33 @@
 #define IMX_SC_R_VPU_PID5		363
 #define IMX_SC_R_VPU_PID6		364
 #define IMX_SC_R_VPU_PID7		365
-#define IMX_SC_R_VPU_UART		366
-#define IMX_SC_R_VPUCORE		367
-#define IMX_SC_R_VPUCORE_0		368
-#define IMX_SC_R_VPUCORE_1		369
-#define IMX_SC_R_VPUCORE_2		370
-#define IMX_SC_R_VPUCORE_3		371
+#define IMX_SC_R_ENET_0_A2		366
+#define IMX_SC_R_ENET_1_A0		367
+#define IMX_SC_R_ENET_1_A1		368
+#define IMX_SC_R_ENET_1_A2		369
+#define IMX_SC_R_ENET_1_A3		370
+#define IMX_SC_R_ENET_1_A4		371
 #define IMX_SC_R_DMA_4_CH0		372
 #define IMX_SC_R_DMA_4_CH1		373
 #define IMX_SC_R_DMA_4_CH2		374
 #define IMX_SC_R_DMA_4_CH3		375
 #define IMX_SC_R_DMA_4_CH4		376
-#define IMX_SC_R_ISI_CH0		377
-#define IMX_SC_R_ISI_CH1		378
-#define IMX_SC_R_ISI_CH2		379
-#define IMX_SC_R_ISI_CH3		380
-#define IMX_SC_R_ISI_CH4		381
-#define IMX_SC_R_ISI_CH5		382
-#define IMX_SC_R_ISI_CH6		383
-#define IMX_SC_R_ISI_CH7		384
-#define IMX_SC_R_MJPEG_DEC_S0		385
-#define IMX_SC_R_MJPEG_DEC_S1		386
-#define IMX_SC_R_MJPEG_DEC_S2		387
-#define IMX_SC_R_MJPEG_DEC_S3		388
-#define IMX_SC_R_MJPEG_ENC_S0		389
-#define IMX_SC_R_MJPEG_ENC_S1		390
-#define IMX_SC_R_MJPEG_ENC_S2		391
-#define IMX_SC_R_MJPEG_ENC_S3		392
+#define IMX_SC_R_ISI_0_CH0		377
+#define IMX_SC_R_ISI_0_CH1		378
+#define IMX_SC_R_ISI_0_CH2		379
+#define IMX_SC_R_ISI_0_CH3		380
+#define IMX_SC_R_ISI_0_CH4		381
+#define IMX_SC_R_ISI_0_CH5		382
+#define IMX_SC_R_ISI_0_CH6		383
+#define IMX_SC_R_ISI_0_CH7		384
+#define IMX_SC_R_MJPEG_0_DEC_S0		385
+#define IMX_SC_R_MJPEG_0_DEC_S1		386
+#define IMX_SC_R_MJPEG_0_DEC_S2		387
+#define IMX_SC_R_MJPEG_0_DEC_S3		388
+#define IMX_SC_R_MJPEG_0_ENC_S0		389
+#define IMX_SC_R_MJPEG_0_ENC_S1		390
+#define IMX_SC_R_MJPEG_0_ENC_S2		391
+#define IMX_SC_R_MJPEG_0_ENC_S3		392
 #define IMX_SC_R_MIPI_0			393
 #define IMX_SC_R_MIPI_0_PWM_0		394
 #define IMX_SC_R_MIPI_0_I2C_0		395
@@ -514,11 +521,11 @@
 #define IMX_SC_R_SECO_MU_3		504
 #define IMX_SC_R_SECO_MU_4		505
 #define IMX_SC_R_HDMI_RX_PWM_0		506
-#define IMX_SC_R_A35			507
-#define IMX_SC_R_A35_0			508
-#define IMX_SC_R_A35_1			509
-#define IMX_SC_R_A35_2			510
-#define IMX_SC_R_A35_3			511
+#define IMX_SC_R_AP_2			507
+#define IMX_SC_R_AP_2_0			508
+#define IMX_SC_R_AP_2_1			509
+#define IMX_SC_R_AP_2_2			510
+#define IMX_SC_R_AP_2_3			511
 #define IMX_SC_R_DSP			512
 #define IMX_SC_R_DSP_RAM		513
 #define IMX_SC_R_CAAM_JR1_OUT		514
@@ -539,8 +546,8 @@
 #define IMX_SC_R_BOARD_R5		529
 #define IMX_SC_R_BOARD_R6		530
 #define IMX_SC_R_BOARD_R7		531
-#define IMX_SC_R_MJPEG_DEC_MP		532
-#define IMX_SC_R_MJPEG_ENC_MP		533
+#define IMX_SC_R_MJPEG_0_DEC_MP		532
+#define IMX_SC_R_MJPEG_0_ENC_MP		533
 #define IMX_SC_R_VPU_TS_0		534
 #define IMX_SC_R_VPU_MU_0		535
 #define IMX_SC_R_VPU_MU_1		536
@@ -572,6 +579,105 @@
 #define IMX_SC_PM_CLK_PLL		4	/* PLL */
 #define IMX_SC_PM_CLK_BYPASS		4	/* Bypass clock */
 
+/*
+ * Compatibility defines for sc_rsrc_t
+ */
+#define IMX_SC_R_A35			IMX_SC_R_AP_2
+#define IMX_SC_R_A35_0			IMX_SC_R_AP_2_0
+#define IMX_SC_R_A35_1			IMX_SC_R_AP_2_1
+#define IMX_SC_R_A35_2			IMX_SC_R_AP_2_2
+#define IMX_SC_R_A35_3			IMX_SC_R_AP_2_3
+#define IMX_SC_R_A53			IMX_SC_R_AP_0
+#define IMX_SC_R_A53_0			IMX_SC_R_AP_0_0
+#define IMX_SC_R_A53_1			IMX_SC_R_AP_0_1
+#define IMX_SC_R_A53_2			IMX_SC_R_AP_0_2
+#define IMX_SC_R_A53_3			IMX_SC_R_AP_0_3
+#define IMX_SC_R_A72			IMX_SC_R_AP_1
+#define IMX_SC_R_A72_0			IMX_SC_R_AP_1_0
+#define IMX_SC_R_A72_1			IMX_SC_R_AP_1_1
+#define IMX_SC_R_A72_2			IMX_SC_R_AP_1_2
+#define IMX_SC_R_A72_3			IMX_SC_R_AP_1_3
+#define IMX_SC_R_GIC			IMX_SC_R_GIC_0
+#define IMX_SC_R_HSIO_GPIO		IMX_SC_R_HSIO_GPIO_0
+#define IMX_SC_R_IEE			IMX_SC_R_IEE_0
+#define IMX_SC_R_IEE_R0			IMX_SC_R_IEE_0_R0
+#define IMX_SC_R_IEE_R1			IMX_SC_R_IEE_0_R1
+#define IMX_SC_R_IEE_R2			IMX_SC_R_IEE_0_R2
+#define IMX_SC_R_IEE_R3			IMX_SC_R_IEE_0_R3
+#define IMX_SC_R_IEE_R4			IMX_SC_R_IEE_0_R4
+#define IMX_SC_R_IEE_R5			IMX_SC_R_IEE_0_R5
+#define IMX_SC_R_IEE_R6			IMX_SC_R_IEE_0_R6
+#define IMX_SC_R_IEE_R7			IMX_SC_R_IEE_0_R7
+#define IMX_SC_R_IRQSTR_M4_0		IMX_SC_R_IRQSTR_MCU_0
+#define IMX_SC_R_IRQSTR_M4_1		IMX_SC_R_IRQSTR_MCU_1
+#define IMX_SC_R_IRQSTR_SCU2		IMX_SC_R_IRQSTR_AP_0
+#define IMX_SC_R_ISI_CH0		IMX_SC_R_ISI_0_CH0
+#define IMX_SC_R_ISI_CH1		IMX_SC_R_ISI_0_CH1
+#define IMX_SC_R_ISI_CH2		IMX_SC_R_ISI_0_CH2
+#define IMX_SC_R_ISI_CH3		IMX_SC_R_ISI_0_CH3
+#define IMX_SC_R_ISI_CH4		IMX_SC_R_ISI_0_CH4
+#define IMX_SC_R_ISI_CH5		IMX_SC_R_ISI_0_CH5
+#define IMX_SC_R_ISI_CH6		IMX_SC_R_ISI_0_CH6
+#define IMX_SC_R_ISI_CH7		IMX_SC_R_ISI_0_CH7
+#define IMX_SC_R_M4_0_I2C		IMX_SC_R_MCU_0_I2C
+#define IMX_SC_R_M4_0_INTMUX		IMX_SC_R_MCU_0_INTMUX
+#define IMX_SC_R_M4_0_MU_0A0		IMX_SC_R_MCU_0_MU_0A0
+#define IMX_SC_R_M4_0_MU_0A1		IMX_SC_R_MCU_0_MU_0A1
+#define IMX_SC_R_M4_0_MU_0A2		IMX_SC_R_MCU_0_MU_0A2
+#define IMX_SC_R_M4_0_MU_0A3		IMX_SC_R_MCU_0_MU_0A3
+#define IMX_SC_R_M4_0_MU_0B		IMX_SC_R_MCU_0_MU_0B
+#define IMX_SC_R_M4_0_MU_1A		IMX_SC_R_MCU_0_MU_1A
+#define IMX_SC_R_M4_0_PID0		IMX_SC_R_MCU_0_PID0
+#define IMX_SC_R_M4_0_PID1		IMX_SC_R_MCU_0_PID1
+#define IMX_SC_R_M4_0_PID2		IMX_SC_R_MCU_0_PID2
+#define IMX_SC_R_M4_0_PID3		IMX_SC_R_MCU_0_PID3
+#define IMX_SC_R_M4_0_PID4		IMX_SC_R_MCU_0_PID4
+#define IMX_SC_R_M4_0_PIT		IMX_SC_R_MCU_0_PIT
+#define IMX_SC_R_M4_0_RGPIO		IMX_SC_R_MCU_0_RGPIO
+#define IMX_SC_R_M4_0_SEMA42		IMX_SC_R_MCU_0_SEMA42
+#define IMX_SC_R_M4_0_TPM		IMX_SC_R_MCU_0_TPM
+#define IMX_SC_R_M4_0_UART		IMX_SC_R_MCU_0_UART
+#define IMX_SC_R_M4_1_I2C		IMX_SC_R_MCU_1_I2C
+#define IMX_SC_R_M4_1_INTMUX		IMX_SC_R_MCU_1_INTMUX
+#define IMX_SC_R_M4_1_MU_0A0		IMX_SC_R_MCU_1_MU_0A0
+#define IMX_SC_R_M4_1_MU_0A1		IMX_SC_R_MCU_1_MU_0A1
+#define IMX_SC_R_M4_1_MU_0A2		IMX_SC_R_MCU_1_MU_0A2
+#define IMX_SC_R_M4_1_MU_0A3		IMX_SC_R_MCU_1_MU_0A3
+#define IMX_SC_R_M4_1_MU_0B		IMX_SC_R_MCU_1_MU_0B
+#define IMX_SC_R_M4_1_MU_1A		IMX_SC_R_MCU_1_MU_1A
+#define IMX_SC_R_M4_1_PID0		IMX_SC_R_MCU_1_PID0
+#define IMX_SC_R_M4_1_PID1		IMX_SC_R_MCU_1_PID1
+#define IMX_SC_R_M4_1_PID2		IMX_SC_R_MCU_1_PID2
+#define IMX_SC_R_M4_1_PID3		IMX_SC_R_MCU_1_PID3
+#define IMX_SC_R_M4_1_PID4		IMX_SC_R_MCU_1_PID4
+#define IMX_SC_R_M4_1_PIT		IMX_SC_R_MCU_1_PIT
+#define IMX_SC_R_M4_1_RGPIO		IMX_SC_R_MCU_1_RGPIO
+#define IMX_SC_R_M4_1_SEMA42		IMX_SC_R_MCU_1_SEMA42
+#define IMX_SC_R_M4_1_TPM		IMX_SC_R_MCU_1_TPM
+#define IMX_SC_R_M4_1_UART		IMX_SC_R_MCU_1_UART
+#define IMX_SC_R_MJPEG_DEC_MP		IMX_SC_R_MJPEG_0_DEC_MP
+#define IMX_SC_R_MJPEG_DEC_S0		IMX_SC_R_MJPEG_0_DEC_S0
+#define IMX_SC_R_MJPEG_DEC_S1		IMX_SC_R_MJPEG_0_DEC_S1
+#define IMX_SC_R_MJPEG_DEC_S2		IMX_SC_R_MJPEG_0_DEC_S2
+#define IMX_SC_R_MJPEG_DEC_S3		IMX_SC_R_MJPEG_0_DEC_S3
+#define IMX_SC_R_MJPEG_ENC_MP		IMX_SC_R_MJPEG_0_ENC_MP
+#define IMX_SC_R_MJPEG_ENC_S0		IMX_SC_R_MJPEG_0_ENC_S0
+#define IMX_SC_R_MJPEG_ENC_S1		IMX_SC_R_MJPEG_0_ENC_S1
+#define IMX_SC_R_MJPEG_ENC_S2		IMX_SC_R_MJPEG_0_ENC_S2
+#define IMX_SC_R_MJPEG_ENC_S3		IMX_SC_R_MJPEG_0_ENC_S3
+#define IMX_SC_R_PERF			IMX_SC_R_PERF_0
+#define IMX_SC_R_SMMU			IMX_SC_R_SMMU_0
+#define IMX_SC_R_VPU_UART		IMX_SC_R_ENET_0_A2
+#define IMX_SC_R_VPUCORE		IMX_SC_R_ENET_1_A0
+#define IMX_SC_R_VPUCORE_0		IMX_SC_R_ENET_1_A1
+#define IMX_SC_R_VPUCORE_1		IMX_SC_R_ENET_1_A2
+#define IMX_SC_R_VPUCORE_2		IMX_SC_R_ENET_1_A3
+#define IMX_SC_R_VPUCORE_3		IMX_SC_R_ENET_1_A4
+#define IMX_SC_R_UNUSED1		IMX_SC_R_V2X_PID0
+#define IMX_SC_R_UNUSED2		IMX_SC_R_V2X_PID1
+#define IMX_SC_R_UNUSED3		IMX_SC_R_V2X_PID2
+#define IMX_SC_R_UNUSED4		IMX_SC_R_V2X_PID3
+
 /*
  * Defines for SC CONTROL
  */
@@ -637,6 +743,10 @@
 #define IMX_SC_C_INTF_SEL			59
 #define IMX_SC_C_RXC_DLY			60
 #define IMX_SC_C_TIMER_SEL			61
-#define IMX_SC_C_LAST				62
+#define IMX_SC_C_MISC0				62
+#define IMX_SC_C_MISC1				63
+#define IMX_SC_C_MISC2				64
+#define IMX_SC_C_MISC3				65
+#define IMX_SC_C_LAST				66
 
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
-- 
2.37.3

