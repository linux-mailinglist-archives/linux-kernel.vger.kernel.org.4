Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785B361DFD4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 01:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKFAgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 20:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFAgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 20:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D11FCED
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 17:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C8360BC8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 00:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80525C433D6;
        Sun,  6 Nov 2022 00:36:36 +0000 (UTC)
Date:   Sat, 5 Nov 2022 20:36:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing
 timers
Message-ID: <20221105203634.7e0b2e8e@rorschach.local.home>
In-Reply-To: <775ada-29f1-3b56-7deb-c1b8d958e2c@inria.fr>
References: <20221105060024.598488967@goodmis.org>
        <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
        <20221105123642.596371c7@rorschach.local.home>
        <20221105140356.6a3da628@rorschach.local.home>
        <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
        <20221105144303.3552bf85@rorschach.local.home>
        <775ada-29f1-3b56-7deb-c1b8d958e2c@inria.fr>
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

On Sun, 6 Nov 2022 07:08:48 +0800 (+08)
Julia Lawall <julia.lawall@inria.fr> wrote:

> Various suggestions:
> 
> 1.  On your ... put when strict and then on a separate line put when !=
> ptr.  The when strict will get rid of the goto problem (usually a
> desirable feature, but not here) and the when != ptr will be sure that ptr
> is not used before the free.

You mean ptr->timer.function? because it's allowed to be touched. Only
this case is weird (and I believe I covered it).

Not sure what you mean by "put when strict" I added:

 ... when strict

Thinking that's what you meant (examples would be easier to understand,
than descriptions). And it didn't cover the return case. Does it only
cover gotos?

  See drivers/net/wireless/intel/iwlwifi/mvm/sta.c for the false positive case:

	del_timer_sync(&baid_data->session_timer);
[..]
        return 0;

out_free:
        kfree(baid_data);
        return ret;
}

That "return 0" should make the match fail.

> 
> 2.  If you want to handle the initialization of the function field, then
> you can duplicate the rule and add the removal of that assignment in the
> first one.  This only seems worth it if it is a very common case.
> Otherwise, I would agree with Linus and just take care of it by hand
> later.

No, Linus wants the script to not touch the initialization case. That
is, currently, the script does the conversion (which also initializes
it), and the timer.function = NULL is just redundant.

What Linus wanted, was my script to do nothing in this case. But I
figured this part out.

> 
> 3. Running the rule three times seems to me like a reasonable choice.  Or
> you could duplicate the rule three times.  But that would be more script
> to read through.  If this is not a common case, though, you could probably
> also fix the one up later by hand.

Yeah, that's fine.

I'm just looking for how to avoid the goto / return case.

-- Steve
