Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E4060CA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiJYKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:49:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCDBB6A;
        Tue, 25 Oct 2022 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mzKf4zO+aOND3THi9Mu4VLFu+cDOF5LRRU7uDWVved8=; b=drAwqS4LP96zpDpHwpq6MvvMJS
        oOTRW1UAGrBCGBEMp6DVBnhjWagPeCZZheSoI2DkIlACY/RTvB5Zir3QnK0z1kY90/WamBX8qPZY9
        YG/GkldNcOnAZwsGfT7LLcA0dJ8TTauzyiYGFiZuAgfysMVz1BaBVhX4n6mK3xQ9T5XyzSkRi33Wf
        BpEvK/RbO6MVc993r74jWuRyXSzg7FNx85l+uO3M7J6yvC/+ionBv/MtYZmY0nDfiXy+tX7sIALe9
        3eRtjO4N//w2SWmnv2imoBiJzCsJflmaA3DTd6iVXu4UO+yR9BE1nS489Kb9lva2nxJ63cpjphGfF
        FBnihckg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onHUl-00GC5g-Nh; Tue, 25 Oct 2022 10:49:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E39A30008D;
        Tue, 25 Oct 2022 12:49:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EB092C431FB4; Tue, 25 Oct 2022 12:49:13 +0200 (CEST)
Date:   Tue, 25 Oct 2022 12:49:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1drd2gzxUJWdz5F@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:52:07AM +0300, Ville Syrjälä wrote:
> On Fri, Oct 21, 2022 at 08:22:41PM +0300, Ville Syrjälä wrote:
> > On Mon, Aug 22, 2022 at 01:18:22PM +0200, Peter Zijlstra wrote:
> > > +#ifdef CONFIG_LOCKDEP
> > > +	/*
> > > +	 * It's dangerous to freeze with locks held; there be dragons there.
> > > +	 */
> > > +	if (!(state & __TASK_FREEZABLE_UNSAFE))
> > > +		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > > +#endif
> > 
> > We now seem to be hitting this sporadically in the intel gfx CI.
> > 
> > I've spotted it on two machines so far:
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12270/shard-tglb7/igt@gem_ctx_isolation@preservation-s3@vcs0.html
> > https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_109950v1/shard-snb5/igt@kms_flip@flip-vs-suspend-interruptible@a-vga1.html
> 
> Sadly no luck in reproducing this locally so far. In the meantime
> I added the following patch into our topic/core-for-CI branch in
> the hopes of CI stumbling on it again and dumping a bit more data:
> 
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -125,8 +125,16 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
>  	/*
>  	 * It's dangerous to freeze with locks held; there be dragons there.
>  	 */
> -	if (!(state & __TASK_FREEZABLE_UNSAFE))
> -		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> +	if (!(state & __TASK_FREEZABLE_UNSAFE)) {
> +		static bool warned = false;
> +
> +		if (!warned && debug_locks && p->lockdep_depth) {
> +			debug_show_held_locks(p);
> +			WARN(1, "%s/%d holding locks while freezing\n",
> +			     p->comm, task_pid_nr(p));
> +			warned = true;
> +		}
> +	}
>  #endif
>  
>  	WRITE_ONCE(p->__state, TASK_FROZEN);

That seems reasonable. But note that this constraint isn't new; the
previous freezer had much the same constraint but perhaps it wasn't
triggered for mysterious raisins. see the previous
try_to_freeze_unsafe() function.
