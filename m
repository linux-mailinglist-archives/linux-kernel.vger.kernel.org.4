Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEF6BBE27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCOUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjCOUug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06411DB91
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678913391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6t0t5Iv2bD47uL2A95ufn+9Sx0u6l51PcnjxQgGARxw=;
        b=c3haIYcYcBX6mo3XIS7IFc05s8viSXWpbHX0gwyNx7bUZQQAfTwCgVrc6Xic9EGShQqVK4
        Q0UQ4ht934G9MaopSl+eX5CTKTp8rVUleLM6UBudERv5tujF3A1Tj6V8Txplu9lryuIn7U
        UUGbMNyk25Apj+1rhDHbbvyY8JqCGuo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-AdBYETmLO8ymtkZ6oqkjRA-1; Wed, 15 Mar 2023 16:49:48 -0400
X-MC-Unique: AdBYETmLO8ymtkZ6oqkjRA-1
Received: by mail-wm1-f69.google.com with SMTP id bi21-20020a05600c3d9500b003e836e354e0so1196095wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6t0t5Iv2bD47uL2A95ufn+9Sx0u6l51PcnjxQgGARxw=;
        b=VLe7IzLFlaj9FSIRN1FAlmziXHUPqdDeEK3LhudG1vXnTmc072H/J0fH1gIbNwLE3d
         ZtkoS4vO69kByuMdvUAVzSKksWZ0SR48vyFphUN/2j62qqImWoAwJi8J+uxIkGkwhl45
         LDa3Ok59BE4hHJLyT0m/vrsiAeCWDFqRkshLqKEcDdZb7QN8ZxgI7BAb4LzO8HEodE8F
         66z2bqKienaeqDwyEveWOUl1y6aQQuuURIf2gjQ8eDbgXcoRG6sBS8TdsuscRiH8hcpU
         W6FMWdtl26r1irgxaUfkRgkxVw1GwvVQHdKZSJVqsqlkFUsQjCk+qq7NaWHq9204i11A
         zArw==
X-Gm-Message-State: AO0yUKXJ3LHJjiFxR2pHk2TjScYRUWyZa+YJH7RBI1v8ZHi9LrbQraRT
        JcOoVyxUpbKGbmGWjAQWunoqSNQEKRAsSbeNVrru5xdXvmrnvCiS0TFp8PZ1jMUdM76Er2tDKCM
        jFmI0qTZCY1Lyo/QEEW5tOvPS
X-Received: by 2002:adf:fc87:0:b0:2cb:5b58:74a with SMTP id g7-20020adffc87000000b002cb5b58074amr3005978wrr.56.1678913387487;
        Wed, 15 Mar 2023 13:49:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set/f3Yj/rHER0QrCQC6NJ2Yg4faXcicmXXK9BRt3t8AK+QzAEoTQFerFOG9rD+XVbf7VoSg1lg==
X-Received: by 2002:adf:fc87:0:b0:2cb:5b58:74a with SMTP id g7-20020adffc87000000b002cb5b58074amr3005964wrr.56.1678913387123;
        Wed, 15 Mar 2023 13:49:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bg7-20020a05600c3c8700b003eb2e33f327sm8517638wmb.2.2023.03.15.13.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 13:49:46 -0700 (PDT)
Message-ID: <2164b29f-ab4e-c08d-58e8-adccdb9124ae@redhat.com>
Date:   Wed, 15 Mar 2023 21:49:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V5 0/2] selftests: KVM: Add a test for eager page
 splitting
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
References: <20230131181820.179033-1-bgardon@google.com>
 <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
 <CABgObfYAStAC5FgJfGUiJ=BBFtN7drD+NGHLFJY5fP3hQzVOBw@mail.gmail.com>
 <CALzav=c-wtJiz9M6hpPtcoBMFvFP5_2BNYoY66NzF-J+8_W6NA@mail.gmail.com>
 <CABgObfYm6roWVR0myT5rHUWRe7k09TkXgZ7rYAr019QZ80oQXQ@mail.gmail.com>
 <199f404d-c08e-3895-6ce3-36b21514f487@redhat.com>
 <ZBIa7NQI4qRP6uON@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZBIa7NQI4qRP6uON@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 20:22, Sean Christopherson wrote:
> On Wed, Mar 15, 2023, Paolo Bonzini wrote:
>> On 3/15/23 13:24, Paolo Bonzini wrote:
>>> On Tue, Mar 14, 2023 at 5:00 PM David Matlack <dmatlack@google.com> wrote:
>>>> I wonder if pages are getting swapped, especially if running on a
>>>> workstation. If so, mlock()ing all guest memory VMAs might be
>>>> necessary to be able to assert exact page counts.
>>>
>>> I don't think so, it's 100% reproducible and the machine is idle and
>>> only accessed via network. Also has 64 GB of RAM. :)
>>
>> It also reproduces on Intel with pml=0 and eptad=0; the reason is due
>> to the different semantics of dirty bits for page-table pages on AMD
>> and Intel.  Both AMD and eptad=0 Intel treat those as writes, therefore
>> more pages are dropped before the repopulation phase when dirty logging
>> is disabled.
>>
>> The "missing" page had been included in the population phase because it
>> hosts the page tables for vcpu_args, but repopulation does not need it.
>>
>> This fixes it:
>>
>> -------------------- 8< ---------------
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH] selftests: KVM: perform the same memory accesses on every memstress iteration
>>
>> Perform the same memory accesses including the initialization steps
>> that read from args and vcpu_args.  This ensures that the state of
>> KVM's page tables is the same after every iteration, including the
>> pages that host the guest page tables for args and vcpu_args.
>>
>> This fixes a failure of dirty_log_page_splitting_test on AMD machines,
>> as well as on Intel if PML and EPT A/D bits are both disabled.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
>> index 3632956c6bcf..8a429f4c86db 100644
>> --- a/tools/testing/selftests/kvm/lib/memstress.c
>> +++ b/tools/testing/selftests/kvm/lib/memstress.c
>> @@ -56,15 +56,15 @@ void memstress_guest_code(uint32_t vcpu_idx)
>>   	uint64_t page;
>>   	int i;
>> -	rand_state = new_guest_random_state(args->random_seed + vcpu_idx);
>> +	while (true) {
>> +		rand_state = new_guest_random_state(args->random_seed + vcpu_idx);
> 
> Doesn't this partially defeat the randomization that some tests like want?  E.g.
> a test that wants to heavily randomize state will get the same pRNG for every
> iteration.  Seems like we should have a knob to control whether or not each
> iteration needs to be identical.

Yes, this wasn't really a full patch, just to prove what the bug is.

One possibility to avoid adding a new knob is to do something like:

unsigned iteration = 0;
rand_state = new_guest_random_state(args->random_seed
	+ vcpu_idx + iteration++);

Paolo

