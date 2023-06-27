Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1173F0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjF0Cmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0Cm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:42:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88414173A;
        Mon, 26 Jun 2023 19:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db0zS1AImQftSn+Z6rAs0mnBkKcNAkxLcwAoS2ZAltXP0wgdccfkT8gvjvlhjr7IT9mVPdsbvSuvOOdmXdOoNyRg1wh6hpugFwEoD0F7JGqPgSm/aLQZ0NHuULXl8uGysi0FksB7Xjd8Gxuwt2ahO5Xd+esaAiJHjk/x/RMF6QQNL2HZ4uXh3osvgbkFqlV2elmYqIlyMZYHRtnzDAQHuo80QQaHrkRCj+0cTIusXpFgJJDkf9QxQwmNvmWEeK4UUNLQYlUdSpcl9AFZ2vtsuPYss3by2OdGQm6vGYQsYhocG1K5g4yS+c75XUlRyEcrz4hUJeY6W/kZ6o2dwP5FEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOGB5c45cFt4pHBDtBGsipeS7s7UAioafrQLcGXqeZM=;
 b=lKKTJMvfhMPh4bcrzgKbVKLhiu1lN3YLacNLO1jiEeLGIqtHKDIerQGmO7I9eXG2N5nCR3xoBMX4icxYlXyeN6vu2VLS5QqXXhefB03jE3hnCuhGjc3JMMTVtbynLtU642etYuk8ngX+gZK76okd8EJRNt/nQNqsOYNi819ow8AUiILsa+qUzvGGUMf5i6bkXrX7ARcGT/cDi7QeJsf4Wf5B/YHk2mSuT8MYHp+pKUvwwlIz3NT4ieJ52htwdK0sKios+mXhUF0Y9CmyiUK5UJ03FuyYaK6y3YuWWIFpglU9UpHCmvsBqnosvfJQnSOFeVbN0W2I8S3l11vkr45QSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOGB5c45cFt4pHBDtBGsipeS7s7UAioafrQLcGXqeZM=;
 b=EMAnyei5KJofEeQpSNpxNbKyNVhXGb4xSa+iLaAeJGtiuZs8TsTixKDenqybQkeqLTqr6hbF2N1ObxMsyj9LtU5JYY7uKPzEC0FJTgNeVQ7PHEUA873zBC3aJmyx5xFKzZHi646YizbRodADaJIBFBK/IBmg8r/H0UKP3Fakv/d0ftYmluFutoqweWdMIr7oq49aAx48WNI1FQHTX/SbklOEppTHtrP3poNP4VaqNBu7WvRY1YoyOFFiKkOZdvM5co2fXWA0LFLifYKEGxzxLDc9/XljaOlJAJhKrPCzXgUhNYEjGbOt3qpp5XAv98PurQUNOx6+R2IJoHRw+Msipg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by TYSPR06MB6528.apcprd06.prod.outlook.com (2603:1096:400:47a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 02:42:20 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Tue, 27 Jun 2023
 02:42:19 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, You Kangren <youkangren@vivo.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] wifi: ray_cs: Remove unnecessary conditional statements
Date:   Tue, 27 Jun 2023 10:42:07 +0800
Message-Id: <20230627024211.18385-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|TYSPR06MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: e251c4ef-4e35-47aa-1b26-08db76b82065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDSMzT3DBusG24E/CelomkNwRb5hjHiuQP4zoMr1oZ1EvIqBVZZKvlt6bFlI1qcmJIRk4VNHSp4/7aufwLQNVQY67QcA4/sffVThOeKrQOwkZSF7l78Yee1NaFZn12N+oHUTQ46zbbbIC3Zu/cmaBDKuAk7CqSlMR86kO2eIIUcSUQHwXRKpfin2nBEUP0i5X07cCD6Ex47eBOqJcOMfQcd0LKblxdnja0q2BTUiXBfyuqTf/M9dIT2u2CREEWI7rMoaOzkWeCqJR8IDiS9O/pa6H29699qECKS6i3GkUh+FLlik8HqHKGOn5rUFqlg8bXIHFiQ38gElDeWvgp3rP2CPit08vOYQIrWkkYhJQ8IporC8PgITud4F1122cb7s5vNKG1rQtPODmTTst7jmnKBfZ4pgqT5qtRFvrtGLnEgMxGTbGnzkWw8fchMAXasMGWvpJlqAbUADGbtE2JliXTKMZ6XXpSScxcMS4EwM+1vpBefvB4HN40MukfAJafpHPEpyoCD8xIBsV4gIwjsVRQp32e8tAo6p0ywospGJBiOH0tHXIF0g08imXtiVaGY5WB8jqW3vWazc2sBtcefQRD5AqIYH30EIxMV+30PofmWWhLAj6nDll3x7kA829b5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(110136005)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6512007)(26005)(6506007)(1076003)(2616005)(38100700002)(107886003)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vrd3RBjginTj5+HuR1ZRZ32vLAP3ZYxcE8y6Cf9PRbOa1jlU7yyV+gcVGqh5?=
 =?us-ascii?Q?eGADeQ31OnE2oTbdzxM36XAl4d45HDIK4ULFH7aAXnXXBYne5gBf+wumpV5g?=
 =?us-ascii?Q?fchOx97aHjcvXiu+1YWfMFN7s44WiRrNMA3/wx4eIcX3+VO9+ge8tg8P9RDe?=
 =?us-ascii?Q?10YwLRWzvGJ32Zy6Mge2BrB3OaWG49rByxywJnb5eNCPhIhc+8M/DmpCyppg?=
 =?us-ascii?Q?+6Ze5cMIZTSPFZ+zE8HkdnChqVgVMKD0zr7/66Fw13o70TVYq4iNZObbPLlF?=
 =?us-ascii?Q?m0ySY0ZwZ4xEoOW0GdAVkzcK3p/RUmrTsEl4JCSUHciKzielFgWVwTmdRp6J?=
 =?us-ascii?Q?e+o+Tg1jgh/WpJQPwYFeCYOLFg5JTrtGb7cT3NIHcW3chk1mz4hz2NAtXpyf?=
 =?us-ascii?Q?qi0AbJFS+NlilXfAUkfrh4Ux7xs3OqFLPYVrHCjLFVNfOlqJNJNw+qoPXzAz?=
 =?us-ascii?Q?A+V8AHih9IV6rBnULFaNycsSGc3j9fh50EvLuJlNUb298AOf0xNSCiI7TpJ/?=
 =?us-ascii?Q?h1iLMz5G614pXZ5pPX7NuQoA1Dbsj7VrZLGEL+PFPt8JMdDyDjEkc7atf4w3?=
 =?us-ascii?Q?lmZO6GuZufuX9lYqRxFx2PcyJ6NO87gCfNDjovwtsnD+TXqYLukvzIhPK0/G?=
 =?us-ascii?Q?s8QBcRL4/bJqcvkND1WWb644DS6u4h2GUtSM3vy5H9cbPHaqLjQSV1rLwjMb?=
 =?us-ascii?Q?+1tIOj3/rjkOnknddgfrTQm7aWrwHj6wZ7sKTTnE0I9ZDDAB/EU3AjdrZv+W?=
 =?us-ascii?Q?LX30pEzALpszkqnXXFVBqQlXS0zzjGrXYLhGmopUq09Sovw5dO/+Q2clat9R?=
 =?us-ascii?Q?MJAv+WSsjqpuLsBrWBp1JXUQ0MolIDPJ7+TeOvCOeyTYf0uTNWdzCOtOiO38?=
 =?us-ascii?Q?pFmoZGq641gPa0e25eEAEKrxJlrM9lYJTIPBv+/tEzvKJ0X0n/aiSduquLSI?=
 =?us-ascii?Q?6itUN+qBjtzMB/GAEmSYOlrxeF7tgX6dI6lUhwoKzKiAlDzCNFRlJ/YpcCa4?=
 =?us-ascii?Q?HgOYmWBmG6FwjtO6tP7gziJBTcJi1U3LxGlpd2Slhv6dt8u9DZy32FP2i7D+?=
 =?us-ascii?Q?CvIqjHgk7id5FN9CqbwXAmvhSSoeu4Zcp2+GXi7wOWhBT0itrPugb+mTy+cN?=
 =?us-ascii?Q?Sp08+iQ127qXobJHRMDi7zJc2F3dbdWngnIN5gqM4shOhIXDMMgyBGGNI7hz?=
 =?us-ascii?Q?SS8d0LH9TlJCEOJI4ZPYTxWk6XV6RPXZNzBKviR2Ar1/dkCo/AR80KPLcv/s?=
 =?us-ascii?Q?Blry1zNMXGF3EhsTFdw5gPHaNp2fkoWhZhFJhR+hD8x97wRqCZAhvI7NJoQh?=
 =?us-ascii?Q?E9Wt6ulyehKegoVmqXkiyhTzxij3zAFH7o1ai4Bott8PVTJe/iUFYbRrgKmV?=
 =?us-ascii?Q?AR5l8zwpG0xMiFvlbDwVa1dQ3Yw91THbR6Bpeb1YxJXCjH0gGGJGERwQxrJP?=
 =?us-ascii?Q?k+fNaSNdzDbkRlvYOTK5565SOpohOgiCpxOf0gl6St7KVMqyp34VDuJYvcrr?=
 =?us-ascii?Q?UCv+s4UXF8l9Zo0DrZmf8AcjBC1KoDa2uhzgtkPMYPk7rBBujVio8mWP0Iim?=
 =?us-ascii?Q?YjzRSbZwpcH2NVEoTuqEYBskz2AUpbQr7Nk462gD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e251c4ef-4e35-47aa-1b26-08db76b82065
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:42:19.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQh2trPDZukMiH/T9SSBY3crT9rnWWbZoRsT/LgO07hkNGXMAi+ZsKAEEYc6Nu1/ZtLH43nPX/i0OHxu+Bn9JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary conditional statements to simplify the code

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 30 ++++++----------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 5f97fcf5c4ba..e4ea22316a03 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2115,30 +2115,12 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
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
+				 ETH_HLEN + FCS_LEN))) {
+		pr_debug("ray_cs invalid packet length %d received\n", rx_len);
+		return;
 	}
 	pr_debug("ray_cs rx_data packet\n");
 	/* If fragmented packet, verify sizes of fragments add up */
-- 
2.39.0

