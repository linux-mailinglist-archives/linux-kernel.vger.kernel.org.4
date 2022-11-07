Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7C61ED4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKGIrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKGIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:47:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B971086;
        Mon,  7 Nov 2022 00:47:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B871722453;
        Mon,  7 Nov 2022 08:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667810860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFwkIA+hpXfr5X8ZQSucgd5/1QNkOR9JRiXi9mJSFas=;
        b=eZwujpWyIOaAy0UYMyza2lX7QA78jpGKxfHk1fRaxsXE8fwqguK1mQwDULKSazmwqaQXX2
        uBbL1xmlg+cHjXsP311tnDEoivhxnXrLtVIJK3xfSuROzdF79N6UrHWBo6tOh0/dups3Ko
        93c0iG4nvmF/4X7W8OULty2Go+EpiUQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 991672C141;
        Mon,  7 Nov 2022 08:47:38 +0000 (UTC)
Date:   Mon, 7 Nov 2022 09:47:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 12/38] tty: serial: kgdboc: use
 console_is_enabled()
Message-ID: <Y2jGKnSw02QLecx+@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-13-john.ogness@linutronix.de>
 <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
 <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
 <87czagf8hf.fsf@jogness.linutronix.de>
 <87bkpm7kp8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkpm7kp8.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-11-04 17:29:15, John Ogness wrote:
> On 2022-10-24, Doug Anderson <dianders@chromium.org> wrote:
> > It actually only holds console_list_lock() even at the end of the
> > series. Still, it seems weird that we're declaring the `data_race` on
> > CON_ENABLED but not CON_BOOT ?
> 
> For my upcoming v3 I decided to drop this patch and will keep the
> existing direct reading of @flags. Instead of this patch, for v3 the
> comment will additionally mention why @flags is allowed to be directly
> read:
> 
> /*
>  * Hold the console_lock to guarantee that no consoles are
              ^^^^^^^^^^^^
>  * unregistered until the kgdboc_earlycon setup is complete.

My understanding is that this is synchronized by console_list_lock.
Or do I miss something?

>  * Trapping the exit() callback relies on exit() not being
>  * called until the trap is setup. This also allows safe
>  * traversal of the console list and race-free reading of @flags.
>  */

Best Regards,
Petr
