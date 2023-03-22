Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8006C5206
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCVRPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCVRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D14637F7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679505300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBppRhOrRBmo4SnTGVUqBOXa70ZawMCQKN6tcvrZ2lw=;
        b=fD+KPDxT+uy5x0/pA7H1R+LXtLj0kyhipqTbdKUxYRyzI7zqeyKiCoEtyvHSbFVm1Ua8kd
        /WSFjbyprTgY0c/YySux5F+RpjDAJ/+FFAJs/1CDYEDvD0fUgP7p9QQQdwuBbpddd8PyFg
        ssYI6b8xSLenHzlYG/EFVrI0tXYsw+4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-f6FIZVpVMXOZM96gjxl3sg-1; Wed, 22 Mar 2023 13:14:59 -0400
X-MC-Unique: f6FIZVpVMXOZM96gjxl3sg-1
Received: by mail-wm1-f71.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so9063427wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505298;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBppRhOrRBmo4SnTGVUqBOXa70ZawMCQKN6tcvrZ2lw=;
        b=W75YDi9ZloxpUY8b6QsbEAqhxhkcUqaxJ+0lXmg0x9c3CwK4GOglJNGCORwZXM9laf
         vTt/gk1xrWpQU4q5GYODU1oDXZP8tJUSVrZh2Exizmy1SXIN+qeBykBUyyO5Obk/a7eK
         Yi6gn8WV6hoszAC+Pn4P0YW1t9ju0A9mfRxHaKiXwNEyvZCvlKSs9yy3kQZjRa4a5rxa
         YU2EJNp9NSYQEF8HRG5osED8GqcVX72zz83DD1pf3URySUsGzQLNs3wnVcKCov1yz0G4
         K35PRyeR3owjkotajZfA7FNKuddh1PoM3YxC1AJsl7YV29sVAEZISQOYoXBpkHRmDios
         guXA==
X-Gm-Message-State: AAQBX9cRnnnBZBiCHgf2nYlTS1FNkCO2jhyF7JYCn9PRbnMBsWSNE0vc
        yZEmMcbK9o8fH5iGgQdnkNkyUP4C0Uy9QmG9XsSZsiAchgCK3h4VUSQtHxBKIW1sEqyPJu7lv1y
        zOw+RBKeT5AtFHTEfQCkgj6YI
X-Received: by 2002:adf:eac3:0:b0:2d1:6104:76af with SMTP id o3-20020adfeac3000000b002d1610476afmr435263wrn.28.1679505297940;
        Wed, 22 Mar 2023 10:14:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350YsyeX98944Y42ANtbCd1Si/fvtvfwMtr422hgZd2KEDMQKJqDia4iR2kzSJPSt4GGwSrvF0A==
X-Received: by 2002:adf:eac3:0:b0:2d1:6104:76af with SMTP id o3-20020adfeac3000000b002d1610476afmr435247wrn.28.1679505297615;
        Wed, 22 Mar 2023 10:14:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000120d00b002d7a75a2c20sm6918238wrx.80.2023.03.22.10.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:14:57 -0700 (PDT)
Message-ID: <f2729e78-bb8b-b1b7-7a5e-0e7d5075d33c@redhat.com>
Date:   Wed, 22 Mar 2023 18:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] loongarch: drop ranges for definition of
 ARCH_FORCE_MAX_ORDER
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@vger.kernel.org
References: <20230322081727.2516291-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230322081727.2516291-1-rppt@kernel.org>
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

On 22.03.23 09:17, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> LoongArch defines insane ranges for ARCH_FORCE_MAX_ORDER allowing
> MAX_ORDER up to 63, which implies maximal contiguous allocation size of
> 2^63 pages.
> 
> Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
> simple integer with sensible defaults.
> 
> Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
> will be able to do so but they won't be mislead by the bogus ranges.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
> 
> This applies to akpm/mm-unstable tree
> 
>   arch/loongarch/Kconfig | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 272a3a12c98d..e1e3a3828962 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -420,11 +420,8 @@ config NODES_SHIFT
>   
>   config ARCH_FORCE_MAX_ORDER
>   	int "Maximum zone order"
> -	range 13 63 if PAGE_SIZE_64KB
>   	default "13" if PAGE_SIZE_64KB
> -	range 11 63 if PAGE_SIZE_16KB
>   	default "11" if PAGE_SIZE_16KB
> -	range 10 63
>   	default "10"
>   	help
>   	  The kernel memory allocator divides physically contiguous memory

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

