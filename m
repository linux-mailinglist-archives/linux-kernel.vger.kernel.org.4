Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D13628495
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiKNQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiKNQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:04:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6431B7BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D50EB8104F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A0BC433C1;
        Mon, 14 Nov 2022 16:04:07 +0000 (UTC)
Date:   Mon, 14 Nov 2022 11:04:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Eric Dumazet <edumazet@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221114110449.18124499@gandalf.local.home>
In-Reply-To: <87iljhsftt.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <875yfitpdu.ffs@tglx>
        <20221113191518.0a3b29b1@rorschach.local.home>
        <87sfims7ca.ffs@tglx>
        <87iljhsftt.ffs@tglx>
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

On Mon, 14 Nov 2022 16:42:22 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> So something like the below should do the trick. It's compiled this time
> and I spent more than 5 seconds to stare at it. Still needs some
> eyeballs and splitting apart into more digestable pieces.

Thanks Thomas. I really appreciate this.

> 
> The only downside of this is that timers which are not properly
> initialized are now silently ignored. That's not a real problem as
> driver writers should run their code with debugobjects enabled at least
> once, which will tell them nicely. So if someone has to scratch his head
> why his timer is not firing, then it's well deserved.

I just came back from my trip with over 300 patches to review :-p Luckily,
for me, Masami is now a co-maintainer and has started that process already :-)

When I catch up, I'll take a look at this more closely, and we (Guenter and
I) will be running with DEBUG_OBJECTS enabled which will hopefully help
catch missed places. At least for the drivers we care about ;-)

-- Steve
