Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3407F5B3657
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiIIL2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiIIL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BF132055
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpDkHaXnSCsM/ZoB4suIHBbFFXOjSmaxDG4e8GA+GC8=;
        b=eIifYCdFToErnFIPF2q1qWz/JLBzLqYSXYDAjX+vIboEpTEGUfQQmdurdvR30VWebCCZZZ
        nsWaKDCQYw6xFWkl9/izAKcrBByGMp6A5RLrFnqfdrE3a/9rplzpKhLLt5BNkXTc/eRfdm
        0Qgry/4j93nAeMgVPm/EV226xfK14rA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-5LyGPwAtPemskhZxYciOxw-1; Fri, 09 Sep 2022 07:27:52 -0400
X-MC-Unique: 5LyGPwAtPemskhZxYciOxw-1
Received: by mail-wm1-f70.google.com with SMTP id v189-20020a1cacc6000000b003b461a36bb5so371881wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=CpDkHaXnSCsM/ZoB4suIHBbFFXOjSmaxDG4e8GA+GC8=;
        b=Kusskhhs3JgzMwzce8ITCYpwa6sRK4ucqrBWprp1INm+OEqHp3ro7Y6ZR59AL8UEly
         Kt6Blj2ok/XgjZHvBrnGvdy9vmXmoWGTA7CzjT6oKGMyt3paFXvzqC8B9equWps6ojCf
         QEnILaEJ8EBvtgYXpKLVbMPJ8eeNjQ1ZS5DmZsEZ3bm4rAl0U65aAHmlkInzfEPG7Xo+
         GQs3GAsMaSFeaQ3/SfYHQULIA/id/IoTCmMDlYc6za4GB9nX5EKJSSOsPQk3KnHq0D6c
         Ca9XVl9vdcZCyxQ/Vnmpj74Q5jQsIQm5UR9WnycW+v+0ZUqqduVJNLQRN/Ah85YIto7E
         bZZw==
X-Gm-Message-State: ACgBeo1AhKFt3UixUygldLWZQQ5Xnkpe5syVw1plrg66p+QITilwv3zi
        Ntxdg4bH3Li4T4dP4H25Vb6rN5V/Fgb6RDILn7XcYPuMX4DQ/m4H5AsN7WrIUCanBN+qS5IESYN
        imOJ7Dz2w10Hj+a3HY92KlqCb
X-Received: by 2002:a05:600c:4148:b0:3a5:4f94:577b with SMTP id h8-20020a05600c414800b003a54f94577bmr5277064wmm.167.1662722870966;
        Fri, 09 Sep 2022 04:27:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ID9YjImwe7Jx4eKIMHs9zUvU8ficM9t1XwGQlYU82810wLPJqZGwwt6OEcD5IyqWX2Z32CQ==
X-Received: by 2002:a05:600c:4148:b0:3a5:4f94:577b with SMTP id h8-20020a05600c414800b003a54f94577bmr5277051wmm.167.1662722870743;
        Fri, 09 Sep 2022 04:27:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003a840690609sm525048wmb.36.2022.09.09.04.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:27:50 -0700 (PDT)
Message-ID: <27b09e1e-21dc-33ac-f26b-86ab74d25bed@redhat.com>
Date:   Fri, 9 Sep 2022 13:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 05/16] mm/page_alloc: add __init annotations to
 init_mem_debugging_and_hardening()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-6-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 11:24, Miaohe Lin wrote:
> It's only called by mm_init(). Add __init annotations to it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/mm.h | 2 +-
>   mm/page_alloc.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 364bcadb4d20..c2277f5aba9e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3093,7 +3093,7 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
>   				   unsigned long address, unsigned long size,
>   				   pte_fn_t fn, void *data);
>   
> -extern void init_mem_debugging_and_hardening(void);
> +extern void __init init_mem_debugging_and_hardening(void);
>   #ifdef CONFIG_PAGE_POISONING
>   extern void __kernel_poison_pages(struct page *page, int numpages);
>   extern void __kernel_unpoison_pages(struct page *page, int numpages);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81f06d8a4f5..3497919f4ef5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -903,7 +903,7 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>    * order of appearance. So we need to first gather the full picture of what was
>    * enabled, and then make decisions.
>    */
> -void init_mem_debugging_and_hardening(void)
> +void __init init_mem_debugging_and_hardening(void)
>   {
>   	bool page_poisoning_requested = false;
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

