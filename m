Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56431683144
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjAaPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjAaPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D832B7EEB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675178188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxh3yGM/ZsG6BoXNyGFfgQ/WFqnddub0mxCa53sHlr0=;
        b=cr2tKUstrkBjHWddR/Ezhj0B+UFQeQRw/QehPyLI9MxOIWgCfQg+5xupdYiQIuYi/kkK22
        P7Br1RzC5M7x1ojcxOhRa+Cf9wMr2Pt35oZpQS0lB5Iu7+sj5X0V6ZaRvmpXGI0/hlnAoY
        C8M3sVVT2PLz9K/gUAN4H2Neksq2FWY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-8UN-5mYUNNaeUFitFvJfeg-1; Tue, 31 Jan 2023 10:02:31 -0500
X-MC-Unique: 8UN-5mYUNNaeUFitFvJfeg-1
Received: by mail-wm1-f72.google.com with SMTP id e38-20020a05600c4ba600b003dc434dabbdso6697400wmp.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxh3yGM/ZsG6BoXNyGFfgQ/WFqnddub0mxCa53sHlr0=;
        b=JgEjAUpdzUncjhAZ9SP46s3X6+0v4JJAjfY9TYkL9Nznk4BX30FWe7MR4/e1MznMbG
         1kH8hhXqEl6FriztDytM9cWX6+n8n7sxmfXguPC14Bxmqen1Z7xclsJalGpwgkZDwQTJ
         irgbOfVg1SHca4c/hXPr7wubSR6Yya70SkqBjdO8sN+CRvAzcRtIRw1aJ2QmtmrSp9Zc
         34hBJfGHIK5gTzermTdgcnp2REZTC5h+J8yLssVmos+9LNN7dKfQv3ZPo3Yc7jnPOGJ4
         c1sZ12fsbSYEsKcFkaK6TDpKGMe1EowXVHXEmARZcMYgAxbdJ5xq28UG38Vqn6Uy4KiX
         YCgA==
X-Gm-Message-State: AO0yUKWxXLzh3KtiTng3x6gX5gDvVrRVO0mVNHihb0a8J2ogY1RVMoo8
        B3Qa+PVycGlrqJ1TRtLHChbuk1fyFMFYzMTqwawnaRzQAs2Bkt2EIoU3TT5ZIIQr8kNlqrAYxiC
        61mgeUb7mIjupLpu6dKSUlnPb
X-Received: by 2002:a05:600c:12c6:b0:3dc:59a5:afc7 with SMTP id v6-20020a05600c12c600b003dc59a5afc7mr8099364wmd.20.1675177344021;
        Tue, 31 Jan 2023 07:02:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/V4yEZEsQrG/ruc8sFzoH9qJbB6K1Fnya6OXei72kF8T6t0smCD8SwpweMLGlQh0L9cOmCbA==
X-Received: by 2002:a05:600c:12c6:b0:3dc:59a5:afc7 with SMTP id v6-20020a05600c12c600b003dc59a5afc7mr8099330wmd.20.1675177343696;
        Tue, 31 Jan 2023 07:02:23 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003dafbd859a6sm19664293wmb.43.2023.01.31.07.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:02:23 -0800 (PST)
Message-ID: <7f8f2d0f-4bf2-71aa-c356-c78c6b7fd071@redhat.com>
Date:   Tue, 31 Jan 2023 16:02:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
 <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
 <3791872.1675172490@warthog.procyon.org.uk>
 <88d50843-9aa6-7930-433d-9b488857dc14@redhat.com>
 <f2fb6cc5-ff95-ca51-b377-5e4bd239d5e8@kernel.dk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f2fb6cc5-ff95-ca51-b377-5e4bd239d5e8@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.23 15:50, Jens Axboe wrote:
> On 1/31/23 6:48?AM, David Hildenbrand wrote:
>> On 31.01.23 14:41, David Howells wrote:
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>>> percpu counters maybe - add them up at the point of viewing?
>>>>> They are percpu, see my last email. But for every 108 changes (on
>>>>> my system), they will do two atomic_long_adds(). So not very
>>>>> useful for anything but low frequency modifications.
>>>>>
>>>>
>>>> Can we just treat the whole acquired/released accounting as a debug mechanism
>>>> to detect missing releases and do it only for debug kernels?
>>>>
>>>>
>>>> The pcpu counter is an s8, so we have to flush on a regular basis and cannot
>>>> really defer it any longer ... but I'm curious if it would be of any help to
>>>> only have a single PINNED counter that goes into both directions (inc/dec on
>>>> pin/release), to reduce the flushing.
>>>>
>>>> Of course, once we pin/release more than ~108 pages in one go or we switch
>>>> CPUs frequently it won't be that much of a help ...
>>>
>>> What are the stats actually used for?  Is it just debugging, or do we actually
>>> have users for them (control groups spring to mind)?
>>
>> As it's really just "how many pinning events" vs. "how many unpinning
>> events", I assume it's only for debugging.
>>
>> For example, if you pin the same page twice it would not get accounted
>> as "a single page is pinned".
> 
> How about something like the below then? I can send it out as a real
> patch, will run a sanity check on it first but would be surprised if
> this doesn't fix it.
> 
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f45a3a5be53a..41abb16286ec 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   		 */
>   		smp_mb__after_atomic();
>   
> +#ifdef CONFIG_DEBUG_VM
>   		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
> +#endif
>   
>   		return folio;
>   	}
> @@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_PIN) {
> +#ifdef CONFIG_DEBUG_VM
>   		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
> +#endif
>   		if (folio_test_large(folio))
>   			atomic_sub(refs, folio_pincount_ptr(folio));
>   		else
> @@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>   		} else {
>   			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>   		}
> -
> +#ifdef CONFIG_DEBUG_VM
>   		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
> +#endif
>   	}
>   
>   	return 0;
> 

We might want to hide the counters completely by defining them only with 
CONFIG_DEBUG_VM.

-- 
Thanks,

David / dhildenb

