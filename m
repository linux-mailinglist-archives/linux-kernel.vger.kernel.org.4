Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473BE60C60D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJYIFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiJYIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:05:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB815FAE5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnlB77EC8slHXFmQWbSNZ9uLSdwxfJNxskxNdM2nV6/Qad2MtL8RCh8aAoWqEvoKmMsuFHu8imQYJDT+fFnCSA0HQKM44TvGJ2wuj6sDd4CgOhR7G+dT4ciZwfYP20L9uyDAX9noGydvbM/EwKrYsXBaQFcxMeiLXnTnLQ5VklIlGDkyEVjHDlX0cqW2l7t/r3MlynkHc/wakbh3nbTu4aVyLSStqDhZy8//lB3IyOioEGgZ32uYgkL/9vsznTvPFhYPn+3XgNdNfHgtUNPjzRrvtwy/GsGtmjIUPztWlPtyRGsMgNUuNHjh7ta0+f+3cI1RVdGsK10KJJYgC9WJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6mhdRo0rJ0G+OYhur+vjiwq9R07TyurOMjhIaGh4Zw=;
 b=apzOLIC4oerAOB5MGj6j/IThMVHqf8WgzWsH0FT1vkkkMcaP5NHR8w5R1/nkymqid+dZsJuwGkeVFf/lRue/DMBselX5cThIIM/UTnctvFPv3ESQTemrMbjx/9X/hpnj8FiR/QwxKbFPVwJdgjYdSJbt8aXAItwehlc7OPbV3aiaciUiVnSYj0die6uD8cPE2SekGDgiAjj6t61BUg83q7oNdZqvjPwQTwudA7MIp1Q/rr+NzjSmDOdxXvilJ8X+PMCoqBGshtFRkzH1O9ISTJ5l7NkDxss8inBXfY5Dw0YlKAfxbbKuqBiOmaAmyBe90W9oYprqkUYUajZ3/fYlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6mhdRo0rJ0G+OYhur+vjiwq9R07TyurOMjhIaGh4Zw=;
 b=ZYuYi+FnZwB9eiDfcbGTqpA9SRYjrVJPrRS9YVcGWZGmEncKeOU0u+TPTo0d6p/9BibCvKiNVG4b5zi3GvpJ2G4mWAg0hyFuomgz8v7NuRURmhXFz6E0UrMm+crZPo6sT12SEKofsnhyP9/o+Qcat6M1psmJ42173VI4BsLqUpPNaU5kqqjUUp4Iw9IP6FkELu0hV+8aj636DEeAWiT5uXid8ohFKju/FQBp6xLd/YetKNokErehPqdlCJMHhwX5JKbZn654O5cibUH1fnO3/0XkfbbdKuJxvS2ZoAAccBmJGEXqgUdNRYZGE3fzMIkGczzZ29k9ke1bpe/ORpwFXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5550.apcprd06.prod.outlook.com (2603:1096:820:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 08:05:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 08:05:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3] f2fs: cleanup in f2fs_create_flush_cmd_control()
Date:   Tue, 25 Oct 2022 16:05:26 +0800
Message-Id: <20221025080526.9331-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: ec435f05-32b2-4dc0-1598-08dab65fb247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HthUCvfyYySU40wTUl55b6cfhYXZ2Ea2pnKovp0va2oyb95mAl0J9IE9kj9i/eO3ZdycqeNiJ5k8hOu0g+bkB6zc4twBqq91NxYMd3eiDOhfwhO4okXGGC2gOnFCX/WPNFzUo/DAVp3wuYDe94YOpiUSXTkOuMaB+umtR00cmSZYrEftKAoXnThgropveHkbMUUHxdfB5Lx5FKNqCKRzH+4RKggA/anjZCL7n281qCWMu8A+eJ7FTmDDIuTsJxRYll4EmNSlrY+Hhqvam0kb8rkHlbXBx4c09YoxXJaO7rqGQ9hYxqIsQWE1OY7/t7klRXcM7k4kWC3BI3jV4dCq4G7jbnhVy4BGdJYW8JXE0anml3mpXIG5HQzy0cfY9++Ha+/iYpLw23BzmaceZWlrly2X3hvgCyWD2DUjPpfI6FcpLKoSC7doMCQ17MFi9XLkd4uVp4x7ZyuItz3MRjQlc0i8j1l6rhyHn/jWmARVkZiy1oLSYPLn11RgOgdv2raEkjHgyFxjcOhDuNalR2ssWx2+re0CgIC0T+JGHLladbp4uCBsdeq0cKoz85yokd4c41S1Pwos4nbOhkphZAUy3mofR1P43YUsFEwMZhMF24e/+fYTt+Z0LQrdUBPDqARr0/C6hfn/+LDQQgB+buMQF7uW0Z7Cl/53LmFnW6Z8irrLA2QKrSftIiZl8wxTliAiPX+07NnoseLPhJHG/Bo116JKf7SryRudbXm9P9h5cHscSKdJn8rl/sx0iuYGoVlxoiCqK1Nx7TFMEXU88N1HjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(2616005)(1076003)(186003)(86362001)(38100700002)(38350700002)(41300700001)(83380400001)(316002)(2906002)(8936002)(5660300002)(478600001)(6512007)(26005)(6486002)(107886003)(6666004)(6506007)(4326008)(52116002)(66946007)(8676002)(66476007)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?99ccrjmAuTZ3lfwRQqbSkOxQdjgeQxLS1cB1hiM9rOdprUG+gTvL+whjSBVJ?=
 =?us-ascii?Q?aMS9Mb1vNspzCfZOolqvIXFInKb1SURLcS5ElpCbUgLD3zbkmMVlW5Safdfw?=
 =?us-ascii?Q?xecjv2Q9nwPLljnNtI/ClRcZv/Ccdy58LsdOfoL4n+5fiO2eynlDcEDtu0a2?=
 =?us-ascii?Q?KI2JLomA/3GOvVwpljiccKUmZr4VIqydoxHJQA/CGX1orHTUgMrnQCX4F1GO?=
 =?us-ascii?Q?vpLekLYrQT3v8Bxl4WXklDiX114ZAnSy9qvJesEDa5brartF2HvAcl6FIuQr?=
 =?us-ascii?Q?U41LfvI2+6aVLG3ve69AGXITipo5nbLrwq9lrilz68J/HX0VnC1GBfgllZXz?=
 =?us-ascii?Q?QA9aYTggr5cQgNROMWE+2hAT4Ujruf6JeqQQfK/OQ/OE/8pSeO3Ng8yQqaEe?=
 =?us-ascii?Q?sxfn3zEzuWeA9BFymGoCsg4TiTq61ATl4WE7uXw+qwdAB9HqBHAqpuUn0C7v?=
 =?us-ascii?Q?aALtja6daiXoeUWeV1A1NfP0IyRZEYWCDJ/GA7xDx3KcgsgsL6/gHejtsX6p?=
 =?us-ascii?Q?3mOsIhAlgSsGXYEOgFWI95nk1xdNZBT5jvdwpRRyzjn2jU9n/NEBIt2VvZXh?=
 =?us-ascii?Q?8tcO1EryoMVZ3IWW2/UgYDZK/S8jwpV3simkTDubK0C63m6qhw30PvNhNFgQ?=
 =?us-ascii?Q?9zJNzgSV4iEhpTSVuZ25tvm15m9/N+egZ4T1zRdcVW4M8yBmR8vvWZ0a8wjJ?=
 =?us-ascii?Q?FJHRNA3IhYuNPULvbW7THD48pPPKXvNbapztwLwHAJQXcGeTRf215s+U/xie?=
 =?us-ascii?Q?DmP8tnOT6SZGBSwaIs2GkUZpgjkPff0d+9CZiJZLuhyZgI/YEtVCf2CT4qQm?=
 =?us-ascii?Q?HcwPUvEooBknfy84yjsvyomkUuHvQ1jZA+/FlTpSDBq9eZrHMRu9xuGxutGh?=
 =?us-ascii?Q?lWpaJIb1VGeXoRK2RWfon+v5HBhX+mGTcsN+qLTJMWwvLXmIudlih9Yoloyk?=
 =?us-ascii?Q?vNMNzdpufKjqA7kyrI7edolYm5Pqt3vjyBzoA+u1Egpp/H9U/xW3PYoRFzKy?=
 =?us-ascii?Q?ZjhW9MVqpYjOBCBsJt/lEsV6TvBsfgMGsox9ec7U/M4FIs0Xiy5ny5xzfD2p?=
 =?us-ascii?Q?6I+f/BXCdziC9udrI5A8FLgv2j0UlLQ83m3nvAiUrSu5Qygcq1J8X5GcmOKs?=
 =?us-ascii?Q?UQs7uXo+u+spp10LxLwpyvTvF4HMf56mrRTJRAr4RiAhyw+Fy+YktCXVkPL+?=
 =?us-ascii?Q?bThR7b/BADVghNP4oko+YFMiY5qHyIWoImFJdWyhzFet6ZfVbWKG98439bKa?=
 =?us-ascii?Q?Nar7GFNFR7HtRZbHUIzAEgG5pxU9cbadYwVjTCW9PzXbUM/vrBJtg5+uFej+?=
 =?us-ascii?Q?/wg7WBU5acaSqxjbeDWsGJ66u54HUbdxmNWcNcHeShLX/9CwDJbLOkmJgq1m?=
 =?us-ascii?Q?yndRXGQk5Avyy5TwY35g6i8TE861ZjaPpNUf13olz96WnC7VGbPavBMg/AUI?=
 =?us-ascii?Q?favKwWw8pZbUaU2HZvwWdmNkqF0mPBC19CmuAqFfKdErdhEdqrVhZ3YCVAFz?=
 =?us-ascii?Q?0FO5/faXmubRkq2GyeI2/zEvc89a83YndNRq7ZSm1tRUPrEUaMoFbSDxNZDU?=
 =?us-ascii?Q?1RMbX3Be6EOdAKRrXqH80mxvqYRdZ4Docc8zcmvb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec435f05-32b2-4dc0-1598-08dab65fb247
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:05:35.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbrvOXE5PoGtJsojsxZ92H3gaAU2SghaOrWEBf/AKtRKlr43EBLFQLOyppl2a38jQzto3k7t0EeXJOWamohIEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup for readable, no functional changes.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-avoid UAF
 fs/f2fs/segment.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..84a17607dfee 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -620,12 +620,12 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct flush_cmd_control *fcc;
-	int err = 0;
+	int err;
 
 	if (SM_I(sbi)->fcc_info) {
 		fcc = SM_I(sbi)->fcc_info;
 		if (fcc->f2fs_issue_flush)
-			return err;
+			return 0;
 		goto init_thread;
 	}
 
@@ -638,7 +638,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->fcc_info = fcc;
 	if (!test_opt(sbi, FLUSH_MERGE))
-		return err;
+		return 0;
 
 init_thread:
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
@@ -650,7 +650,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
-- 
2.25.1

