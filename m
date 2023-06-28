Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C9740822
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjF1CRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjF1CRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:17:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B45E2D72;
        Tue, 27 Jun 2023 19:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VikRCQtFH6f5IabNmX3+/cIrZhlLal2b9e74qwTf6yndPsfwVZV+oBygsMdB+IUYzlwEQ1BY4OZixaGHtKeXLbrcAsxtZahA07Uhv/tthZbvw6OQctzAfBCwLhVoa6oQNRk+Pq6fcqrayfNgRGNSx6QOj98xYcR/s9nbTfGBT1S1XRqBfNUS2d3M86tf/H3Z61XxkplAq5dCqEv4Xd4FnyoW7uCEuT5JYKu8ExV2fanARcXY8k80uVlyNxXGzaflhPSoT782anTChHexVts/9+aLJWfR+HV+Co2a7cu97nBPbpPmY1oja0X16E3m85jQUJvPCoUJgUHEI5bh5m/xLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yZRszPr7szpVTdmejxYi7RIvr8oXSpWiSD9Bh/eWq8=;
 b=lKD+GAni5Xdq7Ukx3ui8iu70X542sGhz9k5FaRnd6aMIDvz5sHx2qvFJq3W2a9yTNDVT3pIUEnlquScRfzOb1kWCiWxXQU73z4tjjpITurqGLLwpWiJpcZX6+qhU7eqp3ILppCxJE5MLrvIAWN7J+oR0WAQ5gmVtQIuowfEwSdiFqwToFothVlVadRpyOOdg/FhRHrDEt9XUf2uzK0HBfYO+5gG8gvMT6YKIH4M3sQmKDhGaTNXZCBTr3jIkjg1D3+qDoKSIA+9kk3ZRSTpR2AudnLWxD2MgurVE3sqNYt27QLPufih0p2HObXd83uIFU/Szinnj03D2zlgQwsBsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yZRszPr7szpVTdmejxYi7RIvr8oXSpWiSD9Bh/eWq8=;
 b=KKIozlLVpD/n350xOfFhi/KW4Mw3f00gEmqjfyJKynAgdWeLNnXziJ/g1ucMUHmFsR/mtPzbtx9t0i66gRaxYIPanq8MYW2ysxQwbdnuIlt0I2iho9s6QLgzvOp2+rCXEJb04Z1sReAol4hyIJnTr1YZBls3CdyGgyU8ua6mNY6P/1/Icj6W0r3s7JBFpcrmnmq/pvsrAcbkoDWyDDKS85Uw1TBaswwWOLLU4w2O02tuG7WMFDU1MzxTAayjp1hnVg/gD2rU6SG5e0HV52YUuIM0uPtccNv4kFGYCrCokVo6wJlmAqQMv7MbGc16xCn5GhJh7naQ0E1SIrozrO14jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SEYPR06MB6131.apcprd06.prod.outlook.com (2603:1096:101:dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:16:55 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Wed, 28 Jun 2023
 02:16:55 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        You Kangren <youkangren@vivo.com>,
        Simon Horman <simon.horman@corigine.com>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3] Remove unnecessary conditional statements
Date:   Wed, 28 Jun 2023 10:16:46 +0800
Message-Id: <20230628021647.28655-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:404:a::31) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SEYPR06MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: c30dc363-7e8c-4e70-5be9-08db777dbe02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxTTs1rfpc3fBB1VXMN5RbG9pGd4UpsuXZp800duke99c0FBWmQlTQJqtWFb6I9XM2o1+ZiuGUjiPlVAI1bM5Z8rYdANaQqyU7SJcU81VmJw7E+wP/ktsfILxujE+nAywlbSBQV30EouoP2J+HmuhSW+UuswsBXOOKaPhJfpkv3OAYWV+NB0Rx+9zYu+IpYBfGhUtIVbHsb4VYFXAIMJdHgsaOCXiLYiLdyPIGul4jgZ1BX+IUXJC61NCbXElOL08iCEd0zU3DQEOvhwHU/+buUWGMIQjonj3EPM/6vSIN1gQgQgD116RYBMuQ1HFLysX9JR3LXuat/vXaIGwj7hKo7MX99/qomWTHZaCF/DuhF/Lui5xbszDqK7S8Ub3xe2BxumAc8mQBt7yTwIGsEzoQ45HacbOpP4KWEC9e1pNcQYTGpoqvDoWjBuC1crToOOQrKLAF89W0DO/4/2UhRNB+H16Btc/AJjcqJW/IoxEFS15aDhRFh1J7f+UBfGwrj7CsaMAcpBE86aohbhMwq+MbWnUqy9XKS2XnyAL8/aWA3lakg8c1TlGgMczpJE93YFRFXw8mFXqyl317ZwMPptXY683bcb3+02B9aPeKcJqfqcmr9rHBIQ2CmRPrXrQBbo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(2906002)(186003)(38350700002)(52116002)(6486002)(107886003)(38100700002)(83380400001)(2616005)(6506007)(6512007)(6666004)(26005)(86362001)(1076003)(110136005)(41300700001)(478600001)(316002)(36756003)(4326008)(66946007)(66556008)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WT+8IAPBgAhDQXMj7rxGnlmwgs9+2+u+e4ntDEeEjMbjR+ilsd7v1h8wh3VC?=
 =?us-ascii?Q?TVb3Bagthk8btLzBCQV0702iIT136sPDPW6rn9P9xX/V+4ZJ7goUB6sV1J8I?=
 =?us-ascii?Q?cQAdUB774FVkYMCY6ZdKGfFgzyKorgP5PPP9mhPDey33oJ9+MTp8J/UmawhL?=
 =?us-ascii?Q?XHJaM8s9a+m0MIijbRwocdGsB35RmYXwDZ+TvNIbhzi48Iq+wiKkhlYS8QvC?=
 =?us-ascii?Q?A/itNd5jlXtv2arT/Q7KnBxSZEvUwRm42CPNiF4LvLrAYpgA6Aoj/l50ogtQ?=
 =?us-ascii?Q?o9gi1A1nnzCrPKym/SN9yNrHfderJ2k+hboPeXtomAeRpM0XOP8es1bwl3NE?=
 =?us-ascii?Q?g6/+ON35VIC4MHf5UEtD8v5zDPsqsd5ncD8OblUMtM+nrH4vHQy8THs/s5AG?=
 =?us-ascii?Q?VkUGfHZtgszxvhpG1fhhAvgzImVRNxR+jMJe1fmM6i81z5llGGejAd7s6Qyk?=
 =?us-ascii?Q?BgaTMm/prP/qZIvJNVLpM8w2AVaoyh9b6QkM36EGFFQ2nC4sSQREgL8oI65N?=
 =?us-ascii?Q?0HTEG+uNXLSHV3QK8YteuyVsuRCZsZJZftypf+KNl6c325DAuwIUcsMa/cmX?=
 =?us-ascii?Q?U+XW5f8LoedaVLY448Jkbq7+JnunE3nHgRfYaXgm1NT5FKj5l+D3DlDFCvLb?=
 =?us-ascii?Q?pC53czvu1Swlk1++lr6Hyc23cqOUMstOkdT3Wrk85jtatqv6ZAa1RAChPOJ8?=
 =?us-ascii?Q?tNLBBbgK8zfGHnoUXNV4UN8SpLNyeDitcP0bsvN/1LMOC8PP/yeRtAjlvxEM?=
 =?us-ascii?Q?Mh4VT05nzpDQWtn7oMtflgPpaRbny8sIubIFwZGrULDSOp90HMLMwwf7NiJt?=
 =?us-ascii?Q?imYLkHJloBnGrRa6h+8d2bw89lDu/9GkDJ0mfwpYMRdydB2vyWmg8BFt9vrK?=
 =?us-ascii?Q?X3sTnwJM4srLJmWB0o7g5w828tvXhIimmpV2F3dZOty3rvkNhZwHZo/3OSja?=
 =?us-ascii?Q?dXu1ZVtkof9thG0ZaWjFE0q62Ed0iMjrqMmZvLqbNIMPdZ4xcPBSaXKrNZFn?=
 =?us-ascii?Q?ILMwbZmZCCnY0koSlPbEjOfk3AZMTSnWDIdKq52R26Q3c6L+LfbNMPVb47tk?=
 =?us-ascii?Q?ziVId/zy5fPS/VbemGwdMVzDaUtPEkwNjfBpZFX9gRl8k9BNvP9Tf8X+0KY4?=
 =?us-ascii?Q?VhMi1t9HrMhY0Wb2mi1sXlKfRUlFY+1sEKHDJFT+3hjb4tcIbYXuJn5fSqz7?=
 =?us-ascii?Q?teuvxZNyp9YYLhtcFiqGwxU8H6wKgS+c/5u/fHR+YA6SCwa1sxpLu1b8oieN?=
 =?us-ascii?Q?kluN3os9JZBdTQecnItjHRmiGyvht6U7eu8avwjrDkdhFH3nokxgT/tmoHET?=
 =?us-ascii?Q?77e7p9oOUdrDrO2mLNRXg+FsqOSw//hJ+BJSNhbXEpM5pikvP2cyKdlQ58Qa?=
 =?us-ascii?Q?4FoDNUpEhii600dX8WB2VF90d1gC0+HoDSlP/nOi9HYzIg+5zW2SyFVRsAmd?=
 =?us-ascii?Q?XRwtf4nA3RE2crXXXxenFcqNnC3RgzAPi5qU34EqtDiekq+Wmsfjnb6LLms9?=
 =?us-ascii?Q?AKJ/Q0CGJN5/YWJmGmSVRrmlRmxphKE8O/CqNCfxGOugwz4O5wnOkojmG8E2?=
 =?us-ascii?Q?aE7S1GJg1Ljhb002JsCDFR2ZktzIz9kkArQ+ykN4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30dc363-7e8c-4e70-5be9-08db777dbe02
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:16:54.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdujKAM9jRdO9Z3HUw+JR+IAz81JMrjnEfgO14vDAzDbZHCd7uSeTArfiwuMGMXqY6+GetyVQ84675d2RSSxkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning is found at compiling time that the if and else branches 
in the rx_data function have no effect, we check the code and 
find the contents of both branches are the same, so we merge
the contents of both branches into one.

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 30 ++++++----------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 8ace797ce951..dc2feb88453e 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2116,30 +2116,12 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
 	u_char linksrcaddr[ETH_ALEN];	/* Other end of the wireless link */
 #endif
 
-	if (!sniffer) {
-		if (translate) {
-/* TBD length needs fixing for translated header */
-			if (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
-			    rx_len >
-			    (dev->mtu + RX_MAC_HEADER_LENGTH + ETH_HLEN +
-			     FCS_LEN)) {
-				pr_debug(
-				      "ray_cs invalid packet length %d received\n",
-				      rx_len);
-				return;
-			}
-		} else { /* encapsulated ethernet */
-
-			if (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
-			    rx_len >
-			    (dev->mtu + RX_MAC_HEADER_LENGTH + ETH_HLEN +
-			     FCS_LEN)) {
-				pr_debug(
-				      "ray_cs invalid packet length %d received\n",
-				      rx_len);
-				return;
-			}
-		}
+	/* TBD length needs fixing for translated header */
+	if (!sniffer && (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
+			 rx_len > (dev->mtu + RX_MAC_HEADER_LENGTH +
+			 ETH_HLEN + FCS_LEN))) {
+		pr_debug("ray_cs invalid packet length %d received\n", rx_len);
+		return;
 	}
 	pr_debug("ray_cs rx_data packet\n");
 	/* If fragmented packet, verify sizes of fragments add up */
-- 
2.39.0

