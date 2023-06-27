Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A173F9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjF0KQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjF0KPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:15:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7D2940
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s6GXufJOcmhUIu39CJQudXyNhyKZE2ynukFPV1BS9p8=; b=jYpnzlDHh8VOYWx6PS4u+52l3o
        naaCN+ToskjujelRjkhm15ELm31TiYNAvmKii2jB9fwUYDe1wUkgVHlg2zsULuDk/+d8Vy9LoUzpO
        nDMti40pMttOHm1Ijyce/sAhV/DUuNyFM6ps2capNhyAJzWONa1Ni0q9hTbm4DTvZE3DVGKz45Vcr
        tObvkASYKgA84rlO+yOTnR5/Ca47N1AyqLYyVzaJHUy745Ej6oj1Bg9kzdahEOdkHKN3etL9ElJpn
        B73l0KlL75DNbwe4t9JEvNuQxWc5/0s9P4icoP2yRglT1jtFAzpk/JVvCSiqDgLurbKqvkL4Oh9mv
        31ySIh6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE5iY-002c0C-6x; Tue, 27 Jun 2023 10:14:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 709D1300095;
        Tue, 27 Jun 2023 12:14:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 515FA2435114E; Tue, 27 Jun 2023 12:14:37 +0200 (CEST)
Date:   Tue, 27 Jun 2023 12:14:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Deng Pan <pan.deng@intel.com>, tim.c.chen@intel.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        tianyou.li@intel.com, yu.ma@intel.com, lipeng.zhu@intel.com,
        yu.c.chen@intel.com, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <20230627101437.GY4253@hirez.programming.kicks-ass.net>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626054756.GA435374@ziqianlu-dell>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:47:56PM +0800, Aaron Lu wrote:

> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ec7b3e0a2b20..4fbd4b3a4bdd 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -389,6 +389,19 @@ struct task_group {
> >  #endif
> >  #endif
> >  
> > +	struct rcu_head		rcu;
> > +	struct list_head	list;
> > +
> > +	struct list_head	siblings;
> > +	struct list_head	children;
> > +
> > +	/*
> > +	 * To reduce false sharing, current layout is optimized to make
> > +	 * sure load_avg is in a different cacheline from parent, rt_se
> > +	 * and rt_rq.
> > +	 */

That comment is misleading I think; you don't particularly care about
those fields more than any other active fields that would cause false
sharing.

> > +	struct task_group	*parent;
> > +
> 
> I wonder if we can simply do:
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..31b73e8d9568 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -385,7 +385,9 @@ struct task_group {
>  	 * it in its own cacheline separated from the fields above which
>  	 * will also be accessed at each tick.
>  	 */
> -	atomic_long_t		load_avg ____cacheline_aligned;
> +	struct {
> +		atomic_long_t		load_avg;
> +	} ____cacheline_aligned_in_smp;
>  #endif
>  #endif
> 
> This way it can make sure there is no false sharing with load_avg no
> matter how the layout of this structure changes in the future.

This. Also, ISTR there was a series to split this atomic across nodes;
whatever happend to that, and can we still measure an improvement over
this with that approach?
