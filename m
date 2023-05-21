Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75E70B1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjEUXHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEUXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 19:07:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3473DC3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 16:07:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae3f74c98bso163385ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684710461; x=1687302461;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIwsDcXIgqGabOrw2zINVCQbldk9zdIAC6OoUEGx+AQ=;
        b=Kq87XCymTREUT+OVcogWZjum+1CbBEkWMM1pjljQewkjdZWBEJt9ATHO6gRjNhv2h/
         eWKdio8rIBqOha0dRTe64GQq9M89S6B9QFu0SQBLWC7v95ubzIYjbBRdPIDG3Vt9Zb5f
         cp/FslnnDIFM3xVhqnYkdmAqXYvYYC2GTcJpZFZgxyVRw7HQD28jqXcCauvgH6Utp4xj
         aTbuKXgHPkb7TFL4nzn7U32K3P7NmoxEFdzmOKQ04yhR12Q5EDbrTxYOwIwpcvoSlt/I
         j/H0BYLfIWwFmaru2YzO7HOlMs4R6s+ACQcMasO9iXdf7RyjqQdzWxBZA5DVHYDP2I1z
         JKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684710461; x=1687302461;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIwsDcXIgqGabOrw2zINVCQbldk9zdIAC6OoUEGx+AQ=;
        b=BKUuPzpSdZXFdozORrDfFGpYp2QInSUenH3dSYKxAwQD4vAOEWqgDONb0Wrop+nn7H
         IRTtvmM8xrzar23JQ1PikvNGVDoXS/MloDD/Zwodsau09MNQ45mfxm0Ozahy0N2W26BW
         tSTeYqZ2lRmxJHDzbuWrCPi6nrZqnQknV3rgn90jaLFIuuKwvYxgb9NSonBEOiRoutUt
         LUXi9yff7l/9pWtQgjIhfBEu83sSa7yX92IIgfe7b3KwA5oRosIuGYV+DVQy6W6QQwq3
         DGN1MpfFucET6anlpBX492BHCygjYsOCpXyFrwIXr3MpTU3IFRKZp856jzDR4U4P0C8u
         qAkg==
X-Gm-Message-State: AC+VfDyVVW8NneATpq14w4+zI3cASo9k21YzHzjnzVy+t3OhfXpXSRlw
        rOWsG+7JTxbKe6wDm3bFzkNkpQ==
X-Google-Smtp-Source: ACHHUZ436D+0OgmobeGSeiZ+v/J8u3Cyb6uS0YRQ12TwEbqHtMzGvOzBVTCw8IZIdkwZgwL/Bp9mxg==
X-Received: by 2002:a17:902:cec4:b0:1ac:36e6:2801 with SMTP id d4-20020a170902cec400b001ac36e62801mr713442plg.12.1684710461498;
        Sun, 21 May 2023 16:07:41 -0700 (PDT)
Received: from [2620:0:1008:11:c77c:12d8:c868:4106] ([2620:0:1008:11:c77c:12d8:c868:4106])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b001a1a8e98e93sm3164121plk.287.2023.05.21.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 16:07:40 -0700 (PDT)
Date:   Sun, 21 May 2023 16:07:40 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
Message-ID: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_VM is used to enable additional MM debug checks at runtime.
This can be used to catch latent kernel bugs.

Because this is mainly used for debugging, it is seldom enabled in
production environments, including due to the added performance overhead.
Thus, the choice between VM_BUG_ON() and VM_WARN_ON() is somewhat loosely
defined.

VM_BUG_ON() is often used because debuggers would like to collect crash
dumps when unexpected conditions occur.

When CONFIG_DEBUG_VM is enabled on a very small set of production
deployments to catch any unexpected condition, however, VM_WARN_ON()
could be used as a substitute.  In these configurations, it would be
useful to surface the unexpected condition in the kernel log but not
panic the system.

In other words, it would be useful if checks done by CONFIG_DEBUG_ON
could both generate crash dumps for kernel developers *and* surface
issues but not crash depending on how it's configured.

 [ If it is really unsafe to continue operation, then BUG_ON() would be
   used instead so that the kernel panics regardless of whether
   CONFIG_DEBUG_VM is enabled or not. ]

Introduce the ability to suppress kernel panics when VM_BUG_ON*() variants
are used.  This leverages the existing vm_debug= kernel command line
option.

Additionally, this can reduce the risk of systems boot looping if
VM_BUG_ON() conditions are encountered during bootstrap.

Signed-off-by: David Rientjes <rientjes@google.com>
---
Note: the vm_debug= kernel parameter is only extensible for new debug
options, not for disabling existing debug options.

When adding the ability to selectively disable existing debug options,
such as in this patch, admins would need to know this future set of debug
options in advance.  In other words, if admins would like to preserve the
existing behavior of BUG() when VM_BUG_ON() is used after this patch, they
would have had to have the foresight to use vm_debug=B.

It would be useful to rewrite the vm_debug= interface to select the
specific options to disable rather than "disable all, and enable those
that are specified."  This could be done by making vm_debug only disable
the listed debug options rather than enabling them.

This change could be done before this patch is merged if that's the agreed
path forward.
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 include/linux/mmdebug.h                       | 20 ++++++++++++++-----
 mm/debug.c                                    | 14 ++++++++++++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6818,6 +6818,7 @@
 			debugging features.
 
 			Available options are:
+			  B	Enable panic on MM debug checks
 			  P	Enable page structure init time poisoning
 			  -	Disable all of the above options
 
diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -13,34 +13,44 @@ void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
 
+extern bool debug_vm_bug_enabled;
+
 #ifdef CONFIG_DEBUG_VM
-#define VM_BUG_ON(cond) BUG_ON(cond)
+#define VM_BUG_ON(cond)							\
+	do {								\
+		if (unlikely(cond)) {					\
+			if (likely(debug_vm_bug_enabled))		\
+				BUG();					\
+			else						\
+				WARN_ON(1);				\
+		}							\
+	} while (0)
 #define VM_BUG_ON_PAGE(cond, page)					\
 	do {								\
 		if (unlikely(cond)) {					\
 			dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
-			BUG();						\
+			VM_BUG_ON(1);					\
 		}							\
 	} while (0)
 #define VM_BUG_ON_FOLIO(cond, folio)					\
 	do {								\
 		if (unlikely(cond)) {					\
 			dump_page(&folio->page, "VM_BUG_ON_FOLIO(" __stringify(cond)")");\
-			BUG();						\
+			VM_BUG_ON(1);					\
 		}							\
 	} while (0)
 #define VM_BUG_ON_VMA(cond, vma)					\
 	do {								\
 		if (unlikely(cond)) {					\
 			dump_vma(vma);					\
-			BUG();						\
+			VM_BUG_ON(1);					\
 		}							\
 	} while (0)
 #define VM_BUG_ON_MM(cond, mm)						\
 	do {								\
 		if (unlikely(cond)) {					\
 			dump_mm(mm);					\
-			BUG();						\
+			VM_BUG_ON(1);					\
 		}							\
 	} while (0)
 #define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
diff --git a/mm/debug.c b/mm/debug.c
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -224,10 +224,15 @@ void dump_mm(const struct mm_struct *mm)
 }
 EXPORT_SYMBOL(dump_mm);
 
+/* If disabled, warns but does not panic on added CONFIG_DEBUG_VM checks */
+bool debug_vm_bug_enabled = true;
+EXPORT_SYMBOL(debug_vm_bug_enabled);
+
 static bool page_init_poisoning __read_mostly = true;
 
 static int __init setup_vm_debug(char *str)
 {
+	bool __debug_vm_bug_enabled = true;
 	bool __page_init_poisoning = true;
 
 	/*
@@ -237,13 +242,17 @@ static int __init setup_vm_debug(char *str)
 	if (*str++ != '=' || !*str)
 		goto out;
 
+	__debug_vm_bug_enabled = false;
 	__page_init_poisoning = false;
 	if (*str == '-')
 		goto out;
 
 	while (*str) {
 		switch (tolower(*str)) {
-		case'p':
+		case 'b':
+			__debug_vm_bug_enabled = true;
+			break;
+		case 'p':
 			__page_init_poisoning = true;
 			break;
 		default:
@@ -254,9 +263,12 @@ static int __init setup_vm_debug(char *str)
 		str++;
 	}
 out:
+	if (debug_vm_bug_enabled && !__debug_vm_bug_enabled)
+		pr_warn("Panic on MM debug checks disabled by kernel command line option 'vm_debug'\n");
 	if (page_init_poisoning && !__page_init_poisoning)
 		pr_warn("Page struct poisoning disabled by kernel command line option 'vm_debug'\n");
 
+	debug_vm_bug_enabled = __debug_vm_bug_enabled;
 	page_init_poisoning = __page_init_poisoning;
 
 	return 1;
