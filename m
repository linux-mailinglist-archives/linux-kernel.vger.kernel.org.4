Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19426747D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGEGhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGEGhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:37:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7821700
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:37:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c4e5e8093a2so3689396276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688539038; x=1691131038;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEcsCBzNF4o70240RbNtRsxkJMv3dgoeG47F/eJErR4=;
        b=NRt67G4eRCmPFMXhxD3qW9K9EDj0xnVdQKTKufRvQkcPo7ZdLBv0zTj1I+0oIpa2hf
         RNbwbPBRRogvAWVpk5UaiqbfxSKUz15RoJ7CB+USDdwHmnmfpV6jkLxbEnsYpFFZaO/V
         SHkrXnyB7eFzXg59ZHInsE6Ag/21l5iBDRtfRUxDxPZ/FU1OKcIdaR+keSSWazvkJh5Q
         7s+3RLuRM38qG/NcRSerlS841aoCJMp0+XIoBRVOSxggq4iZYaH+zqxDmhUtoJFuHlZu
         D53jP1OcRKF4mM/4S+ltgmuuTXWPdfIQ3Qrpc4LEr92kprtgKQxmqXBhxsp8tdb8AsgV
         55rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539038; x=1691131038;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEcsCBzNF4o70240RbNtRsxkJMv3dgoeG47F/eJErR4=;
        b=VnjvvCmzf69SQTBgCZs3RISXrhsnJlJgzrvbC0tDwpSCI0SyB1hjIpTIRpSYSIv24s
         oAKw4exigoVoVfGAqEgBRtFkLX1+PgrUGX5nrleqFZrNIFLLHF+Zdt4vR2IruWF2Lnbx
         nitekjTFhlPWjkOEK3pyjs7UQlUtLWaEdX9XFa7CE31uBPQtc5b4gyhAQQou1D6eFmbb
         1b/ro5aVGYERVIjS0m4eaiE9t2Z5NzV+fdDrk5ZjQ0MqjPnuPIYgzLQSx1MyNd/KoOIM
         A0ddH9OJeY5JnGzbjfrvhE3DC+xlTYKjgobhE2T08JOzZ43IsAmpOHKIWN3rD05j3qke
         fESw==
X-Gm-Message-State: ABy/qLbyQocTr7WhuXjtCVr9lH6n3QxDDpkVPVCly4yycqePlf+r/6cw
        le7LfVbXmnJeubJJUSkpcOw7o/183+w=
X-Google-Smtp-Source: APBJJlFxf2AFzH5E1himxE/0ay/K/ncJrIflv9U1K8XKuqoxYpjdV/ZXI10Rc5HBkhf6oCEZCsT7XVeCpvM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9164:ef9f:8918:e2b6])
 (user=surenb job=sendgmr) by 2002:a25:ad96:0:b0:c5d:5b6f:f5c5 with SMTP id
 z22-20020a25ad96000000b00c5d5b6ff5c5mr31841ybi.4.1688539038122; Tue, 04 Jul
 2023 23:37:18 -0700 (PDT)
Date:   Tue,  4 Jul 2023 23:37:10 -0700
In-Reply-To: <20230705063711.2670599-1-surenb@google.com>
Mime-Version: 1.0
References: <20230705063711.2670599-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705063711.2670599-2-surenb@google.com>
Subject: [PATCH v2 1/2] fork: lock VMAs of the parent process when forking
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
Cc: stable@vger.kernel.org
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

