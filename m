Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C072BCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjFLJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjFLJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1A524A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2zik9I6wtN0hN5lDN65C1IiqrhISpY0AugfFqCf2aE=;
        b=EgE8UGyOoPhPfQP2mFHd3ulGQNziNlnkv+SOQ32drFAuSNy4PBi9+z9BWjks433iNvQ2ad
        113h39HtXJXQcKv8nQQGpPPzxcCjAKwRLJdopAFsnYXEaIVxG7NTk3j3dJRKwcdrVpfxV4
        //BEZDQJbtF1rDlBOn39DF7t2N5P9W4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-xsj9x_AkObSIXBv9LqtriA-1; Mon, 12 Jun 2023 05:33:01 -0400
X-MC-Unique: xsj9x_AkObSIXBv9LqtriA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e7cfcae4so25594025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562380; x=1689154380;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2zik9I6wtN0hN5lDN65C1IiqrhISpY0AugfFqCf2aE=;
        b=Ci99ebkDVmLAT5BaLP479j+unm7jAuzg2OB/aneJWlRxADCg65Y3yXVsQFiIbzEt+F
         yiVlemab3EaYr4BFTAcTLiu7mqFAhKDqj01ApGBAeS0RIp9uz0pgne7/FmbhZ90ISWBQ
         fwC0gJi0kaZ33EDL3xY3+n8C/16cbw9Jp89am9/ZJgslp24ywsJ2uUr5lmIh0fWA5qw2
         V9Tex+kte5Es9LPDt57+qCbFXS2psBuweVB5J8AvAmyzhYqOM16E2++MzhTLDCCsMrgh
         GrfmcbNACeYBtVQUKnxVR/2FWGNNe17XAHzueezayAUbR2pnM5dRpG1+0pQ6FcphV1an
         h7Aw==
X-Gm-Message-State: AC+VfDw3BXu9UXVylTiX6SESHBlgZ9JalnVDoBOOwXoyMbMBguCCravn
        jOOmgmKtElXfnSMCqlH3UYipRUoXG3S0d5yRdX2LCQBZ9ezAxBIzaFJonBFFPo/vkO+kD+/V3wc
        RCNtEm2aSwiSpzkAZwwiCnSdv
X-Received: by 2002:a1c:6a04:0:b0:3f6:143:7c4b with SMTP id f4-20020a1c6a04000000b003f601437c4bmr7194239wmc.6.1686562380176;
        Mon, 12 Jun 2023 02:33:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4z8ERkPWmOW1qx+Uef6lYQlwqsm4Uqr2iyzMwAUJ3cV4HfE2QxGeOBqFvLloo/xVA2Hvg5Vw==
X-Received: by 2002:a1c:6a04:0:b0:3f6:143:7c4b with SMTP id f4-20020a1c6a04000000b003f601437c4bmr7194224wmc.6.1686562379843;
        Mon, 12 Jun 2023 02:32:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10762632wmj.22.2023.06.12.02.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:32:59 -0700 (PDT)
Message-ID: <3f943c78-bc8b-fd2f-50b1-5bd3501bc878@redhat.com>
Date:   Mon, 12 Jun 2023 11:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: vmscan: mark kswapd_run() and kswapd_stop() __meminit
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230606121813.242163-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230606121813.242163-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.23 14:18, Miaohe Lin wrote:
> Add __meminit to kswapd_run() and kswapd_stop() to ensure they're default
> to __init when memory hotplug is not enabled.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/swap.h | 4 ++--
>   mm/vmscan.c          | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2ddbfd85f6c7..b5f6f2916de1 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -460,8 +460,8 @@ static inline bool node_reclaim_enabled(void)
>   void check_move_unevictable_folios(struct folio_batch *fbatch);
>   void check_move_unevictable_pages(struct pagevec *pvec);
>   
> -extern void kswapd_run(int nid);
> -extern void kswapd_stop(int nid);
> +extern void __meminit kswapd_run(int nid);
> +extern void __meminit kswapd_stop(int nid);
>   
>   #ifdef CONFIG_SWAP
>   
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 43dc5c90abbf..a8881571e0ed 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7871,7 +7871,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>   /*
>    * This kswapd start function will be called by init and node-hot-add.
>    */
> -void kswapd_run(int nid)
> +void __meminit kswapd_run(int nid)
>   {
>   	pg_data_t *pgdat = NODE_DATA(nid);
>   
> @@ -7892,7 +7892,7 @@ void kswapd_run(int nid)
>    * Called by memory hotplug when all memory in a node is offlined.  Caller must
>    * be holding mem_hotplug_begin/done().
>    */
> -void kswapd_stop(int nid)
> +void __meminit kswapd_stop(int nid)
>   {
>   	pg_data_t *pgdat = NODE_DATA(nid);
>   	struct task_struct *kswapd;

kswapd_stop() is only called with CONFIG_MEMORY_HOTPLUG, so I'm 
wondering if we even want to compiled that without CONFIG_MEMORY_HOTPLUG ...

Anyhow,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

