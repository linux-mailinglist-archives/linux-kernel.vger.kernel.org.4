Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979DF6E7415
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjDSHf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjDSHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:35:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B8F9010
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:35:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5438921905;
        Wed, 19 Apr 2023 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681889714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyB/75+jiUPM1QbAHiRPjsAvKjjCWrsA4ssFHkqLNwg=;
        b=TMg4G2d65HjVAIwxzRQu9OhxitpicLJzY8btsIHMJCIOh89/dx6yaEOgOLMEzWTwUSIEI4
        wRbkUDjOHdqaKYUmw3JYnu0nhLISwxDy/WYBYW/Prik4ad/n7jDCAxaZMvDT+gI9KrUD0S
        iTbEnNvz5azS24fykLbj+LP1gg2r3AA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D20213580;
        Wed, 19 Apr 2023 07:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DamWCLKZP2Q5SAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Apr 2023 07:35:14 +0000
Date:   Wed, 19 Apr 2023 09:35:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg, oom: remove unnecessary check in
 mem_cgroup_oom_synchronize()
Message-ID: <ZD+ZsV6siXmUa8zm@dhcp22.suse.cz>
References: <ZDUxVG2otm5i12o2@dhcp22.suse.cz>
 <20230419030739.115845-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419030739.115845-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 03:07:38, Haifeng Xu wrote:
> mem_cgroup_oom_synchronize() is only used when the memcg oom handling is
> handed over to the edge of the #PF path. Since commit 29ef680ae7c2 ("memcg,
> oom: move out_of_memory back to the charge path") this is the case only
> when the kernel memcg oom killer is disabled (current->memcg_in_oom is
> only set if memcg->oom_kill_disable). Therefore a check for
> oom_kill_disable in mem_cgroup_oom_synchronize() is not required.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: split original into two and improve patch description
> ---
>  mm/memcontrol.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..fbf4d2bb1003 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1999,16 +1999,9 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  	if (locked)
>  		mem_cgroup_oom_notify(memcg);
>  
> -	if (locked && !memcg->oom_kill_disable) {
> -		mem_cgroup_unmark_under_oom(memcg);
> -		finish_wait(&memcg_oom_waitq, &owait.wait);
> -		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> -					 current->memcg_oom_order);
> -	} else {
> -		schedule();
> -		mem_cgroup_unmark_under_oom(memcg);
> -		finish_wait(&memcg_oom_waitq, &owait.wait);
> -	}
> +	schedule();
> +	mem_cgroup_unmark_under_oom(memcg);
> +	finish_wait(&memcg_oom_waitq, &owait.wait);
>  
>  	if (locked) {
>  		mem_cgroup_oom_unlock(memcg);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
