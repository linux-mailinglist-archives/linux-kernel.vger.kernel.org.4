Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC26C4582
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCVJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:00:18 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25BCB50713;
        Wed, 22 Mar 2023 02:00:10 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1peuKE-0004ZM-00; Wed, 22 Mar 2023 10:00:06 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 540DCC1B28; Wed, 22 Mar 2023 09:59:53 +0100 (CET)
Date:   Wed, 22 Mar 2023 09:59:53 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Message-ID: <20230322085953.GA3910@alpha.franken.de>
References: <20230322081520.2516226-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322081520.2516226-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Thank you for cleaning this up.

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
