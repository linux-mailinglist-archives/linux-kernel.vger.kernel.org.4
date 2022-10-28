Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247E611496
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJ1Oak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJ1Oah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:30:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B78B2C9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRbd2cWrTLrIZGsnu/u4m6k5MOmQWWlQm6UB102fFPgX1eIhwpPEdY7zek4PbEtt3UWpdAj0jwOcqoG6XjyqJmd5L7tUhSjvPJbpgRWW9v9Bv6+tixgDI8NvQOJ8TZE+YsbSRZKs9BhdvHn7/sBZOHxBsBLjjbNsa7hHtV9fM8KJklwvPHR1vMe0rGkhfwiDsMxSQ/hG7qitIS3UCd6j/tDMdCu6mH9qnJ9fVcQWpcUmkyUnAeUHHvXWsMOGf0a48JcuInPpSIr4DYZyE0PTdVhCGs2E5cPF/PCmg/PKNlxFiTCnf95gSGKXq0A2mzn0V5GG2BK/d8xmLe/RE/VVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIHQY6kRjsGHtWVGB/mGnno7LPH0Wu1mVe2cu5SWP8I=;
 b=nnZ+KTIQqqQzZSlpSR1zKkNsCsmse3Itbh3eYZPCIqJtFUGsUgyPFFddCsKZPaL+RT28zlzjmLWQ9BwpWXxC+8C8ZLhJaxTcyiGHDTPp8l7novk+0pDnPnHwQVZdD08bIUqI1W/dkybdanxBt8QNVWP9WbgoBnnOcLBYKPF+mNE0gmwmDJ0Ex97GEEFpDRV9LVkzNvI851BjgWKe4PjZOdI32QCaw3NnS9lIMgYL/EYWTwYiT9wVUDlr5c+/PkW/dHdsPTDtLqubRAGOvX4bcc5qAzzclmvCZAv4/3IgbK1E87SSNCEYhFEJKuDsizVFrd108lymmr0EZImP8CVCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIHQY6kRjsGHtWVGB/mGnno7LPH0Wu1mVe2cu5SWP8I=;
 b=Pe0hnTBi/Ea0e55PxWhZI2SqXoTfUV7WmdzKtsDBhdViG5mMh57K9lhn3JTp3NwVOyysKUkidEfCntADDeVjnFrjfTwie/8DRxTXpcEs/eW9DnBoCVLXaAPruJO1U8Nz4YAMJgundp9mFWocNpAWGUM4em0x1pKgwocFm6jggWr+RzN2HGJhbeakKABiNQTiGkCUDW8Ce62m1J7bkIk5C8xZjRCH+FsetYmf+sKqsqM0jOd3/7P4L869UnvGkCTtsJchJTPbLfeQmc/hnYBZT78Ye7yMnK0xMFCSnaTuuseS0P/Z25AmlcVvM2PTxVwwZrt5nRq1IYBUTfap73dO6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5841.apcprd06.prod.outlook.com (2603:1096:400:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:30:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:30:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: stop issue discard if has fsck tag
Date:   Fri, 28 Oct 2022 22:30:22 +0800
Message-Id: <20221028143022.56476-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 1121728f-a8b2-40dc-e177-08dab8f0f7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ofmiqlhtw9RAyPFwWRIxOGAAnGt3cuhtI4EsaSMCHMjCZA6LyXoiBc0Ig5el9DH6lec89YgGzfWHyGTkU7V6qhiFAisL8HaKy/8jLcuZ65vvD3glJ0wOaMKbSSeRkBy2YGuiHfOe4GVNu8CoCBFBf1m9h+kbzj9GGmBohBQa//6lbvE3nN4d9gAAdvEa1Cc0JsfbHd2iaBFmJFE/ZXulbFZVgC1grfAqIDkyRQIIDtAss9Ijw2W4pllQlh+8jQ4S9Ycjmy7cy8leQNlNPscULMjaoVuykPXKHuj/33qAiP72j276p2vFtvtJLuRA+IqjTuKhelMJxOc1QMeBbKb5LavOlrFjFkdKVVgTWN5tt7leXjPif/29n68pz5M+YQkRkoywhL7S2Yilx2KY5xfDZYiyEUinZXSpEo5HtosfrMrJP9cCpoGslqnYAeW1aLcst+s9Jl18e6A03u77gIY4U986kqTWpkkQFGzdFCntevTyjQKFWUQ/0MvKfn1lYvDHvvfAHJLsDv+D3aMgcACLkhfsV/hBvrXwTM0xHBCWUwQsYod+QawKxIiMd+Em+OEqcs9biH94J3jYBfbXlXxUSeUMgzvWTrwfmHEUcYhmNFENPi4kkErwyHLhs+cSAF0Qpq66GIskIlB3zCATalwwtsrSNf7zT4z1cmXznYixKv2PoDs6HecC4M8YQ2t7aLfCsHOSJPzaiLdRvLeSeGZlNIl1/jKDSIz/QXdoe0+huUpu1sq54AhPBlrVckuCQXPBiiD9pE9MGgqpb437xZvTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199015)(26005)(6486002)(36756003)(5660300002)(2906002)(4744005)(4326008)(316002)(107886003)(8676002)(478600001)(6666004)(38350700002)(186003)(86362001)(38100700002)(6506007)(8936002)(1076003)(2616005)(6512007)(66476007)(41300700001)(66556008)(83380400001)(66946007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0+mLseSiRHb0BI/F7I/jLf6LRniw54p8f8Ezjl6ZITprbNRRQQlZ7CkO6nc?=
 =?us-ascii?Q?7V37hLT4OiXTOZzYnaByjmLd8QqLZKSfYbONpPpOozEFggluMxUr1AfIPpl4?=
 =?us-ascii?Q?iNwMvQv+yZfAnhAsFwrUexXTenFDjdhSh7elOONtOZNHHTXcx6eKLUyzvRP3?=
 =?us-ascii?Q?wJaSE7sG9hZQpRJvX5hOrJXtTpltxVqALasyqH+LaS+Q9BKctK8dTnDYi2t3?=
 =?us-ascii?Q?15TmIWSgH2crGzs9/NwPJE8LlrjVg4FaumDo55273NdbqFwnkmauvz0HWZPz?=
 =?us-ascii?Q?yUcXyXoxqXHkSQfN84PZg2/Mkuq5jaM/nlIvwS1pCMg4N2AhFAPvb0tAIG+W?=
 =?us-ascii?Q?KG7BaVpRPI4o0c1pdEO3P74GpiR+oghSAsnYONFclXBnz9ckEnAEy62HFQAs?=
 =?us-ascii?Q?y6eWGhN3EYCt3btv33AGw9BF9f/MxUFdeMMSN192eJi+0hcDP5uy87/gYOb2?=
 =?us-ascii?Q?K/aaDPd/nzSRKjNPiUVeA4XsI1N5OWW+ps9XAucKn/FbClM3d1/HIWFitiyY?=
 =?us-ascii?Q?utpHJSLKOPPGad8Ri6QZNv3T9Jq479Ro21o82rfdS0sMmi6BvjcRPls2NRlQ?=
 =?us-ascii?Q?V7ZKDSZdtXX3X7nbhY3mXtHktjEwXpXCHFJcyFbBhUWQwaTpdVj5wN4QaMjN?=
 =?us-ascii?Q?Rw5tlPsQEW7hhL+plbjID54lsRb8Hag6UwT9vnfijZTbEZupv7VKr/OqEqdC?=
 =?us-ascii?Q?V7vF/PclIovmJeyO+L9H8JgX5cEzep6LhnTNkhb+P+lFsfFbosxuDfOqRXB7?=
 =?us-ascii?Q?V8W653vevUCQNRMr7ptJkimPtuLpJfrIuAmqfkjoclFUQ0jjUjUNtSJkx2C+?=
 =?us-ascii?Q?0sQHZo4zhs0WqW7bOORXOiz4jInoJG3/9mIiIoZ4Ma5K2ZNJG7HmX8MpIo5x?=
 =?us-ascii?Q?gth+JVVuQEGv7RJO0BIfB1x36MWhTo733JBmVR/E3vDkCD3P0HS0SnzRIJuE?=
 =?us-ascii?Q?I0N5q3wDBb7LVzt6ffClDLmguOpZVxoOhQJWBLVkn98faW2BkRUUWp56h4Y1?=
 =?us-ascii?Q?L7KZIHN40Y/ZhKpQxcSS+IkqWEqOyWlA+0OKCYBqsElUh/MLdMkiBk3fwSgt?=
 =?us-ascii?Q?s3LwwQA+YhbwHdA7kmp1Lfp1tfBQg74oocoEQeXoQNHr+Q0v0z+T41as++Bm?=
 =?us-ascii?Q?kofwQVDXxPaX9k4SH0/VfJd22x5I8JMBt4WqAPhCAo8fVQYSb899lnjwkkr4?=
 =?us-ascii?Q?g4/HH0DFad2x/la3pt0Gmx8jcg94tr3ty2p3oW0PkqPYliDT4r5dj3Fds4+C?=
 =?us-ascii?Q?yvUta/chvVHA1IRILLozVJX6Ixvbsx46FgneiGGSCjruI24GpBqwEJs0dkEq?=
 =?us-ascii?Q?rwgH4/XxDlCsN4fRLokiuRb/AIjH5dhU/MRViGN3cJwHVwCdvmVj1XqvCF4h?=
 =?us-ascii?Q?ovnX5u03JV7sJhWBtXfeadR/DzM0fPyhPe5031EcaTYx9RBCc32zv+AdCfhl?=
 =?us-ascii?Q?sWCn1PbUx1TKf4YZ2+tnMgkwifl/N0DQXIB3Tx9+GwFy4jVjX2CgzkVktoWt?=
 =?us-ascii?Q?PEx/R2+aqwB3OmV9AkoosTS3lcpZ7a8Ibz1+y8F6oSHgxIFm06qgI7bu5Y5v?=
 =?us-ascii?Q?9aIpPV92RJX12ftQD0vemkrGGWjfCxvc0lTvIEcq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1121728f-a8b2-40dc-e177-08dab8f0f7f1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:30:32.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08kyCEgxIynJBWyZPH1iKUUpK4V7JrkZHC4cNTAt1/p5IMyFlNQhlcE22gxylfw6vIVwriR6VNKYE3ArT/Dgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under the current logic, after the fsck flag is set,
the discard thread will still run periodically.

Fixes: d618477473eb ("f2fs: stop issue discard if something wrong with f2fs")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7786351de429..b3600bcadfc7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1716,8 +1716,8 @@ static int issue_discard_thread(void *data)
 		if (kthread_should_stop())
 			return 0;
 		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
-			wait_ms = dpolicy.max_interval;
-			continue;
+			dcc->f2fs_issue_discard = NULL;
+			return 0;
 		}
 		if (!atomic_read(&dcc->discard_cmd_cnt))
 			continue;
-- 
2.25.1

