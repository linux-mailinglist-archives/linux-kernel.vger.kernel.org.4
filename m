Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E725E9BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIZI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiIZI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F50A356CC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664180816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6kVQxgDaKttefr6LvFpoSU7rbEztqe/rwJtDt7FFSw=;
        b=CxcrShJa9OtBOqYSENX6oI2I21oxbf+hVV7DMwJGnIgT9ClkLSpEVy8zIeOBQebABAhNWV
        TM4H3xWEjI30kuO7ZQiYDvarDx8gp2vhjoL9Q4LM5ENfOTUn6/pBvAYvjPu6O7G9AqqmnV
        P7Y2jrUsuvNLsoif08bq2O6yaKucC7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-aHyvJQMnOL-SJGD_ZQ1zvA-1; Mon, 26 Sep 2022 04:26:55 -0400
X-MC-Unique: aHyvJQMnOL-SJGD_ZQ1zvA-1
Received: by mail-wm1-f71.google.com with SMTP id t14-20020a1c770e000000b003b4856a6ecaso1595033wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R6kVQxgDaKttefr6LvFpoSU7rbEztqe/rwJtDt7FFSw=;
        b=ZVe6EnLz7o+A21tCoOkJc6oD5YeK+z++naZwa1N0AOz4CFrKJHNgMat+GXADBlAQPL
         rkA8GaXYMcf7TAP683dBLLSzfohE0xq74wbw+izCcIiFMI9vYMRBx/RYUuj5DvbNBiov
         foKtzwZzBTw/mSJBL2q55tKDKAb1/C/EgDWncewCWz+hLGd7t1xlinoUGA+CogkO8aP0
         i3JtZbNodlOMPU8tp+dCvTycn8EkTeIQ1XMJrqus9Gw4jya/hiwjvJZca2mfDXIOkMCw
         /u/HKS2LJI3OTJR/NN8l4ss7sHN+x+5IrXCbEkFp1SFeyPTncuC1LlREKDJnVl3zu6tp
         l5cQ==
X-Gm-Message-State: ACrzQf2PEd62esGnW51jVHuNG0VyPVyp+KY+M2W+3m5N9qLhGgdHo7FA
        4D7lz49+xdDzt/sH+J4bzb+1acnEy2ggGffqwR27ZnHk2R8wdcOYmCHoy/jA0k2R3g6+Iq4BLqY
        HMeCOW6X+lZn2YcbrwEZrDDyY
X-Received: by 2002:a05:600c:4f82:b0:3b4:9f2f:430b with SMTP id n2-20020a05600c4f8200b003b49f2f430bmr21036105wmq.16.1664180814431;
        Mon, 26 Sep 2022 01:26:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7UbvwgXNhwxU1xdrO2alWyD+qqM4PoM2/a/0ZUOs6VVeKnKiIpHoohUPQxs97J8FJ848nRoQ==
X-Received: by 2002:a05:600c:4f82:b0:3b4:9f2f:430b with SMTP id n2-20020a05600c4f8200b003b49f2f430bmr21036087wmq.16.1664180814116;
        Mon, 26 Sep 2022 01:26:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d6b42000000b00225307f43fbsm13780433wrw.44.2022.09.26.01.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:26:53 -0700 (PDT)
Message-ID: <353188b6-1fa6-0d53-b699-869a0588ee39@redhat.com>
Date:   Mon, 26 Sep 2022 10:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] mm/page_table_check: Check writable zero page in page
 table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
 <20220911095923.3614387-2-pasha.tatashin@soleen.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220911095923.3614387-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.22 11:59, Pasha Tatashin wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> The zero page should remain all zero, so that it can be mapped as
> read-only for read faults of memory that should be zeroed. If it is ever
> mapped writable to userspace, it could become non-zero and so other apps
> would unexpectedly get non-zero data. So the zero page should never be
> mapped writable to userspace. Check for this condition in
> page_table_check_set().
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/page_table_check.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index e2062748791a..665ece0d55d4 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>   	if (!pfn_valid(pfn))
>   		return;
>   
> +	BUG_ON(is_zero_pfn(pfn) && rw);

We most probably don't want that:

https://lkml.kernel.org/r/20220923113426.52871-2-david@redhat.com

-- 
Thanks,

David / dhildenb

