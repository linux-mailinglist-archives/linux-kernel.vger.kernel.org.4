Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66C646DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLHLAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLHK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:59:51 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B7596408;
        Thu,  8 Dec 2022 02:52:39 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p3EW2-0002wy-00; Thu, 08 Dec 2022 11:52:34 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B762FC2060; Thu,  8 Dec 2022 11:36:18 +0100 (CET)
Date:   Thu, 8 Dec 2022 11:36:18 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     yang.yang29@zte.com.cn
Cc:     julia.lawall@inria.fr, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] MIPS: OCTEON: cvmx-bootmem: use strscpy() to
 instead of? strncpy()
Message-ID: <20221208103618.GA8388@alpha.franken.de>
References: <202212031417162803709@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212031417162803709@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 02:17:16PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-bootmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
> index 306cee07ce3f..334bf8e577e5 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
> @@ -780,9 +780,8 @@ int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
>  	if (addr_allocated >= 0) {
>  		named_block_desc_ptr->base_addr = addr_allocated;
>  		named_block_desc_ptr->size = size;
> -		strncpy(named_block_desc_ptr->name, name,
> +		strscpy(named_block_desc_ptr->name, name,
>  			cvmx_bootmem_desc->named_block_name_len);
> -		named_block_desc_ptr->name[cvmx_bootmem_desc->named_block_name_len - 1] = 0;
>  	}
> 
>  	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
> -- 
> 2.15.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
