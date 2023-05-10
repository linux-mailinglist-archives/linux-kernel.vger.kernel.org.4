Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B456FDA51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjEJJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjEJJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:03:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABB93AB6;
        Wed, 10 May 2023 02:03:11 -0700 (PDT)
Date:   Wed, 10 May 2023 11:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683709388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koD4cPNLIm/3wGHC3EUteEyEyTTF+ReaD/tXyekbMOQ=;
        b=Sj6Q+mZK1Sh7wD3GRIO91IlUZaDPN4ecfDyK/X12c0k+idExcfzk1ObRV8y2qd/iHVhy27
        lOx4FLgfQGv0fEm0PiDmkcMQS4iG/W/UzlZHBTu7y7XgZqSDbAsNWbddaAkTvehhFn1I4z
        lZUsCU1fGAhILvmaR/k3yjMIJ8jg5MddbKXTiV+yIkFhb323++gcq3SIkI9xSSkXXcQs44
        3GgJ5KSoEQeIef4I3O7ozG5iaTuDJWs+P6mXyNmaxIvUteRFi+04mH0DVBmIIcyq9t/J1j
        6eJn9b8efjrIXsPAvsQTHcus0IS5nbMTx//f+Jxt8+U9WUiyBEFuSX+Y/E0hSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683709388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koD4cPNLIm/3wGHC3EUteEyEyTTF+ReaD/tXyekbMOQ=;
        b=N6EJm5GFButoC3rcZLzq6db/2Fkhmh5G15xAkRJ/6bGGMMESFiSlG2yQR/2QCu2NS3m/oX
        c0ytQj07XX+2f0Bg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Andrea Righi <andrea.righi@canonical.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] timers/nohz: introduce nohz_full_aggressive
In-Reply-To: <ZFe1IY+TdzSC0RLZ@righiandr-XPS-13-7390>
Message-ID: <2161b8c0-b08c-7bf7-4c99-3bb89ca44ad8@linutronix.de>
References: <20230507090700.18470-1-andrea.righi@canonical.com> <20230507100852.54a354ca@rorschach.local.home> <ZFe1IY+TdzSC0RLZ@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023, Andrea Righi wrote:

> On Sun, May 07, 2023 at 10:08:52AM -0400, Steven Rostedt wrote:
> > 
> > [ Added Anna-Maria who is doing some timer work as well ]
> > 
> > On Sun,  7 May 2023 11:07:00 +0200
> > Andrea Righi <andrea.righi@canonical.com> wrote:
> > 
> > Now, I think what is really happening here is that you are somewhat
> > simulating the results that Anna-Maria has indirectly. That is, you
> > just prevent an idle CPU from waking up to handle interrupts when not
> > needed.
> > 
> > Anna-Maria,
> > 
> > Do you have some patches that Andrea could test with?
> > 
> > Thanks,
> > 
> > -- Steve
> 
> Thanks for looking at this (and I'm happy to help Anna-Maria with any
> test).

I posted v6 of the queue - but forgot to add you to cc list. Here is the
current version:

  https://lore.kernel.org/lkml/20230510072817.116056-1-anna-maria@linutronix.de/

I have to mention, that there is still the issue with the fair scheduler
which wakes up the CPU where the process_timeout() timer was enqueued,
because it assumes that context is still cache hot.

Thanks,

	Anna-Maria

