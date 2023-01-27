Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A867EEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjA0T6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjA0T5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:57:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D824A20F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:55:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso6391663ybx.19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIuOo+WD7hhMM8dbfJD4mGHBD08/Cqf6l0kIi97gWpI=;
        b=iI2a7MepfOBNDqB7wu+/83gKbYOOOUW8grtwa3CiYxFM9JfwE6yM70Ne3Bb3nWcBVw
         Yu75uY4jTmGekedOn8ngeIwpB83dCuwgdGAmo3PP8/5H9WQZ6zUPSiR4iOLBbFN7215j
         t5fY8PD6baQLdLtkjh6u6ca2lGsT7fHu5oxzuRWhyEjLoCc6wJIYtxHPj4OPz1R/r154
         +v9JTIHiwr1S1nQG1EzjVKOQzPqMVCb1Q8Qi6vYQuYU/8I9rd1kQnHGC5kdzCbnlOWk7
         FPBIbkrQ5+p0qEBCYmhl8CWtOia+KC/VA/z2TgOLyA8KXzLYreAkUsa906GcFZG1qYyr
         SCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIuOo+WD7hhMM8dbfJD4mGHBD08/Cqf6l0kIi97gWpI=;
        b=Q+bNhDyyt0TgmdfFWixxRubvRkV0JVtQuIRZEjoVFtEwPCokeMtGgJpAB6vGNCK/Iv
         auIwJVr7QM34ouwh9SgkIz8KlF/QxrZli5tXnMlmB3mt9amDsLQn7+28tYW9k240saMC
         Y6UGEWUIJkV5kUWltzkcXzVSFlEBIcTs1W/srBOc0AhMcM/U/PVYF3tk+XVwBnA/ySys
         azK1kA3l5vWVQJHi5/xPCnUwRbUuUo49L+EQESG4S7itbI9L/Fzr4OX7X+bJj1Ge90rF
         2or7hcf5cC57gww/4lhBnUf2QGbC7tqK5tL/RZhDyJB8A1SM6/1B+DchGQtRL/WLERsN
         w2mw==
X-Gm-Message-State: AO0yUKXdcn+owEL6f3C+DlxvoIA7Hw27I29aEq3pQbWRWffDX+HWuU+2
        CjRZA5tm1PebCb6hrH0CZiUR8bgNZA4=
X-Google-Smtp-Source: AK7set91XCOXqw0Dg5UJpzZX/mqq3ueYFNiPcfvNNp2V4Tl7t8riuyYgZdoB/8yFEdiYxfiOzkRBBcWpyqU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:3e15:0:b0:506:653c:db97 with SMTP id
 l21-20020a813e15000000b00506653cdb97mr1675918ywa.201.1674848517274; Fri, 27
 Jan 2023 11:41:57 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:55 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-19-surenb@google.com>
Subject: [PATCH v2 18/33] mm: write-lock VMAs before removing them from VMA tree
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
 mm/mmap.c  | 1 +
 mm/nommu.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index b3c247073aa0..5bdfd087b632 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2261,6 +2261,7 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
+	vma_start_write(vma);
 	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
diff --git a/mm/nommu.c b/mm/nommu.c
index 57ba243c6a37..2ab162d773e2 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -588,6 +588,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 		       current->pid);
 		return -ENOMEM;
 	}
+	vma_start_write(vma);
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
@@ -1519,6 +1520,10 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
+		/*
+		 * No need to lock VMA because this is the only mm user and no
+		 * page fault handled can race with it.
+		 */
 		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
-- 
2.39.1

