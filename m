Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2565FE26
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjAFJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjAFJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:40:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6009269B02
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:34:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CD9124754;
        Fri,  6 Jan 2023 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672997690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvxAIOvk1kYa+qwv6hW6ltwjTsDNYL4aFxzW4AWlEbw=;
        b=Iw2w0nHz/QJ1sffHgt3kKFBEGmzOSZSDZFHhNzZamPGGRWgASHl+3AF8hY5sKiDMfh2M3s
        vCbpasPFfc549i3oISvdkXWfo3H4/5utaBQe0AMU1UrvD2hHDf/2XJ9llL/Lsu0MaPU/mp
        XKMf7omVL2JygP12ZokeQbPes/rIjDs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4995F2C143;
        Fri,  6 Jan 2023 09:34:50 +0000 (UTC)
Date:   Fri, 6 Jan 2023 10:34:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 6/8] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7frNwBA06hMivMl@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-7-john.ogness@linutronix.de>
 <Y7b4AND0DRs7jPW9@alley>
 <87y1qhaqhc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1qhaqhc.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 17:41:59, John Ogness wrote:
> On 2023-01-05, Petr Mladek <pmladek@suse.com> wrote:
> >> +	if (WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
> >> +		return;
> >
> > I guess that this will always trigger the compiler warning
> > when CONFIG_PRINTK is disabled. See the report for v3 at
> > https://lore.kernel.org/r/202301052114.vvN3wQoH-lkp@intel.com
> 
> That report is actually complaining about the check after this one. It
> is the same "problem".

I see.

> > Hmm, we might want to fix this warning so that it does not break
> > build with -Werror.
> >
> > IMHO, the proper solution would be to define this function only when
> > CONFIG_PRINTK is defined. But it might require bigger changes
> > and define many more console functions only when CONFIG_PRINTK
> > is defined. This is out-of-scope of this patchset.
> >
> > I wonder if the following would work as an "intermediate" workaround:
> >
> > 	if (!IS_ENABLED(CONFIG_PRINTK) ||
> > 	    WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
> > 		return;
> 
> The whole CONFIG_PRINTK stuff is a total mess right now. We should
> definitely get that cleaned up at some point. As an intermediate
> workaround, it might make more sense to just put the whole function
> inside an "#ifdef CONFIG_PRINTK". It doesn't return anything anyway.
> 
> #ifdef CONFIG_PRINTK
> static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
> {
> ...
> }
> #else
> #define console_prepend_dropped(pmsg, dropped)
> #endif

Looks good.

The question is if we want to do it in this patch or as a follow up
fix.

I slightly prefer to do it as a follow up fix to avoid another respin.
Also we will not need to complicate this patch with explaining
why this is needed.

Best Regards,
Petr
