Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF346DD944
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDKLVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDKLVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420A3596
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:21:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA5FD21A47;
        Tue, 11 Apr 2023 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681212096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82lOFgdBVYINhhrKJi05kihOdbuv6p0omPOKS3yzBIw=;
        b=UUelcH4mP4U/ZJVUoloWTrseIbp1Z5pbGWuM3LnSx/cfSNJzkOemWzf5P/qlFw5xyt95vf
        +1PQB4azG4NjQwEj5ZY/+bTdQXnXiO8YJ/kSiOchHkwF6yiDAga+kS8EtvJL1cGGMilx3Y
        wn0Gv/eTdED39qRKECss2Sv7M5eHyLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681212096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82lOFgdBVYINhhrKJi05kihOdbuv6p0omPOKS3yzBIw=;
        b=rVQTft2tfptnekBUEA06kH3puYeYDPg9clM6TLBZ2LPxSxUxWEwMRgIK/PnNTWkoX6DmBQ
        xPU6PHZ0GQhUIaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7568A13519;
        Tue, 11 Apr 2023 11:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E82KHMBCNWSFaQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 11:21:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2AF3BA0732; Tue, 11 Apr 2023 13:21:30 +0200 (CEST)
Date:   Tue, 11 Apr 2023 13:21:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     yizhou.tang@shopee.com
Cc:     neilb@suse.com, tj@kernel.org, wufengguang@huawei.com,
        jack@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tangyeechou@gmail.com, chunguang.xu@shopee.com, yue.zhao@shopee.com
Subject: Re: [PATCH v2] mm: Fix memcg writeback for rt tasks
Message-ID: <20230411112130.7zswqnyifgjhshif@quack3>
References: <20230411082248.1020719-1-yizhou.tang@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411082248.1020719-1-yizhou.tang@shopee.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-04-23 16:22:48, yizhou.tang@shopee.com wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> In domain_dirty_limits(), the calculation of the thresh and bg_thresh
> variable needs to consider whether it's for global dirtypage writeback
> or memcg dirtypage writeback. However, in the rt_task branch, the
> accumulation of both variables only considers the global_wb_domain,
> which seems strange to me.
> 
> I find the accumulation was introduced in the commit a53eaff8c119 ("MM:
> increase safety margin provided by PF_LESS_THROTTLE"). IMHO, realtime
> tasks are given a higher page cache limit because they require higher
> responsiveness, but we also need to consider whether the writeback of
> realtime tasks occurs in the global dirtypage writeback or in the memcg
> dirtypage writeback scenario.
> 
> Later Neil said he didn't know what was wanted for realtime in the
> commit message of commit a37b0715ddf3 ("mm/writeback: replace
> PF_LESS_THROTTLE with PF_LOCAL_THROTTLE"). I guess he made this small
> mistake since the commit a53eaff8c119 ("MM: increase safety margin
> provided by PF_LESS_THROTTLE").
> 
> Fixes: a53eaff8c119 ("MM: increase safety margin provided by PF_LESS_THROTTLE")
> CC: NeilBrown <neilb@suse.com>
> CC: Tejun Heo <tj@kernel.org>
> CC: Fengguang Wu <wufengguang@huawei.com>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Thanks for the patch! Was this found just by code inspection or is there
any practical problem you are trying to fix with this patch?

> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 516b1aa247e8..7d92de73360e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -419,8 +419,8 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>  		bg_thresh = thresh / 2;
>  	tsk = current;
>  	if (rt_task(tsk)) {
> -		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
> -		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
> +		bg_thresh += bg_thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
> +		thresh += thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;

This makes sense but I'm not 100% sure this does not reintroduce the
problem a53eaff8c119 was trying to fix. Reading the changelog, it seems the
extra term you are fixing is there specifically to deal with ratelimiting,
which is global (and not per-memcg), of calls to balance_dirty_pages() and
hence using global_wb_domain.dirty_limit is indeed correct. Neil?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
