Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7916340A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiKVPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKVPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:55:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB69720AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:55:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D09401F86B;
        Tue, 22 Nov 2022 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669132526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VeFIPJECu8nE+ikYuLTPQhIWFf9JfxjgpbHjHtL6c1I=;
        b=ggPClbhTYnZ+Cky+LlzpEBM4iesF0Nn12oM/Dp7jS+T4uGIhY18qEDVgRXRL5SnkkNgoKm
        ZiVnkTqzq7p9Rwwgr8fjiRHcqFrkA1WKb20x6UFjccgoCkIw5GooT7uQNtuZ4j2SF2KWsi
        HsZBJ7gNMPxKqL0DGss5Uuy3Mgf0tSI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A7FEB2C141;
        Tue, 22 Nov 2022 15:55:26 +0000 (UTC)
Date:   Tue, 22 Nov 2022 16:55:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     paulmck@kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <Y3zw7nv5KJ32P4FG@alley>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leo3ovpw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-22 16:33:39, John Ogness wrote:
> On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?
> >
> > The people wanting it separate back in the day were those wanting very
> > tiny kernels.  I have not heard from them in a long time, so maybe it
> > is now OK to just make SRCU unconditional.
> 
> Who decides this? Or maybe I should create a semaphore-based Variant of
> console_srcu_read_lock()/console_srcu_read_unlock() for the
> "!CONFIG_PRINTK && !CONFIG_SRCU" case?

I would prefer to avoid it. It would require keeping this in mind.
Semaphore behaves very differently than srcu_read_lock (deadlocks,
nesting).

I am not sure how much the tiny SRCU would increase the size of
the kernel. I doubt that it would be more that what printk()
added by the various per-CPU and per-console buffers.

Well, another question is why we actually need to register the consoles
at all for !CONFIG_PRINTK. Only reasons come to my mind:

   + /dev/console
   + preventing double registration/unregistration (initialization)

I could imagine to handle these two use-cases a special way
on tiny systems. But I would do it only when anyone complains.

Best Regards,
Petr
