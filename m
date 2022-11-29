Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0410963C890
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiK2TiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiK2ThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7242F657
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1A7zSSAdH3Q+Nn9HaLXwUXJ3cHWzn45QfpKMkITSm0w=;
        b=b6gVKCGZCvbnoU5aOoZzsIibfF+bR1hZQIon/dYwWZEkyI+xD/keZLKldUD6ds9Nb+7zT6
        s39XNLh8ldeMS5hzTnsCGCtrmvEt+Bpm9X1cziLyx6nl29hk80lcOQpM5LB0XXz4QNwTeG
        mgcqWaT1+GJIr78wiEGaF+W847PoFXA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-sxDb94_hNwmBDLCYUvi_LA-1; Tue, 29 Nov 2022 14:35:35 -0500
X-MC-Unique: sxDb94_hNwmBDLCYUvi_LA-1
Received: by mail-qt1-f200.google.com with SMTP id u31-20020a05622a199f00b003a51fa90654so23116707qtc.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A7zSSAdH3Q+Nn9HaLXwUXJ3cHWzn45QfpKMkITSm0w=;
        b=cmz5NIYTerrTD0Qr0NAw/VIW3XftWYzQA8kND8qUY2TZQPyg76spF+1GW04xM4ZpA/
         f15lAQv2cVrJanJi4xqBLCGbyXWCsuQPmJm2/ZFdgIoBmkVanC0/9bw++3ZRS4y8T9le
         Q6kSaH8bhG8rGAfy08+Gb75pB6hLYueglORu/yw/ZHSiD/iZT5oGP1ejAXHqXGrDhl8+
         sJKbpaPofxwKQJ4Jpbr4t6zdA4Kws4DEm1bmQITEPS6xG3uSKLuRFKmsoEC82Dl6oFey
         wTxoP7X2hk6Hp12pd3akL7YFMuzu+b4xkNjxhoQbEijlqbCylsFjzrGgXaEI1vqq8/Ml
         I4VA==
X-Gm-Message-State: ANoB5pnh8McmTcEBukyfjPiALCPApXk5M7kPpFCWqtZzIz6JYHxxSMlc
        qtpzL4mv2sG1+Ud9BbgWTKk547GtVE/8ZZbp1TMOVORm3Ig2cQIptmzyGJGIeoShL68MfQiQm1d
        sEhk9TtYySRy5ZDFUh90FUOXC
X-Received: by 2002:a05:620a:573:b0:6fc:1ddf:deec with SMTP id p19-20020a05620a057300b006fc1ddfdeecmr31840269qkp.595.1669750535316;
        Tue, 29 Nov 2022 11:35:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5eWRw1Wa7HXYgpo5FSiggQn9vyy3jAcCpLR470cYzs1D4H/YgQTVf/66JS7eR+jzWwjJRHDg==
X-Received: by 2002:a05:620a:573:b0:6fc:1ddf:deec with SMTP id p19-20020a05620a057300b006fc1ddfdeecmr31840242qkp.595.1669750535029;
        Tue, 29 Nov 2022 11:35:35 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Date:   Tue, 29 Nov 2022 14:35:19 -0500
Message-Id: <20221129193526.3588187-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
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

