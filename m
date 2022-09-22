Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6C5E66A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiIVPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIVPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:17:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41608EA5BD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:17:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E77EE219C2;
        Thu, 22 Sep 2022 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663859841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fLjBpSsIkHhWMS/r4yDqtoBRkYr2tKWwaoUAVKJthM=;
        b=J07kkDz6x0RLVy/wR68jKAm7naDi/iRO18VgU5wg22Ry7kXCVY7kGEeUA5PJSAPXroelrU
        0vHB0/9upMcI2Rl6Dy0y+BKGOsPagI8D3gN7SSWjk5qaIE7QSt0e0Yz8LEhn4hVXkEwCZg
        hQK6SUZorYbQJuZlzStX6dzq3io0J90=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A92A2C141;
        Thu, 22 Sep 2022 15:17:21 +0000 (UTC)
Date:   Thu, 22 Sep 2022 17:17:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <Yyx8gGNTe6VWPC6Y@alley>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
 <YxYLKU8TWZ4T5ONF@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYLKU8TWZ4T5ONF@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-09-05 15:43:53, Chris Down wrote:
> Hi Petr,
> 
> Thanks a lot for looking this over!
> 
> Petr Mladek writes:
> > I think that the function does not work as expected.
> > 
> > > +	bool seen_serial_opts = false;
> > > +	char *key;
> > > +
> > > +	while ((key = strsep(&options, ",")) != NULL) {
> > > +		char *value;
> > 
> > strsep() replaces ',' with '\0'.
> > 
> > > +
> > > +		value = strchr(key, ':');
> > > +		if (value)
> > > +			*(value++) = '\0';
> > 
> > This replaces ':' with '\0'.
> > 
> > > +
> > > +		if (!seen_serial_opts && isdigit(key[0]) && !value) {
> > 
> > This catches the classic options in the format "bbbbpnf".
> > 
> > > +			seen_serial_opts = true;
> > > +			c->options = key;
> > > +			continue;
> > > +		}
> > > +
> > > +		pr_err("ignoring invalid console option: '%s%s%s'\n", key,
> > > +		       value ? ":" : "", value ?: "");
> > 
> > IMHO, this would warn even about "io", "mmio", ...  that are used by:
> 
> Oh dear, I should have known it won't be that simple :-D
> 
> > 
> > 		console=uart[8250],io,<addr>[,options]
> > 		console=uart[8250],mmio,<addr>[,options]
> > 
> > Warning: I am not completely sure about this. It seems that
> > 	 this format is handled by univ8250_console_match().
> > 
> > 	 IMHO, the "8250" is taken as "idx" in console_setup().
> > 	 And "idx" parameter is ignored by univ8250_console_match().
> > 	 This probably explains why "8250" is optional in console=
> > 	 parameter.
> > 
> > > +	}
> > > +}
> > 
> > Sigh, the parsing of console= parameter is really hacky. Very old code.
> > The name and idx is handled in console_setup(). The rest
> > is handled by particular drivers via "options".
> > 
> > This patch makes it even more tricky. It tries to handle some
> > *options in add_preferred_console(). But it replaces all ','
> > and ':' by '\0' so that drivers do not see the original *options
> > any longer.
> 
> Other than the mmio/io stuff, I think it works properly, right? Maybe I'm
> missing something? :-)

One important thing is to do not warn about mmio/io when they are
valid options.

Another important thing is to restore *options string. I mean to
revert all the added '\0' when they are not longer needed.

The *options buffer is passed as paramter to both con->match()
and con->setup() callbacks, see try_enable_preferred_console().
They must be able to see all the values.

Well, I would remove the newly added "logleve:X" when it is handled
in __add_preferred_console(). Otherwise, we would need to double
check all con->match() and con->setup() callbacks that they are
able to handle (ignore) this new option.


> Here's a userspace test for the parser that seems to work.
> parse_console_cmdline_options() should also ignore empty options instead of
> warning, but it still functions correctly in that case, it's just noisy
> right now.

> % make CFLAGS='-Wall -Wextra -Werror' loglevel
> cc -Wall -Wextra -Werror    loglevel.c   -o loglevel
> % ./loglevel 9600n8
> options: 9600n8
> level: 0
> level set: 0
> % ./loglevel 9600n8,loglevel:3
> options: 9600n8
> level: 3
> level set: 1
> % ./loglevel 9600n8,loglevel:123
> ignoring invalid console option: 'loglevel:123'
> options: 9600n8
> level: 0
> level set: 0
> % ./loglevel 9600n8,loglevel:3,foo:bar
> ignoring invalid console option: 'foo:bar'
> options: 9600n8
> level: 3
> level set: 1
> % ./loglevel 9600n8,loglevel
> ignoring invalid console option: 'loglevel'
> options: 9600n8
> level: 0
> level set: 0
> % ./loglevel loglevel
> ignoring invalid console option: 'loglevel'
> options: (null)
> level: 0
> level set: 0
> % ./loglevel loglevel:7
> options: (null)
> level: 7
> level set: 1

> Seems to work ok as far as I can tell, maybe I've misunderstood your
> concern?  Or maybe your concern is just about the mmio/io case where the
> driver wants that as part of the options?

Yes, the mmio/io stuff is the known problem.

My concern is that the function is destructive. It modifies the given
*options buffer that it later passed to another functions. It means
that it modifies the existing behavior.

I am afraid that you might just add an extra check to keep the
particular mmio/io parameters. But I am not sure if these are there only
special parameters used by console drivers.

We found about mmio/io parameters because they were mentioned in
Documentation/admin-guide/kernel-parameters.txt. But there might
be another parameters used by some exotic console that are documented
somewhere else.

I would prefer to do it the other (conservative) way around. I mean
that the new parser in __add_preferred_console() will only search
for the newly added ",loglevel:X" option and remove it from *options
buffer. Everything else should stay in the buffer so that it can
be parsed by the particular console drivers.

It actually already works this way. console_setup() searches for
"tty[S]X" prefix and it "eats" this prefix. The rest of *str buffer
is passed via *options parameter down to __add_preferred_console().

Best Regards,
Petr
