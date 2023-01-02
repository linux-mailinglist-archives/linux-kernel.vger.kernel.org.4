Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F565B47C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjABPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjABPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:54:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF28AB82
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672674805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08dCYsa5Ayalb0WHzc9Dc+dPt0AFb2C2DyR+UOE8zaY=;
        b=bP892EV8QTT/5NiNugqgRK/SgdLQD23Mz4DhSqExfmGEp7CBd720jOJvuomK7n1Ih713hV
        YKBbqtqBLfQvh/EtDPsp4YPfeSpxavVilfIBB297t4s/4juxAuuUF5OOyOZCh6dm9ZSVIw
        hJLC9Lfu8PEgEO1HQr04FzV61tacbOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-IAxPvY-KOxmyPGdQE6Whcw-1; Mon, 02 Jan 2023 10:53:22 -0500
X-MC-Unique: IAxPvY-KOxmyPGdQE6Whcw-1
Received: by mail-wm1-f71.google.com with SMTP id c23-20020a7bc857000000b003d97c8d4935so11000469wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08dCYsa5Ayalb0WHzc9Dc+dPt0AFb2C2DyR+UOE8zaY=;
        b=6j7FYiuya6916uN7F4qaIiQANrqcugmU6Gp5DKZcywLUnPaGP8+QADGK08l/OOyt8R
         nFEKbNbEg3FmgmCT6xjFY0MQriaPIp1l5NtYH1vMJMlyEK1XRYURas2Y8vKCTpev2CmV
         AEsp31CFZYpo48ifDCs4KkSLGbN4dbF4XcRbqxeZw71hc+SULhnJD/6n/mlT2rOC1e+S
         QacYglAQ9Ah16IKHnXcQPUSa1ZMTUOXaOgZi7112wGH+oFOnx6jYaiEAMKSfwH1nhzqQ
         Q3RhfzlBhcg6DzttLjb/aaYdl16EehtBj16E5ED0Wg2yTSRbQtIsD49wnpz1saBmGMnv
         WPcg==
X-Gm-Message-State: AFqh2kqxgUc1X/Yq5V/4vFZBLTmrg0LqEoj92yXdGSMJZl7Teh9jw/cV
        LR64mpP5/aYczcomByYl7gn+1nUjhuTbUpC1FXYrFCCpqvNsGsibpBZxp8tHNI2dMnGVAQPO0Td
        TDXTbyAbi0PvqqtZ+K+3HYXVb
X-Received: by 2002:adf:cc8e:0:b0:273:75d2:8d01 with SMTP id p14-20020adfcc8e000000b0027375d28d01mr23779219wrj.26.1672674801691;
        Mon, 02 Jan 2023 07:53:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvsKmOyCmw5BR6SbNL6IHnflKGvVcnU44NWhqj6A8qfHLRPHgTXjmjL32Q503GqLTl/iAl4Zg==
X-Received: by 2002:adf:cc8e:0:b0:273:75d2:8d01 with SMTP id p14-20020adfcc8e000000b0027375d28d01mr23779202wrj.26.1672674801440;
        Mon, 02 Jan 2023 07:53:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d618d000000b002425dc49024sm28834869wru.43.2023.01.02.07.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:53:21 -0800 (PST)
Message-ID: <54da9c76-a506-0acd-3f97-60a0cce87c8a@redhat.com>
Date:   Mon, 2 Jan 2023 16:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <f132891530423f8bb72fde8169279b1c5967ec40.1672670177.git.lstoakes@gmail.com>
 <3a4fbe90-b46e-aa49-9866-e2b0cf6de38d@redhat.com> <Y7L9JfyQrwIRVo2A@lucifer>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7L9JfyQrwIRVo2A@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.23 16:49, Lorenzo Stoakes wrote:
> On Mon, Jan 02, 2023 at 04:34:14PM +0100, David Hildenbrand wrote:
>> On 02.01.23 15:44, Lorenzo Stoakes wrote:
>>> Add a test to assert that we can mremap() and expand a mapping starting
>>> from an offset within an existing mapping. We unmap the last page in a 3
>>> page mapping to ensure that the remap should always succeed, before
>>> remapping from the 2nd page.
>>>
>>> This is additionally a regression test for the issue solved in "mm, mremap:
>>> fix mremap() expanding vma with addr inside vma" and confirmed to fail
>>> prior to the change and pass after it.
>>>
>>> Finally, this patch updates the existing mremap expand merge test to check
>>> error conditions and reduce code duplication between the two tests.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>>> ---
>>>    tools/testing/selftests/vm/mremap_test.c | 115 ++++++++++++++++++-----
>>>    1 file changed, 93 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
>>
>>
>> ...
>>
>>> +
>>> +	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
>>> +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +
>>> +	if (start == MAP_FAILED) {
>>> +		ksft_print_msg("mmap failed: %s\n", strerror(errno));
>>
>> I'd
>>
>> 	ksft_test_result_fail(...)
>> 	return;
>>
>>> +		goto out;
>>> +	}
>>> +
>>> +	munmap(start + page_size, page_size);
>>> +	remap = mremap(start, page_size, 2 * page_size, 0);
>>> +	if (remap == MAP_FAILED) {
>>> +		ksft_print_msg("mremap failed: %s\n", strerror(errno));
>>> +		munmap(start, page_size);
>>> +		munmap(start + 2 * page_size, page_size);
>>> +		goto out;
>>
>> dito
>>
>> 	ksft_test_result_fail(...)
>> 	...
>> 	return;
>>
>>> +	}
>>> +
>>> +	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
>>> +	munmap(start, 3 * page_size);
>>> +
>>> +out:
>>
>> then you can drop the out label.
>>
> 
> I have to disagree on this, to be consistent with the other tests the
> failure messages should include the test name, and putting the
> ksft_test_result_fail("test name") in each branch as well as the error
> message would just be wilful duplication.
> 
> I do think it's a pity C lacks mechanisms such that gotos are sometimes
> necessary, but I can only right so many wrongs in this patch :)
> 

Let's agree to disagree ;) Too bad we don't have prefix push/pop 
functionality as we have in other similar testing frameworks -- to avoid 
exactly that duplication.

[...]

>> I'd simply use a global variable, same applies for page_size. But passing it
>> around is also ok.
>>
> 
> I am trying to keep things consistent with what's gone before in this code,
> and given page_size is being passed around I think the 'when in Rome'
> principle applies equally to passing the fp around I think.

Other tests we have handle it "easier". :)

-- 
Thanks,

David / dhildenb

