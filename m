Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEF66DC36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjAQLUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjAQLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:20:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3CE33459;
        Tue, 17 Jan 2023 03:20:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 680FB5CB40;
        Tue, 17 Jan 2023 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673954423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPjwrcXmuFGkQbX3taDI9ie1BtTBZf9HP9xMBmIbYHg=;
        b=QejvsoIMCwUtGFOfkF1T35ph+Pp2eQzJX1oyMUJutWnO+tPAsvBOMrdBi4xcU66AK82Jpj
        L2h504x44J6hR1jOtzYRPKj26VV/Z3xpKB/V7Q47FF2SHxkwSJy6QMHUelno/9wipM6ruN
        1sBKFQPCcoYXQYsvjBy5+L5MRMJOt34=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D90852C141;
        Tue, 17 Jan 2023 11:20:22 +0000 (UTC)
Date:   Tue, 17 Jan 2023 12:20:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        coverity-bot <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <Y8aEdDxQrQICQtem@alley>
References: <202301131544.D9E804CCD@keescook>
 <Y8KAhaiZQOWTcfyF@google.com>
 <Y8V8tqMJeB7t+rcJ@alley>
 <Y8YRBo7ZmtzWT4J1@google.com>
 <877cxl3abr.fsf@jogness.linutronix.de>
 <Y8ZTlVX3HQUVkU13@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZTlVX3HQUVkU13@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-17 16:51:49, Sergey Senozhatsky wrote:
> On (23/01/17 08:16), John Ogness wrote:
> > On 2023-01-17, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > > On (23/01/16 17:35), Petr Mladek wrote:
> > >> 	len = snprintf(scratchbuf, scratchbuf_sz,
> > >> 		       "** %lu printk messages dropped **\n", dropped);
> > >
> > > Wouldn't
> > >
> > > 	if (WARN_ON_ONCE(len + PRINTK_PREFIX_MAX >= outbuf_sz))
> > > 		return;
> > >
> > > prevent us from doing something harmful?

The problem is that it compares outbuf_sz that is bigger than
scratchbuf.

The above check should prevent crash in:

	memmove(outbuf + len, outbuf, pmsg->outbuf_len + 1);

But it would not prevent out-of-bound access to scratchbuf in:

	memcpy(outbuf, scratchbuf, len);


That said, the coverity report is pretty confusing. It is below
the memmove() so that it looks like the memmove() is dangerous.
But it talks about "scratchbuf" so that it probably describes
the real problem in "memcpy()".


> > Sure. But @0len is supposed to contain the number of bytes in
> > @scratchbuf, which theoretically it does not. snprintf() is the wrong
> > function to use here, even if there is not real danger in this
> > situation.
> 
> Oh, yes, I agree that snprintf() should be replaced. Maybe we can go
> even a bit furhter and replace all snprintf()-s in kernel/printk/*
> (well, in a similar fashion, just in case). I'm just trying to understand
> what type of assumptions does coverity make here and so far everything
> looks rather peculiar.

Note that we sometimes need snprintf() to compute the needed size
of the buffer. For example, vsnprintf() in vprintk_store() is
correct.

It looks to me that snprintf() in console_prepend_dropped() is the
only real problem.

Well, it would be nice to replace the few sprintf() calls. They look safe
because the size of the output is limited by the printf format but...

Best Regards,
Petr
