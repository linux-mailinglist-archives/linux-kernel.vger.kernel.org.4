Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51DA619D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKDQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKDQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:23:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788C2FC25;
        Fri,  4 Nov 2022 09:23:17 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667578996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tijLp86GZkQuYvpbkKNsoSVqaYbeBZGTP0NGWpFyyCE=;
        b=rhX9V8yaFwgNnlHRVbXxSHwqauTFRTjTrQL6BQ1p6vBoQS+MPSPyCmgaN+rVzZbZBMCK8l
        xo5SiNiRlO3EDC0yfxtSoi8U3Zjuu33rA+FMPViiORyfhqRC19TvEgrnEYVsKhv/m0CUrv
        7uo+pCOQcFp6C62wH+xMood/ljqOalG8ogQFvFnOEVZ/zpGls4t+rqTIIxBquItUOK8ZBn
        rgSqrlIJ74Nh5rH4KOzY24TklkQ8VxiLlwm+QOxJV/3l9cfBRUgmtn4fjiw8RxGTQc6j5P
        Lo3zjkbgBHbIxinMoz3ykEASjqzkzppFTRmxVuyv60daF7CRQtMVQwq6XOLoIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667578996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tijLp86GZkQuYvpbkKNsoSVqaYbeBZGTP0NGWpFyyCE=;
        b=03km6Xg2ZZbUKK1SCAp0bHxpHwoD19D3C1TT2XmKXk1NfLgyr78f44THYoqM/4udhMvv4f
        SinlmF6qT5x7kCDw==
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 12/38] tty: serial: kgdboc: use
 console_is_enabled()
In-Reply-To: <87czagf8hf.fsf@jogness.linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-13-john.ogness@linutronix.de>
 <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
 <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
 <87czagf8hf.fsf@jogness.linutronix.de>
Date:   Fri, 04 Nov 2022 17:29:15 +0106
Message-ID: <87bkpm7kp8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-24, Doug Anderson <dianders@chromium.org> wrote:
> It actually only holds console_list_lock() even at the end of the
> series. Still, it seems weird that we're declaring the `data_race` on
> CON_ENABLED but not CON_BOOT ?

For my upcoming v3 I decided to drop this patch and will keep the
existing direct reading of @flags. Instead of this patch, for v3 the
comment will additionally mention why @flags is allowed to be directly
read:

/*
 * Hold the console_lock to guarantee that no consoles are
 * unregistered until the kgdboc_earlycon setup is complete.
 * Trapping the exit() callback relies on exit() not being
 * called until the trap is setup. This also allows safe
 * traversal of the console list and race-free reading of @flags.
 */

John Ogness
