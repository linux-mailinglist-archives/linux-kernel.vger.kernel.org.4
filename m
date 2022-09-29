Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD215EFC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiI2Rxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiI2Rxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6264153118
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664474019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sXJFjCRFxMNssr/mUWen1rN16k+mBeuV002AH3z+GQ=;
        b=b9UjnnH4+3IhRpMiXxbpT2UNZKGEIu9fVDeObz+qq1CjvlC81/brtPcuE88MCN2IHNaoV+
        /Ob1f4sepo7Hiak0kNhwUw0oBPEhLCsd287y1oQ0yrYnAHhyu97KHLBHbSIBnWcF7T2G3U
        c+ovjD9+R4j2AL6OnIzEczAoAu669p8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-1MIvrFShMZyGFEL5GlKERQ-1; Thu, 29 Sep 2022 13:53:37 -0400
X-MC-Unique: 1MIvrFShMZyGFEL5GlKERQ-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020adfc654000000b0022cc05e9119so788128wrg.16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/sXJFjCRFxMNssr/mUWen1rN16k+mBeuV002AH3z+GQ=;
        b=AC1McKh8LzVmy6gt5xep57oVeKdo0/pa3U9ORPCKvyn6OHq7KT6Ebz6xTvzwdplEt9
         2qO/FrMrnCcDmd0dz+r7Zqhwg/KXG+sBepdg36h2cexACSz/OGrzgW+cbGROuTTggIz6
         uYhrX9XD7vR1TddS+dqZy2XauZRwEmT29z6nNkW9QtwpuNbYf/Yyoy6gnUrcYb2ssvJx
         hHt3z25xjC5t+VcKrbOWZ+w6bZHqMp0zqyUMJvuR45HEJR39JeWoR+Nf7ZfXK2pblV5G
         RiA8L3eyJggvRDW38AW6abmL7zGj14cCv3xFEzFXjhJhZXMYG0rALO5y9UzgfRZ2NWe2
         jAkg==
X-Gm-Message-State: ACrzQf32HkK+gTKNFYaZj0RCXN36ZWgYwTa1Ljtf1JMzIm6oanbf8HaA
        cMPNJW1PUGRDiQ8STxzub4JNPubcIp3TgHe4Xi4NN4wKajPiGr//zlcso9j7eOqs5vDOOL5v5EP
        hCBg5a5rjPNoUKHAUY9bDScqh
X-Received: by 2002:a5d:64e8:0:b0:22a:bb78:1e44 with SMTP id g8-20020a5d64e8000000b0022abb781e44mr3522230wri.378.1664474016324;
        Thu, 29 Sep 2022 10:53:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6NM1V+j1UR86PNp4yTqE5L3bA7FGaGV39Ce7xz8ZTyuznu+JH3bLcqrb0Wa7tlWDfb94uU8g==
X-Received: by 2002:a5d:64e8:0:b0:22a:bb78:1e44 with SMTP id g8-20020a5d64e8000000b0022abb781e44mr3522211wri.378.1664474016026;
        Thu, 29 Sep 2022 10:53:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id bs11-20020a056000070b00b0022a2bacabbasm43197wrb.31.2022.09.29.10.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:53:35 -0700 (PDT)
Message-ID: <1fc6984b-bcc7-123d-1ea3-9e04d5b26529@redhat.com>
Date:   Thu, 29 Sep 2022 19:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
 <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
 <20220929123630.0951b199@p-imbrenda>
 <745f75a4-6a2a-630f-8228-0c5e081588e7@redhat.com>
 <20220929140548.1945dccf@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
In-Reply-To: <20220929140548.1945dccf@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 14:05, Claudio Imbrenda wrote:
> On Thu, 29 Sep 2022 13:12:44 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 29.09.22 12:36, Claudio Imbrenda wrote:
>>> On Thu, 29 Sep 2022 11:21:44 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>    
>>>> On 29.09.22 04:52, xu.xin.sc@gmail.com wrote:
>>>>> From: xu xin <xu.xin16@zte.com.cn>
>>>>>
>>>>> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
>>>>> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
>>>>> after enabling use_zero_pages, all empty pages that are merged with
>>>>> kernel zero page are not counted in pages_sharing or pages_shared.
>>>>> That is because the rmap_items of these ksm zero pages are not
>>>>> appended to The Stable Tree of KSM.
>>>>>
>>>>> We need to add the count of empty pages to let users know how many empty
>>>>> pages are merged with kernel zero page(s).
>>>>>
>>>>> Please see the subsequent patches for details.
>>>>
>>>> Just raising the topic here because it's related to the KSM usage of the
>>>> shared zero-page:
>>>>
>>>> MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare
>>>> the shared zeropage as placed by KSM (which is against the
>>>> MADV_UNMERGEABLE documentation at least). It will only unshare actual
>>>> KSM pages. We might not want want to blindly unshare all shared
>>>> zeropages in applicable VMAs ... using a dedicated shared zero (KSM)
>>>> page -- instead of the generic zero page --  might be one way to handle
>>>> this cleaner.
>>>
>>> I don't understand why do you need this.
>>>
>>> first of all, one zero page would not be enough (depending on the
>>> architecture, e.g. on s390x you need many). the whole point of zero
>>> page merging is that one zero page is not enough.
>>
>> I don't follow. Having multiple ones is a pure optimization on s390x (I
>> recall something about cache coloring), no? So why should we blindly
>> care in the special KSM use case here?
> 
> because merging pages full of zeroes with only one page will have
> negative performance on those architectures that need cache colouring
> (and s390 is not even the only architecture that needs it)
> 
> the whole point of merging pages full of zeroes with zero pages is to
> not lose the cache colouring.
> 
> otherwise you could just let KSM merge all pages full of zeroes with
> one page (which is what happens without use_zero_pages), and all the
> numbers are correct.
> 
> if you are not on s390 or MIPS, you have no use for use_zero_pages

Ah, I see now that use_zero_pages is really only (mostly) s390x 
specific. I already wondered why on earth we would really need that, 
thanks for pointing that out.

One question I'd have is: why is the shared zero page treated special in 
KSM then *at all*. Cache coloring problem should apply to *each and 
every* deduplicated page.

Why is a page filled with 0xff any different from a page filled with 0x0?

Yes, I read e86c59b1b12d. It doesn't mention any actual performance 
numbers and if the performance only applies to some microbenchmarks 
nobody cares about.

Did you post some benchmarks results back then? That would be 
interesting. I assume that the shared zeropage was simply the low 
hanging fruit.

> 
>>
>>>
>>> second, once a page is merged with a zero page, it's not really handled
>>> by KSM anymore. if you have a big allocation, of which you only touch a
>>> few pages, would the rest be considered "merged"? no, it's just zero
>>> pages, right?
>>
>> If you haven't touched memory, there is nothing populated -- no shared
>> zeropage.
>>
>> We only populate shared zeropages in private anonymous mappings on read
>> access without prior write.
> 
> that's what I meant. if you read without writing, you get zero pages.
> you don't consider those to be "shared" from a KSM point of view
> 
> does it make a difference if some pages that have been written to but
> now only contain zeroes are discarded and mapped back to the zero pages?

That's a good question. When it comes to unmerging, you'd might expect 
that whatever was deduplicated will get duplicated again -- and your 
memory consumption will adjust accordingly. The stats might give an 
admin an idea regarding how much memory is actually overcommited. See 
below on the important case where we essentially never see the shared 
zeropage.

The motivation behind these patches would be great -- what is the KSM 
user and what does it want to achieve with these numbers?

> 
>>
>>> this is the same, except that we take present pages with zeroes in it
>>> and we discard them and map them to zero pages. it's kinda like if we
>>> had never touched them.
>>
>> MADV_UNMERGEABLE
>>
>> "Undo  the effect of an earlier MADV_MERGEABLE operation on the
>> specified address range; KSM unmerges whatever pages it had merged in
>> the address range specified  by  addr  and length."
>>
>> Now please explain to me how not undoing a zeropage merging is correct
>> according to this documentation.
>>
> 
> because once it's discarded and replaced with a zero page, the page is
> not handled by KSM anymore.
> 
> I understand what you mean, that KSM did an action that now cannot be
> undone, but how would you differentiate between zero pages that were
> never written to and pages that had been written to and then discarded
> and mapped back to a zero page because they only contained zeroes?

An application that always properly initializes (write at least some 
part once) all its memory will never have the shared zeropage mapped. VM 
guest memory comes to mind, probably still the most important KSM use case.

There are currently some remaining issues when taking a GUP R/O longterm 
pin on such a page (e.g., vfio). In contrast to KSM pages, such pins are 
not reliable for the shared zeropage, but I have fixes for them pending. 
However, that is rather a corner case (it didn't work at all correctly a 
while ago) and will be sorted out soon.

So the question is if MADV_UNMERGEABLE etc. (stats) should be adjusted 
to document the behavior with use_zero_pages accordingly.

-- 
Thanks,

David / dhildenb

