Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A874D27D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGJKAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGJKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606119BD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688983075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxhdeuum+rQdb4EJhhx9EY5tMmwdfqA+NXTAeGpMu/I=;
        b=TLeppozGMtueBvo05wJLt4kOsLW4PLSAhDXGs8oAXkcd8nKJZG49GTBh38owD4d0x1x3sv
        rrcJ1kTJhYsW5jW01jZxMfz7vAGdzNmawkxnJX+9s6ipGtofy9P7+zVHXu9ebq/Ockc0/P
        cfWO4TuWxybxPkdwaLg0XgAhD/RVsuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-7jimqDVLNuWEW2wJ2Shl-Q-1; Mon, 10 Jul 2023 05:57:53 -0400
X-MC-Unique: 7jimqDVLNuWEW2wJ2Shl-Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc08035926so7239245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983072; x=1691575072;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxhdeuum+rQdb4EJhhx9EY5tMmwdfqA+NXTAeGpMu/I=;
        b=TGj8Tc/lSZH2t5webtLYtEG37qpjOS+TBYi/1NPaVs9aSzaeubtIKIMq7RAY0OyGIe
         HXrr3czKZH8eW8piBeceYJw3JU6/U4JOWNYm+x/vFgxoPGNFtzlXcRKzpghgWR3Ebk57
         Yf3CDgr+SXN8txamiF9rdInM5gmL0GJwVpv497BFqzMnvcrd2a8SkvIKykAi/IUq4aVV
         u69zYzjYGoC8XeeDOmArVKOGwmWjUww50POzkS6TKU2WKn9vrqc+0TzjpL2GltGZ5V+h
         rwjb4bMTLOkTv+MajfRqSuXIFGgq545BzhJeSDsNJFJQp8vL7HFsFjD/kWfvasXZuOgn
         DrUg==
X-Gm-Message-State: ABy/qLYLgdln2d/l5s0ZuHJ1uwbPP4WLXIsisS8FzZ0QUpjueT39Yz7r
        KucYBvAo609ukYs0GfIcWeC2U9uxGIKhkWIGjaHoslGpYbFuISl0SRXkOCa3VM0is63HdtJEVuW
        9ENdpi3liQnPDn8Pbcn5hfeVMHKInQbSi
X-Received: by 2002:a05:600c:1d04:b0:3fb:b075:8239 with SMTP id l4-20020a05600c1d0400b003fbb0758239mr13813111wms.4.1688983072389;
        Mon, 10 Jul 2023 02:57:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpBp/d9/gl1N7kcqv3jse3V7N8Lab6TNLefH1IBhwPuBidQSu2KOJazUzSaVfnkMEhjYn5hQ==
X-Received: by 2002:a05:600c:1d04:b0:3fb:b075:8239 with SMTP id l4-20020a05600c1d0400b003fbb0758239mr13813094wms.4.1688983071977;
        Mon, 10 Jul 2023 02:57:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:7500:b60f:a446:46f6:5acf? (p200300cbc7387500b60fa44646f65acf.dip0.t-ipconnect.de. [2003:cb:c738:7500:b60f:a446:46f6:5acf])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d67c7000000b0030ae3a6be4asm11297801wrw.72.2023.07.10.02.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:57:51 -0700 (PDT)
Message-ID: <967ccf33-0982-6042-e4ce-b0c859b4c3b1@redhat.com>
Date:   Mon, 10 Jul 2023 11:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
 <676ce1b3-6c72-011e-3a4f-723945db3d31@intel.com>
 <04efd5eb-06c2-d449-8427-d7c30df962d1@redhat.com>
 <b598c796-7bec-5ac7-9e7e-9a8b5d9ecba2@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
In-Reply-To: <b598c796-7bec-5ac7-9e7e-9a8b5d9ecba2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 11:43, Yin, Fengwei wrote:
> Hi David,
> 
> On 7/10/2023 5:32 PM, David Hildenbrand wrote:
>> On 09.07.23 15:25, Yin, Fengwei wrote:
>>>
>>>
>>> On 7/8/2023 12:02 PM, Matthew Wilcox wrote:
>>>> I would be tempted to allocate memory & copy to the new mlocked VMA.
>>>> The old folio will go on the deferred_list and be split later, or its
>>>> valid parts will be written to swap and then it can be freed.
>>> If the large folio splitting failure is because of GUP pages, can we
>>> do copy here?
>>>
>>> Let's say, if the GUP page is target of DMA operation and DMA operation
>>> is ongoing. We allocated a new page and copy GUP page content to the
>>> new page, the data in the new page can be corrupted.
>>
>> No, we may only replace anon pages that are flagged as maybe shared (!PageAnonExclusive). We must not replace pages that are exclusive (PageAnonExclusive) unless we first try marking them maybe shared. Clearing will fail if the page maybe pinned.
> Thanks a lot for clarification.
> 
> So my understanding is that if large folio splitting fails, it's not always
> true that we can allocate new folios, copy original large folio content to
> new folios, remove original large folio from VMA and map the new folios to
> VMA (like it's only true if original large folio is marked as maybe shared).
> 

While it might work in many cases, there are some corner cases where it 
won't work.

So to summarize

(1) THP are transparent and should not result in arbitrary syscall
     failures.
(2) Splitting a THP might fail at random points in time either due to
     GUP pins or due to speculative page references (including
     speculative GUP pins).
(3) Replacing an exclusive anon page that maybe pinned will result in
     memory corruptions.

So we can try to split any THP that crosses VMA borders on VMA 
modifications (split due to munmap, mremap, madvise, mprotect, mlock, 
...), it's not guaranteed to work due to (1). And we can try to replace 
pages such pages, but it's not guaranteed to be allowed due to (3).

And as it's all transparent, we cannot fail (1).

For the other cases that Willy and I discussed (split on VMA 
modifications after fork()), we can at least always replace the anon page.

<details>

What always works, is putting the THP on the deferred split queue to see 
if we can split it later. The deferred split queue is a bit suboptimal 
right now, because it requires the (sub)page mapcounts to detect whether 
the folio is partially mapped vs. fully mapped. If we want to get rid of 
that, we have to come up with something reasonable.

I was wondering if we could have a an optimized deferred split queue, 
that only conditionally splits: do an rmap walk and detect if (a) each 
page of the folio is still mapped (b) the folio does not cross a VMA. If 
both are met, one could skip the deferred split. But that needs a bit of 
thought -- but we're already doing an rmap walk when splitting, so 
scanning which parts are actually mapped does not sound too weird.

</details>

-- 
Cheers,

David / dhildenb

