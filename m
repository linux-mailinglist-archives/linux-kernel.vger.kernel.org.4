Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D4698BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBPFS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBPFSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F63E60A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-532e96672b3so8513177b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4opi4a+4wBSqIsfjyFGdOCf+RfFv13YZtxtXh5ocOUM=;
        b=Xo1jDDViHSHN/alioaTDnw+zuoNPKrF9ZLXUf3ea0NE3bXPLl0z7WkGrQUW7AOG0Nr
         J8SsODBneQSeaMKO7nEqhtXELAqyVVzyHag3dRajS0MNlWpB1lyOtsy0oB8MM0CrQEnP
         Moe4iuqLi8ffYInMsJBu3lDYUcEPw1W16t68/pqdVg/PM7yHOfl4JRIe/AAV288dZ063
         0OmpnGUH5/0w4iEIelRXBTS4gWduVmNFBkN/5ItORK5tiSjU8ab3rw3adCz9oFddo8Er
         mGSeo2MZqEM7cxpZTU0mXlOgRPyGjhgPgDiiUmvS//v9NEkdkZgUTyYfpCAeqd0avQoQ
         0u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4opi4a+4wBSqIsfjyFGdOCf+RfFv13YZtxtXh5ocOUM=;
        b=dnVvbQuX0z02PvlE2JzCE/26YFqGqDUuIpfJ30U+NHA3qw9ThWwiofaxF09hYN84uM
         dfyUfd3bxyoDMkeKPTZvNXwwfrHNNvz4XL6Z08lLHaaIQ9OspmlzCC625YorPrElNk5X
         UxBkLJcvp1dj+jRSWEDvlt+Jo4UKUUDF2GZe7gA0WMdtmFVA1ghDuEG3Ux4+F1iaLOYZ
         mx48eW/1E2/I867mvHHxdSyTa7hFofNT8kTgYeTJbEl+ZpPJvJehA0iwWMmv43kvBfs9
         +w7AD8pmzTvb2ElHOxk0qpcrcqVkzG+bi8+/3p2eZ4TmpG+2D7u6MgS0WdUGskjnaVyP
         N8Vw==
X-Gm-Message-State: AO0yUKXFojpPCu/ngGizB2aOfBSAirllKfpxT8J7j8c5/+krrKJUcxER
        n0IP5ZUAWcvq5H/Xo1JC1sW8Ym0AJRw=
X-Google-Smtp-Source: AK7set+/DgIBDY3hKjRHmWHVe7yByHJ3rZUqgnqz5mohiI9GciRP+9xmqTdnoEyOpn2/QPX/HT0hsnAfle8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:ca:b0:8f2:9e6:47a4 with SMTP id
 i10-20020a05690200ca00b008f209e647a4mr3ybs.7.1676524694561; Wed, 15 Feb 2023
 21:18:14 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:23 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-9-surenb@google.com>
Subject: [PATCH v3 08/35] mm: Enable maple tree RCU mode by default.
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
index 3cd60243c625..3fd5305dbbf9 100644
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
index 20f21f0949dd..06c0f6686de8 100644
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

