Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF46699067
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBPJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBPJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DF2109
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676540825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9ZbC/yZoS+EllJFHjVEOvoIsGMwmzQvn0ZNh0HypLA=;
        b=Cnd1cPOWP6swcf5d81AnUK/taYmoXZsw7gvsCeYN0hg7xm+aNIH12TFKgxSSF7OxfV1FTs
        Na2j77aVuq3zx3ZEL6ThaDKqXG6FWpXoqN00R0o/oG7x4ARbnH9bMy5seStS4UCPQptVgx
        5+HiQFk0MIgJZrIgoEJr/fVBccxBhbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-571-lPaoSvx9NtCEzWxc3tibuw-1; Thu, 16 Feb 2023 04:47:04 -0500
X-MC-Unique: lPaoSvx9NtCEzWxc3tibuw-1
Received: by mail-wm1-f69.google.com with SMTP id o42-20020a05600c512a00b003dc5341afbaso856189wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9ZbC/yZoS+EllJFHjVEOvoIsGMwmzQvn0ZNh0HypLA=;
        b=MjQwIWonXkTgL8rpPd4x08IKjSD+/blZYdnPGmS6p5C1Ah+apqPRD3cbOU/ovcLnDU
         QuPFFcTIYP0eCECPEvaGo0qWZZRpc1fUOSOcOjlQX4S08+z65LYXy8OIs/x3HZhRWO+H
         JYwV+E0kJxyFj0OJyjvoniRwbhPfjDfCm0tVi8i9tQ1MLaBitAbCUwr963uM2G/v4ZuG
         EaeYbzye6sd9S9qtDO8cD6CR1Vp9x9+s0bRteBciBpGZJvs++jmNgKKJVzKEn1sEFMtb
         /4lT+tHIpORzYqvLPl6eq1haksFf2CJeYOyL2aU7quNHs0QxxDylC4nc9rYhTWCTueWL
         +8qw==
X-Gm-Message-State: AO0yUKW4hKUUZXsvP1DU33QsYSmRKC/WgxgvIAjPFGdtz7jwpHlHdViO
        3mvwBRAujsnH+/Zq7rG3NOEZZHFnDu6PKON7yu3qWGL5hkTgiokBgKPsQdmMKlY55tSsIruznFh
        CPjAsvUfFVzbd8fDCL1YwisM1
X-Received: by 2002:adf:fc8a:0:b0:2c5:5836:4e11 with SMTP id g10-20020adffc8a000000b002c558364e11mr3768188wrr.55.1676540822914;
        Thu, 16 Feb 2023 01:47:02 -0800 (PST)
X-Google-Smtp-Source: AK7set/YsK/s/hRdvzQyrsSnlrgQI2zLVsRG2a7mY/dJri7gXuWBq3Omxd+uIv12aRYY3hHjUxMqrQ==
X-Received: by 2002:adf:fc8a:0:b0:2c5:5836:4e11 with SMTP id g10-20020adffc8a000000b002c558364e11mr3768171wrr.55.1676540822595;
        Thu, 16 Feb 2023 01:47:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id n15-20020adff08f000000b002c567b58e9asm1028087wro.56.2023.02.16.01.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:47:02 -0800 (PST)
Message-ID: <9c274928-1118-1b31-9aff-07cd246cbbcf@redhat.com>
Date:   Thu, 16 Feb 2023 10:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: return nothing from
 do_migrate_range()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230215230300.61125-1-sj@kernel.org>
 <20230215230300.61125-2-sj@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230215230300.61125-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 00:02, SeongJae Park wrote:
> Return value mechanism of do_migrate_range() is not very simple, while
> no caller of the function checks the return value.  Make the function
> return nothing to be more simple.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/memory_hotplug.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bcb0dc41c2f2..6c615ba1a5c7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1620,8 +1620,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>   	return 0;
>   }
>   
> -static int
> -do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> +static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   {
>   	unsigned long pfn;
>   	struct page *page, *head;
> @@ -1721,8 +1720,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   			putback_movable_pages(&source);
>   		}
>   	}
> -
> -	return ret;
>   }

I think this patch should also stop initializing ret = 0 inside that 
function.

With that

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

