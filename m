Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD066A4832
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjB0Rhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjB0RhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:21 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA1244B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536d63d17dbso154500957b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls18it+007PHyc+1gU+R0B2Ah0edgQPBYFo5Fg80PJ0=;
        b=XsYGyrr6UscqFf/3E/PqXH+0brCoiV/AniBzcmo5DJxAd/4Bmzv4DyD8sM4NuAQxi8
         dZWrcG1/ZDBfEbfkvX95mB7A+YCMYHAJEmom82/9Nzaqf1YzLljv1hrT1/pnhQY+fnL+
         IOvvFbrnVTXpiEotFDmf2wc0ksmnu2CR25KjblrUK/fkJWLyctUr7YoQUoBBpu2dXgAS
         BlvIHfsMMuqia7hwWHF3vceBwA8k9G+49DeoR5tUXJAWoHB1hsAUuDBJJWuX8cJ0Z90U
         6Vd32qha+psgDSdv++LPDOcFAXLUVGYeIPM/jmszF46HDebsTawQRm0lgk8RRbgTNhtx
         sLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls18it+007PHyc+1gU+R0B2Ah0edgQPBYFo5Fg80PJ0=;
        b=GpJTvYfsxTNAe9QYASsqLq6qXwsHzX2/yOzLJadVfj4Cg1gXc3Cz6JPXMocwDLUJ9E
         9sdit3IqP/bYOShEsrxqqK8Qbt4MIvwRh0sCtkUspMm+vo8lK/Wr4bSc/4m01uRMvOBZ
         Jx8H3KNMEkoU6VXz+K6tEKU737k05Y9QEvJM6DzUUiQf8fPLyBjsKTCZjYoiuUwkdrwa
         Q18/oSsCfzSpL8Gz9WcTojoWH8ZUqyUQPFzlom0//6OZvsmRV7R2WOOlfqX2DyhP2qOY
         OqWMWMATZ18FIpZol2CX1tKP9OyB9LxI/o671/My+zm1Z0MYIPzseHDH+uZDIRf++Cdx
         vHDw==
X-Gm-Message-State: AO0yUKUf1F5anhGd935YvOOPQrA7Eyj4oTOwNZCqh8ty0tmnzjp4akv/
        9bZOYB3plpWKJLBBFGpXXqlQuXY+nEw=
X-Google-Smtp-Source: AK7set84bNGznxOoxVaVlILHB4VZYiPLd+BYNZO1PonJXcuULbgT0KQ1/CW8aHys4CM8FC8mlmVpy5ibqO4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:1007:b0:8f3:904a:2305 with SMTP id
 w7-20020a056902100700b008f3904a2305mr261507ybt.2.1677519423051; Mon, 27 Feb
 2023 09:37:03 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:10 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-12-surenb@google.com>
Subject: [PATCH v4 11/33] mm: move mmap_lock assert function definitions
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

Move mmap_lock assert function definitions up so that they can be used
by other mmap_lock routines.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmap_lock.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 96e113e23d04..e49ba91bb1f0 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 
 #endif /* CONFIG_TRACING */
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held_write(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -150,18 +162,6 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_lock);
 }
 
-static inline void mmap_assert_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
-static inline void mmap_assert_write_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
 static inline int mmap_lock_is_contended(struct mm_struct *mm)
 {
 	return rwsem_is_contended(&mm->mmap_lock);
-- 
2.39.2.722.g9855ee24e9-goog

