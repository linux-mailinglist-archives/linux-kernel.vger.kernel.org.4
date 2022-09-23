Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7790B5E7E69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiIWPaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiIWPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4A9FAB5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD6CFB80B3A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545E4C433C1;
        Fri, 23 Sep 2022 15:30:04 +0000 (UTC)
Date:   Fri, 23 Sep 2022 11:31:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Kacur <jkacur@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: printk meeting at LPC 2022
Message-ID: <20220923113107.79d3e013@gandalf.local.home>
In-Reply-To: <875yheqh6v.fsf@jogness.linutronix.de>
References: <20220910221947.171557773@linutronix.de>
        <87h71cr1gb.fsf@jogness.linutronix.de>
        <875yheqh6v.fsf@jogness.linutronix.de>
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

On Fri, 23 Sep 2022 16:55:28 +0206
John Ogness <john.ogness@linutronix.de> wrote:

>   All other consoles could then be tried as a "last hope" at the very
>   end of panic(), after all records have been flushed to reliable
>   consoles and when it no longer matters if a console kills the CPU. For
>   non-panic emergencies (warn, rcu stalls, etc), there may be other
>   flags that would be needed.

I think we may need to check if kexec is involved. We don't want one of
these "last hope" consoles to lock up the system preventing kexec to occur.

But if there's no kexec, and the system is just going to lock up anyway,
then sure go ahead and call the unsafe consoles.

-- Steve
