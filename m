Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAF7240A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjFFLOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjFFLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:14:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF89E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wXNFm40ScDPy3oViI3mzPEh9rSr7y3hl/rRDYk32YTk=; b=Ole+pTNSmNUJMgsNHw1RTBVr65
        2EAZeE6iD0xqPTW57YcveLJhp8KNZmYL17d+5Y6BlYiggLE2rMRKkc5H3kNN8tTLDC63CB9J40nD1
        hXBdO/MdodXMine00KKeNi/pCajd61c723VDLeYNxRhu4JYW8yLrA+c+bo9KGZNAaCnbIjsb+0OZq
        V3u5b8/FGBhnruJCjX/y0nZLHDbGzjKcpqtCnrlV0fYKBB/ZpxCU/s5b3u8/8x4KmMSJFeHWDwN0P
        rz3lT9uiHlCoMTUcZcG0NMI/EYPpINumUMtO4ENfynOhjnOdBiT5NWw/FWuraLTBpup2T1myCzFbg
        MSZ/FIeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Udo-00D4x2-28; Tue, 06 Jun 2023 11:14:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A4BD300188;
        Tue,  6 Jun 2023 13:14:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A5F824321B19; Tue,  6 Jun 2023 13:14:18 +0200 (CEST)
Date:   Tue, 6 Jun 2023 13:14:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST 2/2] signal: Don't disable preemption in
 ptrace_stop() on PREEMPT_RT.
Message-ID: <20230606111418.GA906324@hirez.programming.kicks-ass.net>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
 <20230606085524.2049961-3-bigeasy@linutronix.de>
 <20230606110447.GA7542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606110447.GA7542@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:04:48PM +0200, Oleg Nesterov wrote:
> The patch LGTM, but I am a bit confused by the changelog/comments,
> I guess I missed something...
> 
> On 06/06, Sebastian Andrzej Siewior wrote:
> >
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2328,11 +2328,16 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
> >  	 * The preempt-disable section ensures that there will be no preemption
> >  	 * between unlock and schedule() and so improving the performance since
> >  	 * the ptracer has no reason to sleep.
> > +	 *
> > +	 * This optimisation is not doable on PREEMPT_RT due to the spinlock_t
> > +	 * within the preempt-disable section.
> >  	 */
> > -	preempt_disable();
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		preempt_disable();
> 
> Not only we the problems with cgroup_enter_frozen(), afaics (please correct me)
> this optimisation doesn't work on RT anyway?
> 
> IIUC, read_lock() on RT disables migration but not preemption, so it is simply
> too late to do preempt_disable() before unlock/schedule. The tracer can preempt
> the tracee right after do_notify_parent_cldstop().

Correct -- but I think you can disable preemption over what is
effectivly rwsem_up_read(), but you can't over the effective
rtmutex_lock() that cgroup_enter_frozen() will then attempt.

(iow, unlock() doesn't tend to sleep, while lock() does)

But you're correct to point out that the whole preempt_disable() thing
is entirely pointless due to the whole task_lock region being
preemptible before it.
