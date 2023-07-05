Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62631748F02
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjGEUiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGEUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBC19A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688589448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aNSOaaUBYCJKouQNnFhzum9bTqqbGqw38WYLNiNCbU=;
        b=LETH1TqCO06IJINxqDRNCl1yU5rQ8CiMedl1U2GQ9QQjjDv9CVfN+00cfScWMXb6W0moCb
        l2XfCwcppG7M8//griPw34IbwfEiRwBBPqp8WQf4ByOd9AaW9BSg7TDhSwCrJYmud/mzQ7
        hBsLSIKiD2C7H7KxcxKkeQ5jjG74MdY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-gH2FBvmaP3yF2UaOhR2vvA-1; Wed, 05 Jul 2023 16:37:27 -0400
X-MC-Unique: gH2FBvmaP3yF2UaOhR2vvA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3141325af78so4634716f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589446; x=1691181446;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aNSOaaUBYCJKouQNnFhzum9bTqqbGqw38WYLNiNCbU=;
        b=TNTt9mMHnuCFP9hbSluPj3cJ4chnu7mxJbwdPLF46gtz5TnRdAn3Znf4n5rIs9bqdI
         brZjpBQBp9hQ6/8HKFRXla7Oj2GkDTQNVuXx3HgwBMTo+WjqbQPHI+SyK7FVQXsqxS+0
         6LdqVf3/GznhDtR9ysHlS+gUv5a/4QBDjJ6QV73ZdiefFZgaDQZndtfoGzl1EMWUTRDf
         VwWORNVQwkaTfMR7xnUasCyBzeGZ4F+dyUDsY8D80nsWL1AYiclGfrFADGVpwBkOahFG
         KcySQAdJu20aClX84N1GR31+oNUEsjy5Br3WYluM2TZW3durwUc3fRuoWE4gCsWdJzaj
         2qXw==
X-Gm-Message-State: ABy/qLb9owDsGhyWL6zHk1LK0hH0tm1k2Zyqukbhx7oEAjtqtNxkrIcB
        KTwfa6LshnvrXcRVa2Bjo/H1L9C2IVQOD7V2FvqE0yWb844zqkjnFDU9T9invz1FO+gAbAOhFPq
        pKde3K4tqJ94cvJQ5ryU6Uqd9
X-Received: by 2002:a5d:4303:0:b0:314:2e77:afec with SMTP id h3-20020a5d4303000000b003142e77afecmr11354889wrq.57.1688589446258;
        Wed, 05 Jul 2023 13:37:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlpk4/V1Yhf33Ofe9H74MrNLKgyUAvRE41pG4SyoZ+RXBrxrqIG4eJDpP22mgxnUCAE+YvFA==
X-Received: by 2002:a5d:4303:0:b0:314:2e77:afec with SMTP id h3-20020a5d4303000000b003142e77afecmr11354843wrq.57.1688589445769;
        Wed, 05 Jul 2023 13:37:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:1c00:e2b1:fc33:379b:a713? (p200300cbc71a1c00e2b1fc33379ba713.dip0.t-ipconnect.de. [2003:cb:c71a:1c00:e2b1:fc33:379b:a713])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d45c7000000b003141a3c4353sm17225645wrs.30.2023.07.05.13.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 13:37:24 -0700 (PDT)
Message-ID: <d3245a2a-285b-6dfe-5dd3-05fdeb308e18@redhat.com>
Date:   Wed, 5 Jul 2023 22:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
 <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZKXRsQC8ufiebDGu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.23 22:25, Peter Xu wrote:
> On Wed, Jul 05, 2023 at 10:22:27AM -0700, Suren Baghdasaryan wrote:
>> On Wed, Jul 5, 2023 at 10:16 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 05.07.23 19:12, Suren Baghdasaryan wrote:
>>>> A memory corruption was reported in [1] with bisection pointing to the
>>>> patch [2] enabling per-VMA locks for x86.
>>>> Disable per-VMA locks config to prevent this issue while the problem is
>>>> being investigated. This is expected to be a temporary measure.
>>>>
>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
>>>> [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com
>>>>
>>>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>>>> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
>>>> Reported-by: Jacob Young <jacobly.alt@gmail.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
>>>> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>> ---
>>>>    mm/Kconfig | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 09130434e30d..0abc6c71dd89 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
>>>>           def_bool n
>>>>
>>>>    config PER_VMA_LOCK
>>>> -     def_bool y
>>>> +     bool "Enable per-vma locking during page fault handling."
>>>>        depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
>>>> +     depends on BROKEN
>>>>        help
>>>>          Allow per-vma locking during page fault handling.
>>>>
>>> Do we have any testing results (that don't reveal other issues :) ) for
>>> patch #1? Not sure if we really want to mark it broken if patch #1 fixes
>>> the issue.
>>
>> I tested the fix using the only reproducer provided in the reports
>> plus kernel compilation and my fork stress test. All looked good and
>> stable but I don't know if other reports had the same issue or
>> something different.
> 
> The commit log seems slightly confusing.  It mostly says the bug was still
> not solved, but I assume patch 1 is the current "fix", it's just not clear
> whether there's any other potential issues?
> 
> According to the stable tree rules:
> 
>   - It must fix a problem that causes a build error (but not for things
>     marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>     security issue, or some "oh, that's not good" issue.  In short, something
>     critical.
> 
> I think it means vma lock will never be fixed in 6.4, and it can't (because
> after this patch it'll be BROKEN, and this patch copies stable, and we
> can't fix BROKEN things in stables).
> 
> Totally no problem I see, just to make sure this is what you wanted..
> 
> There'll still try to be a final fix, am I right?  As IIRC allowing page
> faults during fork() is one of the major goals of vma lock.

At least not that I am aware of (and people who care about that should 
really work on scalable fork() alternatives, like that io_uring fork() 
thingy).

My understanding is that CONFIG_PER_VMA_LOCK wants to speed up page 
concurrent page faults *after* fork() [or rather, after new process 
creation], IOW, when we have a lot of mmap() activity going on while 
some threads of the new process are already active and don't actually 
touch what's getting newly mmaped.

-- 
Cheers,

David / dhildenb

