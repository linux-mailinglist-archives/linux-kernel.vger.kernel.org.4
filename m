Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356F665F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjAKPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbjAKPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:48:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BA33D67
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:46:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA3006017A;
        Wed, 11 Jan 2023 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673451974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGle1qDaVLgCmc/KzANyHq27FrunNJVqz61yvg3H7TM=;
        b=ezLduFndFN+PyJnkiyV0RCMWop/miUrrWZlSQSn9lbKQ7RPAZcw3SikHtm1D3clqUPSFtV
        XNEmVWAQCgQ1UhW66B5NYVglF35FSjWgyFptyR2WQNEyzkKEHfFyBwT4vWVQgCTnRBhIBC
        JnbQz1+NiRifLjPFyJVvWFrnTjLbMMU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B57E1358A;
        Wed, 11 Jan 2023 15:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6CiJI8bZvmNDPQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 15:46:14 +0000
Date:   Wed, 11 Jan 2023 16:46:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] mm/page_alloc.c: Allow __GFP_NOFAIL requests deeper
 access to reserves
Message-ID: <Y77ZxWRYe+4RPGRj@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-6-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109151631.24923-6-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 15:16:29, Mel Gorman wrote:
> Currently __GFP_NOFAIL allocations without any other flags can access 25%
> of the reserves but these requests imply that the system cannot make forward
> progress until the allocation succeeds. Allow __GFP_NOFAIL access to 75%
> of the min reserve.

I am not sure this is really needed. IIRC the original motivation for
allowing NOFAIL request to access access to memory reserves was
GFP_NOFS|__GFP_NOFAIL requests which do not invoke the OOM killer.
The amount of memory reserves granted was not really important. The
point was to allow to move forward. Giving more of the reserves is a
double edge sword. It can help in some cases but it can also prevent
other high priority users from fwd progress.

I would much rahter see such a change with an example where it really
made a difference.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6f41b84a97ac..d2df78f5baa2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5308,7 +5308,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		 * could deplete whole memory reserves which would just make
>  		 * the situation worse
>  		 */
> -		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
> +		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
>  		if (page)
>  			goto got_pg;
>  
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
