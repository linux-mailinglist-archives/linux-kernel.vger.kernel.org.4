Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6387492F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjGFBOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjGFBOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:14:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698961997
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:14:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704991ea05so2923157b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688606046; x=1691198046;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRyQ8wft+e4cwUe/4GM3Z/J/mXzz/SW74opGciLdsgA=;
        b=xMFTe33UghKj4/G8jSkl+aAMntxmpgQyUTj2jgLHCbBzVb7QaFsV3Qt5UoTcoYiY4e
         ynbz5c/7AAWVN4OWYl8Rutu8qVUj0BgMtJxbdqQQF9Jgj2E43IhnOz6jnjLRWn+jh8qZ
         j2jKUrzEpotfW6PkRYlwOxlBa05JaVxygK91qgISwSCJF2DgNiZZyxbTnZqSsVrACtS3
         T0QKYCFZrPolcFgqdTex7G8qQAvSlc5QZU3T0X5EJgWJI+yUFCfWtKZGTVyoMQiosrU8
         5V6sSW20QSvTmgMgA2i9rYZyRIgVoD6GV9SZ9bs/ZCOyIFX0hAk3ZF/G1pbDqovqnTVD
         8e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606046; x=1691198046;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dRyQ8wft+e4cwUe/4GM3Z/J/mXzz/SW74opGciLdsgA=;
        b=TnISV8B4MumyACqDVc5niW197acyrjstvV7BBfqNkfjZ0MUsiLXC250b7hc6H/lVRF
         oQlFpLWAgFaq+INE+bdqaQHALTqPSO6qnl+ZWq1nDbbqrjEMW8sQuqjToMt2nsO7LrWc
         ZrHW/h73rmP/YhKHEswwmg1z4aDWin8zBA6ANH6mLAIHofKJYdbXu2d4NOal6ojXnlwa
         1P/pThGzua7OCVlAapWcswFMDCWrfc0cK6J5CZD2Sdej/zVXUyw11bW8wki1+aLwC8Sn
         ELBfVk/g2JOpH9MbCI247AqEjIETt+r+EhxuiroJGbgDyqjC+iitg3foC4vN+A8GytGk
         t5oA==
X-Gm-Message-State: ABy/qLZASiJVZZrzDur6WrKsEFuTT6qWvpVZsXPnpSHSiMLK0AozYPWw
        T8OhDIZ/DaDTJCsopOZq8hyRiDzE22s=
X-Google-Smtp-Source: APBJJlHcrjVsSxUzFTFx4QaDgI6yh9N4fazbh93P07JImKRnjPmhjhwgjMJtlGesIKuFtSoRWtWbpywIl+c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:946c:be30:90d9:9093])
 (user=surenb job=sendgmr) by 2002:a81:e409:0:b0:56d:5d2:1bb1 with SMTP id
 r9-20020a81e409000000b0056d05d21bb1mr5654ywl.2.1688606046365; Wed, 05 Jul
 2023 18:14:06 -0700 (PDT)
Date:   Wed,  5 Jul 2023 18:13:59 -0700
In-Reply-To: <20230706011400.2949242-1-surenb@google.com>
Mime-Version: 1.0
References: <20230706011400.2949242-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706011400.2949242-2-surenb@google.com>
Subject: [PATCH v4 1/2] fork: lock VMAs of the parent process when forking
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
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
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When forking a child process, parent write-protects an anonymous page
and COW-shares it with the child being forked using copy_present_pte().
Parent's TLB is flushed right before we drop the parent's mmap_lock in
dup_mmap(). If we get a write-fault before that TLB flush in the parent,
and we end up replacing that anonymous page in the parent process in
do_wp_page() (because, COW-shared with the child), this might lead to
some stale writable TLB entries targeting the wrong (old) page.
Similar issue happened in the past with userfaultfd (see flush_tlb_page()
call inside do_wp_page()).
Lock VMAs of the parent process when forking a child, which prevents
concurrent page faults during fork operation and avoids this issue.
This fix can potentially regress some fork-heavy workloads. Kernel build
time did not show noticeable regression on a 56-core machine while a
stress test mapping 10000 VMAs and forking 5000 times in a tight loop
shows ~7% regression. If such fork time regression is unacceptable,
disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
optimizations are possible if this regression proves to be problematic.

Suggested-by: David Hildenbrand <david@redhat.com>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@ke=
rnel.org/
Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@ap=
plied-asynchrony.com/
Reported-by: Jacob Young <jacobly.alt@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first"=
)
Cc: stable@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index b85814e614a5..2ba918f83bde 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		retval =3D -EINTR;
 		goto fail_uprobe_end;
 	}
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Disallow any page faults before calling flush_cache_dup_mm */
+	for_each_vma(old_vmi, mpnt)
+		vma_start_write(mpnt);
+	vma_iter_set(&old_vmi, 0);
+#endif
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
--=20
2.41.0.255.g8b1d071c50-goog

