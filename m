Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B673F5B3662
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIILcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIILcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E712D566
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dH8rD5L6M9z0I77gljxR/cy6eNJfaXJvN6rfg8iFTw=;
        b=LFPioyCErM0yQMrHyWvHnaUHb/eyDWssRvrXG8L9XCnA1n3fyJgx+RO10zJ41AihfzUVlw
        7g2GTdo4tg2PtXwG9GP3vYl8EnsUC+w2ZVKFsMsUA3xNKdvkRbGdcfT6FWXbkSV0aaonLY
        /iPnNmvGA3OgsLYQ9QryaI6VLTTRJmQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-uZI7ioVONVyy2VO6CrxcFQ-1; Fri, 09 Sep 2022 07:32:39 -0400
X-MC-Unique: uZI7ioVONVyy2VO6CrxcFQ-1
Received: by mail-wm1-f69.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so720843wmq.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5dH8rD5L6M9z0I77gljxR/cy6eNJfaXJvN6rfg8iFTw=;
        b=tHpKHQhYdwFoGCq5t+eYJD7dMMqhjha2GokMK3QvZkdmyHnGXCHtRlPBsT2d4Z1PlH
         H5rc1niUKpyEFfPXW7dPC/F6s6iOFibPufCX214U5vBQBvUPi2KwNn+J91XA1EvDAbqN
         TnqMeOiMQKtjVZttW+CCL+Mu46pvF2VBrIVSnR03ewS1864PmE4qTwZqMqZUcf76ENhz
         d0GfAcx8uoOO/ykaIx3nwWn/YP4EFefBl0SZAl6/nkIrnzk2pCCKEIoej9w4A0P8S/Tq
         3ifMRppedtgsJBRG0PM0OM5lh+YkSKP3gtvHDe+DwP+wk7d5n1ocZgwCDqZoGyux0EQT
         0u+w==
X-Gm-Message-State: ACgBeo33fly4cm140cMOsVzf+lrOPqPlFCYtTdFF9X2xolDxv9nFfSxd
        cU/tEjz7JdpvqYynORpRFPsX6aT8FbDqPqIgcA5XdglepRqgLhy52pMdRAdVI04T9d03wHrwbqd
        NfF7+jEYfYzf8H6YBS9xdBtsR
X-Received: by 2002:a05:6000:1865:b0:228:de57:f1c8 with SMTP id d5-20020a056000186500b00228de57f1c8mr7960299wri.370.1662723158377;
        Fri, 09 Sep 2022 04:32:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6MItsI+H+1YabaJrFfrnc5NhFRGMdojAjSqaxzqEZzfxKBZad2gA8/HUE8X6nCBqRrpOwxQg==
X-Received: by 2002:a05:6000:1865:b0:228:de57:f1c8 with SMTP id d5-20020a056000186500b00228de57f1c8mr7960289wri.370.1662723158096;
        Fri, 09 Sep 2022 04:32:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a4efb794d7sm340325wmi.36.2022.09.09.04.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:32:37 -0700 (PDT)
Message-ID: <ff5cf13a-2c72-6e61-8394-0ff32da855ec@redhat.com>
Date:   Fri, 9 Sep 2022 13:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 11/16] mm/page_alloc: make boot_nodestats static
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-12-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-12-linmiaohe@huawei.com>
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
> It's only used in mm/page_alloc.c now. Make it static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/internal.h   | 2 --
>   mm/page_alloc.c | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 2424fcde6538..43a441d35baf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -864,8 +864,6 @@ int migrate_device_coherent_page(struct page *page);
>    */
>   struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>   
> -DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> -
>   extern bool mirrored_kernelcore;
>   
>   static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3417232afa45..7a8a6bb08a15 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6571,7 +6571,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
>   #define BOOT_PAGESET_BATCH	1
>   static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
>   static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
> -DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> +static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>   
>   static void __build_all_zonelists(void *data)
>   {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

