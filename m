Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD86C1007
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCTK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCTK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B152595A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679309655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tMCQDVzULAU4jofBrk3rYm7lirCI2ZuvfCFM/wFL08=;
        b=GP2CH2fv3233vvImoMZ9DIEY6xhBWc+xYL2mgBwKqXEfZycJExQE7b3HzS3B7u0MP6J1F3
        13jAKrZljqQIeoFPBVTSMeP/l1F0AEMueI33Bx0X7vLop6ecNSY2t8zEAymu7WgRLvg5NZ
        CMydGcfT8H1rLGiugmWJjJnLiNUCIZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-6KG8mVOXM72MotgGVhybLQ-1; Mon, 20 Mar 2023 06:54:14 -0400
X-MC-Unique: 6KG8mVOXM72MotgGVhybLQ-1
Received: by mail-wm1-f72.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so401712wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679309653;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tMCQDVzULAU4jofBrk3rYm7lirCI2ZuvfCFM/wFL08=;
        b=q6YURQHK+oUvdvndQWgNxgVbPHQJGPMN4iuETPeWUXaQL5ZWGAFzMGacLSZ3kRLxb2
         LH0PWruHVPZoVmjkDGh3p++sSD+d0umGGbwub2qLs6/d5OsBmTgdcyYr1is6i64OK7Wv
         ax4tFdzFchGQ5I0oqHdYvDMOLmj2KxRcbeW7mx1XHCMEuK68nsN2iJY35VjDEzTB+HAW
         qrL2opRpDnBcxt63jLGzgJCPZV56GT1mrhMnSCOKJWgkA5yDDWxe8wYEgEwn7Dv/unFn
         7y9bDXjMvYtlqBaSvchH6KkTOwkkfqf1BHkWL/cSfExZZ11rtRC+2yh+ug4Ll0U5/kzn
         fDHg==
X-Gm-Message-State: AO0yUKUvTE9KqPN/K7Ti6hAS2HTU4V75pQy3rA01TUGaCBBaZBnzRwHY
        xqjf159fy6bTKXJA3N2RU5Aqd97t/IKAV2KzWP27bTQv1Q45XuiimvxEFTLILTiZ/BKFt6ga7qk
        B4pHSPuxvDBt+LxtP5bD5kzW5
X-Received: by 2002:a7b:c8cc:0:b0:3ed:a5df:cf52 with SMTP id f12-20020a7bc8cc000000b003eda5dfcf52mr6949898wml.13.1679309653017;
        Mon, 20 Mar 2023 03:54:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set9d5YjWFuqRhbzglWL5WNl+1FjRpHrjEMlJMUOl8DuqOurWcJPI5w6n84yTGENjzP/cbJwiSw==
X-Received: by 2002:a7b:c8cc:0:b0:3ed:a5df:cf52 with SMTP id f12-20020a7bc8cc000000b003eda5dfcf52mr6949885wml.13.1679309652719;
        Mon, 20 Mar 2023 03:54:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcd14000000b003e203681b26sm10131233wmj.29.2023.03.20.03.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:54:12 -0700 (PDT)
Message-ID: <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
Date:   Mon, 20 Mar 2023 11:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
In-Reply-To: <20230320024739.224850-2-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 03:47, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
> The return value of mlock is zero. But nothing will be locked since the
> len in do_mlock overflows to zero due to the following code in mlock:
> 
>    len = PAGE_ALIGN(len + (offset_in_page(start)));
> 
> The same problem happens in munlock.
> 
> Add new check and return -EINVAL to fix this overflowing scenarios since
> they are absolutely wrong.

Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?

> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>   mm/mlock.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 617469fce96d..eb68476da497 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -568,6 +568,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>   	unsigned long locked;
>   	unsigned long lock_limit;
>   	int error = -ENOMEM;
> +	size_t old_len = len;
>   
>   	start = untagged_addr(start);
>   
> @@ -577,6 +578,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>   	len = PAGE_ALIGN(len + (offset_in_page(start)));
>   	start &= PAGE_MASK;
>   
> +	if (old_len != 0 && len == 0)

if (old_len && !len)

> +		return -EINVAL;
> +
>   	lock_limit = rlimit(RLIMIT_MEMLOCK);
>   	lock_limit >>= PAGE_SHIFT;
>   	locked = len >> PAGE_SHIFT;
> @@ -631,12 +635,16 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>   SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
>   {
>   	int ret;
> +	size_t old_len = len;
>   
>   	start = untagged_addr(start);
>   
>   	len = PAGE_ALIGN(len + (offset_in_page(start)));
>   	start &= PAGE_MASK;
>   
> +	if (old_len != 0 && len == 0)

if (old_len && !len)

> +		return -EINVAL;
> +
>   	if (mmap_write_lock_killable(current->mm))
>   		return -EINTR;
>   	ret = apply_vma_lock_flags(start, len, 0);

-- 
Thanks,

David / dhildenb

