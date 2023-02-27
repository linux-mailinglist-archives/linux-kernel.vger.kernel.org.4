Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053C6A4834
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjB0RiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjB0Rha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1556244AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5395c8fc4a1so108715137b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I212iwzKiM4RAh4/x5atSdllFVTlqkGJNP08f3JbnWQ=;
        b=XBhlBuuWfB0rAIGd6hmSTNeCzmJSeNc8sCljBThxSUCF4xl/MSw7wD8HJnBQqXsjUJ
         57kJQANXg6fNdWd8Pt4eiSrUjDCyUw1I4L84NqCzMgqp7jq/T8VmsbuNmrFrLa4O4XYU
         GqAQJ+b6Oca+hy9pxgzol0kd/HIC9ER2wtl/KEZHOhFYwY8HxJnljLvK30eOyvBMk653
         HhqyRDcfvr4BXt/19NWrR6/WQesJSjC/tN0jtggmEFB14E/QwVd/f4szWEolKHRDFF2I
         b8hGsHDba//nCM47ED9hrsor6X6kCcWnUTvy8GzRTm8e9DVF7x8YXaJ1E8nG+/bnJf9E
         7yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I212iwzKiM4RAh4/x5atSdllFVTlqkGJNP08f3JbnWQ=;
        b=E4AukLGt3jKn6naeNishIxs21cVl7GqQC4bcYfUiXSNZ4qZGcmAV1YZRmOUku2ZdUV
         xk3L5MeJlyOfRMO8PgwCYzcfe2xzLAN6HhDelg3suOAJIyP5TjeP0ofKPKtetCiIKU1V
         Xmlv3frGoV/NvXPMN56eapgWNRWMnAf2u46k73BgZhLL7s0a1Eonr+yNny4+Phlj+hr1
         nB9jxzMRc60zKuInnE9Tw/YJpZYaPt+tH349k9kyGlhEY2it+8KmLcZ9oFUZvu9cRsbf
         cJkyWN4SCcq2IUfGIWDAb4CwtqY/rfkwijF88Kqmko45STvOe1nXiPoWquCTzuwZeBcT
         TiLQ==
X-Gm-Message-State: AO0yUKXEPbglgUTMRqRDjCRkX6/xkTbplYM95SSod1Q+7q22d+wbbqXl
        PaVRcz5yJYUXnPNWp6QMg2drepbckrs=
X-Google-Smtp-Source: AK7set92Gr75A5uaM9VLoSN3m2+g8CdJzSD2poMBi0hZE65OwRnSrd/3zaVdEb4P76h2ChlMWirB5h4UQZs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a5b:a4b:0:b0:a06:5ef5:3a82 with SMTP id
 z11-20020a5b0a4b000000b00a065ef53a82mr7473143ybq.5.1677519427726; Mon, 27 Feb
 2023 09:37:07 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:12 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-14-surenb@google.com>
Subject: [PATCH v4 13/33] mm: mark VMA as being written when changing vm_flags
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to vm_flags have to be done with VMA marked as being written for
preventing concurrent page faults or other modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bbad5d4fa81b..3d5e8666892d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -726,28 +726,28 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
 static inline void vm_flags_reset(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	vm_flags_init(vma, flags);
 }
 
 static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
 }
 
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
 }
 
 static inline void vm_flags_clear(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
 }
 
@@ -768,7 +768,7 @@ static inline void __vm_flags_mod(struct vm_area_struct *vma,
 static inline void vm_flags_mod(struct vm_area_struct *vma,
 				vm_flags_t set, vm_flags_t clear)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	__vm_flags_mod(vma, set, clear);
 }
 
-- 
2.39.2.722.g9855ee24e9-goog

