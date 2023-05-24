Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D470EF51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbjEXHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjEXHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35242AA
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684913096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOWburZop7IRyE9mCdh6a3TB9Gbj+e6pc25ewY0dTOI=;
        b=SIRhqUsfWoFMzCbgdC+K2CbuyE7b58455Bnz8ujs3/RTqx0Yj7o8t0vFpa8UQ125ybIhWP
        mKjqOPcTym4928uezgvB50lw5c0Bsbb5oVfU39YwsYvaV40stDPoLmzRNSCt6zPqTXUb69
        AJiFbtTIEIjGxKRTD9BZCipDTcrN7bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-hUKvoE2NMkSzQ_FzS8kn_Q-1; Wed, 24 May 2023 03:24:54 -0400
X-MC-Unique: hUKvoE2NMkSzQ_FzS8kn_Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5fb41bc42so2506465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684913093; x=1687505093;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOWburZop7IRyE9mCdh6a3TB9Gbj+e6pc25ewY0dTOI=;
        b=W6lk+qkgYOI5sFQlZ6wDo/ugcHN3KbP03V36m+dPwydSfey/do+ml+ACUkq/VAfnb+
         qpCWkINfXQL2xM1NvqVCnY0t5GlapkPvKM3juS6fGgTqjW6gWhgiR6SYPW+b6IP/+Vap
         Pw47Ziao9Xuu46ncKJA/vOTh8TllYxFJuQzjL0TeKuIulDWFzkH3VQtmc2r2dfINzeoh
         oNZnLQjR94sXkzypbJ5nl3nX2Rej4uqpqrHFb3KnlNakwdhZMYHdyLjReLF6Vf/i4sNm
         13QJ/J0uIfsaOEgfpgAYenPGJU63/tZ6BSshkFspeCTCfvKxhst6kN4Ro3MXOd6D/HCM
         KtiQ==
X-Gm-Message-State: AC+VfDyxGNFSJ5oWRwVI9U7Trb/r4KN64cONnz7vw9LRG8yxD+LTy8z1
        s63BEUzJbZ3g6aSdkMM6N7WnjXfIoQ6xn82d8IslWLstgpHTWgK64mmctEhxQ1nzdsiSUG8rXr/
        uhcygSZpo49WiScCAaWiIo17G
X-Received: by 2002:a1c:f615:0:b0:3f5:878:c0c2 with SMTP id w21-20020a1cf615000000b003f50878c0c2mr11933957wmc.3.1684913093521;
        Wed, 24 May 2023 00:24:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7atvM2j02RAHsay7ecQLnin92v7/D/DAFbH6Z0yh8ugUDWe8s2XE5NoBOor7UbvEuspoqgzQ==
X-Received: by 2002:a1c:f615:0:b0:3f5:878:c0c2 with SMTP id w21-20020a1cf615000000b003f50878c0c2mr11933941wmc.3.1684913093207;
        Wed, 24 May 2023 00:24:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f42d8dd7d1sm1328501wml.7.2023.05.24.00.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:24:52 -0700 (PDT)
Message-ID: <a2e53f37-e76a-930d-3020-2ebc4b3986b2@redhat.com>
Date:   Wed, 24 May 2023 09:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 3/5] ksm: add ksm zero pages for each process
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305241351365661923@zte.com.cn>
 <20230524055800.20498-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230524055800.20498-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.23 07:58, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> As the number of ksm zero pages is not included in ksm_merging_pages per
> process when enabling use_zero_pages, it's unclear of how many actual
> pages are merged by KSM. To let users accurately estimate their memory
> demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
> pages per process. In addition, it help users to know the actual KSM
> profit because KSM-placed zero pages are also benefit from KSM.
> 
> since unsharing zero pages placed by KSM accurately is achieved, then
> tracking empty pages merging and unmerging is not a difficult thing any
> longer.
> 
> Since we already have /proc/<pid>/ksm_stat, just add the information of
> 'ksm_zero_pages' in it.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---

[...]

>   static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..14f781509812 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -777,7 +777,7 @@ struct mm_struct {
>   #ifdef CONFIG_KSM
>   		/*
>   		 * Represent how many pages of this process are involved in KSM
> -		 * merging.
> +		 * merging (not including ksm_zero_pages).
>   		 */
>   		unsigned long ksm_merging_pages;
>   		/*
> @@ -785,7 +785,12 @@ struct mm_struct {
>   		 * including merged and not merged.
>   		 */
>   		unsigned long ksm_rmap_items;
> -#endif
> +		/*
> +		 * Represent how many empty pages are merged with kernel zero
> +		 * pages when enabling KSM use_zero_pages.

"zero page" ? Only some archs have multiple ones, and it's rather an 
implementation detail.

> +		 */
> +		unsigned long ksm_zero_pages;
> +#endif /* CONFIG_KSM */
>   #ifdef CONFIG_LRU_GEN
>   		struct {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

