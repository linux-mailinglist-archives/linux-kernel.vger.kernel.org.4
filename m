Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D965BCA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiISLDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiISLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEB182
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663585409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwUo7Yxu7g8KKedrheqIyBOp5MS1QkWmkQipZH0FhJE=;
        b=GfnGjMurErX5c9458dLPKkNLx9uGgaE9msk0Xe1bwmbdMEWapHftbFkZ2VJyEQX7MWo5W1
        ft2gYyGABByvOmcPj56bI5ZkxtpyTHzYq1EqU/Mw1jgpIs64He6XpxXdU+65qb02BDj7Ny
        J5PTzNUUjLT6h4XERlAK4zn78o2Uagc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-jLxoOsZxORSxPtucsRljTw-1; Mon, 19 Sep 2022 07:03:28 -0400
X-MC-Unique: jLxoOsZxORSxPtucsRljTw-1
Received: by mail-wr1-f71.google.com with SMTP id m29-20020adfa3dd000000b00224f577fad1so5994711wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=UwUo7Yxu7g8KKedrheqIyBOp5MS1QkWmkQipZH0FhJE=;
        b=awEmniMCRwLWFkRhzevSugFhy0QXlTSWnXDboO9iJuZMz4kOYfqlpvWPm0OuCcx/JW
         22JKPwSjrcUqD3ppfKH7wQACe1YtJUlELmAycOvjjsxGhblDn7m0CS3vU11AahUWtnuf
         Fs0BtPs4OkasKd5TkYCjHL5mhl39Uvwo/sv298x6m1h20cdvp+05jat9XFKSE11CfuRM
         1rwTohhwNWFQ8ZxM7f+85hwKR2qsrBhl5tEjES9UN1ANsqFy94KnnL2D4JZtWHOpWtzD
         Rxa3yIsq5kJT3e+gQDVYnhFkSIwhKMrjXvDIEy0ugrOkXJZAqRGi+q38bkchkvpiC1cj
         fgbg==
X-Gm-Message-State: ACgBeo1ic210n3RNZHN2V8JvmN9ueamwwyki+WUXokBv5UYo+06FLA9I
        9UZSHMpT7ax7Zgg3WTDMhNNZ08CTn+CPTSaJlkMybZrHikFIJdFsLj4eKTZJ2rffS4YRe0OIF2/
        EMFlrlMAjDq8J5O9secwzFAOs
X-Received: by 2002:a05:600c:4a9a:b0:3b4:78ab:bae5 with SMTP id b26-20020a05600c4a9a00b003b478abbae5mr19337807wmp.114.1663585407371;
        Mon, 19 Sep 2022 04:03:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77AQ9diuaa3dMtIY99pQ/ZvPkqg8kmkNf7q+UBOiYN60Jpb6K7ASAZpB5ago4wTtKQVvlK2g==
X-Received: by 2002:a05:600c:4a9a:b0:3b4:78ab:bae5 with SMTP id b26-20020a05600c4a9a00b003b478abbae5mr19337772wmp.114.1663585407073;
        Mon, 19 Sep 2022 04:03:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4d02000000b00226dfac0149sm13520502wrt.114.2022.09.19.04.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:03:26 -0700 (PDT)
Message-ID: <c2efeb24-0da0-ee25-7cb9-2b9b05523f25@redhat.com>
Date:   Mon, 19 Sep 2022 13:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
 <826cd775-14d2-12ae-2e96-cf0766aa1502@redhat.com>
 <CAOf5uwmKfcC0OiiuN82tUzcE1XkPuA3N3u+o3Ue_ZPNJqeSM+g@mail.gmail.com>
 <4475783a-73c1-94f1-804e-507abeb84ab1@redhat.com>
 <CAOf5uwk8RLRrMa3vM-1+k0oi8XfnWVZH6_uc_UtagWYFVrMYKQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Correlation CMA size and FORCE_MAX_ZONEORDER
In-Reply-To: <CAOf5uwk8RLRrMa3vM-1+k0oi8XfnWVZH6_uc_UtagWYFVrMYKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.22 11:57, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Mon, Sep 19, 2022 at 11:31 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.09.22 11:17, Michael Nazzareno Trimarchi wrote:
>>> Hi David
>>>
>>> On Mon, Sep 19, 2022 at 10:38 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 15.09.22 23:36, Michael Nazzareno Trimarchi wrote:
>>>>> Hi all
>>>>
>>>> Hi,
>>>>
>>>>>
>>>>> Working on a small device with 128MB of memory and using imx_v6_v7
>>>>> defconfig I found that CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE
>>>>> are not respected. The calculation done does not allow the requested
>>>>> size. I think that this should be somehow documented and described but
>>>>> I did not
>>>>> find the documentation. Does it work this way?
>>>>>
>>>>> With CMA_SIZE of 8MB I need to have FORCE_MAX_ZONEORDER=12 if I have
>>>>> the default FORCE_MAX_ZONEORDER=14 the min size is 32Mb
>>>>
>>>> The underlying constraint is that CMA regions require a certain minimum
>>>> alignment+size. They cannot be arbitrarily in size.
>>>>
>>>> CMA_MIN_ALIGNMENT_BYTES expresses that, and corresponds in upstream
>>>> kernels to the size of a single pageblock.
>>>>
>>>> In previous kernels, it used to be the size of the largest buddy
>>>> allocation granularity (derived from MAX_ORDER, derived from
>>>> FORCE_MAX_ZONEORDER).
>>>>
>>>> On upstream kernels, the FORCE_MAX_ZONEORDER constraint should no longer
>>>> apply. On most archs, the minimum alignment+size should be 2 MiB
>>>> (x86-64, aarch64 with 4k base pages) -- the size of a single pageblock.
>>>>
>>>> So far the theory. Are you still running into this limitation on
>>>> upstream kernels?
>>>>
>>>
>>> I can run 6-rc2 on my board. I test again but according to it, if I
>>> put 4M as CMA in cma=4M in boot
>>> parameters, the result is 32Mb of CMA. Apart of that seems that
>>> process lime tiny membench can not even start
>>> to mblock memory
>>>
>>
>> The CMA alignemnt change went into v5.19. If "cma=4M" still gives you >
>> 4M, can you post /proc/meminfo and the early console output?
>>
> 
> cat /proc/cmdline
> cma=4M mtdparts=gpmi-nand:4m(nandboot),1m(env),24m(kernel),1m(nanddtb),-(rootfs)
> root=ubi0:root rw ubi.mtd=ro
> otfs rootfstype=ubifs rootwait=1
> # cat /proc/meminfo
> MemTotal:         109560 kB
> MemFree:           56084 kB
> MemAvailable:      56820 kB
> Buffers:               0 kB
> Cached:            39680 kB
> SwapCached:            0 kB
> Active:               44 kB
> Inactive:            644 kB
> Active(anon):         44 kB
> Inactive(anon):      644 kB
> Active(file):          0 kB
> Inactive(file):        0 kB
> Unevictable:       39596 kB
> Mlocked:               0 kB
> HighTotal:             0 kB
> HighFree:              0 kB
> LowTotal:         109560 kB
> LowFree:           56084 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:           628 kB
> Mapped:             1480 kB
> Shmem:                84 kB
> KReclaimable:       4268 kB
> Slab:               8456 kB
> SReclaimable:       4268 kB
> SUnreclaim:         4188 kB
> KernelStack:         392 kB
> PageTables:           88 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       54780 kB
> Committed_AS:       1876 kB
> VmallocTotal:     901120 kB
> VmallocUsed:        2776 kB
> VmallocChunk:          0 kB
> Percpu:               72 kB
> CmaTotal:          32768 kB
> CmaFree:           32484 kB
> # uname -a
> Linux buildroot 6.0.0-rc5 #20 SMP Mon Sep 19 11:51:26 CEST 2022 armv7l GNU/Linux
> #
> 
> Then here https://pastebin.com/6MUB2VBM dmesg
> 
> CONFIG_ARM_MODULE_PLTS=y
> CONFIG_FORCE_MAX_ZONEORDER=14
> CONFIG_ALIGNMENT_TRAP=y
> ...
> CONFIG_CMA
> CONFIG_CMA_AREAS=7
> ...
> 
> CONFIG_CMA_SIZE_MBYTES=8
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> 

Thanks!

I assume that in your setup, the pageblock size depends on MAX_ORDER 
and, therefore, FORCE_MAX_ZONEORDER.

This should be the case especially if CONFIG_HUGETLB_PAGE is not defined 
(include/linux/pageblock-flags.h).

In contrast to what I remember, the pageblock size does not seem to 
depend on the THP size (weird) as well.


So, yes, that limitation is still in effect for some kernel configs.

One could make the pageblock size configurable (similar to 
CONFIG_HUGETLB_PAGE_SIZE_VARIABLE) or simply default to a smaller 
pageblock size as default with CONFIG_CMA and !CONFIG_HUGETLB_PAGE.

I imagine something reasonable might be to set the pageblock size to 
2MiB without CONFIG_HUGETLB_PAGE but with CONFIG_CMA.

-- 
Thanks,

David / dhildenb

