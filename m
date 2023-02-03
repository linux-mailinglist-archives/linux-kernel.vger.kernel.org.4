Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34D0689B40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBCOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjBCOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:12:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B422340F2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:10:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 74E495BD6F;
        Fri,  3 Feb 2023 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675433432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1tZaQaRF4SOg/Lz4IhDtc7UlmOkImhQ/MPCiygwEJw=;
        b=Wm2qvPtyRCDKDY3YQ5X2tjgYy3w0zi/8p1dnlFmSPqKlYkZrEc83miETbE680jJEHEJyKS
        LeHzyizgQNU3xCaw8pavVjrAYX5q1TG9OVaDErg1dCzCIzCMHsLb3Ib2WX2QPRmsxqItOE
        LjGn78XD2BzTWfM+o1WE6OhVlRse+0E=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4760D2C141;
        Fri,  3 Feb 2023 14:10:32 +0000 (UTC)
Date:   Fri, 3 Feb 2023 15:10:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/5] workqueue: Warn when a new worker could not be created
Message-ID: <Y90V1E9KP785ALMs@alley>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-3-pmladek@suse.com>
 <Y9xHnwG39IHN/BBu@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xHnwG39IHN/BBu@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-02-02 13:30:39, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 01, 2023 at 02:45:40PM +0100, Petr Mladek wrote:
> > +static __printf(2, 3) __cold
> > +void __print_create_worker_failure(long err, const char *fmt, ...)
> > +{
> > +	spin_lock_irq(&create_worker_failed_lock);
> > +
> > +	/*
> > +	 * Report potentially repeated failures only once during a stall.
> > +	 * Otherwise, it might be noisy. Also slow serial console drivers
> > +	 * touch watchdogs so that more frequent messages would prevent
> > +	 * reaching the watchdog thresh.
> > +	 */
> > +	if (!create_worker_failed) {
> > +		va_list args;
> > +
> > +		va_start(args, fmt);
> > +		vprintk(fmt, args);
> > +		va_end(args);
> > +	}
> > +
> > +	create_worker_failed++;
> > +
> > +	spin_unlock_irq(&create_worker_failed_lock);
> > +}
> 
> That's pretty elaborate.

Yeah, I am not super happy with it either.

> Why not just use printk_ratelimited()?

The default printk_ratelimited() is not usable because it uses:

     #define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
     #define DEFAULT_RATELIMIT_BURST		10

It allows 10 messages per 5 seconds. It would be still too noisy.
maybe_create_worker() tries to create a new worker every second.

And more importantly, it would break both softlockup and workqueue
watchdogs. See touch_nmi_watchdog() in serial8250_console_write().
By other words, it would break both softlockup and workqueue watchdogs.


A solution would be to use a custom printk_ratelimited_wq() that would
allow printing one message per 2 * wq_watchdog_thresh.
Something like:

#define printk_ratelimited_wq(fmt, ...)					\
({									\
	static DEFINE_RATELIMIT_STATE(_rs, 60 * HZ, 1);			\
									\
	if (__ratelimit(&_rs))						\
		printk(fmt, ##__VA_ARGS__);				\
})

I admit that it is much easier than __print_create_worker_failure().

The only problem might be that wq_watchdog_thresh might be modified
at runtime. But it can be solved by sharing the same
struct ratelimit_state rs in all printk_ratelimited_wq() calls
and updating it together with wq_watchdog_thresh.

Would you prefer the custom printk_ratelimited_wq(), please?

Best Regards,
Petr
