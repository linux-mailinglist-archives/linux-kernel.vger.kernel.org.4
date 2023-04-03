Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB46D5117
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjDCTHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDCTHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8272701
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680548790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o312F+8qQ3csr6xoClPXHStqrqRF/NPJb7KBcI61xtc=;
        b=O464ThtgQvDkQU5NYmfnrWaps7EaQ0ONLeU4Sc32h1VWS3xzWzolINM50Cmnv+AjcMEE4w
        e9hMIEvHyca1bW1YWpwmKYazbxRBBAtOVuYTylol4l2Sq37742RZV8m1bpIgjsbwTyS6NT
        FZgu8I7ZRz0h0ZcJPW7LUQP4/yUFteU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-qSuO7SQwNqescrrGDnrtvg-1; Mon, 03 Apr 2023 15:06:29 -0400
X-MC-Unique: qSuO7SQwNqescrrGDnrtvg-1
Received: by mail-wm1-f72.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so15164457wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 12:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680548788;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o312F+8qQ3csr6xoClPXHStqrqRF/NPJb7KBcI61xtc=;
        b=YogciNSaSz8VIQJiF+RgO3C0bLYaAesJyvMOn1VW1iAEe/0cwxUzjY2d95x6shUxCK
         yoPVW0fGxyHYRLfWncS4BKRFKy38dZhDQwBKZbw1G0q4l4IZKBJ20Wha1hMLLBCFVNpZ
         jdzqhcmadgKxcnnfNLSzPT+lUTwuCsN1qUWhtY/LdYNvdxKeaxww6L2u5xORzdUN4qxD
         ngtzr6RF+8zJ6rufU+IEOImrf/WhzQXB5rv1K0ySv0c8rJHd8c5sTm97G9tCcwYDFprz
         2ts9QKtvqhwgwhkpftCCEgo4wtizWmRNCTS99PfO38RIxYLFSytW5ApfOY53Q8HwGoFy
         xS1g==
X-Gm-Message-State: AAQBX9dEFJGB3NRK6g6q/vPQBbadDD7Rk3fSChF/0RP3yUqfAYkUH3in
        03zwfc68okSTbuPjBVf0uPjCPKJ5TWyCY+OfF3hhNiYOZpz/vP5RADoFaqJ3a8Yo+nBOuX8o0dY
        p50ODRD7HKPLjHMMuqrVYAhol
X-Received: by 2002:a5d:6710:0:b0:2e3:a038:7870 with SMTP id o16-20020a5d6710000000b002e3a0387870mr122126wru.40.1680548788385;
        Mon, 03 Apr 2023 12:06:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bf2K9RhlECDumNV6UhMWL27ufSYHSPWnXBF4+HoFPMkwvRMlQkYdnLEfRr/e6GBdIDL0MKbQ==
X-Received: by 2002:a5d:6710:0:b0:2e3:a038:7870 with SMTP id o16-20020a5d6710000000b002e3a0387870mr122113wru.40.1680548788048;
        Mon, 03 Apr 2023 12:06:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b002cfefa50a8esm10380139wrs.98.2023.04.03.12.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 12:06:27 -0700 (PDT)
Message-ID: <b282519e-d43d-026c-3f96-4d7fb287d96b@redhat.com>
Date:   Mon, 3 Apr 2023 21:06:26 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 16/29] selftests/mm: UFFDIO_API test
In-Reply-To: <ZCsCRRdnbeNgcSlq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.23 18:43, Peter Xu wrote:
> On Mon, Apr 03, 2023 at 09:59:50AM +0200, David Hildenbrand wrote:
>> There is ksft_print_msg, ksft_test_result, ksft_test_result_fail, ... do we
>> maybe want to convert properly to ksft while already at it?
> 
> Yes, I started with trying to use that but found that there're not a lot of
> things that I can leverage.
> 
> Starting with ksft_set_plan() - I think this is something we call first. I
> want the current unit test to skip everything if UFFD API test failed here,
> then I need to feed in a dynamic number of "plan" into ksft_set_plan().
> But I never know after I ran the 1st test..

In cow.c I did that. Getting the number of tests right can be 
challenging indeed.

Basic "feature availability" checks would go first (is uffd even 
around?), and depending on that you can set the plan.

For everything else, you can skip instead of test, so it will still be 
accounted towards the plan.

> 
> I can call ksft_set_plan() later than this, but it misses a few tests which
> also looks weird.

Yeah, it would be nice to simply make ksft_set_plan() optional. For 
example, make ksft_print_cnts() skip the comparison if ksft_plan == 0. 
At least ksft_exit_skip() handles that already in a descend way (below).

> 
> It also seems to not really help anything at all and not obvious to use.
> E.g. ksft_finished() will reference ksft_plan then it'll trigger
> ksft_exit_fail() but here I want to make it SKIP if the 1st test failed
> simply because the kernel probably doesn't have CONFIG_USERFAULTFD.

You'd simply do that availability check first and then use 
ksft_exit_skip() in case not available I guess.

> 
> Another example: I never figured what does x{fail|pass|skip} meant in the
> header..  e.g. ksft_inc_xfail_cnt() is used nowhere so I cannot reference
> either.  Then I don't know when I should increase them.

In cow.c I have the following flow:

ksft_print_header();
ksft_set_plan();
... tests ...
err = ksft_get_fail_cnt();
if (err)
	ksft_exit_fail_msg();
return ksft_exit_pass();

That gives me:

# [INFO] detected THP size: 2048 KiB
# [INFO] detected hugetlb size: 2048 KiB
# [INFO] detected hugetlb size: 1048576 KiB
# [INFO] huge zeropage is enabled
TAP version 13
1..190
...
# Totals: pass:87 fail:0 xfail:0 xpass:0 skip:103 error:0


I didn't use xfail or xpass so far, but what I understood is that these 
are "expected failures" and "expected passes". fail/pass/skip are 
straight forward. 
ksft_test_result_fail()/ksft_test_result_pass()/ksft_test_result_skip() 
are used to set them.

You'd do availability checks before ksft_set_plan() and fail with a 
ksft_exit_skip() if the kernel doesn't support it. Then, you'd just use 
ksft_test_result_fail()/ksft_test_result_pass()/ksft_test_result_skip().

> 
> In short, to make the unit test behave as expected, I figured I'll just
> write these few helpers and that's good enough for this unit test.  That
> takes perhaps 5 min anyway and isn't hugely bad for an unit test.
> 
> Then I keep the exit code matching kselftests (KSFT_SKIP, etc.).
> 
> What I can do here, though, is at least reuse the counters, e.g:
> 
>   ksft_inc_pass_cnt() / ksft_inc_fail_cnt()
> 
> There's no ksft_inc_skip_cnt() so, maybe, I can just reuse
> ksft_inc_xskip_cnt() assuming that counts "skip"s?
> 
> Let me know if you have better ideas, I'll be happy to switch in that case.

I guess once you start manually increasing/decreasing the cnt, you might 
be abusing the ksft framework indeed and are better off handling it 
differently :D

-- 
Thanks,

David / dhildenb

