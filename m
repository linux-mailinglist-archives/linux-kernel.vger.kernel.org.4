Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7D6C1E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjCTRhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjCTRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:36:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A316326
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8IWWxCLdzKPFhlRMSsRylXwbDCSgqnpC9aHBBZmI9UZevnH35+RNWiP23xt11hA5vvhenB1BTCG9ohyaq06IJlyxik3ScELGfoA5Bj3PGeOZENfLxPOysMU2Q9O7rt4C4VMpvPS+oU1pM0GZTIiZIWu6zNDA/4pTdEvUcH3cKG1/6jYXQFZpoZ37URpr1di7vDbBLEVsSu8ifEstIZB1Ao3lmQmYTE/g1wcvOs5Yy25mejXGuM39aFI6MA3oQrT/jWYYfAuQlQ6EiKE9SM7O+aH8bPhDXtlpYiqPFA8eV3V7O+0voKMMhl8G/Ng3G8mnm5c2UEBjOYYyxjqGj9BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LVaPTCfjPYI1OJzN1Mri4Fv4VfkAhKNfWqasn0hEaI=;
 b=LSGA1jQXZCZTVGHwTcAYqPTm5UUHTIWCP9+gPDZ83e6GM1OpReBEPWl46BhHn1BrXPaKsZNf9oM4sWB4EgSNV4rzQul2KO0vngri4sI4NipfswvcEGm1BvDtnJvJrEK5yxAYC+57vfDKr76tB+KebEqNiB2N7pG8CNVSe+7T/tZkhIzF6UU4+JATNuv8Pw3HNXZEHAI6+F4ECCR3OKJcuulEKqix7u36gGzYae6Xn+tS/8IHxl2het9yLRjcpEvb5TpfkRAQziEfnoXVmBbNasBCFai7li8ne8o97CSfgG28MHgJOVDXQ3ZRUw1/rzBY3uLQr8gyZ53cHTunbYMbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LVaPTCfjPYI1OJzN1Mri4Fv4VfkAhKNfWqasn0hEaI=;
 b=N0Mbdvg/Mb6REp//EARyZtq+1oNJievJO0ZXBV8l3Vnrzf2Y7N806tayMNCz3vQQRvgTCbn2EaQSC7i7tDKlSTop2hKa/GbJfY5Kgm1A/RJUgsGlNwjMhJpViYh77krO6Z30kC9+ovOm3y1EZqKKV0VHopBQPL1QAMxHQgzZzaxNUMcOvruSxLIWWK6ZbsuntLk99jd5n5uuiizfDoTg8GLFD2kDISXzy9fHCt/sAFJPqbhKXVJmIAiIsSMM4+6VdKCnBd37+j+cNJYG7a/4WE0esklwtc1nbf7+s4Gu1CqJ3g9SoJcLpzk7SNQQbcvzonPzYhSKT9hMpGCn+RDYQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:31:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:31:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: remove else in f2fs_write_cache_pages()
Date:   Tue, 21 Mar 2023 01:31:36 +0800
Message-Id: <20230320173137.64413-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc44a12-3dc5-4993-77ac-08db2968fc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKNNAoSo9REsFKKUVNepxg+Qq00lfNH2bzih5Qyf0/Ngl1ix6UGDUeg2rrktCTK/OoeGAF0hDrofa9vUc7F7uk5zFy9LhpE7cwMcBmgiM53IHYVWwVUSiJlYM61W959o2gXIPCqyxtoilmOwAja/ZvS4Lspnn2twVS5xjWknXEOikzSOqOVk1oF/7/XASW6Yqn+aZpivFKtwOfzNDQpBeAK0f+Mpj2SvswDC3I7JHIe/BDKvulQAo4KJhgpnjuCeb7JH3JAY7DwIjwUhHanlEZRs264kfY4niTP51xwKpPXox8Tl23VTAfX3Ba/0U3EXhqn77dyDrEZIPMFxBaUusKh8Wjg8NoMHjRmUbahzu3pqm+T9WrbxgVPPrboHME87GmNUQ+8yPNtkXsxKW3fYOUxSUOVN9mpMEWtZq6FZd+1gh2rGXeYkIBbW+Vk3MYnCGpjMFovrizG8iiaoUP6Fn3wx5fz+75PvKUY+EYpnfk8drjDOv950oRKlICXfF/c1mFRlU2RBZ3BO03WDMQ+Mk6qT6mgOJaDyk7oi8nnpMyWCXRp25P/l9pxRStAjjK+/V5SLbadbzvRLQZ1Jt+qLmmF+bNCBXlWKXUJVw1BUY8TRHpMK5C4Z8uTGAOjScrcODdDwpf6wx1EEbFJEDG7WgdPyWpfiLaj1lZGH5aL2AMnRXDJm3OZ5u4iLb7CxU9RzRBuV9RsKJ5htR+HUudTaHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199018)(2616005)(41300700001)(52116002)(186003)(6486002)(4326008)(6666004)(83380400001)(478600001)(316002)(110136005)(8676002)(66476007)(66556008)(66946007)(6506007)(1076003)(6512007)(26005)(8936002)(4744005)(5660300002)(38100700002)(38350700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Po13rdLamcn8tcExQtIpZm32zlnbAG2wUrKycQRNmpYdkHNpvn/Qt7v5exUL?=
 =?us-ascii?Q?iLyuDXunEc/mrK3RaXuB6MVSzCHjNVWPKZSawm3+keJ35MPrjdmM+VrxERWG?=
 =?us-ascii?Q?fYr6dNUDMKcxXzqpOjnpwpnCaC5HICoi+/dz/LsI17fJkSQ1cmp3+1JCeYZc?=
 =?us-ascii?Q?9zMXt/CRsxuEiUo+EmLWk9PjyldNUuXyyNwWB72a3Jj0EGVZ6+o+Zpl1/3J8?=
 =?us-ascii?Q?uG0W/A4W++VhIdBAD4q4uAF196oyTsTza5iOIUq69a8iXVaDlEEAJqbIDPAe?=
 =?us-ascii?Q?HDtos8aln1jd/26HuPtdukNMLlNeuTBngmXwIpnKDUEiS3WVjR/W12SS9w9q?=
 =?us-ascii?Q?hglAfHc6mrQJ5HA/Z4kDMJ3xRui5yZoblZ33B9gc3t2UM9jysJQLazH8riAC?=
 =?us-ascii?Q?Oo97A52/coaCBXftz2E98ttUBSsoKQbIrZ60Uiid+0cNgMax89QB4bIY4GNk?=
 =?us-ascii?Q?w6uYNMH48sBY0Fsb+df5xbbynWr37hqH/36QLTVKvsV5wb9BMt14lK2bE/+p?=
 =?us-ascii?Q?2993jLtdwoK5XZgtoQWffmtkfSGKZUgtbXVf3fu9ry6OTdsli80rqGAaLTA+?=
 =?us-ascii?Q?I8FKG1VK7jzpkwhsXJcuRvrLD/lSXp4wz6BwFaTAzPxwp7DoMuQnwu4193uS?=
 =?us-ascii?Q?Hc7HZU7xMhV0Ghy3lNqiS7z0jd22PXpsp5RdRaicst9KiYx43O2d9dwW6fV8?=
 =?us-ascii?Q?nJFqP5pzoDgAlOLyHwLLMI22mkcV75jvzyMIz+IMH8wzFZ8fxNo9UU7Eijqs?=
 =?us-ascii?Q?zr38L9yfNtg9TjBK7ZX7OHpuGVPyEGxHsjRWbYKz4+Z9fAQVfKJtX6OzGOcV?=
 =?us-ascii?Q?aw1LsmaChGFq6/e0lVfz4X6L1Cbi4+k5re3v10isL6WCH7gUQOFI54NJMClI?=
 =?us-ascii?Q?3dqahRP5jCbXt7IdLMrlC6DCQYP6vu/cpekaC4eaHuj0CRLG9gq4sMCdc+Yi?=
 =?us-ascii?Q?lJW6hn92y/NOjbOWORtYhfL0BYqpKZcdjdgMpmzpBCSbcOySGp/rV00KM3EC?=
 =?us-ascii?Q?cBfrH98w55rc7agtG6RrsOFCnpAoQr3pBjSR/6I4DVN/kZZxwcfchbY1oRL4?=
 =?us-ascii?Q?Ww0brKm59CM/OS3ve7ilY6o1mkfIRW0MCMAI+b5bIXiB0KyLbvDRT4WyXX4Y?=
 =?us-ascii?Q?Zw9x91B+6F0YccFqKVgbcjujnMq3PeWfARaziH74m6kgRuYnQ1B2MN+89sQ5?=
 =?us-ascii?Q?RNKrU0o9rp8Aien3vUnTBjgpox9XF9V429SbFt76Nv1NBX+3CdwkNyKaMnvr?=
 =?us-ascii?Q?iZMgOytWxGPY+gOXMEqpfzBSbz5g5/dlDaFA+7fMgzduxOM9YhAGjWgGfpUz?=
 =?us-ascii?Q?C79q40aTlEpcgBJwmVU9L2ES8Wi2vboy2rIeynCoHLQ+dKDjD7GT7d/48nZA?=
 =?us-ascii?Q?OcOyDu7HMGtYWpkPPzsiqlRN3VGKsNBc85VQDEWn60bIW937cA2aO9lBXhcu?=
 =?us-ascii?Q?8cM3/v3FUC7cfMKtvETwsTa8lCpbG+JNSmtT7xFMQTwLLRpi1dU0nFebECWY?=
 =?us-ascii?Q?yTTomA5NWADG9nNCvGsXh3YNM2wtJjLOk7o9qwBR13hO9/JFB8ikvNHq2bJ+?=
 =?us-ascii?Q?1oM6vWaro/rF0rB9Q1CNzexGoNJCb6p3QznVxJlc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc44a12-3dc5-4993-77ac-08db2968fc5d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:31:49.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJTHQnjj56/gCg8tWwEwLfPMgWaDv8yf87WxG2yl9f6Mllicu09OgwcrRnm/1xNktfziv9yLcFo3n8WnmbNwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Christoph Hellwig point out:

	Please avoid the else by doing the goto in the branch.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/data.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bf51e6e4eb64..fa931fb768e7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3123,12 +3123,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			}
 
 			if (folio_test_writeback(folio)) {
-				if (wbc->sync_mode != WB_SYNC_NONE)
-					f2fs_wait_on_page_writeback(
-							&folio->page,
-							DATA, true, true);
-				else
+				if (wbc->sync_mode == WB_SYNC_NONE)
 					goto continue_unlock;
+				f2fs_wait_on_page_writeback(&folio->page, DATA, true, true);
 			}
 
 			if (!folio_clear_dirty_for_io(folio))
-- 
2.35.1

