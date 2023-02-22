Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B869F97A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjBVRDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B353B3E08C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677085362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cy8aRjj0Cs6b4N0ThlOh9z/BIC9bT02uPtrhxFtoTNo=;
        b=PTHYD3yIA/Y/M300SvBcOeZT3u0HvCXQ6cVib5S96DjKxS86lYqDKkuOjNZa+gC3LrNVf2
        EsSmls1xQE7CChzsaYnyVqCRuT1u6N7l8U1F1mEjxGpKkys6fmiPG0Wxskk1/Q/2IOHycX
        7DWliFhZ2/wCpoa2CUnJ1FVNWfvHj7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-w6dfS5bJOSiKqD8gF9w16Q-1; Wed, 22 Feb 2023 12:02:41 -0500
X-MC-Unique: w6dfS5bJOSiKqD8gF9w16Q-1
Received: by mail-wr1-f72.google.com with SMTP id bp30-20020a5d5a9e000000b002bde0366b11so1999212wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy8aRjj0Cs6b4N0ThlOh9z/BIC9bT02uPtrhxFtoTNo=;
        b=ck8RhFGapsEfNK21teDGci1hW3JBV8HMoTR7YbvULruYzzI6gUwBzRQh1pcP9oQelE
         SRZmBJAcz307ESPfSS1jYo/XC9OPB2B+rMXB02A9b5AdRci+20fxNqAjppvMlnj96GZw
         5S762t4j7ERdivYdQkJXlaXN5Pa0TrPa8oZCy7D9b3gDCZwBiqZJoc2pPbv7hf1Frd7M
         RbKRRgjh2Q0zCI1AsmB21Y2f86HMlcFOOfVBfWWsT0KsUQnN1UHDV7TSGMfY4FYqqKC8
         whCXH0ulDS1khImOrzBm/rz0gToM52Cn0FZjvn4SD9gUlSWpCwLuLIwfaqp/IgG6MAwi
         L5JQ==
X-Gm-Message-State: AO0yUKW+nFA4eIB+ji++mGwQmr/IwSHLrjKSlZfBn8aleUnrd9QKEEGH
        FtxsnaY+jCT5giZbpzxPD7NPJIUDTWjggUI8PmtcRHRuIlcZR4hRxODCWjl9m1Ogg+9Dn8vSOAA
        mRn9SKMB9Pa9m1XvBuENT+EjM
X-Received: by 2002:adf:dd88:0:b0:2c5:542a:5850 with SMTP id x8-20020adfdd88000000b002c5542a5850mr8613716wrl.39.1677085359923;
        Wed, 22 Feb 2023 09:02:39 -0800 (PST)
X-Google-Smtp-Source: AK7set+mo0k7MHnXtxAkSgUeDXXUzE5foRsfnHbymUmOrf/7IlUzJydm9lHqTQCuPLy026NNW8sYlg==
X-Received: by 2002:adf:dd88:0:b0:2c5:542a:5850 with SMTP id x8-20020adfdd88000000b002c5542a5850mr8613679wrl.39.1677085359450;
        Wed, 22 Feb 2023 09:02:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:a100:95ad:6325:131:6b1d? (p200300cbc704a10095ad632501316b1d.dip0.t-ipconnect.de. [2003:cb:c704:a100:95ad:6325:131:6b1d])
        by smtp.gmail.com with ESMTPSA id a15-20020adffb8f000000b002c3f03d8851sm7533730wrr.16.2023.02.22.09.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:02:38 -0800 (PST)
Message-ID: <91d7c512-ee57-7d71-34b7-90e45f5c109b@redhat.com>
Date:   Wed, 22 Feb 2023 18:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com> <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com> <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com> <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com> <Y/AIEvHJoMUnh4b6@x1n>
 <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com> <Y/VQMyssclyIGa5i@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y/VQMyssclyIGa5i@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.23 00:13, Peter Xu wrote:
> On Tue, Feb 21, 2023 at 01:43:28PM +0100, David Hildenbrand wrote:
>> I think what we really want to avoid is, creating a new VMA and requiring to
>> populate page tables just to set the PTEs softdirty.
>>
>> The VMA flag is one way, but it might prevent merging as we discovered.
>> Changing the semantic of "pte_none()" to mean " dirty" is another one.
> 
> AFAIU, seeing pte_none() as dirty obviously adds false positives in another
> way, comparing to what happens when we merge vmas.

Yeah ... I think it's all tuned for "well, let's allow some false 
positives, but keep it simple such that we don't have to allocate a 
bunch of page tables just to track memory that won't eventually be 
written either way".

So when merging, we say "well, let's consider all pte_none() as dirty 
again" by setting the softdirty flag. Otherwise, we'd have to handle 
allocation pf page tables and whatnot to make merging work without 
setting the VM flag.


Allocating all these page tables to install uffd-wp flags is also one of 
the things I actually dislike about the new approach just to get more 
precision. I wondered if it could be avoided, but my brain started to 
hurt. Just an idea how to eventually avoid it:


We can catch access to these virtual memory that are not populated using 
UFFD_MISSING mode. When installing a zeropage, we could set the uffd-wp 
bit. But we don't want to mix in the missing mode I guess. But maybe we 
could use a similar approach for the uffd-wp async mode? Something like 
the following.


We'd want another mode(s?) for that, in addition to _ASYNC mode:

(a) When we hit an unpopulated PTE using read-access, we map a fresh 
page (e.g., zeropage) and set the uffd-wp bit. This will make sure that 
the next write access triggers uffd-wp.

(b) When we hit an unpopulated PTE using write-access, we only map a 
fresh page (not setting the bit). We would want to trigger uffd-wp in 
!_ASYNC mode after that. In _ASYNC mode, all is good.


pte_none() without the uffd-wp bit set would be assumed to be clean -- 
because touching them would turn them dirty (!pte_none() and not have 
the uffd-wp bit set). We might have to handle discarding of memory, by 
using a uffd-wp marker. Then we could detect that (where we already had 
page tables allcoated!) directly.


Such a mode (excluding the _ASYNC stuff) would even make sense for 
background snapshots in QEMU, and would avoid us having to populate page 
tables completely. Simply uffd-wp all that's populated and don't care 
about pte_none(). These will be properly handled on fault.


Does something like that make sense?


> 
>> Simply because we cared about getting it precise for uffd-wp, which nobody
>> cared for before for soft-dirty. And yes, there are similar issues to be
>> solve.
>>
>> You are much rather turning uffd-wp with the async mode into a soft-dirty
>> replacement,
> 
> Exactly.  When I was discussing uffd-wp years ago with Andrea, Andrea
> already mentioned about replacing soft-dirty with uffd-wp since then.
> 
> We wasn't really clear about what interface it would look like; at that
> time the plan was not using pagemap, but probably something else to avoid
> the pgtable walking.
> 
> I thought about that later with other forms like ring structures, not so
> much. Later on I figured that maybe it's not that trivial to do so, and the
> benefit is not clear, either.  We know we may avoid pgtable walks, but we
> don't yet know what to lose.

Interesting idea.

> 
>> instead using what we learned with uffd-wp to make soft-dirty more
>> precise.
> 
> I hope it's not in a way we duplicate many things from userfaultfd, though.
> 
> As I mentioned before, we can have yet another bit reserved in pte markers
> for soft-dirty and that was actually the plan, but if they'll grow into
> something even more similar, it'll be fair if someone asks "why bother?".
> 
> The other thing is IIUC soft dirty just took the burden of compatibility,
> if that works out we don't probably need uffd-wp async mode on the other
> way round - in short, if we can have one thing working for all cases IMHO
> we don't bother duplicating in the other.

Right. I wish we didn't have softdirty and could start with something 
clean. :)

> 
>>
>> Fair enough, I won't interfere. The natural way for me to tackle this would
>> be to try fixing soft-dirty instead, or handle the details on how soft-dirty
>> is implemented internally: not exposing to user space that we are using
>> uffd-wp under the hood, for example.
>>
>>
>> Maybe that would be a reasonable approach? Handle this all internally if
>> possible, and remove the old soft-dirty infrastructure once it's working.
>>
>> We wouldn't be able to use uffd-wp + softdirty, but who really cares I guess
>> ...
> 
> The thing is userfaultfd is an exposed and formal kernel interface to
> userspace already, before / if this new async mode will land.  IMHO it's
> necessary in this case to let the user know what's happening inside rather
> than thinking this is not important and make decision for the user. We
> don't want to surprise anyone I guess..
> 
> It's not only from the angle where an user may be using userfault in its
> tracee app, so the user will know why the "new soft-dirty" won't work.
> 
> It's also about maintaining compatible with soft-dirty even if we want to
> replace it some day with uffd-wp - it means there'll at least be a period
> of having both of them exist, not until we know they're solidly replaceable
> between each other.
> 
> So far it's definitely not in that stage.. and they're not alike - it's
> just that some of us wanted to have soft-dirty change into something like
> uffd-wp, then since the 1st way is not easily achievable, we can try the
> other way round.

Right. And uffd-wp even supports hugetlb :)

>>>
>>> While the other "uffd cannot be nested" defect is actually the same to
>>> soft-dirty (no way to have a tracee being able to clear_refs itself or
>>> it'll also go a mess), it's just that we can still use soft-dirty to track
>>> an uffd application.
>>
>> I wonder if we really care about that. Would be good to know if there are
>> any relevant softdirty users still around ... from what I understoodm even
>> CRIU wants to handle it using uffd-wp.
> 
> Yeah I don't know either.
> 
>> Jup.
> 
> What does this mean?

Yes to the statement "So I assume there's no major issue to not continue 
with a new version, then I'll move on." :)

But my idea at the very beginning might make sense to consider: can we 
instead handle this at fault time and avoid allocating all these page 
tables. Happy to hear if I am missing something important.

-- 
Thanks,

David / dhildenb

