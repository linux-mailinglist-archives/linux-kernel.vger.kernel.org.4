Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01888748DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjGETj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGETj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E9171E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688585918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LkPXGfTtUH5FuOUrLUe3qSTFVo4QS+rW6uZwA0gLV4=;
        b=i6l2zTjFLdwUV6LfUxn81NHIbK9a1a6Ol68iOfpjBYtCqFDSqUcAzH/wm7XudJjVJ+Nr+i
        8aUiuJIukYVdvpEnPedKk6GnJaZl9wajjQJZOPY2HEWJNGm78mKkE5PlZxHj/rjK9xufFX
        EfzA720obYRFyMALmDQUfMjwhRGEBZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-OhNvl2qtNUmTSu5raxTYqQ-1; Wed, 05 Jul 2023 15:38:36 -0400
X-MC-Unique: OhNvl2qtNUmTSu5raxTYqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdde92299so16804645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 12:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585915; x=1691177915;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LkPXGfTtUH5FuOUrLUe3qSTFVo4QS+rW6uZwA0gLV4=;
        b=D5UXHBAZULnB1QO+CwF7TjZa+rjz7bGg4c6pM1Pnlg+insD3shqONz1hGjMIsvSNEw
         46GTmqX+iSfzuqYjot6MmHp3rA7Db0qCUiYwO9DEtk3FI/DTG0heSVAGIvAW3CNAuqsH
         B77VsEMVmGebfytP4xBkyfYjt16s/tG5zzY6W75N9s2hvs45FYBNB5ZFuCuLLM0PRd5p
         bUHpD4CmYKivfNzSnjKLbKiNdcqPe8SaAnNPWXVbdg8G+l5IYSZCOobqVFusiZ0bMIT7
         7FPVGJqoXABCjAlrZ1RCRuPacT6SuWjMqqA5sPcxTkpgh8MoSVCcfgLAi9AgKiJKE+dO
         88Qw==
X-Gm-Message-State: AC+VfDx85xkl4LJAS8JdkUNdtYtu8CSYlVa8mhl1jdAdC+t/6YrQ7+v7
        ljfFIVmIDn8aHPHpdFSLXHKUiie3RxZjd4NTgc4iGJUNCbhJB0L8MS7hy9v1khwZ1ucDaE11f/J
        uTovMuetk4fFGpMF51bHJNrFQ
X-Received: by 2002:a7b:ce87:0:b0:3f7:aad8:4e05 with SMTP id q7-20020a7bce87000000b003f7aad84e05mr16094661wmj.11.1688585915699;
        Wed, 05 Jul 2023 12:38:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SinKO/39gyhOIO7laZxTzu6zK3ZRvtrbet5rKpwhogS74hv5oaCsyiZwcdYsNUGNWNi2Yew==
X-Received: by 2002:a7b:ce87:0:b0:3f7:aad8:4e05 with SMTP id q7-20020a7bce87000000b003f7aad84e05mr16094648wmj.11.1688585915267;
        Wed, 05 Jul 2023 12:38:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:1c00:e2b1:fc33:379b:a713? (p200300cbc71a1c00e2b1fc33379ba713.dip0.t-ipconnect.de. [2003:cb:c71a:1c00:e2b1:fc33:379b:a713])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003fbd0c50ba2sm2978019wmg.32.2023.07.05.12.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 12:38:34 -0700 (PDT)
Message-ID: <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
Date:   Wed, 5 Jul 2023 21:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703135330.1865927-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.23 15:53, Ryan Roberts wrote:
> Hi All,
> 
> This is v2 of a series to implement variable order, large folios for anonymous
> memory. The objective of this is to improve performance by allocating larger
> chunks of memory during anonymous page faults. See [1] for background.
> 
> I've significantly reworked and simplified the patch set based on comments from
> Yu Zhao (thanks for all your feedback!). I've also renamed the feature to
> VARIABLE_THP, on Yu's advice.
> 
> The last patch is for arm64 to explicitly override the default
> arch_wants_pte_order() and is intended as an example. If this series is accepted
> I suggest taking the first 4 patches through the mm tree and the arm64 change
> could be handled through the arm64 tree separately. Neither has any build
> dependency on the other.
> 
> The one area where I haven't followed Yu's advice is in the determination of the
> size of folio to use. It was suggested that I have a single preferred large
> order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, or there
> being existing overlapping populated PTEs, etc) then fallback immediately to
> order-0. It turned out that this approach caused a performance regression in the
> Speedometer benchmark. With my v1 patch, there were significant quantities of
> memory which could not be placed in the 64K bucket and were instead being
> allocated for the 32K and 16K buckets. With the proposed simplification, that
> memory ended up using the 4K bucket, so page faults increased by 2.75x compared
> to the v1 patch (although due to the 64K bucket, this number is still a bit
> lower than the baseline). So instead, I continue to calculate a folio order that
> is somewhere between the preferred order and 0. (See below for more details).
> 
> The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes() series
> [2], which is a hard dependency. I have a branch at [3].
> 
> 
> Changes since v1 [1]
> --------------------
> 
>    - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>    - replaced with arch-independent alloc_anon_folio()
>        - follows THP allocation approach
>    - no longer retry with intermediate orders if allocation fails
>        - fallback directly to order-0
>    - remove folio_add_new_anon_rmap_range() patch
>        - instead add its new functionality to folio_add_new_anon_rmap()
>    - remove batch-zap pte mappings optimization patch
>        - remove enabler folio_remove_rmap_range() patch too
>        - These offer real perf improvement so will submit separately
>    - simplify Kconfig
>        - single FLEXIBLE_THP option, which is independent of arch
>        - depends on TRANSPARENT_HUGEPAGE
>        - when enabled default to max anon folio size of 64K unless arch
>          explicitly overrides
>    - simplify changes to do_anonymous_page():
>        - no more retry loop
> 
> 
> Performance
> -----------
> 
> Below results show 3 benchmarks; kernel compilation with 8 jobs, kernel
> compilation with 80 jobs, and speedometer 2.0 (a javascript benchmark running in
> Chromium). All cases are running on Ampere Altra with 1 NUMA node enabled,
> Ubuntu 22.04 and XFS filesystem. Each benchmark is repeated 15 times over 5
> reboots and averaged.
> 
> 'anonfolio-lkml-v1' is the v1 patchset at [1]. 'anonfolio-lkml-v2' is this v2
> patchset. 'anonfolio-lkml-v2-simple-order' is anonfolio-lkml-v2 but with the
> order selection simplification that Yu Zhao suggested - I'm trying to justify
> here why I did not follow the advice.
> 
> 
> Kernel compilation with 8 jobs:
> 
> | kernel                         |   real-time |   kern-time |   user-time |
> |:-------------------------------|------------:|------------:|------------:|
> | baseline-4k                    |        0.0% |        0.0% |        0.0% |
> | anonfolio-lkml-v1              |       -5.3% |      -42.9% |       -0.6% |
> | anonfolio-lkml-v2-simple-order |       -4.4% |      -36.5% |       -0.4% |
> | anonfolio-lkml-v2              |       -4.8% |      -38.6% |       -0.6% |
> 
> We can see that the simple-order approach is responsible for a regression of
> 0.4%.
> 
> 
> Kernel compilation with 80 jobs:
> 
> | kernel                         |   real-time |   kern-time |   user-time |
> |:-------------------------------|------------:|------------:|------------:|
> | baseline-4k                    |        0.0% |        0.0% |        0.0% |
> | anonfolio-lkml-v1              |       -4.6% |      -45.7% |        1.4% |
> | anonfolio-lkml-v2-simple-order |       -4.7% |      -40.2% |       -0.1% |
> | anonfolio-lkml-v2              |       -5.0% |      -42.6% |       -0.3% |
> 
> simple-order costs 0.3 % here. v2 is actually performing higher than v1 due to
> fixing the v1 regression on user-time.
> 
> 
> Speedometer 2.0:
> 
> | kernel                         |   runs_per_min |
> |:-------------------------------|---------------:|
> | baseline-4k                    |           0.0% |
> | anonfolio-lkml-v1              |           0.7% |
> | anonfolio-lkml-v2-simple-order |          -0.9% |
> | anonfolio-lkml-v2              |           0.5% |
> 
> simple-order regresses performance by 0.9% vs the baseline, for a total negative
> swing of 1.6% vs v1. This is fixed by keeping the more complex order selection
> mechanism from v1.
> 
> 
> The remaining (kernel time) performance gap between v1 and v2 for the above
> benchmarks is due to the removal of the "batch zap" patch in v2. Adding that
> back in gives us the performance back. I intend to submit that as a separate
> series once this series is accepted.
> 
> 
> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230315051444.3229621-1-willy@infradead.org/
> [3] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/anonfolio-lkml_v2
> 
> Thanks,
> Ryan

Hi Ryan,

is page migration already working as expected (what about page 
compaction?), and do we handle migration -ENOMEM when allocating a 
target page: do we split an fallback to 4k page migration?

-- 
Cheers,

David / dhildenb

