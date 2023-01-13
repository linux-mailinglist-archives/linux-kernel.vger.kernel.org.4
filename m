Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F116690CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbjAMI1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbjAMI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:27:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D632254
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:13 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x4so11506005pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOTLi2okEkFS/8sRuephFsj+ueiTQYPyzZu8sNnyp7c=;
        b=DB756DEl2kGDqQ5rfDMa3lVd8k2XMke/NAVPJCDgsCtDEJg13Xz/fxlQsi6ARGID5t
         AQKoMIXe1XHUCwkTq9BXngkwHZsjAvHYQw0/pBvoLWIAEFrdypdAQctxhOs3ZzbtSDnn
         7DZfqdI4g8uFLqxGcSwnoMhj3WqPhdv9CrCy+9WNKhZSJZVoxzmhL4NWqFvbkenHT0Mi
         9pkheDnafz8YWI8jh6trHGmClw/7B1W1AvE6X2nkS4DKN0wRSCJqrxvfLdNofZxAu2HN
         3zQ3tSWjWchr7jZNG4+z5VYau6pQ5Dl5MVnyLHPrM1lnWYHZ0YoNQ9moxdvHbP9w8KmJ
         ph1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOTLi2okEkFS/8sRuephFsj+ueiTQYPyzZu8sNnyp7c=;
        b=O3SfVIqkhg4bhiUN+tKn5swoB1deTxoKucW1g7aLboW3/4Uuc6UMkdPuVMe5wVycly
         dYBMXqGrGiot0yZMNZZyFyEUTHB7wcdjGZrjIAGa+9sBxeTJzXje6F9/O/6hcgBn+Q5H
         F13VNliMalfg9zWzUd+xMMSIoQkJtKk9KZo7bS/ehoCWe701OXUBeOBt6pf/yQi+8zWd
         vmNL6VlY55zQbNmXdxw75HIaX54fvmtShs4jlDL5dq91ruB4v5z4dlO88WQ4SDD0rcoj
         zpbV7Hwfd2XtM0pQHBbq3CIwxAbSVQbXSN+8TAdSs149Kzcq/26EDfgKiTa0Q5AELy9o
         CvDw==
X-Gm-Message-State: AFqh2kp0vGPs6mVoaaeaGLmu7rJkK/ocfO3QBW4301fAPsAKnTC9GZei
        sZ4naRbIs+kF9GiWmkEyUe8rlA==
X-Google-Smtp-Source: AMrXdXulkzNesHhKgvQj9Q1syqtv8lKl4izjylagJ5dv+ZcAuCj2UKPdGjaoAGBSze8FhPfemMlcsQ==
X-Received: by 2002:a05:6a00:706:b0:580:d409:396c with SMTP id 6-20020a056a00070600b00580d409396cmr72502746pfl.6.1673598433479;
        Fri, 13 Jan 2023 00:27:13 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm13092738pfl.136.2023.01.13.00.27.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Jan 2023 00:27:13 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 2/3] memblock: Make finding index faster when modify regions.
Date:   Fri, 13 Jan 2023 16:26:58 +0800
Message-Id: <20230113082659.65276-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use binary search to find the index to modify regions in
memblock_add_range() and memblock_isolate_range(). Because the
arrangement of regions is ordered. It may be faster when there are
many regions. So implemented a binary search and a new macro to walk
regions.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/memblock.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 6eedcfc5dcc1..cb92770ac22e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -149,6 +149,11 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 	     i < memblock_type->cnt;					\
 	     i++, rgn = &memblock_type->regions[i])
 
+#define for_each_memblock_type_start(i, start, memblock_type, rgn)	\
+	for (i = start, rgn = &memblock_type->regions[i];		\
+	     i < memblock_type->cnt;					\
+	     i++, rgn = &memblock_type->regions[i])
+
 #define memblock_dbg(fmt, ...)						\
 	do {								\
 		if (memblock_debug)					\
@@ -181,6 +186,24 @@ static unsigned long __init_memblock memblock_addrs_overlap(phys_addr_t base1, p
 	return ((base1 < (base2 + size2)) && (base2 < (base1 + size1)));
 }
 
+/*
+ * Binary search for the first region not to the left of @base.
+ */
+static unsigned long __init_memblock memblock_lower_bound_region(struct memblock_type *type,
+								 phys_addr_t base)
+{
+	unsigned long idx, low_idx = 0, high_idx = type->cnt;
+
+	while (low_idx < high_idx) {
+		idx = (low_idx + high_idx) >> 1;
+		if (type->regions[idx].base + type->regions[idx].size <= base)
+			low_idx = idx + 1;
+		else
+			high_idx = idx;
+	}
+	return low_idx;
+}
+
 bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
 					phys_addr_t base, phys_addr_t size)
 {
@@ -581,7 +604,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, nr_new;
+	int idx, start_idx, nr_new;
 	struct memblock_region *rgn;
 
 	if (!size)
@@ -607,6 +630,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	 */
 	if (type->cnt * 2 + 1 <= type->max)
 		insert = true;
+	start_idx = memblock_lower_bound_region(type, base);
 
 repeat:
 	/*
@@ -617,7 +641,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	base = obase;
 	nr_new = 0;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for_each_memblock_type_start(idx, start_idx, type, rgn) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
@@ -737,7 +761,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 					int *start_rgn, int *end_rgn)
 {
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx;
+	int idx, start_idx;
 	struct memblock_region *rgn;
 
 	*start_rgn = *end_rgn = 0;
@@ -750,7 +774,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for_each_memblock_type(idx, type, rgn) {
+	start_idx = memblock_lower_bound_region(type, base);
+	for_each_memblock_type_start(idx, start_idx, type, rgn) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
-- 
2.20.1

