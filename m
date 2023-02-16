Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C149699ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBPRBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E111731
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676566856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPtS2M4ckztPkytz/xiV8zOap2sT6BuznJ9SmPkRUBo=;
        b=BM3telA40Azgc92AT/YSaa/4jjfojzSYYToCbCY5hWuyv31BRCCw5lkv62uxm1LZlZGTy3
        ZJpEWrT+RleP74TAzjYeDcdNJRcX9XtxEGy93C/24sSZQA3URtK9hvtdX1SJoos7U8DhzL
        lGrU5E3hJ5vJ7rzeKihL766IfifCJl0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-B-unw87uMByP-_-dTFOS2g-1; Thu, 16 Feb 2023 12:00:55 -0500
X-MC-Unique: B-unw87uMByP-_-dTFOS2g-1
Received: by mail-wm1-f70.google.com with SMTP id fl9-20020a05600c0b8900b003dfe4bae099so1440364wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPtS2M4ckztPkytz/xiV8zOap2sT6BuznJ9SmPkRUBo=;
        b=p3L5pkjympyRIHWyVjDtfOSOOX3SeJYhD4C23QXNRpwVKQ9yKZCIuLSLyshAG+C/ct
         RuSvNu0DVFckboOBS27uQe3Vycb6XwAfKLZYwjrniLcUEBVoyULXLxPIRw01JW13dewd
         ifOmtaFizu0/ltSywXoPuq82eEXttYDrfUyqcGDA3cj7BatZRnQbUEhNkdqpPs8s4/0U
         BFttcQ6cgBHd2LMJOWnJJXqIJOhDbFF4pMjZUwprRJrsa5M5kxCm/TSk20OKUqoMoDNy
         MYHgGqYq+6CMBnl0cOnlLX2V0JGPzx1Y5txtIQ0CIgCTDWLnpMVR/WiPAVlPIm5AOwLd
         lo0g==
X-Gm-Message-State: AO0yUKV6H0gJdEK6wu2cIzN/2Cv+JyAssKUjK9zbI19Cb8eHs1rbljAW
        vGqc2M/5lBGmiN63MjBjADgY5Gii+NjkjwYR2ZwSAT98ysyto18qW7d1rNMLL0rhvuKFnOcXAYe
        JL5G+jKVwts9BiH4XCmWZJ20xOatw5A==
X-Received: by 2002:a5d:40d0:0:b0:2c5:5a65:799f with SMTP id b16-20020a5d40d0000000b002c55a65799fmr4808553wrq.34.1676566853678;
        Thu, 16 Feb 2023 09:00:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9dw7x2GZ1RBccsi5U8GisuBksZelvx9S8gQKwDhaYWOgVGlFewbg4pWNsxPmhoWu8WHuq2Ng==
X-Received: by 2002:a5d:40d0:0:b0:2c5:5a65:799f with SMTP id b16-20020a5d40d0000000b002c55a65799fmr4808533wrq.34.1676566853285;
        Thu, 16 Feb 2023 09:00:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d530e000000b002c553e061fdsm1852390wrv.112.2023.02.16.09.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 09:00:52 -0800 (PST)
Message-ID: <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
Date:   Thu, 16 Feb 2023 18:00:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y+5Z+88Z3T2TyxUI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
>> PTE markers, would be more benficial:
>>
>> 1) It would be applicable to anon hugetlb
> 
> Anon hugetlb should already work with non ptes with the markers?
> 

... really? I thought we'd do the whole pte marker handling only when 
dealing with hugetlb/shmem. Interesting, thanks. (we could skip 
population in QEMU in that case as well -- we always do it for now)

>> 2) It would be applicable even when the zeropage is disallowed
>>     (mm_forbids_zeropage())
> 
> Do you mean s390 can disable zeropage with mm_uses_skeys()?  So far uffd-wp
> doesn't support s390 yet, I'm not sure whether we over worried on this
> effect.
> 
> Or is there any other projects / ideas that potentially can enlarge forbid
> zero pages to more contexts?

I think it was shown that zeropages can be used to build covert channels 
(similar to memory deduplciation, because it effectively is memory 
deduplication). It's mentioned as a note in [1] under VII. A. ("Only 
Deduplicate Zero Pages.")


[1] https://www.ndss-symposium.org/wp-content/uploads/2022-81-paper.pdf

> 
>> 3) It would be possible to optimize even without the huge zeropage, by
>>     using a PMD marker.
> 
> This patch doesn't need huge zeropage being exist.

Yes, and for that reason I think it may perform worse than what we 
already have in some cases. Instead of populating a single PMD you'll 
have to fill a full PTE table.

> 
>> 4) It would be possible to optimize even on the PUD level using a PMD
>>     marker.
> 
> I think 3+4 is in general an interesting idea on using pte markers on
> higher than pte levels, but that needs more changes.
> 
> Firstly, keep using pte markers is somehow preallocating the pgtables, so a
> side effect of it could be speeding up future faults because they'll all
> split into pmd locks and read doesn't need to fault at all, only writes.
> 
> Imagine when you hit a page fault on a pmd marker, it means you'll need to
> spread that "marker" information to child ptes and you must - it moves the
> slow operation of WP into future page faults in some way.  In some cases
> (I'd say, most cases..) that's not wanted.  The same to PUDs.

Right, but user space already has that option (see below).

> 
>>
>> Especially when uffd-wp'ing large ranges that are possibly all unpopulated
>> (thinking about the existing VM background snapshot use case either with
>> untouched memory or with things like free page reporting), we might neither
>> be reading or writing that memory any time soon.
> 
> Right, I think that's a trade-off. But I still think large portion of
> totally unpopulated memory should be rare case rather than majority, or am
> I wrong?  Not to mention that requires a more involved changeset to the
> kernel.
> 
> So what I proposed here is the (AFAIU) simplest solution towards providing
> such a feature in a complete form.  I think we have chance to implement it
> in other ways like pte markers, but that's something we can work upon, and
> so far I'm not sure how much benefit we can get out of it yet.
> 

What you propose here can already be achieved by user space fairly 
easily (in fact, QEMU implementation could be further sped up using 
MADV_POPULATE_READ). Usually, we only do that when there are very good 
reasons to (performance).

Using PTE markers would provide a real advantage IMHO for some users 
(IMHO background snapshots), where we might want to avoid populating 
zeropages/page tables as best as we can completely if the VM memory is 
mostly untouched.

Naturally, I wonder if UFFD_FEATURE_WP_ZEROPAGE is really worth it. Is 
there is another good reason to combine the populate zeropage+wp that I 
am missing (e.g., atomicity by doing both in one operation)?

-- 
Thanks,

David / dhildenb

