Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5B60CFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiJYO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiJYO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:59:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637BE55
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:59:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E04B21FEE;
        Tue, 25 Oct 2022 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666709983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OnjWi2pdEy4n7cmfWwSconN2E9bcsinJA3k/vOB3j8=;
        b=Bi1oUHuhLNJkMqAAT63Md2prAKktFZVVGkXOzu9qROi0Bdaf1vvw5UL4KVunD3eEI5jq6f
        GHfIq5RXCZz68W80UEQ6EKYzDtPI/GLOX14CT77FWtITKpe8z0dmgwg7dlu6sUMU+Gsbht
        Zs8XwXnA11RSgttxqYJBtCOJC+LxFLs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F55D2C141;
        Tue, 25 Oct 2022 14:59:42 +0000 (UTC)
Date:   Tue, 25 Oct 2022 16:59:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v2 26/38] kdb: use srcu console list iterator
Message-ID: <Y1f53hZkpyAgfz7/@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-27-john.ogness@linutronix.de>
 <CAD=FV=U3BSOxDV6VKsEfFUdMTzuJr_VSL9GdvqnxN6qJ8tuW=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U3BSOxDV6VKsEfFUdMTzuJr_VSL9GdvqnxN6qJ8tuW=w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-24 17:47:25, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
> >
> > Guarantee safe iteration of the console list by using SRCU.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 550fe8b456ec..5c0bd93c3574 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
> >  {
> >         struct console *c;
> >         const char *cp;
> > +       int cookie;
> >         int len;
> >
> >         if (msg_len == 0)
> > @@ -558,7 +559,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
> >                 cp++;
> >         }
> >
> > -       for_each_console(c) {
> > +       cookie = console_srcu_read_lock();
> > +       for_each_console_srcu(c) {
> 
> Maybe it wouldn't hurt to also have a comment saying that normally the
> console_srcu_read_lock() wouldn't be enough given that we're poking
> into each individual console and calling ->write() but that we're
> relying on the fact that all the other CPUs are stopped at the moment
> and thus we should be safe.

True. I guess that the SRCU lock is not really needed from the same
reason.

Well, the SRCU walk makes sense. It makes sure that the list can be
safely traversed. I mean that pointers are updated and read in
the right order with the right barriers.

Yes, it would be nice to add a comment.

Best Regards,
Petr
