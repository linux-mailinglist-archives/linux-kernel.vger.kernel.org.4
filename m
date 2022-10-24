Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63860609CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJXIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJXIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:34:38 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5851A229
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:34:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VSvcrBd_1666600470;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSvcrBd_1666600470)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 16:34:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, ying.huang@intel.com, ziy@nvidia.com,
        shy828301@gmail.com, apopple@nvidia.com,
        baolin.wang@linux.alibaba.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm: migrate: Fix return value if all subpages of THPs are migrated successfully
Date:   Mon, 24 Oct 2022 16:34:21 +0800
Message-Id: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During THP migration, if THPs are not migrated but they are split and all
subpages are migrated successfully, migrate_pages() will still return the
number of THP pages that were not migrated.  This will confuse the callers
of migrate_pages().  For example, the longterm pinning will failed though
all pages are migrated successfully.

Thus we should return 0 to indicate that all pages are migrated in this
case

Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
---
Changes from v2:
 - Add Fixes tag suggested by Yang Shi and Huang, Ying.
 - Drop 'nr_thp_split' validation suggested by Alistair.
 - Add reviewed tag from Alistair.
 - Update the commit message suggested by Andrew.
Changes from v1:
 - Fix the return value of migrate_pages() instead of fixing the
   callers' validation.
---
 mm/migrate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8e5eb6e..2eb16f8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1582,6 +1582,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	 */
 	list_splice(&ret_pages, from);
 
+	/*
+	 * Return 0 in case all subpages of fail-to-migrate THPs are
+	 * migrated successfully.
+	 */
+	if (list_empty(from))
+		rc = 0;
+
 	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
 	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-- 
1.8.3.1

