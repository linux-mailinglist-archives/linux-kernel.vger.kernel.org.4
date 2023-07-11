Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86474F4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjGKQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjGKQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:20:08 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3453B8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:19:30 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-763a2e39b88so589587585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092370; x=1691684370;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywQ2j8L4AJMQA4P82Cjvo7hxI/Fw5jSDYjwiGIchlFE=;
        b=Oq8Cca2GgRr6YtiG5i+ETG9mUlZGvL9I8y/KKlQa2Z+B8crawegXTePCAu93hduSSe
         0NmrvqSSs4WwNW1K72csltAw/D3KaTLiueWw7QBJtmE3FqXwXbW/6l9tkByAPNP+lbVc
         RDXQDPQZDrh8u8gpkbJgWypBFcur5pdyVlNXcOCGX71tER96dUODPPWLJBcozz6UiOU+
         TKMuyGk24od0derWhtTe8Dbwpzt+54HQCcng7PyexLNnZi5EArD8YToaBKWHCtnzHjp0
         8y47b+wrArdzf0KsfMUyloJYMe4LnQyIEKT0QB9PO+31yRYyzPvfJvtSALiV4WKturdA
         BMSg==
X-Gm-Message-State: ABy/qLYNRfjVZm/LwB7U8e0tvsVdNh611miOYVXQKnWwdKnWkS9MXsoS
        d6bDR7Lu0BwJl6yGzlUIxfw=
X-Google-Smtp-Source: APBJJlHdMkQ61eAz9qw63IdnhsjxmUHXz2SsS1lBkyvD7sGZCtZessaZW/HQAp0UfjQPMVXpVzo0+Q==
X-Received: by 2002:ac8:5f13:0:b0:403:b395:b450 with SMTP id x19-20020ac85f13000000b00403b395b450mr5190305qta.2.1689092369563;
        Tue, 11 Jul 2023 09:19:29 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1d49])
        by smtp.gmail.com with ESMTPSA id b15-20020ac801cf000000b004037cd9bd40sm1249901qtg.15.2023.07.11.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:19:29 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:19:26 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 4/7] sched/fair: Add SHARED_RUNQ sched feature and
 skeleton calls
Message-ID: <20230711161926.GA389526@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-5-void@manifault.com>
 <20230711094547.GE3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711094547.GE3062772@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:45:47AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 10, 2023 at 03:03:39PM -0500, David Vernet wrote:
> 
> > @@ -11843,6 +11871,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >  	if (!cpu_active(this_cpu))
> >  		return 0;
> >  
> > +	if (sched_feat(SHARED_RUNQ) && shared_runq_pick_next_task(this_rq, rf))
> > +		return -1;
> > +
> 
> Next patch implements shared_runq_pick_next_task() with the same return
> values as newidle_balance(), which would seem to suggest the following
> instead:
> 
> 	if (sched_feat(SHARED_RUNQ)) {
> 		pulled_task = shared_runq_pick_next_task(this_rq, rf);
> 		if (pulled_task)
> 			return pulled_task;
> 	}

Yep, that's cleaner.

> Additionally, I think we wants something like:
> 
> 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> 	if (sched_feat(SHARED_RUNQ)) {
> 		... /* see above */
> 
> 		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> 		sd = sd->parent;
> 	}
> 
> to ensure we skip <=LLC domains, since those have already been covered
> by this shiny new thing, no?

Indeed, another nice optimization. I'll incorporate both of these into
the next version.
