Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1A6EE657
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjDYRHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjDYRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:07:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B0773A9E;
        Tue, 25 Apr 2023 10:07:00 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id BE5CF21C2B28;
        Tue, 25 Apr 2023 10:06:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE5CF21C2B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682442419;
        bh=gm/PMTFaYLlIr+m7FSXI+UiVoqIRgvxEf7MjPoLA8zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsCHMBeINdrE6QJzfwfnxvsESp5X+H8MFVGv454UbJI+ySq6TAyg4JNVwd3j0D85D
         nzPi+1DDySvGT5YaL/ecENQ1ZvhTZ3lX8OoVO1VL87Kyyq3619PQ77Hdu5WKSl1nJo
         vGQR0Ln/ZNdbu4Y/ZEJ1x+d64vCbnxbIsXkTZJV4=
Date:   Tue, 25 Apr 2023 10:06:54 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/user_events: Ensure bit is cleared on
 unregister
Message-ID: <20230425170654.GA74@W11-BEAU-MD.localdomain>
References: <20230411211709.15018-1-beaub@linux.microsoft.com>
 <20230411211709.15018-3-beaub@linux.microsoft.com>
 <20230424213957.55c503c1@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424213957.55c503c1@rorschach.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:39:57PM -0400, Steven Rostedt wrote:
> On Tue, 11 Apr 2023 14:17:08 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > +static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
> > +				   unsigned long uaddr, unsigned char bit)
> > +{
> > +	struct user_event_enabler enabler;
> > +	int result;
> > +
> > +	memset(&enabler, 0, sizeof(enabler));
> > +	enabler.addr = uaddr;
> > +	enabler.values = bit;
> > +retry:
> > +	/* Prevents state changes from racing with new enablers */
> > +	mutex_lock(&event_mutex);
> > +
> > +	/* Force the bit to be cleared, since no event is attached */
> > +	mmap_read_lock(user_mm->mm);
> > +	result = user_event_enabler_write(user_mm, &enabler, false);
> > +	mmap_read_unlock(user_mm->mm);
> > +
> > +	mutex_unlock(&event_mutex);
> > +
> > +	if (result) {
> > +		/* Attempt to fault-in and retry if it worked */
> > +		if (!user_event_mm_fault_in(user_mm, uaddr))
> > +			goto retry;
> 
> Without looking into the functions of this call, I wonder if this can
> get into an infinite loop?
> 

That's a good point, user_event_mm_fault() is a wrapper around
fixup_user_fault(). We retry if it works, so I guess if the user could
somehow cause a fail on the write and succeed to page in repeatedly, it
could keep the loop going for that time period. I cannot think of a way
to achieve this forever, but that doesn't mean it couldn't happen.

I can certainly add an upper bound of retries (maybe 3 or so?) if you
think it would be possible for this to occur. I think we need retries of
some amount to handle spurious faults.

Thanks,
-Beau

> -- Steve
> 
> 
> > +	}
> > +
> > +	return result;
> > +}
> > +
