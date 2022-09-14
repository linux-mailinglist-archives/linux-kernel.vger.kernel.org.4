Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53185B85F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiINKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742540558
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663150155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRy6NMXVqAdLaaelo9/KHPKagVual2K79eNRneTqSHA=;
        b=EyQ9du6xRmFX7YB9MtOcw0ux1gbmZFbMa870f0cREnvSY2IrABqTEJKu1seMY5Z6ZTAgA0
        BF8Gqmj8ht3sJ0Koqz7ckcfPs18wTEGvkTactiV0Ta1+Js/OVzQMzhGoQ1VJL8JT+taLEi
        aBjTYbA9zjRHMMROLQ6qkJecchuWkfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-JprccLpxP4GI8SHyI1Jy3Q-1; Wed, 14 Sep 2022 06:09:13 -0400
X-MC-Unique: JprccLpxP4GI8SHyI1Jy3Q-1
Received: by mail-wm1-f70.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so1982835wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tRy6NMXVqAdLaaelo9/KHPKagVual2K79eNRneTqSHA=;
        b=PKhM4nOrMfePV+OoAG6ZW6s5mDBs8zrhIkGDtUvF04cPEId9rRjoxHsWo1u7bI8eSb
         XfLx7Vvbr0E1ARd+LfwEODXMcn8LINSIKxfKg5s9WGTi68DEdEy7i0sh7GH9BcWTaJCi
         ujCEd367Necv171zwnFHPmCIc8VN2cYfdb3eBT6Bk/+wYZSTUOJ1JkLDlGusgPapiWkV
         4hjqjm3YOFhmr65mnKnXjnLmJR9WCh2S7saj8eMg8yPiSowlPUsNruSGTGRuZx0gDCkS
         X3rAK1vU13+bpaYjRtIY0QRe2Kd76q68XutUlHE+vw1uhhX2c1RF5h+wJd/Fa+NJNv5I
         q3Vg==
X-Gm-Message-State: ACgBeo2BEmNuX+jVDj+zCMldb6gEhFM4NvmBULdw/DmSe1vhvbGpcYd6
        6fiyDLYemr9xp5LTYJHOaHJiO6GeVkxd1nI8Q10gl0U66y7iHaJ9FOjBkdLv5uZTDUpOmDFmS+s
        r7vj27UBC5jWz4lK5HWUsvYhi
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr20947372wrb.581.1663150152762;
        Wed, 14 Sep 2022 03:09:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6mUE0OyqSCSCmqM4mki5eCHDSHXk9TWtC5yJAaN4TbupXuzHkSxN3OSWGQKjEVNQGAFCI3Hw==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr20947344wrb.581.1663150152500;
        Wed, 14 Sep 2022 03:09:12 -0700 (PDT)
Received: from [10.119.22.46] ([89.101.193.71])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00228dff8d975sm12603941wri.109.2022.09.14.03.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:09:11 -0700 (PDT)
Message-ID: <35003c8f-d777-b2b1-4d48-20f90ba66994@redhat.com>
Date:   Wed, 14 Sep 2022 12:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] hmm-tests: Fix migrate_dirty_page test
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org
References: <20220913052203.177071-1-apopple@nvidia.com>
 <53390539-cfa9-7498-5b69-8fb8b307182d@redhat.com>
 <878rmnn0jq.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <878rmnn0jq.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.22 10:20, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 13.09.22 07:22, Alistair Popple wrote:
>>> As noted by John Hubbard the original test relied on side effects of the
>>> implementation of migrate_vma_setup() to detect if pages had been
>>> swapped to disk or not. This is subject to change in future so
>>> explicitly check for swap entries via pagemap instead. Fix a spelling
>>> mistake while we're at it.
>>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>> Fixes: 5cc88e844e87 ("selftests/hmm-tests: add test for dirty bits")
>>> ---
>>>    tools/testing/selftests/vm/hmm-tests.c | 50 +++++++++++++++++++++++---
>>>    1 file changed, 46 insertions(+), 4 deletions(-)
>>> diff --git a/tools/testing/selftests/vm/hmm-tests.c
>>> b/tools/testing/selftests/vm/hmm-tests.c
>>> index 70fdb49b59ed..b5f6a7dc1f12 100644
>>> --- a/tools/testing/selftests/vm/hmm-tests.c
>>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>>> @@ -1261,9 +1261,47 @@ static int destroy_cgroup(void)
>>>    	return 0;
>>>    }
>>>    +static uint64_t get_pfn(int fd, uint64_t ptr)
>>> +{
>>> +	uint64_t pfn;
>>> +	int ret;
>>> +
>>> +	ret = pread(fd, &pfn, sizeof(ptr),
>>> +		(uint64_t) ptr / getpagesize() * sizeof(ptr));
>>> +	if (ret != sizeof(ptr))
>>> +		return 0;
>>> +
>>> +	return pfn;
>>> +}
>>> +
>>> +#define PAGEMAP_SWAPPED (1ULL << 62)
>>> +
>>> +/* Returns true if at least one page in the range is on swap */
>>> +static bool pages_swapped(void *ptr, unsigned long pages)
>>> +{
>>> +	uint64_t pfn;
>>> +	int fd = open("/proc/self/pagemap", O_RDONLY);
>>> +	unsigned long i;
>>> +
>>> +	if (fd < 0)
>>> +		return false;
>>> +
>>> +	for (i = 0; i < pages; i++) {
>>> +		pfn = get_pfn(fd, (uint64_t) ptr + i * getpagesize());
>>> +
>>> +		if (pfn & PAGEMAP_SWAPPED) {
>>> +			close(fd);
>>> +			return true;
>>> +		}
>>
>> We do have pagemap_get_entry() in vm_util.c to query the pagemap entry.
> 
> Thanks. I'd missed that, although `grep pagemap
> tools/testing/selftests/vm` suggests I'm not the first to follow a
> tradition of open-coding this :-)
> 
> But there's no need to perpetuate that tradition, so will redo this to
> use vm_util.c instead.

Yeah, we just recently factored stuff out into there. I'll be factoring 
out more in my upcoming tests from the madv_populate tests.

-- 
Thanks,

David / dhildenb

