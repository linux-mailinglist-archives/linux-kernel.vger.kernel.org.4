Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F086FE278
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEJQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C67D80
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683736091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wug8MPxwb1qwikFpXl+LsvcQU0BExfoIt784lLQszUA=;
        b=Ns3y+AMVl+2a9ertl3kZIXOonu7Jg4tNe7BkDOMgSKbgnaINnmDBu0fH3gIZTLQnvHfJjy
        tmRgj/yb7QeXnlDJpL9PHWFU0hMUydRO884/jEzoROE8+tZxamKdEqOfWYKmy4jiwrc1lb
        UCTTtfuzOUDPnLGG0ruH++tsspL3qiU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-1Kwm6vD6NBqm5ZXGguP5Ng-1; Wed, 10 May 2023 12:28:10 -0400
X-MC-Unique: 1Kwm6vD6NBqm5ZXGguP5Ng-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24e00b8cc73so4155526a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736089; x=1686328089;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wug8MPxwb1qwikFpXl+LsvcQU0BExfoIt784lLQszUA=;
        b=JHxHZBz1OiErplTw5Ef8eowOvjcwDXMG6nJJbb0LlXWhiqKqd+/hF/BBHhUPU5Qnlg
         HEMQfqs5G7WAJQin+OnTPRvvBOgAq0dp9Mez5VBFgJQkLtwQIjtLrkBzTPVM9kavV05+
         fptS4OYBJOlfwN9texeaZ6gUygWG7tEoFuVZsCQtly2DYN75B2iug0VWr+xJngoTbRbE
         3Tw2bxM7//4xxZe30QtFWwNDZo1imjd9cYVUYSf1LxBCYfTNFsXtj8Jwf8+TxF6w6Q7+
         zmeegdWmckPk+l0ru36EKyG9TEkcqmMe/OE+B1cQx9uIGH72NMDSDOpbHVNtDjURdcTu
         Sjug==
X-Gm-Message-State: AC+VfDwTbF2jG3yoSpeeSHwGxxwXD2QJpxINW2cEBFju2CU+YPs0LRYZ
        HYsixb76M4hyHKHCSSTyPAUmFKe2761eV4oU0VUrkOTZ6qzL152ZF6v5JzC+jWBCxRNW+pxoHOb
        wKZb4nR1vVpzZEC6vxNXXtX4b
X-Received: by 2002:a17:90b:3b8b:b0:252:7114:b37a with SMTP id pc11-20020a17090b3b8b00b002527114b37amr1700951pjb.47.1683736089092;
        Wed, 10 May 2023 09:28:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71vWUUnU7AsOBwsGxC0ccIsutZeH6ArG3YH506jPelGdB7oxxS6W/XHzHY2l9G3KKb1qg+vQ==
X-Received: by 2002:a17:90b:3b8b:b0:252:7114:b37a with SMTP id pc11-20020a17090b3b8b00b002527114b37amr1700938pjb.47.1683736088796;
        Wed, 10 May 2023 09:28:08 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:5835:5bd3:f0c8:e5ef? ([2001:4958:15a0:30:5835:5bd3:f0c8:e5ef])
        by smtp.gmail.com with ESMTPSA id lr8-20020a17090b4b8800b0024752ff8061sm22035186pjb.12.2023.05.10.09.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:28:08 -0700 (PDT)
Message-ID: <7d72d054-2994-cc5a-53fb-c28eba32be49@redhat.com>
Date:   Wed, 10 May 2023 18:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: memory_hotplug: Fix format string in warnings
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        rick.wertenbroek@heig-vd.ch
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230510090758.3537242-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230510090758.3537242-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.23 11:07, Rick Wertenbroek wrote:
> The format string in __add_pages and __remove_pages has a typo
> and prints e.g., "Misaligned __add_pages start: 0xfc605 end: #fc609"
> instead of "Misaligned __add_pages start: 0xfc605 end: 0xfc609"
> Fix "#%lx" => "%#lx"
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>   mm/memory_hotplug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..9061ac69b1b6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -325,7 +325,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>   	}
>   
>   	if (check_pfn_span(pfn, nr_pages)) {
> -		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
> +		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
>   		return -EINVAL;
>   	}
>   
> @@ -525,7 +525,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>   	map_offset = vmem_altmap_offset(altmap);
>   
>   	if (check_pfn_span(pfn, nr_pages)) {
> -		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
> +		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
>   		return;
>   	}
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

