Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B465D093
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjADKYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjADKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:24:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2931AA08
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E176164B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31511C433EF;
        Wed,  4 Jan 2023 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672827886;
        bh=YJDznZgeh+BEyxpBFvqDWK88sgorfwfW6T+7n5G8kBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgVGP5VVq0BrTBujIIWDYrh7WrFCLSxLy5waJh/0bBcp5l+kzsA6nWg4S2HxA4HeC
         YVdIEqt2xlij1Cjr3kBA7ehjmrNQsYSOtHz9m9GHdYtCDz+eXm0TmqhnNglyOQLq7c
         xxVcOXghk5cQlUk1akUMA+uf6y53euoquLn1xVbz8Tit+zEq6XvRV+WxwJtjHmJVmi
         R68APvlnk4Wn7xgAdZb8tHCQA/NBPC4KQpT0DRz4uL+vny2B7Yz79pXk6FVoV1R0qz
         albb58E8tcADOMab4FANw7CsHsKm+Vq67aCfROpBiPxgHfd4TC6BsLAG3BC447ILmK
         GR0gWL1KKtAJQ==
Date:   Wed, 4 Jan 2023 12:24:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] memblock: Fix return sizeless candidate on
 __memblock_find_range_top_down.
Message-ID: <Y7VT4gvLCQK7B1Ak@kernel.org>
References: <20230104095049.59043-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104095049.59043-1-ppbuk5246@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 06:50:49PM +0900, Levi Yun wrote:
> __memblock_find_range_top_down can return start address of free region
> which sizeless then user speicified.
> To prevent the above case, add size check on candidate free region.

Did you see an actual issue or it's solely based on code inspection?
 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..710e2ef8d67d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -262,7 +262,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
>  			continue;
>  
>  		cand = round_down(this_end - size, align);
> -		if (cand >= this_start)
> +		if (cand >= this_start && this_end - cand >= size)
>  			return cand;
>  	}
>  
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
