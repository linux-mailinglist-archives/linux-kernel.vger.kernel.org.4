Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034874DFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGJVFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGJVFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2DA8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689023067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JurnhLHH9YQFXyYfM7Lu+OdaASAwBLZOqLUwNesFXOA=;
        b=Kt/juClkCnyht1j52qs5XN0CjcfZLAHh2GAb1emb3lunAy41Tem/gtMj3rbCZ4/dZ2T5wh
        fa0MJhgHijKizPBg4XJsAoHdE/6hkvXuq0rPsJoXLSzV7E/UTjYcsJGKjTGTIwBNuw+kLR
        iPDXMdLoQ7T457HQNNtQjHo9HuR0C7A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-lqcSTs8NMmiwbnZUgdYJMg-1; Mon, 10 Jul 2023 17:04:24 -0400
X-MC-Unique: lqcSTs8NMmiwbnZUgdYJMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80FB71C17103;
        Mon, 10 Jul 2023 21:04:23 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0DFF492C13;
        Mon, 10 Jul 2023 21:04:22 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:04:21 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
Message-ID: <20230710210421.GA146093@lorien.usersys.redhat.com>
References: <20230707195748.2918490-1-pauld@redhat.com>
 <20230707195748.2918490-2-pauld@redhat.com>
 <ZKxnRIZQzyVDMZGD@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKxnRIZQzyVDMZGD@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:17:08AM -1000 Tejun Heo wrote:
> Hello,
> 
> On Fri, Jul 07, 2023 at 03:57:47PM -0400, Phil Auld wrote:
> > @@ -11038,11 +11038,14 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
> >  
> >  		/*
> >  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> > -		 * always take the min.  On cgroup1, only inherit when no
> > -		 * limit is set:
> > +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> > +		 * inherit when no limit is set:
> >  		 */
> >  		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> > -			quota = min(quota, parent_quota);
> > +			if (quota == RUNTIME_INF)
> > +				quota = parent_quota;
> > +			else if (parent_quota != RUNTIME_INF)
> > +				quota = min(quota, parent_quota);
> 
> Can you please add a comment explaining how hierarchical_quota is used in
> cgroup2? It seems like you're using it to detect whether bw limit is
> enforced for a given cgroup, which is fine, but the above code in isolation
> looks a bit curious because it doesn't serve any purpose by itself.

Sure, I can do that.



Cheers,
Phil

> 
> Thanks.
> 
> -- 
> tejun
> 

-- 

