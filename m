Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFA5E787F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIWKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIWKhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:37:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F381296B8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:37:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 131D82199A;
        Fri, 23 Sep 2022 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663929419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2pKPKJLTiTkpoVATkLkUo2lNNjZ9DxfVfraEJnPgSY=;
        b=f48byvyRbgUd85XZ2KjI+5ZndvyGLLT8PEuJT/MGvAALyTLjUTUnk3m7r+F2OZFhuRR8ln
        +eNgic1L69JtTClxykx0ktOFX2FEgMAQ0QcID55GlRLr3TT91c6B4pjKE5ht2l0mUeEXxb
        R5nOPqhyB8GNxjK7atWMlsXujP31HUc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A25292C153;
        Fri, 23 Sep 2022 10:36:58 +0000 (UTC)
Date:   Fri, 23 Sep 2022 12:36:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2 v3] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <Yy2MSm1zIRWa2BT4@alley>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
 <YuRtSGCfe2qxHrqT@zx2c4.com>
 <YueBnnnnvpxxjE4N@linutronix.de>
 <YueeIgPGUJgsnsAh@linutronix.de>
 <CAHmME9rZj9S62RngnYhkvj7is6Qi4wx0St-PiOwrLON-cW0OoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9rZj9S62RngnYhkvj7is6Qi4wx0St-PiOwrLON-cW0OoA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-09-20 17:01:33, Jason A. Donenfeld wrote:
> Hi,
> 
> On Mon, Aug 1, 2022 at 11:34 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > The printk code invokes vnsprintf in order to compute the complete
> > string before adding it into its buffer. This happens in an IRQ-off
> > region which leads to a warning on PREEMPT_RT in the random code if the
> > format strings contains a %p for pointer printing. This happens because
> > the random core acquires locks which become sleeping locks on PREEMPT_RT
> > which must not be acquired with disabled interrupts and or preemption
> > disabled.
> > By default the pointers are hashed which requires a random value on the
> > first invocation (either by printk or another user which comes first.
> >
> > One could argue that there is no need for printk to disable interrupts
> > during the vsprintf() invocation which would fix the just mentioned
> > problem. However printk itself can be invoked in a context with
> > disabled interrupts which would lead to the very same problem.
> >
> > Move the initialization of ptr_key into a worker and schedule it from
> > subsys_initcall(). This happens early but after the workqueue subsystem
> > is ready. Use get_random_bytes() to retrieve the random value if the RNG
> > core is ready, otherwise schedule a worker in two seconds and try again.
> >
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > v2…v3:
> >    - schedule a worker every two seconds if the RNG core is not ready.
> >
> As we discussed at Plumbers, it seems like this is the least-awful way
> forward. If we wind up with another case sufficiently similar to this,
> I'll add back a notifier to random.c. But while there's only this one
> special case, the ugly timer thing will have to do.
> 
> So Petr - feel free to queue this up this v3, with my objection now removed.

v3 is still using two patches and there was some discussion about
adding __read_mostly.

Sebastian, could you please re-send a cleaned up patch(set). Also it would
be to get/add there also Acked-by from Jason.

Thanks in advance.

Best Regards,
Petr
