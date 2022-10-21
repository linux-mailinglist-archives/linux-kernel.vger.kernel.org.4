Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4430607090
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJUGzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJUGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7F664D6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666335301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azbR1iYqZdjkLxcnJ4PM0CwNs7s9IcYhQ0EBbhWLuQQ=;
        b=d02KuBjN4zUu1fgD2/LwO29Iit3bD7TY71yVT3HNiWCuD12RRQm+ZIYcVKGpZsML2iQDKo
        FK72/Bj8R0yBMCTgovoFif4h7tykDFOr6MKYyjH6iJJ4LlnDDqGQfVSVcXiNqer0t82exj
        K9X/Lv8G6jN8mh4JSdjaXH5RlJS8xek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-Z2uIgD6HNHCYzOXADsNhUw-1; Fri, 21 Oct 2022 02:54:59 -0400
X-MC-Unique: Z2uIgD6HNHCYzOXADsNhUw-1
Received: by mail-wm1-f71.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so1067955wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azbR1iYqZdjkLxcnJ4PM0CwNs7s9IcYhQ0EBbhWLuQQ=;
        b=7ToHbXnyUmYbeush2p8b3n1eh6/0zSCjwXDDhWmFr2v/z3xMbZzvH+ZPLsmF7SNaez
         04JOogr+/ZKdfNclzJ27BljGuNVjSAPPARQDo2vcsOSd606jfl+uHg9k/VooS0Zhf/cx
         GVpw1iDBfy7N8gxk6yqvmMlnQeAHi8tPMnekxgihh3lM/hGpDN+WyFyGEDKc7S28CkdU
         Ltz9e7azwFAVXA0sRxF/OByQzA1XOww6GZCmOapH+VU6aEvIo2ZTte6uu9AIe1U3/XtA
         S0k8p7J7yyzLzFUop1m2F/TJYG5OcOg7c04z8Ydu4maHiA1+sRA4Q59VG9X9gmNCd8FH
         08MQ==
X-Gm-Message-State: ACrzQf1nIFRl00+HsZvMFcS5M/U1FsN9m1A7P7/hTK7iK0g0a33bKFcZ
        DJdpad9dluho6f/jKMTKb/Ohe83IDN/KkW3dLGwrq6ofbW/F6q7CFM+T96JhLKJFVCq485erG6E
        dTyOOyyhm6Wk0qTXEcfddjytF
X-Received: by 2002:a05:6000:1051:b0:22e:5d8a:d3d5 with SMTP id c17-20020a056000105100b0022e5d8ad3d5mr11029995wrx.476.1666335298295;
        Thu, 20 Oct 2022 23:54:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7nywPHwEgg407aCL0VBvl6j32KpgwSPv03Ps5WxcZoWqv+Aab1gImv2W/IVSJenOEhTVywYQ==
X-Received: by 2002:a05:6000:1051:b0:22e:5d8a:d3d5 with SMTP id c17-20020a056000105100b0022e5d8ad3d5mr11029980wrx.476.1666335298017;
        Thu, 20 Oct 2022 23:54:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1700:e40d:574c:c991:5f78? (p200300cbc7081700e40d574cc9915f78.dip0.t-ipconnect.de. [2003:cb:c708:1700:e40d:574c:c991:5f78])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0022e6f0d0d7csm21744709wrb.18.2022.10.20.23.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 23:54:57 -0700 (PDT)
Message-ID: <d00d6e23-6e4f-074f-67c3-5f00e8a913d2@redhat.com>
Date:   Fri, 21 Oct 2022 08:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/1] mm/page_isolation: fix clang deadcode warning
To:     Maria Yu <quic_aiquny@quicinc.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, opendmb@gmail.com
References: <20221021051936.15346-1-quic_aiquny@quicinc.com>
 <20221021051936.15346-2-quic_aiquny@quicinc.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221021051936.15346-2-quic_aiquny@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.22 07:19, Maria Yu wrote:
> When !CONFIG_VM_BUG_ON, there is warning of
> clang-analyzer-deadcode.DeadStores:
> Value stored to 'mt' during its initialization
> is never read.
> 
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>   mm/page_isolation.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 04141a9bea70..a7a478a22123 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -330,9 +330,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   				      zone->zone_start_pfn);
>   
>   	if (skip_isolation) {
> -		int mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));

__maybe_unused should work as well. Was that considered?

-- 
Thanks,

David / dhildenb

