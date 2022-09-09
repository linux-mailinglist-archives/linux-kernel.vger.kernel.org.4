Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404F45B364A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIILZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIILZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB29F1A8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lett+OMh9RV2ImeP8GLziHw5ig15HxWDOKscDnHXwoc=;
        b=NODC+6Rjmu1XloD0hOSN91qaZhMllEgLJqLmXIBenYZnqrs5P7ur/lmkL1eklSybV5lRRv
        RCBhTrwnM9dnNJio64yOxQp7S72BTI0O3vP5U2lC/nofnot3YgSE5osuNCEytjobjWXf/+
        038Md7MqLVqD60ZE5Hlon18nW9bUu84=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-GB8suRs9NCGlMQrC7rBmjA-1; Fri, 09 Sep 2022 07:25:28 -0400
X-MC-Unique: GB8suRs9NCGlMQrC7rBmjA-1
Received: by mail-wm1-f69.google.com with SMTP id c188-20020a1c35c5000000b003b2dee5fb58so713605wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=lett+OMh9RV2ImeP8GLziHw5ig15HxWDOKscDnHXwoc=;
        b=PkSpC2Qigpc5MrJ+YB9gs9fESIgpjVdvyk+YYti3R1U1JhCuLbY7rUySTeF6wvAmaA
         yXKAmut17A3WHvXq8T/JzKYVKPGrUEtbk1BRFGsBPqkOOrXlD1AI0OIKIWgZKK8KT410
         XewPHY7qnshD3ML559jNj0GYNWkqe+IU7x6ziglbs+b7nFrcmBdHiyfiNdE4yH7gL8PN
         AIdTgwSZOTcdWieuR0Z4w62EdKNyQOsHpXVqp45DgOMiNcyUymvfyVpEHNDndMc6E+U2
         z1hnJQMUA/XJEycH2cQCyavSUqqqpCXMc+RlR1TmDCj6UcAeOGC9C15z0sUj2nIqryn7
         bsYA==
X-Gm-Message-State: ACgBeo2utHM0lPh0FNAxmwt7L8uHoNi78fDV6r7JhM7fg6EghEkz1DUZ
        jvtqeAW/SDOVAnLkxfdmTckqKAkCkCyggaXsetH9yp+Dih6Div6g8D40bQdOK9Nn+ysM7xnCD5R
        +z8aOU4wtOYiDhHTPMykTRWKR
X-Received: by 2002:a05:600c:444b:b0:3a6:6b99:2394 with SMTP id v11-20020a05600c444b00b003a66b992394mr5166892wmn.43.1662722727160;
        Fri, 09 Sep 2022 04:25:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR66u6H/yD0rqeGiYuHOB58QLfDGBxLi234XgcQ0LqmW2zAEVWwvc8Gqn72NSpnBcMkSL9VSYQ==
X-Received: by 2002:a05:600c:444b:b0:3a6:6b99:2394 with SMTP id v11-20020a05600c444b00b003a66b992394mr5166877wmn.43.1662722726919;
        Fri, 09 Sep 2022 04:25:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6a06000000b0021badf3cb26sm342953wru.63.2022.09.09.04.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:25:26 -0700 (PDT)
Message-ID: <9dd94b86-4fc6-a636-9a4e-bddc77225644@redhat.com>
Date:   Fri, 9 Sep 2022 13:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 16/16] mm/page_alloc: fix obsolete comment in
 deferred_pfn_valid()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-17-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-17-linmiaohe@huawei.com>
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
> There are no architectures that can have holes in the memory map within
> a pageblock since commit 859a85ddf90e ("mm: remove pfn_valid_within()
> and CONFIG_HOLES_IN_ZONE"). Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 262e8972e019..4cc0232020d2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1929,11 +1929,7 @@ static inline void __init pgdat_init_report_one_done(void)
>   /*
>    * Returns true if page needs to be initialized or freed to buddy allocator.
>    *
> - * First we check if pfn is valid on architectures where it is possible to have
> - * holes within pageblock_nr_pages. On systems where it is not possible, this
> - * function is optimized out.
> - *
> - * Then, we check if a current large page is valid by only checking the validity
> + * We check if a current large page is valid by only checking the validity
>    * of the head pfn.
>    */
>   static inline bool __init deferred_pfn_valid(unsigned long pfn)

Reviewed-by: David Hildenbrand <david@redhat.com>
-- 
Thanks,

David / dhildenb

