Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F95B95AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIOHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIOHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:48:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046F71727
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:48:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C0D033A3E;
        Thu, 15 Sep 2022 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663228086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsTf4WFIx3ndJJe11Vrfh3fpJ7fymPrJc2VjyOh0Ix4=;
        b=gGHiZdrmBXc+ToLIgjhB2BX561tBIyMXd3OhQwK4S0HERrXimWoGYGJ5K4rjQTYL2tW+CB
        99lcPoGmCn/MX3v5Moddf5kEFwo4224DhuXbxwac1ByUUJKT9+pJQaxW0CjZhtyZOkrNRI
        75mF9GmV2jv312ifRWzGNaaZh6zVrMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663228086;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsTf4WFIx3ndJJe11Vrfh3fpJ7fymPrJc2VjyOh0Ix4=;
        b=Ng5UxaMnEI6Vt05HxQcmpa1wSGSzo+Zs9zoN08IlJghVuYBiCSwF1nVOwi19R0AWKGiszT
        vVS5KJKhQdm9gFBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20869133A7;
        Thu, 15 Sep 2022 07:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x4sfBbbYImNmagAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:48:06 +0000
Date:   Thu, 15 Sep 2022 09:48:04 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] mm/page_alloc: remove obsolete
 gfpflags_normal_context()
Message-ID: <YyLYtLWSHLpBohML@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-16-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-16-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:50PM +0800, Miaohe Lin wrote:
> Since commit dacb5d8875cc ("tcp: fix page frag corruption on page
> fault"), there's no caller of gfpflags_normal_context(). Remove it
> as this helper is strictly tied to the sk page frag usage and there
> won't be other user in the future.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/gfp.h | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ea6cb9399152..ef4aea3b356e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -36,29 +36,6 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>  }
>  
> -/**
> - * gfpflags_normal_context - is gfp_flags a normal sleepable context?
> - * @gfp_flags: gfp_flags to test
> - *
> - * Test whether @gfp_flags indicates that the allocation is from the
> - * %current context and allowed to sleep.
> - *
> - * An allocation being allowed to block doesn't mean it owns the %current
> - * context.  When direct reclaim path tries to allocate memory, the
> - * allocation context is nested inside whatever %current was doing at the
> - * time of the original allocation.  The nested allocation may be allowed
> - * to block but modifying anything %current owns can corrupt the outer
> - * context's expectations.
> - *
> - * %true result from this function indicates that the allocation context
> - * can sleep and use anything that's associated with %current.
> - */
> -static inline bool gfpflags_normal_context(const gfp_t gfp_flags)
> -{
> -	return (gfp_flags & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC)) ==
> -		__GFP_DIRECT_RECLAIM;
> -}
> -
>  #ifdef CONFIG_HIGHMEM
>  #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
>  #else
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
