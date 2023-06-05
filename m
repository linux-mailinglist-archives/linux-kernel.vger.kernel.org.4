Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111A7224AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjFELei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjFELeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5219FF9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWZsawEmNjsKMnfR+1l0oUcAwfNqWG5eEd+XBf5YquQ=;
        b=KlCRPFLLzlh/Llu0nPfffWrM1DfU2N8pbGGU2hoh0rnfMX0hUqsz76Qfja7TDjC8B90ulp
        6/67El5Swgh61pdcutOAr/RtkQfRL1QSUOqJJ0pYVTgC7ZPM+A0Q7GfVPKg16K7J4fP78G
        bl6G0k0iifKHK19chyHeir06aNWy5KA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-XAMZDxFUNS2H_R06VouwNw-1; Mon, 05 Jun 2023 07:33:26 -0400
X-MC-Unique: XAMZDxFUNS2H_R06VouwNw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30af779d6e6so2206098f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964805; x=1688556805;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWZsawEmNjsKMnfR+1l0oUcAwfNqWG5eEd+XBf5YquQ=;
        b=cklocWdeEvn9phwZN24cS7I1/FpcJ+r709SGfeRaWEtJpy5SAWbPChTft8RUMz9Qfn
         yhtfbWchKYbWAksE0EceNV4t0f66sVEftvLQZkSbZXTHJQQrzXuLAoAD1UXEbwhApoEQ
         ATwveehbJOBDW4DEw2BsuDbBxls9uQzTzCsWpcM5apjc/c1lg6zpArsBG3XupAp5y7Ad
         0r0P+FXMNXhu64/j/I6crn0LsqI429SLDv8b7i8kXpZgMbquls/XuYtXlK2WyVpfMIzm
         rWDEdXJ8xF+s6NS9kFGLxtWszxF8a64zcx+kVt//dE3SyTDkvW/gUPtgVpa0x9eSFiUu
         l+wg==
X-Gm-Message-State: AC+VfDz/sEb9DMkaSr6eVlWA8h+WZblNGrdCzS/DJoexY3k1EaQ8YUFf
        qMXtiIaXQM1WZKKWD+MWQHsva+V0XgMhT9J2neXIYMBaA29vRGgLUk780TeXzmmySK6GXVZrArc
        gvN0gEG0FDeAwASxW4R/r1ryr
X-Received: by 2002:a5d:61d0:0:b0:309:4f23:e52d with SMTP id q16-20020a5d61d0000000b003094f23e52dmr4260850wrv.43.1685964805212;
        Mon, 05 Jun 2023 04:33:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RQ3AlCqjOV82nqoNru2DfVOGvG/WnLvkOAZxPivnxiDb0Dn3L3EHv5MhHI1/VKuS8RsBUQw==
X-Received: by 2002:a5d:61d0:0:b0:309:4f23:e52d with SMTP id q16-20020a5d61d0000000b003094f23e52dmr4260835wrv.43.1685964804884;
        Mon, 05 Jun 2023 04:33:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id x14-20020adfec0e000000b003062d815fa6sm9585755wrn.85.2023.06.05.04.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:33:24 -0700 (PDT)
Message-ID: <4ad9df00-fd3e-56f7-d2b8-240d24045a48@redhat.com>
Date:   Mon, 5 Jun 2023 13:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] mm: page_alloc: remove unneeded header files
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230603112558.213694-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603112558.213694-1-linmiaohe@huawei.com>
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

On 03.06.23 13:25, Miaohe Lin wrote:
> Remove some unneeded header files. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 19d97dde4558..e991c6b4d252 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -26,7 +26,6 @@
>   #include <linux/kmsan.h>
>   #include <linux/module.h>
>   #include <linux/suspend.h>
> -#include <linux/pagevec.h>
>   #include <linux/ratelimit.h>
>   #include <linux/oom.h>
>   #include <linux/topology.h>
> @@ -36,8 +35,6 @@
>   #include <linux/memory_hotplug.h>
>   #include <linux/nodemask.h>
>   #include <linux/vmstat.h>
> -#include <linux/sort.h>
> -#include <linux/pfn.h>
>   #include <linux/fault-inject.h>
>   #include <linux/compaction.h>
>   #include <trace/events/kmem.h>
> @@ -52,7 +49,6 @@
>   #include <linux/memcontrol.h>
>   #include <linux/ftrace.h>
>   #include <linux/lockdep.h>
> -#include <linux/nmi.h>
>   #include <linux/psi.h>
>   #include <linux/khugepaged.h>
>   #include <linux/delayacct.h>

On mm-unstable, I assume

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

