Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC862816E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiKNNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiKNNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:35:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD38193D4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEA62B80EBD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B4C433D7;
        Mon, 14 Nov 2022 13:35:54 +0000 (UTC)
Date:   Mon, 14 Nov 2022 08:36:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221114083635.60e23559@gandalf.local.home>
In-Reply-To: <87sfims7ca.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <875yfitpdu.ffs@tglx>
        <20221113191518.0a3b29b1@rorschach.local.home>
        <87sfims7ca.ffs@tglx>
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

On Mon, 14 Nov 2022 01:33:25 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, Nov 13 2022 at 19:15, Steven Rostedt wrote:
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> You surely have spent a massive amount of analysis on this!
> >> 
> >> Can you please explain how you came up with the brilliant idea of asking
> >> Linus to pull this post -rc4 without a review from the timer maintainers
> >> or anyone else who understands concurrency?  
> >
> > I trusted the source of this code:
> >
> >   https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/  
> 
> Sure because uncomplied suggestions are the ultimate source of truth and
> correctness, right?

Well, I figured it covered the race conditions.

> 
> I'm terribly sorry that I misled you on this, but OTOH it's pretty
> obvious that you decided to ignore:
> 
>    https://lore.kernel.org/all/87v8vjiaih.ffs@tglx/
> 

I'm not sure what you mean by that. The idea is that once timer_shutdown()
is called, we still warn on re-arming the timer. Yeah, I did not follow
Linus's suggestion that we just use shutdown to prevent the race and let it
re-arm if it wants. That is, I did not blindly convert all del_timer_sync()
to timer_shutdown(). The script only converts it if there's an immediate
free of the object that holds the timer in the same function without any
paths to avoid it.

The final patch series
(https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/) works
to make sure that after the shutdown is called, it does not get re-armed.

-- Steve
