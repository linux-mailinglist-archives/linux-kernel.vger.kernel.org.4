Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A47478E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGDUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:07:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B718B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 13:07:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff81be091so62927677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688501221; x=1691093221;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8il2W3A+Y7dZW8xauwfpOUi9D6SLUIEJNmGFcA4NVg=;
        b=6VCAkwu8Vj/qi03mCMziSMUtK2HemZuvC0I/OyVXR3EqfP3G6zpDUX/yE5A84wYXHs
         Vprk+pCbwwr5BJIsl2f7iCstULYXel5PXQjVyFU8x4ocxvsmJu/Ijw9ucU9zSExQSPVJ
         GjfBPz+I4GWvxMeyFmWCK+hZnrn51I2seHLCHVjcRPGORoPK3UC0L3RotkOC9Mpu7r22
         63WqExhTkViW4O6Pxql2AJSPXAmeeLluTcOHO6Kga2OWz7K11pb+2XVjOc/Ovw26usyn
         NFE/enwZP1tGesPvIGeRCKvuC/KSspHC43PLVf8huMbGaGy2Y2IHO2VvZnoKNaEc8d3t
         OWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688501221; x=1691093221;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8il2W3A+Y7dZW8xauwfpOUi9D6SLUIEJNmGFcA4NVg=;
        b=EJAAZTqYvBxHMaTUTg1iWk/Dp+yb/sK4+rz118+HxZcCRxSZcpxtjPmQevYJmrep3o
         Mbk+aySGQsFfBpHUMBJXv7fXw9toBeP+SjHwJtB85rA82AnpNWRKeqIVFCLdOAXa/6hP
         ixsOFp8BRrkHelTpWL0HdcFHlgaHBYUBX8rFsKJ10JwxRdb18UzGKI3ldX/A80+dtFHC
         3JIZtIcBzCnxPNAqKZofCo078hkcaboqx5+OHQcZG4sQ8P+LNg3zq8C0jgEJYwQbFRts
         kTFqmlavZ6fEr5Sykc9mUOsvrsReByMW7y/sfwb3onIKTg34HdCLZesL75xZ9RG7iAwm
         uzMw==
X-Gm-Message-State: ABy/qLYlYtJNqXr8uMyb+J5DLNdAY7sQ+RpXyAImv13Qr8u5SrZb5+XL
        Ojn+92vQOa3eHXzWbab2qXdACsGEGQ8=
X-Google-Smtp-Source: APBJJlEeX9skwLcSa6ScHb3JM5//3ONAkxhpQ7w9Tg9rQrPR9RX9XqSOF0TFni9TD5TubYd6ol0QzlgFmOw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9164:ef9f:8918:e2b6])
 (user=surenb job=sendgmr) by 2002:a81:4109:0:b0:56f:f77c:3c7d with SMTP id
 o9-20020a814109000000b0056ff77c3c7dmr103135ywa.3.1688501221474; Tue, 04 Jul
 2023 13:07:01 -0700 (PDT)
Date:   Tue,  4 Jul 2023 13:06:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230704200656.2526715-1-surenb@google.com>
Subject: [PATCH 1/1] fork: lock VMAs of the parent process when forking
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
shows ~5% regression. If such fork time regression is unacceptable,
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
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index b85814e614a5..d2e12b6d2b18 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	for_each_vma(old_vmi, mpnt) {
 		struct file *file;
=20
+		vma_start_write(mpnt);
 		if (mpnt->vm_flags & VM_DONTCOPY) {
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
 			continue;
--=20
2.41.0.255.g8b1d071c50-goog

