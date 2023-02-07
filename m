Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC48C68D6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBGMam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjBGMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6234BBAE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675772990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9M0jX2xmB8vWyJGMgAXVnZDFC1rrsIact0NlypICcc=;
        b=Z7nJoUw2QnPaJc67DYEytjaZORB7GRVKzZr6tYlnMeWD737kkNdLeMPZFUHG3g17aZ28IW
        0o1U8+AlnPvKzYsbAf8IaXAwWQPzRFqO5IgbEstOneHRWuigSbxmW02ll6zk9H8B7vfIId
        Br9B96F4eD8wwOS3Ot0wDtvRJxExdik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-2ckzrFroPVWB2pK1wr6YiA-1; Tue, 07 Feb 2023 07:29:46 -0500
X-MC-Unique: 2ckzrFroPVWB2pK1wr6YiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D5E385A5A3;
        Tue,  7 Feb 2023 12:29:46 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FD19C16516;
        Tue,  7 Feb 2023 12:29:45 +0000 (UTC)
Date:   Tue, 7 Feb 2023 07:29:43 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: pick_next_rt_entity(): check list_entry
Message-ID: <Y+JEN3/iEPEn6JZq@lorien.usersys.redhat.com>
References: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pietro,

On Mon, Feb 06, 2023 at 10:33:54PM +0000 Pietro Borrello wrote:
> Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
> removed any path which could make pick_next_rt_entity() return NULL.
> However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
> pick_next_rt_entity()) still checks the error condition, which can
> never happen, since list_entry() never returns NULL.
> Remove the BUG_ON check, and instead emit a warning in the only
> possible error condition here: the queue being empty which should
> never happen.
> 
> Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
> Changes in v3:
> - return NULL if the list is empty
> - Link to v2: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it
> 
> Changes in v2:
> - pick_next_rt_entity(): emit warning instead of crashing
> - Link to v1: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it
> ---
>  kernel/sched/rt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ed2a47e4ddae..0a11f44adee5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1777,6 +1777,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
>  	BUG_ON(idx >= MAX_RT_PRIO);
>  
>  	queue = array->queue + idx;
> +	if (SCHED_WARN_ON(list_empty(queue)))
> +		return NULL;
>  	next = list_entry(queue->next, struct sched_rt_entity, run_list);
>  
>  	return next;
> @@ -1789,7 +1791,8 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
>  
>  	do {
>  		rt_se = pick_next_rt_entity(rt_rq);
> -		BUG_ON(!rt_se);
> +		if (unlikely(!rt_se))
> +			return NULL;
>  		rt_rq = group_rt_rq(rt_se);
>  	} while (rt_rq);
>  
> 
> ---
> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> change-id: 20230128-list-entry-null-check-sched-a3f3dfd6d468
> 
> Best regards,
> -- 
> Pietro Borrello <borrello@diag.uniroma1.it>
> 


Reviewed-by: Phil Auld <pauld@redhat.com>

Thanks. I think this will be useful.


Cheers,
Phil


-- 

