Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C95B6894
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIMHVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIMHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BD843E54
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663053704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylh9ncmGPJOsB78thI/3cAGzV/njJPkYV/mAwkDnPyI=;
        b=gDVmlbDJXUfXsuQGBiGKARgTX1WTp4oyGju5w1ihYXyGRvcNmBSJq83rznWP0iGG+MZp4k
        HwxORjssqNi3toMzXH2xzPv91GjcLSXJpFDn9xvp7ubYqS/SJTEXbUOoQn+hI2BVALhLj6
        4iMJoROGIoXTEot7kWd12FbBcQiwc+E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-67RR7IzrMQ-EVv3PtEFCUA-1; Tue, 13 Sep 2022 03:21:42 -0400
X-MC-Unique: 67RR7IzrMQ-EVv3PtEFCUA-1
Received: by mail-lf1-f71.google.com with SMTP id i33-20020a0565123e2100b00498fb105ef4so3520494lfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ylh9ncmGPJOsB78thI/3cAGzV/njJPkYV/mAwkDnPyI=;
        b=vHzhHCOJEfRSBOKduQUOZLc4IuziVvwJHWJYYQUxif0Wsxdw4NGDb/01BjsO1F2t9d
         oT0rboGSJUsWps26aa/GrHBn7OeRBXybrfBU6I7D5yLCiqUDNtKgjMzvffyf6pNY257v
         LSeF6cYqfVDAtwaL9FZahfWSKhuto+LIYCmLXdxefI3H+/kum4iyshq9mmKA1LLcKW5i
         qoDRZkTF7hMIMkDQZRc74mLBn6vhq0Nj5fDj5ROo0Q0pHlzRqGOy+9Km4/MyslYMCsZF
         lnMKv/HnY7Mv/oU9fH7+IqbXpcsRM40fUilUKVG8qNIqKU7KiWGmCN/6lpmDgkFFX7MV
         04IQ==
X-Gm-Message-State: ACgBeo3p8Sk5d8NGdZObM5fMTi0s/bkjAiMkyvnrRdwYsa926+POyJ1Z
        KXjcrp2ItAUe+2mix7xXulPT70/HL8lzOcoklaG+pz+0Ld/D2JVhX64sat5VnVVych4/UmWc0lh
        XIH4vW+448aeEnsBGD+4knXE=
X-Received: by 2002:a2e:a887:0:b0:26a:871b:a16d with SMTP id m7-20020a2ea887000000b0026a871ba16dmr9391586ljq.482.1663053701204;
        Tue, 13 Sep 2022 00:21:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6r+REe45FUvXnaTS9jVKKwZjNZFId41bNwnokkT3n1YTbgrJnWiH8KnqDSyjREPFSzn6xt4g==
X-Received: by 2002:a2e:a887:0:b0:26a:871b:a16d with SMTP id m7-20020a2ea887000000b0026a871ba16dmr9391578ljq.482.1663053700977;
        Tue, 13 Sep 2022 00:21:40 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id o1-20020a05651205c100b0048b0099f40fsm1522618lfo.216.2022.09.13.00.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 00:21:40 -0700 (PDT)
Message-ID: <64964b86-1fef-3550-a224-081f8e0e5e52@redhat.com>
Date:   Tue, 13 Sep 2022 10:21:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hmm-tests: Fix migrate_dirty_page test
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org
References: <20220913052203.177071-1-apopple@nvidia.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20220913052203.177071-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.9.2022 8.22, Alistair Popple wrote:
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
> +	}
> +
> +	close(fd);
> +	return false;
> +}
> +
>   /*
>    * Try and migrate a dirty page that has previously been swapped to disk. This
> - * checks that we don't loose dirty bits.
> + * checks that we don't lose dirty bits.
>    */
>   TEST_F(hmm, migrate_dirty_page)
>   {
> @@ -1300,6 +1338,10 @@ TEST_F(hmm, migrate_dirty_page)
>   
>   	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>   
> +	/* Make sure at least some pages got paged to disk. */
> +	if (!pages_swapped(buffer->ptr, npages))
> +		SKIP(return, "Pages weren't swapped when they should have been");
> +
>   	/* Fault pages back in from swap as clean pages */
>   	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>   		tmp += ptr[i];
> @@ -1309,10 +1351,10 @@ TEST_F(hmm, migrate_dirty_page)
>   		ptr[i] = i;
>   
>   	/*
> -	 * Attempt to migrate memory to device, which should fail because
> -	 * hopefully some pages are backed by swap storage.
> +	 * Attempt to migrate memory to device. This might fail if some pages
> +	 * are/were backed by swap but that's ok.
>   	 */
> -	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
> +	hmm_migrate_sys_to_dev(self->fd, buffer, npages);
>   
>   	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>   


Reviewed-by: Mika Penttilä <mpenttil@redhat.com>

