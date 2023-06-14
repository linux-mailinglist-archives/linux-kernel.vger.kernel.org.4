Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB372F818
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbjFNImz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjFNImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A571BC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686732121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Owpi2SX75vf893dHZP5yFIiV94ajm8nG5xJNVjgQKe4=;
        b=gBzOGgXiJAueRmQRAU2RljcGzF37aF8nluXhGQJ+ZGoeuOuXrOgbGGR2zQzRd/mT0FhmY/
        XR5uoOXliOwa/GXwQRHlvuwhhF9FWTjLeDeiHObzSovDXuEWQQZVRjUg8yp21k1c5pBdfB
        6bv1kIVdTvmcdTHNQglTjqDRGuTf9cM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-zxhS8WgLMDyqXyCpQo4dTg-1; Wed, 14 Jun 2023 04:42:00 -0400
X-MC-Unique: zxhS8WgLMDyqXyCpQo4dTg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f8d3609a7bso1444475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732119; x=1689324119;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Owpi2SX75vf893dHZP5yFIiV94ajm8nG5xJNVjgQKe4=;
        b=iGon7IAPzMiR/qz24G3VgHxBfqogJBVvZc54VGSB16mrCiuov/ziwC87VP6tHh3MVC
         0ukBlsNnpyk42QExcUMCDz5yS4g1aZH8kmsq3nr6dRqIUD/3Bi8SjqpRedJ2k/HKJUKJ
         hoS4MsWj4ZCfVkSjvd564ChmZPIhqpFfpUAvBjTLoUBWyC5/L64+YIUufYAVmFkeSZ8h
         Vct/Kfb9icfcmiK86/RdIZDYz0GsGhJSPZdapLw7IdZY0aoI5Ai+F85TUlmeaIZhaW3i
         PBbeA2khJJwOKaGbq0B9aqZpVIwgKRK1Xr+CRE0ODG4/4LehByo9/KQ8noHoIVHr5ndC
         POKQ==
X-Gm-Message-State: AC+VfDwbRWhPZrZEDjlQCYu7kRT3Ldie6hs5h0TCYySKHml03pIs8pO8
        AATaM8cx6zuQi7YphyzujHGJDeAj7WmHz+weWyKGqiizXxSFj0OLLmy4Qe3Pa1BoY4pDJR8+noP
        LktElhhcI2X7Axio1Stmc90CL
X-Received: by 2002:a05:600c:cb:b0:3f7:3a19:b951 with SMTP id u11-20020a05600c00cb00b003f73a19b951mr9127589wmm.21.1686732119192;
        Wed, 14 Jun 2023 01:41:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xTsl2WxsuwLu6DEpYmKAKYfFg1ToBVlcsmvbKJZjuhF+SpmKYqxIgztujYVuB7TtcnwaPug==
X-Received: by 2002:a05:600c:cb:b0:3f7:3a19:b951 with SMTP id u11-20020a05600c00cb00b003f73a19b951mr9127575wmm.21.1686732118831;
        Wed, 14 Jun 2023 01:41:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003f8044b3436sm16370815wmg.23.2023.06.14.01.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:41:58 -0700 (PDT)
Message-ID: <92bb89b1-23a2-668d-a5fa-6306336241a0@redhat.com>
Date:   Wed, 14 Jun 2023 10:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: page_io: Prefer 'unsigned int' to bare use of
 'unsigned'
Content-Language: en-US
To:     hexingwei001@208suo.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230614071804.13110-1-panzhiai@cdjrlc.com>
 <1e132a6416d673e285af610ff185fa5f@208suo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1e132a6416d673e285af610ff185fa5f@208suo.com>
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

On 14.06.23 09:23, hexingwei001@208suo.com wrote:
> Fix the following checkpatch warning:
> 
> mm/page_io.c:87: WARNING: Prefer 'unsigned int' to bare use of
> 'unsigned'.
> mm/page_io.c:89: WARNING: Prefer 'unsigned int' to bare use of
> 'unsigned'.
> mm/page_io.c:109: WARNING: Prefer 'unsigned int' to bare use of
> 'unsigned'.
> 
> Signed-off-by: Xingwei He <hexingwei001@208suo.com>
> ---
>    mm/page_io.c | 6 +++---
>    1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 684cd3c7b59b..138f73386612 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -84,9 +84,9 @@ int generic_swapfile_activate(struct swap_info_struct
> *sis,
>    {
>        struct address_space *mapping = swap_file->f_mapping;
>        struct inode *inode = mapping->host;
> -    unsigned blocks_per_page;
> +    unsigned int blocks_per_page;
>        unsigned long page_no;
> -    unsigned blkbits;
> +    unsigned int blkbits;
>        sector_t probe_block;
>        sector_t last_block;
>        sector_t lowest_block = -1;
> @@ -106,7 +106,7 @@ int generic_swapfile_activate(struct
> swap_info_struct *sis,
>        last_block = i_size_read(inode) >> blkbits;
>        while ((probe_block + blocks_per_page) <= last_block &&
>                page_no < sis->max) {
> -        unsigned block_in_page;
> +        unsigned int block_in_page;
>            sector_t first_block;
> 
>            cond_resched();
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

