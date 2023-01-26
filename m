Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023167C606
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjAZIjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjAZIjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E3F6C117
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674722278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03govaco/k7QRuYG8wH+zgOyem44zOrE/2g3qGYBeec=;
        b=FWqtu4MW7Sx/608JPLVCggviPdHcgpHYc3GlhLf0tfUZCuclY6o7zOgg4Yy1zZUuJekJt4
        A+Jmf/TK55QXZwD5WxPTH6Ily505lVNN5GVyixx9PYGoUCmZO/1VDiLk9VYMH8OOM+pJbS
        K+6v/KIC9smuG5wp3WX1pENFBMLb7Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-sC-wqvVoPXSZVMEsA3u2hw-1; Thu, 26 Jan 2023 03:37:57 -0500
X-MC-Unique: sC-wqvVoPXSZVMEsA3u2hw-1
Received: by mail-wm1-f72.google.com with SMTP id l8-20020a05600c1d0800b003dc25f6bb5dso569414wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03govaco/k7QRuYG8wH+zgOyem44zOrE/2g3qGYBeec=;
        b=4j080u1sh+bfAv4B0IZcWjI3ZDjGKcW/Et6Qn5XkI60DLM0URUJQ37I+ZcLwBBV8Jz
         p/3mqscOpS7LYVV7XS7UlJssR3TAf5S4GkdmURqX+zxeBjOBJS4C2xA5qt42xMfNMl7p
         eCyPt/cC4sJ7k2tgXdg/Uj7kvh9hwy7FaFDpjVSrqWt8SliumpY5QwLIklAk9poK0225
         R1EOQ66XAUGKq5TuiWNxzhauYv6OEUraSEzxPztNQ00lNooJo/nQJW+NTo5to8GefUBS
         FWm1IQt8D1idJzLQphOvwdk8tO7ixv1gQi9xzbMryp73gjVJOtPB2gtvHYISgOVBoXWE
         6ySQ==
X-Gm-Message-State: AO0yUKVprbj992shZAPiik834/VVSwVi47Xj5pdnL2M/P3lsGOzDBc4F
        GNu24WsEEnY0YslzxxlYgs2CSBUbYiwHoTWP4I4fLoLmlrlcYIAfFS53VVsDjSwOev/YTkYGC6y
        H9xDhR9pstFfjzSncK+Gg5Jw5
X-Received: by 2002:a05:600c:46cb:b0:3dc:1d62:1e9c with SMTP id q11-20020a05600c46cb00b003dc1d621e9cmr4576482wmo.41.1674722276212;
        Thu, 26 Jan 2023 00:37:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8iyfb7Q4H7MkzbfZ3IksQgPv9DTJio1Pn6vTBNqXG4VFnEqYcPyKuzkUvU34RxL6c9T07KNw==
X-Received: by 2002:a05:600c:46cb:b0:3dc:1d62:1e9c with SMTP id q11-20020a05600c46cb00b003dc1d621e9cmr4576466wmo.41.1674722275766;
        Thu, 26 Jan 2023 00:37:55 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm4508629wmq.33.2023.01.26.00.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:37:55 -0800 (PST)
Message-ID: <52af321f-175b-9fa9-10f0-ac2bba04c677@redhat.com>
Date:   Thu, 26 Jan 2023 09:37:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
 <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
 <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
 <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
 <CAOzc2pyV9-wq04NRKVE1vRj7PnRF7g+jSFFj-oKYuZk-t9smBA@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAOzc2pyV9-wq04NRKVE1vRj7PnRF7g+jSFFj-oKYuZk-t9smBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.23 23:09, Vishal Moola wrote:
> On Wed, Jan 25, 2023 at 1:29 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.01.23 11:24, David Hildenbrand wrote:
>>> On 25.01.23 11:20, David Hildenbrand wrote:
>>>> On 24.01.23 02:22, Vishal Moola (Oracle) wrote:
>>>>> folio_estimated_mapcount() takes in a folio and calls page_mapcount() on
>>>>> the first page of that folio.
>>>>>
>>>>> This is necessary for folio conversions where we only care about either the
>>>>> entire_mapcount of a large folio, or the mapcount of a not large folio.
>>>>>
>>>>> This is in contrast to folio_mapcount() which calculates the total
>>>>> number of the times a folio and its subpages are mapped.
>>>>>
>>>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>>>> ---
>>>>>      include/linux/mm.h | 5 +++++
>>>>>      1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index c9db257f09b3..543c360f7ecc 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -875,6 +875,11 @@ static inline int page_mapcount(struct page *page)
>>>>>              return mapcount;
>>>>>      }
>>>>>
>>>>> +static inline int folio_estimated_mapcount(struct folio *folio)
>>>>> +{
>>>>> +   return page_mapcount(folio_page(folio, 0));
>>>>> +}
>>>>> +
>>>>>      int folio_total_mapcount(struct folio *folio);
>>>>>
>>>>>      /**
>>>>
>>>> I'm sorry, but "estimated" as absolutely unclear semantics. You could
>>>> have a THP mapped into 9999 processes using THP and the estimation would
>>>> be "0".
>>>
>>> ... or would it be 9999 ? What about a PMD-mapped THP? What about a
>>> partially unmapped THP?
>>>
>>> What are we estimating?
>>
>> Thinking about mapcounts again, might not have been my smartest moment.
>>
>> What we return here is the precise number of times the first subpage is
>> mapped (via the large folio and directly). That's supposed to be an
>> estimate for the number of times any subpage part of the folio is mapped.
>>
>> I really don't know a better name, but folio_estimated_mapcount() does
>> not feel completely right to me and triggere dmy confusion in the first
>> place ... hm ...
> 
> I can understand the confusion, but I can't think of a better name
> either myself. I'll go ahead and add a comment to make the purpose
> of this function more clear. Looks like I'll have to move it to get rid
> of the build warnings/errors anyway.

The issue is that we're not estimating the mapcount of the folio, so the 
name is very misleading ... I think you really want to avoid the term 
mapcount completely in that context. We're just using the #mappings of 
the first subpage to determine something differently.

Thinking about it, I guess "folio_estimated_sharers()" might be what we 
actually want to name it. Then you can comment how we estimate sharers 
by looking at into how many page tables the first subpage is currently 
mapped, and assume the same holds true for the other subpages.

It's unreliable because other subpages might behave differently, we 
might not be holding the pagelock to stabilize, and we're not looking at 
indirect mappings via the swapcache. But it's a comapratively good 
estimate for most scenarios I guess.

-- 
Thanks,

David / dhildenb

