Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABC61E01B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKFDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:12:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB4CF4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AA580CE092D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 03:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FFCC433C1;
        Sun,  6 Nov 2022 03:12:43 +0000 (UTC)
Date:   Sat, 5 Nov 2022 23:12:41 -0400
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
Message-ID: <20221105231241.7513fc33@rorschach.local.home>
In-Reply-To: <b52c207c-e7bf-af2e-61d9-116c9e76af86@inria.fr>
References: <20221105060024.598488967@goodmis.org>
        <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
        <20221105123642.596371c7@rorschach.local.home>
        <20221105140356.6a3da628@rorschach.local.home>
        <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
        <20221105144303.3552bf85@rorschach.local.home>
        <775ada-29f1-3b56-7deb-c1b8d958e2c@inria.fr>
        <20221105203634.7e0b2e8e@rorschach.local.home>
        <b52c207c-e7bf-af2e-61d9-116c9e76af86@inria.fr>
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

On Sun, 6 Nov 2022 11:05:14 +0800 (+08)
Julia Lawall <julia.lawall@inria.fr> wrote:

> > Thinking that's what you meant (examples would be easier to understand,
> > than descriptions). And it didn't cover the return case. Does it only
> > cover gotos?
> >
> >   See drivers/net/wireless/intel/iwlwifi/mvm/sta.c for the false positive case:
> >
> > 	del_timer_sync(&baid_data->session_timer);
> > [..]  
> 
> But there is a kfree_rcu(baid_data, rcu_head); right below.  So it looks
> fine?

D'oh! I think you are correct. I didn't trust the script and it appears
that it was correct all along. The free was hidden in between the code
and I only noticed the kfree() in the error path. I thought that was a
bug in the script. :-/

I guess there were no false positives then. To be sure, I'll write a
script to find all that have a return or goto in between and see what
it comes up with.

I guess my original patch doesn't need any changes from the script.
I'll look more.

Thanks Julia!

-- Steve
