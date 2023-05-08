Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D36FAC71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEHLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjEHLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:24:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA0E39B94
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:24:16 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QFJmJ4yNyzsRCL;
        Mon,  8 May 2023 19:22:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 19:24:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] mm: memory-failure: move sysctl register in memory_failure_init()
Date:   Mon, 8 May 2023 19:41:28 +0800
Message-ID: <20230508114128.37081-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230508114128.37081-1-wangkefeng.wang@huawei.com>
References: <20230508114128.37081-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

There is already a memory_failure_init(), don't add a new initcall,
move register_sysctl_init() into it to cleanup a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory-failure.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b663eca1f29..004a02f44271 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -123,7 +123,6 @@ const struct attribute_group memory_failure_attr_group = {
 	.attrs = memory_failure_attr,
 };
 
-#ifdef CONFIG_SYSCTL
 static struct ctl_table memory_failure_table[] = {
 	{
 		.procname	= "memory_failure_early_kill",
@@ -146,14 +145,6 @@ static struct ctl_table memory_failure_table[] = {
 	{ }
 };
 
-static int __init memory_failure_sysctl_init(void)
-{
-	register_sysctl_init("vm", memory_failure_table);
-	return 0;
-}
-late_initcall(memory_failure_sysctl_init);
-#endif /* CONFIG_SYSCTL */
-
 /*
  * Return values:
  *   1:   the page is dissolved (if needed) and taken off from buddy,
@@ -2441,6 +2432,8 @@ static int __init memory_failure_init(void)
 		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
 	}
 
+	register_sysctl_init("vm", memory_failure_table);
+
 	return 0;
 }
 core_initcall(memory_failure_init);
-- 
2.35.3

