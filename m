Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4E646265
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLGUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B847B57E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1A7zSSAdH3Q+Nn9HaLXwUXJ3cHWzn45QfpKMkITSm0w=;
        b=RV5CXOV5Y6Cmi7B12y3Fnp7XG77jLFoFJdIr+DmwNNmN3hSYLjMVVgcha/oxTuBRje4UAu
        w/BqPgqMmmLSFgpFC/fdDaUnEj12F6RdSQviErZE+SwlKsBtF49TF67SZxEfnFxXqGpfkH
        k7yXVWgnuf25AFehVad+qNkxDLLpqTI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-S-ffjT42P9GltHSv8Dc6XA-1; Wed, 07 Dec 2022 15:30:43 -0500
X-MC-Unique: S-ffjT42P9GltHSv8Dc6XA-1
Received: by mail-qt1-f199.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so37923797qtb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A7zSSAdH3Q+Nn9HaLXwUXJ3cHWzn45QfpKMkITSm0w=;
        b=iQ/Bvts5f6Cpu7N2a6ZHfsPhGZXqclJ5c5UexnaTuw1WSJ2oovR4MzCBDmocTvfDU9
         xxww+hlCHp7tYH7oYoTnLXNGEubnE9VBF91XzVDU5dARDgaMGF5IFWoWUvPUSdoC6ju8
         mtz9+DqDzTikSC8Xjef2Ngmq+17iNeO5pwAYduTYEh0NNVBtxhncuIVDehCxTBw16Xxg
         XG0h55Pj/9awJRNKEnpBTGB9GzGUpbIIaoD1p0loP7cJntAZbSy3XqMjqZXfYK2ImDZF
         g/2lXlfFaop3ZQoQY4fvibQ/K/B+7GOvwkU6X5NSJZEcj2HjGfHJWII6PD+L2gPLTtg4
         tDhg==
X-Gm-Message-State: ANoB5pnyjZMJYa1vGwCzk1RxOFJ+0eVY3R+mOqYlBKMYSiPbz2rzD19w
        GbhSTZhuo2Przg/vGNiAoQPdQOJS0QtUSlVHMvtObzbaSpUmptK8EWBI1E0GiQBpP4pRmpEuaih
        OIEOtOCAkrdEpb5XOiho4L32g
X-Received: by 2002:a0c:e109:0:b0:4c6:ecbf:e47e with SMTP id w9-20020a0ce109000000b004c6ecbfe47emr1918691qvk.44.1670445042945;
        Wed, 07 Dec 2022 12:30:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7c6SH17+R0AvUqKo+tJdpohz+daUf26kZ0d9KHAqt+n6XDiZgwzv4YTz/R34Mrel5se5ut4w==
X-Received: by 2002:a0c:e109:0:b0:4c6:ecbf:e47e with SMTP id w9-20020a0ce109000000b004c6ecbfe47emr1918677qvk.44.1670445042671;
        Wed, 07 Dec 2022 12:30:42 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:42 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 03/10] mm/hugetlb: Document huge_pte_offset usage
Date:   Wed,  7 Dec 2022 15:30:27 -0500
Message-Id: <20221207203034.650899-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Normally, it's always safe to walk a generic pgtable as long as we're with
the mmap lock held for either read or write, because that guarantees the
pgtable pages will always be valid during the process.

But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
pgtable freed by pmd unsharing, it means that even with mmap lock held for
current mm, the PMD pgtable page can still go away from under us if pmd
unsharing is possible during the walk.

So we have two ways to make it safe even for a shared mapping:

  (1) If we're with the hugetlb vma lock held for either read/write, it's
      okay because pmd unshare cannot happen at all.

  (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
      okay because even if pmd unshare can happen, the pgtable page cannot
      be freed from under us.

Document it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 551834cd5299..81efd9b9baa2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
+/*
+ * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
+ * Returns the pte_t* if found, or NULL if the address is not mapped.
+ *
+ * Since this function will walk all the pgtable pages (including not only
+ * high-level pgtable page, but also PUD entry that can be unshared
+ * concurrently for VM_SHARED), the caller of this function should be
+ * responsible of its thread safety.  One can follow this rule:
+ *
+ *  (1) For private mappings: pmd unsharing is not possible, so it'll
+ *      always be safe if we're with the mmap sem for either read or write.
+ *      This is normally always the case, IOW we don't need to do anything
+ *      special.
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
+ *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
+ *           sure even if unshare happened the racy unmap() will wait until
+ *           i_mmap_rwsem is released.
+ *
+ * Option (2.1) is the safest, which guarantees pte stability from pmd
+ * sharing pov, until the vma lock released.  Option (2.2) doesn't protect
+ * a concurrent pmd unshare, but it makes sure the pgtable page is safe to
+ * access.
+ */
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
-- 
2.37.3

