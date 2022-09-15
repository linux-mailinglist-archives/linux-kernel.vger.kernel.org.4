Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473325B9CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIOOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIOOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:22:47 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102514361E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:22:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPtLfkE_1663251760;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPtLfkE_1663251760)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 22:22:41 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH V1 2/2] mm/damon/core: remove duplicate check about THP
Date:   Thu, 15 Sep 2022 22:22:37 +0800
Message-Id: <20220915142237.92529-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220915142237.92529-1-xhao@linux.alibaba.com>
References: <20220915142237.92529-1-xhao@linux.alibaba.com>
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

In damon_young_pmd_entry(), it calls pmd_trans_huge() to check whether
the OS supports THP, if CONFIG_TRANSPARENT_HUGEPAGE is not included,
the pmd_trans_huge() will return 0.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/vaddr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58bf1bbad530..21daaa5503fb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -434,7 +434,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct page *page;
 	struct damon_young_walk_private *priv = walk->private;

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (!pmd_present(*pmd)) {
@@ -462,7 +461,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}

 regular_page:
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */

 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return -EINVAL;
--
2.31.0
