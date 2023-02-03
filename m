Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9B68A014
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjBCRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE5F8C439
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/WHxUzzwv9ZaSxxvaGPadr2/52VpYwqJQM6nMFBVqU=;
        b=TyB0lGGU122Vlna+6vAeZfqUMKFUGp/27jKdQEyWvA7k6zKVrJamo173uSmK4ki6lb4lLK
        njs36nkFL7FlFuii0YQTktHsLvJDdZ2VxgKwZFSuQ4/ft3vp5o4x0rHrsFFk5RmOo+jpkx
        vcPu9dgjBYw/1SDWcN5jLQjyWzqGwRI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-2-dcSY3UNWq3GDPVR0vCBw-1; Fri, 03 Feb 2023 12:14:32 -0500
X-MC-Unique: 2-dcSY3UNWq3GDPVR0vCBw-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b003deab30bb8bso2996575wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/WHxUzzwv9ZaSxxvaGPadr2/52VpYwqJQM6nMFBVqU=;
        b=ziPVaphU/nucjWaIh6KKrpx/w231BtTNOtJg59ZB7/UOFQUloPsWKKkrzpYntAm0IN
         9yQc6RmYPlm/FMj6ag3M+qlzrUZhjk+bYCU2FHM6ub+R5J8Qp26RppQLbRUsiWI+zLN7
         vIsyqqIwHMH4cRlEkC4E0aLwlCW4WPxqFepRWiJ+u1DBzANKUJewiTIZwFPDgD+fhNXh
         SZA/auYWZMIw+ab4WwedI3Slox+dNjc1kmaU6G9t/JjTB0jmwm2m3fC/wIr0k3khIowb
         nVBodSHiQxof8gFKKRfFN0/B2+FgIeMewCbaI/rNFNqPvLA+7rjLHBl+Mxgqz5A3ujDU
         SxPw==
X-Gm-Message-State: AO0yUKUS2d410pHC7PdSSf1Lagae71073jj4pajxTFCb3ppWKjiKZ1Cv
        bBhXBt9Pa1SjmzQDFCt9JdFzQ28rs1VfoFdfTjx0TMIDF2Q2Bqgwj6sbFOOhfeYZJ2WkN+2n3BO
        KKvbmr5XloCC9TfTH9vM47Bm1
X-Received: by 2002:a05:6000:1f0f:b0:2bf:bbd1:1db3 with SMTP id bv15-20020a0560001f0f00b002bfbbd11db3mr9703404wrb.44.1675444471404;
        Fri, 03 Feb 2023 09:14:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+XL6mzxsALxdMaVmhrCDXd3CD0FBym0RXIS3cJEDzHwXenBQU7IeJ42BV1gKVtitH4Mk6d5g==
X-Received: by 2002:a05:6000:1f0f:b0:2bf:bbd1:1db3 with SMTP id bv15-20020a0560001f0f00b002bfbbd11db3mr9703388wrb.44.1675444471136;
        Fri, 03 Feb 2023 09:14:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:7900:b84d:7f2e:b638:3092? (p200300cbc7067900b84d7f2eb6383092.dip0.t-ipconnect.de. [2003:cb:c706:7900:b84d:7f2e:b638:3092])
        by smtp.gmail.com with ESMTPSA id k6-20020adfb346000000b0027cb20605e3sm2470036wrd.105.2023.02.03.09.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 09:14:30 -0800 (PST)
Message-ID: <753c53d3-84a6-da73-4121-0db4a71e4fde@redhat.com>
Date:   Fri, 3 Feb 2023 18:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230128063229.989058-1-mawupeng1@huawei.com>
 <20230128063229.989058-2-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230128063229.989058-2-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.23 07:32, Wupeng Ma wrote:
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
> 
> Return 0 early to avoid burn a bunch of cpu cycles if len == 0.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>   mm/mlock.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 7032f6dd0ce1..eb09968ba27f 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -478,8 +478,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>   	end = start + len;
>   	if (end < start)
>   		return -EINVAL;
> -	if (end == start)
> -		return 0;
>   	vma = mas_walk(&mas);
>   	if (!vma)
>   		return -ENOMEM;
> @@ -575,7 +573,13 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>   	if (!can_do_mlock())
>   		return -EPERM;
>   
> +	if (!len)
> +		return 0;
> +
>   	len = PAGE_ALIGN(len + (offset_in_page(start)));
> +	if (!len)
> +		return -EINVAL;
> +
>   	start &= PAGE_MASK;

The "ordinary" overflows are detected in apply_vma_lock_flags(), correct?

-- 
Thanks,

David / dhildenb

