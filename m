Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334361E71C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKFWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKFWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:53:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2F910065
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:53:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 258F360BA0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B14DC433D6;
        Sun,  6 Nov 2022 22:52:59 +0000 (UTC)
Date:   Sun, 6 Nov 2022 17:52:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
Message-ID: <20221106175257.3f1b9a55@rorschach.local.home>
In-Reply-To: <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
References: <20221106054535.709068702@goodmis.org>
        <20221106054649.099333291@goodmis.org>
        <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
        <20221106160956.2414d73f@rorschach.local.home>
        <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
        <20221106165220.4d7e5dac@rorschach.local.home>
        <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 14:40:14 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I do think that you should just remove that E expression and the
> "function = E" part.
> 
> Really, _any_ use of the timer after the timer delete makes it questionable,
> 
> It doesn't change the patch in my testing, but I think it's silly to
> have that very specific pattern, when the more general case of "hey,
> if you use the timer after deleting it, it's not obvious that it
> should be a shutdown any more" just is more sensible anyway.

OK, I updated the script to:

@@
expression ptr, slab;
identifier timer, rfield;
@@
(
-       del_timer(&ptr->timer);
+       timer_shutdown(&ptr->timer);
|
-       del_timer_sync(&ptr->timer);
+       timer_shutdown_sync(&ptr->timer);
)
  ... when strict
      when != ptr->timer
(
        kfree_rcu(ptr, rfield);
|
        kmem_cache_free(slab, ptr);
|
        kfree(ptr);
)

And produced no difference from https://lore.kernel.org/all/20221106212702.547242324@goodmis.org/

I can post a v7a with the updated change log and also Guenter's
tested-by tag. But the patches will remain the same. Are you going to
just take that then?

-- Steve
