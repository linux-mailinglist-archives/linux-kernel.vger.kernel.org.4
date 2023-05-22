Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B7870BB56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjEVLOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEVLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186F40ED
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f683e8855so488847866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753734; x=1687345734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNtfrgi/quI4TC521AyXgwFWeKCoK/ixdzMUo1Hjyag=;
        b=GkR4/dm/njRpBQa+KVraZ+7JOlNk7shw4BEphYd/T4MuYuRj9UeHx7STRIkE9qZ3ZV
         2oXVDGHFmqIOsQbp8tUn9Y00B46Baxi7Y8dneLOn6DV42d85pL1sEsY68+QnjQ1f2vmJ
         aDPoq7XcD9rLqsdzZWq3ANly5HjVSjJ29W0p5d8YhCo15pKjujxSAlIMECHBsZDAyuMN
         tLgaKTuxmHTfb/eGGN0rAdS+/lKXxYAVJyynl/B47Xw/ZEaCyR2lt1lpmnS2FpLh3BXG
         MgpEFyKwNZW3Q2xr0xt2mb+dk5JSHw7+52EgYFgJevxmwbWAu2YUPoOjuE6sjvnpUmYm
         ZEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753734; x=1687345734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNtfrgi/quI4TC521AyXgwFWeKCoK/ixdzMUo1Hjyag=;
        b=FTZ3yfk6jS6vKVXbW+/KmL42W+/A/0LU6hHyovEVYmhf1EB2QBqDn19pmtG8/mQ4Ei
         hWnhTRwkh55HHMi+wxdu1FsFpjA2IMpVzKW4uEMJpuTBOfdz0qoMzFsnbA5tS90o7Mdm
         xS2KE+rY+MPoRCrl8f+74hO79VwqCNVdMSfze9cbbqkR2dW8h6Egn78MKFoidwQxY6fB
         ld/s2KdjEBesyC13rGxOYctu4CZrQVwStEu3Rrcubc3z/MAgkWNUf95rOdTWRelFOQyK
         mJWrQtwbRt+gzwre07P2ubdUVjVSQ1vlPEot5vhEub/qi/0oJB2am4yKleZXnXwoNjmi
         xztQ==
X-Gm-Message-State: AC+VfDwI+MLuZ2nmwbQF63GjwJOKw9BOOGtMsx7ULvMErwYslkD6CjuK
        FjXKwbA2Ue0DCk3DX1KRldA=
X-Google-Smtp-Source: ACHHUZ6CkjutlmxyUmi96KfbjXVfsWOUvXlEtbViniM+ZZDlWRxo42QLeXCAxHA9y4X8Xg8XpIQzUA==
X-Received: by 2002:a17:907:d21:b0:965:4b43:11f1 with SMTP id gn33-20020a1709070d2100b009654b4311f1mr9711913ejc.3.1684753734338;
        Mon, 22 May 2023 04:08:54 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:54 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/9] mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
Date:   Mon, 22 May 2023 13:08:43 +0200
Message-Id: <20230522110849.2921-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A vmap_init_free_space() is a function that setups a vmap space
and is considered as part of initialization phase. Since a main
entry which is vmalloc_init(), has been moved down in vmalloc.c
it makes sense to follow the pattern.

There is no a functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 82 ++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5f900efec6a9..19dcffb0d563 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2416,47 +2416,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static void vmap_init_free_space(void)
-{
-	unsigned long vmap_start = 1;
-	const unsigned long vmap_end = ULONG_MAX;
-	struct vmap_area *busy, *free;
-
-	/*
-	 *     B     F     B     B     B     F
-	 * -|-----|.....|-----|-----|-----|.....|-
-	 *  |           The KVA space           |
-	 *  |<--------------------------------->|
-	 */
-	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
-			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-			if (!WARN_ON_ONCE(!free)) {
-				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
-
-				insert_vmap_area_augment(free, NULL,
-					&free_vmap_area_root,
-						&free_vmap_area_list);
-			}
-		}
-
-		vmap_start = busy->va_end;
-	}
-
-	if (vmap_end - vmap_start > 0) {
-		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-		if (!WARN_ON_ONCE(!free)) {
-			free->va_start = vmap_start;
-			free->va_end = vmap_end;
-
-			insert_vmap_area_augment(free, NULL,
-				&free_vmap_area_root,
-					&free_vmap_area_list);
-		}
-	}
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
@@ -4271,6 +4230,47 @@ module_init(proc_vmalloc_init);
 
 #endif
 
+static void vmap_init_free_space(void)
+{
+	unsigned long vmap_start = 1;
+	const unsigned long vmap_end = ULONG_MAX;
+	struct vmap_area *busy, *free;
+
+	/*
+	 *     B     F     B     B     B     F
+	 * -|-----|.....|-----|-----|-----|.....|-
+	 *  |           The KVA space           |
+	 *  |<--------------------------------->|
+	 */
+	list_for_each_entry(busy, &vmap_area_list, list) {
+		if (busy->va_start - vmap_start > 0) {
+			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+			if (!WARN_ON_ONCE(!free)) {
+				free->va_start = vmap_start;
+				free->va_end = busy->va_start;
+
+				insert_vmap_area_augment(free, NULL,
+					&free_vmap_area_root,
+						&free_vmap_area_list);
+			}
+		}
+
+		vmap_start = busy->va_end;
+	}
+
+	if (vmap_end - vmap_start > 0) {
+		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+		if (!WARN_ON_ONCE(!free)) {
+			free->va_start = vmap_start;
+			free->va_end = vmap_end;
+
+			insert_vmap_area_augment(free, NULL,
+				&free_vmap_area_root,
+					&free_vmap_area_list);
+		}
+	}
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
-- 
2.30.2

