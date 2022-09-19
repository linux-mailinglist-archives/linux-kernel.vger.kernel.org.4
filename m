Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8105BC563
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiISJbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiISJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E61FCC4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663579872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oE4JqwfpkTz6M2Oz21kLEomloGPhwfNZ/IsoD6mNtaA=;
        b=Rsvx8Iz+qQj3oxMQpOvTTEKUEglCViS/+B9G4X4NBcRuplJ+Ijrm6u/KaWwZukUCbBKw3j
        jBFFsKvhEWlrju/ERNoMvvNAfP5PusVeQTgYj9JcH1oR/gUAWg98s9P1N9O7nbs04Iy/iI
        QvbG17mayAlMQEo7vfbmX+qcfflIZyM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-FHuOvy5BPmm6nvmKE9jPHQ-1; Mon, 19 Sep 2022 05:31:10 -0400
X-MC-Unique: FHuOvy5BPmm6nvmKE9jPHQ-1
Received: by mail-wm1-f72.google.com with SMTP id c188-20020a1c35c5000000b003b2dee5fb58so14943930wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=oE4JqwfpkTz6M2Oz21kLEomloGPhwfNZ/IsoD6mNtaA=;
        b=l7DY91geo3icsYxXCcjo7ba+8HRYYAn0lpMqjDmrEhVxkBNs0usLA2IuqLIvyZqXD+
         EJfmizqMJtj4EvZ3ZhDx6XsNETL5jFhrMjX7EbrZOelIpHoT7rPWqHzR6mBfPipxWpWM
         5J5PP5HpWunUytUMPd1EdSeB7sAkyjTjNCeHwCbs7/U41IxzsnadQDazGOroiQzlV8+z
         8ER1eYQe/+WhglHKVAT6MSqqzvEeqzHXZUVqPaknwEhedwH2CvFSfI5kEV2okT3GxcVH
         q2jhl5EFztTPkMTBlF+knbtK8V3UajW151MmV5an82iFj0s7RjtQT/J00wgaWo7aRTfk
         k2bg==
X-Gm-Message-State: ACrzQf1HHCb29746VmAHDtFBknJcRffPWtXfGILxATv6IHhqrjgIBVS0
        HJh8pBRU/CUF2mJw8jZa0s/HjWmV2t3xyexanE3sCg2Kuw2Ckb9ORMMIaUoO2mxB+jj8ytgAgO0
        hg+GcjFODDk/m2jtwi1bYliei
X-Received: by 2002:a05:600c:524f:b0:3b4:7cfa:3ca3 with SMTP id fc15-20020a05600c524f00b003b47cfa3ca3mr11982347wmb.172.1663579869530;
        Mon, 19 Sep 2022 02:31:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XwNvaGWuGQAc8gFpPHrebwng7IhRM1HFXR46xCGdcomPFcKeXRR/dOilE5ejwvfIlYaCyEw==
X-Received: by 2002:a05:600c:524f:b0:3b4:7cfa:3ca3 with SMTP id fc15-20020a05600c524f00b003b47cfa3ca3mr11982336wmb.172.1663579869284;
        Mon, 19 Sep 2022 02:31:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000008900b00228cbac7a25sm13073328wrx.64.2022.09.19.02.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 02:31:08 -0700 (PDT)
Message-ID: <4475783a-73c1-94f1-804e-507abeb84ab1@redhat.com>
Date:   Mon, 19 Sep 2022 11:31:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Correlation CMA size and FORCE_MAX_ZONEORDER
Content-Language: en-US
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
 <826cd775-14d2-12ae-2e96-cf0766aa1502@redhat.com>
 <CAOf5uwmKfcC0OiiuN82tUzcE1XkPuA3N3u+o3Ue_ZPNJqeSM+g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAOf5uwmKfcC0OiiuN82tUzcE1XkPuA3N3u+o3Ue_ZPNJqeSM+g@mail.gmail.com>
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

On 19.09.22 11:17, Michael Nazzareno Trimarchi wrote:
> Hi David
> 
> On Mon, Sep 19, 2022 at 10:38 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 15.09.22 23:36, Michael Nazzareno Trimarchi wrote:
>>> Hi all
>>
>> Hi,
>>
>>>
>>> Working on a small device with 128MB of memory and using imx_v6_v7
>>> defconfig I found that CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE
>>> are not respected. The calculation done does not allow the requested
>>> size. I think that this should be somehow documented and described but
>>> I did not
>>> find the documentation. Does it work this way?
>>>
>>> With CMA_SIZE of 8MB I need to have FORCE_MAX_ZONEORDER=12 if I have
>>> the default FORCE_MAX_ZONEORDER=14 the min size is 32Mb
>>
>> The underlying constraint is that CMA regions require a certain minimum
>> alignment+size. They cannot be arbitrarily in size.
>>
>> CMA_MIN_ALIGNMENT_BYTES expresses that, and corresponds in upstream
>> kernels to the size of a single pageblock.
>>
>> In previous kernels, it used to be the size of the largest buddy
>> allocation granularity (derived from MAX_ORDER, derived from
>> FORCE_MAX_ZONEORDER).
>>
>> On upstream kernels, the FORCE_MAX_ZONEORDER constraint should no longer
>> apply. On most archs, the minimum alignment+size should be 2 MiB
>> (x86-64, aarch64 with 4k base pages) -- the size of a single pageblock.
>>
>> So far the theory. Are you still running into this limitation on
>> upstream kernels?
>>
> 
> I can run 6-rc2 on my board. I test again but according to it, if I
> put 4M as CMA in cma=4M in boot
> parameters, the result is 32Mb of CMA. Apart of that seems that
> process lime tiny membench can not even start
> to mblock memory
> 

The CMA alignemnt change went into v5.19. If "cma=4M" still gives you > 
4M, can you post /proc/meminfo and the early console output?


-- 
Thanks,

David / dhildenb

