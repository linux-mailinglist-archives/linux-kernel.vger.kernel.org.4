Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A366629816
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKOMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiKOMER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:04:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3084EFFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:03:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3F71A1F8B4;
        Tue, 15 Nov 2022 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668513809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=787wjDZOCndoyFt2mKQ1d7aZ2+xHAJpoA56kFzLmXlQ=;
        b=CuWLbwz0Vpx5g2oOolZBnnZRoeokXfHLDVaQNE5CxrwqZ38l4wS7rk7eXcU1uOr0vqG6+J
        li3t4UPue1pzCXRN2WL7+IoddwlEdCDKdS3tGwjHDgZuDwLlAtcWHW1y1EIyvbFT5fnQf2
        sYXPl2VPqt4Yhk0SmSM/aCuSMd6EtGw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E170F2C143;
        Tue, 15 Nov 2022 12:03:28 +0000 (UTC)
Date:   Tue, 15 Nov 2022 13:03:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v4 03/39] printk: Prepare for SRCU console list
 protection
Message-ID: <Y3OAEJW/z8k7LSJv@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-4-john.ogness@linutronix.de>
 <Y3Nu+Bd/SWsYn8Sp@alley>
 <875yfgo3k1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yfgo3k1.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-15 12:39:18, John Ogness wrote:
> On 2022-11-15, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2022-11-14 17:34:56, John Ogness wrote:
> >> Provide an NMI-safe SRCU protected variant to walk the console list.
> >> 
> >> Note that all console fields are now set before adding the console
> >> to the list to avoid the console becoming visible by SCRU readers
> >> before being fully initialized.
> >> 
> >> This is a preparatory change for a new console infrastructure which
> >> operates independent of the console BKL.
> >> 
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -3254,7 +3303,7 @@ int unregister_console(struct console *console)
> >>  		return -ENODEV;
> >>  	}
> >>  
> >> -	hlist_del_init(&console->node);
> >> +	hlist_del_init_rcu(&console->node);
> >
> > This should be hlist_del_rcu() here so that a list walker that it just
> > processing this console could see the rest of the list.
> 
> hlist_del_init_rcu() does not prevent the rest of the list from being
> seen. It only unlinks @pprev for future iterators.

I see. I looked at hlist_del_init() instead of on the _rcu() variant.
hlist_del_init_rcu() is correct here.


> > It seems that hlist_unhashed() checks only node.pprev pointer
> > so that we even do not need to initialize it.
> >
> > We discussed this in v3 in the patch implementing
> > console_force_preferred_locked(), see
> > https://lore.kernel.org/r/Y20aBwNWT19YDeib@alley.
> > I forgot that unregister_console() might have the same problem.
> 
> For console_force_preferred_locked() it was about making sure that the
> console always appears registered, even though it is temporarily removed
> from the console list.
> 
> For unregister_console() we want it to be seen as removed from the
> console list.

Makes sense.

Best Regards,
Petr
