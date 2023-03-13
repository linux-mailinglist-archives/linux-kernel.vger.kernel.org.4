Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF416B7863
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCMNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCMNEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AD664F1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678712619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/DLfot4JSpsy3w7Ct1qHyh3IvVJ9dCmlGzWXj2vp5k=;
        b=E8nSaRky6YqWWTh0OHr34/XpOhyrCxdI1woorOA1uqYvvrhAJ+vfMB/5kaf2SfWJrbcj30
        rqLh2wZ6kaBsULRuXCbEfhBJNHDFUbzOUBjuVZVzj+KtTusgY2uvcvAvuZ4Z67pndTgjt5
        LBv/s0wmqnUMfQKvsg6Sh4A6tV4RPTE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-U64xEay1On2U9x626COnsw-1; Mon, 13 Mar 2023 09:03:38 -0400
X-MC-Unique: U64xEay1On2U9x626COnsw-1
Received: by mail-wr1-f69.google.com with SMTP id i18-20020a05600011d200b002c94d861113so2105940wrx.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712615;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/DLfot4JSpsy3w7Ct1qHyh3IvVJ9dCmlGzWXj2vp5k=;
        b=Y9fbA/iOn3N9Qkl+kyheZ1/h5d74fP0E7/LI/SYfsvJfNOHgiyYk3s0sMKj0PkAbms
         hIzNhhvx9Rdz3Z/0UVV4ZraXr/K7wTFtfPUzrtEY1rQhG0cyxBeq4S5RUQ5TDpgHmY3g
         TNq+yh/A7HADPjI2PfMooGSOR7kD1BwQoM753acagZc9KJqzohICO6FpDH9EDwma1CfQ
         34UwrTvTk0m6D2zyls7Bv1GW2sRWn6XokB+N94Y/XkWi1twyqj0kmncDqrRKBdlBShr6
         uKydWlwGbuCdH+3hnuKQmnp/DM12acjJDT/wbs6JyFYHr1B0W2B0496e8bM82HOn3HKz
         tezg==
X-Gm-Message-State: AO0yUKUbnoJmpDALd6aw8LhGXzSEkty45/ktaHw8hBMo8J4aDVnT9771
        nk8S03WGY8LYetjU/2gtLL1x75rINVPKIcKjdKHR5saiDQ6n8GI4Gw+y0RAlaUeHB1V4coPOmEH
        kgyPrGfblWVQLlVXZOlHiHrPU
X-Received: by 2002:a05:6000:1c2:b0:2ce:a944:1d9b with SMTP id t2-20020a05600001c200b002cea9441d9bmr3776833wrx.58.1678712615500;
        Mon, 13 Mar 2023 06:03:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set8SXtDlde5143rTYY54QSBP2tzbO47Y4zst+YARWAhqzofWtcRon4WxnKgiBWaGaiZUojRq/A==
X-Received: by 2002:a05:6000:1c2:b0:2ce:a944:1d9b with SMTP id t2-20020a05600001c200b002cea9441d9bmr3776805wrx.58.1678712615144;
        Mon, 13 Mar 2023 06:03:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:7500:9d5c:56ee:46c3:8593? (p200300cbc70175009d5c56ee46c38593.dip0.t-ipconnect.de. [2003:cb:c701:7500:9d5c:56ee:46c3:8593])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d4a8f000000b002c70e60abd4sm7972148wrq.2.2023.03.13.06.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:03:34 -0700 (PDT)
Message-ID: <9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com>
Date:   Mon, 13 Mar 2023 14:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Hugh Dickins <hughd@google.com>
References: <202302100915227721315@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
In-Reply-To: <202302100915227721315@zte.com.cn>
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

On 10.02.23 02:15, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 

Hi,

sorry for the late follow-up. Still wrapping my head around this and 
possible alternatives. I hope we'll get some comments from others as 
well about the basic approach.

> The core idea of this patch set is to enable users to perceive the number of any
> pages merged by KSM, regardless of whether use_zero_page switch has been turned
> on, so that users can know how much free memory increase is really due to their
> madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
> all empty pages will be merged with kernel zero pages instead of with each
> other as use_zero_pages is disabled, and then these zero-pages are no longer
> monitored by KSM.
> 
> The motivations for me to do this contains three points:
> 
> 1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
>     unshare the shared zeropage as placed by KSM (which is against the
>     MADV_UNMERGEABLE documentation at least); see the link:
>     https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/
> 
> 2) We cannot know how many pages are zero pages placed by KSM when
>     enabling use_zero_pages, which hides the critical information about
>     how much actual memory are really saved by KSM. Knowing how many
>     ksm-placed zero pages are helpful for user to use the policy of madvise
>     (MERGEABLE) better because they can see the actual profit brought by KSM.
> 
> 3) The zero pages placed-by KSM are different from those initial empty page
>     (filled with zeros) which are never touched by applications. The former
>     is active-merged by KSM while the later have never consume actual memory.
> 

I agree with all of the above, but it's still unclear to me if there is 
a real downside to a simpler approach:

(1) Tracking the shared zeropages. That would be fairly easy: whenever
     we map/unmap a shared zeropage, we simply update the counter.

(2) Unmerging all shared zeropages inside the VMAs during
     MADV_UNMERGEABLE.

(3) Documenting that MADV_UNMERGEABLE will also unmerge the shared
     zeropage when toggle xy is flipped.

It's certainly simpler and doesn't rely on the rmap item. See below.

> use_zero_pages is useful, not only because of cache colouring as described
> in doc, but also because use_zero_pages can accelerate merging empty pages
> when there are plenty of empty pages (full of zeros) as the time of
> page-by-page comparisons (unstable_tree_search_insert) is saved. So we hope to
> implement the support for ksm zero page tracking without affecting the feature
> of use_zero_pages.
> 
> Zero pages may be the most common merged pages in actual environment(not only VM but
> also including other application like containers). Enabling use_zero_pages in the
> environment with plenty of empty pages(full of zeros) will be very useful. Users and
> app developer can also benefit from knowing the proportion of zero pages in all
> merged pages to optimize applications.
> 

I agree with that point, especially after I read in a paper that KSM 
applied to some applications mainly deduplicates pages filled with 0s. 
So it seems like a reasonable thing to optimize for.

> With the patch series, we can both unshare zero-pages(KSM-placed) accurately
> and count ksm zero pages with enabling use_zero_pages.

The problem with this approach I see is that it fundamentally relies on 
the rmap/stable-tree to detect whether a zeropage was placed or not.

I was wondering, why we even need an rmap item *at all* anymore. Why 
can't we place the shared zeropage an call it a day (remove the rmap 
item)? Once we placed a shared zeropage, the next KSM scan should better 
just ignore it, it's already deduplicated.

So if most pages we deduplicate are shared zeropages, it would be quite 
interesting to reduce the memory overhead and avoid rmap items, instead 
of building new functionality on top of it?



If we'd really want to identify whether a zeropage was deduplciated by 
KSM, we could try storing that information inside the PTE instead of 
inside the RMAP. Then, we could directly adjust the counter when zapping 
the shared zeropage or during MADV_DONTNEED/when unmerging.

Eventually, we could simply say that
* !pte_dirty(): zeropage placed during fault
* pte_dirty(): zeropage placed by KSM

Then it would also be easy to adjust counters and unmerge. We'd limit 
this handling to known-working architectures initially (spec64 still has 
the issue that pte_mkdirty() will set a pte writable ... and my patch to 
fix that was not merged yet). We'd have to double-check all 
pte_mkdirty/pte_mkclean() callsites.

-- 
Thanks,

David / dhildenb

