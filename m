Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615C698BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBPFUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBPFTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B971D42BCE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-527501b56ffso8391427b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rL5PSjChr8wFTlKRWTO498bp0kCwADLZZe/SXHes2h8=;
        b=LRD+lTaXr6Pqw8LYMkej56Kfm91pJviFVpFaUDR17WEIFgUKOpU+ogLRfy6oidvw/F
         4mOXwIhPJkh7gxaJzacQ5Q2xpA2MxMudctw4pQKYtuqshuSCMBeCw647b99z6JqUfMYU
         FnWI7aY3RIFvc0EuIZqwF4n5sAACqaxfMc5BUHOhpo7PrLkybX4Nw85DLStMxOu85Den
         S+x5aTXsnUr3Va/T4IBtQXPzTR4iMs6msv64zgKWL87HLYoK/sTJqZLT5fditOnzScG6
         JUQkoM18jflZAeAGFMAkFQi7v0aeD9Evl42tB/J4ec9dW/Jbo4ktb05auTom3OB08iqz
         18AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL5PSjChr8wFTlKRWTO498bp0kCwADLZZe/SXHes2h8=;
        b=oJDdWhN0RQy9I/hsb4XFwsiK2vAh7zeStY3CwjBy3BWD/hn37uUGYL2UJ0GKdWoEaI
         BnB4TqXN5H2nAdkVmwido6KH6uBNWt55Amd1shMzEMdUDWTGCWMOcz/PoqH3oxBd3RAf
         qAD+hyCp3M/QasPeWvDxw1O9B9woITynPJZJ1awqJj+/QKz3O0fZGczViUJJ+lRjSOQ8
         9PA67umAd/pORsWQMmtkIr8ZcuF0UdsV5o0PvtSLqnSBMooWcYMRcEprKwnw8+p8NpZ1
         aouNk1eEhYm4uriF9ly5mLigDEm+ge5jQJknwn6XY5Kc8eE6UbFkIar+4JWbPz9/qsjw
         0scw==
X-Gm-Message-State: AO0yUKXm3KAlMKeaGDPmp8mMIFRS7KprUtNB0dIVtILxRKA6lMPMbT8W
        KmT7TbMb6FsQQH/n5RQhUJIWvvwf6wA=
X-Google-Smtp-Source: AK7set+44y5aeQf1zuFNW05XeMWyuIDsdI+r8pPqkHzR/in6WRVQ9dwNjFzyqkfy6m3wNLuusOCyHSVO/GU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a0d:e506:0:b0:52e:c531:20b3 with SMTP id
 o6-20020a0de506000000b0052ec53120b3mr448676ywe.147.1676524720915; Wed, 15 Feb
 2023 21:18:40 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:34 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-20-surenb@google.com>
Subject: [PATCH v3 19/35] mm: write-lock VMAs before removing them from VMA tree
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

Write-locking VMAs before isolating them ensures that page fault
handlers don't operate on isolated VMAs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c  | 1 +
 mm/nommu.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0eaa3d1a6cd1..aaa359a147b2 100644
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

