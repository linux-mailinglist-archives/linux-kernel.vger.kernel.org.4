Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC962B618
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiKPJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiKPJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFEC2A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668589713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyltcw5T2Jgb215BEwpuC1JHtb3SSPcmkoPplj08lqE=;
        b=IjKrCjsyP0ZYPNAJO/fq/ReE+oSqp4E4sAy8qimIABpzLKCqUe3kVwf0HG7EdVcuhz6l+v
        7bCIndz9+QrKVy7buK5Z7ZtaEOKltzp587oSaD+Q8CrxGbbapWs1tthxfjjHreBw0wIsrH
        3jJcB1QAPOqi5Cz8L5527T6tXWgEBh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-NWY4lrf7MsuK1hhp-BKhUA-1; Wed, 16 Nov 2022 04:08:29 -0500
X-MC-Unique: NWY4lrf7MsuK1hhp-BKhUA-1
Received: by mail-wm1-f70.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so7144730wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyltcw5T2Jgb215BEwpuC1JHtb3SSPcmkoPplj08lqE=;
        b=GO4oyyeyPHsXsTqq4BrXek+BDV0yiPUbDqaiYXw9bA2DaKrAFIZlHoIM6NLINEeomp
         kmLftBs6NXa3HtEfj/RQs+hnWRBq3OwZ2akA32w2WbwajYaagzgLVquEQ1S5vwe4Hi0k
         X+6CDIEuMPbgAnFm2Ri2yQt0aNijb/xXdDtbUB0Q7QSWtqyNEyNQO7TLrshxnz1c/V3/
         PWHauQptqjip1a1w/XwzG8uyazaEAxkMwH8OCEPB8a1WXfYVLJjM2ePidNX07Q0N3JJf
         9ideaF2vPCZVhtVti83mHGIXhoTtvKAyXZCgyUlgJeKftUn50KJ65os3eshlEVBAubFA
         lb8A==
X-Gm-Message-State: ANoB5pkRn/606MgBavKBwujVUXgbk0qhSCR9oCJfZMYmJHOgP0I2ESU4
        1RXrVtIJyHcLJpDUsp0cz6VmrKPfIGnLFPuxodk8Z879U4qDABZdgtSmXBfOhT1b+ooYnQsGNkF
        hjvMfTA45NZUxy63uhGozPbh3
X-Received: by 2002:a5d:6e86:0:b0:22f:8603:24c5 with SMTP id k6-20020a5d6e86000000b0022f860324c5mr12582230wrz.245.1668589708627;
        Wed, 16 Nov 2022 01:08:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4/R3OSAatEf0znUrZyOwmCCnGSuHg/w/V9S5+ALzG2D88hMgYBJ7ZeTzD2kRv/0ygfsZHPog==
X-Received: by 2002:a5d:6e86:0:b0:22f:8603:24c5 with SMTP id k6-20020a5d6e86000000b0022f860324c5mr12582211wrz.245.1668589708279;
        Wed, 16 Nov 2022 01:08:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c4b0a00b003b476cabf1csm1331225wmp.26.2022.11.16.01.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:08:27 -0800 (PST)
Message-ID: <73189e81-08c2-bb18-dd4a-f717996ea819@redhat.com>
Date:   Wed, 16 Nov 2022 10:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] arm64/mm: fix incorrect file_map_count for invalid
 pmd/pud
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116083811.464678-1-liushixin2@huawei.com>
 <20221116083811.464678-3-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221116083811.464678-3-liushixin2@huawei.com>
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

On 16.11.22 09:38, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when split hugepage:
> 
>   ------------[ cut here ]------------
>   kernel BUG at mm/page_table_check.c:119!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in:
>   CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : page_table_check_set.isra.0+0x398/0x468
>   lr : page_table_check_set.isra.0+0x1c0/0x468
> [...]
>   Call trace:
>    page_table_check_set.isra.0+0x398/0x468
>    __page_table_check_pte_set+0x160/0x1c0
>    __split_huge_pmd_locked+0x900/0x1648
>    __split_huge_pmd+0x28c/0x3b8
>    unmap_page_range+0x428/0x858
>    unmap_single_vma+0xf4/0x1c8
>    zap_page_range+0x2b0/0x410
>    madvise_vma_behavior+0xc44/0xe78
>    do_madvise+0x280/0x698
>    __arm64_sys_madvise+0x90/0xe8
>    invoke_syscall.constprop.0+0xdc/0x1d8
>    do_el0_svc+0xf4/0x3f8
>    el0_svc+0x58/0x120
>    el0t_64_sync_handler+0xb8/0xc0
>    el0t_64_sync+0x19c/0x1a0
> [...]
> 
> On arm64, pmd_present() will return true even if the pmd is invalid.

I assume that's because of the pmd_present_invalid() check.

... I wonder why that behavior was chosen. Sounds error-prone to me.

Fix LGHTM, but I am not an arm64 pgtable expert.

-- 
Thanks,

David / dhildenb

