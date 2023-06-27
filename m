Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979973F56C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjF0HV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjF0HVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6591FCA;
        Tue, 27 Jun 2023 00:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFEWlO+kIJa3a64pen21/gfqaiJ3j9tcuODpuLXPJCF8edzJBGIBExpyUc+up9L1sIg+HFiRv4XZ7A4RdUw2ihngVBJd77/fOBLQrBU6z4QCeikMHu6zisJOBt24/J4JP7KnivWCSmeRtpEPt1LEulK+MgxfeUwn6kSF2Q7RYYhYS1IucN1Tff629X+WqhIJPDBlSEXekjtYf16Up+JdzodGrHM3tkD/HlS2nVgK9suYCH/I6i0OPIhXNsI7mSBtX6emCTGHTp+Bs9pSNzevyUzTq92pyki8zND75hDKLhBCZa94r7m6RF1jgWoIfMTmPFpkaHpPTXA4gS9v1Zyu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2nOYKhmPkPTNbx2/4hfbCT/8vW8K+MCzBmhWG+ZCgc=;
 b=A/auajKMMqgFNwVziG0IcS6S6t0IFE18Ng1HOCf/fjkieVFCB5pAhyxpsv0OCjfAyWXRDL85/3wCc38hnOHgx4WgbmXIpsntJc4y/VhEZvrKEEtGF+4Y1vx3KsIdX2dgCni5DK85ciVDoclLzNDD85Ea3/I1ozGr58TD2yFo95/uAkYPv4GU00EHAD3zVD4KwKwVf7H61Iu7EsEFybeH90gBB+LtyNTHoLVhhBl4RWe2jzShdY2bk+1N26oELC+I5yrhQgpVIX3EB9WANxIsAhPLFRMiFyp0J+F+mt+SdXshiHdGBD6bfbFFBNMqP3IxQmT6H7XtBit39x2k/sfhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2nOYKhmPkPTNbx2/4hfbCT/8vW8K+MCzBmhWG+ZCgc=;
 b=bEBYmoqY9zzDQGYhyh17pQ/qdiaxd4hlSIVN0sZGjQ0Ic7VOxA1IhhQSRIXehTlOn0D7VCvAdrzrinsarfXtRkF0ZIhEgqQjZFA6kgCU3cVGMXuEfcO14eVpPhKXiey0sO1Vs9G95bLzxJiFIChuG1epYaHAIxtCIIurAk8RCFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:55 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:55 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 02/12] net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
Date:   Tue, 27 Jun 2023 10:18:43 +0300
Message-Id: <20230627071853.106215-3-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 137049e2-7494-4b74-c29b-08db76dee7e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trvdfTYvac66ML3+BRZWIWU1y0Np4654u4T5fJ55u/AtmM2shqCHjlHHbDRQHR3GyvFMuuSzzwgUTR0L6enyat4yE1lBt1ahVcZR8kn8VvfEfdt45autHayVcdbWmZjQMCp1Rb60MbrI4LEAMoA9jkS7zdaIePz1tM70xCaG+Ao7z6h5utAIJ3PE9j/3WNzFSJxsxNhn1SdMlbbsyruXqkG3WwlNdh990vOsZVvt7102tUdqM/RFX9FnU6E7EMmXpDM20gyk8j9Mm2j+u/3fCWUwSUYE6yG3Bo4EVlPO2Ihc1QiWaqI7jHm+3IZVHxQjJyRoN2OCFkNsNCEy5VsAM1u0Oiq+asHsMWAQ0R+TYwCUq4PATmgiaCz6VKZrFplPG3kLOmmdBHmFkEBqU7B4MiwDpCUPe/LZxlIqmaj0ydRwUeoJZX4H9hGvJB1jiuf65NK7ihwnsjRnXD2oTiu6QxPQf8vLTpuL73YUT3u+B/dip7jskBlj/dv4IWCwKwdxrqKdEVn7dO3qsl009g1sE+mHe3AiycQZ/QHJru3fMhuMun/ufvgY7y3i/Ql0EndFfYsTcBL5OOTZbtQIBroaTy43xlZ9z9j83bduNgHHSoMcxQeIvBB3INip4g13sh9S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6y1a4UMR3HFkke5n4/KBjW3DqmjdU9Zc9x44DH56o06lxxWh2XOg/Ng22dN?=
 =?us-ascii?Q?5gyoybNY7oYyZo9P7qnY8eisHkdohlunAZWu2bnY6YkxZs0P0bZWpIfQpLlU?=
 =?us-ascii?Q?ASKPQRUaSYL8MeqORICLkQYFHJzzLf88gepYkACEs8AnbuoT1HWaltu74DMw?=
 =?us-ascii?Q?oYGuP9RJl1Y3P4VQ5NfFy9mubITD7bZmXIFD2bq+AeYZ+wu95CQPEA9dVvEX?=
 =?us-ascii?Q?8RXr8K+vqfhxp301fMK7Kt/b53EdHjR+IalZsmWWb6/h45ebWwEL3oPt9TWL?=
 =?us-ascii?Q?oOZeroQszL1RyKblOW7IFv3Y7FGTwTFi5Cl1KTSZYrFs1tpyTrCMnbHCa+o/?=
 =?us-ascii?Q?22KMJxWvLbWRexmwVa8n0RS0N3uriIm9wn1IBwz3IsFjjPzKlGCggf8JFHle?=
 =?us-ascii?Q?ygG0TDnbJs5edJ8cRbA+baQF+0jDGvbO4j0NZcKS+l4jrcay8hO2F+pNdjry?=
 =?us-ascii?Q?JM/bXMBAyADfAdW3KKhZyJJVNhK9YGuUnuyd0OcwC7J0G5Bz3LfW/M6Y5I2k?=
 =?us-ascii?Q?/3AcAqWgFLzjPRTC5/S5P6PJaHXDLSI+oqkXh+RMHrw1h8eVfbXeMCSFmlRw?=
 =?us-ascii?Q?tw4HF7hujFfMC8oMsNrJKV+AmWAVQna87U5nM6mWfLVF94R524JR2lpOtFJ6?=
 =?us-ascii?Q?P14pNQ+273FjRvFR/O4fJzeCwtWon38sU/+lVyObVNb4pH4mZZXW9Fz3QNXw?=
 =?us-ascii?Q?STf4wbFvS6uzrSe5mZJh3uOfWyf5qk0rpEjXmyLRaBHYOTIoJYXAU95frZwh?=
 =?us-ascii?Q?SdN2Ojkymk7rK9MlM4JjVPw+RyeyoUud/rsBfGkZ7zlbGchY9ojQjntWf5si?=
 =?us-ascii?Q?LDWxabPOQJBF7cjyDW3DFJW7vQyvY4MghaibbDcKWECMZ1bQYl24hlU19o8Y?=
 =?us-ascii?Q?1/fW491dfsg+qlvfko3T4sgIf9Phf9kr1l7m71/DTxxWlPgeOIfldJ/4qROe?=
 =?us-ascii?Q?NaOM29TYmuo0KM1SySZ5R6IUT3J8irTGJlmORUZcNHIxCrDTiJyG/Bw9L3/6?=
 =?us-ascii?Q?VCTvCZOAPM/wNt46jKph4Z3IWhz+tOKqyDh9Ev47GYwAegMMzKI8jY8h4Xru?=
 =?us-ascii?Q?bDC/hYSLznUkay3o+mkLdfQjpO5LmgtK6nuKCrvEHTTYHX0JnEKcRnKb8S5z?=
 =?us-ascii?Q?m36L6chSZ2fYNX/uu0/VMA/kXu6B2w4DPtVlittKKh9JsvdrQDYQckd1Ao6V?=
 =?us-ascii?Q?YpJW4tapzOiCcXqqvWu40Y6Pt4smLJHVMz9Fbm0KfS2lhWR59jQMKwzrE1SV?=
 =?us-ascii?Q?vprPUAO9bahvRr1rbrxPmbOOG9dcF74JJrGhMWZLtHeUgQ/E8UppSJR6Hy0t?=
 =?us-ascii?Q?s7udb06YPDMSFN/cadw3VMEwIGLw+D7tq6TlweY+Ko8Js6/Hp+waQUNj3mBW?=
 =?us-ascii?Q?qKRd0Z/WFNH2fykYkvq8hcvWlsJJd5TFdzfGIlBx3HSNecenl3fgEtT2I4ov?=
 =?us-ascii?Q?7XlhxgXKbNQdH6igTjdjTsjOLkM//iyStkFH7Ay51V7sVOyJX8/GqF9Rhr7V?=
 =?us-ascii?Q?4dizZD+xGT8TN3Fc89YLvGi5RxPIw7TgDXNG3vYJhx6ioWgl/MlcHlq9wfYL?=
 =?us-ascii?Q?HvbzFvG5oXh9P7X4koJNihrZGIVq2IoNz3VZapP43OzAqFsjZZZcQct72yRs?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137049e2-7494-4b74-c29b-08db76dee7e0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:54.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgwuR1E1TnfG7L5MaUcVPyBFsaBRuZPLaEtW3r1slLkOg4tQwQILVLuIZohCAuH/PJSscWMZ2y/Gf78GfZ6+EQrMII51ZxP6LAEoYt9Tils=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RX BIST frame counters from the PHY statistics.
In production mode, these counters are always read as 0.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 41b8af0547e4..f1f15a1b6cfc 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -81,9 +81,6 @@
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
-#define VEND1_R_GOOD_FRAME_CNT		0xA950
-#define VEND1_R_BAD_FRAME_CNT		0xA952
-#define VEND1_R_RXER_FRAME_CNT		0xA954
 #define VEND1_RX_PREAMBLE_COUNT		0xAFCE
 #define VEND1_TX_PREAMBLE_COUNT		0xAFCF
 #define VEND1_RX_IPG_LENGTH		0xAFD0
@@ -809,12 +806,6 @@ static const struct nxp_c45_phy_stats nxp_c45_hw_stats[] = {
 		VEND1_LINK_LOSSES_AND_FAILURES, 10, GENMASK(15, 10) },
 	{ "phy_link_failure_cnt", MDIO_MMD_VEND1,
 		VEND1_LINK_LOSSES_AND_FAILURES, 0, GENMASK(9, 0) },
-	{ "r_good_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_GOOD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_bad_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_BAD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_rxer_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_RXER_FRAME_CNT, 0, GENMASK(15, 0) },
 	{ "rx_preamble_count", MDIO_MMD_VEND1,
 		VEND1_RX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
 	{ "tx_preamble_count", MDIO_MMD_VEND1,
-- 
2.34.1

