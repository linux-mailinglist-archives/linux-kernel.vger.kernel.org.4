Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FC5B693A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIMILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIMILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93754E01A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663056688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmFmooLgl+35+BTBj+s1lGG8DnrrIwlLQYKFeHvmKdo=;
        b=T28SoIL8n0oW3gY7V+Sq2q4lyoz6iCXK0MuUES1Ngr3z91G7t/3mqDC1cbyO98d2XOAjuN
        ODC7S3zXYLWmZ0XHkfmT9LLz1FoBmSmuvFlCSDVv00LCurcIVnDy6Na9FyMxztI/uSMhdd
        VH/La6juU1mInfgap+GUQl4eqhtkzZ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-OTMrP_WvPtaKwHC5sM0KDQ-1; Tue, 13 Sep 2022 04:11:27 -0400
X-MC-Unique: OTMrP_WvPtaKwHC5sM0KDQ-1
Received: by mail-wr1-f71.google.com with SMTP id a13-20020adfbc4d000000b00228631ddfafso2879157wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=JmFmooLgl+35+BTBj+s1lGG8DnrrIwlLQYKFeHvmKdo=;
        b=feFLuhKEjsuwBHVirGRAYwkKjAUcDSH4/RNjKdWS6+kYH+USBCKORwdkp4xKDG2FHC
         C2XjLtQMVq9l+cAYWyd0/ZxQnuYEOXyPfFs0PiOv47+HB8vsByjbppq90KJKsnqRIVZR
         beCpo7vgzOUlicsZUkEbvzLEKjZrh6ZqUg7X+cszc1qyv+yRGFJK4F04v1PKGRfYTNkw
         rxnFxDk0ro9U+av1OBJlMkSrWji69KowEPbOqIVh1vjaOEJZOk5dZBMcpu/B5wLxcxLR
         XtaB8RQEOb8N1W7old3CKcBbZ1tXzfMXEbniH4UX0loRCCk/MzAAvW/a2NtGidTNZZFa
         8ybw==
X-Gm-Message-State: ACgBeo02R7GosPhLHx9oa/0a5C/J8KCi36NNYesrZCqQHa+yOgMmgWGF
        lt1dBE7jIlCxSawHJ3FD1iiUU452e2l5Nbq6HuV0Zb2O7aHD1QhDZmFOkGKTUtcEkRfS35fMFIa
        814m2jGY68K2E2COCHBQQhd94
X-Received: by 2002:a05:600c:2c4d:b0:3b4:867f:1e6f with SMTP id r13-20020a05600c2c4d00b003b4867f1e6fmr1470238wmg.75.1663056686093;
        Tue, 13 Sep 2022 01:11:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6gvK/9o5ScYFHjDs446Lk12FBMcnw01AT8c1yJTTHwzIKu2JPOCYuyUxK2yCjziCsd7trgng==
X-Received: by 2002:a05:600c:2c4d:b0:3b4:867f:1e6f with SMTP id r13-20020a05600c2c4d00b003b4867f1e6fmr1470208wmg.75.1663056685746;
        Tue, 13 Sep 2022 01:11:25 -0700 (PDT)
Received: from [10.119.22.46] ([89.101.193.66])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b003a5fa79007fsm11515445wms.7.2022.09.13.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 01:11:24 -0700 (PDT)
Message-ID: <53390539-cfa9-7498-5b69-8fb8b307182d@redhat.com>
Date:   Tue, 13 Sep 2022 10:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] hmm-tests: Fix migrate_dirty_page test
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220913052203.177071-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.22 07:22, Alistair Popple wrote:
> As noted by John Hubbard the original test relied on side effects of the
> implementation of migrate_vma_setup() to detect if pages had been
> swapped to disk or not. This is subject to change in future so
> explicitly check for swap entries via pagemap instead. Fix a spelling
> mistake while we're at it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 5cc88e844e87 ("selftests/hmm-tests: add test for dirty bits")
> ---
>   tools/testing/selftests/vm/hmm-tests.c | 50 +++++++++++++++++++++++---
>   1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
> index 70fdb49b59ed..b5f6a7dc1f12 100644
> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -1261,9 +1261,47 @@ static int destroy_cgroup(void)
>   	return 0;
>   }
>   
> +static uint64_t get_pfn(int fd, uint64_t ptr)
> +{
> +	uint64_t pfn;
> +	int ret;
> +
> +	ret = pread(fd, &pfn, sizeof(ptr),
> +		(uint64_t) ptr / getpagesize() * sizeof(ptr));
> +	if (ret != sizeof(ptr))
> +		return 0;
> +
> +	return pfn;
> +}
> +
> +#define PAGEMAP_SWAPPED (1ULL << 62)
> +
> +/* Returns true if at least one page in the range is on swap */
> +static bool pages_swapped(void *ptr, unsigned long pages)
> +{
> +	uint64_t pfn;
> +	int fd = open("/proc/self/pagemap", O_RDONLY);
> +	unsigned long i;
> +
> +	if (fd < 0)
> +		return false;
> +
> +	for (i = 0; i < pages; i++) {
> +		pfn = get_pfn(fd, (uint64_t) ptr + i * getpagesize());
> +
> +		if (pfn & PAGEMAP_SWAPPED) {
> +			close(fd);
> +			return true;
> +		}

We do have pagemap_get_entry() in vm_util.c to query the pagemap entry.

Can you further, add pagemap_is_swapped() to vm_util.c?

I'll be also needing that (including a variant for testing a range) in 
anon COW tests.


-- 
Thanks,

David / dhildenb

