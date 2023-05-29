Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50366714B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjE2N7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjE2N7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:59:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA3BEA;
        Mon, 29 May 2023 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=daJr36z+xkb/H/fiOexwZNK30Bl/V66a5KNArnHZvM8=; b=fuY62XaNQ1pid4PNx3bW9OvYFH
        W2MZp/QZXjFmThuV9a1DJcWOd+JYQNxPMJygXk9c0KUuaPqy0M9u/r+Vs27UTvHbWDtYVnA+RTTp6
        jB78eAY5YpAKoIS/61GR1/oSnkSEWJbGBUTSyEmZ9+18f/mzDRAupMRvltvNWDYeS4BcrG9tm2BJf
        9eiEdU9vtilsjcpBoR5QNebyugV+d/7DnGaOatu9kYBzf4L0AOTycICgaBuWc/MrIP0hG9cSOgII0
        Ru6GHGxtFSG/YbqlMBCcSBH4IipXcVzJCce6Tp4PdiiqApnnSuEbaBiJJr4ds9zEpfuv9ZaAXKVgR
        jTQB7oWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3dMZ-005SA0-VJ; Mon, 29 May 2023 13:56:44 +0000
Date:   Mon, 29 May 2023 14:56:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/12] mm/pgtable: add PAE safety to __pte_offset_map()
Message-ID: <ZHSvG8UIaq14I/5p@casper.infradead.org>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <923480d5-35ab-7cac-79d0-343d16e29318@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923480d5-35ab-7cac-79d0-343d16e29318@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 11:16:16PM -0700, Hugh Dickins wrote:
> +#if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
> +	(defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RCU))
> +/*
> + * See the comment above ptep_get_lockless() in include/linux/pgtable.h:
> + * the barriers in pmdp_get_lockless() cannot guarantee that the value in
> + * pmd_high actually belongs with the value in pmd_low; but holding interrupts
> + * off blocks the TLB flush between present updates, which guarantees that a
> + * successful __pte_offset_map() points to a page from matched halves.
> + */
> +#define config_might_irq_save(flags)	local_irq_save(flags)
> +#define config_might_irq_restore(flags)	local_irq_restore(flags)
> +#else
> +#define config_might_irq_save(flags)
> +#define config_might_irq_restore(flags)

I don't like the name.  It should indicate that it's PMD-related, so
pmd_read_start(flags) / pmd_read_end(flags)?

