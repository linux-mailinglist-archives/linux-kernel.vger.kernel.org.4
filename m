Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28251624855
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiKJR1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiKJR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:26:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E173F18E37;
        Thu, 10 Nov 2022 09:26:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FD55228D3;
        Thu, 10 Nov 2022 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668101209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nzyi44WKO3p/rhzOL3lGsqVjLxzcpLoKQVlmwsHqaY4=;
        b=VIifZ/vuAtq6adyPtfIzER7lD6dcovCYFn2LPl2N7liyeJ2smk+e619717bVZOVG2cCs4L
        4NW34hAc5nZGPOp/hx+KHmTKMgvXYz+r6z8waJ7yaz+ZDQCc5GlM2IINXZtTuek5vPZ+hB
        8h++xOtr6IViY8n5P15stCuy6lMKTek=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3D2E22C141;
        Thu, 10 Nov 2022 17:26:49 +0000 (UTC)
Date:   Thu, 10 Nov 2022 18:26:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v3 33/40] printk, xen: fbfront: create/use safe
 function for forcing preferred
Message-ID: <Y200WG6q4z0JGYBc@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-34-john.ogness@linutronix.de>
 <Y20aBwNWT19YDeib@alley>
 <877d026blr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d026blr.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-10 17:09:12, John Ogness wrote:
> On 2022-11-10, Petr Mladek <pmladek@suse.com> wrote:
> >> +void console_force_preferred_locked(struct console *con)
> >> +{
> >> +	struct console *cur_pref_con;
> >> +
> >> +	if (!console_is_registered_locked(con))
> >> +		return;
> >> +
> >> +	cur_pref_con = console_first();
> >> +
> >> +	/* Already preferred? */
> >> +	if (cur_pref_con == con)
> >> +		return;
> >> +
> >> +	hlist_del_init_rcu(&con->node);
> >
> > We actually should re-initialize the node only after all existing
> > console list walks are finished. Se we should use here:
> >
> > 	hlist_del_rcu(&con->node);
> 
> hlist_del_init_rcu() only re-initializes @pprev pointer.

Ah, I was not aware of it.

> But maybe you
> are concerned that there is a window where list_unhashed() becomes true?
> I agree that it should be changed to hlist_del_rcu() because there
> should not be a window where this console appears unregistered.

Makes sense.

> >> +	/* Only the new head can have CON_CONSDEV set. */
> >> +	WRITE_ONCE(cur_pref_con->flags, cur_pref_con->flags & ~CON_CONSDEV);
> >
> > As mentioned in the reply for 7th patch, I would prefer to hide this
> > WRITE_ONCE into a wrapper, e.g. console_set_flag(). It might also
> > check that the console_list_lock is taken...
> 
> Agreed. For v4 it will become:
> 
> console_srcu_write_flags(cur_pref_con->flags & ~CON_CONSDEV);

I am happy that your are going to introduce an API for this.

Just to be sure. The _srcu_ in the name means that the write
will use WRITE_ONCE() so that it can be read safely in SRCU
context using READ_ONCE(). Do I get it correctly, please?

I expect that the counter part will be console_srcu_read_flags().
I like the name. It is better than _unsafe_ that I proposed earlier.

Best Regards,
Petr
