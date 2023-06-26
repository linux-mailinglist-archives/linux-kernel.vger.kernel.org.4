Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1273DC36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFZK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZK2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:28:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B283E56;
        Mon, 26 Jun 2023 03:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeBV23hsJ+9iVbVkPmp89SzpGWfsDYCCqaBvt9erMfeGF4ylGcx24bQ5wvyhfJagOi5Zh4tTypS+ef4tg+EadjjpL76SImjWX9pUpyTc5Su3YmUkQnP0/FCw6LJX2+Cf+VmM3RUNoaQ1ENwux2HkjU7h1S6FjVucPViDy7DVNpw5j4OydKITUqNiJtNYM8fPlK/2FvWbfHG3bfvlFBNrLhMUAo/Lu/yJ56kt/UOGUvDuterFIMCfQ0DS0ThkFVCc98I2/l0mvNcQCgITFmvFRkPn+rJDeTwjprrRIl/e3pMTvELhTVosqGaDNDknf03tKsthRPcewFaNtOtYRjGN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw2lv8tYuBJi9bF9fSEiHg/Pq4olWdiryrhg9bVL0kU=;
 b=OBo2uWEvHtdfYrWuGkLB2Jt6nr36jR6yPBoA13ToFsp54gC/67yRi57yj2hdNWq4mBz1h8t/yUTEu097Vf5u27XXaSb2dxk4euBiY3bYuCGZhHwG/Nc1wx02U/5ctZzyxTgLaPK6RGjpsJa7WfOCQQQj2lmY+UZKAC7UM29y74oq/HLsIKVAx5YhLZM0flqUdmy+0pIGL0Q5jXGS4o+ey34td48EfhuOjO21uxhYSHZE2dqyYTnBClTLIUQZy51V5RYd6VkndtpCphiPM79MkNhZVq6lhCHcxqY2QTyg0/ZDguYtTjinFmMQQBwW7ihx5iPLG5kANmMX95pjldFEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw2lv8tYuBJi9bF9fSEiHg/Pq4olWdiryrhg9bVL0kU=;
 b=a8ga5gGE0+00sgHCNL5jYEbKNCM3bNT6KA/5jky+w5AYt6H2qMvT9n5JaQRD0hX4x3FeO0C2JGkbHXQbaRMdRjWoxjSIb3VtLaeYRNbsLdfuRZiI8Q1gfmwUUrXjaiVxmoCNDpQSr1qSyBSE8SPJEMNjWUoDMdctdhgxy5FKjVxGh3mo47zDqKJF0AELjKr4R+KlT5uAs4T5aQbroAbNEXOCPY/tIrzZW+e342yNxM2eMA4ISUKkRauiFaxt95SIbywk/7+a+SxuRJavFHOriRmGUM8LRM9lRH34Lqcd6a1Q0s2HsIEYT8Zg36GbatHnRt4xU+uHRHzKKSvgek7k3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by TYZPR06MB3886.apcprd06.prod.outlook.com (2603:1096:400:2c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 10:28:02 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 10:28:02 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        You Kangren <youkangren@vivo.com>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] wifi: ray_cs: Remove invalid conditional statements
Date:   Mon, 26 Jun 2023 18:27:50 +0800
Message-Id: <20230626102752.1583-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0274.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::10) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|TYZPR06MB3886:EE_
X-MS-Office365-Filtering-Correlation-Id: e397062d-b9c9-4468-2c2a-08db763004e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SLC8uKzAuwM9CVUeyV/ddZoRiYQXPt97W+0gNCyazHcj+zi1Du8ok56RauQEGG82RCkGgBTqCjeqf2Csx8708ADb7U0IwVim0Zha7w+PNiv+8rBINxnohGMi2FPTx/4Sv+XLk5LgciwidlDBAJl42pDvGOLXcuFUPhcVNCrZSY8CJlyKKgd4tEaGoDJ3NBaNXPzTrkS5L7zGi7Qt9wlRXqkDSA234v8nVYMtDcqFw+KCXCmUjYQPRCeYO3q55L6w2A/1MQmRgvJ+XcWBYDdiIKWH7P6hN4eewBewyhSejQXPQFw+uYy7IY0RYLCPaeZyy7wHglzCfv5ruzPdl7TNYT9rS8dlHM+YlAXOcea3kyWJJWUX9ZxKLeppzxrKfOWWqLZRtJu/B/Cq5fH/qV2TyLTFhs6h1c/36bj4JrFVLy5onOvR994sc+uUC9A9oIGhUaDCtTP69XjnV1xgmmkePbmcFnkpDoi9+Tma2sBSnSnpL/6KhfkUCTk1ZxoPJ3ffI1U3Ke2ndi/Huvn0UFqL7RdWmpwagsVTrVS+la9shn/ROmroxd2i0aRBMi8IidT2ukttXlIK32j0ddqMKPSlLK8VYGfj1hunkSnIwklLF84sZsVQEHE1vlPd2zzJToL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(451199021)(8676002)(8936002)(66476007)(66556008)(66946007)(41300700001)(316002)(4326008)(6506007)(6512007)(1076003)(26005)(186003)(107886003)(2616005)(478600001)(110136005)(6666004)(52116002)(6486002)(2906002)(5660300002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jUdCXE6QRqPtvM1F86VU5YML0HZQK+5Z/wr/ZOi5IGTsOuIjD3I0FUKDpPIl?=
 =?us-ascii?Q?4Jd6XMZOrlP7qX21QKOXjkkMBjawd6ovZJ+OF65FkAFODSxTJ2p8UDhICvgV?=
 =?us-ascii?Q?TQiF5zcGTTjQop8/ugL21USOE18s4tW56Ajqh/WNvSTQSNGx9DhkRJ7f3GZG?=
 =?us-ascii?Q?Q1KZBUrkwEJI/q8b3Kw0w4o3pMrCvSHW6qCu6DhLoupikMNF5ivUpQ2GzMz/?=
 =?us-ascii?Q?UGWVBE8hnKJBJ4mO9RTA9bu+njrmTTa7xisFZ8twN/y4M9DU5BwfSN2gnT0E?=
 =?us-ascii?Q?jBGYIH8zABqC9NeVTqeQS5pHBvQwg0AnBgITF0H6Zhy9qdfLh4U/zBKWIBmi?=
 =?us-ascii?Q?7tHcIfgsMuauhBSLHSUGqNB9ZMOqipfQDJJSvhrxi09z8H1ImQmwA0Q4DByH?=
 =?us-ascii?Q?QV8l+3zMYPQ/41Y+jPa7pBmJSJiJXMiQcCwkmiyZxnGF3fqnLhbPvrWJ22Nw?=
 =?us-ascii?Q?BWv0chsmLe+VqxWlaUu99rFg3YSvAlaKXC55a5egYQYnE+XyjdEGsZ5ihDsX?=
 =?us-ascii?Q?/lPBpzI5OrDcZ5A/vZG6OytT0lTR+63Kukt7LRcXsvuL571fW8TCMHKlw8dC?=
 =?us-ascii?Q?28TCUzY3gnHCvveVmQalO707stm1JBQcaY24AwrMidw2TDjOn+XncYdYOl+3?=
 =?us-ascii?Q?1S7cc4M32NkMOPKvbrP/xgYzwfHI9fag9PXcA1E5akLbINcWQzh5fTADOGen?=
 =?us-ascii?Q?vvkzw/Qjn/GBvIcdFJFyp89sfVExHECq2HaMvP/ixN7fpDvf5RZc+kNkKpxs?=
 =?us-ascii?Q?Rkzx8UJ+faomm076TTQcw1CBiTLcCos2ZiVNZEt2Ftup3BOtwgYNYLU/Ph25?=
 =?us-ascii?Q?x7KLrFpHv7gmHM6H2McNmosWnTtDdzMXA3TyR+lmaGqGyl6ZsX0TdmKtpo1s?=
 =?us-ascii?Q?QNBpgZWXiP0y0IdGJT8dVROjGrLh823WLejI8iNKgYnB1/qBnlTdSZKArW4M?=
 =?us-ascii?Q?z1kXdho5pDzRb9sLG70VQIo1NHm59PcB7XYkWIT359HOZsKYsUmrz8l6qwIs?=
 =?us-ascii?Q?uoiNTFpfdturFD71bNCpYEWo4YiuPK+tXffSjxDpSxaBBZdTcGk19+6kBugs?=
 =?us-ascii?Q?FX5sXmd1jE1RPTr8+nYLj2G0OWnPpVDpQP3C5HrcjceiaV4nQVn6oaasuSMr?=
 =?us-ascii?Q?nl2STplb55PUdD/xk0DMRnkjrHi+vXrsL5mSBLw8ofOrpcodXgguAvsr9L1a?=
 =?us-ascii?Q?R+OTpZZeZoRrddBDa3sGcN/JAv7dZjC9yLWiTH3pnUFRgVbiIUQgM6InYwcD?=
 =?us-ascii?Q?1ThxnTBagUdL81QgeYaYchLCRXxkoP/nXgRbiSyaSSJvS4S6nfyg6DXseArm?=
 =?us-ascii?Q?yGfvBaey3N0E8V+xPVxDSnBXgjelrryGbPfNtbQ5bAJuLGCEi1gHmVzn4Zew?=
 =?us-ascii?Q?t+y6qoLdnRMpTz0UNdMJen0cWhRDG40W6MBXSXtNO4mT/DlR7/sOpo9EARob?=
 =?us-ascii?Q?E1yV+sG3Ak7sHRiHyUYpXdu4bFi6A8+ZUTSxK3M0ZkwqeoDGkoi/ugm97cuM?=
 =?us-ascii?Q?sIsP5SkRZM9UlrUlbDsffXxTsj5useehrKEbmK9bdHQwxZSei/8+0/L+tnvW?=
 =?us-ascii?Q?uaDvqtofVq77bq7aQkIswcGtH8YBajCh50nRI0PR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e397062d-b9c9-4468-2c2a-08db763004e2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:28:01.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JhOy+OzWoet2erkuMwzkdHY7NPOHHlkUleyc+gLTpf02D379SoXaOG7fgocxul9plrSfWLbVpGWfUDY8shddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove invalid conditional statements to make the code clean

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 96f34d90f601..0022038b0758 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2116,7 +2116,6 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
 #endif
 
 	if (!sniffer) {
-		if (translate) {
 /* TBD length needs fixing for translated header */
 			if (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
 			    rx_len >
@@ -2126,18 +2125,6 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
 				      "ray_cs invalid packet length %d received\n",
 				      rx_len);
 				return;
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
 		}
 	}
 	pr_debug("ray_cs rx_data packet\n");
-- 
2.39.0

