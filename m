Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6101361E280
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKFOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKFOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:05:57 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6B958F;
        Sun,  6 Nov 2022 06:05:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b11so8346888pjp.2;
        Sun, 06 Nov 2022 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smCLlLyTQyDwgc2ypyGBDtflgmLDspTngdUNottfTWg=;
        b=mc6yIRmuumqY0HGaWV/CJrfs3m3/Eiu6jlpSdE3xAB1eptE8MGjjeNCnMwrmPecCwn
         siWV69WENJ7VgEVkCtFq7MZBq0YmLCJ+Xx4IYokNr+UznTb4tIOxrIjKn9C5gM76GVtU
         3d1TP+IFqemIK4rJCAub6sTMoQC8ugbnc9MzLluN1FdaOd0/HfsAsjyAwAvvGRcJ5321
         6wE64QZq8LxIZVwFXtNT3HEADjK92f/vVNXheffQaAk1lBaO0z/vy/W4lAYK9C5gAiDA
         9JXJ7mvRQN66VKYcttbu1jTZGvWGl/fQW9sVXzJBMG8RykgM5cNdNcRogyhkXxFYa5Jr
         hfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smCLlLyTQyDwgc2ypyGBDtflgmLDspTngdUNottfTWg=;
        b=4bVSCQ15oG/dUYS0V3WB0FeqXDuwlTBfEK+CwzCqm7rcv5yA/A3zvXsHcNQoKiKwan
         ycKYcdGJgldtuKkWHAm/PEwYrmg+SkKRv0YXM6ev5JS3iYG41cEl1Lor+HJJGa6MPsI0
         5lhExAL1bcG0/4mhSBCD0D2dlWwzkuBkWBz61ilViOQxLirBXQJyyyEcTK+LANQSH4kd
         D+79xJYA/P/uVHeX3UOYmIa29Dwp7V2Goyn1lPr/P/+ESDQg+VHk+y1n6hIR5VyhR76O
         YixjzcTRiO5Wqbno6NB/1tJj7tw4uymdZSxhLHcNbErIFNalgghCJpFrR3L5N79tNV5P
         PWuw==
X-Gm-Message-State: ACrzQf1GNjhHWBroJQR3UKYI+pdnFrKE1AvlKHuy3d7OwFZYae8fgsft
        6LkPuA8t2NltnNn4QC3VLXU=
X-Google-Smtp-Source: AMsMyM7bpSnjkSlkuBLbex0k3sLCvvB6FqOdB99adAtFtItsRq1queNxOE9FQUp4MstN2Z7PA3hheA==
X-Received: by 2002:a17:90a:f306:b0:213:b191:f3bf with SMTP id ca6-20020a17090af30600b00213b191f3bfmr44387333pjb.237.1667743555703;
        Sun, 06 Nov 2022 06:05:55 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00172f6726d8esm3156197pln.277.2022.11.06.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 06:05:54 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 3/3] mm, printk: introduce new format %pGt for page_type
Date:   Sun,  6 Nov 2022 23:03:55 +0900
Message-Id: <20221106140355.294845-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221106140355.294845-1-42.hyeyoo@gmail.com>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_page() uses %pGp format to print 'flags' field of struct page.
As some page flags (e.g. PG_buddy, see page-flags.h for more details)
are set in page_type field, introduce %pGt format which provides
human readable output of page_type. And use it in dump_page().

Note that the sense of bits are different in page_type. if page_type is
0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
page_type is 0xffefffff. Clearing a bit means we set the bit. Bits in
page_type are inverted when printing type names.

Below is examples of dump_page(). One is just after alloc_pages() and
the other is after __SetPageSlab().

[    1.814728] page:ffffea000415e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105788
[    1.815961] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[    1.816443] page_type: 0xffffffff()
[    1.816704] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
[    1.817291] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[    1.817870] page dumped because: Before __SetPageSlab()

[    1.818258] page:ffffea000415e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105788
[    1.818857] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[    1.819250] page_type: 0xffefffff(slab)
[    1.819483] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
[    1.819947] raw: 0000000000000000 0000000000000000 00000001ffefffff 0000000000000000
[    1.820410] page dumped because: After __SetPageSlab()

Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 Documentation/core-api/printk-formats.rst |  3 ++-
 lib/test_printf.c                         | 23 ++++++++++++++++++++++
 lib/vsprintf.c                            | 24 +++++++++++++++++++++++
 mm/debug.c                                |  7 +++++++
 mm/internal.h                             |  1 +
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index dbe1aacc79d0..582e965508eb 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -575,12 +575,13 @@ The field width is passed by value, the bitmap is passed by reference.
 Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
 printing cpumask and nodemask.
 
-Flags bitfields such as page flags, gfp_flags
+Flags bitfields such as page flags, page_type, gfp_flags
 ---------------------------------------------
 
 ::
 
 	%pGp	0x17ffffc0002036(referenced|uptodate|lru|active|private|node=0|zone=2|lastcpupid=0x1fffff)
+	%pGt	0xffefffff(slab)
 	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
 	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index fe13de1bed5f..6b778a8ea44c 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -654,12 +654,26 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 	test(cmp_buf, "%pGp", &flags);
 }
 
+static void __init page_type_test(unsigned int page_type, const char *name,
+				  char *cmp_buf)
+{
+	unsigned long size;
+
+	size = scnprintf(cmp_buf, BUF_SIZE, "%#x(", page_type);
+	if (page_type_has_type(page_type))
+		size += scnprintf(cmp_buf + size, BUF_SIZE - size, "%s", name);
+
+	snprintf(cmp_buf + size, BUF_SIZE - size, ")");
+	test(cmp_buf, "%pGt", &page_type);
+}
+
 static void __init
 flags(void)
 {
 	unsigned long flags;
 	char *cmp_buffer;
 	gfp_t gfp;
+	unsigned int page_type;
 
 	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!cmp_buffer)
@@ -699,6 +713,15 @@ flags(void)
 	gfp |= __GFP_HIGH;
 	test(cmp_buffer, "%pGg", &gfp);
 
+	page_type = ~0;
+	page_type_test(page_type, "", cmp_buffer);
+
+	page_type = ~PG_slab;
+	page_type_test(page_type, "slab", cmp_buffer);
+
+	page_type = ~(PG_slab | PG_table | PG_buddy);
+	page_type_test(page_type, "slab|table|buddy", cmp_buffer);
+
 	kfree(cmp_buffer);
 }
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 24f37bab8bc1..d855b40e5cfd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2056,6 +2056,28 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 	return buf;
 }
 
+static
+char *format_page_type(char *buf, char *end, unsigned int page_type)
+{
+	if (!(page_type & PAGE_TYPE_BASE))
+		return string(buf, end, "no type for user-mapped page", default_str_spec);
+
+	buf = number(buf, end, page_type, default_flag_spec);
+
+	if (buf < end)
+		*buf = '(';
+	buf++;
+
+	if (page_type_has_type(page_type))
+		buf = format_flags(buf, end, ~page_type, pagetype_names);
+
+	if (buf < end)
+		*buf = ')';
+	buf++;
+
+	return buf;
+}
+
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -2069,6 +2091,8 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	switch (fmt[1]) {
 	case 'p':
 		return format_page_flags(buf, end, *(unsigned long *)flags_ptr);
+	case 't':
+		return format_page_type(buf, end, *(unsigned int *)flags_ptr);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
diff --git a/mm/debug.c b/mm/debug.c
index 0fd15ba70d16..bb7f2278abc5 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -36,6 +36,11 @@ const struct trace_print_flags pageflag_names[] = {
 	{0, NULL}
 };
 
+const struct trace_print_flags pagetype_names[] = {
+	__def_pagetype_names,
+	{0, NULL}
+};
+
 const struct trace_print_flags gfpflag_names[] = {
 	__def_gfpflag_names,
 	{0, NULL}
@@ -114,6 +119,8 @@ static void __dump_page(struct page *page)
 
 	pr_warn("%sflags: %pGp%s\n", type, &head->flags,
 		page_cma ? " CMA" : "");
+	pr_warn("page_type: %pGt\n", &head->page_type);
+
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
diff --git a/mm/internal.h b/mm/internal.h
index cb4c663a714e..956eaa9f12c0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -773,6 +773,7 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
+extern const struct trace_print_flags pagetype_names[];
 extern const struct trace_print_flags vmaflag_names[];
 extern const struct trace_print_flags gfpflag_names[];
 
-- 
2.32.0

