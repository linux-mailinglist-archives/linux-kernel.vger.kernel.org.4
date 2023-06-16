Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8BF732A04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjFPIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbjFPIh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF0ED
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686904634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8IfjRY0f8BdXm8pFP8WTJ/+9yrpb0bBo4i74RqlpNw=;
        b=OitshKOWioXtuY4GoS1j2MyrDHXIo4wErcdvdgcb040mYZdVn4HS0vfkk3mx68yTY2FWMY
        SnFkC3aUkB6rw4Q6AoJ9/aPU524MzlnLCs0fepctJmZ1CLEAVaxmYN6v2C7+NdzzIKK7vk
        +/H0OQJ42Y1YCCVsQAaYQtfN2ETL4OA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-bLU45P9GPJiNxUyCg78rAw-1; Fri, 16 Jun 2023 04:37:12 -0400
X-MC-Unique: bLU45P9GPJiNxUyCg78rAw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30fa3ea38bcso138238f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904631; x=1689496631;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8IfjRY0f8BdXm8pFP8WTJ/+9yrpb0bBo4i74RqlpNw=;
        b=mEgteqRxn2tCCsMezSIxK7V+gIq6vbFVtj37dmJ+xRPM7pAj8xGB9kGDfUHpm+v1VP
         YPYC0w4vv8IdFNC0XQqc5tvp9T+h3aDr25RBs9jBkm5ABu1GhCw6prQ3FDGo7BsAPW8d
         KSpTPSb3l7Xh0IS/QfB+BI+nGbEbW3EI6FizxSnuwubOcZQdBr63z8m0R4fgU3ehjHfK
         X2xD31rDoC7WIGhxyzsaK8ImrgwkuPd4ujtMjpLzLi3B4mdXylmxpui535AGWzL9k4GL
         +xGdCuI4ZZ2NPdw1ybr5rps2O8YJ//F5+i1R7+bYtuGvUGEyt6oMmEXNQPPew4LJrg9P
         /WWg==
X-Gm-Message-State: AC+VfDx1Q3DGM52+G0rNDEgUMGtwxWV85NR9+Itv5t4b6/GWZzmQqZp2
        Q7R8V8bLPoXBxhXOg1NoSho0f4mwrqb1cAJ9bBaazT+Y1SebK/YNVB4p1hk/aqtmCuiuP5gfJRe
        kERLPHYJFGT7UEzVHJSPIbE+F
X-Received: by 2002:adf:ded1:0:b0:30f:c54a:711c with SMTP id i17-20020adfded1000000b0030fc54a711cmr609146wrn.15.1686904631533;
        Fri, 16 Jun 2023 01:37:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YkCdEf3nZqMA+yMqs/owMpyTWMc8hEG+1DxNTU/2scTVebxwZFD7BuiM4IDJ7c75YdrqRQw==
X-Received: by 2002:adf:ded1:0:b0:30f:c54a:711c with SMTP id i17-20020adfded1000000b0030fc54a711cmr609132wrn.15.1686904631095;
        Fri, 16 Jun 2023 01:37:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id h14-20020adff4ce000000b0030c40e2cf42sm22876104wrp.116.2023.06.16.01.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:37:10 -0700 (PDT)
Message-ID: <dede2f5b-2ae5-6fa3-c0d5-3ce7fba11694@redhat.com>
Date:   Fri, 16 Jun 2023 10:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>,
        Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
 <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
 <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
 <CAJD7tka4Uc1DhNzKbrj71vGyVVA12bJivPUQU7P0DOinunLgGg@mail.gmail.com>
 <576b7ba6-4dcd-48c9-3917-4e2a25aaa823@redhat.com>
 <CAJD7tkaS-wRjGjKbmN-HfiKJNTX0+PDdtw83NefEQ8nYAFznog@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
In-Reply-To: <CAJD7tkaS-wRjGjKbmN-HfiKJNTX0+PDdtw83NefEQ8nYAFznog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 10:04, Yosry Ahmed wrote:
> On Fri, Jun 16, 2023 at 12:57 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 16.06.23 09:37, Yosry Ahmed wrote:
>>> On Thu, Jun 15, 2023 at 9:41 PM 贺中坤 <hezhongkun.hzk@bytedance.com> wrote:
>>>>
>>>>> Thanks Fabian for tagging me.
>>>>>
>>>>> I am not familiar with #1, so I will speak to #2. Zhongkun, There are
>>>>> a few parts that I do not understand -- hopefully you can help me out
>>>>> here:
>>>>>
>>>>> (1) If I understand correctly in this patch we set the active memcg
>>>>> trying to charge any pages allocated in a zspage to the current memcg,
>>>>> yet that zspage will contain multiple compressed object slots, not
>>>>> just the one used by this memcg. Aren't we overcharging the memcg?
>>>>> Basically the first memcg that happens to allocate the zspage will pay
>>>>> for all the objects in this zspage, even after it stops using the
>>>>> zspage completely?
>>>>
>>>> It will not overcharge.  As you said below, we are not using
>>>> __GFP_ACCOUNT and charging the compressed slots to the memcgs.
>>>>
>>>>>
>>>>> (2) Patch 3 seems to be charging the compressed slots to the memcgs,
>>>>> yet this patch is trying to charge the entire zspage. Aren't we double
>>>>> charging the zspage? I am guessing this isn't happening because (as
>>>>> Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
>>>>> this patch may be NOP, and the actual charging is coming from patch 3
>>>>> only.
>>>>
>>>> YES， the actual charging is coming from patch 3. This patch just
>>>> delivers the BIO page's  memcg to the current task which is not the
>>>> consumer.
>>>>
>>>>>
>>>>> (3) Zswap recently implemented per-memcg charging of compressed
>>>>> objects in a much simpler way. If your main interest is #2 (which is
>>>>> what I understand from the commit log), it seems like zswap might be
>>>>> providing this already? Why can't you use zswap? Is it the fact that
>>>>> zswap requires a backing swapfile?
>>>>
>>>> Thanks for your reply and review. Yes, the zswap requires a backing
>>>> swapfile. The I/O path is very complex, sometimes it will throttle the
>>>> whole system if some resources are short , so we hope to use zram.
>>>
>>> Is the only problem with zswap for you the requirement of a backing swapfile?
>>>
>>> If yes, I am in the early stages of developing a solution to make
>>> zswap work without a backing swapfile. This was discussed in LSF/MM
>>> [1]. Would this make zswap usable in for your use case?
>>
>> Out of curiosity, are there any other known pros/cons when using
>> zswap-without-swap instead of zram?
>>
>> I know that zram requires sizing (size of the virtual block device) and
>> consumes metadata, zswap doesn't.
> 
> We don't use zram in our data centers so I am not an expert about
> zram, but off the top of my head there are a few more advantages to
> zswap:

Thanks!

> (1) Better memcg support (which this series is attempting to address
> in zram, although in a much more complicated way).

Right. I think this patch also misses to update apply the charging in the recompress
case. (only triggered by user space IIUC)

> 
> (2) We internally have incompressible memory handling on top of zswap,
> which is something that we would like to upstream when
> zswap-without-swap is supported. Basically if a page does not compress
> well enough to save memory we reject it from zswap and make it
> unevictable (if there is no backing swapfile). The existence of zswap
> in the MM layer helps with this. Since zram is a block device from the
> MM perspective, it's more difficult to do something like this.
> Incompressible pages just sit in zram AFAICT.

I see. With ZRAM_HUGE we still have to store the uncompressed page
(because, it's a block device and has to hold that data).

> 
> (3) Writeback support. If you're running out of memory to store
> compressed pages you can add a swapfile in runtime and zswap will
> start writing to it freeing up space to compress more pages. This
> wouldn't be possible in the same way in zram. Zram supports writing to
> a backing device but in a more manual way (userspace has to write to
> an interface to tell zram to write some pages).

Right, that zram backing device stuff is really sub-optimal and only useful
in corner cases (most probably not datacenters).

What one can do with zram is to add a second swap device with lower priority.
Looking at my Fedora machine:

  $ cat /proc/swaps
Filename                                Type            Size            Used            Priority
/dev/dm-2                               partition       16588796        0               -2
/dev/zram0                              partition       8388604         0               100


Guess the difference here is that you won't be writing out the compressed
data to the disk, but anything the gets swapped out afterwards will
end up on the disk. I can see how the zswap behavior might be better in that case
(instead of swapping out some additional pages you relocate the
already-swapped-out-to-zswap pages to the disk).

-- 
Cheers,

David / dhildenb

