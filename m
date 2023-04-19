Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEE6E7421
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjDSHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjDSHit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:38:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F271980
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:38:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FF14218A9;
        Wed, 19 Apr 2023 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681889922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0ScSRd7XdrWa3mKgZYiQMwWQPIvOIHXV2c6WBE5gyQ=;
        b=MG/521apeHblfAHRLJbK+QJuWM3lOblltBAW47vHMjDzJTMCPCT4JDCN5JYbQBieaO+UiV
        3E+Z/kJbrHQkzRuL1Is1hZBUoka63P/WOHxIAyAPsgAd98RoSuX7GqwVD2YCflM3dMopa7
        XBYSgM4SrXdR9jTXtHntFIjwLAHYlZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62B9213580;
        Wed, 19 Apr 2023 07:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CYzUFIKaP2QOSgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Apr 2023 07:38:42 +0000
Date:   Wed, 19 Apr 2023 09:38:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] memcg, oom: remove explicit wakeup in
 mem_cgroup_oom_synchronize()
Message-ID: <ZD+agX9/xxLe2cK+@dhcp22.suse.cz>
References: <ZDUxVG2otm5i12o2@dhcp22.suse.cz>
 <20230419030739.115845-2-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419030739.115845-2-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 03:07:39, Haifeng Xu wrote:
> Before commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to
> the charge path"), all memcg oom killers were delayed to page fault
> path. And the explicit wakeup is used in this case:
> 
> thread A:
>         ...
>         if (locked) {           // complete oom-kill, hold the lock
>                 mem_cgroup_oom_unlock(memcg);
>                 ...
>         }
>         ...
> 
> thread B:
>         ...
> 
>         if (locked && !memcg->oom_kill_disable) {
>                 ...
>         } else {
>                 schedule();     // can't acquire the lock
>                 ...
>         }
>         ...
> 
> The reason is that thread A kicks off the OOM-killer, which leads to
> wakeups from the uncharges of the exiting task. But thread B is not
> guaranteed to see them if it enters the OOM path after the OOM kills
> but before thread A releases the lock.
> 
> Now only oom_kill_disable case is handled from the #PF path. In that
> case it is userspace to trigger the wake up not the #PF path itself.
> All potential paths to free some charges are responsible to call
> memcg_oom_recover() , so the explicit wakeup is not needed in the
> mem_cgroup_oom_synchronize() path which doesn't release any memory
> itself.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>

I hope I haven't missed anything but this looks good to me. One way to
test this would be a parallel OOM triggering workload which uses page
faults and an automatic user space driven oom killer (detect under_oom
and send SIGKILL to a random task after a random timeout). Objective is
that no task gets stuck in mem_cgroup_oom_synchronize. I am pretty sure
this could be easily turned into a selftest.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: split original into two and improve patch description
> ---
>  mm/memcontrol.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fbf4d2bb1003..710ce3e7824f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2003,15 +2003,8 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  	mem_cgroup_unmark_under_oom(memcg);
>  	finish_wait(&memcg_oom_waitq, &owait.wait);
>  
> -	if (locked) {
> +	if (locked)
>  		mem_cgroup_oom_unlock(memcg);
> -		/*
> -		 * There is no guarantee that an OOM-lock contender
> -		 * sees the wakeups triggered by the OOM kill
> -		 * uncharges.  Wake any sleepers explicitly.
> -		 */
> -		memcg_oom_recover(memcg);
> -	}
>  cleanup:
>  	current->memcg_in_oom = NULL;
>  	css_put(&memcg->css);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
