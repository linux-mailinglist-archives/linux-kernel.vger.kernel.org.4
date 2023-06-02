Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7D720107
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjFBL60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjFBL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E21810D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685706979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b99fVIhvBW0PdWaQkBupcAm5x8dtY13rsZ96awTJ34Q=;
        b=MNRwJg7e5YM/2JYgqcoehhwC+/3kS4hiTA6ZFzCZ7HGdEkHuO1beWTTykVi58FL2SJshTt
        GqlHkGIUrgxMM4l4711uUm08FAnA9CIQ4H1rpPEUOiTQQw/3oB+aeGZ/+MfwNqJs7+wuQ8
        HvSO7HG+AJZp7EbUqBP7VbA0ssRwDso=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-WN5KKaKXOtOKKnPZi6NS-A-1; Fri, 02 Jun 2023 07:56:15 -0400
X-MC-Unique: WN5KKaKXOtOKKnPZi6NS-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3078b9943d6so943950f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706974; x=1688298974;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b99fVIhvBW0PdWaQkBupcAm5x8dtY13rsZ96awTJ34Q=;
        b=BLxwy4Txyu6uQgF7gRFQOZrLDaX34K4S4jWF63Z+x7sFdnxE4xM5mc0xSlvSKNjGXS
         a1RSvIME3AbschvINJ6S3w0aOslDpaFVZzddPebEu+O5ggbfnVMweSYHW+9jf6ISFSo0
         wSieA7ZYSFDknL22Hh8R0rtmMR2iweqNupCwSJjs3onZ9WQ1PsoIcchFwJz1+wkWdDZY
         kjrS8ti7rxzDiqwbtNFDitFXIVv3V11++SY0IUIEEfnudesdbiATWtF8g9QyNKNFtMTa
         iy6oZxy/ioH8k/QIlDcWTgmUES3aLtzwJYHZF8UyIu8CMPsxltwRq5nu8FcUf0Jo1AWy
         3Rqg==
X-Gm-Message-State: AC+VfDyzIFY1rXzOc5+9cB2GUsdA0wuaHizVGugw2rmhKfMzA9wEzqUk
        V+KL6VN9s7cto/+53m+h7W2HQG/iFoCtcknATUEmKYQi69NH7cPWX2BjNLgp/qGTsk9glIcEtG2
        s6XkmRc/irhqiAx6fwWbSF4FyDOiNdFmk
X-Received: by 2002:a5d:62d1:0:b0:306:30e8:eb34 with SMTP id o17-20020a5d62d1000000b0030630e8eb34mr4348159wrv.48.1685706974794;
        Fri, 02 Jun 2023 04:56:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wKKEPkK17gfY9xI4rAOQYLVr7BVRmUH2RF1nWLTvujaDGLxauyOp0F1Yqv3R2qrvO+ktXbQ==
X-Received: by 2002:a5d:62d1:0:b0:306:30e8:eb34 with SMTP id o17-20020a5d62d1000000b0030630e8eb34mr4348149wrv.48.1685706974402;
        Fri, 02 Jun 2023 04:56:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id d6-20020adff2c6000000b00307b5376b2csm1475261wrp.90.2023.06.02.04.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 04:56:14 -0700 (PDT)
Message-ID: <d92273f6-28be-dc37-3ca5-a9579a75f8c4@redhat.com>
Date:   Fri, 2 Jun 2023 13:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     osalvador@suse.de, rppt@kernel.org, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230601162626.1030-2-haifeng.xu@shopee.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/2] mm/mm_init.c: remove reset_node_present_pages()
In-Reply-To: <20230601162626.1030-2-haifeng.xu@shopee.com>
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

On 01.06.23 18:26, Haifeng Xu wrote:
> reset_node_present_pages() only get called in hotadd_init_pgdat(), move
> the action that clear present pages to free_area_init_core_hotplug(), so
> the helper can be removed.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---

[...]

> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 78e67041ae9f..e24ea1db9e26 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1491,6 +1491,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>   {
>   	int nid = pgdat->node_id;
>   	enum zone_type z;
> +	struct zone *zone;

You can declare that within the for loop.

>   	int cpu;
>   
>   	pgdat_init_internals(pgdat);
> @@ -1507,6 +1508,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>   	pgdat->kswapd_order = 0;
>   	pgdat->kswapd_highest_zoneidx = 0;
>   	pgdat->node_start_pfn = 0;
> +	pgdat->node_present_pages = 0;
> +
>   	for_each_online_cpu(cpu) {
>   		struct per_cpu_nodestat *p;
>   
> @@ -1514,8 +1517,15 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>   		memset(p, 0, sizeof(*p));
>   	}
>   
> -	for (z = 0; z < MAX_NR_ZONES; z++)
> -		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
> +	/* When memory is hot-added, all the memory is in offline state. So

/*
  * When ...


> +	 * clear all zones' present_pages and managed_pages because they will
> +	 * be updated in online_pages() and offline_pages().
> +	 */
> +	for (z = 0; z < MAX_NR_ZONES; z++) {
> +		zone = &pgdat->node_zones[z];

Too bad we don't have something like node_zone(pgdat, z)

Might be a reasonable cleanup staring at "git grep "pgdat->node_zones"" 
output ...

> +		zone->present_pages = 0;
> +		zone_init_internals(zone, z, nid, 0);
> +	}
>   }
>   #endif
>   


In general,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

