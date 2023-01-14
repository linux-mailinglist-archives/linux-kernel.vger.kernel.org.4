Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E0466AC73
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjANQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjANQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1333903A
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673712585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3R4pvBr6dG+A0u3o+nBNguX6qX9S+oXSEacD+sP77s=;
        b=WEHe9K+xAy6oigFcSDK+FWRPiXdaPr+oBmYe6CQlwXTNxpU+i2IXzcvWpQF+umNYd7No1b
        iLs7TRio9nK5/U1C+mHafht+qs8s20Zr51bBiOZhYOUe4we1HXEYkijnVdliwSz3KK5RCT
        pw+KMvz7kO35YQsgZ02vLWHd/lDvkLM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-H6gnecHxN0-drMrP12fT1g-1; Sat, 14 Jan 2023 11:09:39 -0500
X-MC-Unique: H6gnecHxN0-drMrP12fT1g-1
Received: by mail-wm1-f71.google.com with SMTP id ay38-20020a05600c1e2600b003da7c41fafcso722928wmb.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3R4pvBr6dG+A0u3o+nBNguX6qX9S+oXSEacD+sP77s=;
        b=TqC/LuG73xotWRRmIRBlBTBMI/vM+7ji/3HwychYMUaKqvIZVA4keNt3L3vdfASzH4
         2znew2hy4SVp50k7oaqGejAYCVQteBFKcRNW5gi8i5jyylkskSvb3wNWPtcCKZ2bD6ES
         iZsEr3RSCf4V/WWXUNFvd2g/Uv+WMpdbhMdF72T3neTF+9uqEUk+UG98uyMzqkzjxv5S
         LuwyZqdJBqFG+zKMal4wgyGHffl8O2+9ii50cz5CPBdZ16HIIxJoy0hLBht6C7kcNejI
         RaArl1qLF8zqZm8F4RPRpYjyS6FKoz93DU7QM7GQOtcW5W3Xj8hxYIm1EzlbBwNXN2Tz
         INgA==
X-Gm-Message-State: AFqh2krPqPOnU+d5ic38XMMuw931IAROPJRbTlXWY6YSj4M/A+9l1xUI
        2F13ulsT6c/VoKspyUURPLpJTSxMqTcXecYYZqE514HgkrrwVt6JxHZGZiqLfBFuGSnW57U+iFm
        g/bjUm6JDBUpMA6BORfexD7wB6SNP3nYBbngRUSHjNJuKqzklOoX65mDsdlONdmS/svl3mitn
X-Received: by 2002:a05:600c:348b:b0:3d1:f16b:30e6 with SMTP id a11-20020a05600c348b00b003d1f16b30e6mr62422477wmq.28.1673712578396;
        Sat, 14 Jan 2023 08:09:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtvXECQ77f+OwG9Mdcw6TdAWlLhcG76s2TeMh5Hr9A1VofwYXs3lPZWG9daADyc7xNo4jh7zQ==
X-Received: by 2002:a05:600c:348b:b0:3d1:f16b:30e6 with SMTP id a11-20020a05600c348b00b003d1f16b30e6mr62422426wmq.28.1673712578037;
        Sat, 14 Jan 2023 08:09:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:9800:fa4a:c1fc:a860:85af? (p200300cbc71c9800fa4ac1fca86085af.dip0.t-ipconnect.de. [2003:cb:c71c:9800:fa4a:c1fc:a860:85af])
        by smtp.gmail.com with ESMTPSA id q18-20020adfdfd2000000b002bdc129c8f6sm10260315wrn.43.2023.01.14.08.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 08:09:37 -0800 (PST)
Message-ID: <6aaad548-cf48-77fa-9d6c-db83d724b2eb@redhat.com>
Date:   Sat, 14 Jan 2023 17:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-2-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 01/26] mm/debug_vm_pgtable: more
 pte_swp_exclusive() sanity checks
In-Reply-To: <20230113171026.582290-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.23 18:10, David Hildenbrand wrote:
> We want to implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures.
> Let's extend our sanity checks, especially testing that our PTE bit
> does not affect:
> * is_swap_pte() -> pte_present() and pte_none()
> * the swap entry + type
> * pte_swp_soft_dirty()
> 
> Especially, the pfn_pte() is dodgy when the swap PTE layout differs
> heavily from ordinary PTEs. Let's properly construct a swap PTE from
> swap type+offset.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The following fixup for !CONFIG_SWAP on top, which makes it compile for me and
passes when booting on x86_64 with CONFIG_DEBUG_VM_PGTABLE:

...
[    0.347112] Loaded X.509 cert 'Build time autogenerated kernel key: ee6afc0578f6475656fec8a4f9d02832'
[    0.350112] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    0.351217] page_owner is disabled
...


 From 6a6162e8af62a4b3f7b9d823fdfae86de3f34a9d Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sat, 14 Jan 2023 16:47:12 +0100
Subject: [PATCH] fixup: mm/debug_vm_pgtable: more pte_swp_exclusive() sanity
  checks

generic_max_swapfile_size() is only available with CONFIG_SWAP -- which
makes sense, because without SWAP there are no swap files. Let's
simply probe manually which bits we can obtain after storing them in a
PTE, and properly call it "max swap offset", which is more generic for
a swap entry.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/debug_vm_pgtable.c | 8 +++++---
  1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 3da0cc380c35..af59cc7bd307 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -810,15 +810,17 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
  
  static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
  {
-	unsigned long max_swapfile_size = generic_max_swapfile_size();
+	unsigned long max_swap_offset;
  	swp_entry_t entry, entry2;
  	pte_t pte;
  
  	pr_debug("Validating PTE swap exclusive\n");
  
+	/* See generic_max_swapfile_size(): probe the maximum offset */
+	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
+
  	/* Create a swp entry with all possible bits set */
-	entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1,
-			  max_swapfile_size - 1);
+	entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
  
  	pte = swp_entry_to_pte(entry);
  	WARN_ON(pte_swp_exclusive(pte));
-- 
2.39.0



-- 
Thanks,

David / dhildenb

