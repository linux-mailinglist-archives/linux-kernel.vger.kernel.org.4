Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6074B4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjGGQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjGGQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B921BF4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688745985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwPjc8vcrtj61iKL+PFdekq3QvvaLbWA6Qsa4S/CLJA=;
        b=bqcB+LYL5KjUnIegbgjvcmL+uRkgMMlu+08OGAq3jdds2J4fyxMvUCaiuJTLmQjV5b0tbL
        y6eGVT76b9+gdYhb5TSsL4QeQqAZIEC9dfNQgdg6RYpJX/x1lG1tcJ4MPOH/SO9Yd+uUuY
        7bH+RJqr+JIe2+1JmrgJlykxVip6VEA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-H1gmjeaKMByG-OSWQHGW5A-1; Fri, 07 Jul 2023 12:06:24 -0400
X-MC-Unique: H1gmjeaKMByG-OSWQHGW5A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314326f6e23so1043671f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745983; x=1691337983;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwPjc8vcrtj61iKL+PFdekq3QvvaLbWA6Qsa4S/CLJA=;
        b=JdJR0PimfsPfAlUJh3K6GDhguP62qKQjhMxqCLUVl1VOIv/dL8FfHDdZxfrn1+GTl0
         K5BTBLhdlKD5vqN8wq4j7Im2b/bRzDWKDorVT++ufByTUEFWspyQvgaKc2tJnz6dJ7WI
         JEMYeLiQChHgnILofvEvw7L4eVYmoID31ilTbjEJO9n0dYbGTYylBJDPKhaMfwk6cdGk
         8lxxVn2/XI48tby9YXBv2BdjR4s+tPNYLPMcI6Vrl8t/TTf9fWfcqCnsOj5btk4szbJk
         TIjyToJTrBeGUjrzQPj2iuUQCqvje250KGdiBDk5nN/gipEym4bgmqNlPRc0yBi0BFDI
         xAXQ==
X-Gm-Message-State: ABy/qLYmWIKg0gboxOlHpvLauvz9DwKBapceDyX/E2zMo282W9UlvkSb
        fxnKbGv5HuW0NwpNqgjA0DfHdv7jEUkTr1/ul3SbjPE1IrKDHa8DDYvextRzh+1siO4290mogM8
        1BUNw2mdYP8jgrD4o/LCCvKRk
X-Received: by 2002:a5d:58c5:0:b0:314:5f6f:68ce with SMTP id o5-20020a5d58c5000000b003145f6f68cemr3020442wrf.66.1688745982877;
        Fri, 07 Jul 2023 09:06:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH5cYvipoXxcLVPWrgX1VBfttdwQWGQsXJzVcd1hL47gcf10idF/3InhZjed94f6o29TxN3Jg==
X-Received: by 2002:a5d:58c5:0:b0:314:5f6f:68ce with SMTP id o5-20020a5d58c5000000b003145f6f68cemr3020411wrf.66.1688745982463;
        Fri, 07 Jul 2023 09:06:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d5908000000b0031437ec7ec1sm4858220wrd.2.2023.07.07.09.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 09:06:21 -0700 (PDT)
Message-ID: <a8fed7f8-d285-4628-da4b-0ff82c19c582@redhat.com>
Date:   Fri, 7 Jul 2023 18:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
 <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
 <ZKgZrNuxuq4ACvIb@casper.infradead.org>
 <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
 <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
In-Reply-To: <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 07.07.23 17:13, Ryan Roberts wrote:
> On 07/07/2023 15:07, David Hildenbrand wrote:
>> On 07.07.23 15:57, Matthew Wilcox wrote:
>>> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>>>> On 07.07.23 11:52, Ryan Roberts wrote:
>>>>> On 07/07/2023 09:01, Huang, Ying wrote:
>>>>>> Although we can use smaller page order for FLEXIBLE_THP, it's hard to
>>>>>> avoid internal fragmentation completely.  So, I think that finally we
>>>>>> will need to provide a mechanism for the users to opt out, e.g.,
>>>>>> something like "always madvise never" via
>>>>>> /sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
>>>>>> a good idea to reuse the existing interface of THP.
>>>>>
>>>>> I wouldn't want to tie this to the existing interface, simply because that
>>>>> implies that we would want to follow the "always" and "madvise" advice too;
>>>>> That
>>>>> means that on a thp=madvise system (which is certainly the case for android and
>>>>> other client systems) we would have to disable large anon folios for VMAs that
>>>>> haven't explicitly opted in. That breaks the intention that this should be an
>>>>> invisible performance boost. I think it's important to set the policy for
>>>>> use of
>>>>
>>>> It will never ever be a completely invisible performance boost, just like
>>>> ordinary THP.
>>>>
>>>> Using the exact same existing toggle is the right thing to do. If someone
>>>> specify "never" or "madvise", then do exactly that.
>>>>
>>>> It might make sense to have more modes or additional toggles, but
>>>> "madvise=never" means no memory waste.
>>>
>>> I hate the existing mechanisms.  They are an abdication of our
>>> responsibility, and an attempt to blame the user (be it the sysadmin
>>> or the programmer) of our code for using it wrongly.  We should not
>>> replicate this mistake.
>>
>> I don't agree regarding the programmer responsibility. In some cases the
>> programmer really doesn't want to get more memory populated than requested --
>> and knows exactly why setting MADV_NOHUGEPAGE is the right thing to do.
>>
>> Regarding the madvise=never/madvise/always (sys admin decision), memory waste
>> (and nailing down bugs or working around them in customer setups) have been very
>> good reasons to let the admin have a word.
>>
>>>
>>> Our code should be auto-tuning.  I posted a long, detailed outline here:
>>> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/
>>>
>>
>> Well, "auto-tuning" also should be perfect for everybody, but once reality
>> strikes you know it isn't.
>>
>> If people don't feel like using THP, let them have a word. The "madvise" config
>> option is probably more controversial. But the "always vs. never" absolutely
>> makes sense to me.
>>
>>>> I remember I raised it already in the past, but you *absolutely* have to
>>>> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
>>>> example, userfaultfd) that doesn't want the kernel to populate any
>>>> additional page tables. So if you have to respect that already, then also
>>>> respect MADV_HUGEPAGE, simple.
>>>
>>> Possibly having uffd enabled on a VMA should disable using large folios,
>>
>> There are cases where we enable uffd *after* already touching memory (postcopy
>> live migration in QEMU being the famous example). That doesn't fly.
>>
>>> I can get behind that.  But the notion that userspace knows what it's
>>> doing ... hahaha.  Just ignore the madvise flags.  Userspace doesn't
>>> know what it's doing.
>>
>> If user space sets MADV_NOHUGEPAGE, it exactly knows what it is doing ... in
>> some cases. And these include cases I care about messing with sparse VM memory :)
>>
>> I have strong opinions against populating more than required when user space set
>> MADV_NOHUGEPAGE.
> 
> I can see your point about honouring MADV_NOHUGEPAGE, so think that it is
> reasonable to fallback to allocating an order-0 page in a VMA that has it set.
> The app has gone out of its way to explicitly set it, after all.
> 
> I think the correct behaviour for the global thp controls (cmdline and sysfs)
> are less obvious though. I could get on board with disabling large anon folios
> globally when thp="never". But for other situations, I would prefer to keep
> large anon folios enabled (treat "madvise" as "always"), with the argument that
> their order is much smaller than traditional THP and therefore the internal
> fragmentation is significantly reduced. I really don't want to end up with user
> space ever having to opt-in (with MADV_HUGEPAGE) to see the benefits of large
> anon folios.

I was briefly playing with a nasty idea of an additional "madvise-pmd" 
option (that could be the new default), that would use PMD THP only in 
madvise'd regions, and ordinary everywhere else. But let's disregard 
that for now. I think there is a bigger issue (below).

> 
> I still feel that it would be better for the thp and large anon folio controls
> to be independent though - what's the argument for tying them together?

Thinking about desired 2 MiB flexible THP on aarch64 (64k kernel) vs, 2 
MiB PMD THP on aarch64 (4k kernel), how are they any different? Just the 
way they are mapped ...

It's easy to say "64k vs. 2 MiB" is a difference and we want separate 
controls, but how is "2MiB vs. 2 MiB" different?

Having that said, I think we have to make up our mind how much control 
we want to give user space. Again, the "2MiB vs. 2 MiB" case nicely 
shows that it's not trivial: memory waste is a real issue on some 
systems where we limit THP to madvise().


Just throwing it out for discussing:

What about keeping the "all / madvise / never" semantics (and 
MADV_NOHUGEPAGE ...) but having an additional config knob that specifies 
in which cases we *still* allow flexible THP even though the system was 
configured for "madvise".

I can't come up with a good name for that, but something like 
"max_auto_size=64k" could be something reasonable to set. We could have 
an arch+hw specific default.

(we all hate config options, I know, but I think there are good reasons 
to have such bare-minimum ones)

-- 
Cheers,

David / dhildenb

