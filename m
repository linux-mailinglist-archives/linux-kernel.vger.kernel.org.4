Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC5712B64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjEZRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjEZRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:08:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F33F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:08:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52867360efcso635772a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685120920; x=1687712920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L63EKoAxWjoTSIB5GLdcWFgTRYmWwICpoIuOH6jdy4w=;
        b=ULLHkgWDOcET9dqNzeiZjMLgZC5sr7XQER77zlEQfdKNtNGE/n2nG9nFFaMUhdO6jg
         X33f0Abx1x24sEE9qWaVujLzEA7ff1WlReyHXvfq7wgWzi4UlmregYmzbTy7ynIZhdqx
         /ilGuTIbyHMTj57cxDXxCsTIBBEe1LGU8TUR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120920; x=1687712920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L63EKoAxWjoTSIB5GLdcWFgTRYmWwICpoIuOH6jdy4w=;
        b=kAjqlCwBU+vXN8aMa6jbYqUw3Rvr1IaYUcZoEl3uNUs0Qs7tSnjynFPLiUzkTb75wB
         j/QUU4keibBRhuqpfJiI8JiblrmGkrKL1/Kk4RR4l7+7QDI1QaHOeNd0DDpw7Nnl8N11
         BbwiNXyCHmNuSMYjjdXbhGwlU1euT3JD4G3TFraBoqTseCl0BJ1gb+lfYkgjWXZY4RTw
         Mlt8NIP1gf+oi1XsaniQ7+JTxJw8dJF7bSsgV49sxHgkZA57mzQAUTn5NKrnYol5GpMd
         cP6syYprAj2EJ6p7+slKZVYfigMoB2mCri9SuR2nkcC6+y8a4Rlpki6FGVqJ7RSmaktv
         UbjQ==
X-Gm-Message-State: AC+VfDyBzLs6ZQaEOAHkZFv8hxGc3mtPa/AatJBdB1gqWdVoQcB7OHJF
        2h4yfT7+5wICMSXZAW/4BNjf+A==
X-Google-Smtp-Source: ACHHUZ63PKUp1aUysefPnUXc2g7FZO4vmhQkFDfovcfHvrklG1yM2pHtVu0nAmwDcs3ye1B/Pw+0xQ==
X-Received: by 2002:a17:902:d483:b0:1b0:12e:3bfd with SMTP id c3-20020a170902d48300b001b0012e3bfdmr4003433plg.7.1685120919960;
        Fri, 26 May 2023 10:08:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm3485454plr.172.2023.05.26.10.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:08:39 -0700 (PDT)
Date:   Fri, 26 May 2023 10:08:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/2] sched: Use fancy new guards
Message-ID: <202305261006.01B34DB4C@keescook>
References: <20230526150549.250372621@infradead.org>
 <20230526151947.027972233@infradead.org>
 <2023052626-blunderer-delegator-4b82@gregkh>
 <d806769b-c568-fa7c-f7aa-ded9ffea11b4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d806769b-c568-fa7c-f7aa-ded9ffea11b4@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:27:51PM -0400, Mathieu Desnoyers wrote:
> On 5/26/23 12:25, Greg KH wrote:
> > On Fri, May 26, 2023 at 05:05:51PM +0200, Peter Zijlstra wrote:
> > > Convert kernel/sched/core.c to use the fancy new guards to simplify
> > > the error paths.
> > 
> > That's slightly crazy...
> > 
> > I like the idea, but is this really correct:
> > 
> > 
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >   kernel/sched/core.c  | 1223 +++++++++++++++++++++++----------------------------
> > >   kernel/sched/sched.h |   39 +
> > >   2 files changed, 595 insertions(+), 667 deletions(-)
> > > 
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1097,24 +1097,21 @@ int get_nohz_timer_target(void)
> > >   	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
> > > -	rcu_read_lock();
> > > -	for_each_domain(cpu, sd) {
> > > -		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> > > -			if (cpu == i)
> > > -				continue;
> > > +	void_scope(rcu) {
> > > +		for_each_domain(cpu, sd) {
> > > +			for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> > > +				if (cpu == i)
> > > +					continue;
> > > -			if (!idle_cpu(i)) {
> > > -				cpu = i;
> > > -				goto unlock;
> > > +				if (!idle_cpu(i))
> > > +					return i;
> > 
> > You can call return from within a "scope" and it will clean up properly?
> > 
> > I tried to read the cpp "mess" but couldn't figure out how to validate
> > this at all, have a set of tests for this somewhere?
> > 
> > Anyway, the naming is whack, but I don't have a proposed better name,
> > except you might want to put "scope_" as the prefix not the suffix, but
> > then that might look odd to, so who knows.
> 
> FWIW C++ has std::scoped_lock. So perhaps using a similar wording may help ?

Yeah, I like "scoped_*" and "guarded_*" for naming. IMO, it reads better.

-- 
Kees Cook
