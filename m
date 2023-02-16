Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F913699BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjBPR4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD333CE2D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676570150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2tgnw3ncEF2oxFUmsim2qGLiKUEtTjsNW/2spHhOXE=;
        b=Tv9IqwFWkDWXWDTqytV+jQA6+jmc5LQ7bL0Lk9wbB+loRDeB4S6jgr1WazPGOgaViaccpf
        /r5EViYhKReiG7qCwcbnwZtLoI3T/tTS/dndbknPgfWzBSSefe5Ysi8vQUq7TMx7yo07qa
        X5eAVptXBzauWqHEOfqF1O/0VigoWf0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-DoI_RFP4MEGOjtive5HXaQ-1; Thu, 16 Feb 2023 12:55:48 -0500
X-MC-Unique: DoI_RFP4MEGOjtive5HXaQ-1
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso1746686ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676570148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2tgnw3ncEF2oxFUmsim2qGLiKUEtTjsNW/2spHhOXE=;
        b=Jj+TFRBqXVsjya0nldpI4MqJtUg5cSl0UDCOVJzmErFWOvtHnQ6xyQqN2D5xwHLwm1
         2pmhSBJtdXl+1vu9inHVpk1GHiSKZIeqaA6oBhlhvp25Z+z8NEC4I8PD8FY5LbwhaHRJ
         WQoLl0Cp6vy09qB2aaOTsW0fB0CNjGMJs8jj4Ezt7W9GrCzDu6b3dEct+EiB0KzRUWv0
         3aYWldOnJ+KD1i4Sv6GDEZQsKdiHL7bXhQT4AaG7pIaAYSc2DLxhK5DjSxprkaSLA6Dh
         V6/A+tHT1HxcpD//q3Sy733OwViAVBWcWWzG9lT7EYLV76afxeRmJFRpPJvsxw3NC7l0
         Yv9w==
X-Gm-Message-State: AO0yUKXqhyHvSDc2+Ta+vS5kN+XJlaV74nD2v6TF9q+vDTg9zPNomT0t
        YBzpnfaPZOIK+hssBgLyd+SayLWAxA9PVsI7j8ktDjfjxY1IWkXGCOvx6Q0KgdsBWqG7Qg8R2Kg
        su1HHN30P9LLiYQzE6bbRbf9Y
X-Received: by 2002:a6b:f909:0:b0:72c:f57a:a37b with SMTP id j9-20020a6bf909000000b0072cf57aa37bmr3840216iog.2.1676570147847;
        Thu, 16 Feb 2023 09:55:47 -0800 (PST)
X-Google-Smtp-Source: AK7set8So9jtqkCnTfnz4CG8UwjiF2zqPCIl6jRKp1AuiPe/LXvvK8Gi/BF+v95HTqf6DF2jsspdLQ==
X-Received: by 2002:a6b:f909:0:b0:72c:f57a:a37b with SMTP id j9-20020a6bf909000000b0072cf57aa37bmr3840199iog.2.1676570147483;
        Thu, 16 Feb 2023 09:55:47 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c050000000b003c484c77623sm748763jam.123.2023.02.16.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:55:46 -0800 (PST)
Date:   Thu, 16 Feb 2023 12:55:45 -0500
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
Message-ID: <Y+5uIS5E9sTLi41T@x1n>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
 <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 06:00:51PM +0100, David Hildenbrand wrote:
> > > 
> > > There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
> > > PTE markers, would be more benficial:
> > > 
> > > 1) It would be applicable to anon hugetlb
> > 
> > Anon hugetlb should already work with non ptes with the markers?
> > 
> 
> ... really? I thought we'd do the whole pte marker handling only when
> dealing with hugetlb/shmem. Interesting, thanks. (we could skip population
> in QEMU in that case as well -- we always do it for now)

Hmm, you're talking about "anon hugetlb", so it's still hugetlb, right? :)

For qemu's live snapshot, let me take a look at that later; and I will
definitely do so if this patch lands, then we avoid it completely.

> 
> > > 2) It would be applicable even when the zeropage is disallowed
> > >     (mm_forbids_zeropage())
> > 
> > Do you mean s390 can disable zeropage with mm_uses_skeys()?  So far uffd-wp
> > doesn't support s390 yet, I'm not sure whether we over worried on this
> > effect.
> > 
> > Or is there any other projects / ideas that potentially can enlarge forbid
> > zero pages to more contexts?
> 
> I think it was shown that zeropages can be used to build covert channels
> (similar to memory deduplciation, because it effectively is memory
> deduplication). It's mentioned as a note in [1] under VII. A. ("Only
> Deduplicate Zero Pages.")
> 
> 
> [1] https://www.ndss-symposium.org/wp-content/uploads/2022-81-paper.pdf

Thanks for the link.  I'm slightly confused how dedup of zero pages is a
concern here, though.

IIUC the security risk is when the dedup-ed pages contain valid information
so the attacker can measure latency of requests when the attemped malicious
page contains exactly the same content of the data page, by trying to
detect the CoW from happening.

Here it's the zero page, even if there's CoW difference the data being
exposed can only be all zeros?  Then what's the risk?

Another note for s390: when it comes we can consider moving to pte markers
conditionally when !zeropage.  But we can leave that for later.

> 
> > 
> > > 3) It would be possible to optimize even without the huge zeropage, by
> > >     using a PMD marker.
> > 
> > This patch doesn't need huge zeropage being exist.
> 
> Yes, and for that reason I think it may perform worse than what we already
> have in some cases. Instead of populating a single PMD you'll have to fill a
> full PTE table.

Yes.  If you think that'll worth it, I can conditionally do pmd zero thp in
a new version.  Maybe it will be a good intermediate step between
introducing pte markers to pmd/pud/etc, so at least we don't need other
changes to coordinate pte markers to higher levels.

> 
> > 
> > > 4) It would be possible to optimize even on the PUD level using a PMD
> > >     marker.
> > 
> > I think 3+4 is in general an interesting idea on using pte markers on
> > higher than pte levels, but that needs more changes.
> > 
> > Firstly, keep using pte markers is somehow preallocating the pgtables, so a
> > side effect of it could be speeding up future faults because they'll all
> > split into pmd locks and read doesn't need to fault at all, only writes.
> > 
> > Imagine when you hit a page fault on a pmd marker, it means you'll need to
> > spread that "marker" information to child ptes and you must - it moves the
> > slow operation of WP into future page faults in some way.  In some cases
> > (I'd say, most cases..) that's not wanted.  The same to PUDs.
> 
> Right, but user space already has that option (see below).
> 
> > 
> > > 
> > > Especially when uffd-wp'ing large ranges that are possibly all unpopulated
> > > (thinking about the existing VM background snapshot use case either with
> > > untouched memory or with things like free page reporting), we might neither
> > > be reading or writing that memory any time soon.
> > 
> > Right, I think that's a trade-off. But I still think large portion of
> > totally unpopulated memory should be rare case rather than majority, or am
> > I wrong?  Not to mention that requires a more involved changeset to the
> > kernel.
> > 
> > So what I proposed here is the (AFAIU) simplest solution towards providing
> > such a feature in a complete form.  I think we have chance to implement it
> > in other ways like pte markers, but that's something we can work upon, and
> > so far I'm not sure how much benefit we can get out of it yet.
> > 
> 
> What you propose here can already be achieved by user space fairly easily
> (in fact, QEMU implementation could be further sped up using
> MADV_POPULATE_READ). Usually, we only do that when there are very good
> reasons to (performance).

Yes POPULATE_READ will be faster.  This patch should make it even faster,
because it merges the two walks.

> 
> Using PTE markers would provide a real advantage IMHO for some users (IMHO
> background snapshots), where we might want to avoid populating
> zeropages/page tables as best as we can completely if the VM memory is
> mostly untouched.
> 
> Naturally, I wonder if UFFD_FEATURE_WP_ZEROPAGE is really worth it. Is there
> is another good reason to combine the populate zeropage+wp that I am missing
> (e.g., atomicity by doing both in one operation)?

It also makes the new WP_ASYNC and pagemap interface clean: we don't want
to have user pre-fault it every time too as a common tactic..  It's hard to
use, and the user doesn't need to know the internals of why it is needed,
either.

The other thing is it provides a way to make anon and !anon behave the same
on empty ptes; it's a pity that it was not already like that.

We can always optimize this behavior in the future with either
PMD/PUD/.. pte markers as you said, but IMHO that just needs further
justification on the complexity, and also on whether that's beneficial to
the majority to become the default behavior.

The worst case (if anyone would like that behavior) is we can have another
feature bit making decision of that behavior, but that'll be something on
top.

Thanks,

-- 
Peter Xu

