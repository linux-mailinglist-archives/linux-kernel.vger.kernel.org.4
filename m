Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12699678288
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjAWRFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjAWRFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:10 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D323DA2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:07 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id n8so10975529oih.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FThLWOoZZXBRMb3ocbeHMeCYRMJ3a8JkbY9XwLoGNJM=;
        b=A9lLC3vexpFb3gkXoiJam0gSNrJv94xqiphCLdx0LFU3eh7KEeYgStPEfrRN9g8zpw
         A3GchVFNx8Xz92R77r69+TnXkwRpLv0f4SZTWcoUkzMuuJzYUJuOqeeBVn734rIYAV5a
         ZSElJIx6NA7ipjRKAKc6R/bCELanuH/z572MGTGOY/3RBmynGJYcxLyAB+MhLJjkzjTp
         eAzUI7z7K7TtjO4lofdlRwFJ+XwX3f4c3cbfcDtynWMve6g7lcHq27Ht6HeTI24ykwVL
         bpYboW7jXSyPhRl2YQPckiVdwmsGgnTOi1G2xrchCMOiIvay6/B7evJ0+peTalvlZgsC
         oWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FThLWOoZZXBRMb3ocbeHMeCYRMJ3a8JkbY9XwLoGNJM=;
        b=t2ACi1qVjrf7eewcfeYc4IfJGY4cdlf8sz2SBJ/pPzMej/cif+S6sChX8OXEVjh/x3
         F/Lki4nIK1ezYp9Em0/swUvApZQ0Nw58XCWpQnQj6OF9+MRLKe1AOwYoNw7cyKyYiXIu
         L2LJ6OfzTSyHZ7I2CGK1km/aMyPqkqKbOtOucXKSbEubLesKpN/f1xDY2ON4a/g0V0cC
         VPWTS20PtyQZiGe4U46G9MSM96+AxDY7R1I7LOtEv8FSVQKm6LQ/6O7D7bGMzwabcEvC
         9DHOAac882JKlp/keq5bEe04wlqvrr1S6M0Levw29fbNXpCCM3OKdMwwsOmmzv6lq3uL
         Swpw==
X-Gm-Message-State: AFqh2koIc3t++/0ard1OLYzdYnvZ3lP7f7CtZBhE/ZfzoN+eEX42067m
        /BpYjpew957vTPSOeMNF4lLDFxmwAyru+8tgafXLBFUTvSqBvA69RC+FdOHrp2BPmSZvNt57H5K
        7+ZdY7p5QKnC4OZfBcs7IR25BE9fVnLO1XXTFpV3/gT8CCtpxA44tH+h2wU8RgYybN8wNwX2izV
        SvDf2jR1Tc0ANp
X-Google-Smtp-Source: AMrXdXtkuNeB5js0YY7EQvF6CWd2gqsNNMHEQebeRjWsftml8x/8mMpKwTlodh8Si41JeAy8tMMlEQ==
X-Received: by 2002:a05:6808:300e:b0:364:f962:afd1 with SMTP id ay14-20020a056808300e00b00364f962afd1mr13072058oib.56.1674493506352;
        Mon, 23 Jan 2023 09:05:06 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:06 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
Date:   Mon, 23 Jan 2023 11:04:11 -0600
Message-Id: <20230123170419.7292-2-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak has a flag to enable or disable task stack scanning.
Unfortunately, this flag does not work as intended. Even when the user
disables stack scanning, kmemleak will scan them. Stacks are allocated
with vmalloc and are included in the list of objects to scan of
kmemleak.

Introduce a new function kmemleak_mark_stack that marks an allocation as
a stack. This allows kmemleak to properly decide whether to scan or not
the object based on the respective flag.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 include/linux/kmemleak.h |  1 +
 kernel/fork.c            |  3 +++
 mm/kmemleak.c            | 39 ++++++++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 6a3cd1bf4680..1e2e8deac6dc 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -33,6 +33,7 @@ extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				gfp_t gfp) __ref;
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
 extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
+extern void kmemleak_mark_stack(const void *ptr) __ref;
 
 static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
 					    int min_count, slab_flags_t flags,
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..e66337ce88d4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
 #include <linux/stackprotector.h>
+#include <linux/kmemleak.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -316,6 +317,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	if (!stack)
 		return -ENOMEM;
 
+	kmemleak_mark_stack(stack);
+
 	vm = find_vm_area(stack);
 	if (memcg_charge_kernel_stack(vm)) {
 		vfree(stack);
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 92f670edbf51..b40735539abd 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -176,6 +176,8 @@ struct kmemleak_object {
 #define OBJECT_FULL_SCAN	(1 << 3)
 /* flag set for object allocated with physical address */
 #define OBJECT_PHYS		(1 << 4)
+/* flag set by alloc_thread_stack_node for stacks */
+#define OBJECT_STACK		(1 << 5)
 
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
@@ -1229,6 +1231,24 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
+/**
+ * kmemleak_mark_stack - mark the allocated object as a kernel stack
+ *
+ * @ptr:	pointer to beginning of the object
+ */
+void __ref kmemleak_mark_stack(const void *ptr)
+{
+	struct kmemleak_object *object;
+
+	if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
+		object = find_and_get_object(ptr, 0);
+		if (object) {
+			object->flags |= OBJECT_STACK;
+			put_object(object);
+		}
+	}
+}
+
 /*
  * Update an object's checksum and return true if it was modified.
  */
@@ -1404,6 +1424,8 @@ static void scan_object(struct kmemleak_object *object)
 	if (!(object->flags & OBJECT_ALLOCATED))
 		/* already freed object */
 		goto out;
+	if (!kmemleak_stack_scan && object->flags & OBJECT_STACK)
+		goto out;
 
 	obj_ptr = object->flags & OBJECT_PHYS ?
 		  __va((phys_addr_t)object->pointer) :
@@ -1586,23 +1608,6 @@ static void kmemleak_scan(void)
 	}
 	put_online_mems();
 
-	/*
-	 * Scanning the task stacks (may introduce false negatives).
-	 */
-	if (kmemleak_stack_scan) {
-		struct task_struct *p, *g;
-
-		rcu_read_lock();
-		for_each_process_thread(g, p) {
-			void *stack = try_get_task_stack(p);
-			if (stack) {
-				scan_block(stack, stack + THREAD_SIZE, NULL);
-				put_task_stack(p);
-			}
-		}
-		rcu_read_unlock();
-	}
-
 	/*
 	 * Scan the objects already referenced from the sections scanned
 	 * above.
-- 
2.37.1

