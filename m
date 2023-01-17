Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BAF66E3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAQQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjAQQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:36:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787A42DD5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:35:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso84069wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZx85Sf0ezER0rilQtZPHDwVHsmiiEfW3AZAr5ZtFc=;
        b=QeCeDVWgByy16VG/MS4W5/YqPsrRtIYCfxrL4a6dZ+jZ6vmgpog/rXDT+QwoBwEzWa
         TRUNErkvo/oGfg/S/j+KWbMIOr9GiSqQngzTIWk7ya/FeORgOym/kAENGgZexeyu18HF
         yCRYWDe2hV+jEemvGLePPiYEwI381jYY3y/y9LZS5uAltHoWHi7ranAoS88vZqFoWym9
         wLzh3dk9TQeSL9/t0u5QaQsBZGZ+3sI/nHXgFAdMhtOWE4hJwCEkI6j4hLp24hoEDchK
         uX93pmOD/0EkL+C75TSWbZrUBdq+LaGuOCUxJltawuwbrpRugoZ3Y0i5OZwf9lD0QSWx
         2RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnZx85Sf0ezER0rilQtZPHDwVHsmiiEfW3AZAr5ZtFc=;
        b=OcKAB9wJAMoSknd/7wrHSfazmTwn+LTu6pt+hXEPDXLt9egNC8VH0mbgk0Vj+F/SNf
         ZSZT248vfYu0+yJcEpKKeltSZwHBrl955KxRzSIKwb5Jcg1F6S3esW+J8T8TefpkH5ZZ
         KsC16nbWxmApOy1U5deLTCDRwLFuxGCH7ZGlDl+2RhZa1SJcuvPsBfeXVYr5xwbgqf8b
         rz1ULxOeOTo3y0+bHxy4vTGOb7eG3Yf7xPhbQdqAKvAMTWBaf/LWvxrN7ZPd6zoseZ1S
         xOkahvxf2Ehj0SqwWA53ix15XzhTnfVWiRoLNfWGcXqBKnyzZoJ0f6Ek7ddCqHyGy8hy
         3zIw==
X-Gm-Message-State: AFqh2kosQTbqLdiuiS0f2EpadMZIZunYuU75OEmf8jSTH6LhkOj2lioJ
        TCY8P1teKCdTeSNfi1JbufY09g==
X-Google-Smtp-Source: AMrXdXtfymwl0mGkq0lJ5rS3lmAK1qgKiocFOzgCqZmkdq6hC54QQMHrTm3liJbZGL1Y6YgJUf16Pw==
X-Received: by 2002:a05:600c:1d92:b0:3d0:30c8:c47b with SMTP id p18-20020a05600c1d9200b003d030c8c47bmr2335336wms.2.1673973354962;
        Tue, 17 Jan 2023 08:35:54 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:9df1:9663:75e8:617c])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003db09692364sm2302292wms.11.2023.01.17.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:35:53 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com
Subject: [PATCH] fork, vmalloc: KASAN-poison backing pages of vmapped stacks
Date:   Tue, 17 Jan 2023 17:35:43 +0100
Message-Id: <20230117163543.1049025-1-jannh@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN (except in HW_TAGS mode) tracks memory state based on virtual
addresses. The mappings of kernel stack pages in the linear mapping are
currently marked as fully accessible.
Since stack corruption issues can cause some very gnarly errors, let's be
extra careful and tell KASAN to forbid accesses to stack memory through the
linear mapping.

Signed-off-by: Jann Horn <jannh@google.com>
---
I wrote this after seeing
https://lore.kernel.org/all/Y8W5rjKdZ9erIF14@casper.infradead.org/
and wondering about possible ways that this kind of stack corruption
could be sneaking past KASAN.
That's proooobably not the explanation, but still...

 include/linux/vmalloc.h |  6 ++++++
 kernel/fork.c           | 10 ++++++++++
 mm/vmalloc.c            | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..bfb50178e5e3 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -297,4 +297,10 @@ bool vmalloc_dump_obj(void *object);
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+#if defined(CONFIG_MMU) && (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
+void vmalloc_poison_backing_pages(const void *addr);
+#else
+static inline void vmalloc_poison_backing_pages(const void *addr) {}
+#endif
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..5c8c103a3597 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -321,6 +321,16 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		vfree(stack);
 		return -ENOMEM;
 	}
+
+	/*
+	 * A virtually-allocated stack's memory should only be accessed through
+	 * the vmalloc area, not through the linear mapping.
+	 * Inform KASAN that all accesses through the linear mapping should be
+	 * reported (instead of permitting all accesses through the linear
+	 * mapping).
+	 */
+	vmalloc_poison_backing_pages(stack);
+
 	/*
 	 * We can't call find_vm_area() in interrupt context, and
 	 * free_thread_stack() can be called in interrupt context,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7c9d77..10c79c53cf5c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4042,6 +4042,30 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+/*
+ * Poison the KASAN shadow for the linear mapping of the pages used as stack
+ * memory.
+ * NOTE: This makes no sense in HW_TAGS mode because HW_TAGS marks physical
+ * memory, not virtual memory.
+ */
+void vmalloc_poison_backing_pages(const void *addr)
+{
+	struct vm_struct *area;
+	int i;
+
+	if (WARN(!PAGE_ALIGNED(addr), "bad address (%p)\n", addr))
+		return;
+
+	area = find_vm_area(addr);
+	if (WARN(!area, "nonexistent vm area (%p)\n", addr))
+		return;
+
+	for (i = 0; i < area->nr_pages; i++)
+		kasan_poison_pages(area->pages[i], 0, false);
+}
+#endif
+
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0.314.g84b9a713c41-goog

