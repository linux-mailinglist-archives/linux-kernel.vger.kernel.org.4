Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D0655891
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiLXF6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiLXF6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:58:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A5611A05
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14DFCB8213E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 05:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49417C433D2;
        Sat, 24 Dec 2022 05:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671861509;
        bh=uLCqzEDC7jZshVTitUpPbVlxqEqcXcWdhQ+wKrZOuBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oY69dP0YwPKeVzIAPzTOQCQss/orLy++K0YqkKnEAuTue4N2+LU2HR8pxHD9Il0L+
         6PePIx2s2ATD8bWTEQj/ZY4aHfrmXWSBt+bfORUk5xffQCIv7kG+i3dHMChhmcJ3Ea
         xzfTQHJjEGmU3fqeYPVA8VPjT1yF4NOwW5U0jSENu2ahzADqPV/+FPWYxZTSfEbwLF
         0OSlbrAb1RhokURUAZV7ef1Xg65sXHl1frUbvyKHBT4BUZ2zkgpPvNpk/50QdgG+1n
         c826LYOjcF7JcaGf0jXL1FmlWPXrp2M/w40vDDyYad6Q+staSRWe6p0pbgNucOsHzU
         Yd3bN4RqnWn2A==
Date:   Fri, 23 Dec 2022 22:58:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     ndesaulniers@google.com, trix@redhat.com,
        akpm@linux-foundation.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH linux-next] lib: Dhrystone: initialize ret value
Message-ID: <Y6aVA9M/wxsi/KKh@dev-arch.thelio-3990X>
References: <20221224050640.64427-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224050640.64427-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 01:06:40PM +0800, Zhouyi Zhou wrote:
> Initialize ret value whenever 'if' condition is false in dhry_run_set.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Dear Developers:
> When I invoke make bzImage LLVM=1, clang complains followings:
> lib/dhry_run.c:61:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false
> 
> Fix above complain by initialize the ret value.
> 
> Thanks
> Zhouyi

Thank you for the patch! I think this has already been fixed:

https://lore.kernel.org/20221219221045.0ABAEC433D2@smtp.kernel.org/

-next is on a break so it won't be there for a bit:

https://lore.kernel.org/20221220112148.64f183ce@canb.auug.org.au/

Cheers,
Nathan

> --
>  lib/dhry_run.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/dhry_run.c b/lib/dhry_run.c
> index 31a1d442e4a0..be86e5126c29 100644
> --- a/lib/dhry_run.c
> +++ b/lib/dhry_run.c
> @@ -64,6 +64,7 @@ static int dhry_run_set(const char *val, const struct kernel_param *kp)
>  			return ret;
>  	} else {
>  		dhry_run = true;
> +		ret = 0;
>  	}
>  
>  	if (dhry_run && system_state == SYSTEM_RUNNING)
> -- 
> 2.34.1
> 
