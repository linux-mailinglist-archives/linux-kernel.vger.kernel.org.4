Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370D6C5200
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCVRPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCVRP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C63BC54
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679505290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhcQx2NxtkDvsHqlKyViRVKylH4cYj+8iP0eb4uVraM=;
        b=bVnwJdn46chGPfRhOolDKD0y/MRb2q4LCWYezRWin9saksTIrklkejRDGt36Y6zs7dS5vG
        kFS5WH2hVV+N1ia/hyUPtbMYGYuURVPXTclKwKIjVqw37VQl5cgGTvJI/cRZxjfkzOUFnu
        9DbuaMpkglfHarGsG84hQ/lnPMnhFgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-5Kh_RpbjPFuCH4es_42vdw-1; Wed, 22 Mar 2023 13:14:48 -0400
X-MC-Unique: 5Kh_RpbjPFuCH4es_42vdw-1
Received: by mail-wm1-f69.google.com with SMTP id e5-20020a05600c4e4500b003edc5824521so6472690wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505285;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhcQx2NxtkDvsHqlKyViRVKylH4cYj+8iP0eb4uVraM=;
        b=kZ6B8GWNOsNY3KaiU9b6U6QitvcIRqKUvBQKa09b5+IW0VjyZNFvaK5RIP2ikUg2tt
         y4nmI+ngLPNQdh+FT4gdtJ7TVj43Wc2zc70ORDcjhttgWHcKQZa3l64jy8oczQcs2Om8
         2hszICGdVO32oAsNJlND5U2K1M3VgOMlEFgpxhkoNW1asIS5seoPBqFh72D/rSS/+lyx
         AUSUHOJxId+ooaPO6qyAVwQ9SSz37uGVYfoaLLpuCWOuwfchFIHeL8HHj7c4I3K3Qe65
         4oVjYy5W3x/c2k3JUppelHjtoFfbM+GTfDDJJYPEjVafB9l816oJBQGhUweXEeEa5s5n
         QUDw==
X-Gm-Message-State: AO0yUKVo0mTKEGQFB1/hcCnmmpxlY/Y8YejkBXIJ1Ddm3DrnwdF3ZaNN
        kYMXC4NXS5g5t5bfT90wWJ64yrqAKU41207rShvbPnm5i2EpCtsHSN2vqAA7H4ZNbe8I3fwRXw+
        9U2KmT/v1nvNPY73O9k1suGIb
X-Received: by 2002:a05:600c:21c6:b0:3e2:1368:e395 with SMTP id x6-20020a05600c21c600b003e21368e395mr191853wmj.33.1679505285753;
        Wed, 22 Mar 2023 10:14:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ktA60W5SATyyrsmfQ99IK3ZDV+uvMG2CKK0dUg+fqy5KgjxxPddfBPOT/AJ0lUW89XuBWog==
X-Received: by 2002:a05:600c:21c6:b0:3e2:1368:e395 with SMTP id x6-20020a05600c21c600b003e21368e395mr191841wmj.33.1679505285384;
        Wed, 22 Mar 2023 10:14:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003ed29189777sm24112940wmq.47.2023.03.22.10.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:14:44 -0700 (PDT)
Message-ID: <ef94f19a-4754-6b19-1042-b7c9bca98035@redhat.com>
Date:   Wed, 22 Mar 2023 18:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mips: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
References: <20230322081520.2516226-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230322081520.2516226-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 09:15, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> MIPS defines insane ranges for ARCH_FORCE_MAX_ORDER allowing MAX_ORDER
> up to 63, which implies maximal contiguous allocation size of 2^63
> pages.
> 
> Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
> simple integer with sensible defaults.
> 
> Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
> will be able to do so but they won't be mislead by the bogus ranges.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/mips/Kconfig | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3e8b765b8c7b..a0f6e9d0a561 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2137,13 +2137,9 @@ endchoice
>   
>   config ARCH_FORCE_MAX_ORDER
>   	int "Maximum zone order"
> -	range 13 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
>   	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> -	range 12 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
>   	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
> -	range 11 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
>   	default "11" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
> -	range 0 63
>   	default "10"
>   	help
>   	  The kernel memory allocator divides physically contiguous memory

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

