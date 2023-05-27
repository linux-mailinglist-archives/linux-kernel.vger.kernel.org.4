Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9145C7131E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjE0CRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjE0CRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:17:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE112A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:17:32 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QSlgZ4f5Rz18KDL;
        Sat, 27 May 2023 10:12:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 10:17:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <damon@lists.linux.dev>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>
Subject: [PATCH] mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()
Date:   Sat, 27 May 2023 10:33:30 +0800
Message-ID: <20230527023330.23535-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'aggr_interval' is smaller than 'sample_interval', max_nr_accesses becomes
zero which leads to divide error in damon_nr_accesses_to_accesses_bp(), let's
validate the values of them in damon_set_attrs() to fix it, which similar to
others attrs check.

Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d9ef62047bf5..91cff7f2997e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -551,6 +551,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
 		return -EINVAL;
+	if (attrs->sample_interval > attrs->aggr_interval)
+		return -EINVAL;
 
 	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
-- 
2.35.3

