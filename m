Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131DB689B92
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjBCO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjBCO04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:26:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740C6278D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:26:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7CEAC34974;
        Fri,  3 Feb 2023 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675434400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ny7BJV83V4zsz+dLyia4fibVFzhFs8JK1s3+ud8cMA=;
        b=UjeO1HOASyF2qatthf8GvZj4ow/bz3raxu8AlbXInKVWcsbUzWaTg8MWK/IoCNizFNMd+M
        ZAvcJ9d/SKPqwGwP6USxutblTs3fMdJdRYC89ZtUg+ANuxZoXzUEetxFZTd/y+SbWxjwOx
        I0U7urRp1CdzONYjA6gVCF/m09frNQ0=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A1392C141;
        Fri,  3 Feb 2023 14:26:40 +0000 (UTC)
Date:   Fri, 3 Feb 2023 15:26:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] workqueue: Print backtraces from CPUs with hung CPU
 bound workqueues
Message-ID: <Y90ZnFNT+4XS2PlH@alley>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-6-pmladek@suse.com>
 <Y9xLAdc9ODyEO+RQ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xLAdc9ODyEO+RQ@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu 2023-02-02 13:45:05, Tejun Heo wrote:
> > +static bool show_pool_suspicious_workers(struct worker_pool *pool, bool shown_title)
> > +{
> > +	bool shown_any = false;
> > +	struct worker *worker;
> > +	unsigned long flags;
> > +	int bkt;
> > +
> > +	raw_spin_lock_irqsave(&pool->lock, flags);
> > +
> > +	if (pool->cpu < 0)
> > +		goto out;
> 
> This can be tested before grabbling the lock.

I see.

> > +	if (!per_cpu(wq_watchdog_hung_cpu, pool->cpu))
> > +		goto out;
> 
> Given that the state is per-pool, would it make sense to mark this on the
> pool instead?

Makes sense. I think that I started with the per-CPU variable before
I sorted my thoughts about what backtraces were useful ;-)

> > +	if (list_empty(&pool->worklist))
> > +		goto out;
> 
> This condition isn't really necessary, right?

IMHO, it should be there. The watchdog reports the problem only when
there  are pending work items, see

		if (list_empty(&pool->worklist))
			continue;

in wq_watchdog_timer_fn().

My understanding is that it is OK to process work items longer
time when they are sleeping and waiting for something.

Best Regards,
Petr
