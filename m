Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C606248EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiKJSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiKJSAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:00:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150B47314;
        Thu, 10 Nov 2022 10:00:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 324AD1FF97;
        Thu, 10 Nov 2022 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668103230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWcSmvtAAd5nshpVmK+tjYCHfPfNH63I2RCJ9fpekb0=;
        b=pnPpVVewxH0PjRciuCOtuB7hb5Th2mXdC1dbLBfyijTO/9Ag9YMDi0fwiQCbd8TGLh+t6F
        OOJ9FnNP4GZJwiUoYv9iPblTq37t40B7oMb6i5hms49C1ZBPUBRWJRba7rDctwvdYF7O2A
        LzXlIrGoNkzOWLAwzSOfl2YEV0pyJWc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5F582C142;
        Thu, 10 Nov 2022 18:00:29 +0000 (UTC)
Date:   Thu, 10 Nov 2022 19:00:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 36/40] tty: serial: kgdboc: use
 console_list_lock for list traversal
Message-ID: <Y208PUz/fotmi8/R@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-37-john.ogness@linutronix.de>
 <20221109090631.wbtar2ho45x5yanl@ash.lan>
 <87tu388nsk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu388nsk.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-09 10:50:43, John Ogness wrote:
> On 2022-11-09, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> >> @@ -463,9 +476,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
> >>  	 * serial drivers might be OK with this, print a warning once per
> >>  	 * boot if we detect this case.
> >>  	 */
> >> -	for_each_console(con)
> >> +	cookie = console_srcu_read_lock();
> >> +	for_each_console_srcu(con) {
> >>  		if (con == kgdboc_earlycon_io_ops.cons)
> >> -			return;
> >> +			break;
> >> +	}
> >> +	console_srcu_read_unlock(cookie);
> >> +	if (con)
> >> +		return;
> >
> > This change isn't mentioned in the patch description.
> 
> I will move this change into its own separate patch.
> 
>     tty: serial: kgdboc: use srcu console list iterator
> 
>     Use srcu console list iteration for safe console list traversal.

Yes, split it please :-) Anyway, both changes look good to me.

Best Regards,
Petr
