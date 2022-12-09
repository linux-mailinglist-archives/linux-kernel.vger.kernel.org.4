Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AD76482B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLINRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLINRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:17:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C88AF6E54E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:17:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8F023A;
        Fri,  9 Dec 2022 05:17:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.39.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868643F73B;
        Fri,  9 Dec 2022 05:17:09 -0800 (PST)
Date:   Fri, 9 Dec 2022 13:17:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Xander Moerkerken <xandermoerkerken@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xander Moerkerken <xander.moerkerken@gmail.com>,
        Xander Moerkerken <xander.moerkerken@omron.com>
Subject: Re: [PATCH] Added ability to vmalloc executable memory
Message-ID: <Y5M1UowMyucPOqAl@FVFF77S0Q05N>
References: <20221209131052.64235-1-xander.moerkerken@omron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209131052.64235-1-xander.moerkerken@omron.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:10:52PM +0100, Xander Moerkerken wrote:
> From: Xander Moerkerken <xander.moerkerken@gmail.com>
> 
> Since release 5.8-rc1 the pgprot got removed from __vmalloc
> because the only usage was PAGE_KERNEL as argument.
> However, this removes the ability to input other arguments
> such as 'PAGE_KERNEL_EXEC', which can be used to allocate
> memory in which you can execute. For this reason a new
> function is introduced called '__vmalloc_exec'.
> 
> Signed-off-by: Xander Moerkerken <xander.moerkerken@omron.com>

What is this going to be used for? There's no user from this patch alone, as a
module or otherwise.

Mark.

> ---
>  include/linux/vmalloc.h | 1 +
>  mm/vmalloc.c            | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..10c46513b6b2 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -147,6 +147,7 @@ extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
>  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> +extern void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
>  extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  			unsigned long start, unsigned long end, gfp_t gfp_mask,
>  			pgprot_t prot, unsigned long vm_flags, int node,
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..8fd01ed7082b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3294,6 +3294,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>  
> +
> +void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> +{
> +	return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_EXEC,
> +	                          NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(__vmalloc_exec);
> +
>  /**
>   * vmalloc - allocate virtually contiguous memory
>   * @size:    allocation size
> -- 
> 2.37.2
> 
