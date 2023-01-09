Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514F663207
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbjAIU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjAIU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:56:08 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD478B510
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z3-20020a170903018300b0018fb8ca1688so6973059plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=olOpibg5eXy7KG3cFGJtGZQRi2wnSYuvllMlsZALFjE=;
        b=pKSCW4f0d77MorxMhTYeMa3Bkvztzi2l/11p+8AD9JlAcd7O/4nLaK3tMdO/JZYFZO
         oqL+3k7pxb64mumhhSbnD+8oqAK9T+YZbtnVKYdyWwz1xTl0lxuCTGJlmjyD4W6tkdoJ
         ScE8xkE+709mZSvnfMafhqWZz0JUfC8PX8Gqgq4hVWAiFqsbly88nJnbf2OtvsEjRJ+V
         Bh1jSeLHcoArd7dhSosnJ19E8FECzKPk1IhOzNYJUOL7f9tKHCqrIEP0OXg1wGsfV/sX
         JopWIX7MNjYmVxKWpBhB8gnFt1KMXJN0MSlcK65fQjg6FKg5IorU4J4ePrdeGZ792swl
         N3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olOpibg5eXy7KG3cFGJtGZQRi2wnSYuvllMlsZALFjE=;
        b=Cse5lVDedKARQeb5dOg8SwyoAtu+QJQ4oB/2nBrSGg/s27leK0jzpr1QZE+41ziT0J
         hSqEKktydZ2zd0wYQcrKSTZpwEvq6QFW9QZU05o8ewxsulMXjpFOSUQVK3R5GAENo/ab
         q2SwEK81hyeZ0TLV7Z3TXeRrg49ANKQ3GRiwWcerOuxfMcnL81TSgaIeCLVRWMkTQP1z
         87hdIRgCzYxN86Q65mVsL3YOeIMgKqHibIyodCNddG2gFRjmbhYPKg0Kq4wc24MrCrmc
         roPOYHT2bZAmLh/RhhcKh1UtZTy/TIGmOH6aUfjhwME3JsnkuR8NDdKHaJjHGHn8wST0
         7RtA==
X-Gm-Message-State: AFqh2kooJSGHSRf56ZYbaMJ7MtGrB9lNinD/ziV1TkqufYBRkkrST25p
        Jo3tHIxBfVwP8Hx2dm1X/TBNxYRD34A=
X-Google-Smtp-Source: AMrXdXsFsv+WY6uB2QAxQKVey5zkUH2AXIcpYb3YNAv+Gej95uP4vEcIzk/UCgPyK193sduP1xpoK0p/ZF8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a62:1501:0:b0:589:8362:c7ce with SMTP id
 1-20020a621501000000b005898362c7cemr251559pfv.21.1673297679447; Mon, 09 Jan
 2023 12:54:39 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:18 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-24-surenb@google.com>
Subject: [PATCH 23/41] mm: write-lock VMAs before removing them from VMA tree
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
        surenb@google.com
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

Write-locking VMAs before isolating them ensures that page fault
handlers don't operate on isolated VMAs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c  | 2 ++
 mm/nommu.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index da1908730828..be289e0b693b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -448,6 +448,7 @@ void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
  */
 void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
 {
+	vma_write_lock(vma);
 	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
 	mas->index = vma->vm_start;
 	mas->last = vma->vm_end - 1;
@@ -2300,6 +2301,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
+	vma_write_lock(vma);
 	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
diff --git a/mm/nommu.c b/mm/nommu.c
index b3154357ced5..7ae91337ef14 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -552,6 +552,7 @@ void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
 
 void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
 {
+	vma_write_lock(vma);
 	mas->index = vma->vm_start;
 	mas->last = vma->vm_end - 1;
 	mas_store_prealloc(mas, NULL);
@@ -1551,6 +1552,10 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		cleanup_vma_from_mm(vma);
+		/*
+		 * No need to lock VMA because this is the only mm user and no
+		 * page fault handled can race with it.
+		 */
 		delete_vma(mm, vma);
 		cond_resched();
 	}
-- 
2.39.0

