Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEC609F62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJXKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:19 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 03:54:19 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DC5A17D;
        Mon, 24 Oct 2022 03:54:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 147C361C24;
        Mon, 24 Oct 2022 12:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608857;
        h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
         references; bh=ggedhJh1EHWK9qNin4m66c03VGctJh9G7V0HKNEN04Y=;
        b=fdFQpBm4T/UC47utgxrSqkY3N24nXcCQFT1qJ77mNYeZdEjDkAaf5MBUil6J4f4psSe43M
        19VwejTI/p1KSwwjFeyjHwhJtOUswaUIACU/9lKyA+dvLc+tE5P1Yijz4s87fqZ/9s1QrN
        x5J3GOPLc80mZTvAR3f3daRZIViZj8jIpthSNA3XAiCAIxTOE73MgavXez1EMRq6d3gZb8
        CJYpsD+CHTG3S7+ClmMF4HhN9Au45IEEnzzC3IriyW4wpKhVyRhq5y84i3q/F1WSTipCIw
        iHSmGI6007mTclyjUcix+03IAphOqLpOu3LSBO7zVlvkIEonFkRR0qXb5Ceb4w==
Date:   Mon, 24 Oct 2022 12:54:16 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH RT 0/9] Linux v4.19.255-rt114-rc1
Message-ID: <20221024105416.nflnrqhmzsyqqdzz@carbon.lan>
References: <20221024104425.16423-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:44:16PM +0200, Daniel Wagner wrote:
> Dear RT Folks,
>
> This is the RT stable review cycle of patch 4.19.255-rt114-rc1.
>
> Please scream at me if I messed something up. Please test the patches
> too.
>
> The -rc release will be uploaded to kernel.org and will be deleted
> when the final release is out. This is just a review release (or
> release candidate).
>
> The pre-releases will not be pushed to the git repository, only the
> final release is.
>
> If all goes well, this patch will be converted to the next main
> release on 2022-10-31.

Timer changes seem not to be correct though:

[   24.674424] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[   24.674426] in_atomic(): 0, irqs_disabled(): 1, pid: 23, name: ktimersoftd/1
[   25.730421] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[   25.730424] in_atomic(): 0, irqs_disabled(): 1, pid: 11, name: ktimersoftd/0

I get those for when running any of the rttests. I suppose I am missing
an additional fix:

-               if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
-                   timer->flags & TIMER_IRQSAFE) {
+               if (timer->flags & TIMER_IRQSAFE) {
                        raw_spin_unlock(&base->lock);
                        call_timer_fn(timer, fn);
                        base->running_timer = NULL;


is now queuing up fn callbacks with TIMER_IRQSAFE which then triggers:

+       if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+               might_sleep();

in del_timer_sync(). But this is just a guess.

Daniel
