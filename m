Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5B713211
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjE0DEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE0DEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:04:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2482ED9;
        Fri, 26 May 2023 20:04:47 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QSmlw1WkrzLnb3;
        Sat, 27 May 2023 11:01:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 11:04:45 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <damon@lists.linux.dev>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()
Date:   Sat, 27 May 2023 11:21:01 +0800
Message-ID: <20230527032101.167788-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

If 'aggr_interval' is smaller than 'sample_interval', max_nr_accesses
in damon_nr_accesses_to_accesses_bp() becomes zero which leads to divide
error, let's validate the values of them in damon_set_attrs() to fix it,
which similar to others attrs check.

Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=841a46899768ec7bec67
Link: https://lore.kernel.org/damon/00000000000055fc4e05fc975bc2@google.com/
Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Cc: <stable@vger.kernel.org> # 6.3.x-
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: close checkpatch warning, add RB/cc stable, per SJ

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

