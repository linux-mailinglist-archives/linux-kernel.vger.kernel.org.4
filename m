Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5006A8C40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCBWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCBWxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:53:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9321B2DB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D49615FE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 22:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF3C433D2;
        Thu,  2 Mar 2023 22:53:36 +0000 (UTC)
Date:   Thu, 2 Mar 2023 17:53:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        "Midas Chien" <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Anton Vorontsov" <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230302175334.49abf342@gandalf.local.home>
In-Reply-To: <dcf2fa0bde1e49a286c57c1e7d4a78d3@AcuMS.aculab.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
        <dcf2fa0bde1e49a286c57c1e7d4a78d3@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 22:41:36 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I can't help feeing that the RT kernel suffers from the
> same problems if the system is under any kind of load.
> You might get slightly better RT response, but the overall
> amount of 'work' a system can actually do will be lower.

That basically is the definition of an RTOS.

But it's not "slightly better RT responses" what you get is a hell of a lot
better responses, and no unbounded priority inversion.

On some workloads I can still get millisecond latency cases on vanilla
Linux where as with the PREEMPT_RT patch, the same workload is still under
a 100 microseconds.

-- Steve
