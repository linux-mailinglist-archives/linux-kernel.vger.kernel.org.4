Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154674A46F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGFTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:33:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9641BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0wxmw1h/+sc7ZkGjLi6C59U1J1wukIjy+nrYU+ZKh7s=; b=kdCQhoZRlP+51y/fm7OjLLXVUU
        MgnblWPjJeWegHqTxc2bW0g5qPTx6NwuwQCIsIJvqXFS5nAz/OseFxEljm4ZSBVx8ZlGklmk3j+yG
        paqL/h+GOK0chawhP5ibXNRWszLaLGTJyhS9KS4VaS0kGn47IFSlMOdqcxAbPvjLFkao/7Loxweav
        zMDn7iZYkB5P64QhmKHix+FMnDemyQSDfb0d1ZqkosI0J7H/lbDLI1aJtQ7gsetgEhHDK/r3Cdsu2
        RKI9G5Uq2Ymp6A4iOE5hCZOGQCfwbDECKx7oEJ4/xr55VGX0rlMmt/CEdFA3HhBJvEKIA8HxXwpja
        SxnltGVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHUj7-00BLN7-QK; Thu, 06 Jul 2023 19:33:17 +0000
Date:   Thu, 6 Jul 2023 20:33:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
Message-ID: <ZKcW/Zij1HZB0tmf@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
 <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
 <eea2b36d-9c6d-64ca-4e21-57cfd5a93d57@arm.com>
 <CAOUHufZypv+kLFu3r8iPYbceBh0KSE=gus-_iC1Q35_QVQdnMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZypv+kLFu3r8iPYbceBh0KSE=gus-_iC1Q35_QVQdnMQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:07:19PM -0600, Yu Zhao wrote:
> >  - On arm64 when the process has marked the VMA for THP (or when
> > transparent_hugepage=always) but the VMA does not meet the requirements for a
> > PMD-sized mapping (or we failed to allocate, ...) then I'd like to map using
> > contpte. For 4K base pages this is 64K (order-4), for 16K this is 2M (order-7)
> > and for 64K this is 2M (order-5). The 64K base page case is very important since
> > the PMD size for that base page is 512MB which is almost impossible to allocate
> > in practice.
> 
> Which case (server or client) are you focusing on here? For our client
> devices, I can confidently say that 64KB has to be after 16KB, if it
> happens at all. For servers in general, I don't know of any major
> memory-intensive workloads that are not THP-aware, i.e., I don't think
> "VMA does not meet the requirements" is a concern.

It sounds like you've done some measurements, and I'd like to understand
those a bit better.  There are a number of factors involved:

 - A larger page size shrinks the length of the LRU list, so systems
   which see heavy LRU lock contention benefit more
 - A larger page size has more internal fragmentation, so we run out of
   memory and have to do reclaim more often (and maybe workload which
   used to fit in DRAM now do not)
(probably others; i'm not at 100% right now)

I think concerns about "allocating lots of order-2 folios makes it harder
to allocate order-4 folios" are _probably_ not warranted (without data
to prove otherwise).  All anonymous memory is movable, so our compaction
code should be able to create larger order folios.

