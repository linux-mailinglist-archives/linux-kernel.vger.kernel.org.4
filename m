Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB774BEE2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGHTMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGHTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:12:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7726FF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:12:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2afso32392777b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688843541; x=1691435541;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTV0xihdJDZ3LmT5b0VvbfWVPo2l/pYZxiWhaA2z/Wc=;
        b=1k2h2Lzi2Y7Zso2QCXABxD6tKxYBi69Od4eg/BJzd/oZKr/yo1QC9zYTy+F7bkwUsr
         MJ4Cs8yuMwfbeH9sKlCNAwVo49wzFYe05nOmOIFdL12CZV8/kFSu5wJrvCOBni6b6XLW
         llu6z1SxXl9jUD2la6uHivLOfnp3yDTzL+wbIb/uZmz+uMYQ0KGYXgadTEUmWm9Uz2p8
         OvPqWDoLPuHzUoISVlQIJ3HwqRiXh8i6S85Nr9mydxCOVHJ3byBf5nAejApz8KtI+7VG
         nVka+9EAa6kAPb4o2CIYQlx+qV3ecK270Nq5eVaYu0hTPSFmvNlGf9LGupgmu1sf8Ore
         83wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688843541; x=1691435541;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTV0xihdJDZ3LmT5b0VvbfWVPo2l/pYZxiWhaA2z/Wc=;
        b=lg1pjAVblzR8WDKyLqXxYKE20KEdJBFT2YDx9ERnXNvSkX0K7Xn6/ItPdeVDXuAQC8
         cxMhmx9X+ZILHob7FfOF34X0PJai5Iri7o5tKE/+XZf389qepszt8ZP1i3TRiG6zHtJV
         cYaM/7XCdOihYqYtP05FMICniXSLcSVJmazhQi6J0rai/edh6tYi4Q/1roaBmu1Te+qb
         xc9rpJCp+DEIyUrezhqz1Cltb4YCkJymMW8KPbFHSO9P9Z8QTqlK7s3ydB1zMHKjExCN
         0bPB62XY7qruO8ni+abhPMSf5kj+/C751PNunL8weZMRkxm2GMZLS3JE+6naoILrp107
         oS1A==
X-Gm-Message-State: ABy/qLZHMO0GXf+LIkd7q229mys2oZs/1cb66Zi5/mYOKhiiKuKlIMhL
        GlRHace3QdMRfWUlBE+/cKNBragYYOY=
X-Google-Smtp-Source: APBJJlHVrRFpZyyO6dwy1Gjn4/30Rl1D+ek+P+dzMKAoVpdfL0WWnvznDWyGgdeVaC3RV2FWAanbuAUiF7I=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6f0:5193:79db:25b3])
 (user=surenb job=sendgmr) by 2002:a81:ac20:0:b0:565:b269:5ef7 with SMTP id
 k32-20020a81ac20000000b00565b2695ef7mr58334ywh.1.1688843541040; Sat, 08 Jul
 2023 12:12:21 -0700 (PDT)
Date:   Sat,  8 Jul 2023 12:12:12 -0700
In-Reply-To: <20230708191212.4147700-1-surenb@google.com>
Mime-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230708191212.4147700-3-surenb@google.com>
Subject: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
From:   Suren Baghdasaryan <surenb@google.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev,
        Suren Baghdasaryan <surenb@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.390.g38632f3daf-goog

