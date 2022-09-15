Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF95B9E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiIOPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiIOPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:06:30 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C5D2A24E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:29 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so13139213edz.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=78o9fcmZe1rakLyEcoaxPY9Q3UwZCgWFE2+savdbFCc=;
        b=rks9uNCmfYS/YqkY6U0g2qKgsPbMgCzE5to9YTQsDSGno7MLZ57OiRem/Dm1MXM0oH
         61AdLXN3KgyZyk6WUXmAHXD8aHWhS7pncFYrPm6r8+mhpSEOBaFzKjhqrmkb5ObvQynG
         3lyTmZNVq6qgxAzIWXhy+CSuzx0NPccWxOoEtJhpsVgel0Vw7Mfxk4UkKlJwhEMEQ0Fi
         2tZcO8IrdExLJ33Ih9HNh0SgckWNA8DiGItv4ZovRLvY24k9gTbd/QACNW+CdrW7i0mE
         8QR49AgHjVh9EsKUHDRNITyvpL24ACDRbhDaHoQexo2bF7giUI71j4WmqaXoSvQd5FNX
         krfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=78o9fcmZe1rakLyEcoaxPY9Q3UwZCgWFE2+savdbFCc=;
        b=sNLsCwuwDADOqP40ECud+pg//ODU+b7Tg4Xxpccut4uyvEHe6AzB9LkWiqZRBXNDHa
         FR/xYtDaK+X5qi29/87bRy+PbnEVGw0t55su1xpIRxOvOaRbmCSnzRbW1nfpr1yPgQdp
         dKs/fGTtdyieOSlEGBFrbXLAB08uVEsdDmJAEHZV2jOuvIBwpdRJIPue9hfqGua+YCRe
         P8uEf31M4RGFaYuLBEBrS3DM/2mbvVIDHBhje2TeQUPEiuAvhLW0P1PEKn6JsDy3rDUt
         rEL/JThud4gd4Gn0tGvN27JDGPRojfP+wRpRbt8qtclre70FMAWfGxgJzFNgg7M8JTL4
         e1rQ==
X-Gm-Message-State: ACrzQf0FzIEWiTobPupR/09Soo7UGy0BdakO1iBw4tT2+RW8PpJS4PnM
        5MWff5F2UyTN9IEaKHmvDmmfdF3Ary8=
X-Google-Smtp-Source: AMsMyM7StdmW2s0JDvShx0DM9h1H+6w0xzDkuDWLDHWgfE3mb+SwKv151I2wlKdpfNQSqM2uNm3YpsTkNJU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:aa7:d8ce:0:b0:44e:8895:89c2 with SMTP id
 k14-20020aa7d8ce000000b0044e889589c2mr272708eds.382.1663254327816; Thu, 15
 Sep 2022 08:05:27 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:52 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-19-glider@google.com>
Subject: [PATCH v7 18/43] instrumented.h: add KMSAN support
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid false positives, KMSAN needs to unpoison the data copied from
the userspace. To detect infoleaks - check the memory buffer passed to
copy_to_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v2:
 -- move implementation of kmsan_copy_to_user() here

v5:
 -- simplify kmsan_copy_to_user()
 -- provide instrument_get_user() and instrument_put_user()

v6:
 -- rebase after changing "x86: asm: instrument usercopy in get_user()
    and put_user()"

Link: https://linux-review.googlesource.com/id/I43e93b9c02709e6be8d222342f1b044ac8bdbaaf
---
 include/linux/instrumented.h | 18 ++++++++++++-----
 include/linux/kmsan-checks.h | 19 ++++++++++++++++++
 mm/kmsan/hooks.c             | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 9f1dba8f717b0..501fa84867494 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -2,7 +2,7 @@
 
 /*
  * This header provides generic wrappers for memory access instrumentation that
- * the compiler cannot emit for: KASAN, KCSAN.
+ * the compiler cannot emit for: KASAN, KCSAN, KMSAN.
  */
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
@@ -10,6 +10,7 @@
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
+#include <linux/kmsan-checks.h>
 #include <linux/types.h>
 
 /**
@@ -117,6 +118,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
 	kcsan_check_read(from, n);
+	kmsan_copy_to_user(to, from, n, 0);
 }
 
 /**
@@ -151,6 +153,7 @@ static __always_inline void
 instrument_copy_from_user_after(const void *to, const void __user *from,
 				unsigned long n, unsigned long left)
 {
+	kmsan_unpoison_memory(to, n - left);
 }
 
 /**
@@ -162,10 +165,14 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
  *
  * @to destination variable, may not be address-taken
  */
-#define instrument_get_user(to)                         \
-({                                                      \
+#define instrument_get_user(to)				\
+({							\
+	u64 __tmp = (u64)(to);				\
+	kmsan_unpoison_memory(&__tmp, sizeof(__tmp));	\
+	to = __tmp;					\
 })
 
+
 /**
  * instrument_put_user() - add instrumentation to put_user()-like macros
  *
@@ -177,8 +184,9 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
  * @ptr userspace pointer to copy to
  * @size number of bytes to copy
  */
-#define instrument_put_user(from, ptr, size)                    \
-({                                                              \
+#define instrument_put_user(from, ptr, size)			\
+({								\
+	kmsan_copy_to_user(ptr, &from, sizeof(from), 0);	\
 })
 
 #endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index a6522a0c28df9..c4cae333deec5 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -46,6 +46,21 @@ void kmsan_unpoison_memory(const void *address, size_t size);
  */
 void kmsan_check_memory(const void *address, size_t size);
 
+/**
+ * kmsan_copy_to_user() - Notify KMSAN about a data transfer to userspace.
+ * @to:      destination address in the userspace.
+ * @from:    source address in the kernel.
+ * @to_copy: number of bytes to copy.
+ * @left:    number of bytes not copied.
+ *
+ * If this is a real userspace data transfer, KMSAN checks the bytes that were
+ * actually copied to ensure there was no information leak. If @to belongs to
+ * the kernel space (which is possible for compat syscalls), KMSAN just copies
+ * the metadata.
+ */
+void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
+			size_t left);
+
 #else
 
 static inline void kmsan_poison_memory(const void *address, size_t size,
@@ -58,6 +73,10 @@ static inline void kmsan_unpoison_memory(const void *address, size_t size)
 static inline void kmsan_check_memory(const void *address, size_t size)
 {
 }
+static inline void kmsan_copy_to_user(void __user *to, const void *from,
+				      size_t to_copy, size_t left)
+{
+}
 
 #endif
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 6f3e64b0b61f8..5c0eb25d984d7 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -205,6 +205,44 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
 	kmsan_leave_runtime();
 }
 
+void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
+			size_t left)
+{
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	/*
+	 * At this point we've copied the memory already. It's hard to check it
+	 * before copying, as the size of actually copied buffer is unknown.
+	 */
+
+	/* copy_to_user() may copy zero bytes. No need to check. */
+	if (!to_copy)
+		return;
+	/* Or maybe copy_to_user() failed to copy anything. */
+	if (to_copy <= left)
+		return;
+
+	ua_flags = user_access_save();
+	if ((u64)to < TASK_SIZE) {
+		/* This is a user memory access, check it. */
+		kmsan_internal_check_memory((void *)from, to_copy - left, to,
+					    REASON_COPY_TO_USER);
+	} else {
+		/* Otherwise this is a kernel memory access. This happens when a
+		 * compat syscall passes an argument allocated on the kernel
+		 * stack to a real syscall.
+		 * Don't check anything, just copy the shadow of the copied
+		 * bytes.
+		 */
+		kmsan_internal_memmove_metadata((void *)to, (void *)from,
+						to_copy - left);
+	}
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(kmsan_copy_to_user);
+
 /* Functions from kmsan-checks.h follow. */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
-- 
2.37.2.789.g6183377224-goog

