Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8E6BE884
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCQLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCQLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:47:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F35DF71B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:47:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FE171FDDE;
        Fri, 17 Mar 2023 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679053656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6PNEKXZBANXXYlgBFt4BSZwmt2KtLDfnR7EpFF/l24=;
        b=QEr6ZWlEz1RxsRIxf3gBBdzWoMa3CRgVx5t/K0QBsh+2JW9lT9jT958osg1G9LMq5EfWAe
        /7eQIFU+x4+jJ/RSizu581yJu+pNbKGGA6itD36+TcN/xJ6+RuPg8ChWrcZPajfqbeeSFj
        XIBe+Bs26fzGkkS8W7XaXRjpRjJBar0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C7D91346F;
        Fri, 17 Mar 2023 11:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id unqGEFhTFGTOHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 17 Mar 2023 11:47:36 +0000
Date:   Fri, 17 Mar 2023 12:47:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memcg, oom: clean up mem_cgroup_oom_synchronize
Message-ID: <ZBRTV12GNtiSlOr3@dhcp22.suse.cz>
References: <20230315070302.268316-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315070302.268316-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-03-23 07:03:02, Haifeng Xu wrote:
> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to
> the charge path"), only oom_kill_disable is set, oom killer will
> be delayed to page fault path. In the charge patch, even if the
> oom_lock in memcg can't be acquired, the oom handing can also be
> invoked. In order to keep the behavior consistent with it, remove
> the lock check, just leave oom_kill_disable check behind in the
> page fault path.

I do not understand the actual problem you are trying to deal with here.

> Furthermore, the lock contender won't be scheduled out, this doesn't
> fit the sixth description in commit fb2a6fc56be66 ("mm: memcg:
> rework and document OOM waiting and wakeup"). So remove the explicit
> wakeup for the lock holder.
> 
> Fixes: fb2a6fc56be6 ("mm: memcg: rework and document OOM waiting and wakeup")

The subject mentions a clean up but the fixes tag would indicate an
acutal fix.

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/memcontrol.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..360fa7cf7879 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1999,7 +1999,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  	if (locked)
>  		mem_cgroup_oom_notify(memcg);
>  
> -	if (locked && !memcg->oom_kill_disable) {
> +	if (!memcg->oom_kill_disable) {
>  		mem_cgroup_unmark_under_oom(memcg);
>  		finish_wait(&memcg_oom_waitq, &owait.wait);
>  		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,

Now looking at the actual code I suspect you in fact want to simplify
the logic here as mem_cgroup_oom_synchronize is only ever triggered whe
oom_kill_disable == true because current->memcg_in_oom is never non NULL
otherwise. So the check is indeed unnecessary. Your patch, however
doesn't really simplify the code much. 

Did you want this instead?
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 12559c08d976..a77dc88cfa12 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1999,16 +1999,9 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	if (locked)
 		mem_cgroup_oom_notify(memcg);
 
-	if (locked && !READ_ONCE(memcg->oom_kill_disable)) {
-		mem_cgroup_unmark_under_oom(memcg);
-		finish_wait(&memcg_oom_waitq, &owait.wait);
-		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
-					 current->memcg_oom_order);
-	} else {
-		schedule();
-		mem_cgroup_unmark_under_oom(memcg);
-		finish_wait(&memcg_oom_waitq, &owait.wait);
-	}
+	schedule();
+	mem_cgroup_unmark_under_oom(memcg);
+	finish_wait(&memcg_oom_waitq, &owait.wait);
 
 	if (locked) {
 		mem_cgroup_oom_unlock(memcg);

> @@ -2010,15 +2010,8 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  		finish_wait(&memcg_oom_waitq, &owait.wait);
>  	}
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

Hmm, so this seems unneded as well for the oom_kill_disable case as
well. Rather than referring to fb2a6fc56be66 it would be better to
why the explicit recovery is not really needed anymore.

>  cleanup:
>  	current->memcg_in_oom = NULL;
>  	css_put(&memcg->css);

-- 
Michal Hocko
SUSE Labs
