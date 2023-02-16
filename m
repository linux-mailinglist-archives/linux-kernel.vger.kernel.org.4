Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958C869907A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBPJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBPJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940BC165
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676540968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSf4rPxDI4PK5WHfG9t2gwXH78HiPuNdnpkIgDcejxM=;
        b=hmdflMMSl2G2RJbmYwDGLNGzmn37QNjro8XMp8cSaB2EO2C3Uh3JFhrUL2GecsByxzXTNz
        rS4zVTOvdGyVVqVwhGI6NlLw70nY0RQ/itd75crU5P/GCiVBOXmNZEYmgm4egeHrYsUJka
        CmaSztgDacTyNjde3bYj52ttah4glh4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-NypfMnQuPIGX9JGjJPbX0g-1; Thu, 16 Feb 2023 04:49:27 -0500
X-MC-Unique: NypfMnQuPIGX9JGjJPbX0g-1
Received: by mail-wr1-f72.google.com with SMTP id r15-20020a5d494f000000b002c54d9b8312so150499wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSf4rPxDI4PK5WHfG9t2gwXH78HiPuNdnpkIgDcejxM=;
        b=yNVFENWMT1E2NWw3pRm9/JuBciqZxCJDsBoyKL1/EDQX94tO9HQjM8TpZPR/ZcHK7h
         8Zr4mId/wbtisWrgF+kwcaSlpTkDeDFzn1u+I3XuX9FG2Whb3khHfQ7cmU2Qi58X3u6Q
         mbZFgeshExKsW6iwm3t6zLOfkmX2xt386mnbCoI1b+FLHZhfy49p4XBFViLlDf/GIk1R
         tjKqfaviTFbwVnOu71DcmeP5CHZUlUtghgy3O2fNtLwCN69YKtDI6i8m/aVI3WS6Cpiu
         3Jv724rxtFDLDGeNYIJS3/UMPywCAlACDWK3fUDWHVLkDYAvg8yQbRUpzP7nteg5VouX
         fhHw==
X-Gm-Message-State: AO0yUKV0MBTEGzfvsv0NbiSrYImZ6mN9Y4JSwejwhLZia/hT1hYw9pHp
        zo/tCcsomUXNWND21kAXKRSK6XF6C/5o2H/zT31D0JWvAz053WoPAd6oOocTZk835e6hL5HFilD
        Iwl5C4CR4YtoiH9o+QTRNu6XQ
X-Received: by 2002:a05:600c:a292:b0:3d9:fb59:c16b with SMTP id hu18-20020a05600ca29200b003d9fb59c16bmr4388646wmb.36.1676540966143;
        Thu, 16 Feb 2023 01:49:26 -0800 (PST)
X-Google-Smtp-Source: AK7set86Dteipgj8wYxbQ5+bF8BJUjd+1l5fPmvG52JGhNgza9RUkZ4v6+ebNPF3JYs/1oa95PuUVg==
X-Received: by 2002:a05:600c:a292:b0:3d9:fb59:c16b with SMTP id hu18-20020a05600ca29200b003d9fb59c16bmr4388625wmb.36.1676540965378;
        Thu, 16 Feb 2023 01:49:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b003e206cc7237sm3546085wms.24.2023.02.16.01.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:49:24 -0800 (PST)
Message-ID: <85d0ddcb-4e47-4f2e-2897-a785872b860c@redhat.com>
Date:   Thu, 16 Feb 2023 10:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: cleanup 'ret' variable usage in
 do_migrate_range()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230215230300.61125-1-sj@kernel.org>
 <20230215230300.61125-3-sj@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230215230300.61125-3-sj@kernel.org>
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

On 16.02.23 00:03, SeongJae Park wrote:
> Because do_migrate_range() is returning nothing, some 'ret' variable
> usages are unnecessary.  Remove unnecessary usage and reduce its scope.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/memory_hotplug.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6c615ba1a5c7..6df3072d11df 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1624,7 +1624,6 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   {
>   	unsigned long pfn;
>   	struct page *page, *head;
> -	int ret = 0;
>   	LIST_HEAD(source);
>   	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
>   				      DEFAULT_RATELIMIT_BURST);
> @@ -1678,7 +1677,6 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   						    page_is_file_lru(page));
>   
>   		} else {
> -			ret = -EBUSY;
>   			if (__ratelimit(&migrate_rs)) {
>   				pr_warn("failed to isolate pfn %lx\n", pfn);
>   				dump_page(page, "isolation failed");
> @@ -1692,6 +1690,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   			.nmask = &nmask,
>   			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>   		};
> +		int ret;
>   
>   		/*
>   		 * We have checked that migration range is on a single zone so

Please squash that into the previous patch, just calling it 
"mm/memory_hotplug: cleanup return value handling in do_migrate_range()" 
or similar.

-- 
Thanks,

David / dhildenb

