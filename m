Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5343B7465A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGCWGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:06:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B970E70;
        Mon,  3 Jul 2023 15:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmNDEawrZVeF7wxCdsauWhfJA8dWqhcbR8D774Je3hIkN6UdnG9bDSNCX5WAejCXWnHPgoDdIHw7PS/gMr3zaMxVlxWinCgK737JQOgRZwNU2L5X4NkyBS7oDSE4sdvGlgcYC49yxTcp/IeGMH0x1uO/6Hjo5BElYvcUerFXA/HvS9qoFDOjRBAN1rFqVqLN6cFiyILp9jj1eZB6oX+2/Qt/pGv0L4XaXk51yhcibMEhXX9HUPzkPgOEDD7nAs3RGQY/35KRCAVi+vdMdwzWyIszyixu9r6wBrl9obXltPiaioi9Y4zQSDGL8hasewMY6uC0UatbM4ZQEfRxBlsFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcxyD8AZojHmHGQnKc1I7aukbW9ubN01UUK4uK8XJQI=;
 b=bxtBcQev3AFnj3qCY6UBVEmhPgcvt7pZ7/AUpbdZ6yE5Wl6PbqA0/glmIKxjNvAfl4KParXQW4Gn72amo/k60NzBDbZrgtTjn11vdvHzhUS55KbV1WxdWwBGVJzpDqun3vjC96+wpYVWzIzuDSUnPO+mgh3O5fdb+93KtLhqFX7ME+XM/jpGlba9SEA8DBYIxbCHqzKn8CN9XEXi3Nxj+tncmfCs/YRt+cHJVmQNw7Ie0k/vOyqLQ6spqGeYPcVc7MijlT9TolMPyKcapQQXZluJIW8n2ndUKh5ZSO2e6woWdptsi6ar7dzeGexFgDqmPNkjuHZ39M3lT3jzSyFg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcxyD8AZojHmHGQnKc1I7aukbW9ubN01UUK4uK8XJQI=;
 b=sUJhh1fM9Lt7mcDiNMujCw83aBf5ZTVqU2zmURU3lBo30M/IkPDntbENBTr06896G0DltQ9E1nBbO1WmhdFg+tp0xWl3Yjzvgf27dKR8sAXCwChB3eMmNSk1MnslQZcvGLs7+CLTNbYbLspcqc+j8vu3yx33gCu5jMRq8nNLrmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 22:06:12 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 22:06:12 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v2 net 1/2] net: dsa: tag_sja1105: fix MAC DA patching from meta frames
Date:   Tue,  4 Jul 2023 01:05:44 +0300
Message-Id: <20230703220545.3172891-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
References: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::45) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c56d63-380d-4cd1-3ae2-08db7c11b660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgQyAseS0GksIKM8o56Wjchh2aF4ECLexLQsPbV2sWedhb+jExmuzC5CEm1lqOWfH2Ko08GpIRL20WYoSnb6EZoJTG1v25v2CWN2YaGtZoqwlEzFUwupRI2dxmbZwuKbttDsePDPnaPKqihMMnZIFq5rfmY4rXvRwWltZQKrvYCNl+OhKzwSBu/j1QgMm+4/k8ygfJDdvp/eyXrLEYPjmAh+x2S3Yl3X404A6kJw8y2B6VFrC/b+5G2GGKaqWVUaKM76tOC+4C9fhntWyM1V2HIM+6kJkkvs2Owo2+iXl6hwoKAFMvVCHdmX8pGzl8K5Ujjju8pvLDgvc9qxzbR9Eub/eI31wBvVp/ULlHIC3u3dQ+8i5Cvv/6ckH38jhGC/UklHBDRk4DxnG3CiVbrx1R9uk7vVB5gpfAbmdR30y4obIPntDhACTSdwMRwjGiKSmIJFY+kb3eGByTNjCbIoawjIGEXP1MFm9fsMc0ctybtW3M319GwbjAfjyG4+C0tB4P1ZrTLUgMagsE/+LTSJkwayWfSWlfQmVkQrGzRQ9CBV2oh29UXQnfvaDoe8f4QqrpyHxPVVf4bfga3U7axU43DjRNjAykH/dA82VPjYddMnxkiAQVBDnpXLxnNCCkOf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(52116002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(38350700002)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GPIG2ySQUBrG7X9gEsXPlRB/GcWQp8sk5ByHn+BukV7aSa7iKNGwyYOvHTMt?=
 =?us-ascii?Q?UEbvJMM5uUW6pP9nF0X/auleRTWvckUPWhsuOlBLUhjdbb6baSnYKBmuKDBP?=
 =?us-ascii?Q?cMXeLgG3N7fzbsMQaV4ybSPNIu8Ftx83qW+c3WClnxxrK55QEgFg/ZSg8acR?=
 =?us-ascii?Q?foiFt+qOWcKOuiJO+Omj6K0QC+WdQf3KEQFu8njhBV4gsWny+K13sL6d4F6Z?=
 =?us-ascii?Q?aMwijN5ze6e+JRSJ9I0smz71c5KorhhrXVBpU/el358QAN9us9I7Ka6gcEjR?=
 =?us-ascii?Q?E3hzNjHhp2p+P2eqigjACM33HlYesKnZ4OUx1Rd/dcNgz28F3HWHNO2TuTsp?=
 =?us-ascii?Q?AYv6nHNlTWVikiakBhkH+q0wHNgqAIZ2rjfoNDFq5YmOf4bd9Hh+vE0SXTkr?=
 =?us-ascii?Q?JrxgqvEDHdMLyfd5YL5+SJ4sJQOp23WGquM76oOdA6nXgiORZxy1yfEGu1tJ?=
 =?us-ascii?Q?+H5LKGg4gPBDmHJJcIoDlqw4ZgpP9MvW/hVf/0i6phM06bGuopwGtYkAGBrM?=
 =?us-ascii?Q?Q8gkB+ABEFYj6i768FuNsgKcbNk6ZF35tX70Jzd67t97l4dYysHjrRtx4ip/?=
 =?us-ascii?Q?+8gdmvQKBLooutDRwdLJCrCLVjxTPwy1y7ocNcB0cImHzhg4JkBQCr7k7U6l?=
 =?us-ascii?Q?LBwZacL24ZwZKfCT+kWXRNT2tp+E1C03VLTP3XHaZglhsaNhqrnXc3qlRMeP?=
 =?us-ascii?Q?uwRLxfR5VR9XLys2sfaqdA8HHqRbwsW6kaXLBYWeRd1dbmdJv4IRYeiF427n?=
 =?us-ascii?Q?L8KaNw3M7+rxMIlBeemoZVsXICaxIWkEwurXAz//iQRuaqbEi9dUJGKEVNKr?=
 =?us-ascii?Q?FXANiszpE5oUxqKNzNPOfGNY7HQAljVECcrFOEkNjT5SOvf8w6P5aA8VAJ+U?=
 =?us-ascii?Q?hFhTuu5ki6Do6aA3nplc0CmC7CRDLjHwqpZeHWUFrVHUOuCLx3+Oy/q8AfvL?=
 =?us-ascii?Q?rReQiGEG6W/q2aUTBYAXCbS+JB6hYzckigFm24o4pLQ1Y9i8qVfhT6YE/w2C?=
 =?us-ascii?Q?gVBVDinCBsb0hkIKOz3/75wTXRKlCVtp1ybwpqsXHOYPUd1NiABk5OtKS7ll?=
 =?us-ascii?Q?iIDGFG1q4EYJIlbZWu/K8h5bhomwMgC1CXLIVgiR9SArXQ+bLiAi0y2uzeP4?=
 =?us-ascii?Q?AjwH/ZA/b4K/TnvpR+VBX5k9S5fRGEEl8GPdACX28xHlWeVhliaGN4Vc1Crw?=
 =?us-ascii?Q?u4YeDX6/Kzflx0ts1qHNn7m8eFwRpVm1+lZaUSIuCYjfVSFQJS7BfmGrIL8p?=
 =?us-ascii?Q?jMII7d28tdP3z1tQu8TVQ4HEUbNkpHzXkBxCfG49mFiyPq2UcxIj1VJVvKzb?=
 =?us-ascii?Q?H5X4qiNiUj3XR/lAR7gi+6fS79rxdFWwS668bvADk7E3YRBqLLiiedRmsuLB?=
 =?us-ascii?Q?uvxu14+6kz1tJQSkoKcXAWQ+Aym6ndzrkubOYcxdphxRhxv/jnz/15tcKZ2r?=
 =?us-ascii?Q?Jx4eXrJ+YuH0lGuFUK4aLJarKGz5Pm1V43gFMjE1MSoCPJAhyvnsFkTHwR0U?=
 =?us-ascii?Q?nfwcODRHDnZM+KsyLgCq6CjrtO4bZCMJoASczDlW3XNQSJ3G14zXSvro49+h?=
 =?us-ascii?Q?Ma3cWq93ehPZuVFncXxKm4JCvNYxc80ySWxcCuJag4AwNcochQhgXqsnp1/9?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c56d63-380d-4cd1-3ae2-08db7c11b660
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 22:06:12.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/ku4yKX4hR1xxj9yjSh1vDSrpTZ5sKp7o84RgXt2u4gjSd5dtOPEWNHeEQ3uqHLpo4W1o2usevclppFj50Apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SJA1105 manual says that at offset 4 into the meta frame payload we
have "MAC destination byte 2" and at offset 5 we have "MAC destination
byte 1". These are counted from the LSB, so byte 1 is h_dest[ETH_HLEN-2]
aka h_dest[4] and byte 2 is h_dest[ETH_HLEN-3] aka h_dest[3].

The sja1105_meta_unpack() function decodes these the other way around,
so a frame with MAC DA 01:80:c2:11:22:33 is received by the network
stack as having 01:80:c2:22:11:33.

Fixes: e53e18a6fe4d ("net: dsa: sja1105: Receive and decode meta frames")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v1->v2: none

 net/dsa/tag_sja1105.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index db0a6ac67470..ec48165673ed 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -118,8 +118,8 @@ static void sja1105_meta_unpack(const struct sk_buff *skb,
 	 * a unified unpacking command for both device series.
 	 */
 	packing(buf,     &meta->tstamp,     31, 0, 4, UNPACK, 0);
-	packing(buf + 4, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
-	packing(buf + 5, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 4, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 5, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
 	packing(buf + 6, &meta->source_port, 7, 0, 1, UNPACK, 0);
 	packing(buf + 7, &meta->switch_id,   7, 0, 1, UNPACK, 0);
 }
-- 
2.34.1

