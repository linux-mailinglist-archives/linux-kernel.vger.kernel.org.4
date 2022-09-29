Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8315EF5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiI2Mno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiI2Mni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:43:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7215E4E2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:43:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B3711F8AC;
        Thu, 29 Sep 2022 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664455416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOcEESQnsA0kpIRBFTMbSdazV3q2H0MHo5CJze4RNjk=;
        b=ozZaI6K/BR4HmSPVh4Pyp8Oh1lguXzH0nxgSqqeEOo2217P1+JPLktAqKivCBmvo0ZvnPq
        FoXw2WRfGkhhsEi2+1n65FLX7IKy70r1Gur/RX5smABvAQxEueYBWWFrpvC9d5BmdOsmYu
        wMEYpFV93zURjW56O8Byjac/NZrDKgY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC0BD2C14F;
        Thu, 29 Sep 2022 12:43:35 +0000 (UTC)
Date:   Thu, 29 Sep 2022 14:43:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2 v4] Init the hashed pointer from a worker.
Message-ID: <YzWS9edAVjY0rMmi@alley>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927104912.622645-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-09-27 12:49:10, Sebastian Andrzej Siewior wrote:
> This is a mini series to initialize the random value, needed for the %p
> format argument, upfront during boot instead on demand. The latter is
> problematic on PREEMPT_RT if the first user happens to be in an atomic
> region.
> 
> v3…v4:
>     - Added a __read_mostly.
>     - Added Jason's Acked-by for 2/2 after talking to him at Plumbers.
>       While we were discussion several ways of tackling this differently
>       and the possible problems/ side effects that this may cause we
>       happen to notice that the current way of doing things is also a
>       problem if the first printk("%p\n") user happens to be in NMI
>       context.
>       Therefore I leave it to the vsprintf/ printk maintainer to decide
>       if this is -stable material or not. I'm not aware of any NMI code
>       path using %p but then it is not officially forbidden.
>       Assuming unknown_nmi_error() contains %p format the string, then
>       the backtrace at the end of the email will be printed.

JFYI, both patches are committed into printk/linux.git,
branch for-6.1-hash-pointer-init

I have just added a note into the 2nd patch about that it also
prevents deadlock when printk("%p", ptr) is called under the lock
used by get_random_bytes(), see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.1-hash-pointer-init&id=6f0ac3b52a9075b7291a72fb338d08491c1f0a64

I did not modify the code. The system_unbound_wq can and should be
fixed separately.

Best Regards,
Petr
