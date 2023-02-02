Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832266877B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBBIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBBIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2E37DBED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675327168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEmUWkILhjHwy32wJlP5ahEThJlPzKxbPpXUXtBpjW8=;
        b=dd0IzM4fQHXsHLpOzmXF6HWXTtVmIk1Rms5lcnzAB4cAzzCja5LvwS6vbMWgNWLfcpojPh
        YoH77H7A/acrf02ePt3sAgxVKak1M0jBX8L6/0Z7m4c8vBRgKpH4mB7zjPzFLiuSporN3b
        +6WuR9z0PkosiZv2a5Q3NaotAphGvkM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-HeL15RLQMpaMI-7L4wJSTA-1; Thu, 02 Feb 2023 03:39:24 -0500
X-MC-Unique: HeL15RLQMpaMI-7L4wJSTA-1
Received: by mail-wm1-f69.google.com with SMTP id e38-20020a05600c4ba600b003dc434dabbdso2449146wmp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEmUWkILhjHwy32wJlP5ahEThJlPzKxbPpXUXtBpjW8=;
        b=6C2s1zfMNbt/9cxbCgV2h6BzZxqASPQa2P/fV+kuoJXOgpNLIPPSn29MHVh2ZY32L7
         o3nYIlz4FuUECfj6lPn+Fz7xzxZsGh9a7tBvphvLlEC0OYL3MxDLr5ghrTWYs0B5K4PL
         T4+xvCTsZe9SNEwSYNbPy4611XttUYphD7mnRLvBNE/3ZcW1CqQbgOp/9sX6Os3Xrwjl
         0Zf0+se7cErrr2lxAePuGC3pPhhblUYkXeb28ixgnGFHXGWoyj5I02t86CLgquXp2mei
         WNKQg/uBHCv4sZJt5NB+Y/yTHw6fjs1Th786+xhaKXSWNtH5xsTSkt2gwN+IqM/uM4oq
         72ug==
X-Gm-Message-State: AO0yUKUQIusbxANLkFMsh50/Sxgmboy8YoABLrDVZIQV7hejOQGTv/5g
        zWov8j6qaAAkP2vTYWO8yxgFj4f0XpXpPK3bOYvnUrVaKZ+XDDeV047aK7cLnwfvNkjMen31K3M
        epDaKwh4HDyZquFR20F2gV++p
X-Received: by 2002:adf:e192:0:b0:2bd:fa1d:5291 with SMTP id az18-20020adfe192000000b002bdfa1d5291mr5604511wrb.67.1675327163209;
        Thu, 02 Feb 2023 00:39:23 -0800 (PST)
X-Google-Smtp-Source: AK7set98llXB/OWQBWRDSwiILjhUm2SHG2oN+98oEMUauH+IM4rxQpqpkQvaA7kT1rOvZPHO/7OhmQ==
X-Received: by 2002:adf:e192:0:b0:2bd:fa1d:5291 with SMTP id az18-20020adfe192000000b002bdfa1d5291mr5604494wrb.67.1675327162961;
        Thu, 02 Feb 2023 00:39:22 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfeecd000000b002bbedd60a9asm19075117wrp.77.2023.02.02.00.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:39:22 -0800 (PST)
Message-ID: <7eb43c35-5245-df9b-9e81-ae59d176839c@redhat.com>
Date:   Thu, 2 Feb 2023 09:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/gup: Add folio to list when folio_isolate_lru()
 succeed
Content-Language: en-US
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     chinwen.chang@mediatek.com, andrew.yang@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.23 07:32, Kuan-Ying Lee wrote:
> If we call folio_isolate_lru() successfully, we will get
> return value 0. We need to add this folio to the
> movable_pages_list.
> 
> Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f3d2cccb89f8..918c364d01ac 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1914,7 +1914,7 @@ static unsigned long collect_longterm_unpinnable_pages(
>   			drain_allow = false;
>   		}
>   
> -		if (!folio_isolate_lru(folio))
> +		if (folio_isolate_lru(folio))
>   			continue;
>   
>   		list_add_tail(&folio->lru, movable_page_list);

Agreed that this deserves cc:stable

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

