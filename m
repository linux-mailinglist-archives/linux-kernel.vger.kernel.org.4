Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1319672BF67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjFLKnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjFLKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE64EF5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686565626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dqx/dOTiUNpv7HB25tV0EBriLdezn58c/nIheim7g30=;
        b=HdBasNIG4B2vEwvM21hr8GYlsMUuIc8hF/ZpkfpnAjraEVvYMyJbEdbRfoOqxPtmDzv2jf
        zeMqmZTXBhtyo2a6ghyCvdjn7l+G7R+mK6Wzbrb25VgVv/nyw6AnD8xiWsPU1r7sWmHo+Q
        uVApoN2ocx189F5drhldNQXcNG2YyIk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-htRKrI7AP-q_gW1uT6qMKw-1; Mon, 12 Jun 2023 06:01:24 -0400
X-MC-Unique: htRKrI7AP-q_gW1uT6qMKw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e8c24a92so15440505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564083; x=1689156083;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dqx/dOTiUNpv7HB25tV0EBriLdezn58c/nIheim7g30=;
        b=e7NxwYNgW3kXfUIF+KAydZ6OFrPyzqL/mI/TvfcmxVpM8cYDy11a/bfslay8T0n+cm
         h9p6lenm4TSp8Yd2nhAKHOIQnbMOBm5HDkZBebX/sNOIL6axOU72dA+mn/0McwqVYGGu
         McH7Gz1DJ5za8DZ7HWiLAqIHEW2T8j08xOaxV28D0YmUNTRVO13mhG4GvJxLRXOp6TgG
         gP3EQ7lEfzt5gzTGqsB3pHaMWjRSzdbLyb1LColp6n629ld6x0nlRu1DLNQx7v1zcXMH
         iVjtvLJ/uu70U3DpUkSNEGQzloY7YfYmNNW7h9wtguGhCzpZoVXTCFWlEQUe1h2RV50e
         Qyzw==
X-Gm-Message-State: AC+VfDw6Fnnjj0uY4t9j9IbrMItr4NjcwO8F2P/HuWnkPhWQtOYLoFn/
        6phbrtGHI4Is5u89b905Co/zsGLmo1hk36CZDvc4G/gPXLpiuViF8VBwirppxVdP9Cg3SS3+akV
        hMPvQXp5W/ngLwYQrG/CPy4V9
X-Received: by 2002:a1c:7203:0:b0:3f6:58ad:ed85 with SMTP id n3-20020a1c7203000000b003f658aded85mr5769396wmc.10.1686564082909;
        Mon, 12 Jun 2023 03:01:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xVh4pila2/w97ktJHiDUKA1oBeqlgc+boWkYF7WG/ABffiXi36f0T+EHeh5DRCOkNArJqtA==
X-Received: by 2002:a1c:7203:0:b0:3f6:58ad:ed85 with SMTP id n3-20020a1c7203000000b003f658aded85mr5769375wmc.10.1686564082545;
        Mon, 12 Jun 2023 03:01:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe350000000b0030e5b1fffc3sm12031233wrj.9.2023.06.12.03.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:01:21 -0700 (PDT)
Message-ID: <b72118b0-47dc-86c4-15fb-fb5ea72bcf30@redhat.com>
Date:   Mon, 12 Jun 2023 12:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv5] mm: skip CMA pages when they are not available
Content-Language: en-US
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
References: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org>
 <a562bae0-d779-620a-98bc-6102468aecae@redhat.com>
 <CAGWkznFv=LjrjdqvepYtMP-e5JRp2wuWakd=CGLQQZ7aBx36Hg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAGWkznFv=LjrjdqvepYtMP-e5JRp2wuWakd=CGLQQZ7aBx36Hg@mail.gmail.com>
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

On 12.06.23 11:35, Zhaoyang Huang wrote:
> On Mon, Jun 12, 2023 at 5:29 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 10.06.23 00:35, Andrew Morton wrote:
>>> On Wed, 31 May 2023 10:51:01 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
>>>
>>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>>
>>>> This patch fixes unproductive reclaiming of CMA pages by skipping them when they
>>>> are not available for current context. It is arise from bellowing OOM issue, which
>>>> caused by large proportion of MIGRATE_CMA pages among free pages.
>>>>
>>>> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
>>>> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
>>>> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
>>>> ...
>>>> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
>>>> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
>>>> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0
>>>>
>>>
>>> We saw plenty of feedback for earlier versions, but now silence.  Does
>>> this mean we're all OK with v5?
>>
>> The logic kind-of makes sense to me (but the kswapd special-casing
>> already shows that it might be a bit fragile for future use), but I did
>> not yet figure out if this actually fixes something or is a pure
>> performance improvement.
>>
>> As we phrased it in the comment "It is waste of effort", but in the
>> patch description "This patch fixes unproductive reclaiming" + a scary
>> dmesg.
>>
>> Am I correct that this is a pure performance optimization (and the issue
>> revealed itself in that OOM report), or does this actually *fix* something?
>>
>> If it's a performance improvement, it would be good to show that it is
>> an actual improvement worth the churn ...
> Sorry for the confusion. As for the OOM issue, the previous
> commit(https://lkml.kernel.org/r/1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com)
> helps to decrease the fail rate from 12/20 to 2/20, which it turn to
> be 0 when applying this patch.

Thanks! Can we make that clearer in the patch description? I'm 
struggling a bit my self to find the right words.

Something like

"This change further decreases the chance for wrong OOMs in the presence 
of a lot of CMA memory."

?

In any case

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

