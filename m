Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDC5B93AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 06:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIOEeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 00:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiIOEeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:34:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F918E4EB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 21:34:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A88D5CCAE;
        Thu, 15 Sep 2022 04:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663216444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5/z54frbvxXoAbMjgu4uOYR70plD0Fi7+VY1zuIczo=;
        b=QW+nu7Uh54+PMwibzMW5XVBt0/dy9tJZ1fX+d2mUcurnS02kX0S+I+xG/uWUiCU/2z70xm
        q7iJXuLRxMatZTCNcMP6E2mZO0/cDlX+hDxleCuUrHIuJ6LeLZ1hdFkZS+HOD0fB4lq7dJ
        JVcC4ie5s74ONdsYaocqqa7rmO7XqzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663216444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5/z54frbvxXoAbMjgu4uOYR70plD0Fi7+VY1zuIczo=;
        b=Jnu//URwA9D6Ch+X/Blx3j1U2Ed07UXsGkchW//dAlhN4R8Ic1VQ97sTQuN4l5sbTUElyd
        GBwttHts7KuaxHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCA1B139C8;
        Thu, 15 Sep 2022 04:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o/4yMzurImOrKAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 04:34:03 +0000
Date:   Thu, 15 Sep 2022 06:34:02 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm/page_alloc: ensure kswapd doesn't accidentally
 go to sleep
Message-ID: <YyKrOnf0VhBQMUhd@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:36PM +0800, Miaohe Lin wrote:
> If ALLOC_KSWAPD is set, wake_all_kswapds() will be called to ensure
> kswapd doesn't accidentally go to sleep. But when reserve_flags is
> set, alloc_flags will be overwritten and ALLOC_KSWAPD is thus lost.
> Preserve the ALLOC_KSWAPD flag in alloc_flags to ensure kswapd won't
> go to sleep accidentally.
> 
> Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ba5c9402a5cb..4b97a03fa2dd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5147,7 +5147,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  
>  	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
>  	if (reserve_flags)
> -		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
> +		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
> +					  (alloc_flags & ALLOC_KSWAPD);
>  
>  	/*
>  	 * Reset the nodemask and zonelist iterators if memory policies can be
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
