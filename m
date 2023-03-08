Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC66B1341
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCHUlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCHUlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:41:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D306A2DA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:41:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1996061902
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 20:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D186C433EF;
        Wed,  8 Mar 2023 20:41:13 +0000 (UTC)
Date:   Wed, 8 Mar 2023 15:41:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230308154111.483a686f@gandalf.local.home>
In-Reply-To: <CANDhNCpw+M_bwLpxb-vdL__xZrQsAVCMBozVt3+v4ncUVKbfAA@mail.gmail.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
        <20230302163253.541ac3a8@gandalf.local.home>
        <20230302163603.223313ba@gandalf.local.home>
        <20230302165613.2dcc18ca@gandalf.local.home>
        <20230302200136.381468f0@gandalf.local.home>
        <20230307203122.14b077c4@gandalf.local.home>
        <CANDhNCpw+M_bwLpxb-vdL__xZrQsAVCMBozVt3+v4ncUVKbfAA@mail.gmail.com>
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

On Wed, 8 Mar 2023 12:04:23 -0800
John Stultz <jstultz@google.com> wrote:

> I'm interested in continuing to see if we can further tweak it, but
> I've got some other work I need to focus on, so I think I'm going to
> advocate for the revert in the short-term and look at finer grained
> locking (along with rtmutex to address the priority inversion issue)
> in the longer term.

Yeah, I would suggest the same. I would still like to see what the
difference is. Because I believe this will also be an issue for PREEMPT_RT.

-- Steve
