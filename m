Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96DF74B6F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjGGTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGGTPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41311128
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688757307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRKMINojVLdITqbh6Qws5X2HaU+JqwI7I90nRvPiP7o=;
        b=YlofqwVHJ76IJ0G+fXLBUuFXKXSxEt/UjgPWGOnVxxJE79VBAbxHeA2uywme4zSYx/HxEr
        1HXnHHOMekHwtREfzJUOju3GINyYTE1m5mq2IghOeNqRguNXoIbjbyvyG7Eu90NCuF4mW6
        b4TY91nzJjXUgbampePeLMGVpRUNYzk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-3m1I1jGiONG3qYL-CLp18g-1; Fri, 07 Jul 2023 15:15:05 -0400
X-MC-Unique: 3m1I1jGiONG3qYL-CLp18g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3158a22534aso396821f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688757304; x=1691349304;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRKMINojVLdITqbh6Qws5X2HaU+JqwI7I90nRvPiP7o=;
        b=lC6OhuOTj8wvFNFG1+hwLIEsMQdY3BEeTWJ0lU51hlpQZQqOyqnFXXj4lCGKn2Xx0K
         X8QtVoNOl61XY2JkuUQuFa2ZAJoSoKOMbei1Yc55L/oCISlEsorGQwA8HDSbISclSj53
         Be0P2RxeWcYNJCiB/nkhjd7oGdrpSpGvqWtCjXSlwF7gZa1nEyWtBkCIXas6LVnQzJof
         RHzOydvrlfNhTsv5rPGM0w+i42Ic9/M26XC1zXNBItJHcgsDF3asW1YBADBmks16IeFw
         73B41+8JC7jNBB2uwJ+Uz2efJlYx0cs/5BI/Xp/6s36l9vyiYO18APpgbVZWu/UyvL8h
         36Hg==
X-Gm-Message-State: ABy/qLa0wJ+Ul6WNE0ooaxIa2P1pWMoDLEcKwg+DUrjBSSf7jl69VV2e
        nOrrpUfA9tY2xCpUlvOTcBjQf+c1XEjmkmfVkoL6xssW1l3sNU/QT4SNTWYL4BqXfvynOWLzypc
        Db65Z8PK/i9epqTlEep5+3ZQ/
X-Received: by 2002:a5d:5450:0:b0:314:3503:15ac with SMTP id w16-20020a5d5450000000b00314350315acmr4913391wrv.10.1688757304107;
        Fri, 07 Jul 2023 12:15:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGEMNtQdKckP4Dc4tAeLngfG/Vp+EPGbkObZIVzmDdYwDN6Gm3G2yv8ZHItdXeDqHW94Nsz3A==
X-Received: by 2002:a5d:5450:0:b0:314:3503:15ac with SMTP id w16-20020a5d5450000000b00314350315acmr4913378wrv.10.1688757303730;
        Fri, 07 Jul 2023 12:15:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0031424f4ef1dsm5158897wru.19.2023.07.07.12.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 12:15:03 -0700 (PDT)
Message-ID: <5c9bf622-0866-168f-a1cd-4e4a98322127@redhat.com>
Date:   Fri, 7 Jul 2023 21:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
In-Reply-To: <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 21:06, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 08:54:33PM +0200, David Hildenbrand wrote:
>> On 07.07.23 19:26, Matthew Wilcox wrote:
>>> On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
>>>> This series identified the large folio for mlock to two types:
>>>>     - The large folio is in VM_LOCKED VMA range
>>>>     - The large folio cross VM_LOCKED VMA boundary
>>>
>>> This is somewhere that I think our fixation on MUST USE PMD ENTRIES
>>> has led us astray.  Today when the arguments to mlock() cross a folio
>>> boundary, we split the PMD entry but leave the folio intact.  That means
>>> that we continue to manage the folio as a single entry on the LRU list.
>>> But userspace may have no idea that we're doing this.  It may have made
>>> several calls to mmap() 256kB at once, they've all been coalesced into
>>> a single VMA and khugepaged has come along behind its back and created
>>> a 2MB THP.  Now userspace calls mlock() and instead of treating that as
>>> a hint that oops, maybe we shouldn't've done that, we do our utmost to
>>> preserve the 2MB folio.
>>>
>>> I think this whole approach needs rethinking.  IMO, anonymous folios
>>> should not cross VMA boundaries.  Tell me why I'm wrong.
>>
>> I think we touched upon that a couple of times already, and the main issue
>> is that while it sounds nice in theory, it's impossible in practice.
>>
>> THP are supposed to be transparent, that is, we should not let arbitrary
>> operations fail.
>>
>> But nothing stops user space from
>>
>> (a) mmap'ing a 2 MiB region
>> (b) GUP-pinning the whole range
>> (c) GUP-pinning the first half
>> (d) unpinning the whole range from (a)
>> (e) munmap'ing the second half
>>
>>
>> And that's just one out of many examples I can think of, not even
>> considering temporary/speculative references that can prevent a split at
>> random points in time -- especially when splitting a VMA.
>>
>> Sure, any time we PTE-map a THP we might just say "let's put that on the
>> deferred split queue" and cross fingers that we can eventually split it
>> later. (I was recently thinking about that in the context of the mapcount
>> ...)
>>
>> It's all a big mess ...
> 
> Oh, I agree, there are always going to be circumstances where we realise
> we've made a bad decision and can't (easily) undo it.  Unless we have a
> per-page pincount, and I Would Rather Not Do That. 

I agree ...

But we should _try_
> to do that because it's the right model -- that's what I meant by "Tell

Try to have per-page pincounts? :/ or do you mean, try to split on VMA 
split? I hope the latter (although I'm not sure about performance) :)

> me why I'm wrong"; what scenarios do we have where a user temporarilly
> mlocks (or mprotects or ...) a range of memory, but wants that memory
> to be aged in the LRU exactly the same way as the adjacent memory that
> wasn't mprotected?

Let me throw in a "fun one".

Parent process has a 2 MiB range populated by a THP. fork() a child 
process. Child process mprotects half the VMA.

Should we split the (COW-shared) THP? Or should we COW/unshare in the 
child process (ugh!) during the VMA split.

It all makes my brain hurt.

> 
> GUP-pinning is different, and I don't think GUP-pinning should split
> a folio.  That's a temporary use (not FOLL_LONGTERM), eg, we're doing
> tcp zero-copy or it's the source/target of O_DIRECT.  That's not an
> instruction that this memory is different from its neighbours.
> 
> Maybe we end up deciding to split folios on GUP-pin.  That would be
> regrettable.

That would probably never be accepted, because the ones that heavily 
rely on THP (databases, VMs), typically also end up using a lot of 
features that use (long-term) page pinning. Don't get me started on 
io_uring with fixed buffers.

-- 
Cheers,

David / dhildenb

