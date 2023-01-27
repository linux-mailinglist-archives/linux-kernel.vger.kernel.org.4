Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAA67EE92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjA0TnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjA0Tm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:42:59 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095CB83244
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-50660dd3263so65567817b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDt1g22Fa9gYu2Kb7/F2UNWz7p2znEfhohgEMazkZAE=;
        b=n77zu0oRsJL7OvjwFNjS7T1FAOtu4hdvxpK7kq3XthnUipBv5szcKq0gW6Eh2qWZ+N
         VqA54npBtuI1r6BsRB8yCAVHYO39SuVCqNfhqCm/Ya4OMopwGqTAxzjzqXFTaLEmWefn
         G7d9A2dlsE9NEs9J39+IVmn9jXa2H7iuxd7eUv1r4SdiVN/BsV9E4rX7Fx/7SJnqIKhp
         5pljM+LwjnmUAESpDExSAXXjwcvSQjwdpBA+epV9jtEBYonrLt6ilkcmvKbIgLrFIqhL
         dWwHvu2PRt1rquBCjgEA2IpAdLCPilrM/O5s952uzrtLUUUIX7VUyMYpZs8xK3jyFgDu
         2ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDt1g22Fa9gYu2Kb7/F2UNWz7p2znEfhohgEMazkZAE=;
        b=3u7GOPP1AKy2zKIq6G7zqCcugp/6Hn3KcNWtsLFQoVHTnfbjqokSGNchF4AuTEJmyE
         VwbvUkxFuKw8hz57F2R3zoCjRefE+oB240mj7JfAztahEOOL3I3Di51VkTGtgb8OGS+2
         58zODxxVpscJ8vj2UbCh93ts+8MjxVcuMRkgE8bsw7AGY1v912HYt44B+vLZcfguvZ69
         bytaGPTb58DfVRkx5vIJiCjLs33cL743GT7nukr6Qlj4Lq30RGZDUUO4IfLczLEa+OHR
         ArWby+d7mFEJ0T1tzm8DKLTNLkpzvYHnD/DhBStRHO8acg2asDn/gBQQSaN7rMAdfMUv
         Zaxw==
X-Gm-Message-State: AO0yUKVZtrPJ0JjIIwuhszcyTk8HzwA3woOP5bu1lJBcRtQ4Tx8H0td0
        mtdVE6oCz1pdhL/y4fp7DyKqtX6tnYw=
X-Google-Smtp-Source: AK7set9vKZUOyTcPurWe/bFPJyhfVHuV/nLiUj+ueaBvjKNu+svIA1blUVC8f6GWjxXLSfMUdNgMQcXmD6M=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a25:354:0:b0:80b:543d:2106 with SMTP id
 81-20020a250354000000b0080b543d2106mr1234365ybd.10.1674848491227; Fri, 27 Jan
 2023 11:41:31 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:44 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-8-surenb@google.com>
Subject: [PATCH v2 07/33] mm: Enable maple tree RCU mode by default.
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
index da983aedb741..8410c3052148 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -768,7 +768,8 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
 
-#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
+			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
 
 /* Pointer magic because the dynamic array size confuses some compilers. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 5e3029ea8e1e..5f23d5e03362 100644
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
index 9d0dadb55e9a..9efe13d36df7 100644
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
2.39.1

