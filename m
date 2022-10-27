Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68F960F6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiJ0MIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiJ0MIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:08:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A196B03E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbg/8c0H5LKQTL5yTaJoMnzvYdPoNVYAfZLHkstV/X2WvQsnkmxKWYSLPkTGUlSooHHN6bXlTdzER64z0d6PmNqzousbAV2tnCcbasVMJbOlrZ0X7ZRShCrjGl0g3MocICYzk/nmRy4qzbWw++Y+w6haiqZy1jKgythdz1RdmH6NWOtYghHZeAERmcQu5WOfMgkbLdxT6H40LeJ2jWG1h9ynZhiqF5LQMfScijqSutkyQOWji97rJVTZ1HT1CkMdBTQraWnSSKtSMN0VRaX4Mr2eo5RnJc6I9S4dB/5un68jfY1DrOH6cH9nzzHk3Zg3r59784AOWHZPdyJ2Fy4bUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YtFBksY2m45tgD3PKbTXJC+mVQ36+UJNFhpAC0UhIU=;
 b=oepfvvkEUD64sOEeuAux1WEsFmjJR/QASHpXAu4kQtClY/VlsBb7kohexL/PZxY7/aUCcUNLliScn/daur4DuW53OZMckNP/evL6M/dymH93h+7AjS2Xrm8FgwLdesNvvxBYvPXIjbRZw6nwM7Q8baxmzeoOh+5LvhZBYjxGNGB32MQKwi863jlYhahKpDAG+QviZZPwg4AT/xBpqGDyBCZ7bfhRTEvGW+HFUwELX+K5LLcNWQ5xGM06MADNhkQBK0DmjjlI4w5wyrP/NaoaZr240AvD2UKt8pkUOejhqSSd9CLjp+GHXKLhb3WrjcH27maJ2wo7kC7eXB+m07BHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YtFBksY2m45tgD3PKbTXJC+mVQ36+UJNFhpAC0UhIU=;
 b=a9M3bWpMnlXK0uxCVZKBFfYniltp0YTAXMys8jylO4+H1woRzAg12c8sPMF6hrxn6BQl2SEKjfEhyBQce5p+5KWcUc+WZ6PEbXYpkyxUmtKKNyfjdrfG9/HVn3LqppFqV7x8xdIUvWmgNsLdEwUDVvuv10+DaAyXxOGa08ll7Dj02OaYSSoKY7XND9MwQAOW8M3klQauvej3LV0Izu13BNLp6kGDekWBR7BRqDdDN4r3WWOVBym8UzntYM1h8ao/opiqAhmxptbD2fsDI/dvCYxQQe9tvviy3svEGkgqUJLlBMFYpEF0M7OLjlQAQyWa15T04mwNM5EdZ9vvgxm1Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4468.apcprd06.prod.outlook.com (2603:1096:820:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 12:08:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 12:08:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/3] f2fs: rename flush_error_work() to f2fs_record_error_work()
Date:   Thu, 27 Oct 2022 20:08:05 +0800
Message-Id: <20221027120807.6337-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a795a56-99e9-4dbd-06cc-08dab813eedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9z7lCcxZT0ejF9rp4ip75V7Mqwbch4efHFEsYXClSKhPnYiUiIZfXAttwUYkJapHNDmTyYMp4v6Cglp1OiY1c7UhwUDZDc3d7mESpKKci0KtZ6NIWdpAFZzFaYQDrhf2qBRGdyQGMhdLJg71nFHobnEpbmWsmjLzcoG7SjbJ2Bn+5UIPk+fpm6ZFeP5dSL4t2MWBQlSmxIXIYlRVel23BpdPA8ahD8rIBFGIb2U9320P/n8UZHxCGvEj9W7Hd1FOOnH0pUJNxaiQ3MrhheTZpksSdvRwQbCJfmG9Qzlfg+5pXOo5qRG9Is8Sa135M2rV9IhHUq/Xbfdf09S7nmWpuFGSnIsumq4oAfD/Uz8/wskUZAF4aEYDi5TNYKOdzl/jwLJ+52t/TnoUCw2XPHGiwGvg5y0wtyshdgHhUiohT15SPZDau3UOX+Ozww3u7zuxKiaatLPR3g7ZPQFocY4H842DBFDZUt2vZcfT5Y43oyIVp7mKiSF7NXYjKWMtuEvFmK7UP3TVoaqbKgNnpsO/tsLp4uqOBjMlL203JBhArXtK/X+7SFZqNxhQaiJm3O2qkAEgX0CmMcDRQUWPe/NPYH8V8eYu6lbMlEKCZGi5eP6eAfHFutajR8zcfRvKv4LD1FP0BGric/7ExfALPuUn3G+QGW303GvXCSyDI3X9wTF77ot3R0AszSkFszdVl01ySYvSpjPYzQ9nBL9oyG1mz6S6+BEnK/dlH0G3SqIRkJTBMgfZYOgej4XY+kUAWJkuskuRCupqxzSRehuvqhRVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(36756003)(186003)(1076003)(6486002)(52116002)(83380400001)(6506007)(6666004)(478600001)(107886003)(2616005)(5660300002)(8936002)(66556008)(4326008)(26005)(38350700002)(38100700002)(316002)(6512007)(41300700001)(2906002)(66476007)(8676002)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3f8JQ4tu6Yha8D3F0WNv384iSNrgtijNsSCvkqFnVoy64YF5oqCqveiJ3625?=
 =?us-ascii?Q?2DOuJ2S8SLURQrNzh24cCb4OFqmn6p2LmbE9EYoQll7oMcGQi0jKuZAPUcEC?=
 =?us-ascii?Q?cQSNL8zzcvvu4Whe1lxFWa/hzzot41KnzZz4+npsrhRPA1t5mLHz66FRcTym?=
 =?us-ascii?Q?eV1ineO9BDIR5N0ExIfY2FkZvTmy7mjStR/3ksCvkbwXgVkRP2PK7k3ZzeDW?=
 =?us-ascii?Q?97Av41ofBhHx7pkaXYt9Pv30mO489WAr/OQ/qnMWpIecvzvAV4kjpPXb6U9a?=
 =?us-ascii?Q?5O3X3zigInMg/WQqk6+omLyZseySruPK7qN3XDgsLvCKkbML6Ms58v4BZvHL?=
 =?us-ascii?Q?zMSjR39JTbbs30wE8xHq3bDGW5M6p9FdKFxVZebO9oTpa7FWCHwB1ujfC/RO?=
 =?us-ascii?Q?HUWkq4wwUVdqMaFS8A5J9CkPpUoDE+71AU5XrO2oRd0TeX8NVYdj38iww3tp?=
 =?us-ascii?Q?JmrgTPpQHUyMNTSxP9F5UWxvIc751sdiCDNE5nd+oRI8JjKBPAjigAlqZVvh?=
 =?us-ascii?Q?JVOd+hw+5VrSCW3bqKwkyRNZSwKTYfqciL28Jpwxh1/BhSfr7pVi0++cZ0ND?=
 =?us-ascii?Q?L1TbqHN9/WizYRYAO2+t+PohcLZtvv+6uGt0ruMdxwFoU71ucZJcDZKd64a4?=
 =?us-ascii?Q?OU2LHBk/9jdCC21Sru78H8LpQ3fOfpxt8ldaHhTbICpRz8SoMOBG+tKfLbg6?=
 =?us-ascii?Q?CJw10kVcmpEr2YIMzVvaWuAaKnQk7o0dL7rTGIUYbTJvBEazKKO4akTwNuEz?=
 =?us-ascii?Q?+iHrn6hDBDHlUifpyzVrkWiOOaspb77xqzgB5oTAWKvPmPbiSiQackaSa6sY?=
 =?us-ascii?Q?w9eckUaqqgHZ3dJ+GbqR/kJkAP25tIr6myUjmfgmERZeoJVcE6pyLwc6oltO?=
 =?us-ascii?Q?bChrokJi82iqURL28URP6rpl8oZFDi4N+Kw+56pdafwCXWtqRc1hyCTypdhm?=
 =?us-ascii?Q?iAk7gCLSUkV8to967Ic2bGRSHSXE0M9c2E/VkMusfAZ7y8tKfwdTP9zIFE8t?=
 =?us-ascii?Q?910qdzm5ZiiCJTkVykUzTd1G3PQRGVgYS8odmeRs0aio5/A74YUgnI35a1Bz?=
 =?us-ascii?Q?BJoICxDSn5zCogJf73ff7939bJL7yV3Age9eOPoGMobwPflNzLoDiFzDdy7c?=
 =?us-ascii?Q?hn/xktNxR79rs4PqLQ2xIxRQnDx1wk3PxGOpsUryoyMIZiovBQcbGsKnjbg1?=
 =?us-ascii?Q?/JM89Bscqcg1eK0MGfUT5kA9tVEwuvlDUPww0mg63cweCvcGX4kWBoYuv6vC?=
 =?us-ascii?Q?wmjOdinbF2xjGJpZVKFQ4TTe1iEbtJGqGyihvq9sxvfzPoWOlAMZUsJDYrJe?=
 =?us-ascii?Q?6zNXJenFqtnfIu78O7juBfJ2SK+VT+89upfPWpt130+1AUc2ASWFn92MUbdy?=
 =?us-ascii?Q?8kY3Z66X0zCo3wbP34ZT59fv+3G7ZUYT3jt3iRu1NNl2bJEF7y63Vh2wY6GG?=
 =?us-ascii?Q?olL0FdAayBkoaATfI5UYYjZ4epuZCmRlnezgZvvKDAqwCFtqVsjvMxhB05RM?=
 =?us-ascii?Q?uJedUEDeeI8dVPc7rvEjsPQCFlVD7YEFLJHrzVl8PWBptYEaWJVif5tzLIPF?=
 =?us-ascii?Q?wlkE1brxM/r1HD7lOstTUS+Pm6+mv2mq5p+crDuN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a795a56-99e9-4dbd-06cc-08dab813eedc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 12:08:17.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IgFmGvEP0H7Lq9RBYKYleIZK+zuETQVpGaSoI9nFYYBKPOWoJMlUfDISELVuIKEvRUH6Bh4AknT14sriiDFGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it is an f2fs module, it is best to prefix function names
with f2fs_. At the same time, there is already a flush thread
and related functions in the system, rename flush_error_work()
to f2fs_record_error_work().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a241e4073f1d..fc220b5c5599 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4019,7 +4019,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	f2fs_stop_discard_thread(sbi);
 }
 
-static void flush_error_work(struct work_struct *work)
+static void f2fs_record_error_work(struct work_struct *work)
 {
 	struct f2fs_sb_info *sbi = container_of(work,
 					struct f2fs_sb_info, s_error_work);
@@ -4374,7 +4374,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_devices;
 	}
 
-	INIT_WORK(&sbi->s_error_work, flush_error_work);
+	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
 	spin_lock_init(&sbi->error_lock);
 	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
 	memcpy(sbi->stop_reason, raw_super->s_stop_reason, MAX_STOP_REASON);
-- 
2.25.1

