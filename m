Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF469EB10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBUXOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBUXOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742382B289
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677021239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjoBVATOtfv9v8rBFcDxxSIvzUrutqIng+kqTLVn4fY=;
        b=e2i4f9eVQoL30LjxUfHGXp5B1F12HzDtUHsS7IQKHpSV+jsLOwHOCos61npLJXafJ9hoNL
        lkYVs7XlkJ2Eb7WuYSI//pNfDX/G5b0o4XWmPDTYfPSs/WkD2tbOJwN/0POsDSRW3MM3ST
        NDHyI204Ga73gyDyPoOxyqquAbcSuQ4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-Fku7qy7hMMm7ndv83P3V1A-1; Tue, 21 Feb 2023 18:13:58 -0500
X-MC-Unique: Fku7qy7hMMm7ndv83P3V1A-1
Received: by mail-qk1-f200.google.com with SMTP id w9-20020ae9e509000000b0074232aa927dso694917qkf.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677021237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjoBVATOtfv9v8rBFcDxxSIvzUrutqIng+kqTLVn4fY=;
        b=fv8+1F+KXCyNvGQZ/LN2STbo7hDCzQorbBjEv+7LlFsREJs4YvcxAEAlnmFGUkvgYh
         fcRFN5nKeqMt0KLaeFNW1FD4Ax0kWqbMAdm74XndGWYdlKYIQ5z1/5dvPHXkDNMn8ZQS
         qgvpmhk96+22ebpQzPUDWwm4j0SFFAXeL4+yMcLUrvYvmuS2as5lmbQfvctiTKQDC51K
         9aNfZd8K4Vd27+uxEjCMV55Vr9bL1/NL/tzfVQYFPXtYwiIK/DQOq2GJ6ksjUK2NJ10d
         qJ7GUos+VQsR3zEhJzmJ4vyfOF+845FhSNQDvcpFe64n2iJqNTMYzHoRa1bJP07SlnHC
         rJHw==
X-Gm-Message-State: AO0yUKVmS+EdW0qjchmOIhXwGhuodBs39F+U5cdVycqtUjm56d59TQDY
        v468nSna08aZ5lh/imBnx0aOnUR7lS45/M6RMm9ypUMsl2ZmzAsy/JhW+NXMThoiKFhXJnh/blZ
        /GojIRcuRwPLJbbxCIQTVt4n1
X-Received: by 2002:a0c:f4c1:0:b0:56e:f7dd:47ad with SMTP id o1-20020a0cf4c1000000b0056ef7dd47admr8917224qvm.5.1677021237419;
        Tue, 21 Feb 2023 15:13:57 -0800 (PST)
X-Google-Smtp-Source: AK7set9d0bGlAnIDa86XEfhWI141EdIN8UnlgEpLgUNpSwq1LVJygd8DRb9SezIDQdfK/A668iuZWg==
X-Received: by 2002:a0c:f4c1:0:b0:56e:f7dd:47ad with SMTP id o1-20020a0cf4c1000000b0056ef7dd47admr8917201qvm.5.1677021237102;
        Tue, 21 Feb 2023 15:13:57 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d191-20020a3768c8000000b0073b4d8cb4a5sm1666128qkc.60.2023.02.21.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 15:13:56 -0800 (PST)
Date:   Tue, 21 Feb 2023 18:13:55 -0500
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
Message-ID: <Y/VQMyssclyIGa5i@x1n>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
 <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
 <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
 <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com>
 <Y/AIEvHJoMUnh4b6@x1n>
 <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:43:28PM +0100, David Hildenbrand wrote:
> I think what we really want to avoid is, creating a new VMA and requiring to
> populate page tables just to set the PTEs softdirty.
> 
> The VMA flag is one way, but it might prevent merging as we discovered.
> Changing the semantic of "pte_none()" to mean " dirty" is another one.

AFAIU, seeing pte_none() as dirty obviously adds false positives in another
way, comparing to what happens when we merge vmas.

> Simply because we cared about getting it precise for uffd-wp, which nobody
> cared for before for soft-dirty. And yes, there are similar issues to be
> solve.
> 
> You are much rather turning uffd-wp with the async mode into a soft-dirty
> replacement,

Exactly.  When I was discussing uffd-wp years ago with Andrea, Andrea
already mentioned about replacing soft-dirty with uffd-wp since then.

We wasn't really clear about what interface it would look like; at that
time the plan was not using pagemap, but probably something else to avoid
the pgtable walking.

I thought about that later with other forms like ring structures, not so
much. Later on I figured that maybe it's not that trivial to do so, and the
benefit is not clear, either.  We know we may avoid pgtable walks, but we
don't yet know what to lose.

> instead using what we learned with uffd-wp to make soft-dirty more
> precise.

I hope it's not in a way we duplicate many things from userfaultfd, though.

As I mentioned before, we can have yet another bit reserved in pte markers
for soft-dirty and that was actually the plan, but if they'll grow into
something even more similar, it'll be fair if someone asks "why bother?".

The other thing is IIUC soft dirty just took the burden of compatibility,
if that works out we don't probably need uffd-wp async mode on the other
way round - in short, if we can have one thing working for all cases IMHO
we don't bother duplicating in the other.

> 
> Fair enough, I won't interfere. The natural way for me to tackle this would
> be to try fixing soft-dirty instead, or handle the details on how soft-dirty
> is implemented internally: not exposing to user space that we are using
> uffd-wp under the hood, for example.
> 
> 
> Maybe that would be a reasonable approach? Handle this all internally if
> possible, and remove the old soft-dirty infrastructure once it's working.
> 
> We wouldn't be able to use uffd-wp + softdirty, but who really cares I guess
> ...

The thing is userfaultfd is an exposed and formal kernel interface to
userspace already, before / if this new async mode will land.  IMHO it's
necessary in this case to let the user know what's happening inside rather
than thinking this is not important and make decision for the user. We
don't want to surprise anyone I guess..

It's not only from the angle where an user may be using userfault in its
tracee app, so the user will know why the "new soft-dirty" won't work.

It's also about maintaining compatible with soft-dirty even if we want to
replace it some day with uffd-wp - it means there'll at least be a period
of having both of them exist, not until we know they're solidly replaceable
between each other.

So far it's definitely not in that stage.. and they're not alike - it's
just that some of us wanted to have soft-dirty change into something like
uffd-wp, then since the 1st way is not easily achievable, we can try the
other way round.

> 
> > 
> > One thing I didn't mention before (mostly referring to the 1st major
> > "defect" of using uffd-wp above I said [1] on memory types): _maybe_ we can
> > someday extend at least async mode of uffd-wp to all memory types, so it'll
> > even get everything covered.  So far I don't see a strong requirement of
> > doing so, but I don't see a major blocker either.
> 
> Architecture support is, of course, another issue. Of course, if we could
> replace soft-dirty tracking by uffd-wp internally that would make things
> easier ...

Yes, here it was about page caches, but arch support is another thing.
Uffd-wp is just not as widely spread as soft-dirty to multi-archs, and also
many users may not need that accuracy (by paying off performance).

> 
> > 
> > While the other "uffd cannot be nested" defect is actually the same to
> > soft-dirty (no way to have a tracee being able to clear_refs itself or
> > it'll also go a mess), it's just that we can still use soft-dirty to track
> > an uffd application.
> 
> I wonder if we really care about that. Would be good to know if there are
> any relevant softdirty users still around ... from what I understoodm even
> CRIU wants to handle it using uffd-wp.

Yeah I don't know either.

> Jup.

What does this mean?

Thanks,

-- 
Peter Xu

