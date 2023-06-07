Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE5725D47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjFGLh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbjFGLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7B71730
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686137828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Of8F7oP9DxodgyCzUqZAYENpIjCyox0604fXJEC1XUw=;
        b=CX8jWQwlG/DTgo6Mi6STFjIFsxbRBbeLOHhFSh1db9uymTXAxgK5WOp45sk/ujq19fYMt0
        p5tpPZzjodrsejmzHPc2WOM8JyxFVXZV9tnMXXcEpNnvphU9QKFZe35VuV9fGoByUpFK4O
        qBevxNn7HHTqScgFXrDrSHmCT1LkUqA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-MSE-PZTiP5OLH5IM9INVkA-1; Wed, 07 Jun 2023 07:37:07 -0400
X-MC-Unique: MSE-PZTiP5OLH5IM9INVkA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30aeef6f601so3285248f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137826; x=1688729826;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Of8F7oP9DxodgyCzUqZAYENpIjCyox0604fXJEC1XUw=;
        b=e3eCog3tU2nxHx78yKvABlHwxLGAPTQ1uczWY+bFF0CKmjGQ+IOufrLo3U1UDT3SbZ
         NkWHZAqyWOMJbpcsNowo0ccZKrEGvJIRCClkNaIvGyo5Q8PgfTfVPx2ObRKK0YBat0PQ
         zOREkFFzMqL0YejbrtqjRcuiJjJ9iUZCaiH0fIPR4k88ArcYEJ1XYZECKW/9hj7vE5mu
         HArUWTekqLY85Mc4sQHYW94AOSvRdcNHDJHYwD88YCLnZ9Tns4sAxd0pOwolDoO0SqHK
         +kBR2HvvBYRa+BJJ8heoMXnK+tw62hLYxbaORsRtlXPieNTAdSuatzlHXWtIKtCebfuC
         NBQg==
X-Gm-Message-State: AC+VfDyY0tFxSNmuk1vwdSKspa67uN2v639bQJgRl9eana56CaCHFvmQ
        ghNBGGuFHjXo3iemkeFZf1pkqftBttmGHro5s04LLlBMvkZOtzK21ZqC8jmJZHNR9nD/ez7+uiG
        QIBMa4gvgDc67EYrEFeOUa1KuKg+9XEQH
X-Received: by 2002:a5d:480b:0:b0:30e:5b7c:de1c with SMTP id l11-20020a5d480b000000b0030e5b7cde1cmr1271456wrq.11.1686137826603;
        Wed, 07 Jun 2023 04:37:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MUOjtFrG5onWxT2DxxqjjxHSYc3VMSVJB1Wn+zwDFfZnCS5zfDSPT78n2RmXbz+ZcAbVfWw==
X-Received: by 2002:a5d:480b:0:b0:30e:5b7c:de1c with SMTP id l11-20020a5d480b000000b0030e5b7cde1cmr1271442wrq.11.1686137826261;
        Wed, 07 Jun 2023 04:37:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9c00:8d26:3031:d131:455c? (p200300cbc70e9c008d263031d131455c.dip0.t-ipconnect.de. [2003:cb:c70e:9c00:8d26:3031:d131:455c])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm15272856wrm.17.2023.06.07.04.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:37:05 -0700 (PDT)
Message-ID: <6ff9bcb0-3fa8-59ab-418d-7a53714efafe@redhat.com>
Date:   Wed, 7 Jun 2023 13:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: remove
 reset_node_managed_pages() in hotadd_init_pgdat()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     rppt@kernel.org, mhocko@kernel.org, osalvador@suse.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <f125f0db-30fe-5452-4669-3e48f7856569@redhat.com>
 <20230607024548.1240-1-haifeng.xu@shopee.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230607024548.1240-1-haifeng.xu@shopee.com>
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

On 07.06.23 04:45, Haifeng Xu wrote:
> managed pages has already been set to 0 in free_area_init_core_hotplug(),
> via zone_init_internals() on each zone. It's pointless to reset again.
> 
> Furthermore, reset_node_managed_pages() no longer needs to be exposed
> outside of mm/memblock.c. Remove declaration in include/linux/memblock.h
> and define it as static.
> 
> In addtion to this, the only caller of reset_node_managed_pages() is
> reset_all_zones_managed_pages(), which is annotated with __init, so it
> should be safe to also mark reset_node_managed_pages() as __init.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
> v2:
> - unexport reset_node_managed_pages()
> - mark reset_node_managed_pages() as __init
> - update commit message
> ---
>   include/linux/memblock.h | 1 -
>   mm/memblock.c            | 2 +-
>   mm/memory_hotplug.c      | 1 -
>   3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f82ee3fac1cd..f71ff9f0ec81 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -128,7 +128,6 @@ int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>   
>   void memblock_free_all(void);
>   void memblock_free(void *ptr, size_t size);
> -void reset_node_managed_pages(pg_data_t *pgdat);
>   void reset_all_zones_managed_pages(void);
>   
>   /* Low level functions */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3feafea06ab2..da4264528e1e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2122,7 +2122,7 @@ static unsigned long __init free_low_memory_core_early(void)
>   
>   static int reset_managed_pages_done __initdata;
>   
> -void reset_node_managed_pages(pg_data_t *pgdat)
> +static void __init reset_node_managed_pages(pg_data_t *pgdat)
>   {
>   	struct zone *z;
>   
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..65e385f34679 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1210,7 +1210,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>   	 * online_pages() and offline_pages().
>   	 * TODO: should be in free_area_init_core_hotplug?
>   	 */
> -	reset_node_managed_pages(pgdat);
>   	reset_node_present_pages(pgdat);
>   
>   	return pgdat;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

