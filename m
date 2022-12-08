Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77F64719C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLHOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiLHOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:23:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505A98EBF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:22:26 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NSbqd15PNzJpDN;
        Thu,  8 Dec 2022 22:18:53 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 22:22:24 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wenchao Hao <haowenchao@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] cma:tracing: Print alloc result in trace_cma_alloc_finish
Date:   Thu, 8 Dec 2022 22:21:30 +0800
Message-ID: <20221208142130.1501195-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of allocation is not printed in trace_cma_alloc_finish
now, while it's important to do it so we can set filters to catch
specific error on allocation or trigger some operations on specific
error.

Although we have printed the result in log, but the log is
conditional and could not be filtered by tracing event.

What's more, it introduce little overhead to print this result.
The result of allocation is named as errorno in trace.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 include/trace/events/cma.h | 32 +++++++++++++++++++++++++++++---
 mm/cma.c                   |  2 +-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 3d708dae1542..ef75ea606ab2 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -91,12 +91,38 @@ TRACE_EVENT(cma_alloc_start,
 		  __entry->align)
 );
 
-DEFINE_EVENT(cma_alloc_class, cma_alloc_finish,
+TRACE_EVENT(cma_alloc_finish,
 
 	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
-		 unsigned long count, unsigned int align),
+		 unsigned long count, unsigned int align, int errorno),
 
-	TP_ARGS(name, pfn, page, count, align)
+	TP_ARGS(name, pfn, page, count, align, errorno),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned long, pfn)
+		__field(const struct page *, page)
+		__field(unsigned long, count)
+		__field(unsigned int, align)
+		__field(int, errorno)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->pfn = pfn;
+		__entry->page = page;
+		__entry->count = count;
+		__entry->align = align;
+		__entry->errorno = errorno;
+	),
+
+	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u errorno=%d",
+		  __get_str(name),
+		  __entry->pfn,
+		  __entry->page,
+		  __entry->count,
+		  __entry->align,
+		  __entry->errorno)
 );
 
 DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
diff --git a/mm/cma.c b/mm/cma.c
index 4a978e09547a..a75b17b03b66 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -491,7 +491,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		start = bitmap_no + mask + 1;
 	}
 
-	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
+	trace_cma_alloc_finish(cma->name, pfn, page, count, align, ret);
 
 	/*
 	 * CMA can allocate multiple page blocks, which results in different
-- 
2.32.0

