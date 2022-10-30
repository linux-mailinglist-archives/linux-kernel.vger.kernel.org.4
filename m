Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952AB612D00
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJ3Vax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJ3Vam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2197A1A0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYAYVHGHmOdGIx+b1vNePbFs/fCGWl7iYc8XlHT8evo=;
        b=BES+zssWCvgN0DS018q5U/epVTPOt0UHr6iqWCZYluxZboIJ6S0n+GneXSWGNF4KqlWxX0
        KQ3b6g8MCyr1WlTogppUggJ2Ay7Xo2+vmoaIq60rDDeGp8D0Pq+YQgB5WQS6U9ybAZydHY
        WK91CCrkqR9uMn9cLWmaGpPuSSN7BBg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-sX22bnYeMpeOLp0Pgxeeig-1; Sun, 30 Oct 2022 17:29:37 -0400
X-MC-Unique: sX22bnYeMpeOLp0Pgxeeig-1
Received: by mail-qt1-f200.google.com with SMTP id ew11-20020a05622a514b00b003a524196d31so728276qtb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYAYVHGHmOdGIx+b1vNePbFs/fCGWl7iYc8XlHT8evo=;
        b=3Hca9S2oLzquINCKV/71p5jdTuFNOeUxXDXmq3FGZcZnyTl55PETtYmeW75HqokSQK
         lwLBaT+VDmopeRM9lki48TvAYT2z2rSCg2SsLOdJGWaLP54IYQk3kGsgIXKHGWFzQ0OD
         hq9GUY6tbb52XdhJA0Z/67N29GfSrlzyitApbXLor7vA8eygfLtfqqRT+kjbh5z287qD
         AkqBtPceV35EczysvIIKyRbOU2JxFbsy/BRBUIs7UqDoSrHk+D2RpX2H6TECo0o/q06r
         A0SMGoZTlgOm+SBOvGHOSbOP5ATAg3X70u+n4ha6cq6GKbmS28JvZd3bBamnJUfZsAEB
         Zjmw==
X-Gm-Message-State: ACrzQf0aQYHXjtTfklXOBOgv7SvBh7KhAgj8lJZADaX2zKPkBoBWPJ2a
        hqCnD8I28kfiuo5FttaoqLof7oPhMTXNrGrkeWteqRnf+qxshE3S8TpsQOTKLVzXQagBoBpQTU8
        s3WcQB4gvrNZoEk0e+4eKqBnqDNdyO5rTEAbZPn6AgQfXLXuJAvpYgZNk4oSpQdlBp0L+ARt6Dg
        ==
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr7121587qkp.609.1667165376171;
        Sun, 30 Oct 2022 14:29:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4KUeAeL4uqFBmuI9YDUOE8dGtH/Wl4ZTYcW7dVrCJqlvE5bFVFwU9LFOVe/w5t4Vrzl2V26A==
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr7121563qkp.609.1667165375878;
        Sun, 30 Oct 2022 14:29:35 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH RFC 02/10] mm/hugetlb: Comment huge_pte_offset() for its locking requirements
Date:   Sun, 30 Oct 2022 17:29:21 -0400
Message-Id: <20221030212929.335473-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
hugetlb address.

Normally, it's always safe to walk the pgtable as long as we're with the
mmap lock held for either read or write, because that guarantees the
pgtable pages will always be valid during the process.

But it's not true for hugetlbfs: hugetlbfs has the pmd sharing feature, it
means that even with mmap lock held, the PUD pgtable page can still go away
from under us if pmd unsharing is possible during the walk.

It's not always the case, e.g.:

  (1) If the mapping is private we're not prone to pmd sharing or
      unsharing, so it's okay.

  (2) If we're with the hugetlb vma lock held for either read/write, it's
      okay too because pmd unshare cannot happen at all.

Document all these explicitly for huge_pte_offset(), because it's really
not that obvious.  This also tells all the callers on what it needs to
guarantee huge_pte_offset() thread-safety.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 35e9a468d13e..0bf930c75d4b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -329,6 +329,38 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ptep;
 }
 
+/*
+ * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
+ * Returns the pte_t* if found, or NULL if the address is not mapped.
+ *
+ * NOTE: since this function will walk all the pgtable pages (including not
+ * only high-level pgtable page, but also PUD that can be unshared
+ * concurrently for VM_SHARED), the caller of this function should be
+ * responsible of its thread safety.  One can follow this rule:
+ *
+ *  (1) For private mappings: pmd unsharing is not possible, so it'll
+ *      always be safe if we're with the mmap sem for either read or write.
+ *      This is normally always the case, so IOW we don't need to do
+ *      anything special.
+ *
+ *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
+ *      pgtable page can go away from under us!  It can be done by a pmd
+ *      unshare with a follow up munmap() on the other process), then we
+ *      need either:
+ *
+ *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
+ *           won't happen upon the range (it also makes sure the pte_t we
+ *           read is the right and stable one), or,
+ *
+ *     (2.2) RCU read lock, to make sure even pmd unsharing happened, the
+ *           old shared PUD page won't get freed from under us, so even of
+ *           the pteval can be obsolete, at least it's still always safe to
+ *           access the pgtable page (e.g., de-referencing pte_t* would not
+ *           cause use-after-free).
+ *
+ * PS: from the regard of (2.2), it's the same logic of fast-gup being safe
+ * for generic mm, as long as RCU is used to free any pgtable page.
+ */
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
-- 
2.37.3

