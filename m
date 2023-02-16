Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D22698BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBPFVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBPFT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:59 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886A47435
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52f1641b79aso8473097b3.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2G5AxmmOVrsRnXlCrW6/hvh5FUxSjD+0mS6LSWzYfho=;
        b=sqrDU+BCO7AIuj2EKpC5JjJjchpfs4e7nICzmha43sQtLyfoiEZwLUOwsCD209H5Ui
         lu0l/EwT0lWrDRHYoglaYWRXNYPJ1g8O+GpgkaLO5UTCsF2sShD98xQNq7PDWtH66r6g
         ZsB+oua1JfA0KymwRm2/PgdgPfreEDDqnwQyHLX1ndmfndQgCQh8neVqDDo8QNluQIit
         psaYv9QythR+X2eyBbc1tAjHl/fZRS54lIuiB1Ux7odRjp5k2KlmRL+IIzajgpgWcCV1
         agKdJl/mJ1QtI4UVDWAjmp+dEFlVMZYnML3DG7HfRey4EeaADk1hZvmemdIk3Yb/sCoK
         4MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2G5AxmmOVrsRnXlCrW6/hvh5FUxSjD+0mS6LSWzYfho=;
        b=qcvcJ7dngs44avmgN2LjXdG3axYwu76OjwEDxZMCxitMtZmyibKsvEieuLyIaDIgMT
         Ux9wBggc/OxN5ps3xj4qIVEzv1iLEt8Qj2FkAkXpspsWYuaSL6zSiuSy1ab/2sS0RNXb
         KM8f6tyGsD//Z+eT5vtsJJZHDI95ML/IT6riKW13ChKKyTuOOIWwCg2EBjdrN5fsf7X7
         KFPkdUlkTBooBc9ux+B4zvNL3AttzdcrIlMsXsBTk7UZsNHeES0g3T5g5Q4W+eThqu4U
         zFCmeMyvQazWW1qHwvKxGempdmVRABGpRMde9dpQKLqTV8u2UVG+zyhPM5SRK/rgR1R9
         esGw==
X-Gm-Message-State: AO0yUKXlruymgF53lwLGKjQnHxo2z7Ccm+A2u2ihQPj9RIP0GdTT2KRm
        8gFlMHt/odByyC+J98YaIDEquQxG4zw=
X-Google-Smtp-Source: AK7set/QuR9OxnmNolAau/sd0Kj8g/BkdB7enEU88ehNvfonJ32Y6Yzdt5dUleuzBy4yluRtxlQTgtsiJAU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:13c6:b0:8da:3163:224 with SMTP id
 y6-20020a05690213c600b008da31630224mr7ybu.0.1676524744013; Wed, 15 Feb 2023
 21:19:04 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:44 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-30-surenb@google.com>
Subject: [PATCH v3 29/35] mm: prevent userfaults to be handled under per-vma lock
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

Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 555612d153ad..751aebc1b29f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5254,6 +5254,15 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_start_read(vma))
 		goto inval;
 
+	/*
+	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
+	 * it for now and fall back to page fault handling under mmap_lock.
+	 */
+	if (userfaultfd_armed(vma)) {
+		vma_end_read(vma);
+		goto inval;
+	}
+
 	/* Check since vm_start/vm_end might change before we lock the VMA */
 	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
 		vma_end_read(vma);
-- 
2.39.1

