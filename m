Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0C628776
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiKNRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiKNRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:49:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229525F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC166132C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9C0C433D7;
        Mon, 14 Nov 2022 17:49:51 +0000 (UTC)
Date:   Mon, 14 Nov 2022 12:50:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Eric Dumazet <edumazet@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221114125031.19f8330c@gandalf.local.home>
In-Reply-To: <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <875yfitpdu.ffs@tglx>
        <20221113191518.0a3b29b1@rorschach.local.home>
        <87sfims7ca.ffs@tglx>
        <87iljhsftt.ffs@tglx>
        <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
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

On Mon, 14 Nov 2022 09:16:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And honestly, for that to happen I'd be perfectly happy with something like
> 
>   #define timer_shutdown(t) del_timer(t)
>   #define timer_shutdown_sync(t) del_timer_sync(t)
> 
> (obviously with the patches that first remove the existing
> 'timer_shutdown()' uses first). That wouldn't introduce the *new*
> semantics, but it would at least allow the different subsystems to do
> the obvious cases, and let the networking people wonder about the much
> less obvious ones.

I can create the above series, if Thomas is OK with this approach.

-- Steve
