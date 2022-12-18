Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99C64FE68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 11:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiLRKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 05:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiLRKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 05:19:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF1DEE3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:40 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s7so6406802plk.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+7GjecAQWYKdyIMijkjG0fslIItZloxZjhPMs3OBpw=;
        b=GB+cIi5ruQzrbOrlJbNzYlQ1gH9cgIK6ioIhYfetGCqlHswGzIRR+TzMfVrKR0C2sX
         n+F50/v7rHI0gvqm5BvXZClesXl4zQkvidtIZZF3tTXSePliVaxQ5fsuAGyppWUv0BLl
         Zx6Tbei1P6+mqoGTku/v3tvi92L60cjrk/4LQXalFfFxBVwUnUyfIIlxqKyrQgRHKJYX
         9zv9KGOVZttO1NiJX0T9p/YQlFONDN1Bjr2E3N+qVvpzDLUbKlZK+SLK0LhphmCGBbKd
         zUUqqJAai4NSOX6qTtT8hN8A00XODki6V9A2BBFy386HS7wkbQr73yRAmuTDPDa91/2M
         Uviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+7GjecAQWYKdyIMijkjG0fslIItZloxZjhPMs3OBpw=;
        b=WegJyFi2vVyutAFfQWeyZANDoZxN05/VpFi0gtxk7HBkYpaxbmCQ9MehvBqbeFZOLJ
         bUaWIsrf4PfFRLdwOHJ6j9mjLhhKBU4RmWn0aLBHrnUQ7y2nwd2ROrhcALnTX9IxKtBX
         w3Ki3DcfU/VAMOHp2uCGATP8GVggWwnrTb2595CGEkDIAcRtML4MEBFCPROk7SWGvb84
         uwHEG4zXdMKDyf6HAulMwDvFNXnJa1oBi1hBEVV+BWfq8i0KM+I/FRBxtbLDWah9L0m/
         Ig92iRgR2KiSuegmnXbuNG1GiH4h53fdnQMxSesVJYwUN8ZZejKZ2yO8N7HJ3xymMQgQ
         TXNw==
X-Gm-Message-State: ANoB5plQhBmNbmyGuEtsSUBOve0o40XgJgUMtHrB/hxpECX6z2fYJGt4
        bh543I9FeNc4hs4eJdrRDVY=
X-Google-Smtp-Source: AA0mqf5oVPeB5bhp8aKBFuvgIKkQpspt6mh+LJK000FqqtoAAMJTJ0x6zwvVmJvhrD0/w2mwwG2NjQ==
X-Received: by 2002:a17:902:d18b:b0:18f:8f1d:2352 with SMTP id m11-20020a170902d18b00b0018f8f1d2352mr26047426plb.30.1671358779463;
        Sun, 18 Dec 2022 02:19:39 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm4789791plb.53.2022.12.18.02.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:19:38 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Date:   Sun, 18 Dec 2022 19:19:00 +0900
Message-Id: <20221218101901.373450-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221218101901.373450-1-42.hyeyoo@gmail.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
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

%pGp format is used to print 'flags' field of struct page.
As some page flags (e.g. PG_buddy, see page-flags.h for more details)
are set in page_type field, introduce %pGt format which provides
human readable output of page_type.

Note that the sense of bits are different in page_type. if page_type is
0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
page_type is 0xffefffff. Clearing a bit means we set the bit.

Bits in page_type are inverted when printing page type names.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 Documentation/core-api/printk-formats.rst |  3 ++-
 include/trace/events/mmflags.h            |  7 ++++++
 lib/test_printf.c                         | 26 +++++++++++++++++++++++
 lib/vsprintf.c                            | 21 ++++++++++++++++++
 mm/debug.c                                |  5 +++++
 mm/internal.h                             |  1 +
 6 files changed, 62 insertions(+), 1 deletion(-)

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
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 8301912f8c25..57f52d00e761 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -138,6 +138,13 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 	__def_pageflag_names						\
 	) : "none"
 
+#define __def_pagetype_names						\
+	{PG_slab,			"slab"		},		\
+	{PG_offline,			"offline"	},		\
+	{PG_guard,			"guard"		},		\
+	{PG_table,			"table"		},		\
+	{PG_buddy,			"buddy"		}
+
 #if defined(CONFIG_X86)
 #define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
 #elif defined(CONFIG_PPC)
diff --git a/lib/test_printf.c b/lib/test_printf.c
index d34dc636b81c..e0d0770d5eec 100644
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
 	gfp |= __GFP_ATOMIC;
 	test(cmp_buffer, "%pGg", &gfp);
 
+	page_type = ~0;
+	page_type_test(page_type, "", cmp_buffer);
+
+	page_type = 10;
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
index 7f8e5f744e42..5ce6b359004a 100644
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
index bcf75a8b032d..b4ba6fd6051c 100644
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

