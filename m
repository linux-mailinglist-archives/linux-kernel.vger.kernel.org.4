Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971BC5FAF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJKJgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJKJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3039A80F7F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665480971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvTLEvqcj3p3d1KXb3PDcuwC6nozluzlm8I3s02xoko=;
        b=Qp4qPb/f3dv9y8ANgvsEJTYkPREX+Z54352RxYtD2K8C2FSFCHM7jG7vcc+1LLEkvhV/kh
        IrW9NFAB6KS7TXwbzRV7Fzxy1Wrs6C9YGYf2HY6v6+vy2yHxydFidSdg2QpsJFcXk0Qosh
        ljP9WIA1buC6xVsvNFnsE/p0tLa1lM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-gNf9i6RTMQiUhp_b_9topA-1; Tue, 11 Oct 2022 05:36:09 -0400
X-MC-Unique: gNf9i6RTMQiUhp_b_9topA-1
Received: by mail-wm1-f69.google.com with SMTP id h129-20020a1c2187000000b003bf635eac31so5153903wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvTLEvqcj3p3d1KXb3PDcuwC6nozluzlm8I3s02xoko=;
        b=enJO2bkFeQjo+bwn6cF80kdJlWikaVAaxPeIPDQYPvPDybj6F5bTyWXGDJ9wJEBrzU
         4Rs1WCJ6f3nmdm5EjnB5TnIDyR0PBZrFA5Y4CHp73wlj7UkEQhMGtg+YEUjzag1fzCry
         5Kv48Z8PItRGG8RDgddhlyapSTGbagEzX0gmwhwJyuo/JR9qsk4TT+Di/uIhhDTt8bDX
         BCQ1hhpQ8hG0nclPXxKgZAGcVc63KbByHWtjQ6zznc/nk6Oq2yFptPUlq//Fh87pmBw2
         t/yxFD6VeamhMPGnC45eqwOY3MEYrOrHOYo0EIkdUVQBeUlA8iVYB7aL5ijYROJbk8ns
         lxgA==
X-Gm-Message-State: ACrzQf2hkuEMscrNa/sx4GCTVHHRFgFqmD2JM+EpXmDhgdyIkY0p03a6
        6dOBDYOsz8NfZoZix0XNxuopxkwOdCD3kdzYGxiI3oyAZlVvBk+Gszexk0/Syuy6peAu7tq90zI
        IiZj2EmYv8+gpWT6EI+iGq/db
X-Received: by 2002:adf:e88c:0:b0:22e:2e7c:54a5 with SMTP id d12-20020adfe88c000000b0022e2e7c54a5mr13859519wrm.245.1665480968719;
        Tue, 11 Oct 2022 02:36:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM73WSNxypt6hIcD2iNb+bFCQxuzh5DpPW3Sjfby+ihYilYt4z//1nawXaP5Sy+GMe5DeUksPw==
X-Received: by 2002:adf:e88c:0:b0:22e:2e7c:54a5 with SMTP id d12-20020adfe88c000000b0022e2e7c54a5mr13859509wrm.245.1665480968375;
        Tue, 11 Oct 2022 02:36:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6900:f110:6527:aa46:a922? (p200300cbc7096900f1106527aa46a922.dip0.t-ipconnect.de. [2003:cb:c709:6900:f110:6527:aa46:a922])
        by smtp.gmail.com with ESMTPSA id w8-20020adfee48000000b002205a5de337sm10870198wro.102.2022.10.11.02.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 02:36:07 -0700 (PDT)
Message-ID: <cf327d9f-eb29-9107-7fcb-6ae510c2abee@redhat.com>
Date:   Tue, 11 Oct 2022 11:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/5] memblock tests: add range tests for
 memblock_alloc_exact_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1664753534.git.remckee0@gmail.com>
 <c73a6fd7fc3fa4529a6e444b9602d9c63ded91fd.1664753534.git.remckee0@gmail.com>
 <b44eee1a-0d61-f5bb-7b0c-a01f13a0b297@redhat.com>
 <20221011041910.GA7782@sophie>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221011041910.GA7782@sophie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.22 06:19, Rebecca Mckeever wrote:
> On Mon, Oct 10, 2022 at 01:16:03PM +0200, David Hildenbrand wrote:
>> On 03.10.22 01:41, Rebecca Mckeever wrote:
>>> Add tests for memblock_alloc_exact_nid_raw() that are very similar to
>>> the range tests for memblock_alloc_try_nid_raw().
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>> ---
>>>    tools/testing/memblock/Makefile               |    2 +-
>>>    tools/testing/memblock/main.c                 |    2 +
>>>    .../memblock/tests/alloc_exact_nid_api.c      | 1208 +++++++++++++++++
>>>    .../memblock/tests/alloc_exact_nid_api.h      |    9 +
>>>    4 files changed, 1220 insertions(+), 1 deletion(-)
>>>    create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
>>>    create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h
>>>
>>> diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
>>> index 246f7ac8489b..2310ac4d080e 100644
>>> --- a/tools/testing/memblock/Makefile
>>> +++ b/tools/testing/memblock/Makefile
>>> @@ -7,7 +7,7 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
>>>    LDFLAGS += -fsanitize=address -fsanitize=undefined
>>>    TARGETS = main
>>>    TEST_OFILES = tests/alloc_nid_api.o tests/alloc_helpers_api.o tests/alloc_api.o \
>>> -		  tests/basic_api.o tests/common.o
>>> +		  tests/basic_api.o tests/common.o tests/alloc_exact_nid_api.o
>>>    DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
>>>    OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
>>>    EXTR_SRC = ../../../mm/memblock.c
>>> diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
>>> index 4ca1024342b1..278f9dec5008 100644
>>> --- a/tools/testing/memblock/main.c
>>> +++ b/tools/testing/memblock/main.c
>>> @@ -3,6 +3,7 @@
>>>    #include "tests/alloc_api.h"
>>>    #include "tests/alloc_helpers_api.h"
>>>    #include "tests/alloc_nid_api.h"
>>> +#include "tests/alloc_exact_nid_api.h"
>>>    #include "tests/common.h"
>>>    int main(int argc, char **argv)
>>> @@ -12,6 +13,7 @@ int main(int argc, char **argv)
>>>    	memblock_alloc_checks();
>>>    	memblock_alloc_helpers_checks();
>>>    	memblock_alloc_nid_checks();
>>> +	memblock_alloc_exact_nid_checks();
>>>    	return 0;
>>>    }
>>
>>
>> memblock_alloc_exact_nid_raw(NUMA_NO_NODE) behaves exactly the way
>> memblock_alloc_try_nid_raw(NUMA_NO_NODE) behaves -- which is essentially
>> memblock_alloc_raw().
>>
>> So do we really need a separate set of tests for these?
>>
> Instead of a separate set of tests, I could add a flag for
> memblock_alloc_exact_nid_raw() to test_flags so that the range tests in
> alloc_nid_api.c could be run with that flag. Do you think I should do
> that, or omit tests for memblock_alloc_exact_nid_raw(NUMA_NO_NODE)
> altogether?

Good question. From an API point of view, it makes sense to test that 
API somehow. With implementation in mind, it doesn't make too much sense 
to test it twice.

Whatever you prefer :) Just wanted to point out that separate tests 
don't make sense -- using a flag would be cleaner.

-- 
Thanks,

David / dhildenb

