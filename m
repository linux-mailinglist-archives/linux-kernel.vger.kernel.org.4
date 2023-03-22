Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB146C44D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCVIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCVIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:24:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F4E053;
        Wed, 22 Mar 2023 01:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6733DB81B8C;
        Wed, 22 Mar 2023 08:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A01AC433EF;
        Wed, 22 Mar 2023 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679473470;
        bh=0AVUHyovgdMtaGSIbe/hxeqI2SIVBTRTMuD+Kxhj5dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0sJPBPQ5mxTgEgqod7L2sRJ3rPU4r2mFbtlYi9ToJvKZfKM5BdnDWxlThmxhlFG0
         4rXulIjNkfRYBJay303dmS7zirK2fLz+SMMHEgdF3B4w8HCsXyVUb+Fhk9VfvQbGEB
         NqhFqjMUO5ADXRtI3ExWdtpiJOlZEEW2ETflNc6mp9R/zUsu0EBwHbAIJzAcKodZlb
         3L9RFyzrMArcFCEjkhRMtSaCfvPx6PiZmZdzUbTo5SkFcpRT8jQpiXKtMjYONs8GzT
         tYSpSTWRu3ehVHoLWwEr/FwOo5qL3AgieaAB5G2k4SqAtBiXYHXJknGvPVvgOs7+Hq
         pSu+RuIUfda/w==
Date:   Wed, 22 Mar 2023 10:24:15 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Message-ID: <ZBq7L5DAczRx74vu@kernel.org>
References: <20230322081520.2516226-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322081520.2516226-1-rppt@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention that the patch is on top of akpm/mm-unstable

On Wed, Mar 22, 2023 at 10:15:20AM +0200, Mike Rapoport wrote:
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
>  arch/mips/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3e8b765b8c7b..a0f6e9d0a561 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2137,13 +2137,9 @@ endchoice
>  
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	range 13 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
>  	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> -	range 12 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
>  	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
> -	range 11 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
>  	default "11" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
> -	range 0 63
>  	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
