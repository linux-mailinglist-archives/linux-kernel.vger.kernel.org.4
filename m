Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3EC67C0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjAYXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjAYXgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:36:12 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F775E52D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-482d3bf0266so1663367b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFNiofQkx8EGkioLCgUuZFMgiu7EagxK9ILw1Sow0vM=;
        b=mIcpdtGtTptlXBa8kzPRiZ4LQeL8L4qFSrls4nVpFeCNpMiSotY6f+paMy+LghZ8V6
         e9l5UcyWL072m000YU0+L04zrVr4EhWAwoZTx/p7MV2c+3YkTz0Vc17xg7GsN6zD4Z9R
         fONlZs10IIrOred9HnpC0C3EFZJdB0XAfbhzeR0ZgQ/dkYvIT6XW43EAfnRvkqq66q3g
         TyPxEoXRoXVo+FH/WvNzfXLvwh7J86Ui+UKVO/3Scbbi/do79F5NcZ+HTnfVO2bahnkQ
         86T/MKLgW1x3swE+dFhZ6o7oKt9I4CYoHoHaBYMQWqHMdLwEjkwoM3UIGDBmnlaN/XJj
         pP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFNiofQkx8EGkioLCgUuZFMgiu7EagxK9ILw1Sow0vM=;
        b=rDuGQyvQ6scJ3VJ/fhObAMeQ3sLEUxfPWer425Dq2h+HufO7Pxo86UYc2b6lGPIrAT
         Dgwfb1F2GpEf/IgJ1Q/PWjgjM1IGSvtTkx7VXYX0PBiJFomrF96E3Ly7pVXakzGpTUPV
         e1GJEPzJwRerE6ltWfRaDxGY+qDxdmyqwbTse3E2iw4JrX3e5F9u69kyQoZBfjslm4K3
         htgJyt7jjW5gkTYWt6KNZsGukjGjQvhAlR73egtSis0W5mX8AAwdBdgUy2k5NDi/X2U5
         f6i5CiikEztGqNBcIRX5B62w1vLs9IRGrwl14FVTTqDKIavBjDn0RL9qlwEyipG8pf0y
         MOdw==
X-Gm-Message-State: AFqh2kpYpIvbyj2AHE+47RHokxnwbKDuKrdaL2L4qL307bJFaw58xJkQ
        kr6yJnrM39Abb5HRVjF4RACwlgBy8gA=
X-Google-Smtp-Source: AMrXdXvMdRhk8RmJeZj9msjjVduAuvJeB5wZmXR/kRnEPyHhZJwnM0jGg8ZrEwM+ym7wuYAnXhndpOMqpaU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a0d:e582:0:b0:4df:96d1:f67a with SMTP id
 o124-20020a0de582000000b004df96d1f67amr4204399ywe.246.1674689769324; Wed, 25
 Jan 2023 15:36:09 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:35:52 -0800
In-Reply-To: <20230125233554.153109-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125233554.153109-6-surenb@google.com>
Subject: [PATCH v3 5/7] mm: replace vma->vm_flags indirect modification in ksm_madvise
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

Replace indirect modifications to vma->vm_flags with calls to modifier
functions to be able to track flag changes and to keep vma locking
correctness.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
 arch/s390/mm/gmap.c                | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 1d67baa5557a..325a7a47d348 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -393,6 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 {
 	unsigned long gfn = memslot->base_gfn;
 	unsigned long end, start = gfn_to_hva(kvm, gfn);
+	unsigned long vm_flags;
 	int ret = 0;
 	struct vm_area_struct *vma;
 	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
@@ -409,12 +410,14 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
+		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-			  merge_flag, &vma->vm_flags);
+			  merge_flag, &vm_flags);
 		if (ret) {
 			ret = H_STATE;
 			break;
 		}
+		reset_vm_flags(vma, vm_flags);
 		start = vma->vm_end;
 	} while (end > vma->vm_end);
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 3a695b8a1e3c..d5eb47dcdacb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2587,14 +2587,17 @@ int gmap_mark_unmergeable(void)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
 	int ret;
 	VMA_ITERATOR(vmi, mm, 0);
 
 	for_each_vma(vmi, vma) {
+		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				  MADV_UNMERGEABLE, &vma->vm_flags);
+				  MADV_UNMERGEABLE, &vm_flags);
 		if (ret)
 			return ret;
+		reset_vm_flags(vma, vm_flags);
 	}
 	mm->def_flags &= ~VM_MERGEABLE;
 	return 0;
-- 
2.39.1

