Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DD6B439A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjCJOQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjCJOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376AD733B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678457619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7zxiTlY/KjLxdbyEM0eMfFkU0GBlfDz/AuaOXGMZI0=;
        b=PCpVkVTIl0hhNTYB+Zz16CTVQpsR3JwCBs4RBqGvbOVVs8Y5cCaBFalVf2REocUT4NDn/c
        0n6BWoU036P+YRP44eVYNzugZ7HycXgkcB0hrT9NWAH667n7Pe0tbrMYbosSxb7+22XM5+
        g2o5Iu+8MaIaviZTYHZz8QNjafy5axE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-XxxlqPh5MnmyVFm0Bp4xvQ-1; Fri, 10 Mar 2023 09:13:38 -0500
X-MC-Unique: XxxlqPh5MnmyVFm0Bp4xvQ-1
Received: by mail-wm1-f71.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so1872719wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457617;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7zxiTlY/KjLxdbyEM0eMfFkU0GBlfDz/AuaOXGMZI0=;
        b=qcoJxl3D591UsbnC2OceGNZSx5KTjBAlDMI+O/eu6k7NXYpRqjEw1qOiWAjJMxAM7Q
         ySxTPAePbjIIoP1PZ0HBl28zeoF6EhIlBWDgdYuR32g+cbaGicDq12uKyDq5KAF4suzi
         5T/sigqJJ+MivA1NGpHqQsm0xVQIL89wBdW3PJ8EF6J4CdTx3UXcyPJW+0svVO4OesGN
         RVMcjIPygbIurqYWtL+2zWBpi74tohhON69lEefWpYXMGO6Kbecwkwpf3iHHRQyeibOC
         K81YhdR18oaehxRovcUCl1f3xjP8B/HTbwZfOH/B4538m/zAQ8fQD1695HFb4B5LC8TW
         60pg==
X-Gm-Message-State: AO0yUKV2wsGu4T2NAYQrBAR0TZA//M6GiOu4ieD1mfipNreDOH03KaAy
        8HofhLYPKumz9NsZAlwV021MS3Zx0PmMzXZ8u0ZBfvBWPpfoPyQjmi0/cwINY8MQ6HpEgwEIyJ6
        45AQDjE0uVWL94GcEm7ORdXIy
X-Received: by 2002:adf:f34c:0:b0:2c7:b3b9:a39d with SMTP id e12-20020adff34c000000b002c7b3b9a39dmr17068380wrp.11.1678457616965;
        Fri, 10 Mar 2023 06:13:36 -0800 (PST)
X-Google-Smtp-Source: AK7set8n9E7TFK3Ba8ZSojU5csRxgVkI3eiMHH3uZmv6dakjA9e52sCj2rxvfm8TjkNYBkF6OFenTw==
X-Received: by 2002:adf:f34c:0:b0:2c7:b3b9:a39d with SMTP id e12-20020adff34c000000b002c7b3b9a39dmr17068362wrp.11.1678457616612;
        Fri, 10 Mar 2023 06:13:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1100:12e6:ffa5:775d:18ee? (p200300cbc707110012e6ffa5775d18ee.dip0.t-ipconnect.de. [2003:cb:c707:1100:12e6:ffa5:775d:18ee])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002c567b58e9asm2202310wrs.56.2023.03.10.06.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:13:36 -0800 (PST)
Message-ID: <117b3a88-0046-95f9-060b-98dd8c09fc64@redhat.com>
Date:   Fri, 10 Mar 2023 15:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: memory-failure: correct HWPOISON_INJECT config
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org
References: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.23 14:38, Kefeng Wang wrote:
> Use IS_ENABLED(CONFIG_HWPOISON_INJECT) to check whether or not to
> enable HWPoison injector module.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/memory-failure.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fae9baf3be16..f761704d27d7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -168,7 +168,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>   	return true;
>   }
>   
> -#if defined(CONFIG_HWPOISON_INJECT) || defined(CONFIG_HWPOISON_INJECT_MODULE)
> +#if IS_ENABLED(CONFIG_HWPOISON_INJECT)
>   
>   u32 hwpoison_filter_enable = 0;
>   u32 hwpoison_filter_dev_major = ~0U;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

