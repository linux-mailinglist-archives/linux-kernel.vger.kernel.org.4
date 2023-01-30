Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B66804F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjA3EZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3EZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:25:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383C4EEF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 78so6772074pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddl5ubdJXdhY37QXaqSPFuWOXoIoME8XjzTIYCn2FfM=;
        b=TrsrcayBW/ufr6B0b7ySUMgYrDdrlI1lmymJVug4Ai+xm9Efhi9PJpmJAq0XdcYAEi
         nQT+yasgYhwPxylv5Ay2NG7qWqlQEidG/nPOxhClNZYhEh1uCdBq6Cz66BopIlWiSax7
         ZyAW40TGTUCdLLapAVdvy0LIAAidA2fB8uXqJ2+s1diIMYaNAA50slhM1O5gSS1CO2/D
         BM0Q6Af/Vk/ESFCz1P/NZBOr74dhaWS7ufOGHTwk9VFYGKrE8iV/LHBDBXLClRsiB4ai
         VYKlqSwQ8MYwtAExxiSyESGSy1lnp8BlLj+/HPJSFN+MhPhMRElH7chEMLvlGGW9hRtm
         eRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ddl5ubdJXdhY37QXaqSPFuWOXoIoME8XjzTIYCn2FfM=;
        b=cbLlrM5GL8AxPhKK9gBCJHhuGtxq4sUOishqXV65QwdylXr2PemUbuGWxejzn5LZOV
         LHdmBubhzoypyoPqkdTGH8RlCNFzPCoNBlrTh1sLQ19bm6Zz7yd6OZ8h+YqcDuMq/Con
         n1NZqhmofaTeAq/1rl1lryL+zddnK5/cPLdOuUHeU1kln3VRGdbevUdZZWRgv7pxn+uP
         0SIkoIEsCfeZgYH5kuYSvdvtnQJ4W0/zwVQvf1wjfQU4tDJBUb0Ws0ks07NnAfBnYJIU
         xwoQvn31ZUoha9hLkAGcc4SWMJ/MdANYHoqjt09fLOctG+n7/mTrKLB9h8s+ZwlF4PJ/
         FOcA==
X-Gm-Message-State: AO0yUKVaYILb4cW5CZFS3nK7mJKMrysqPDLhVzYTlaW4bcjEaILkuc+5
        mPPLaoNDYEpUnxr7bYgb+zU1JcuibNys/g==
X-Google-Smtp-Source: AK7set/g64z3OvggFkD0Z2RB8lO0nvGTzCuFS0OJ7oPDugPEV5kn1VJtceRXiEDz6GS84tqVRQdhbg==
X-Received: by 2002:a62:1742:0:b0:590:772c:b990 with SMTP id 63-20020a621742000000b00590772cb990mr16502661pfx.15.1675052741760;
        Sun, 29 Jan 2023 20:25:41 -0800 (PST)
Received: from localhost.localdomain ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 138-20020a621790000000b0059312530b54sm4275969pfx.180.2023.01.29.20.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:25:40 -0800 (PST)
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
Subject: [PATCH mm-unstable v4 1/3] mmflags.h: use less error prone method to define pageflag_names
Date:   Mon, 30 Jan 2023 13:25:12 +0900
Message-Id: <20230130042514.2418-2-42.hyeyoo@gmail.com>
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

As suggested by Andy Shevchenko, use helper macro to decrease chances
of typo when defining pageflag_names.

Link: https://lore.kernel.org/lkml/Y6AycLbpjVzXM5I9@smile.fi.intel.com
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/trace/events/mmflags.h | 85 ++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 9db52bc4ce19..f453babe29b3 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -67,71 +67,74 @@
 	) : "none"
 
 #ifdef CONFIG_MMU
-#define IF_HAVE_PG_MLOCK(flag,string) ,{1UL << flag, string}
+#define IF_HAVE_PG_MLOCK(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_MLOCK(flag,string)
+#define IF_HAVE_PG_MLOCK(_name)
 #endif
 
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
-#define IF_HAVE_PG_UNCACHED(flag,string) ,{1UL << flag, string}
+#define IF_HAVE_PG_UNCACHED(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_UNCACHED(flag,string)
+#define IF_HAVE_PG_UNCACHED(_name)
 #endif
 
 #ifdef CONFIG_MEMORY_FAILURE
-#define IF_HAVE_PG_HWPOISON(flag,string) ,{1UL << flag, string}
+#define IF_HAVE_PG_HWPOISON(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_HWPOISON(flag,string)
+#define IF_HAVE_PG_HWPOISON(_name)
 #endif
 
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
-#define IF_HAVE_PG_IDLE(flag,string) ,{1UL << flag, string}
+#define IF_HAVE_PG_IDLE(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_IDLE(flag,string)
+#define IF_HAVE_PG_IDLE(_name)
 #endif
 
 #ifdef CONFIG_ARCH_USES_PG_ARCH_X
-#define IF_HAVE_PG_ARCH_X(flag,string) ,{1UL << flag, string}
+#define IF_HAVE_PG_ARCH_X(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_ARCH_X(flag,string)
+#define IF_HAVE_PG_ARCH_X(_name)
 #endif
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define IF_HAVE_PG_SKIP_KASAN_POISON(flag,string) ,{1UL << flag, string}
+#define IF_HAVE_PG_SKIP_KASAN_POISON(_name) \
+	,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_SKIP_KASAN_POISON(flag,string)
+#define IF_HAVE_PG_SKIP_KASAN_POISON(_name)
 #endif
 
+#define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
+
 #define __def_pageflag_names						\
-	{1UL << PG_locked,		"locked"	},		\
-	{1UL << PG_waiters,		"waiters"	},		\
-	{1UL << PG_error,		"error"		},		\
-	{1UL << PG_referenced,		"referenced"	},		\
-	{1UL << PG_uptodate,		"uptodate"	},		\
-	{1UL << PG_dirty,		"dirty"		},		\
-	{1UL << PG_lru,			"lru"		},		\
-	{1UL << PG_active,		"active"	},		\
-	{1UL << PG_workingset,		"workingset"	},		\
-	{1UL << PG_slab,		"slab"		},		\
-	{1UL << PG_owner_priv_1,	"owner_priv_1"	},		\
-	{1UL << PG_arch_1,		"arch_1"	},		\
-	{1UL << PG_reserved,		"reserved"	},		\
-	{1UL << PG_private,		"private"	},		\
-	{1UL << PG_private_2,		"private_2"	},		\
-	{1UL << PG_writeback,		"writeback"	},		\
-	{1UL << PG_head,		"head"		},		\
-	{1UL << PG_mappedtodisk,	"mappedtodisk"	},		\
-	{1UL << PG_reclaim,		"reclaim"	},		\
-	{1UL << PG_swapbacked,		"swapbacked"	},		\
-	{1UL << PG_unevictable,		"unevictable"	}		\
-IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
-IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
-IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
-IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
-IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
-IF_HAVE_PG_ARCH_X(PG_arch_2,		"arch_2"	)		\
-IF_HAVE_PG_ARCH_X(PG_arch_3,		"arch_3"	)		\
-IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
+	DEF_PAGEFLAG_NAME(locked),					\
+	DEF_PAGEFLAG_NAME(waiters),					\
+	DEF_PAGEFLAG_NAME(error),					\
+	DEF_PAGEFLAG_NAME(referenced),					\
+	DEF_PAGEFLAG_NAME(uptodate),					\
+	DEF_PAGEFLAG_NAME(dirty),					\
+	DEF_PAGEFLAG_NAME(lru),						\
+	DEF_PAGEFLAG_NAME(active),					\
+	DEF_PAGEFLAG_NAME(workingset),					\
+	DEF_PAGEFLAG_NAME(slab),					\
+	DEF_PAGEFLAG_NAME(owner_priv_1),				\
+	DEF_PAGEFLAG_NAME(arch_1),					\
+	DEF_PAGEFLAG_NAME(reserved),					\
+	DEF_PAGEFLAG_NAME(private),					\
+	DEF_PAGEFLAG_NAME(private_2),					\
+	DEF_PAGEFLAG_NAME(writeback),					\
+	DEF_PAGEFLAG_NAME(head),					\
+	DEF_PAGEFLAG_NAME(mappedtodisk),				\
+	DEF_PAGEFLAG_NAME(reclaim),					\
+	DEF_PAGEFLAG_NAME(swapbacked),					\
+	DEF_PAGEFLAG_NAME(unevictable)					\
+IF_HAVE_PG_MLOCK(mlocked)						\
+IF_HAVE_PG_UNCACHED(uncached)						\
+IF_HAVE_PG_HWPOISON(hwpoison)						\
+IF_HAVE_PG_IDLE(idle)							\
+IF_HAVE_PG_IDLE(young)							\
+IF_HAVE_PG_ARCH_X(arch_2)						\
+IF_HAVE_PG_ARCH_X(arch_3)						\
+IF_HAVE_PG_SKIP_KASAN_POISON(skip_kasan_poison)
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-- 
2.39.1

