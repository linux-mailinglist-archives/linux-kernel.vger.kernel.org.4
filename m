Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8756F06E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbjD0Nxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0Nxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:53:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070002103
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:53:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B267B1FE35;
        Thu, 27 Apr 2023 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682603607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vt5Z9S2a+6XAPzuBQkUeOkFMmI6jTnVYd7rxV9vyLz4=;
        b=AWmhNAh4/Q1GpW3UvwqI4ALa5kiqhgH7+9GFyGiTga8DyErL7rb/uwLaK9wVi58+tbxbY4
        mzfDwbplmX/GQUdd6URJ0hsnu2W5I+buueGXFrMvDVLJEqZxle6KRptyuG3h4Rn7ktp58P
        UtemgsN47N4wYQ5oxuwMu2IukIwzSAw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 806DB2C141;
        Thu, 27 Apr 2023 13:53:27 +0000 (UTC)
Date:   Thu, 27 Apr 2023 15:53:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v4 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <ZEp-VxdvamrzcW4D@alley>
References: <cover.1681994220.git.chris@chrisdown.name>
 <fb9e0b15134958ef3c0fb7f725c3d5bf88702f85.1681994221.git.chris@chrisdown.name>
 <ZEfqZ6zZKt1tcNet@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEfqZ6zZKt1tcNet@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-04-25 16:57:49, Petr Mladek wrote:
> On Thu 2023-04-20 13:39:32, Chris Down wrote:
> > Consoles can have vastly different latencies and throughputs. For
> > example, writing a message to the serial console can take on the order
> > of tens of milliseconds to get the UART to successfully write a message.
> > While this might be fine for a single, one-off message, this can cause
> > significant application-level stalls in situations where the kernel
> > writes large amounts of information to the console.
> > 
> > --- /dev/null
> > +++ b/Documentation/admin-guide/per-console-loglevel.rst
> > +Console attributes
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +Registered consoles are exposed at ``/sys/class/console``. For example, if you
> > +are using ``ttyS0``, the console backing it can be viewed at
> > +``/sys/class/console/ttyS0/``. The following files are available:
> > +
> > +* ``effective_loglevel`` (r): The effective loglevel after considering all
> > +  loglevel authorities. For example, if the console-specific loglevel is 3, but
> > +  the global minimum console loglevel [*]_ is 5, then the value will be 5.
> 
> I would rather avoid this example. It confused me ;-)
> 
> I thought that it was talking about the "global console loglevel"
> instead of "global minimum console loglevel". I was surprised
> that the global value was used when a console-specific one
> was defined.
> 
> </more details about my confusion>
> The console loglevel defines a maximal message loglevel.
> The important thing is that it defines a "limit". Most people,
> including me, do not remember if the numbers go up or down.
> So I ignored the word "minimum". I though that it described
> the effect of the value and not a limit for the value.
> 
> Also the global minimum loglevel is a really weird setting.
> I do not see much practical use for it. I guess that most
> people are not aware of this limit. I think that it creates
> more harm than good.
> </more details about my confusion>
> 
> My proposal. I would replace the "confusing" paragraph with
> something like:
> 
>   * ``effective_loglevel`` (r): The effective loglevel after considering all
>     loglevel authorities. For example, it would show the value of
>     the console-specific loglevel when it is defined or the global
>     console loglevel value when the console-specific one is not defined.
> 
> > +* ``effective_loglevel_source`` (r): The loglevel authority which resulted in
> > +  the effective loglevel being set. The following values can be present:
> > +

Please, ignore this mail. It was a draft that I sent by
mistake. Let's follow the discussion in my proper review against v5,
see https://lore.kernel.org/r/ZEp9dXwHCYNPidjC@alley

Best Regards,
Petr
