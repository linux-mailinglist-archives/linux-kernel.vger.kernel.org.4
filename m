Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5474F894
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGKT6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGKT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:58:03 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140310D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:58:02 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-76571dae5feso584990485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689105481; x=1691697481;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQFgOAvocFb3uFicWRBty+nRGBWhrTx83zx8+lYf5UI=;
        b=Nh5OtOWjr8PIw1hoZfUfV9c8OaWytk2lPtda8FnHvJDUo2/KgMncyXCyn4UaLdghUL
         3gFW96jxTMm40+KBgrWARdzYMlEzK+6NlKXm0C0zRKB6Me890hm7oY1tbG9cv0sO4ykr
         +RlgkKUdKvqNd8KHatzFafattuE9Hg5KNLBa6uq77pDT+phuFDjYjPLv2eGN9YBZPZ0V
         hvbqFVtlKNCUkTSGDwhzAjGuoc0SQCh9HIIn8u7YPoj3/bqD/K8eNxtHDvMbtR2fEMAK
         RSM7AX2LWWi2gei0nnEmvgEjgVlEY4ZLhdTQIaZTZZEYQ4bYKyDt7fHeyBSoD6ocP7Lm
         VmHg==
X-Gm-Message-State: ABy/qLZjDpYeM7wFk6ks4kBkJMZlRzo2MMagW4Hf1x7JJfi9Q/x3qoud
        mDeA5LLBTR++7fmb3kbfYV4=
X-Google-Smtp-Source: APBJJlHEoNHVZnxZQkppyqBivT9NmqZati2D1iR4d54PXOGxZOlGpe4oIPpMtdc4+Hl+guk3/lTuTw==
X-Received: by 2002:a05:620a:4788:b0:765:a984:ac52 with SMTP id dt8-20020a05620a478800b00765a984ac52mr16048820qkb.9.1689105480946;
        Tue, 11 Jul 2023 12:58:00 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1d49])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a148e00b00767b4fa5d96sm1362791qkj.27.2023.07.11.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:58:00 -0700 (PDT)
Date:   Tue, 11 Jul 2023 14:57:57 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 6/7] sched: Shard per-LLC shared runqueues
Message-ID: <20230711195757.GD389526@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-7-void@manifault.com>
 <20230711104958.GG3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711104958.GG3062772@hirez.programming.kicks-ass.net>
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

On Tue, Jul 11, 2023 at 12:49:58PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 10, 2023 at 03:03:41PM -0500, David Vernet wrote:
> 
> > +struct shared_runq_shard {
> >  	struct list_head list;
> >  	spinlock_t lock;
> >  } ____cacheline_aligned;
> >  
> > +struct shared_runq {
> > +	u32 num_shards;
> > +	struct shared_runq_shard shards[];
> > +} ____cacheline_aligned;
> > +
> > +/* This would likely work better as a configurable knob via debugfs */
> > +#define SHARED_RUNQ_SHARD_SZ 6
> > +
> >  #ifdef CONFIG_SMP
> >  static struct shared_runq *rq_shared_runq(struct rq *rq)
> >  {
> >  	return rq->cfs.shared_runq;
> >  }
> >  
> > -static struct task_struct *shared_runq_pop_task(struct rq *rq)
> > +static struct shared_runq_shard *rq_shared_runq_shard(struct rq *rq)
> > +{
> > +	return rq->cfs.shard;
> > +}
> > +
> > +static int shared_runq_shard_idx(const struct shared_runq *runq, int cpu)
> > +{
> > +	return cpu % runq->num_shards;
> 
> I would suggest either:
> 
> 	(cpu >> 1) % num_shards
>
> or keeping num_shards even, to give SMT siblings a fighting chance to
> hit the same bucket.

Given that neither of these approaches guarantees that the SMT siblings
are in the same bucket, I'll just go with your suggestion which is
simpler.

Seems inevitable that we'll want to have another debugfs knob to adjust
the number of shards, but IMO it's preferable to just apply your
suggestion in v3 and hold off on adding that complexity until we know we
need it.

> (I've no idea how SMT4 (or worse SMT8) is typically enumerated, so
> someone from the Power/Sparc/MIPS world would have to go play with that
> if they so care)

Yeah, no idea either. If these things end up varying a lot across
different architectures then we can look into making shard assignment
architecture specific.

> 
> > +}
> 
> > +			num_shards = max(per_cpu(sd_llc_size, i) /
> > +					 SHARED_RUNQ_SHARD_SZ, 1);
> 
> > +			shared_runq->num_shards = num_shards;
> 
> 
