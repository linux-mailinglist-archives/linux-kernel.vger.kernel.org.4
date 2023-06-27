Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801773F04E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF0BVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjF0BVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:21:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB0173E;
        Mon, 26 Jun 2023 18:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6Dcb5W+KmF0ly6k4OodOdUNUNI7x30LtvUFpl7a2QdTHj96bBB6BpsmSReyHSK9L2iMUmmpiZ59FBTGgQruGJQ+kotPbKGjIu5WktIOGy9dl1bwcemsHL9zjyFMLMhuisKhFU3mCcaqF4S5x5uIp4TrwrcwE2+lx7ubYkpnCyZvPOHbUteQ/g7olUBMr16WSN5NE1iHCqCY5vVDP4wTkYnuLuUY3ZG7fgEuV/ywwrQkKzjzIirfypTr+KsbQFd/VoP9NYX8bABOdISAcuu2oeQGu6pQm5UISVFw5M2JR9ereEaKDb2WsukzDeJEl6AmIyqrkIrPgiEiTTi/rm9SdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY5tA3V++FRLrpsAcsPaQBkCmzG17OjpSALkEpFk47I=;
 b=FTKOAZeOvoJoXXAAf1NMEGDnqchwVeIl/2o0OyCYebCGDTCcQ9KwfOwNoNCZnIZr6IOUryuaYzJ7j7zBTwEGZTHSzHEJLPqZIDG+LiFYOaJhLk4IV3hqR6//9fmR6uqKcXyfvGQu4vd1E9Iy6kOLJ5XRgBxe2djR5QmGQFoFQ0OS15PMsVl28aNN9ofGetl7V56tudIiI/2raS2/ZXo3buQF21xs6xiPwCBvRyT9x3WaOf9FHvaxp1Ng9eDMlCPTOdrlq0KRnemIMN//OctEkw3WUrVe/UunclzTwU8LR3GtWHI+/3TEP7sTetuF7PAQCCjdvGaG8N+/mBuVCky/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY5tA3V++FRLrpsAcsPaQBkCmzG17OjpSALkEpFk47I=;
 b=OfzWteAyQGSWlTZoR8YK+LVfhDuP0q79LCDE/CAke0mR+kPN1nDJDqiyDsz7/T9lpSI9jV+fzFkp76SbJSHZwrW6bzAk4V6Iu/9ay/QDaUgpYkhN6RLt9ApbKQiVaj3Y6ondKmc+TcE0TAn2cPXNLghtUAM6zfKcGooFqQjmR8XUNVTuoAsZJSaMjKwYHupld5/LyQwYZyxkZmW1bDjRD/7HPapUbwAFXFN5V9N+2+H+2Nw9SYStXmixHIOEHB3UNbUupwzbT93qgUCfK5xrrpm0n5YkOwHmO/291U1Mlovf+ZJiBo9BqjRCMzv1/DZqriABVIz73wfkHvBC3fgMkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SI2PR06MB4378.apcprd06.prod.outlook.com (2603:1096:4:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:21:39 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Tue, 27 Jun 2023
 01:21:39 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        You Kangren <youkangren@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] wifi: ray_cs: Replace the ternary conditional operator with min()
Date:   Tue, 27 Jun 2023 09:21:26 +0800
Message-Id: <20230627012129.4066-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SI2PR06MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2eac27-9a29-4983-16d3-08db76acdb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZcnstUn+2t26eHfOTreJNzTin376bsaMvEVruJ1+ozDQHuJCeI2uAg2F0MHU9R0KPJBQU0953PqikXP1YBMM7/HDr3beTxK0yRQhPOT0qVAOYu6LFzxk9PGQxPxY521AdAO/U9CxJtju8hysvgK6gLhnFcsOJQJyJQ28x+Tj22rWn4lvq/zAHnbJXcrU3wqLF93Cqesai+El34+AxvrMKQYFf6dIu6YcY/lg2YAl5HLQPEUFoCKNl96uKJasUGC6DP+FBMBcu/b1BHqK5EH5DvNwlqUBW2KzUhDLwQ5oUDq3G7NqSLQm6r+lrkt6+cylKvLJs6NCRca+WLOtNp1VrZn0ypuKJR8tBKTyDk/dsAjFuLASgf/yznnL9l+hW7uUuhxL0XWxXEjOUo3cp/ogvETYrSfD37KNdwitN5ceKOP1cXEETz7getIvUHt3M5YQGw4H6qsmVG3f48m056JXs9P7R7mJdUYfzUwG6huUgnPCrPT8is+xaH6OWwlD7XBqy3OKyAH7SiTGfOipj44qVtIYqh8f9sPG9Cb6JTJZr4HEGRIYt2G235VGFu3eXy2Ky2kX3f2NfmMDkFa3WuDSXmgWjGMInz1/6CnRCg5StWacoJPc//K+mfZIXaNrwDk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(38350700002)(52116002)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(1076003)(26005)(6512007)(6506007)(4744005)(110136005)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGxwCrna8XAdpYrrDq+sO2pxMB1o99o8LfQkKj/XqejRnfbA2V5L2JFExLlv?=
 =?us-ascii?Q?8f5KJ7nnzGL0k6UisNehfnjyQZoVUXhkqtA+q5mBUIZWUtuYOHNBVt9308Lb?=
 =?us-ascii?Q?kxazB7cFgei2BuP8T5bBHSAz9N4+0N6EuBYFDJWDU9M8IY8Agp1nCfhPssKs?=
 =?us-ascii?Q?cxGvQbyPc3IjPfr2+u/2UGeL2LJ/EB+d4r1L9njkVaw+1MDROf8JVgNAIjGc?=
 =?us-ascii?Q?kH5YVlI2BulrJE9tLljHM1ISHUWPPg9aVsb1eXPte7GvEKsXbSbF9eiDzcHQ?=
 =?us-ascii?Q?C6inVjJ+QuqVumFMiCYQykr0u2FBT5h1G2GZzx4NtYwj99KN1YxsQTwt9Pgc?=
 =?us-ascii?Q?jWb7aHp3T5aVuQhFXYZrvSfKPDzew6ggQ54pyB6e0gvlOVksbxJ0wof5ntW8?=
 =?us-ascii?Q?pO2Ngw7dmarN5nKoKGK8NKm0JtdLVp4QpHvIW2L5A5r+hNrboyLhISRX44G1?=
 =?us-ascii?Q?NtVRJLj0OiOubMSN39uVnDu1TtPl0owTDClH/+8TnVekr/CarRJrpklro8gV?=
 =?us-ascii?Q?8xuHxJOePSqQuZTccYmY45NDG1c9UGm+xQxPVt85gjBq3JYXdYhgbqIE7W9v?=
 =?us-ascii?Q?qBclQoUcuOq04hX6HjZNwmL9wH9T/4K80TRjNz2yGz8ECkGo55ydzcLGdd32?=
 =?us-ascii?Q?kgCaw3wh+aC3GuTcIwv6byZL0Z/vAg6VTNpeCkoOe88c9S+IbbVJdSf6HIQy?=
 =?us-ascii?Q?nYUmLm0cuxKa0LjCImvDax+24/j+8pD8emqAsbKWGl/BCbZWWfElTinUBvX0?=
 =?us-ascii?Q?iwkfD1916XUAyae0M6ceD8pIrxr5lUiS60WuGFNd7XGzv2j+tfylyyuwWqM7?=
 =?us-ascii?Q?GSO6vCPvV9McZpZkVwdoOQZEFLrdvXleIzrm6xb0wLak7r3Fvkuq0bfBjgRs?=
 =?us-ascii?Q?w99bYUcap/YPdh5ol2K77s41PgPYTdB6pGg1Z9+xxQm3CEYugPB4ToDElOIg?=
 =?us-ascii?Q?zidRSrMH5SCoE2ehXLjLDMVZvAFOupVkD2ONE63AIS3Nc8Kzeyt23bCtBZrg?=
 =?us-ascii?Q?aku2zZk8NbD3MM8EVE27uPMhcBQuZVKq9y410LzoiqoKy2XPuJtP5jcWS2mS?=
 =?us-ascii?Q?pgpcC8ehc9CNQNu18Tyg95aaMDedjmmP30CPRS3mRzCYOYHreM/1I3dgk11B?=
 =?us-ascii?Q?YOos8Vkht/LuyRqTCVzzvgl3ZMMNi+aS8koa0YKUGixqqu5YwR0Wl7vUaNOI?=
 =?us-ascii?Q?nA58wr8aswGxzo4b1CHVkWtVFIGiS7GDlUoyXlwIcD/cKMrVLHF8igzTJt3S?=
 =?us-ascii?Q?rzbZsjUR8Byl/VcS4XfbgaaJyKdyHgEc37hmRi15wU2zLU0qJNYmyewtSgZm?=
 =?us-ascii?Q?CcgWD1Rt17FEf7I3lvdeV6gFj62ez/lFUYmXwkTtWlf/DOw0ho+Er5DDAZkt?=
 =?us-ascii?Q?6UU0VYmjp00HXT1T7jA4Oa/55FtBsF33r87gXZSWfhqqGwKxkbz/ToB7MV2e?=
 =?us-ascii?Q?29Y6Rlzgxa8+9zgDx7mXSwMHDdOuxGz08PMHRgkE+mBQ0wgGNc2h+abNjzBW?=
 =?us-ascii?Q?+fc5uCZgt5uWaoeSea6m53wVXtaysEZ1/27p3nYY9QpLUNgNdETvB3FAyVRx?=
 =?us-ascii?Q?isEuLrxHCdtvwjTOaCopyQkoU+yyqqVevfE0SCZN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2eac27-9a29-4983-16d3-08db76acdb2e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:21:38.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUUfBKNrLSt1D0d/emwNSGoVhDEt3A30RZM6flojiEu/vu8BaP/6CGcphBbGtCBUZD0mFxsMrLDlLnHcSTG6qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ternary conditional operator with min_t() to simplify the code

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 8ace797ce951..5f97fcf5c4ba 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
 			rx_data(dev, prcs, pkt_addr, rx_len);
 
 		copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
-				  rx_len < sizeof(struct beacon_rx) ?
-				  rx_len : sizeof(struct beacon_rx));
+				  min_t(rx_len < sizeof(struct beacon_rx)));
 
 		local->beacon_rxed = 1;
 		/* Get the statistics so the card counters never overflow */
-- 
2.39.0

