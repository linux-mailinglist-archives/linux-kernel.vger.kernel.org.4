Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC66D6197
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjDDMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjDDMuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A204486
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680612532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3qiT0TK0SRhIz1YZD0OkKsTfa99dtrpFH3zJu9LCi8=;
        b=JF0uKUnSyi1p9HKd7a7UYXXpAdCtFD0WaFR3ZN7JbuGAqGSXMIWd2OPCi6tofJcBFJABDH
        wjmxR4g2neCv9/pynPoSR9eV9sJibYcX8XKvglqywVVixAmO12sxwa2tI8gQPN0gDGl6Km
        9FVB+NrlB3Xs6EIiK4M+YlWMh+ybk3Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-mQ4ukg90PYWFsBFKSipqxw-1; Tue, 04 Apr 2023 08:48:51 -0400
X-MC-Unique: mQ4ukg90PYWFsBFKSipqxw-1
Received: by mail-wm1-f71.google.com with SMTP id iv18-20020a05600c549200b003ee21220fccso16051626wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680612530;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3qiT0TK0SRhIz1YZD0OkKsTfa99dtrpFH3zJu9LCi8=;
        b=dPXtG4DLIRMyZkqt0GSETddm643gQ0OAx2EwGg2ue+3X5jYES0MXUGePvou6FAW4rs
         NlcrbRuBlaGYyx84DOE2oq6xBY2lRJ8ey7FYG01hIVMH5ChHi83BflcK9DVEQXtN8rIr
         6yqlr8WC6azD5BBBGC1MmqecvFrnTW3ON2YZ2IJ3Jkj7mklLcoRclUtz2Og36mB2RFao
         +TD9YyHb7LpqEREA9yx7uibJh1QG6cU3w3baSr4/xJrwUZLRdMNlvi9qhvfTg2JY3sJU
         nkyErkHgG2qFtVaQXzEFSI53UTbiA3bGUD3MQTZXi+r7Lz0J+wYjsXlncDSv6joTrIXI
         tL9A==
X-Gm-Message-State: AAQBX9dj+woUzh/WAFWhEnOqOZUnbdBDDy3AmwNA2/Ld0pryY7nE+9ln
        oWGji4iWl+uT7rCm2Ibi5rNKz3X8QY7ycpeh7OHagBV8M28SjXLm+rWqqg7Hs630qC6jul/Z6qr
        pMukfhb5Gyjq8Z/tnyWhr6Ep6
X-Received: by 2002:a5d:634b:0:b0:2cf:ef01:1def with SMTP id b11-20020a5d634b000000b002cfef011defmr1375955wrw.30.1680612530225;
        Tue, 04 Apr 2023 05:48:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YtLckYOuIk4nDtcNSZYcM/mUTR2i0YeiImBkQwV0Kjcdo6mXo+2IEc+GWC5ARjj0yV2RGzaQ==
X-Received: by 2002:a5d:634b:0:b0:2cf:ef01:1def with SMTP id b11-20020a5d634b000000b002cfef011defmr1375936wrw.30.1680612529861;
        Tue, 04 Apr 2023 05:48:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:b600:e63:6c3b:7b5d:f439? (p200300cbc709b6000e636c3b7b5df439.dip0.t-ipconnect.de. [2003:cb:c709:b600:e63:6c3b:7b5d:f439])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d474f000000b002d7a75a2c20sm12289754wrs.80.2023.04.04.05.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:48:48 -0700 (PDT)
Message-ID: <efcb43cb-b4da-dbfb-ce84-8a1f58500dbf@redhat.com>
Date:   Tue, 4 Apr 2023 14:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160752.3107283-1-peterx@redhat.com>
 <fcf40deb-e731-c257-fb77-7fcfddf623b1@redhat.com> <ZCsCRRdnbeNgcSlq@x1n>
 <b282519e-d43d-026c-3f96-4d7fb287d96b@redhat.com> <ZCs17E5frPyIoCOs@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 16/29] selftests/mm: UFFDIO_API test
In-Reply-To: <ZCs17E5frPyIoCOs@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.23 22:24, Peter Xu wrote:
> On Mon, Apr 03, 2023 at 09:06:26PM +0200, David Hildenbrand wrote:
>> On 03.04.23 18:43, Peter Xu wrote:
>>> On Mon, Apr 03, 2023 at 09:59:50AM +0200, David Hildenbrand wrote:
>>>> There is ksft_print_msg, ksft_test_result, ksft_test_result_fail, ... do we
>>>> maybe want to convert properly to ksft while already at it?
>>>
>>> Yes, I started with trying to use that but found that there're not a lot of
>>> things that I can leverage.
>>>
>>> Starting with ksft_set_plan() - I think this is something we call first. I
>>> want the current unit test to skip everything if UFFD API test failed here,
>>> then I need to feed in a dynamic number of "plan" into ksft_set_plan().
>>> But I never know after I ran the 1st test..
>>
>> In cow.c I did that. Getting the number of tests right can be challenging
>> indeed.
> 
> IMHO the major thing is not about not easy to set, it's about there's
> merely no benefit I can see of having that calculated at the start of a
> test.

Thinking about it, I believe I figured out why it makes sense. By 
specifying upfront how many tests you intend to run, the framework can 
check if you have the right number of pass/fail/skip during that test 
case execution.

This requires a different way of writing tests: each test case is 
supposed to trigger the exact same number of pass/fail/skip on each 
possible path.

If the numbers don't add up, it could indicate a possible bug in your 
tests. For example, not triggering a fail on some exit path. While your 
test execution might indicate "success", there is actually a hidden 
issue in your test.

I started using the framework for all new tests, because I think it's 
quite nice and at least things will be a bit consistent and possibly 
tests easier to maintain.


Having that said, I can understand why one might not want to use it. And 
that there are some things in there that might be improved.

> 
> There's one thing it can do, that is when calling ksft_finished() it can be
> used to know whether all tests are run, but sadly here we're calculating
> everything just to make it match.. so it loses its last purpose.. IMHO.
> 
>>
>> Basic "feature availability" checks would go first (is uffd even around?),
>> and depending on that you can set the plan.
>>
>> For everything else, you can skip instead of test, so it will still be
>> accounted towards the plan.
>>
>>>
>>> I can call ksft_set_plan() later than this, but it misses a few tests which
>>> also looks weird.
>>
>> Yeah, it would be nice to simply make ksft_set_plan() optional. For example,
>> make ksft_print_cnts() skip the comparison if ksft_plan == 0. At least
>> ksft_exit_skip() handles that already in a descend way (below).
>>
>>>
>>> It also seems to not really help anything at all and not obvious to use.
>>> E.g. ksft_finished() will reference ksft_plan then it'll trigger
>>> ksft_exit_fail() but here I want to make it SKIP if the 1st test failed
>>> simply because the kernel probably doesn't have CONFIG_USERFAULTFD.
>>
>> You'd simply do that availability check first and then use ksft_exit_skip()
>> in case not available I guess.
>>
>>>
>>> Another example: I never figured what does x{fail|pass|skip} meant in the
>>> header..  e.g. ksft_inc_xfail_cnt() is used nowhere so I cannot reference
>>> either.  Then I don't know when I should increase them.
>>
>> In cow.c I have the following flow:
>>
>> ksft_print_header();
>> ksft_set_plan();
>> ... tests ...
>> err = ksft_get_fail_cnt();
>> if (err)
>> 	ksft_exit_fail_msg();
>> return ksft_exit_pass();
>>
>> That gives me:
>>
>> # [INFO] detected THP size: 2048 KiB
>> # [INFO] detected hugetlb size: 2048 KiB
>> # [INFO] detected hugetlb size: 1048576 KiB
>> # [INFO] huge zeropage is enabled
>> TAP version 13
>> 1..190
>> ...
>> # Totals: pass:87 fail:0 xfail:0 xpass:0 skip:103 error:0
>>
>>
>> I didn't use xfail or xpass so far, but what I understood is that these are
>> "expected failures" and "expected passes". fail/pass/skip are straight
> 
> Yes, xfail can be expressed that way, but maybe not xpass?  Otherwise it's
> hard to identify what's the difference between xpass and pass, because IIUC
> pass also means "expected to pass".
> 

I'm a simple man, I use pass/fail/skip in my tests. But let's try 
figuring that out; a quick internet search (no idea how trustworthy) 
tells me that I was wrong about xpass:

xfail: expected failure
xpass: unexpected pass

it essentially is:

xfail -> pass
xpass -> fail

but with a slight semantic difference when thinking about a test case:

ret = mmap(0, 0 ...);
if (ret == MAP_FAILED) {
	XFAIL();
} else {
	XPASS();
}

vs.

ret = mmap(0, 0 ...);
if (ret == MAP_FAILED) {
	PASS();
} else {
	FAIL();
}

It's all inherited from other testing frameworks I think. And xpass 
seems to be completely unused and xfail mostly unused.

So I wouldn't worry about that and simply use pass/fail/skip.

>> forward.
>> ksft_test_result_fail()/ksft_test_result_pass()/ksft_test_result_skip() are
>> used to set them.
>>
>> You'd do availability checks before ksft_set_plan() and fail with a
>> ksft_exit_skip() if the kernel doesn't support it. Then, you'd just use
>> ksft_test_result_fail()/ksft_test_result_pass()/ksft_test_result_skip().
>>
>>>
>>> In short, to make the unit test behave as expected, I figured I'll just
>>> write these few helpers and that's good enough for this unit test.  That
>>> takes perhaps 5 min anyway and isn't hugely bad for an unit test.
>>>
>>> Then I keep the exit code matching kselftests (KSFT_SKIP, etc.).
>>>
>>> What I can do here, though, is at least reuse the counters, e.g:
>>>
>>>    ksft_inc_pass_cnt() / ksft_inc_fail_cnt()
>>>
>>> There's no ksft_inc_skip_cnt() so, maybe, I can just reuse
>>> ksft_inc_xskip_cnt() assuming that counts "skip"s?
>>>
>>> Let me know if you have better ideas, I'll be happy to switch in that case.
>>
>> I guess once you start manually increasing/decreasing the cnt, you might be
>> abusing the ksft framework indeed and are better off handling it differently
>> :D
> 
> I'm serious considering that to address your comment here, to show that I'm
> trying my best to use whatever can help in this test case. :) Here reusing

:) appreciated, but don't let my comments distract you. If you don't 
think ksft is a good fit (or any good), then don't use it.

-- 
Thanks,

David / dhildenb

