Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBBF70BCEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjEVMID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjEVMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32217A3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysgkT5k23P67DDlEbHiugR7dnPfYx2YkiAPcK+Q9LOc=;
        b=UlknmLr3ScSC/kW/Sb13BhaK6wOkJZ1ily8quQ+sNCBe+mES9IygOEWRrZPrPF8FY73rZD
        BviGh5bPlaACUOBxZyS7uisLeBPQlWqepgKiDdHhY5UzupPBvzXhfoY28PO0NEi61I20Ma
        yb1+xDTrB3asR8SNBXcc0pidIYHwl8o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-UmSaVDkFPcen_Bo99cUR2Q-1; Mon, 22 May 2023 08:07:10 -0400
X-MC-Unique: UmSaVDkFPcen_Bo99cUR2Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3093cb05431so3815020f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757229; x=1687349229;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysgkT5k23P67DDlEbHiugR7dnPfYx2YkiAPcK+Q9LOc=;
        b=TIxxecJ0s0vzw/aburi2yCHXip1AhAWZGDL2UE2+fflVErTqVtoQcjhmOSuR5q6tby
         MftemWR4ghexAUEpcvJHnWPHLQFZEqdBm8EJoiy/QejSqgY8vtLE5pyHiW36Z9Ya1I6f
         SgK8oN/mn3Ry2/Vokx3Xu/2y5EZQKoAywxyCmkvlWxrAc3Yn17eqFSXqwmhFt4LQJ0o2
         6ntuKVfeB+gNYkrn4M6KXwwpOZulWU3p6z9hpg9Hi+ZyPduXdyx/8TN/kJXaDabM4q+b
         JfavbP5hjkmzxhwEnYo+NShzyxqg1CaotX5zO0STddP6xbJPc4gOhK7SWb0vaLi98FlA
         grmg==
X-Gm-Message-State: AC+VfDzjiBrKvRubeEY4UohT0aaN/MpXsE4jaAGoqC+qopFHewM/uSuE
        e/mCres2SE0XTM5qgo/tpB4E2QbVRpi4JdgXSh4W0v0dmVQVsONeToI0FtcmE5n0S86SQtt6V91
        xsjoN8JSYrLcZRxPP8x8c5XIr
X-Received: by 2002:adf:fbc4:0:b0:307:9da1:c9d8 with SMTP id d4-20020adffbc4000000b003079da1c9d8mr6900668wrs.4.1684757228767;
        Mon, 22 May 2023 05:07:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ708mLoPG8NjV3U9Sa1bTk2+46CPVsAmy4PaEGr/ZyWKDaTS0wN3m7JcK8qOqBIBsV1FrW+zQ==
X-Received: by 2002:adf:fbc4:0:b0:307:9da1:c9d8 with SMTP id d4-20020adffbc4000000b003079da1c9d8mr6900650wrs.4.1684757228437;
        Mon, 22 May 2023 05:07:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003f42a75ac2asm8178149wmk.23.2023.05.22.05.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 05:07:08 -0700 (PDT)
Message-ID: <2ad811a6-899d-3be8-2bd3-29ebed3308a8@redhat.com>
Date:   Mon, 22 May 2023 14:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V2 5/5] swap: comments get_swap_device() with usage rule
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
References: <20230522070905.16773-1-ying.huang@intel.com>
 <20230522070905.16773-6-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522070905.16773-6-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 09:09, Huang Ying wrote:
> The general rule to use a swap entry is as follows.
> 
> When we get a swap entry, if there isn't some other way to prevent
> swapoff, such as page lock for swap cache, page table lock, etc., the
> swap entry may become invalid because of swapoff.  Then, we need to
> enclose all swap related functions with get_swap_device() and
> put_swap_device(), unless the swap functions call
> get/put_swap_device() by themselves.
> 
> Add the rule as comments of get_swap_device().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>   mm/swapfile.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4dbaea64635d..0c1cb935b2eb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>   }
>   
>   /*
> + * When we get a swap entry, if there isn't some other way to prevent
> + * swapoff, such as page lock for swap cache, page table lock, etc.,

Again "page lock for swap cache" might be imprecise.

> + * the swap entry may become invalid because of swapoff.  Then, we
> + * need to enclose all swap related functions with get_swap_device()
> + * and put_swap_device(), unless the swap functions call
> + * get/put_swap_device() by themselves.
> + *
>    * Check whether swap entry is valid in the swap device.  If so,
>    * return pointer to swap_info_struct, and keep the swap entry valid
>    * via preventing the swap device from being swapoff, until
> @@ -1227,9 +1234,8 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>    * Notice that swapoff or swapoff+swapon can still happen before the
>    * percpu_ref_tryget_live() in get_swap_device() or after the
>    * percpu_ref_put() in put_swap_device() if there isn't any other way
> - * to prevent swapoff, such as page lock, page table lock, etc.  The
> - * caller must be prepared for that.  For example, the following
> - * situation is possible.
> + * to prevent swapoff.  The caller must be prepared for that.  For
> + * example, the following situation is possible.
>    *
>    *   CPU1				CPU2
>    *   do_swap_page()

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

