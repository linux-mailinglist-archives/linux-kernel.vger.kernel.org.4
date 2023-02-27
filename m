Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF76A4836
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjB0RiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjB0Rhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C623C78
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id ki15-20020a170903068f00b0019ce282dc68so3909227plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWCYeH3rb3vSAFp54Mmrv1+eix/+tyqClZQn+3lumNA=;
        b=qq9ST5KYd7H0i08HiNSL8c29Xrjl3aIZNo0vqd33ohY7IlOekjqUFmHX1pCbc/0CIB
         UJYRScXv/uQI5WgiH6m5n3NDzNqXvXc+EBT3Nr8sb84051cUA5rcu7NsZAUPZLQbAT+k
         L1+D52rxNhib5vRaYFXHr0l0OBrPbhYiKHs0HG8E+v4FWKdNvWFhRWhiPM7+2blQtGKB
         AQqKpecJF/PSLRs/Iu3OWc/90nRfqSr4OY1HTu201oV1jp1/8gN3EH/qUSvYipkLdMaB
         KA1JreUYCECV/wYDbpy6/KFPjd6XlpEX5mJczzYRoBrzVCeQlTDt7q+I0gm0goYKe+3A
         HbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWCYeH3rb3vSAFp54Mmrv1+eix/+tyqClZQn+3lumNA=;
        b=OICOCI6F+eOIk+OzMnv/sWdUs/hAi3kIxg+VtxYshKA4wgIqL1HIBacsnVSPyOi1Ma
         LF/0WwguV/8ijYWzV2rWn/PPDSdDpxwCItI45SfFK5dBnKpsyiqlYFThRvrz2Qjv6LxN
         wb+vwpLcTMKbU2gddyDtlOU8Q0FNLCWsMvkwTu3OOW3S+Ifl+Ics78n+LAY7K36TdTtW
         VQcQKqHOYoJC8eODI2hFQqxZmoIAXGy228JRFd4Xz9wc5tEak/MUaFspcppJgDeKELOw
         LX8fDbJsInkccqCzLmMx0QYkFOrIEi0wYsEfZVZxgGx0huxbOqFIxM2LNtW/W23Sy0sj
         ISXg==
X-Gm-Message-State: AO0yUKUKJMpzEdLYsFwuwB7UyC48LWdEqp/toH0SLeCa3t+8o7Rsvt5o
        WxBoXdxftrzV+MZN1jy6PBgR5yw6SFA=
X-Google-Smtp-Source: AK7set8jO949nwq1qPTfiOwF5d/NxOGl9PwUBICmy0J7iLD+CPMrX0ZITRyhhJB1FHKtenUKzwzPrWF2iBQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a17:903:2682:b0:199:56f2:3fc4 with SMTP id
 jf2-20020a170903268200b0019956f23fc4mr6277864plb.8.1677519430200; Mon, 27 Feb
 2023 09:37:10 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:13 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-15-surenb@google.com>
Subject: [PATCH v4 14/33] mm/mmap: move vma_prepare before vma_adjust_trans_huge
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

vma_prepare() acquires all locks required before VMA modifications.
Move vma_prepare() before vma_adjust_trans_huge() so that VMA is locked
before any modification.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c234443ee24c..92893d86c0af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -683,12 +683,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		goto nomem;
 
+	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
 	/* VMA iterator points to previous, so set to start if necessary */
 	if (vma_iter_addr(vmi) != start)
 		vma_iter_set(vmi, start);
 
-	vma_prepare(&vp);
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
@@ -723,8 +723,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	init_vma_prep(&vp, vma);
-	vma_adjust_trans_huge(vma, start, end, 0);
 	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, start, end, 0);
 
 	if (vma->vm_start < start)
 		vma_iter_clear(vmi, vma->vm_start, start);
@@ -994,12 +994,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vma_iter_prealloc(vmi))
 		return NULL;
 
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
 		   vp.anon_vma != adjust->anon_vma);
 
 	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
 	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
 		vma_expanded = true;
 
@@ -2198,10 +2198,10 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
 
 	if (new_below) {
 		vma->vm_start = addr;
@@ -2910,9 +2910,9 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (vma_iter_prealloc(vmi))
 			goto unacct_fail;
 
-		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
 		init_vma_prep(&vp, vma);
 		vma_prepare(&vp);
+		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
 		vma->vm_end = addr + len;
 		vm_flags_set(vma, VM_SOFTDIRTY);
 		vma_iter_store(vmi, vma);
-- 
2.39.2.722.g9855ee24e9-goog

