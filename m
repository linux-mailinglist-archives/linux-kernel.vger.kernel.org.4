Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DEC6631EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjAIUye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjAIUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8675D0D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:53:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-487b0bf1117so104130847b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TT+2XsH00KwTX585kTrU5AriHJozMAXcs0iFxeAd0aM=;
        b=Czdnd0b+5bkyGxVk+9aViJOW1TJ5m6k5XpyXdj4R+Q3dGGEBK2eP5deQvySgSh0iz/
         GZ1iYooFrZ5CipGLrqMEQsrY/Zn4kUyQA8m4xIFN7mfEerPKCDkU1AubZLdIfDfth4hu
         d8dG+6QDcTUs7A9Y052NxeL9TA5a3QdfxlEt4CBoSlbUsLAUBEORkFyS1sdo7qsKHieD
         EXHjCZRBRMhYEWoMQiXcySJyrWxVf33iALFZt6xsCbFcNo15dZaOnJt+J48Z17ETAj7O
         45DKwd6DY6kCK0yPohqOb3E3TN0P5VYKNR4qSRkuKInUqGltfhkGbi1MmOGm2N8pUB+H
         +TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TT+2XsH00KwTX585kTrU5AriHJozMAXcs0iFxeAd0aM=;
        b=bC7B/rJ3bVdZfmD7YYZZtl92FWvCZHlyc5d7T6uwJwdSoDaAH/3/GspsE7gH/oJE3Y
         YNMRv8y17rWecdG/EefZGbFAhpm1grM2Sr1FZ9GZ3a9BAsy40pDUq1b8eVXFQ3ozmq0C
         +VviG7ozHW8h4GXs9OX8aVUt7RhtG5St1bP2Lis68XORHnS/WERPnOVi1B/O1diGDSOL
         rkQzJsIVu+p6qNdCtLlaTBEX6lIiO2yk1mJn+u3r5Rqkm47lnNu/IRtB+0HClHkj07ZO
         k9peQbqzHUzVjWxV5e0cNQm4dodhfYqhBHuGt3SwvA6c+XKBKkRdVfxYaAEKyfFkqH7t
         cbWQ==
X-Gm-Message-State: AFqh2krcWkwsbUS2J382Dit4Tmi49DbKYlV/OA33TsMieHdYRVWHBYhw
        0urCr++7aSWDYrkU74IXXrdTb7k+6QM=
X-Google-Smtp-Source: AMrXdXtUN3SiDpbjRFPvhoNJBXB5uM1KkpI6Zcz0Naqt9m0yZDl1B9u4vz5wIeviZulbrZU/bcJYjep5MGE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:abea:0:b0:762:b86:e82e with SMTP id
 v97-20020a25abea000000b007620b86e82emr7288109ybi.407.1673297638462; Mon, 09
 Jan 2023 12:53:58 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:02 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-8-surenb@google.com>
Subject: [PATCH 07/41] mm: Enable maple tree RCU mode by default.
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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
index 3b8475007734..4b6bce73fbb4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -810,7 +810,8 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
 
-#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
+			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
 
 /* Pointer magic because the dynamic array size confuses some compilers. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..58aab6c889a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -617,6 +617,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	if (retval)
 		goto out;
 
+	mt_clear_in_rcu(mas.tree);
 	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
 
@@ -703,6 +704,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
 	mas_destroy(&mas);
+	if (!retval)
+		mt_set_in_rcu(mas.tree);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 87d929316d57..9db37adfc00a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2304,7 +2304,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	int count = 0;
 	int error = -ENOMEM;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
+	mt_init_flags(&mt_detach, mas->tree->ma_flags &
+		      (MT_FLAGS_LOCK_MASK | MT_FLAGS_USE_RCU));
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
 	if (mas_preallocate(mas, vma, GFP_KERNEL))
@@ -3091,6 +3092,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 	mmap_write_lock(mm);
+	mt_clear_in_rcu(&mm->mm_mt);
 	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
 		      USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
-- 
2.39.0

