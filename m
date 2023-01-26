Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC8D67D571
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAZTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjAZTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:38:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2A402DA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w70-20020a25df49000000b00803e799d7b1so2976685ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SychSIO4sUWIo6QruxirbFjx5CbYNnUeHZ00ltQsQk=;
        b=Pfx+wzAhZ6kKsJzDDedQ8LJwSdqFciZXcllolwp4vBQ+2oIO3zY1GANQzoJfCZWzvE
         CQPh21a5oWziH93KMEhfcmcYLI66KcWMq+wv9dH36RAXDaWDj3mhxF37O3hO+Nm3j333
         DQpz5N93q63IgXjq4N824biP5tt/Btbtpk79Xp1oY2XkCbJniy2hm75eubONJlrUyJHz
         4nhnfw5vwu2MM7c8JHS86kwr5IkxCGiAvk+B0fbplC2co4C0HnFTpw4esf89gAkAXtE3
         btQ+U4BHBe8XCXeuy8OqZ9E2kM4KncMQmpjGCBcfb2U1tiWjIaGyYCULw+IAQrOfXIUP
         +Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SychSIO4sUWIo6QruxirbFjx5CbYNnUeHZ00ltQsQk=;
        b=WK3CZIeRLI+fSss2z01j4gNLHPk1qm/pwEiQ5dckmCYGBg2TgmpkFOXNp45lWM2GNq
         ub8s6HK95jEOhAKYP4PO2fh+Zp50HQnYy2eE1xT267UrXXBOuD9dUZU6BHiUNM3AaqAX
         u8ILVSmv7o1+gXirQpg1y2vaPjyiADTOBgDVTCyVFLy11yOW6WvO1KVGNjNIA85+EAmA
         U6SFcDeOjM3VQLM0A++6njcjle6So/wcZ61JBhkTNUDIXcslANAJae80iKt+RW1z4Bch
         y/OEVvnOxLa0z/V3q1m2nRuvxe50WU+Qj6kik70E6iGWVZIoDJ2gz96Ow7s657rCiKVu
         /Jeg==
X-Gm-Message-State: AFqh2kqERfUIDbPgrcGOEZMgpSGu3GufKSbF2ajFo4j+oi6afmnKlMkR
        bLLG1BTpPI90C6+90vVJAa+Obme0y5s=
X-Google-Smtp-Source: AMrXdXsXS6jvs2FLo8wLjzpNR7510A/NF2577gEg88y5p+yBM43aas9S20uDvZYfhxK8qIb0YJZmeRS9JA0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:d774:88af:bab3:648d])
 (user=surenb job=sendgmr) by 2002:a5b:2ca:0:b0:7d2:d238:42b4 with SMTP id
 h10-20020a5b02ca000000b007d2d23842b4mr3963873ybp.526.1674761888262; Thu, 26
 Jan 2023 11:38:08 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:37:50 -0800
In-Reply-To: <20230126193752.297968-1-surenb@google.com>
Mime-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126193752.297968-6-surenb@google.com>
Subject: [PATCH v4 5/7] mm: replace vma->vm_flags indirect modification in ksm_madvise
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

Replace indirect modifications to vma->vm_flags with calls to modifier
functions to be able to track flag changes and to keep vma locking
correctness.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 6 +++++-
 arch/s390/mm/gmap.c                | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 1d67baa5557a..709ebd578394 100644
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
@@ -409,12 +410,15 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
+		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
+		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-			  merge_flag, &vma->vm_flags);
+			  merge_flag, &vm_flags);
 		if (ret) {
 			ret = H_STATE;
 			break;
 		}
+		vm_flags_reset(vma, vm_flags);
 		start = vma->vm_end;
 	} while (end > vma->vm_end);
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index ab836597419d..5a716bdcba05 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2587,14 +2587,18 @@ int gmap_mark_unmergeable(void)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
 	int ret;
 	VMA_ITERATOR(vmi, mm, 0);
 
 	for_each_vma(vmi, vma) {
+		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
+		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				  MADV_UNMERGEABLE, &vma->vm_flags);
+				  MADV_UNMERGEABLE, &vm_flags);
 		if (ret)
 			return ret;
+		vm_flags_reset(vma, vm_flags);
 	}
 	mm->def_flags &= ~VM_MERGEABLE;
 	return 0;
-- 
2.39.1

