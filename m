Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99B6FB27B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjEHOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEHOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:22:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5119B9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:22:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FC931FF4C;
        Mon,  8 May 2023 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683555744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+CnzOGbtXpZAgNtp1Sbc0yNA//AQM0s+VQt27TC/ik=;
        b=eVM/8o1alDoqtQpkgMPhmAod2H5Fc6iyKsQDNKeqMLlHo/xPCR35JDYD+d+I7w4UZ9kWH3
        VCrzjKQvEPzPDVRetbxkswIOt8zxpkW/T4CbCF8/1fcRlTaJQbpnBLhdaXRKFVAV5Eaatf
        xxnm38qzJa8/0EbQEiMAH7BZSOHR0A4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FAFE1346B;
        Mon,  8 May 2023 14:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jLHpEJ8FWWQJCgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 08 May 2023 14:22:23 +0000
Date:   Mon, 8 May 2023 16:22:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, oom: do not check 0 mask in out_of_memory()
Message-ID: <ZFkFnY052onmeFnp@dhcp22.suse.cz>
References: <20230508073538.1168-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508073538.1168-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-05-23 07:35:38, Haifeng Xu wrote:
> Since commit 60e2793d440a ("mm, oom: do not trigger out_of_memory
> from the #PF"), no user sets gfp_mask to 0. Remove the 0 mask check
> and update the comments.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/oom_kill.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 044e1eed720e..612b5597d3af 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1130,12 +1130,10 @@ bool out_of_memory(struct oom_control *oc)
>  
>  	/*
>  	 * The OOM killer does not compensate for IO-less reclaim.
> -	 * pagefault_out_of_memory lost its gfp context so we have to
> -	 * make sure exclude 0 mask - all other users should have at least
> -	 * ___GFP_DIRECT_RECLAIM to get here. But mem_cgroup_oom() has to
> -	 * invoke the OOM killer even if it is a GFP_NOFS allocation.
> +	 * But mem_cgroup_oom() has to invoke the OOM killer even
> +	 * if it is a GFP_NOFS allocation.
>  	 */
> -	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
> +	if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
>  		return true;
>  
>  	/*
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
