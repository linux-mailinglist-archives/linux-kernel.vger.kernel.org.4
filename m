Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32FB698520
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBOUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBOUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B933D93D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676491255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pM6ZuLLAVBgaXnAlM0ysAj5P46WWetvT+AboXXV0/P0=;
        b=jCCwlo1hscl0u9sE0K2gxZcse439KplXToIbLI0AnEg7eNW4EFqjzhp+tfWsjs1JxI6Fob
        f+Y8rUsjIXq3Jj7jhGw1FDDpiR/jZBciysZ8whplf7LVNEht+koPaaeX7YTRtp1LJg7dRQ
        5Obcr9DfjgbJ06kqkzhPtIr+cF70bn4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-IqE_8EzrPp-YBi4lJQgzOA-1; Wed, 15 Feb 2023 15:00:53 -0500
X-MC-Unique: IqE_8EzrPp-YBi4lJQgzOA-1
Received: by mail-wr1-f72.google.com with SMTP id o9-20020adfa109000000b002bfc062eaa8so3935122wro.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM6ZuLLAVBgaXnAlM0ysAj5P46WWetvT+AboXXV0/P0=;
        b=LWmBHex9mNT8Oh+/PqymRma/PoVsvI9FItO95/4AwlyRRUyEb9P5n72F/S1BwTUuST
         ML3P+U6lb+LoNAweZXB/7lnyzTV0leb6+eiNSB+dd2x4Rab0SpGJ/uTQqM788Dz31s+r
         MPEfPuTFmlouK4dUeZd+i6KGJjzjRk4M5+9B15NJbzN+MZftdG7uPHSkMY+LVCGx3vQp
         57RwFd9dildWyallTzZMTEjsZOmAs70OOqY7eb6mI0QzxmTu19pTXH22fRCcmYCnhdCi
         ClCrQR8zRThctKekJPx7IpyAAE/9RfM0vGfGBaiDcmXWAreMxRBDer4xUTTzz4mvAET+
         zh1g==
X-Gm-Message-State: AO0yUKXn/nwQv9NPOyV8CAfiZH6Shw+nOOLwQyNQoRuGe0fll7DKSUEM
        Vf0p05MFq8H7qNn+sTC0lz7urmyMMC4Pc/6U7Ffjfqz2ldRGml1HqVRjUdAYP86XlWMEyq2CW6Q
        wKpaeBpXLttW5GRMqHRNbTvvlOdJ1gQ==
X-Received: by 2002:a5d:544b:0:b0:2c5:534d:eebb with SMTP id w11-20020a5d544b000000b002c5534deebbmr2901864wrv.13.1676491252230;
        Wed, 15 Feb 2023 12:00:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8yuqeosoikVPd5aJzudaeycPQRLEyT0zOy6UwFihA/3b+WnGmJgbNqpboh+yuCfhJLq2KqCg==
X-Received: by 2002:a5d:544b:0:b0:2c5:534d:eebb with SMTP id w11-20020a5d544b000000b002c5534deebbmr2901840wrv.13.1676491251804;
        Wed, 15 Feb 2023 12:00:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1400:b7d:4122:28d:f4c3? (p200300cbc70714000b7d4122028df4c3.dip0.t-ipconnect.de. [2003:cb:c707:1400:b7d:4122:28d:f4c3])
        by smtp.gmail.com with ESMTPSA id d1-20020adffd81000000b002bfe08c566fsm15989893wrr.106.2023.02.15.12.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:00:51 -0800 (PST)
Message-ID: <1ddc2eff-f1bd-be62-3c62-abe6d539feef@redhat.com>
Date:   Wed, 15 Feb 2023 21:00:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/memory_hotplug: return zero from do_migrate_range()
 for only success
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230215180316.75431-1-sj@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230215180316.75431-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.23 19:03, SeongJae Park wrote:
> On Wed, 15 Feb 2023 14:16:05 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.02.23 23:32, SeongJae Park wrote:
>>> do_migrate_range() returns migrate_pages() return value, which zero
>>> means perfect success, in usual cases.  If all pages are failed to be
>>> isolated, however, it returns isolate_{lru,movalbe}_page() return
>>> values, or zero if all pfn were invalid, were hugetlb or hwpoisoned.  So
>>> do_migrate_range() returning zero means either perfect success, or
>>> special cases of isolation total failure.
>>>
>>> Actually, the return value is not checked by any caller, so it might be
>>> better to simply make it a void function.  However, there is a TODO for
>>> checking the return value.
>>
>> I'd prefer to not add more dead code ;) Let's not return an error instead.
> 
> Makes sense, I will send next spin soon.
> 
>>
>> It's still unclear which kind of fatal migration issues we actually care
>> about and how to really detect them.
> 
> What do you think about treating the isolation/migration rate limit
> (migrate_rs) hit in do_migrate_range() as fatal?  It warns for the event
> already, so definitely a bad sign.
> 
> If that's not that bad enough to be treated as fatal, I think we could have yet
> another rate limit to be considered fatal.

IIRC, there are some setups where offlining might take several minutes 
(e.g., heavy O_DIRECT load) and that's to be expected.

So the existing code warns for better debugging, but keeps trying. So 
the ratelimit is rather to not produce too much debug output, not to 
really indicate that something is fatal.

-- 
Thanks,

David / dhildenb

