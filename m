Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC735BD013
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiISPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:12:14 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1B2A734
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:12:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQEvWGD_1663600329;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQEvWGD_1663600329)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 23:12:09 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to simplify codes
Date:   Mon, 19 Sep 2022 23:12:01 +0800
Message-Id: <20220919151201.66696-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220919151201.66696-1-xhao@linux.alibaba.com>
References: <20220919151201.66696-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
we can use kzmalloc to alloc instance of the related structs, This makes
the function code much cleaner.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b852a75b9f39..06154ece7960 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -657,13 +657,7 @@ struct damon_sysfs_access_pattern {
 static
 struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
 {
-	struct damon_sysfs_access_pattern *access_pattern =
-		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
-
-	if (!access_pattern)
-		return NULL;
-	access_pattern->kobj = (struct kobject){};
-	return access_pattern;
+	return kzalloc(sizeof(struct damon_sysfs_access_pattern), GFP_KERNEL);
 }
 
 static int damon_sysfs_access_pattern_add_range_dir(
@@ -1620,12 +1614,7 @@ struct damon_sysfs_attrs {
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
 {
-	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
-
-	if (!attrs)
-		return NULL;
-	attrs->kobj = (struct kobject){};
-	return attrs;
+	return kzalloc(sizeof(struct damon_sysfs_attrs), GFP_KERNEL);
 }
 
 static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
-- 
2.31.0

