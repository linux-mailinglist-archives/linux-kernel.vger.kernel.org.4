Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6160FA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiJ0O1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiJ0O1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:27:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B118980D;
        Thu, 27 Oct 2022 07:27:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E3561F8E8;
        Thu, 27 Oct 2022 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666880857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qpq/M/opCRpvF3FSdjlTdiqC45BiRz5sGZaOTgW0Sk=;
        b=dX95m2lVjr68CqcXgfwMM+/vozHuhOFtUCxWGxQK7iOx92ZJhMygrLLabYB2Nr2Manu0tV
        m/6CGaOrj0vRvXbgzYWILO8IFQOdNwBx5tz8nxr/sNk7i3vSNqkGv1AUg5R8xaRl9jxwyW
        tE/LzH7OQv6HOVt/Xobnc/3i6OgSkd0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1B092C141;
        Thu, 27 Oct 2022 14:27:36 +0000 (UTC)
Date:   Thu, 27 Oct 2022 16:27:36 +0200
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
Subject: Re: [PATCH printk v2 38/38] printk, xen: fbfront: create/use safe
 function for forcing preferred
Message-ID: <Y1qVWOyJuALz0vXf@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-39-john.ogness@linutronix.de>
 <Y1qFHbi39SpTggPH@alley>
 <87v8o5crtw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8o5crtw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-10-27 15:41:23, John Ogness wrote:
> On 2022-10-27, Petr Mladek <pmladek@suse.com> wrote:
> >> -	if (c) {
> >> -		unregister_console(c);
> >> -		c->flags |= CON_CONSDEV;
> >> -		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
> >> -		register_console(c);
> >> -	}
> >> +	if (c)
> >> +		console_force_preferred(c);
> >
> > I would prefer to fix this a clean way.
> >
> > [...]
> >
> > I would suggest to implement:
> >
> > [...]
> >
> > It is a more code. But it is race-free. Also it is much more clear
> > what is going on.
> >
> > How does this sound, please?
> 
> I wasn't sure if any of the other preferred-console magic in
> register_console() was needed, which is why I kept a full
> register_console() call. But if it really is just about forcing it the
> head and setting a new CON_CONSDEV, then your suggestion is much
> simpler. Thanks.

I believe that it is just this. I have spent a lot of time
investigating these hacks when thinking about refactoring
of register_console().

Best Regards,
Petr
