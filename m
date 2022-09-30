Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979455F0785
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiI3JY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiI3JYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:24:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6E156C07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:24:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C34D21F8D0;
        Fri, 30 Sep 2022 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664529860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/w9v/EtliJzrcCmW8F1pmfKRD9QA41ZDvS7ESzkKgc=;
        b=Ld4rSsPqY8I1s9ps2vAGk3yFdrKZ95lpCIQA2vvOvvxT79nPnWmPcCnSwBKgmIx/e9lTWE
        PVNh48rz7+FykD3PxlydTg+rqM/b/HT/5TP/esg+MvGwp1nH9kIn7tz3Mj+N7ecFK/jAg9
        aLrZ6btnpWRJ5Wo9JtZnWMCWE6XqCIo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 79F762C178;
        Fri, 30 Sep 2022 09:24:20 +0000 (UTC)
Date:   Fri, 30 Sep 2022 11:24:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <Yza1wxVcH2bsITcs@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
 <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzW9ExRVjv6PzvWR@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-09-29 17:43:17, Petr Mladek wrote:
> On Thu 2022-09-29 01:48:29, John Ogness wrote:
> > On 2022-09-27, Petr Mladek <pmladek@suse.com> wrote:
> > > Hmm, the new mutex is really nasty. It has very strange semantic.
> > > It makes the locking even more complicated.
> > 
> > We are working to replace the BKL-console_lock with new separate clearly
> > defined mechanisms.
> >
> > The new mutex provides full synchronization for list changes as well as
> > changes to items of that list. (Really console->flags is the only change
> > to items of the list.)

We should actually make the the reading of console->flags safe under
srcu_read_lock(). It would allow to use the SRCU walk by all the
readers.

> > For some places in the code it is very clear that the console_lock can
> > be completely replaced (either with srcu or the new mutex). For other
> > places, it is not yet clear why the console_lock is being used and so
> > both console_lock and mutex are used.
> 
> One important and tricky location is console_trylock() in
> vprintk_emit(). And the related for_each_console() called from
> console_unlock()->console_flush_all().
> 
> It is the legacy mode that tries to print to the consoles immediately.
> I am not sure if we could _ever_ remove this mode.
> 
> I would really like to avoid state where we have two locks (semaphore
> and mutex) serializing the same thing (console list).

That said, I could imagine implementing console_lock() so that it
would be implemented by mutex when the legacy mode is disabled and
semaphore when it is allowed.

You were talking about command-line option that would allow to
disable the legacy mode on production RT systems. And I guess
that you added mutex because it behaves better on RT.

Also I could imagine using console_list_lock() as a wrapper
to console_lock(). It might help to distinguish locations where
the list is traversed and where the console_lock() is used for
another reason. I mean to remove the big-kernel-lock character
of the console_lock().

You know, the more locks we have, the bigger is the risk of
deadlocks, and the more hacks would be needed in
console_flush_on_panic(). And I am afraid
that console_lock() will be with us for many years and
maybe forever.

Does it make any sense, please?

Best Regards,
Petr
