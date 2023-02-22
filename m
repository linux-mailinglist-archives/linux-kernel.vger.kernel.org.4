Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1669FD10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjBVUiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBVUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E0E38B47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677098245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JVxU2UKQSvqDsuCKkAcVvTb225ImYhgx1XhyfOQZAI=;
        b=R8f3mTScCayd+AJDp12SO3CFGTWwk9VqlyEID7Otgxodxe4N3O/f547zdr67WI1SvSpeHL
        qKd3GIE/V8+cZKwYmgWQBHeeu5Co2KADKgGG2dPLsKoDAMFJD1X/7pGrHZiie75p3xHIFw
        8doREgMCyU7DsfOAX7xMRriSDt2w5NE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-xnAIUj1APJqTEkYvD09mgA-1; Wed, 22 Feb 2023 15:37:24 -0500
X-MC-Unique: xnAIUj1APJqTEkYvD09mgA-1
Received: by mail-qk1-f198.google.com with SMTP id y1-20020a05620a09c100b0070630ecfd9bso4529403qky.20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JVxU2UKQSvqDsuCKkAcVvTb225ImYhgx1XhyfOQZAI=;
        b=NOBmMCfrbDBUdm2kJZ2hZhfA1DjWxCd4PSZ2bOTgBf1vwykUJC0545COAgPzaO89bW
         zgiCpG+mHMnljQ8DDL0AG5ypd8sTBCyFV2xPsHdMKSdznKAmBpsh5chYBkrXmnjZdjx6
         J9La2J8aX4HqrIEVSBV0hgkKiwSP+84+TQPj3qGsg6c9kjPhJjIN5Rv+rO98nTK+77qE
         hzU3Ac2cQx27nOIgF9mhocPKeQjyjkXL8yzfn5y9Kb/TC2FxZy7qkrcVxlDqDmNKI7ru
         9RvxFLIk7EYtrxwjSyQY6hHYZHXfJN8pM2D7P9mL2ANtd1M1iNCxXOi+Y42ZJ/S/sD+g
         lfxQ==
X-Gm-Message-State: AO0yUKULTlhCC6QG5CRMrLJCf4bk9eGQ2Jnf5PCCw71jSyOsLcsp1Ipy
        gQjZj9KulxT1xziBqhzw1WCrPBG2iNkzx26T1pLYY5ehs9TfkA4GyoTm8NlcX4NPFBr0RTJrPEy
        2KkdVQeItV/3UhJu6bvqInnOKspE6Ng==
X-Received: by 2002:ac8:7e94:0:b0:3b9:fc92:a6 with SMTP id w20-20020ac87e94000000b003b9fc9200a6mr20592987qtj.6.1677098243040;
        Wed, 22 Feb 2023 12:37:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9gTpyrDAooN4+9G9IXSsK2TI/oGWL9VsQG3+T5Kz68zeOOSm7XjfDjqv12rmyAppkTPVqFLw==
X-Received: by 2002:ac8:7e94:0:b0:3b9:fc92:a6 with SMTP id w20-20020ac87e94000000b003b9fc9200a6mr20592944qtj.6.1677098242680;
        Wed, 22 Feb 2023 12:37:22 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f24-20020ac840d8000000b003b7e8c04d2esm4948366qtm.64.2023.02.22.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 12:37:22 -0800 (PST)
Date:   Wed, 22 Feb 2023 15:37:20 -0500
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
Message-ID: <Y/Z9ACW8l2E3kOVk@x1n>
References: <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
 <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
 <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com>
 <Y/AIEvHJoMUnh4b6@x1n>
 <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com>
 <Y/VQMyssclyIGa5i@x1n>
 <91d7c512-ee57-7d71-34b7-90e45f5c109b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91d7c512-ee57-7d71-34b7-90e45f5c109b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 06:02:37PM +0100, David Hildenbrand wrote:
> On 22.02.23 00:13, Peter Xu wrote:
> > On Tue, Feb 21, 2023 at 01:43:28PM +0100, David Hildenbrand wrote:
> > > I think what we really want to avoid is, creating a new VMA and requiring to
> > > populate page tables just to set the PTEs softdirty.
> > > 
> > > The VMA flag is one way, but it might prevent merging as we discovered.
> > > Changing the semantic of "pte_none()" to mean " dirty" is another one.
> > 
> > AFAIU, seeing pte_none() as dirty obviously adds false positives in another
> > way, comparing to what happens when we merge vmas.
> 
> Yeah ... I think it's all tuned for "well, let's allow some false positives,
> but keep it simple such that we don't have to allocate a bunch of page
> tables just to track memory that won't eventually be written either way".
> 
> So when merging, we say "well, let's consider all pte_none() as dirty again"
> by setting the softdirty flag. Otherwise, we'd have to handle allocation pf
> page tables and whatnot to make merging work without setting the VM flag.
> 
> 
> Allocating all these page tables to install uffd-wp flags is also one of the
> things I actually dislike about the new approach just to get more precision.

My take is that this is unavoidable if we need the accuracy.  More below.

> I wondered if it could be avoided, but my brain started to hurt. Just an
> idea how to eventually avoid it:
> 
> 
> We can catch access to these virtual memory that are not populated using
> UFFD_MISSING mode. When installing a zeropage, we could set the uffd-wp bit.

Good point. :)

> But we don't want to mix in the missing mode I guess. But maybe we could use
> a similar approach for the uffd-wp async mode? Something like the following.
> 
> 
> We'd want another mode(s?) for that, in addition to _ASYNC mode:
> 
> (a) When we hit an unpopulated PTE using read-access, we map a fresh page
> (e.g., zeropage) and set the uffd-wp bit. This will make sure that the next
> write access triggers uffd-wp.
> 
> (b) When we hit an unpopulated PTE using write-access, we only map a fresh
> page (not setting the bit). We would want to trigger uffd-wp in !_ASYNC mode

Not setting uffd-wp bit sounds dangerous here.  What if right after the
pgtable pte got setup then another thread writting to it?  I think it's
data loss.

> after that. In _ASYNC mode, all is good.

IIUC you're suggesting to have a new vma flag (or VM_UFFD_WP + some other
feature bit, which is fundamentally similar to a new vma flag) to show that
"when register uffd-wp on this region, protection starts right away".  Then
it's not pte based, and we don't have problem on pgtable populations
either.

True, but it goes back to why we need pte markers.  It has the accuracy,
alongside with the trade off of using the pgtables.

Without pte markers and uffd-wp bits everywhere, how do we tell "this pte
is none" or "even if this pte is none, it has been written before but just
got zapped, so we don't need to notify again"?

> 
> 
> pte_none() without the uffd-wp bit set would be assumed to be clean --
> because touching them would turn them dirty (!pte_none() and not have the
> uffd-wp bit set). We might have to handle discarding of memory, by using a
> uffd-wp marker. Then we could detect that (where we already had page tables
> allcoated!) directly.
> 
> 
> Such a mode (excluding the _ASYNC stuff) would even make sense for
> background snapshots in QEMU, and would avoid us having to populate page
> tables completely. Simply uffd-wp all that's populated and don't care about
> pte_none(). These will be properly handled on fault.
> 
> 
> Does something like that make sense?
> 
> 
> > 
> > > Simply because we cared about getting it precise for uffd-wp, which nobody
> > > cared for before for soft-dirty. And yes, there are similar issues to be
> > > solve.
> > > 
> > > You are much rather turning uffd-wp with the async mode into a soft-dirty
> > > replacement,
> > 
> > Exactly.  When I was discussing uffd-wp years ago with Andrea, Andrea
> > already mentioned about replacing soft-dirty with uffd-wp since then.
> > 
> > We wasn't really clear about what interface it would look like; at that
> > time the plan was not using pagemap, but probably something else to avoid
> > the pgtable walking.
> > 
> > I thought about that later with other forms like ring structures, not so
> > much. Later on I figured that maybe it's not that trivial to do so, and the
> > benefit is not clear, either.  We know we may avoid pgtable walks, but we
> > don't yet know what to lose.
> 
> Interesting idea.
> 
> > 
> > > instead using what we learned with uffd-wp to make soft-dirty more
> > > precise.
> > 
> > I hope it's not in a way we duplicate many things from userfaultfd, though.
> > 
> > As I mentioned before, we can have yet another bit reserved in pte markers
> > for soft-dirty and that was actually the plan, but if they'll grow into
> > something even more similar, it'll be fair if someone asks "why bother?".
> > 
> > The other thing is IIUC soft dirty just took the burden of compatibility,
> > if that works out we don't probably need uffd-wp async mode on the other
> > way round - in short, if we can have one thing working for all cases IMHO
> > we don't bother duplicating in the other.
> 
> Right. I wish we didn't have softdirty and could start with something clean.
> :)
> 
> > 
> > > 
> > > Fair enough, I won't interfere. The natural way for me to tackle this would
> > > be to try fixing soft-dirty instead, or handle the details on how soft-dirty
> > > is implemented internally: not exposing to user space that we are using
> > > uffd-wp under the hood, for example.
> > > 
> > > 
> > > Maybe that would be a reasonable approach? Handle this all internally if
> > > possible, and remove the old soft-dirty infrastructure once it's working.
> > > 
> > > We wouldn't be able to use uffd-wp + softdirty, but who really cares I guess
> > > ...
> > 
> > The thing is userfaultfd is an exposed and formal kernel interface to
> > userspace already, before / if this new async mode will land.  IMHO it's
> > necessary in this case to let the user know what's happening inside rather
> > than thinking this is not important and make decision for the user. We
> > don't want to surprise anyone I guess..
> > 
> > It's not only from the angle where an user may be using userfault in its
> > tracee app, so the user will know why the "new soft-dirty" won't work.
> > 
> > It's also about maintaining compatible with soft-dirty even if we want to
> > replace it some day with uffd-wp - it means there'll at least be a period
> > of having both of them exist, not until we know they're solidly replaceable
> > between each other.
> > 
> > So far it's definitely not in that stage.. and they're not alike - it's
> > just that some of us wanted to have soft-dirty change into something like
> > uffd-wp, then since the 1st way is not easily achievable, we can try the
> > other way round.
> 
> Right. And uffd-wp even supports hugetlb :)
> 
> > > > 
> > > > While the other "uffd cannot be nested" defect is actually the same to
> > > > soft-dirty (no way to have a tracee being able to clear_refs itself or
> > > > it'll also go a mess), it's just that we can still use soft-dirty to track
> > > > an uffd application.
> > > 
> > > I wonder if we really care about that. Would be good to know if there are
> > > any relevant softdirty users still around ... from what I understoodm even
> > > CRIU wants to handle it using uffd-wp.
> > 
> > Yeah I don't know either.
> > 
> > > Jup.
> > 
> > What does this mean?
> 
> Yes to the statement "So I assume there's no major issue to not continue
> with a new version, then I'll move on." :)
> 
> But my idea at the very beginning might make sense to consider: can we
> instead handle this at fault time and avoid allocating all these page
> tables. Happy to hear if I am missing something important.

I've raised my questions above.  I had a feeling that you're thinking for
anonymous mostly, because shmem is even trickier IIUC, because ptes can
easily got zapped, then if we only rely on a per-vma attribute, there'll be
tons of false positives.

Anonymous is actually similar, as long as the user app wants to drop the
data and repopulate it again, we'll get yet another wr-protect message
which is probably not useful at all (even if the tracer registered with
UFFD_FEATURE_EVENT_REMOVE to trap DONTNEED, we can't avoid the rubbish
message from coming after that point).

It's sad because that's one major goal of having uffd-wp - we're still
trying our best to avoid false positives, especially logical duplicated
messages (e.g., we got some message that page is wr-protected, we
unprotected it, after a long time, it's notified again it's written).

Thanks,

-- 
Peter Xu

