Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4796C6ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjCWR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjCWR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355EF1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679592452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqUj59ylPYbek9OHHWmJ/oxl6nIZ0K3LfZJ1jC35bg4=;
        b=fwAxNY9/+EvWl6p417jQwT2O8pIZV9sZnVfUuZPLs+mpqOR9ROO12/ATx6xSl3CFzIZsyU
        gLLyAUcXt5+1evQI/hVN3Y47sGVjvolRxDPFSh3BpXA01f3fL+/11E31VzZui1aY6x/kCi
        Ld/1CnK4PhU/FcuDm4fElzRubu9U/5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-DUioiuNlMyesrS7KpP3NPQ-1; Thu, 23 Mar 2023 13:27:31 -0400
X-MC-Unique: DUioiuNlMyesrS7KpP3NPQ-1
Received: by mail-wm1-f69.google.com with SMTP id bh19-20020a05600c3d1300b003ee93fac4a9so977308wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592450;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqUj59ylPYbek9OHHWmJ/oxl6nIZ0K3LfZJ1jC35bg4=;
        b=nm52I5pfaxcnTif5HcfloWB3FxAYsAdgL/rJdL4QmkvpQ7etVfJB9Q5RCHnxWw/Qkx
         X0EPFZ/nziVLZivgWpfIdO+AjTslRBFLEl4QLQCuBQMGQh5y+ZSL6pQuOrGwdJ1uDavN
         zmVN5nLYqEi/Bu9PfEVixBRfmzetySkmLyzVER77YOI3M79XXaTZeO2Y1aduSzokANrE
         SYfc1dXpnO/5qxQNCw0meCejHjwfWXknDenyqkgbgthDfdkbPW3+KKpDZoQrVW2ZkRvO
         IsbMDuPLXzKLJeIWCaqWE0njVuCSJBLZJZmBPXLYeNLIwuncjzKsR3hyyVECJivbI/oz
         vPUw==
X-Gm-Message-State: AAQBX9cumWkK7DVf4GKdj75J1oLAzvETBCOt+nb1TmmrgJmPrYQPSm/4
        PQMj20whW+gXyPah5iW2iNuiXMyj31Mq2LhNQRqfRZiKs6P94ua4yPnHxx0Ic12mSnhnm/9fMsH
        NCxPmTE0NU+lMufPp85guOPhQ5DPzu764
X-Received: by 2002:adf:f382:0:b0:2ce:a6de:2098 with SMTP id m2-20020adff382000000b002cea6de2098mr3247322wro.17.1679592450270;
        Thu, 23 Mar 2023 10:27:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350bErc1SOUZLCZE3ySna6brxGhOEwPKg+R5sV3oNSZC92wU9Vza0cMQB2t6urjMMr12jYwAT2A==
X-Received: by 2002:adf:f382:0:b0:2ce:a6de:2098 with SMTP id m2-20020adff382000000b002cea6de2098mr3247309wro.17.1679592449992;
        Thu, 23 Mar 2023 10:27:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:e500:5cdf:c280:4b31:4016? (p200300cbc704e5005cdfc2804b314016.dip0.t-ipconnect.de. [2003:cb:c704:e500:5cdf:c280:4b31:4016])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe10d000000b002db1b66ea8fsm3123495wrz.57.2023.03.23.10.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 10:27:29 -0700 (PDT)
Message-ID: <a9985035-237a-467c-6516-f996d56cb7e5@redhat.com>
Date:   Thu, 23 Mar 2023 18:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm: Be less noisy during memory hotplug
Content-Language: en-US
To:     Tomas Krcka <krckatom@amazon.de>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20230323171904.14444-1-krckatom@amazon.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230323171904.14444-1-krckatom@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.23 18:19, Tomas Krcka wrote:
> Turn a pr_info() into a pr_debug() to prevent dmesg spamming on systems
> where memory hotplug is a frequent operation.
> 
> Fixes: 966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the point where we init pgmap")
> 

Fixes? I suggest top drop that tag here.

> Suggested-by: Jan H. Schönherr <jschoenh@amazon.de>
> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ac1fc986af44..14d70f4e6c0a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6959,7 +6959,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   				     compound_nr_pages(altmap, pfns_per_compound));
>   	}
>   
> -	pr_info("%s initialised %lu pages in %ums\n", __func__,
> +	pr_debug("%s initialised %lu pages in %ums\n", __func__,
>   		nr_pages, jiffies_to_msecs(jiffies - start));
>   }
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

