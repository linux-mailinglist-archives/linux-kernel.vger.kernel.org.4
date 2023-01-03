Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350FD65C1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjACORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjACOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:16:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF23120BF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:16:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AC0153EA98;
        Tue,  3 Jan 2023 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672755387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8oq+XhQ+3+x7Vpym61jDcEqm3Tvv2/Ah6NareozzB0=;
        b=l8FjXtN8zdh0U4meV9iZO62MyXEqmKTWP7Q/m4r6dcTsBw67WgZxLxxwqJdnq8R7O1ac9J
        svGmsNYXfEcWXVb5VHooaapMnlHXsp+a+dehl143P+plwid0/zPp0FE+OU24iIF1J8TwiC
        tLKC3ELw211EDTJKmcmRNqsg4h2VDTU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9185F2C141;
        Tue,  3 Jan 2023 14:16:27 +0000 (UTC)
Date:   Tue, 3 Jan 2023 15:16:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7Q4u9ICptw0RnXb@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley>
 <87y1qjdimw.fsf@jogness.linutronix.de>
 <Y7QtusGlIX3AU+TN@alley>
 <87o7rfd96w.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7rfd96w.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-03 14:50:23, John Ogness wrote:
> On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> > Well, what about making sure that something more useful is always
> > printed. For example:
> >
> > 	/*
> > 	 * Make sure outbuf is sufficiently large before prepending.
> > 	 * Keep at least the prefix when the message has to be truncated.
> > 	 * It is a rather theoretical problem when someone tries to
> > 	 * use a minimalist buffer.
> > 	 */
> > 	if (WARN_ON_ONCE(len + PREFIX_MAX + 1 >= outbuf_sz))
> > 		return;
> 
> I am fine with this. We won't see this warning anyway. Few lines would
> ever be printed correctly if anyone ever tries to use a buffer so small.

Yup.

> > If we want to use this way. It would probably make sense to
> > rename PREFIX_MAX to CONSOLE_PREFIX_MAX.
> 
> Actually, I would like to rename all of those limit macros to something
> that makes more sense for the new code base:
> 
> CONSOLE_EXT_LOG_MAX -> CONSOLE_MESSAGE_MAX
> 
> CONSOLE_LOG_MAX     -> SYSLOG_MESSAGE_MAX

Heh, we actually do not need this. The size of @scratchbuf
might be LOG_LINE_MAX/PRINTK_RECORD_MAX. The scratch buffer
is newly used only to read the plain message. The prefixes
are added to @outbuf.

> LOG_LINE_MAX        -> PRINTK_RECORD_MAX
> 
> PREFIX_MAX          -> CONSOLE_PREFIX_MAX

I like this.

> I have a patch to do this ready, but I did not want to post it until we
> are finished with the thread/atomic work.

It would make sense to do this as part of this patchset. But I do not
want to delay it too much. Feel free to do it later.

Best Regards,
Petr
