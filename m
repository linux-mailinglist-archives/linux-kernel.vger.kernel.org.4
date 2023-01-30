Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E527B6804F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjA3E0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjA3EZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:25:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A81C59F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso14190579pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwwzdAzQtrDpCWVBIKiBhOmPzUd7VlYgWQiD6C21IJ0=;
        b=RfLhOWGiR1DflwvehJodiK8eZGsp/vBq6+Phyd26hga+7Av2OBhSct+0XSH2B9FRzM
         p1m4/SQPUKR7nuT6kdKVjud9HnaisdGTqP1VRrO/3BwlrFVhBImkRKsi4K4VVNzjcjdn
         RAqpjAGeRVnTJPYjcazViD5yOdR3PZhnv4z0CbFzR6dqDpSAxiypyotLgJEFeCyZce89
         UyYEt7oiwQTWtM1yzJ0MzCOp3gSP1mICANOrnWpW0e2bnbSjr6gncWosiiu1EbAiAlHa
         2AcRJ8BLB3xryqSf4gogQqDj0vhzoMOIBasWKNCWxcwFhQCtBWdHd/KLlRPfEhnd3xb7
         dQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwwzdAzQtrDpCWVBIKiBhOmPzUd7VlYgWQiD6C21IJ0=;
        b=T41CDeAIMexsEFOm5aRNjD3tHOa/en6Wd7lwbreMPF2SXSojMTnOyTTHupBt9OJscP
         80yLCk/1XkjKJe1WLKYNtr3tac8jNT91/6sl/T88myDr1918GXy0W4sly/KY2jBRVJ5p
         ZZPlVygt0+jV+o+3xrg0ExuNtjapi6NMINKOzP0IsdHEDvYgA5L5BVe7Uh2ZXZbyeDau
         2jluUSbIzZBPr84fbKJrU3vTcOBG1cMVoet54PPtW+d8UqgV0oumxpGcrBsGZt0KyffR
         SWSzVtrBEDpR9ZXFGHggnGenoFkpz/VnfCjVfCZuj4/w3L/GZrXDhggEKNWQC9LzVDyv
         FnSQ==
X-Gm-Message-State: AFqh2krO9WxAMVMdUHKnThDfvF8Lucd02KhVWMcC1ocU1NlmnwJtv/SL
        7tIRYRqg4mePBRH8QgfTaM4=
X-Google-Smtp-Source: AMrXdXv0rqldkq324IZrmBFFJnO7fSD5oeWo9f+jtU8Ml/KRwPeLY0lgIYkFlO23Jcdrd2YCCrAdqA==
X-Received: by 2002:a05:6a20:3d86:b0:b8:d032:6486 with SMTP id s6-20020a056a203d8600b000b8d0326486mr67733142pzi.16.1675052745607;
        Sun, 29 Jan 2023 20:25:45 -0800 (PST)
Received: from localhost.localdomain ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 138-20020a621790000000b0059312530b54sm4275969pfx.180.2023.01.29.20.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:25:44 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable v4 2/3] mm, printk: introduce new format %pGt for page_type
Date:   Mon, 30 Jan 2023 13:25:13 +0900
Message-Id: <20230130042514.2418-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130042514.2418-1-42.hyeyoo@gmail.com>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%pGp format is used to display 'flags' field of a struct page.
However, some page flags (i.e. PG_buddy, see page-flags.h for more details)
are stored in page_type field. To display human-readable output of
page_type, introduce %pGt format.

It is important to note the meaning of bits are different in page_type.
if page_type is 0xffffffff, no flags are set. Setting PG_buddy (0x00000080)
flag results in a page_type of 0xffffff7f. Clearing a bit actually means
setting a flag. Bits in page_type are inverted when displaying type names.

Only values for which page_type_has_type() returns true are considered
as page_type, to avoid confusion with mapcount values. if it returns false,
only raw values are displayed and not page type names.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 Documentation/core-api/printk-formats.rst | 16 +++++++++-----
 include/linux/page-flags.h                |  7 +++++-
 include/trace/events/mmflags.h            |  8 +++++++
 lib/test_printf.c                         | 26 +++++++++++++++++++++++
 lib/vsprintf.c                            | 21 ++++++++++++++++++
 mm/debug.c                                |  5 +++++
 mm/internal.h                             |  1 +
 7 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index dbe1aacc79d0..dfe7e75a71de 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -575,20 +575,26 @@ The field width is passed by value, the bitmap is passed by reference.
 Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
 printing cpumask and nodemask.
 
-Flags bitfields such as page flags, gfp_flags
----------------------------------------------
+Flags bitfields such as page flags, page_type, gfp_flags
+--------------------------------------------------------
 
 ::
 
 	%pGp	0x17ffffc0002036(referenced|uptodate|lru|active|private|node=0|zone=2|lastcpupid=0x1fffff)
+	%pGt	0xffffff7f(buddy)
 	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
 	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
 
 For printing flags bitfields as a collection of symbolic constants that
 would construct the value. The type of flags is given by the third
-character. Currently supported are [p]age flags, [v]ma_flags (both
-expect ``unsigned long *``) and [g]fp_flags (expects ``gfp_t *``). The flag
-names and print order depends on the particular	type.
+character. Currently supported are:
+
+        - p - [p]age flags, expects value of type (``unsigned long *``)
+        - t - page [t]ype, expects value of type (``unsigned int *``)
+        - v - [v]ma_flags, expects value of type (``unsigned long *``)
+        - g - [g]fp_flags, expects value of type (``gfp_t *``)
+
+The flag names and print order depends on the particular type.
 
 Note that this format should not be used directly in the
 :c:func:`TP_printk()` part of a tracepoint. Instead, use the show_*_flags()
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a7e3a3405520..57287102c5bd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -926,9 +926,14 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
+static inline int page_type_has_type(unsigned int page_type)
+{
+	return (int)page_type < PAGE_MAPCOUNT_RESERVE;
+}
+
 static inline int page_has_type(struct page *page)
 {
-	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
+	return page_type_has_type(page->page_type);
 }
 
 #define PAGE_TYPE_OPS(uname, lname)					\
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index f453babe29b3..b28218b7998e 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -141,6 +141,14 @@ IF_HAVE_PG_SKIP_KASAN_POISON(skip_kasan_poison)
 	__def_pageflag_names						\
 	) : "none"
 
+#define DEF_PAGETYPE_NAME(_name) { PG_##_name, __stringify(_name) }
+
+#define __def_pagetype_names						\
+	DEF_PAGETYPE_NAME(offline),					\
+	DEF_PAGETYPE_NAME(guard),					\
+	DEF_PAGETYPE_NAME(table),					\
+	DEF_PAGETYPE_NAME(buddy)
+
 #if defined(CONFIG_X86)
 #define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
 #elif defined(CONFIG_PPC)
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 46b4e6c414a3..7677ebccf3c3 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -642,12 +642,26 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
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
@@ -687,6 +701,18 @@ flags(void)
 	gfp |= __GFP_HIGH;
 	test(cmp_buffer, "%pGg", &gfp);
 
+	page_type = ~0;
+	page_type_test(page_type, "", cmp_buffer);
+
+	page_type = 10;
+	page_type_test(page_type, "", cmp_buffer);
+
+	page_type = ~PG_buddy;
+	page_type_test(page_type, "buddy", cmp_buffer);
+
+	page_type = ~(PG_table | PG_buddy);
+	page_type_test(page_type, "table|buddy", cmp_buffer);
+
 	kfree(cmp_buffer);
 }
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index be71a03c936a..fbe320b5e89f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2052,6 +2052,25 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 	return buf;
 }
 
+static
+char *format_page_type(char *buf, char *end, unsigned int page_type)
+{
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
@@ -2065,6 +2084,8 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	switch (fmt[1]) {
 	case 'p':
 		return format_page_flags(buf, end, *(unsigned long *)flags_ptr);
+	case 't':
+		return format_page_type(buf, end, *(unsigned int *)flags_ptr);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
diff --git a/mm/debug.c b/mm/debug.c
index 96d594e16292..01cf0435723b 100644
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
diff --git a/mm/internal.h b/mm/internal.h
index 90bb2078444c..11c3258809a9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -802,6 +802,7 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
+extern const struct trace_print_flags pagetype_names[];
 extern const struct trace_print_flags vmaflag_names[];
 extern const struct trace_print_flags gfpflag_names[];
 
-- 
2.39.1

