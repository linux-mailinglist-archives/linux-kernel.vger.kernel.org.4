Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF47468C3F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBFQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE3910A94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675702653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbI81WdBnirruIRWlS3/2ZRiepvfYoyUy2ovfA/3d2k=;
        b=U/nPt5rCgPqKI4bHYPE/vidRbXV7jiPuc0a3UL+rTuIZNPPujHEFRi5cdVWAxasa6mdE+E
        cG5iyz00lFPid3pAYskxKLV6PDorrFFSvVLXv6JahxMOuGCXSW/nOVGIG5u1QVhlu5lGNP
        1UQ7X2yFPeMHb/E0Zr0s8FfYpjx8C4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-KYQ5vO_yORWA_n0aXKGF6Q-1; Mon, 06 Feb 2023 11:57:23 -0500
X-MC-Unique: KYQ5vO_yORWA_n0aXKGF6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E84F587B2A1;
        Mon,  6 Feb 2023 16:57:22 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E459A2166B29;
        Mon,  6 Feb 2023 16:57:21 +0000 (UTC)
Date:   Mon, 6 Feb 2023 11:57:20 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pietro Borrello <borrello@diag.uniroma1.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: pick_next_rt_entity(): checked list_entry
Message-ID: <Y+ExcOoHOzSctvue@lorien.usersys.redhat.com>
References: <20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it>
 <20230206112342.223d2c29@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206112342.223d2c29@rorschach.local.home>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:23:42AM -0500 Steven Rostedt wrote:
> On Tue, 31 Jan 2023 13:01:16 +0000
> Pietro Borrello <borrello@diag.uniroma1.it> wrote:
> 
> > index ed2a47e4ddae..c024529d8416 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1777,6 +1777,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
> >  	BUG_ON(idx >= MAX_RT_PRIO);
> >  
> >  	queue = array->queue + idx;
> > +	SCHED_WARN_ON(list_empty(queue));
> 
> I wonder if we should make this:
> 
> 	if (SCHED_WARN_ON(list_empty(queue)))
> 		return NULL;
> 
> >  	next = list_entry(queue->next, struct sched_rt_entity, run_list);
> >  
> >  	return next;
> > @@ -1789,7 +1790,6 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
> >  
> >  	do {
> >  		rt_se = pick_next_rt_entity(rt_rq);
> > -		BUG_ON(!rt_se);
> 
> 		if (unlikely(!rt_se))
> 			return NULL;

I think that's better than taking a digger in one of the subsequent macros.


Cheers,
Phil


> 
> -- Steve
> 
> >  		rt_rq = group_rt_rq(rt_se);
> >  	} while (rt_rq);
> >  
>



-- 

