Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06816A482D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjB0RhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjB0RhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A82413A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a545bfbaso154418717b3.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aVmQ+gMlQiQzO0BzppdTJNpvPFfXe9SF4GFtX+8IdI=;
        b=D/TbQt2c2awJMi6HOd9NzTPN8Wh6HIDVRf22VcVpKnoo2iG9BW3cveeUmkm8PKhRJw
         e8yR0ZbMCGkBSW5fis3LsBzhCw5i+IpUgPXTff0+yi++DCnoiZhErYzM/F+7mHgcikXH
         QOit+1nZssfs8RFlG5fSiSPYICEv1yz50+pHU8s0ps/vZirUhJuz0Ulrl1hrsOJOpcE3
         znNNgdhtvb5jKMhdVyGD/B9paUJjeax2LqQ02QvRkavKjrbvwoC4jih7/m+HHIs6ILLw
         YfzP5gfYx0HByoaWOc2LKVichxZvwcYhuSo6etH4BNZtHefRK1x1pNfZ+dtw2h02k/FS
         yoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aVmQ+gMlQiQzO0BzppdTJNpvPFfXe9SF4GFtX+8IdI=;
        b=08DNEBUsmdO0WD+AYuEk0k79T3f1dxgUhEEimJoGOCjYSxfzOhkyH3XEZVZGbA2wj6
         gwY+Rweebw2swIgBrQdGlKV0siBADj6i04pyUZ3/zZOvqWPMH/2ywvQayrRLthkpImWE
         JTtoaaZEjrt3OyD0PoX9QJOh+12rsr8hC0I7JYSyZHBSPCbNgop0dyA9JIf1hfP/mQpo
         hqTpw3vU5JJcIBfiZMxDDMv0/ES0faje8R1KuLSBO0pxRQ1at3GOcJUFXXkkNjuXZlCK
         ck9wRGBjac4dGDiwbPlkvOy09LWumhJsMOGaciVcOf5u9tEbIrypH5hpbsM9HP5zTGsc
         XvVA==
X-Gm-Message-State: AO0yUKWl4K8MOjHV9OLs40tggPEJENpLbDgV5rtF9W0ZEu392mNscn6/
        /0tLcB1du79PD360bUh61QVQdYjquCs=
X-Google-Smtp-Source: AK7set8Y6D5rMaDNffZrErpNBudkJshlslCM/7lUMkyK7fj0ZkdAWXrQW4GsW7RGl7OL0nGeq+RMkIj/EqM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:1205:b0:a09:314f:9f09 with SMTP id
 s5-20020a056902120500b00a09314f9f09mr214802ybu.6.1677519416349; Mon, 27 Feb
 2023 09:36:56 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:07 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-9-surenb@google.com>
Subject: [PATCH v4 08/33] mm: Enable maple tree RCU mode by default.
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
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Use the maple tree in RCU mode for VMA tracking.  This is necessary for
the use of per-VMA locking.  RCU mode is enabled by default but disabled
when exiting an mm and for the new tree during a fork.

Also enable RCU for the tree used in munmap operations to ensure the
nodes remain valid for readers.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 3 ++-
 kernel/fork.c            | 3 +++
 mm/mmap.c                | 4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 417d25c6a262..22b2ac82bffd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -779,7 +779,8 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
 
-#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
+			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
 
 /* Pointer magic because the dynamic array size confuses some compilers. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 0cbfdc4b509e..abfcf95734c7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -617,6 +617,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	if (retval)
 		goto out;
 
+	mt_clear_in_rcu(vmi.mas.tree);
 	for_each_vma(old_vmi, mpnt) {
 		struct file *file;
 
@@ -700,6 +701,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
 	vma_iter_free(&vmi);
+	if (!retval)
+		mt_set_in_rcu(vmi.mas.tree);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 740b54be3ed4..c234443ee24c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2277,7 +2277,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	int count = 0;
 	int error = -ENOMEM;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags &
+		      (MT_FLAGS_LOCK_MASK | MT_FLAGS_USE_RCU));
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
 	/*
@@ -3042,6 +3043,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 	mmap_write_lock(mm);
+	mt_clear_in_rcu(&mm->mm_mt);
 	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
 		      USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
-- 
2.39.2.722.g9855ee24e9-goog

