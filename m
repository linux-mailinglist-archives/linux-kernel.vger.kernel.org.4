Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAF5EFD7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiI2S5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiI2S5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:57:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B068145CB8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:57:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i6so2248226pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MPKXDe/4Z1BXklCL+wTKgd8YdLgG1d0/bq9BWTsLDnI=;
        b=kh6RN9IZGAGzL52O8pWBf25xA+9pL1xEdR03q9YULZIhO/rEtg8tL5d6dksYy7Q1SL
         T+xyCgZPah/rNxBuGlOS8wqlsz2uJk5Bks3lhbLnnnZgTvG3Y5ogWmwreX7y+OWBNcTM
         GMy4hPHoLjOXRldnCyrEXSmajHIDDsxd8pj/i4bG7YZt+pxqeEr6Tweg6wuIMmmPGjic
         ES6gtYME4Wq1EAl5dbvJWMjtIlE3j8NgagtkrPBdpp39JrE5Jolc/UeT5N1kJBQBLHMU
         6e+P7kPCNWxgzC33J6a39E1E0Hj8EbnZCp4p9PbMOW6+yiMK29H1fUs5F/vdxj9BkSNI
         dBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MPKXDe/4Z1BXklCL+wTKgd8YdLgG1d0/bq9BWTsLDnI=;
        b=YjUVILefgnTWPN1BkAtbWQCuszO2th7vN5lgft5Ywen5D6JBJfMbUGA9+9GtdA6IRK
         eV/iDGzpUP/9Oa5Qlv2MkBRs7dOkSuZ5isjSHSIUnUgPgYSjLzPZfjv0wKpq/X40n5lb
         1OREhSgOx7YmK0pqDmy3w/NoNl+Sbw+MytHZCDI2Jxv1DUzQQDYpOMVTaelPHsNk4/Fp
         WCuEDtTjBBBZLC2PT04ey6gSkm211bF6e5kT4gz70JgDlxD4PUZec11m6qGC4cgnzTMc
         4JQTI5HDncoLl80Ih3pYPwnlwJcRqhDyzJQFeLj5BbkTtL/ZxfbvRSkrFHYfl5glPZhv
         TzLQ==
X-Gm-Message-State: ACrzQf1VZ2qGjF2yOGTjWOnmc1kE59LV3ShhI5JINBpctGcTlFHzkMjm
        smrViHp9fR+GqU+MH2PC4dk=
X-Google-Smtp-Source: AMsMyM7KahqHAdmUB7UdN83AxqwnKIAauwCWsOlH7de+r6DvfN5kPmhprCdhtVBTIWO2ORp+pLASJg==
X-Received: by 2002:a63:2bcc:0:b0:439:36bb:c036 with SMTP id r195-20020a632bcc000000b0043936bbc036mr4060428pgr.447.1664477867656;
        Thu, 29 Sep 2022 11:57:47 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b9a-f5f9-665b-0715-9cc1.dynamic-ip6.hinet.net. [2001:b011:20e0:1b9a:f5f9:665b:715:9cc1])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b00178b06fea7asm225050pln.148.2022.09.29.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:57:47 -0700 (PDT)
Date:   Fri, 30 Sep 2022 02:57:40 +0800
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
Message-ID: <YzXqpN5bnG9HSGyI@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
 <YzWf7V5qzMjzMAk4@strix-laptop>
 <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
 <YzXkDKr6plbJZgG4@strix-laptop>
 <834c258d-4c0e-1753-3608-8a7e28c14d07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834c258d-4c0e-1753-3608-8a7e28c14d07@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 08:38:52PM +0200, David Hildenbrand wrote:
> On 29.09.22 20:29, Chih-En Lin wrote:
> > On Thu, Sep 29, 2022 at 07:24:31PM +0200, David Hildenbrand wrote:
> > > > > IMHO, a relaxed form that focuses on only the memory consumption reduction
> > > > > could *possibly* be accepted upstream if it's not too invasive or complex.
> > > > > During fork(), we'd do exactly what we used to do to PTEs (increment
> > > > > mapcount, refcount, trying to clear PageAnonExclusive, map the page R/O,
> > > > > duplicate swap entries; all while holding the page table lock), however,
> > > > > sharing the prepared page table with the child process using COW after we
> > > > > prepared it.
> > > > > 
> > > > > Any (most once we want to *optimize* rmap handling) modification attempts
> > > > > require breaking COW -- copying the page table for the faulting process. But
> > > > > at that point, the PTEs are already write-protected and properly accounted
> > > > > (refcount/mapcount/PageAnonExclusive).
> > > > > 
> > > > > Doing it that way might not require any questionable GUP hacks and swapping,
> > > > > MMU notifiers etc. "might just work as expected" because the accounting
> > > > > remains unchanged" -- we simply de-duplicate the page table itself we'd have
> > > > > after fork and any modification attempts simply replace the mapped copy.
> > > > 
> > > > Agree.
> > > > However for GUP hacks, if we want to do the COW to page table, we still
> > > > need the hacks in this patch (using the COW_PTE_OWN_EXCLUSIVE flag to
> > > > check whether the PTE table is available or not before we do the COW to
> > > > the table). Otherwise, it will be more complicated since it might need
> > > > to handle situations like while preparing the COW work, it just figuring
> > > > out that it needs to duplicate the whole table and roll back (recover
> > > > the state and copy it to new table). Hopefully, I'm not wrong here.
> > > 
> > > The nice thing is that GUP itself *usually* doesn't modify page tables. One
> > > corner case is follow_pfn_pte(). All other modifications should happen in
> > > the actual fault handler that has to deal with such kind of unsharing either
> > > way when modifying the PTE.
> > > 
> > > If the pages are already in a COW-ed pagetable in the desired "shared" state
> > > (e.g., PageAnonExclusive cleared on an anonymous page), R/O pinning of such
> > > pages will just work as expected and we shouldn't be surprised by another
> > > set of GUP+COW CVEs.
> > > 
> > > We'd really only deduplicate the page table and not play other tricks with
> > > the actual page table content that differ from the existing way of handling
> > > fork().
> > > 
> > > I don't immediately see why we need COW_PTE_OWN_EXCLUSIVE in GUP code when
> > > not modifying the page table. I think we only need "we have to unshare this
> > > page table now" in follow_pfn_pte() and inside the fault handling when GUP
> > > triggers a fault.
> > > 
> > > I hope my assumption is correct, or am I missing something?
> > > 
> > 
> > My consideration is when we pinned the page and did the COW to make the
> > page table be shared. It might not allow mapping the pinned page to R/O)
> > into both processes.
> > 
> > So, if the fork is working on the shared state, it needs to recover the
> > table and copy to a new one since that pinned page will need to copy
> > immediately. We can hold the shared state after occurring such a
> > situation. So we still need some trick to let the fork() know which page
> > table already has the pinned page (or such page won't let us share)
> > before going to duplicate.
> > 
> > Am I wrong here?
> 
> I think you might be overthinking this. Let's keep it simple:
> 
> 1) Handle pinned anon pages just as I described below, falling back to the
> "slow" path of page table copying.
> 
> 2) Once we passed that stage, you can be sure that the COW-ed page table
> cannot have actually pinned anon pages. All anon pages in such a page table
> have PageAnonExclusive cleared and are "maybe shared". GUP cannot succeed in
> pinning these pages anymore, because it will only pin exclusive anon pages!
> 
> 3) If anybody wants to take a R/O pin on a shared anon page that is mapped
> into a COW-ed page table, we trigger a fault with FAULT_FLAG_UNSHARE instead
> of pinning the page. This has to break COW on the page table and properly
> map an exclusive anon page into it, breaking COW.
> 
> Do you see a problem with that?
> 
> > 
> > After that, since we handled the accounting in fork(), we don't need
> > ownership (pmd_t pointer) anymore. We have to find another way to mark
> > the table to be exclusive. (Right now, COW_PTE_OWNER_EXCLUSIVE flag is
> > stored at that space.)
> > 
> > > > 
> > > > > But devil is in the detail (page table lock, TLB flushing).
> > > > 
> > > > Sure, it might be an overhead in the page fault and needs to be handled
> > > > carefully. ;)
> > > > 
> > > > > "will make fork() even have more overhead" is not a good excuse for such
> > > > > complexity/hacks -- sure, it will make your benchmark results look better in
> > > > > comparison ;)
> > > > 
> > > > ;);)
> > > > I think that, even if we do the accounting with the COW page table, it
> > > > still has a little bit improve.
> > > 
> > > :)
> > > 
> > > My gut feeling is that this is true. While we have to do a pass over the
> > > parent page table during fork and wrprotect all PTEs etc., we don't have to
> > > duplicate the page table content and allocate/free memory for that.
> > > 
> > > One interesting case is when we cannot share an anon page with the child
> > > process because it maybe pinned -- and we have to copy it via
> > > copy_present_page(). In that case, the page table between the parent and the
> > > child would differ and we'd not be able to share the page table.
> > 
> > That is what I want to say above.
> > The case might happen in the middle of the shared page table progress.
> > It might cost more overhead to recover it. Therefore, if GUP wants to
> > pin the mapped page we can mark the PTE table first, so fork() won't
> > waste time doing the work for sharing.
> 
> Having pinned pages is a corner case for most apps. No need to worry about
> optimizing this corner case for now.
> 
> I see what you are trying to optimize, but I don't think this is needed in a
> first version, and probably never is needed.
> 
> 
> Any attempts to mark page tables in a certain way from GUP
> (COW_PTE_OWNER_EXCLUSIVE) is problematic either way: GUP-fast
> (get_user_pages_fast) can race with pretty much anything, even with
> concurrent fork. I suspect your current code might be really racy in that
> regard.

I see.
Now, I know why optimizing that corner case is not worth it.
Thank you for explaining that.

Thanks,
Chih-En Lin
