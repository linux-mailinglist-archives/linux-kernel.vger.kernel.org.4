Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83426EA41E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDUGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDUGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:51:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061A100
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhjuSYw44bYeq6KZ8kh/3gbg2kwpIRXAasXHWyweucHv0l9uU04GtYWWGHmRj4DgjWiPB3pr/lTizUeCLYIiiVbcNTUQ4uNlCRXqJqqqwnKmPyV3DavrOfGJlo0InVLeyxpYaVVzeLW4eyCmSQofLFi8fNMxCTWkwTyW4JRcj/2MqMq5bYLrv4+F6ltkw54uHrAQQmGZQBWuECb8/tRcynIQO7vz5b05owrkwqjEveSstNUL1Ar/JCh/DYOvPpmv2/TQAEcLRLymFqmhcd2o9ZWW5IFCHWy/sPRjwPsx5cYnknaWtufzI6WcXlJ5oTX6ok10vi3sA5HcgSJctYMQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCR4w6ro0B7pJaP91SMp5xZIrRRl/wkdLH2Bv+EQ3aQ=;
 b=jyyr/327dK4Q1G0hB2q7FQEB0SIELRK2/KGPDTPKCT8EuXEfJrGnSAyWu8ZMDSDjmrlqqKykeuyq+GuD+N8L3lPo8CCz16cS9WZjwMv+LbMZ31ekfZxXrWplrjCdkLf6pfrH7UI2B1JPx+0j3VovQXTWMvMqBU2M1zzbp/Pl/V2DD/jtlveCu+ukF5mo684JcipqBoBHF4xDt7d24e3jQol1ucoztl2vDEUKb/pFidneMLivs+bnbugLmmr57TKIU7tbni9MEOKDZaXOJsCPfsUbilPUjFj2fvo/hdsY36q5TFOmxazkn/T0PSDuIA/X588Qt/JiM3pS7m4TBN7LjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCR4w6ro0B7pJaP91SMp5xZIrRRl/wkdLH2Bv+EQ3aQ=;
 b=kmgoIK5u6/hF7ssH/8NIG8rTqBuKkX4uXhmubj2dFQsyyak6MnHoAig7HFQ3p7KyGceQyTggIiZM1ui8+PeKVe6S1/HlGR7gtc/pDKOie0ZF2Ft92XIilUGXu4aRu6NTHs66XAIuO1jQIXQ596q2OOcC4Ly8xXJH29R3w7I9zA7a1mZtSm3QZ2sfuXTWVHirz1lXFtdIC2kImu9ZupJYA8aYyemDKt0nEALDVxpXoeYE/7orCkUl6z5Er8GLETZQYYSOQyZfKe+iRDfs8YxTSpCywPdBJBMEyAlZFCj/pz0Z4t8GUQvf/bDeq2IOM8pLDEWvvnu5gwf73nqIv3e5tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3223.apcprd06.prod.outlook.com (2603:1096:4:6e::22) by
 TY0PR06MB5380.apcprd06.prod.outlook.com (2603:1096:400:217::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.21; Fri, 21 Apr 2023 06:51:54 +0000
Received: from SG2PR06MB3223.apcprd06.prod.outlook.com
 ([fe80::9a48:6ff5:b14b:8c80]) by SG2PR06MB3223.apcprd06.prod.outlook.com
 ([fe80::9a48:6ff5:b14b:8c80%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 06:51:53 +0000
From:   Qi Han <hanqi@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs: move wrong comment to right place in __may_age_extent_tree
Date:   Fri, 21 Apr 2023 14:51:25 +0800
Message-Id: <20230421065125.44762-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230418060954.67585-1-hanqi@vivo.com>
References: <20230418060954.67585-1-hanqi@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To SG2PR06MB3223.apcprd06.prod.outlook.com
 (2603:1096:4:6e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3223:EE_|TY0PR06MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a1e8a2-7be0-4b1f-d362-08db4234e29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUI005h4rIeHmxwE0puCOjrr/BYNqcBTwQtabKWTszgDM+Zub9SVjatmUvZRD/fwZUOEJ3FlE3fXud4EOjBsLiCR4JpIXXQSnepX4nuX77YR555LkVNKFWnQRD0nONWQxfM85sQWQPl3vHCtdhISv/D9c6qPvSV+jfFh1yZ3OeFaBrt4auFUSctRFVJ0CqI/frC8naQLLmyMZdKzqqHoTa4ADWiQs314zcVYLdY0hIJJiXE9/8nqEBhiW5M+RvY4e0ijGAQuTKTUx4a/MewERJxfSKAnwYbRUP/BglWMstZE3A+4llI0eRVlJsT2D3lu6dzqmb0MsvilgyRw1jAGYE7VdHjNT1uymxifOqj9wAtq1N4SXylrJFkzAuyXMRtFw8L6Ht9JjGLxstik/GhTalz7wk8MY2/Jr6prYSNdkMPjqYIYakNJFjcdGi5zetrB2Q6mb+yWQLAYticcIfb2nwf17DPxd29owsUbmOSWHzARvLa3GanFDJuh1drmdhs+DRf4448ut/2qu2XK7Tivtd8Cr4WdaR8vH5HgfknjoFFDjJpqeK4XRLRfahYoh9dAJdjsLF2cmXMrZJPLli/d9Rfjf6rBCu6sESieBnoRH2WsKl6zfNZ2hc7fiQbKBxRE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3223.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(5660300002)(478600001)(8936002)(41300700001)(316002)(8676002)(4326008)(38100700002)(4744005)(66946007)(38350700002)(1076003)(26005)(6506007)(6512007)(107886003)(186003)(2906002)(2616005)(36756003)(66476007)(66556008)(52116002)(6486002)(86362001)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ZvNjV3aueHIfurIBwO1nwhnx4PYJ+NwRMfpRj4Nro46DXpePJub19tLDb5q?=
 =?us-ascii?Q?znqFzAS9BvFENBjZVwbGxUkEtzNIIWf9ioR+qapJYVaRUbfmct/x2SD1ZXEi?=
 =?us-ascii?Q?F4mosI+vTbmsIgHl8OD3CQVok5nii82fLUAD4HZ9ZSaG5amWNcF2app+h8yM?=
 =?us-ascii?Q?dyD9SnAuahVS9kQSngjH3eGqlovR7Gd3VwphjNR5EiE7BT+yvlsfHhbnPvbs?=
 =?us-ascii?Q?uNsPS771d44sErsEfrA15TKbeVC3Db4bOIjlHTKmA2n4Z+BzY1CTz7eKlBl/?=
 =?us-ascii?Q?LYn4BPbGUCQVfZx6WQpT+7lzHhnsVquKpvVx31++evsp3CzSnoGda7A07ZXR?=
 =?us-ascii?Q?e4ZTuhv9j6I0d36neHM4F/IYCxMgMsxn53D/CZaEp5s+7HOSzasAByKuWHEn?=
 =?us-ascii?Q?A+7EUEodiVp1UaZ1oRQFiHQah/S/jYAGHQk2i1ZQArzSH62IQdETXUbl0ITH?=
 =?us-ascii?Q?X0f8yxwCz8YkBCQDDMWYMpBl8NFWin8/DJB5QnQ2lVc81ISM8nCe60Tf7FWN?=
 =?us-ascii?Q?KNaEJ9Cgvl4ZJ0xX2Of5cjrArka15tFTdQoXGBhPp2i5OsuJR6qDwKLyPkGZ?=
 =?us-ascii?Q?m1sj8hZZuCeJzTZMCc1ciPm/ln4v1o0apjuGcINEEjrtJD83JQY9bMuiGLqy?=
 =?us-ascii?Q?t6J8S3QGzTcbu327PAGMdyZF/VXjhq02Dg8ZQNJKIdGaffYavcDlI3sY9NLE?=
 =?us-ascii?Q?ekfZyoy5AklzuBq44V2DpThxuF0y1TFJ4fkD+mkhiuwGwWTDPlSEyGYAnIaI?=
 =?us-ascii?Q?QbovffjK/y8aIU+St3Fx456lkkx+KfNqw7wjLJlQZDXWaxjXg2UYwgPE3V9N?=
 =?us-ascii?Q?I7pC4Jjoxp03f+2LPGTBkrGkJ8zTeOikuQQM46gfekt7A8UfEQS9gQllfkvd?=
 =?us-ascii?Q?71hNC1KwXDhTZ1AvV40xkaS2gcuVUKUSGdXAcFoOeDSK2fqF9+V4FwZXbV82?=
 =?us-ascii?Q?bMsNOUJqBVHN/ADxaVdmJPpqhCuFATX7w/5f+A+SbDUC9ZzqOH8F0OqlLm0I?=
 =?us-ascii?Q?42yvGi6wyTwxBZN7vJ9ZQ3llxHx+MvpE9NrVWS10rPP007wZ6+UrGXQLdUvu?=
 =?us-ascii?Q?2BKfXIMsYh9znXwcEq0QKBoH7HL6aqErxrmiKqFHdgmPONd+lbvN0o2UpFEy?=
 =?us-ascii?Q?CBC6D1zOsxZMQumle7xuh/8Y4f/UwhVXIguvWA0phcQ/jpJgxqosO5eWBbJB?=
 =?us-ascii?Q?5jqxMoIvItTb2LnXDlDoIZ0+yvoHTsmrXKiyTpB4IjAFJ9Df62e2JtV3k4To?=
 =?us-ascii?Q?NGLY5Fc1SLwqus7/BvWINICr4ATWY2USN8dpHHzWnEQEBmOHAy7/W6BXn4Y2?=
 =?us-ascii?Q?ZDScLMLCFEo7XL2qGiheJ6f8L9BVihk21JtINJF7zjK4RNbUNUIjG7RubtHa?=
 =?us-ascii?Q?7MJ+D86B1QxNjMNxlndiNmFTOcqyn4goWqrRo7FXhgVJSU70IIaEYZ1xU2Zh?=
 =?us-ascii?Q?OT6dq2JBqzEU47aOT9eRUJ0yn+uvO5ovP0i4VEa454hckpZxPPEr12YApfqI?=
 =?us-ascii?Q?rAGAeVPl3rBLZjsL6gT1TBIRx5aqCv69oQZjPcb3l6LlI2qCwwTl085E6L45?=
 =?us-ascii?Q?RMU3JQUYz45xrnAmRmm2RELFiubIGv4ndN6yokDW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a1e8a2-7be0-4b1f-d362-08db4234e29c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3223.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 06:51:53.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM0/yusS3ZpNgl84giLX0FQeqg8WICRNIakB6XHdtQ4tuBVroZQWRTp0O+qUj+8ZxAkAqsCHLm+52ghGMdMDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is commented in the wrong place, let's move it to the right
place.

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/extent_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 28b12553f2b3..0ad769a822ac 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -86,9 +86,9 @@ static bool __may_age_extent_tree(struct inode *inode)
 
 	if (!test_opt(sbi, AGE_EXTENT_CACHE))
 		return false;
-	/* don't cache block age info for cold file */
 	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
 		return false;
+	/* don't cache block age info for cold file */
 	if (file_is_cold(inode))
 		return false;
 
-- 
2.39.0

