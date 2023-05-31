Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1533717892
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjEaHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjEaHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3118F93
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685519201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAEIqyTQIqAgpwEz1m8TesLih/MrDXD4GJgP6XrJJHQ=;
        b=P51VlisMD7pWCRbQ0yjMZdUEFDH0xkj1rsaheKA3ZkOrwjW8ePAPimITJu2dOel1izfwoL
        xeyIKE9TzdGmRYhHjF2f3tlgIHLi45G2PAYZ+3AHiibrtc7410QvB6+KIGcdw/hYppq3iG
        etnTAd83yhM3SF+UVEkDC3r6R6/d9GU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-vasp2XFTO86tv5XkKDwX7g-1; Wed, 31 May 2023 03:46:40 -0400
X-MC-Unique: vasp2XFTO86tv5XkKDwX7g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f603fed174so33848395e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519199; x=1688111199;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAEIqyTQIqAgpwEz1m8TesLih/MrDXD4GJgP6XrJJHQ=;
        b=AtEWNO8BUrgk+7cj6j5XO5QXAZ7Kq7x6yUToiO3KAFR1HMXU9dTxOaUfBoL9w1n7+O
         FguD+Md7eGxM173gbrf59VbmEqAQSnvEmnSiSuDYZW8LxmN17/W3H7EPgsXIIoxJq7c4
         i7N7EBo3bJxIsAu4jzeqiPDZB4M2vpLSZ4yW4IV2woJBPFA5pR8V199glHFLaJU3Lwzt
         2/K30M/YAstXRUFrIet0CW6qYLAQcPLicXC5xECiE7+XA0hRAmUq5fM8TUui7g4SX4ey
         As/mM4maXTheLC81VbdumDixx9xSL0yowpmIF3/h8KoFpH8MINEAuKm7r14WqLq/Xz5m
         Y04A==
X-Gm-Message-State: AC+VfDxYUlshsJJedrq0PNEwoEMGcCVIpBdHCFTXg+jdbrSLeOSGnhj3
        aIRxb1uQfBWGAZs3M2oOCkjqQjsq3dD8hTyLZSucOCGo4mPYnWifbIZiKuVK7TUxOXys1UMFfy9
        YcAiw+b34MVeuBAUcQXx80n2g
X-Received: by 2002:a05:600c:294c:b0:3f4:2374:3512 with SMTP id n12-20020a05600c294c00b003f423743512mr3473978wmd.18.1685519198915;
        Wed, 31 May 2023 00:46:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7z2nWeeDyToNoabyk0bgUbIZ5Qb1hjh9n0hxodHOR7kl1BRQ2tIjARx8taRxj6Rm72VES6uw==
X-Received: by 2002:a05:600c:294c:b0:3f4:2374:3512 with SMTP id n12-20020a05600c294c00b003f423743512mr3473958wmd.18.1685519198688;
        Wed, 31 May 2023 00:46:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d4f8d000000b0030ae69920c9sm5748797wru.53.2023.05.31.00.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:46:38 -0700 (PDT)
Message-ID: <9493177b-c435-9adc-cdfc-e45b91f02e77@redhat.com>
Date:   Wed, 31 May 2023 09:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V3 4/5] swap: remove get/put_swap_device() in
 __swap_duplicate()
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-5-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230529061355.125791-5-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.23 08:13, Huang Ying wrote:
> __swap_duplicate() is called by
> 
> - swap_shmem_alloc(): the folio in swap cache is locked.
> 
> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
>    swap_duplicate(): the page table lock is held.
> 
> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>    get/put_swap_device() in __read_swap_cache_async() already.
> 
> So, it's safe to remove get/put_swap_device() in __swap_duplicate().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

