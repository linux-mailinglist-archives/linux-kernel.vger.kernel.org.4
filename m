Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3626E6C82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDRTBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:01:22 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9F8E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6AA0D3200986;
        Tue, 18 Apr 2023 15:01:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 Apr 2023 15:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681844478; x=
        1681930878; bh=tqi3oI5Ezx9YV9f6lUuUN7M2X1hzJenS7E4oz2JLxDw=; b=t
        pxOB7NwvzZBBJLOSrfdH6NkomNJoFhTTx/7fTzb/PkB8dBn+KhKYJkGtrV4rmHsj
        eFv6HGQKVILhftA2cd59VIIH1Da9Ni9vI27L2QIF0OBP8VBiZOiMaZk9RGQDyK4j
        +2SC89wcM3WJ8VCjt/E3kdaXuwYXt21PzYlCJyMxo2KFS944vSP4PMHTiJamHpRu
        omtuAwRHagvQrQx+k9fyOJc7KzeIQIO4gdmXdEQCGHH52vUsu5XcLUq8SMOzOjPL
        yP+iXubPDxWRAl0IJiD02AfdkTEnP5w0giii6Kpk1FArpVRLxHHGEj29I00N9Zzb
        VGup/Xs49aqXlt+tFzOMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681844478; x=1681930878; bh=tqi3oI5Ezx9YV
        9f6lUuUN7M2X1hzJenS7E4oz2JLxDw=; b=UOIUErmmSb5rY+eMuP0Y9+xznTbO3
        ClVXiyT5naWzamZ8XASR0t6VUl++KLDf34IcXyHYtbNacKKTecVbPhaQKmil5qki
        tCgeR5WLquYbXH3W9B8QadI9w/PmN+mypAn4OeNverEkwCEAsd+M3IKrzfmNqxH3
        LgN04x8jZPPXfJOtuHpJPaO37H8kUOrIuKegkSR3HDeQda96ASvYHl6daPDmG6CQ
        o55MJFFJJDVK4UjuDoUUc1HcBl15y0dSPwG5NcHIEekerU3rEuC4eW9ygjd1LZ4p
        U60ea5JRxFgjFG1PzlwlgCLnP5oLapS7tzgCljB8qbBDxWmdsPzQgYCcg==
X-ME-Sender: <xms:_eg-ZO56INva20OHKmmIeghjDNy-SF-zdZ-wOXsp7-4sbCBZgdhoYg>
    <xme:_eg-ZH5HpHpbwJGZeAyrvXQphPIt2W18oE_lr5iPDq0seFk-i8MNVgZxGHep1SiAd
    7x-t6gvf9NdC6UEx2c>
X-ME-Received: <xmr:_eg-ZNf8tfMh3S4J1B2ZfLfk8EQP2M180mQL0q8_VoOPcAwZgDmCrmC3qMnob29DyHAgRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelkedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepkefghfefffeggefgfefhfeetieevgfeltdeu
    teeggefhvefhjeeifedttdetvdeunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:_eg-ZLI9vRLd3BsVj99McMTlAJUYP5Cxuo6_-etAenKGhbTi-Wd_HQ>
    <xmx:_eg-ZCL1XHgIuz6Xx4w71FZCQT5KifypqdUox9xQqmIdmTEezOdtuQ>
    <xmx:_eg-ZMyHD7w99VDnAL0an3jP9TcBI-Qqa8FtMFgoSuDyirT7BfLcXA>
    <xmx:_ug-ZHGETrLxmOkePw2UiG7l6O23tO-5qImSudVLCWjITK1qempFvQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Apr 2023 15:01:17 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 63BE110C351; Tue, 18 Apr 2023 22:01:12 +0300 (+03)
Date:   Tue, 18 Apr 2023 22:01:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH mm-unstable v1] mm: don't check VMA write permissions if
 the PTE/PMD indicates write permissions
Message-ID: <20230418190112.2eyuhzq3hqwvlmyt@box.shutemov.name>
References: <20230418142113.439494-1-david@redhat.com>
 <ZD69l0zD3UL9HD8g@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD69l0zD3UL9HD8g@x1n>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:56:07AM -0400, Peter Xu wrote:
> On Tue, Apr 18, 2023 at 04:21:13PM +0200, David Hildenbrand wrote:
> > Staring at the comment "Recheck VMA as permissions can change since
> > migration started" in remove_migration_pte() can result in confusion,
> > because if the source PTE/PMD indicates write permissions, then there
> > should be no need to check VMA write permissions when restoring migration
> > entries or PTE-mapping a PMD.
> > 
> > Commit d3cb8bf6081b ("mm: migrate: Close race between migration completion
> > and mprotect") introduced the maybe_mkwrite() handling in
> > remove_migration_pte() in 2014, stating that a race between mprotect() and
> > migration finishing would be possible, and that we could end up with
> > a writable PTE that should be readable.
> > 
> > However, mprotect() code first updates vma->vm_flags / vma->vm_page_prot
> > and then walks the page tables to (a) set all present writable PTEs to
> > read-only and (b) convert all writable migration entries to readable
> > migration entries. While walking the page tables and modifying the
> > entries, migration code has to grab the PT locks to synchronize against
> > concurrent page table modifications.
> 
> Makes sense to me.
> 
> > 
> > Assuming migration would find a writable migration entry (while holding
> > the PT lock) and replace it with a writable present PTE, surely mprotect()
> > code didn't stumble over the writable migration entry yet (converting it
> > into a readable migration entry) and would instead wait for the PT lock to
> > convert the now present writable PTE into a read-only PTE. As mprotect()
> > didn't finish yet, the behavior is just like migration didn't happen: a
> > writable PTE will be converted to a read-only PTE.
> > 
> > So it's fine to rely on the writability information in the source
> > PTE/PMD and not recheck against the VMA as long as we're holding the PT
> > lock to synchronize with anyone who concurrently wants to downgrade write
> > permissions (like mprotect()) by first adjusting vma->vm_flags /
> > vma->vm_page_prot to then walk over the page tables to adjust the page
> > table entries.
> > 
> > Running test cases that should reveal such races -- mprotect(PROT_READ)
> > racing with page migration or THP splitting -- for multiple hours did
> > not reveal an issue with this cleanup.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> > 
> > This is a follow-up cleanup to [1]:
> > 	[PATCH v1 RESEND 0/6] mm: (pte|pmd)_mkdirty() should not
> > 	unconditionally allow for write access
> > 
> > I wanted to be a bit careful and write some test cases to convince myself
> > that I am not missing something important. Of course, there is still the
> > possibility that my test cases are buggy ;)
> > 
> > Test cases I'm running:
> > 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_migration.c
> > 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_thp_split.c
> > 
> > 
> > [1] https://lkml.kernel.org/r/20230411142512.438404-1-david@redhat.com
> > 
> > ---
> >  mm/huge_memory.c | 4 ++--
> >  mm/migrate.c     | 5 +----
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c23fa39dec92..624671aaa60d 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2234,7 +2234,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  		} else {
> >  			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
> >  			if (write)
> > -				entry = maybe_mkwrite(entry, vma);
> > +				entry = pte_mkwrite(entry);
> 
> This is another change besides page migration.  I also don't know why it's
> needed, but it's there since day 1 of thp split in eef1b3ba053, so maybe
> worthwhile to copy Kirill too (which I did).

I was concentrated on the correctness at the point and this small
inefficency didn't catch my eyes.

I was curious how we serialize here against mprotect().

Looks safe to me:

	CPU0					CPU1

__split_huge_pmd()
  pmd_lock()
  __split_huge_pmd_locked()
    pmdp_invalidate()
    // PMD is non-present, but huge at this point
 						change_protection()
						  change_pmd_range()
						    pmd_none_or_clear_bad_unless_trans_huge() == 0 // not skipped
						    change_huge_pmd()
						      __pmd_trans_huge_lock()
						        pmd_lock() // serialized against __split_huge_pmd()

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
