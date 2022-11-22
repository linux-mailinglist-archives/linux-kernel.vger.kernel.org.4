Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB9633BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiKVL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiKVL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:58:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FC1D314;
        Tue, 22 Nov 2022 03:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqBb8lmY9FBaNJ5t+2IiNqOWLq+h49CEYfb5F3OFbH11bmzLSXpP/2fQLSRV7SzajyV1ODIzztHisGHLaXznEKaJ+hTm4IfBo0TsLPdIpHVR2zpfHQupRXHSGD5jWV3XIZWr0gFkDCRSIsryxM8eFvXkU3COSrY6L4MDrwsBl1kH+EGGdht94Ij5IgOmrFUn93V3BU//EVKGyd7CJDPt/CXD1NWKydbAN47CoiCQDahcX7PfM21iIJ8K7zi5ycYshhtWaLq3oyupS5+Qo5F6t09bVWMW7MuU4OOgGXdhEF1NMgkiYU8x8sV1K6oA05J5dxfsqh8JCu4++WKAkJyCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=DRHh/ZyBVqLr7vn7Xl4Ry0sGv0U3OC8qvPLeFjPNFB/1+r7VvrZXosutf5lMSkJbdidUEycNHSIdDMF0wSgFnt7mqPxfKC3dbW6A6JldNPZWPllBzP1gBKvT+Qa09g7/i3twUA1f2ANhd/in4YYeZHplFKLkQu38zopU3LvJlKYo4ia6DB0B9TCnNQxae7dMKPkBYPHVRLtNcb/JvBlIq7DBxfgTYbzgR3wCIq/R/1OmF3v27T7uaGtrPflQBkNAgIA/1L+HTPi5dIZQS0GgneY5+fHQaoVrcSnwIsYvKJnRbNSYLA6VwNe46FoIWCNglAILA0xSdeMAvu/3RUh0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=EQDZACWaOk+5h6TzjA66RiT1yBRPTKSahmHfnKv3ejhHL5/l5l/cIPEDcuI5OTAx27d8sErUSEbsbI/unFJy5XQ7izQh2I4ATku2A+kqcSN7jO+7V3FGGNb0XwOm9EGKrxJMwBUTbI6Kkn4qrguiT93/Xyz7OQueTqWKGCRs+YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by VI1PR04MB6879.eurprd04.prod.outlook.com (2603:10a6:803:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 11:58:26 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:58:25 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] tools: Add identifier for NXP UART BT devices
Date:   Tue, 22 Nov 2022 17:27:56 +0530
Message-Id: <1669118276-30278-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|VI1PR04MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 897a4f32-dc36-4bfd-efa6-08dacc80dc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCMNMYHwGJ2reQj414zs75v5OZggTRG4lbpddjvCJ/UwLd6bC73wogQglmRBPWT7tG/yg64y++3hCoern/UzU5S1NQxhD1zEwUrgkeOloMSKUtb3BM2domM7u04Xi8LDMery/uNIySdjio0p6/NXp+Y45pfeE7miT+CgcJNOdsKQ+6udUXhKTls01eBhX2rRBP6aItaDRr+IY2NyJv5KaugwXeP51df+ozY70cUak6jcqnl/1T6sZvSVsPkfR4YKbt9bGy4cNisxavBbyB2/taq+cAlodK8dR+6TSA4Vnr9ainP8y0zOm7iZFqjlftZ0tM0Tmov6qxDPRey5ZIj+W6TNkVbMS68pZopQVjV289P/ZMXzq73HhZaRgebwtPP6mboG2Lm1hiMA+IcuM5VtEQlJdwtnA71j2mUWa0qbyzlV7YbQ2ui4KZM5HPEftg7+M4qwyQXBnUljUEpnh/Uccf0szmoZPBZ3NrGmUxcj2oqUhCdhILkupBkat1aaOikM1MbEafwUs/q/YKNod0tn6JMXGLTey7r9NGrcOMeBU3EBe14LlHaa21hBxKyLXudoqZM2zdcsZjojIALsAYYYoK+r1r9pD+KESWtgSYxItJyTXcgeYAq7FwK+zU8MY+RwE7Pb0kWsIIyGHraj5LcnicEi9zUuBwd1JjizZMnZBAxWCEqTX/xQz086DPWFtzJdJkHbBPTWkXyt5Bb5kvkPEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(26005)(6506007)(6512007)(38100700002)(38350700002)(52116002)(186003)(4744005)(55236004)(66476007)(2616005)(2906002)(5660300002)(66946007)(478600001)(4326008)(41300700001)(316002)(8676002)(6636002)(6486002)(66556008)(8936002)(6666004)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmCwPssDwac/mYQccDrwXOEY1yT2kjxr7keqKQHCHTm02+FXyQ944A82TpHQ?=
 =?us-ascii?Q?9yLlO8cx+x1s59HFYqNvYR1GrtinoPqjGP/SFMUbA2XbZwNw01rb6E4bEu4y?=
 =?us-ascii?Q?Vhzrcn32tXoBvJf8QPRiOvv/C7OMYYe/IV7H9dBvTpvzjbHL2zQlBFx1HKYq?=
 =?us-ascii?Q?Us33u+wCO+lZOJGOJ8nAo4zN3lJRko13ZBz5q9O4yACutr5RP7ngajKp1t/F?=
 =?us-ascii?Q?0QL1fZzzeUJloLuTrfNXV9LmKctqGfY5P3mi1iJ4E9KyMe16fgkvvm4xT8x9?=
 =?us-ascii?Q?Vx1JIh5DdJ+uV4AgZRtPf8YAEBQ65PFEhNf0t3WEdMT6Q+3Z6nCqQ1EGcRiw?=
 =?us-ascii?Q?vfY0f4GMUTPdNUOJmY+57n5CXIA5JlkH2Qois8ytlA9NTh/usdL6bSqz1zeH?=
 =?us-ascii?Q?pzLx3rUmUJX+SnrtAHYJCfq+JykIf82gk6w8KwJy/D4vJVTS3+56595qJClR?=
 =?us-ascii?Q?mKPlr+90rNb+MtRoQT+/EYN82YjnTtYINmkJf3JmzF30afh14+sW1rnifsMm?=
 =?us-ascii?Q?2TEe4fIyBUXlkjq9uVTw4RK27BDgEtRHl7nzPn5c8bvci7mKKGJfMNIfgjwr?=
 =?us-ascii?Q?CUbqMDPcKGN+jhb74oSgymIThcheA9m0amB3G2liCBMU5ZeS52bY/sk1et2Q?=
 =?us-ascii?Q?r/TF1sXAIvQAeAY8RFwWjIl0rtGXZihmIlpZHTZ05T2UzwLVBMhdjtfdVZJd?=
 =?us-ascii?Q?Hl0UDmrhpdegHuUBlpKXlbdq/TjPQa1pr3Y2ZKJXWNd+OKKnGL7EX9ELSbdo?=
 =?us-ascii?Q?SMFFnDeuarR92EA1sRpLSX7sDfDWvyhkYPXuGpQj/wd6qxOOMrTdsml3O7Z7?=
 =?us-ascii?Q?V4yv2y1lcaoZVccCBkMRwL0hLncj98/0RkDYeqBalqLfz+zAE9pl0hWwvApY?=
 =?us-ascii?Q?i1JBhOPGVw6dc8nLEEBTZofBW3bW97MjrC7hlezhcR0AeiBpkhr7Hc18Wzc/?=
 =?us-ascii?Q?6sZgn93EQVOy8LdA+TAgxvfUMuq5L3SBRj8FTKkfcJT2721HWa52eQVTA+57?=
 =?us-ascii?Q?r8kGRefrXIBBt8nXBbrkrSDIanCsWYAXi7iMfoNuWdMz/MHhsEFEiFhSEPoV?=
 =?us-ascii?Q?eZgr8ZpJk8FUROYyZhW+HCNtMfuZm4IsiLo7NC16pjk4fDPQEoQtDuLKSrGZ?=
 =?us-ascii?Q?5N5Nw9w2tqz6uyGjGBcpTJXPxdKDc7RXfQcHMluBnt6SkKyD/8RZ5F+U1ixv?=
 =?us-ascii?Q?OuU4cjvqkkdH6whX5y21AjWp6sWEGR+qSJNAt2kSeObGy5rkbKOUgmiw5Rgz?=
 =?us-ascii?Q?pYDLyJxwJtdUG45aOUZU8Q/WV9s4HhGAuX7Q5ggbai1mEA6s5RjWSHufQNfs?=
 =?us-ascii?Q?AjYfljKqDn6/ukyHTYWfLy98whwdCTYcZxQ90o6DiG4566TxQy0FJFZUFLuO?=
 =?us-ascii?Q?5SvW+6chGVxS+d5wP+SBVtuM2+abAFYtPBPGbiyDOjKsCPeu3KRTebd4Yn5M?=
 =?us-ascii?Q?3zozouiSGDzEyWSdmvdLZbnY/7ALUTxeMnQlPT4Qab7Z3zD13anwRuRo1JKS?=
 =?us-ascii?Q?94I3/j4HsZsPGa0+wp2ECqHPDoHaEARuxdAGDvA5n/7kuTRLk/JPK0EYZtsj?=
 =?us-ascii?Q?Cdw2v5eSaJYcfjA1UNroN5eOIw8kEDo21dmMrJ+itnH33WEGKNaJZT9DY73E?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897a4f32-dc36-4bfd-efa6-08dacc80dc96
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 11:58:25.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bqk1sRDOs4vAW9xGIblFuhQ0wmI3GWSCgCWUZDT4XrRmgU+oB1+K0HeLxfpBinR6fDH7ObKq9BFT3XvIGdkUQt51cektwiagvRTPnkmcsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identifiers for hci_nxp to support NXP UART BT devices for btattach
---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be7..8a30c5b 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -212,6 +212,7 @@ static const struct {
 	{ "ag6xx", HCI_UART_AG6XX },
 	{ "nokia", HCI_UART_NOKIA },
 	{ "mrvl",  HCI_UART_MRVL  },
+	{ "nxp",   HCI_UART_NXP   },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 26c0d54..d62cabf 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -32,6 +32,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.7.4

