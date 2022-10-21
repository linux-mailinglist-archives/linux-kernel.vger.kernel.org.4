Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822676074BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJUKNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJUKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72FF7AB12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHrPlMhzTs5FfUPfL2J2Q5lLuPRkNLMRcyfMgFj4nT4=;
        b=N0Ce5rcVUBQr3gTezV1zh0XBJS1P/gMC0KTXioI/3eSQJG+DnXbbumJGMxAX+2gvVaiLS8
        sp0PiYrQmi6MsFHf/21NsbIXhGffhXvssfr7dApHsqE5h1HNZX/HUXDe6pEsTy9IxQRECh
        YtAjQdjRHmmbMArpoyVQxxbnbR9LYPs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-dn75feFuN_6Iop431YOpQQ-1; Fri, 21 Oct 2022 06:12:34 -0400
X-MC-Unique: dn75feFuN_6Iop431YOpQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36AF23815D31;
        Fri, 21 Oct 2022 10:12:34 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D682940E42FB;
        Fri, 21 Oct 2022 10:12:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 5/9] mm/ksm: fix KSM COW breaking with userfaultfd-wp via FAULT_FLAG_UNSHARE
Date:   Fri, 21 Oct 2022 12:11:37 +0200
Message-Id: <20221021101141.84170-6-david@redhat.com>
In-Reply-To: <20221021101141.84170-1-david@redhat.com>
References: <20221021101141.84170-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's stop breaking COW via a fake write fault and let's use
FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
write fault, such as mapping the PTE writable and marking the pte
dirty/softdirty.

Consequently, we will no longer trigger a fake write fault and break COW
without any such side-effects.

Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
will fail with VM_FAULT_SIGBUS and will simply return in break_ksm() with
0 instead of actually breaking COW.

For now, the KSM unmerge tests can trigger that:
    $ sudo ./ksm_functional_tests
    TAP version 13
    1..3
    # [RUN] test_unmerge
    ok 1 Pages were unmerged
    # [RUN] test_unmerge_discarded
    ok 2 Pages were unmerged
    # [RUN] test_unmerge_uffd_wp
    not ok 3 Pages were unmerged
    Bail out! 1 out of 3 tests failed
    # Planned tests != run tests (2 != 3)
    # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0

The warning in dmesg also indicates this wrong handling:
    [  230.096368] FAULT_FLAG_ALLOW_RETRY missing 881
    [  230.100822] CPU: 1 PID: 1643 Comm: ksm-uffd-wp [...]
    [  230.110124] Hardware name: [...]
    [  230.117775] Call Trace:
    [  230.120227]  <TASK>
    [  230.122334]  dump_stack_lvl+0x44/0x5c
    [  230.126010]  handle_userfault.cold+0x14/0x19
    [  230.130281]  ? tlb_finish_mmu+0x65/0x170
    [  230.134207]  ? uffd_wp_range+0x65/0xa0
    [  230.137959]  ? _raw_spin_unlock+0x15/0x30
    [  230.141972]  ? do_wp_page+0x50/0x590
    [  230.145551]  __handle_mm_fault+0x9f5/0xf50
    [  230.149652]  ? mmput+0x1f/0x40
    [  230.152712]  handle_mm_fault+0xb9/0x2a0
    [  230.156550]  break_ksm+0x141/0x180
    [  230.159964]  unmerge_ksm_pages+0x60/0x90
    [  230.163890]  ksm_madvise+0x3c/0xb0
    [  230.167295]  do_madvise.part.0+0x10c/0xeb0
    [  230.171396]  ? do_syscall_64+0x67/0x80
    [  230.175157]  __x64_sys_madvise+0x5a/0x70
    [  230.179082]  do_syscall_64+0x58/0x80
    [  230.182661]  ? do_syscall_64+0x67/0x80
    [  230.186413]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
fault was always questionable. As this fix is not easy to backport and it's
not very critical, let's not cc stable.

Fixes: 529b930b87d9 ("userfaultfd: wp: hook userfault handler to write protection fault")
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b884a22f3c3c..c6f58aa6e731 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -420,17 +420,15 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 }
 
 /*
- * We use break_ksm to break COW on a ksm page: it's a stripped down
+ * We use break_ksm to break COW on a ksm page by triggering unsharing,
+ * such that the ksm page will get replaced by an exclusive anonymous page.
  *
- *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
- *		put_page(page);
- *
- * but taking great care only to touch a ksm page, in a VM_MERGEABLE vma,
+ * We take great care only to touch a ksm page, in a VM_MERGEABLE vma,
  * in case the application has unmapped and remapped mm,addr meanwhile.
  * Could a ksm page appear anywhere else?  Actually yes, in a VM_PFNMAP
  * mmap of /dev/mem, where we would not want to touch it.
  *
- * FAULT_FLAG/FOLL_REMOTE are because we do this outside the context
+ * FAULT_FLAG_REMOTE/FOLL_REMOTE are because we do this outside the context
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
@@ -454,7 +452,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		if (!ksm_page)
 			return 0;
 		ret = handle_mm_fault(vma, addr,
-				      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
 				      NULL);
 	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
-- 
2.37.3

