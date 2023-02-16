Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A875E699D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBPUJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C44AFCF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676578092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfg8vX36saRjsMPz9DnZnl4MYT0Crb29SB6FTOezmE8=;
        b=EyO2EmWjWOKhyBvVh0nfVY083TJ38zKsIAgfOc52Ag+2v86RBOGnEYRAngFm6OkQH2IY0d
        J7GRfq6J37Z70/pLTExsN21ixPVmNEZbKIpe6giTlSIuCgQ1YcBI48u+qD38CtPmDqhPCX
        qyxD9Gal6c/PHsK//ePjgQS2iMt859o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-264-ijL0-myjO5ClHXA9appoBg-1; Thu, 16 Feb 2023 15:08:11 -0500
X-MC-Unique: ijL0-myjO5ClHXA9appoBg-1
Received: by mail-qk1-f198.google.com with SMTP id 130-20020a370588000000b0072fcbe20069so1876724qkf.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676578091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfg8vX36saRjsMPz9DnZnl4MYT0Crb29SB6FTOezmE8=;
        b=LfwvD6PlG2EqqAIRd8bItKdYXdPbQR/9Jkb+ywR3tLB8Is1O6SOCYvDb2eyfvOSXca
         yETt5yEABBJZDLLsIDgM/LE7ag3COBDIu/h7Qq9+E8CycM0+vQhAwwGYBF9DtxaImNaJ
         S/hHDbOAM7VPCzQhvJ8Wsnhxl486oo/13jpL2yimoO5HvNS5q6osSPZ3lCeeekc7H0F0
         /Kz/7xTDuGDoWCYs15albW+cY+aRiJBrW5w8voFXQnhtM0HB3aBRaUdwV2kT7vvs8YPx
         tOWipHOrxEdwULdxpSkeJHTJmv1Sl8waEV5Wz4TmDKMBt0rbTwaKX5+gE3GU6CZd9sDm
         TG3w==
X-Gm-Message-State: AO0yUKW4OaETD78VZvJ+oMkrvjfljqDGX6vFXLM55KdylHeOrnwhK8Vn
        1ycksCQ6C0Ai8jakAOaVQtAwDei3k8wtGC3kyGorAxW9AOv435ic5nLp9pORUF6p/xFPPpEhGMJ
        /bKuGr13TwZKWrALDd+R2EPdV
X-Received: by 2002:a05:6214:1a07:b0:56f:666:f0d3 with SMTP id fh7-20020a0562141a0700b0056f0666f0d3mr2392004qvb.4.1676578091126;
        Thu, 16 Feb 2023 12:08:11 -0800 (PST)
X-Google-Smtp-Source: AK7set924eOf8nnWTcs9FvB325jfrkmQ680Fy4zCtcDuJt1ntP00uDZMz+cN655ihjjAOHvCI2jdjA==
X-Received: by 2002:a05:6214:1a07:b0:56f:666:f0d3 with SMTP id fh7-20020a0562141a0700b0056f0666f0d3mr2391974qvb.4.1676578090732;
        Thu, 16 Feb 2023 12:08:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id i187-20020a3786c4000000b006fc2f74ad12sm1781382qkd.92.2023.02.16.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:08:09 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:08:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Message-ID: <Y+6NKPuty9V3nycI@x1n>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
 <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
 <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        On Thu, Feb 16, 2023 at 07:23:17PM +0100, David Hildenbrand wrote:
> On 16.02.23 18:55, Peter Xu wrote:
> > On Thu, Feb 16, 2023 at 06:00:51PM +0100, David Hildenbrand wrote:
> > > > > 
> > > > > There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
> > > > > PTE markers, would be more benficial:
> > > > > 
> > > > > 1) It would be applicable to anon hugetlb
> > > > 
> > > > Anon hugetlb should already work with non ptes with the markers?
> > > > 
> > > 
> > > ... really? I thought we'd do the whole pte marker handling only when
> > > dealing with hugetlb/shmem. Interesting, thanks. (we could skip population
> > > in QEMU in that case as well -- we always do it for now)
> > 
> > Hmm, you're talking about "anon hugetlb", so it's still hugetlb, right? :)
> 
> I mean especially MAP_PRIVATE|MAP_HUGETLB|MAP_ANONYMOUS, so "in theory"
> without any fd and thus pagecache. ... but anon hugetlb keeps confusing me
> with pagecache handling.

IIUC when mmap(fd==-1) it's the same as MAP_PRIVATE|MAP_HUGETLB.

> 
> > > 
> > > > > 2) It would be applicable even when the zeropage is disallowed
> > > > >      (mm_forbids_zeropage())
> > > > 
> > > > Do you mean s390 can disable zeropage with mm_uses_skeys()?  So far uffd-wp
> > > > doesn't support s390 yet, I'm not sure whether we over worried on this
> > > > effect.
> > > > 
> > > > Or is there any other projects / ideas that potentially can enlarge forbid
> > > > zero pages to more contexts?
> > > 
> > > I think it was shown that zeropages can be used to build covert channels
> > > (similar to memory deduplciation, because it effectively is memory
> > > deduplication). It's mentioned as a note in [1] under VII. A. ("Only
> > > Deduplicate Zero Pages.")
> > > 
> > > 
> > > [1] https://www.ndss-symposium.org/wp-content/uploads/2022-81-paper.pdf
> > 
> > Thanks for the link.  I'm slightly confused how dedup of zero pages is a
> > concern here, though.
> > 
> > IIUC the security risk is when the dedup-ed pages contain valid information
> > so the attacker can measure latency of requests when the attemped malicious
> > page contains exactly the same content of the data page, by trying to
> > detect the CoW from happening. >
> > Here it's the zero page, even if there's CoW difference the data being
> > exposed can only be all zeros?  Then what's the risk?
> 
> The focus of that paper is on CoW latency yes (and deduplication
> instantiating shared zeropages -- but building a covert channel using CoW
> latency might be rather tricky I think, because they will get deduplciated
> independently of a sender action ...).
> 
> However, in theory, one could build a covert channel between two VMs simply
> by using cache flushes and reading from the shared zeropage. Measuring
> access time can reveal if the sender read the page (L3 filled) or not (L3
> not filled).

So the attacker will know when someone reads a zeropage, but I still don't
get how that can leads to data leak..

> 
> Having that said, I don't think that we are going to disable the shared
> zeropage because of that for some workloads, I assume in most cases it will
> simply be way too noisy to transmit any kind of data and we have more
> critical covert channels to sort out if we want to.
> 
> Just wanted to raise it because you asked :)
> 
> > 
> > Another note for s390: when it comes we can consider moving to pte markers
> > conditionally when !zeropage.  But we can leave that for later.
> 
> Sure, we could always have another feature flag.

I think that doesn't need to be another feature flag.  If someone will port
uffd-wp to s390 we can implement pte markers for WP_ZEROPAGE, then we
either use it when zeropage not exist, or we can switch to pte markers
completely too without changing the interface if we want, depending on
whether we think replacing zeropages with pte markers will be a major issue
with existing apps.  I don't worry too much on that part.

> 
> > 
> > > 
> > > > 
> > > > > 3) It would be possible to optimize even without the huge zeropage, by
> > > > >      using a PMD marker.
> > > > 
> > > > This patch doesn't need huge zeropage being exist.
> > > 
> > > Yes, and for that reason I think it may perform worse than what we already
> > > have in some cases. Instead of populating a single PMD you'll have to fill a
> > > full PTE table.
> > 
> > Yes.  If you think that'll worth it, I can conditionally do pmd zero thp in
> > a new version.  Maybe it will be a good intermediate step between
> > introducing pte markers to pmd/pud/etc, so at least we don't need other
> > changes to coordinate pte markers to higher levels.
> 
> [...]
> 
> > > > > Especially when uffd-wp'ing large ranges that are possibly all unpopulated
> > > > > (thinking about the existing VM background snapshot use case either with
> > > > > untouched memory or with things like free page reporting), we might neither
> > > > > be reading or writing that memory any time soon.
> > > > 
> > > > Right, I think that's a trade-off. But I still think large portion of
> > > > totally unpopulated memory should be rare case rather than majority, or am
> > > > I wrong?  Not to mention that requires a more involved changeset to the
> > > > kernel.
> > > > 
> > > > So what I proposed here is the (AFAIU) simplest solution towards providing
> > > > such a feature in a complete form.  I think we have chance to implement it
> > > > in other ways like pte markers, but that's something we can work upon, and
> > > > so far I'm not sure how much benefit we can get out of it yet.
> > > > 
> > > 
> > > What you propose here can already be achieved by user space fairly easily
> > > (in fact, QEMU implementation could be further sped up using
> > > MADV_POPULATE_READ). Usually, we only do that when there are very good
> > > reasons to (performance).
> > 
> > Yes POPULATE_READ will be faster.  This patch should make it even faster,
> > because it merges the two walks.
> > 
> 
> Getting some performance numbers would be nice.

Sure, I'll collect some data and post a new version.

> 
> > > 
> > > Using PTE markers would provide a real advantage IMHO for some users (IMHO
> > > background snapshots), where we might want to avoid populating
> > > zeropages/page tables as best as we can completely if the VM memory is
> > > mostly untouched.
> > > 
> > > Naturally, I wonder if UFFD_FEATURE_WP_ZEROPAGE is really worth it. Is there
> > > is another good reason to combine the populate zeropage+wp that I am missing
> > > (e.g., atomicity by doing both in one operation)?
> > 
> > It also makes the new WP_ASYNC and pagemap interface clean: we don't want
> > to have user pre-fault it every time too as a common tactic..  It's hard to
> > use, and the user doesn't need to know the internals of why it is needed,
> > either.
> 
> I feel like we're building a lot of infrastructure on uffd-wp instead of
> having an alternative softdirty mode (using a world switch?) that works as
> expected and doesn't require that many uffd-wp extensions. ;)

We used to discuss this WP_ZEROPAGE before, and I thought we were all happy
to have that.  Obviously you changed your mind. :)

I wasn't really eager on this before because the workaround of pre-read
works good already (I assume slightly slower but it's fine; not until
someone starts to worry).  But if we want to extend soft-dirty that's not
good at all to have any new user being requested to prefault memory and
figuring out why it's needed.

> 
> Having that said, I have the feeling that you and Muhammad have a plan to
> make it work using uffd-wp and I won't interfere. It would be nicer to use
> softdirty infrastructure IMHO, though.

Thanks.  If you have any good idea on reusing soft-dirty, please shoot.
I'll be perfectly happy with it as long as it resolves the issue for
Muhammad.  Trust me - I wished the soft dirty thing worked out, but
unfortunately it didn't..  Because at least so far uffd-wp has two major
issues as I can see:

  (1) Memory type limitations (e.g. general fs memories stop working)
  (2) Tracing uffd application is, afaict, impossible

So if there's better way to do with soft-dirty or anything else (and I
assume it'll not be limited to any of above) it's time to say..

> 
> > 
> > The other thing is it provides a way to make anon and !anon behave the same
> > on empty ptes; it's a pity that it was not already like that.
> 
> In an ideal world, we'd simply be using PTE markers unconditionally I think
> and avoid this zeropage feature :/
> 
> Is there any particular reason to have UFFD_FEATURE_WP_ZEROPAGE and not
> simply always do that unconditionally? (sure, we have to indicate to user
> space that it now works as expected) Are we really expecting to break user
> space by protecting what was asked for to protect?

I suspect so.

From high level, the major functional changes will be:

  (1) The user will start to receive more WP message with zero page being
      reported,

  (2) Wr-protecting a very sparse memory can be much slower

I would expect there're cases where the app just works as usual.

However in some other cases the user may really not care about zero pages
at all, and I had a feeling that's actually the majority.

Live snapshot is actually special because IIUC the old semantics should
work perfectly if the guest OS won't try to sanity check freed pages being
all zeros..  IOW that's some corner case, and if we can control that we may
not even need WP_ZEROPAGE too for QEMU, iiuc.  For many other apps people
may leverage this (ignoring mem holes) and make the app faster.

Normally when I'm not confident of any functional change, I'd rather use a
flag.  Luckily uffd is very friendly to that, so the user can have better
control of what to expect.  Some future app may explicitly want to always
ignore zero pages when on extremely sparse mem, and without the flag it
can't choose.

> 
> > 
> > We can always optimize this behavior in the future with either
> > PMD/PUD/.. pte markers as you said, but IMHO that just needs further
> > justification on the complexity, and also on whether that's beneficial to
> > the majority to become the default behavior.
> 
> As I said, usually any new features require good justification. Maybe there
> really is a measurable performance gain (less syscalls, less pgtable walks).

Muhammad may have a word to say here; let's see whether he has any comment.

Besides that, as I replied above I'll collect some data in my next post
regardless, with an attempt to optimize with huge zeropages on top.

Thanks,

-- 
Peter Xu

