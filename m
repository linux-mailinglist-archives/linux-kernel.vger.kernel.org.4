Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001EC6D0CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjC3Rbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC3Rbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:31:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F412CDF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX23K81XvUEoLeBFhAfDYJ80cFMqx4ww2bXJL/84IR8RJgmlyfhtTwgzwnITqAmpnAYskZPOOSWnowl8jkCnnXVbTT2cyjRWcApkn4j/hH1JQ/lk9tNTLx0P4W0N21V0ypir4/w0p/rLr1BzMsH3iUCqilr/JJMMr4Go7f6Weiri2Fu9MZax2Ukw3O/LPaEnp0m6GUd+bKWhmxzm7OvAYZ9MVGTZMvqAeDyGNg12VQdDl03+2cUfvOp9cT9qnx65OEMrCCpHME8mV8qkd9+QUxuVndg0eZ+wtjlZFOeAWeRkLIO7Z1H+FwSr43hHg8LsRyf5jbXJ2jHYiUelpbmDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG24xqXboo6CB+CG9U0cTzGZ0Tbw9Kj5T8PTRKQTDM4=;
 b=Gsz6kiWD20bBZTECuP2DJPIZTt1dRtVqFq3nQRBKdVDsk6RSsCJz+jQuwY0sAavpc2jnzyEfJCk73bY80EzYvUyAG24FixCzeRlo+zebjHd9BHnf25/8NFcCHYxTbvbROXrt9fDrnvMpXRPBpxJQg8AF9X+NnH2fe58MsUInBssH7oJ3ntz36YL0Sflk2evVf9SKa+Sy4BlUCiTefCd5o22j1/1nMlkHxN6NEEj1y3xeOM+ejosXezhFtd+4nRG1dXs8dqI0vOAKOjwFEAlPwnT8OLHupIP1WCHfbX/LsMhqKCXWY4a1rEOARmwbjdr1QTHrv34J27i354Hb3TDAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG24xqXboo6CB+CG9U0cTzGZ0Tbw9Kj5T8PTRKQTDM4=;
 b=etiWwSkEUYtV59RJXUBRKXn5KuoYDD8j4YK/wIdDgrMnAHxp8w9mVf+ShSIYikoWWsRQJE5mnuS5gcpBqRNkRFJD6po1vo0V7wKTWET1SOLcWUbTJONLZrRjBO81bbmBAJ8E5EBLmGRBf478ylsZ+WpiMul2ZqRnWwsxR3PxmExvFqT7jYPtDm2o1ti6gSckN7mWMN0xqYqsmueD9pScvPqiCKkwLyuJH33MWJW2N7CoAMcVkixd3NlbzNG5hx5wOYyAo4aPsXABKyvCZP4NZebF9dtowIdyrJ6KDYf6jIUgpXpatZxB/9V6LnlcImzbNybW0YlCcuICk5Sb/vMRjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4297.apcprd06.prod.outlook.com (2603:1096:4:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 17:31:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 17:31:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: support to show noage_extent_cache mount option
Date:   Fri, 31 Mar 2023 01:31:27 +0800
Message-Id: <20230330173127.46900-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 917c3a1a-7c46-4b94-042d-08db31449dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFAey+AS8O9Nw42AUi1ZWHoYHZFTo7cdHuPhHzaQ7I+6BMVDV5xoqXKihopqBgkN1J5vEv86hLcvLq5vuOhOu4Ry6IGyXtpgaloKBFiH544j4seF0XYkkzx5x8xNkWnzYbuFw37b4lVb9bk59uB0hODWjEEpOLE0gh/zxUbhYTdhArK+5qhcr79Q1XAod3HKJ8OY2uxNs/BUxhq+q5iZ7N3q/4WNwcSqZu5pHBCKMcCLux8QShMDtLj8uyXe1IGTbIYyjMGTue9hZLd2ONfh0oGExWHIieIQ5E9iFixADo3y4vuotiHtkRuM3WI4uqCKguvhFTtuWgE3gohVCXylIPAF00n5IZNNOXLW5G3+2gX4ZvSQ9PAwWrH801k6Zf03QPWNC4gj3+4cyRJe3IHRdag7y3txRPR8tKBIbw0uVXiMMcpKanWlbY42nmT339pss/gY3uq/6SIyvLJs4LPsDei2IiHWF+Bn2FQ/IiOQ0TAFQB5S8oNhNHVvbnSsXXSRyOGHhkutBS9Hq86Z4YEwyihFmYdtXQbZRkK8l4yR4q6JbGzizzjmgcKbr5pmyDHS/RLat751//DyNlVEJudBR9iiTdVMxrqSX7RW4KdF0Ljdxgdtq9I3ofXm/ziwznHG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(5660300002)(41300700001)(66556008)(8676002)(4326008)(66946007)(66476007)(6486002)(8936002)(2906002)(316002)(38350700002)(38100700002)(36756003)(52116002)(478600001)(86362001)(6666004)(83380400001)(186003)(107886003)(26005)(2616005)(6506007)(6512007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrMIxpLl5GEK+kgL1ksDHMPJBd7kGRa9vzWw14hKvTV9h4N6ye9AJDdNaDNo?=
 =?us-ascii?Q?DB7otCdXD5yEAB7optbjrqXCzHO0lUWsriKN0l3J1+q6G8RmXi1UfkqRTEaZ?=
 =?us-ascii?Q?KbhusvBks/BPKl0xkdffAgDgt1P6ATZmVCKNDuWzYadH0hctzwP+PoU8MxN/?=
 =?us-ascii?Q?ER1bv9BIQMigEKqnGb7341DFoSnzuPERIO8WoC9C2Jw1JSlKFxZjSL5kJxFD?=
 =?us-ascii?Q?GY/R13CQ/hagHz5z1b2eIoGQCeDWw/XVfb6hDY+9Hgix4ZeEhpF40OJTi1e2?=
 =?us-ascii?Q?UjgnKbWxYM1mV2ZsjwL5gh74SjF3hvyi83iyUUnrbFvQwsMgNmHWKC6PpKoJ?=
 =?us-ascii?Q?mhFTDmJb26zSD4hwhRwgnDBDcT6yTSomKYCaFh3BSUzQeel+ENy2HqIzBqlT?=
 =?us-ascii?Q?BIIFegAacfkM/sObyqhgIio9WeQLmuBsFc2/l7+uThkEeHgw5JtstHwS+mFe?=
 =?us-ascii?Q?SNRJf3YbePzeDst5vJtpvXVd/6wtvqr3qU+f8DtX5zi4X5h6wm6YsuYYz2Ci?=
 =?us-ascii?Q?6vlK2AxidwwCemkp0sQGDk6fwX1XFew2yBcFgaE/eV2NUFX2+krx6l3crIac?=
 =?us-ascii?Q?X43P8/dnzb9Wh67W3C1HwehyqdtqEviyfttVjTFMJyAzwVWyHSPGM/SFNsZw?=
 =?us-ascii?Q?TkVtkj/V61Bv7UV1Tg950B6nd+OpZiEWCDjUo9w+Pmd71B3OH/RzMDfz4AeX?=
 =?us-ascii?Q?RGilr8s+NN8pFwEiSumO3zzlWlQzV7DtjJqqD3VMOF40ev7M3H/dpYF+am06?=
 =?us-ascii?Q?BRfmjKjEUb2V45gRfXX7rF8oywBPKN65QBBbdYUxabVN/Z9wltVx95Ek/ffX?=
 =?us-ascii?Q?FqOZO8NU6wyWDKASqC26WNYnP+c9NVN8TQM9QuTpnAnhU/a1K/luVrY/ce2o?=
 =?us-ascii?Q?nb5f6Xn/hDbSkagauIXmJi/cZaXLQ/guwWERu9d4FGFITQ2exVW+VGcnVcP4?=
 =?us-ascii?Q?7h4OoNDxkFroC9okHH2rhu/Ct4L3UocYN7mqN6IMFXgcEiRoKQySzoyeNkvY?=
 =?us-ascii?Q?iUnPlggyV2COaj3Xxj4CMxcCDTUzLdfl+sCT+fkd7yVGKkE16BaJ9xnYPIrl?=
 =?us-ascii?Q?fxwwZ/cTLuBBHzHeRsvZ5KFlpiBnNqxhLhO8QKYNyLnwLeKXjxuxprn126Oj?=
 =?us-ascii?Q?AwlDIyqzMXGGtx72qdNIq60s5Jg0TmI9tMueMGYHRphec7h6jbrkX/W1gbBo?=
 =?us-ascii?Q?vHiyMqSa6pvJJUXGdBdxO6ko+lp2XpOqu93PrnAbBvA6GwFHPIL/Y7R3YHrG?=
 =?us-ascii?Q?I+mEKDVFoDF6zQZkjMXEQTX8oLzhTrjMwUBIaGkAJN/N0klN0NtQd+Vh48fc?=
 =?us-ascii?Q?6pGQAnBWxtMXzn+axtq92KZafPnXgqovI+t+VCGM9hjwnrFBB6Ix2K33xcUv?=
 =?us-ascii?Q?p9uIQNvWrb7QcplgoR7yCg60wG9UeREGyFcFpjDTZWUSCdXMmSKir5elNjMQ?=
 =?us-ascii?Q?VbjznCP22WgV6Y9popKABOsHLQPMDimPLWBclQyw1hpkJSj1miE5ThicFYWk?=
 =?us-ascii?Q?/wobENusg4dHcJOXypfhF2ilJvl4V3ujH4eCTMoaymtwjPb7JEYrXPwvweKM?=
 =?us-ascii?Q?AfOulcQKZs6VFZAttyessOR9GbOPjye7ssXtcU0V?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917c3a1a-7c46-4b94-042d-08db31449dae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:31:37.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICnJ8/SRGk9q8Get489W0rZQaORhKU6GoaV4F0z5w63zI4CjCEvNMVidaOn9S9o9I+5zR/ZcZKY7lVHbW8CFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4297
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch support noage_extent_cache mount option.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/filesystems/f2fs.rst | 2 ++
 fs/f2fs/super.c                    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index a81c896464ff..75505ab88de8 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -352,6 +352,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
 			 data block update frequency of the extent per inode, in
 			 order to provide better temperature hints for data block
 			 allocation.
+noage_extent_cache		 Disable an age extent cache based on rb-tree, see
+			 the above age_extent_cache mount option.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b5828a67f7c1..8bd9953ea7e3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -165,6 +165,7 @@ enum {
 	Opt_discard_unit,
 	Opt_memory_mode,
 	Opt_age_extent_cache,
+	Opt_noage_extent_cache,
 	Opt_err,
 };
 
@@ -244,6 +245,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_discard_unit, "discard_unit=%s"},
 	{Opt_memory_mode, "memory=%s"},
 	{Opt_age_extent_cache, "age_extent_cache"},
+	{Opt_noage_extent_cache, "noage_extent_cache"},
 	{Opt_err, NULL},
 };
 
@@ -1269,6 +1271,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_age_extent_cache:
 			set_opt(sbi, AGE_EXTENT_CACHE);
 			break;
+		case Opt_noage_extent_cache:
+			clear_opt(sbi, AGE_EXTENT_CACHE);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -1974,6 +1979,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",noextent_cache");
 	if (test_opt(sbi, AGE_EXTENT_CACHE))
 		seq_puts(seq, ",age_extent_cache");
+	else
+		seq_puts(seq, ",noage_extent_cache");
 	if (test_opt(sbi, DATA_FLUSH))
 		seq_puts(seq, ",data_flush");
 
-- 
2.35.1

