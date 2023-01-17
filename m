Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8D66DEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjAQNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbjAQNZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:25:02 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C163ABF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8VYsQUGlJHkzOQyr40LV1atUFSc3LRSge1mxmBeu/FsEAbMwXGsxiRSfSM9LdGifIwQIpEruKgkEQ4XiyO5bFYMfW70d+WqQFBFDmUIqejIKOEgfiuAxBKhhxrUrtvkzNUdANAoocGt2QoR6NuxfbFckEt6jL9C1vIjhVPTHuR06E5/pm3TkzNfl50Y9bQmCawMykv6FYEdtMBOaXNrBu6DWGzCcb4USJuuUdWQMyJV8N7h5oxA20Hm3lA7v8d4eifXOvtKxEdSisLS9IB84pH4a0Za6NFpQe4TgdJ2PN5mzY479L+Qun/clik4TMvAwoCEuFxna9kCm1VLAtILUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukqgzqANSIAGsJp4J7SKf7jp4Bj+qgnOobwA5xWmE2k=;
 b=RSlfBO5jyxfQ/LdxdoH7sOPiVFIYzHwiUg4mxqleOt47xoLFFbXwCkQ8tfps3S2DU9K/WKxI5MZLl29x0duFH2RUkMl4Djd0GYyvCSILfeZpaWfRUPMtC8nraw/Vo4+ppEOZKfgLbFIef+33teNcaWOfeCxpaTyk8MqX1XNaxt1K1vAoVJ37KgtBPR/znBYfZb2WAaEKnlcpdpWCPM4akbPkM/8vFGuJiYL6pUQTfqokAav6bL4Us0cTyWpsUSkOrR5mUJ3S6d/YQNPvP3zCTFoPZIOusRi6Tl1HiBbhgDSNBpYo+0i6sdqpqrc05P/NE7LIvO+anBgPxZYrn6mDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukqgzqANSIAGsJp4J7SKf7jp4Bj+qgnOobwA5xWmE2k=;
 b=IDwxc6TWmCbNRqK6bCHMwQxxa3s7zYK22lWOAEREapdwov3IRa0l71sIEbLAaf4bFCbQ3qUofH/n7eYdGOw68xGtlxGsiSIaVpSBnldP4o+vCYyxgFG0I5ED5UKahjbdD+BxhKbK56+rYdxAtv8VT8/AaTGv5e7Tm5bN/B7R4PPOPrzW6PjCudJwdVjWjr8siUIXROgers1a/ge2/GieIozcnJjlLZB7/c37b9BOYH89fhCmMNzI7DIK3k5G0BZCYMg45F7EUT4iELKiT61sknICMTlRF/DMpwda7wIlx+UOJIEeLzOI/0FgfrwppLZuTGRFSAfuLfhksxruUt0iJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4268.apcprd06.prod.outlook.com (2603:1096:4:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 13:24:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 13:24:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: fix to check warm_data_age_threshold
Date:   Tue, 17 Jan 2023 21:24:42 +0800
Message-Id: <20230117132442.77645-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a26637f-201b-4a9c-a9a6-08daf88e37cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GzplzLFHC+L2A2YTr/dYgEM5wl2BFR+86K2xgBvtKHK+afDSisfn1oGPBvJnaX6d7jLUPgBopJImdJ851BMA3aAn0PCoG0MZBqVNdBl3ZqsrvOg/g0EkZImh40Q9lMy68S7B6gyk+XGlCs4npYdvqinShVbT+nEKcdnakcTLILJGP+HoT7VcKB7w6YCOFTLeAVMUxI2ICaOLi8qh1NyvAp/t1otS2QqsMeiO3cTrJ1sCM8BlTFLLx2fiMJz85eoLvYqpGktxpmX2eu5/0g/ghRltwm+FIopJWBmjDJzEpxhDxyk4TN5II5bL4M0gqISDGOV7P/l7FxS141OplF0Bby5mK+cqfzDcW4dMZbTm3iYr8pn5edwhrRWDR6pwoeR1VjVTFcBS6fBn42YzfC1aB35yTtXnxEUAVQy3izac5LdFOkc2jGChVBCKJ5+nfFlZWKOWxpzunkSa0iT59LtVg7sNvxUJKqNFBxA8UNqybj7B/jRl7aXh0xauwPt3j0SPPbIWMY09EOAbBcccPkj+pRCIYg0mog8TslmoaFjSaHyHDSdvfvNvETMHsHKn6wqNZJy1DLXJCBQJt8PJZBrmPAisoBs2THAyZkHH5i+ImgFkpCyMYN50TOT2E8dGsWbi9a1v2cpzvTjVWU9Zh0XQbW/7sR2b0K/OoYB9Z4jGBQPHlWdsW+aqHaUxAUD+iiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199015)(2906002)(186003)(8936002)(26005)(4744005)(41300700001)(36756003)(5660300002)(6512007)(66946007)(38350700002)(66556008)(66476007)(4326008)(86362001)(52116002)(316002)(6666004)(1076003)(8676002)(6486002)(38100700002)(478600001)(83380400001)(107886003)(2616005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5DoyguF8g4xBQBm0tH6479bOIagYVR9hU4tODeEKlkhdf9my6d/G5FDYg5dR?=
 =?us-ascii?Q?5zpJLbwCOHSac3ttmNATYTmHgN9GWklC8rpE3/+Q4zm2EfcXWxTgAVqsEQPI?=
 =?us-ascii?Q?64yFFYgxyzHbZuX17ucCPqqy6t/d4W28yvhwno66Unq5tG6bzmok20YZAorM?=
 =?us-ascii?Q?ulEZKVeKNsLrDSRrziF+DS6ALEZ5Jc9PDhMu9uDduI0+gy57x2tIAYnxxbFs?=
 =?us-ascii?Q?2HGwEP6OcTj8TH3LJf9ACqQiG8xhMmJPVXyQYdlC5eRne4eEGayxngz5RKEZ?=
 =?us-ascii?Q?lKpzCnNgQ6lbYZNtZVn+L33L4nQ7K2yOgpWWb2IV/voWYiTkN5nYNpk1ZXHl?=
 =?us-ascii?Q?saBpzydc/FIcHSW6kS9kavGqOnWz2Rd3iMg66/0lqxBvRILzjjmNGGmJlELK?=
 =?us-ascii?Q?NOZL0VnVu286N8lllzHJDvyYAQrxJ2rYCGGEeIrsjg0LUy5BXELclTxCPc7J?=
 =?us-ascii?Q?yXLgWPWl8k0MZTukB1pJhoe3iFKsw5EkZVxy8DUM/QNhI32jiBikvT4x1tB2?=
 =?us-ascii?Q?wANa31w6QbhZQnXyuFJj/8pTOMU29mvibpp3v2uFm/Bkkc6PZ1wbLvXVxUEr?=
 =?us-ascii?Q?wa88vP+9e6nLXqXH+DO/+giLa+3+IA+JlVVRrp4jcIdvIRw/7jjgTlZaOkRw?=
 =?us-ascii?Q?bXrXiz4/MqxPeQdF8Cwoj+RsuVI1pK02y1V3DptnyuYv5tdNje134xGX2/gb?=
 =?us-ascii?Q?5tUtoRob05z7j2cMwYedmyo/TDV9pZ3yER4BLPY/Bn7kQ86W9e4h5qfsw8Ae?=
 =?us-ascii?Q?Wuhf8Xhw/T51qaeRHOX+DEQxSpfRnW00hbHFxwzwVvuiNw/Caxta0h8kLU+5?=
 =?us-ascii?Q?KbkKV4JDCj+yt9eGdy9hBJjUytewqwBhMfSfPjfNHY0gxLcqmaa5jHWGb3dC?=
 =?us-ascii?Q?D7zhQen7Aq7jTLLbta4BrRF9E5R6bjqVkyuAjlbPS7l8hjoPf6mF5cArTo49?=
 =?us-ascii?Q?w8b5erCGveoR9LuzFnYcwyryS9nx1+/waNOoQMh2CqOwXVYsrnxBh4Ujrs1Q?=
 =?us-ascii?Q?NzYwIyf7fxeOLjyJcm8UO/AXCoFNVF3TpBgIqYdhL0GRw9mYji6JyxQttL/e?=
 =?us-ascii?Q?0ZDGF5M6I26YV8u2g1LF1HEeMzdPcGbq7ZpNER7xJ05S/cV1d55+uiYJqsCE?=
 =?us-ascii?Q?qhF6Y3OTqQZAx+J1BdYqMePIGBh6EbkkgTGgH3DC94UIXl2NMQ1nt06Dc5FI?=
 =?us-ascii?Q?nO7pDKcjGRVE7q2MmvaVkrGcDsXDPMC/hJjavY9o3dQeR8T8HmyP6OuJKYQe?=
 =?us-ascii?Q?+GrHsTNmupyrYwOgr8sIb7fvRN4CxfVqu3RFv8taq6lLXiDJrUp/uqLGViPo?=
 =?us-ascii?Q?yCGAm0XCnmQaIWn2YEPPslPtFbnTZu7lMbCIte9QnM+nxI/Vx5OzAk7iETM4?=
 =?us-ascii?Q?7PXOIb2EvFeO3Ql6wxYUFYcKBLL6/9cGWVphpll8obpTV0qzAFCHhQ94BuC9?=
 =?us-ascii?Q?7loSP1/qOXOS4yVZujNAQeKkQqFo+hTf+nn39lKKa5m26/8XMblBsUlVgDaF?=
 =?us-ascii?Q?Vn/10O3vme47o1yLC/OYwitOEZyDwNNUtLDkIrFrwBPlnAB+ig/PJpLEtMFk?=
 =?us-ascii?Q?T/8r1MmpX8j8iRFNqimOTgdgi19iBtFzcR+flcEX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a26637f-201b-4a9c-a9a6-08daf88e37cc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:24:53.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cHSONvp9wzm/V10VRLqm+scOLwGaJPckCeb29Q1rjuyyjFTNX5fMXpykwUyarkI9Zo0SeecWxEAjv+MXA1S9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hot_data_age_threshold is a non-zero positive number, and
condition 2 includes condition 1, so there is no need to
additionally judge whether t is 0. And let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e396851a6dd1..3c6425f9ed0a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -689,7 +689,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	}
 
 	if (!strcmp(a->attr.name, "warm_data_age_threshold")) {
-		if (t == 0 || t <= sbi->hot_data_age_threshold)
+		if (t <= sbi->hot_data_age_threshold)
 			return -EINVAL;
 		if (t == *ui)
 			return count;
-- 
2.25.1

