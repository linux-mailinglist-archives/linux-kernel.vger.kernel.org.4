Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737F5EFD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiI2S3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiI2S3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:29:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D6E95
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:29:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w20so1936559ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=r7x8U2WWuZqtH2rrIIcS2XynHY/yseYye2zrqMM6Et8=;
        b=gDrN6VJe+mCeTqrI0ZJHo1vweqUHeLnG/QtkQ+DoIZUwHtCLrxLaLVwR+HfP0pk41R
         oQkzMBxK6quJZhURlfZMiFJRRilyfqlTU8W3FeDE5jpIgCpMTH1M7HGSP0CTu3vAYn5G
         4d67xxs/L19iljmPtkYgInGVP6V9KxOlxi/70U13iGVrCE7WIXayTIVsHTxti2WBr478
         Eb9hLQuC1tEIztpaLGBKIG89t+D1Hw4bDR+UQHZL8Z4zX7fPHV4wIkMwRUEVkiEkmr9H
         paogj3j45ErOKFiW3J3li+JkffObx3c5wCBMs995tNn43vcRmDI272qWCodVqbP24vec
         gWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=r7x8U2WWuZqtH2rrIIcS2XynHY/yseYye2zrqMM6Et8=;
        b=vKyLsr+P72tww4Y9mfZETGzqhQnKTkR86dtfvZaD8PrdbzUQgiL/FTR15wUNJ56670
         cyNgIDC28w6OEsQ597kAO+bSI/GFRzZMNLVUVv7Pg8UGiHbQv3lsiMQh9j2Z3HVhcW2F
         Mw0hNBQs1RsBPXfUgsMfI8y+09h3j+7TTer73QV/bpl39Lxdy1O/kZTpK7aZ4vcJhITX
         K3uM7ZZkSLXq2ckRIMPxYLwukerj0DXsEFFIHBGdxXC1dox1MOzmpxrcPdSNRzwo+1XT
         BS9BgwPjxjwnGuoaOOF/Ud4lGoFB/mW8j+grB30Bh2AqlGeRr31CA+DyLjrF2kWBOSnk
         Tzrw==
X-Gm-Message-State: ACrzQf1rvf2jcT+6rerEesXyYM3BXbFhYBzoKWkMQS8qXuENvsbeEzVY
        GCdCAfMzqNuW5L7ps11r3M4=
X-Google-Smtp-Source: AMsMyM69Bm1HmjgbgetOCpH4aYTLjOTBB4jR0voRxC+PtRzFPtyZi2oqA4ER07OJGC3jLIcNy6908w==
X-Received: by 2002:a17:902:d48d:b0:178:306d:f75c with SMTP id c13-20020a170902d48d00b00178306df75cmr4635850plg.73.1664476179293;
        Thu, 29 Sep 2022 11:29:39 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b9a-f5f9-665b-0715-9cc1.dynamic-ip6.hinet.net. [2001:b011:20e0:1b9a:f5f9:665b:715:9cc1])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b0016c09a0ef87sm178417plx.255.2022.09.29.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:29:38 -0700 (PDT)
Date:   Fri, 30 Sep 2022 02:29:32 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Message-ID: <YzXkDKr6plbJZgG4@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
 <YzWf7V5qzMjzMAk4@strix-laptop>
 <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:24:31PM +0200, David Hildenbrand wrote:
> > > IMHO, a relaxed form that focuses on only the memory consumption reduction
> > > could *possibly* be accepted upstream if it's not too invasive or complex.
> > > During fork(), we'd do exactly what we used to do to PTEs (increment
> > > mapcount, refcount, trying to clear PageAnonExclusive, map the page R/O,
> > > duplicate swap entries; all while holding the page table lock), however,
> > > sharing the prepared page table with the child process using COW after we
> > > prepared it.
> > > 
> > > Any (most once we want to *optimize* rmap handling) modification attempts
> > > require breaking COW -- copying the page table for the faulting process. But
> > > at that point, the PTEs are already write-protected and properly accounted
> > > (refcount/mapcount/PageAnonExclusive).
> > > 
> > > Doing it that way might not require any questionable GUP hacks and swapping,
> > > MMU notifiers etc. "might just work as expected" because the accounting
> > > remains unchanged" -- we simply de-duplicate the page table itself we'd have
> > > after fork and any modification attempts simply replace the mapped copy.
> > 
> > Agree.
> > However for GUP hacks, if we want to do the COW to page table, we still
> > need the hacks in this patch (using the COW_PTE_OWN_EXCLUSIVE flag to
> > check whether the PTE table is available or not before we do the COW to
> > the table). Otherwise, it will be more complicated since it might need
> > to handle situations like while preparing the COW work, it just figuring
> > out that it needs to duplicate the whole table and roll back (recover
> > the state and copy it to new table). Hopefully, I'm not wrong here.
> 
> The nice thing is that GUP itself *usually* doesn't modify page tables. One
> corner case is follow_pfn_pte(). All other modifications should happen in
> the actual fault handler that has to deal with such kind of unsharing either
> way when modifying the PTE.
> 
> If the pages are already in a COW-ed pagetable in the desired "shared" state
> (e.g., PageAnonExclusive cleared on an anonymous page), R/O pinning of such
> pages will just work as expected and we shouldn't be surprised by another
> set of GUP+COW CVEs.
> 
> We'd really only deduplicate the page table and not play other tricks with
> the actual page table content that differ from the existing way of handling
> fork().
> 
> I don't immediately see why we need COW_PTE_OWN_EXCLUSIVE in GUP code when
> not modifying the page table. I think we only need "we have to unshare this
> page table now" in follow_pfn_pte() and inside the fault handling when GUP
> triggers a fault.
> 
> I hope my assumption is correct, or am I missing something?
> 

My consideration is when we pinned the page and did the COW to make the
page table be shared. It might not allow mapping the pinned page to R/O)
into both processes.

So, if the fork is working on the shared state, it needs to recover the
table and copy to a new one since that pinned page will need to copy
immediately. We can hold the shared state after occurring such a
situation. So we still need some trick to let the fork() know which page
table already has the pinned page (or such page won't let us share)
before going to duplicate.

Am I wrong here?

After that, since we handled the accounting in fork(), we don't need
ownership (pmd_t pointer) anymore. We have to find another way to mark
the table to be exclusive. (Right now, COW_PTE_OWNER_EXCLUSIVE flag is
stored at that space.)

> > 
> > > But devil is in the detail (page table lock, TLB flushing).
> > 
> > Sure, it might be an overhead in the page fault and needs to be handled
> > carefully. ;)
> > 
> > > "will make fork() even have more overhead" is not a good excuse for such
> > > complexity/hacks -- sure, it will make your benchmark results look better in
> > > comparison ;)
> > 
> > ;);)
> > I think that, even if we do the accounting with the COW page table, it
> > still has a little bit improve.
> 
> :)
> 
> My gut feeling is that this is true. While we have to do a pass over the
> parent page table during fork and wrprotect all PTEs etc., we don't have to
> duplicate the page table content and allocate/free memory for that.
> 
> One interesting case is when we cannot share an anon page with the child
> process because it maybe pinned -- and we have to copy it via
> copy_present_page(). In that case, the page table between the parent and the
> child would differ and we'd not be able to share the page table.

That is what I want to say above.
The case might happen in the middle of the shared page table progress.
It might cost more overhead to recover it. Therefore, if GUP wants to
pin the mapped page we can mark the PTE table first, so fork() won't
waste time doing the work for sharing.

> That case could be caught in copy_pte_range(): in case we'd have to allocate
> a page via page_copy_prealloc(), we'd have to fall back to the ordinary
> "separate page table for the child" way of doing things.
> 
> But that looks doable to me.

Sounds good. :)

> -- 
> Thanks,
> 
> David / dhildenb
> 

Thanks,
Chih-En Lin
