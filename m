Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12DB6B3DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCJL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC95C80AB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678447542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wnd+07RC7REbUFCKV/Th3JnGXK55wayqDQMn9UZgDc0=;
        b=Z2OvGRelR1YkZanx+Rl8dB69GDgZx12PFtJusProLTU6g5w+8ejV4kku28K8jkkidrZGKf
        IAW8ETrJ6NlYVCliCphOPQwJonm0bHW9pZzwgpOdpckeTSCv3x2/wi8jMw6cycgvnZGx2n
        s2tsnTi6owLz3bXWl/rDfTygm7qIp4Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-coFqZZ1VOjGHJL2CH3rLuA-1; Fri, 10 Mar 2023 06:25:41 -0500
X-MC-Unique: coFqZZ1VOjGHJL2CH3rLuA-1
Received: by mail-wm1-f70.google.com with SMTP id k26-20020a05600c0b5a00b003dfe4bae099so1869373wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678447540;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wnd+07RC7REbUFCKV/Th3JnGXK55wayqDQMn9UZgDc0=;
        b=rK6zdL+iq9HPr+M1R3Ht+lK9eYhJcw7sCyho2jB/+xxON4l3R3SXQ1XHaQlxfAODS8
         UtMtFr14AlbgjWO1ASJY9JNaU9hqwr7DzLaZT00lQTwirzsEVCSMfQxlLSL6IdTFfjeZ
         r5HFJhYsMekxLrBexrme6Eao+f+Fl4tcawO30Xhfu6eFLSqSI+QjjEsJ+fmK5NSU4dD6
         7ZEbvx34/Kvo+uGyczwyT1nKK8MLiNIoLsmnkjWva6yLjGmDyXsCc6GED9/7pAcoCXAN
         qFN2au/1LI7S5GPw6cwAOjT0fwAlH/qTeYEZ7aPPz3kc69coZud22tbzIZqGRIv1xgXy
         xl5w==
X-Gm-Message-State: AO0yUKXeJ8KAqfQe1Tn7l/+F0XOND1CEsr/zV1fJlI8ORMAg+q76xgTv
        YhL2qD/qy3UG71svclGRmuXsJ97oHR/99PQt5Qfolp7gYS9+O6XWxvYUzk3/BZjGCpvI+vQZ8p2
        fArH5MkDIj742SnXUfFfXgCt8
X-Received: by 2002:a05:600c:1c18:b0:3eb:40de:9838 with SMTP id j24-20020a05600c1c1800b003eb40de9838mr1493787wms.7.1678447540111;
        Fri, 10 Mar 2023 03:25:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9Gs81tceVs9wUO6S04OgBq58QF0bgNdk/WOJfvkRngarnjh92tvKWEeNaXnZ8S9MvTf4e2sg==
X-Received: by 2002:a05:600c:1c18:b0:3eb:40de:9838 with SMTP id j24-20020a05600c1c1800b003eb40de9838mr1493775wms.7.1678447539807;
        Fri, 10 Mar 2023 03:25:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1100:12e6:ffa5:775d:18ee? (p200300cbc707110012e6ffa5775d18ee.dip0.t-ipconnect.de. [2003:cb:c707:1100:12e6:ffa5:775d:18ee])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003e20a6fd604sm1812910wmh.4.2023.03.10.03.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 03:25:39 -0800 (PST)
Message-ID: <9f44de08-b484-baa7-80c8-0a02a7abb717@redhat.com>
Date:   Fri, 10 Mar 2023 12:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: THP backed thread stacks
Content-Language: en-US
To:     William Kucharski <william.kucharski@oracle.com>,
        Zach O'Keefe <zokeefe@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
 <20230309233340.GC3700@monkey>
 <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
 <9F855331-33B2-4366-9375-988B0D3DAC98@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9F855331-33B2-4366-9375-988B0D3DAC98@oracle.com>
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

On 10.03.23 02:40, William Kucharski wrote:
> 
> 
>> On Mar 9, 2023, at 17:05, Zach O'Keefe <zokeefe@google.com> wrote:
>>
>>> I think the hugepage alignment in their environment was somewhat luck.
>>> One suggestion made was to change stack size to avoid alignment and
>>> hugepage usage.  That 'works' but seems kind of hackish.
>>
>> That was my first thought, if the alignment was purely due to luck,
>> and not somebody manually specifying it. Agreed it's kind of hackish
>> if anyone can get bit by this by sheer luck.
> 
> I don't agree it's "hackish" at all, but I go more into that below.
> 
>>
>>> Also, David H pointed out the somewhat recent commit to align sufficiently
>>> large mappings to THP boundaries.  This is going to make all stacks huge
>>> page aligned.
>>
>> I think that change was reverted by Linus in commit 0ba09b173387
>> ("Revert "mm: align larger anonymous mappings on THP boundaries""),
>> until it's perf regressions were better understood -- and I haven't
>> seen a revamp of it.
> 
> It's too bad it was reverted, though I understand the concerns regarding it.
> 
>  From my point of view, if an address is properly aligned and a caller is
> asking for 2M+ to be mapped, it's going to be advantageous from a purely
> system-focused point of view to do that mapping with a THP. 

Just noting that, if user space requests multiple smaller mappings, and 
the kernel decides to all place them in the same PMD, all VMAs might get 
merged and you end up with a properly aligned VMA where khugepaged would 
happily place a THP.

That case is, of course, different to the "user space asks for 2M+" 
mapping case, but from khugepaged perspective they might look alike -- 
and it might be unclear if a THP is valuable or not (IOW maybe that THP 
could be better used somewhere else).

-- 
Thanks,

David / dhildenb

