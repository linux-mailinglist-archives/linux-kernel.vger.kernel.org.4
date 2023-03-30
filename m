Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3DA6D040C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjC3Lyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjC3Lys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:54:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A979760
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:54:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 71FA11F37E;
        Thu, 30 Mar 2023 11:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680177268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTxuytMBR6QQoX8yIHFqLLHRnVYtbbdBFCds6FGzcxc=;
        b=PydK+RAOysv+l3mDhvE1oUFYSo2qb29bQoO3h/rz8OkZJF1DzCvLXOnzE5SAxVXfBikmXp
        5iFrd1VVG7cdiK6tpJaUdGQBwy7JJfDAOgDgaQkiNXqgdsy8u19t1hj1rurYOoiNXHmEqa
        c9MM13JpvlemEuJlI48xrz9DU42I5tE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 120182C14F;
        Thu, 30 Mar 2023 11:54:27 +0000 (UTC)
Date:   Thu, 30 Mar 2023 13:54:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: buffer write race: Re: [PATCH printk v1 09/18] printk: nobkl:
 Add print state functions
Message-ID: <ZCV4c+Sbywttsq/v@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-10-john.ogness@linutronix.de>
 <ZCRD7oOcTzOM5cXe@alley>
 <87edp7pqy5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edp7pqy5.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-03-29 16:39:54, John Ogness wrote:
> On 2023-03-29, Petr Mladek <pmladek@suse.com> wrote:
> >> +/**
> >> + * console_can_proceed - Check whether printing can proceed
> >> + * @wctxt:	The write context that was handed to the write function
> >> + *
> >> + * Returns:	True if the state is correct. False if a handover
> >> + *		has been requested or if the console was taken
> >> + *		over.
> >> + *
> >> + * Must be invoked after the record was dumped into the assigned record
> >> + * buffer
> >
> > The word "after" made me think about possible races when the record
> > buffer is being filled. The owner might loose the lock a hostile
> > way during this action. And we should prevent using the same buffer
> > when the other owner is still modifying the content.
> >
> > It should be safe when the same buffer might be used only by nested
> > contexts. It does not matter if the outer context finishes writing
> > later. The nested context should not need the buffer anymore.
> >
> > But a problem might happen when the same buffer is shared between
> > more non-nested contexts. One context might loose the lock a hostile way.
> > The other context might get the access after the hostile context
> > released the lock.
> 
> Hostile takeovers _only occur during panic_.
>
> > NORMAL and PANIC contexts are safe. These priorities have only
> > one context and both have their own buffers.
> >
> > A problem might be with EMERGENCY contexts. Each CPU might have
> > its own EMERGENCY context. We might prevent this problem if
> > we do not allow to acquire the lock in EMERGENCY (and NORMAL)
> > context when panic() is running or after the first hostile
> > takeover.
> 
> A hostile takeover means a CPU took ownership with PANIC priority. No
> CPU can steal ownership from the PANIC owner. Once the PANIC owner
> releases ownership, the panic message has been output to the atomic
> consoles. Do we really care what happens after that?

I see. The hostile take over is allowed only in
cons_atomic_exit(CONS_PRIO_PANIC, prev_prio) that is called at the
very end of panic() before the infinite blinking.

It is true that we do not care at this moment. It is actually called
after "suppress_printk = 1;" so that there should not be any
new messages.

Anyway, it would be nice to document this subtle race somewhere.
I could imagine that people would want to risk the hostile
takeover even earlier so the race might get introduced.

Best Regards,
Petr
