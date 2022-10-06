Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201095F6BED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiJFQj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:39:51 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4E1209D;
        Thu,  6 Oct 2022 09:39:50 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id g28so2531275pfk.8;
        Thu, 06 Oct 2022 09:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kI+Hy1fopJBk2WLyhqkwFmt1bdUHIknRqdw/wRFVZbg=;
        b=C32d970mDhqv88cer4zVCq7IkNLCLjHjSzPXtDRTvxM/U34npugQ3sbl0zt1XkapSz
         HwTyOUP3r7doj5bG0vHB7WPnndktkGxhlTIT/mtRpRzg4RWjYj7PFvUD5ZA4H4wvuzcz
         Jb2zdwBGQ6eAJNa6kBdNevzf+mfv3CetZRKhOpk8RS5+3wwB3GQpnV78wHlIMfRMQyjq
         CweWjyORJrdRab/wh78wr3k2R3C2xxPeIiqhKJ0JS7X+mFQDxpd3ruPLW/V7grxIBfZN
         b9v85A+xVsxLXiSOYlS6r4xuFb4zgrpMkOz4wqX1dr+Hhqet0WU3QhKb50kqSI/1f5JZ
         oSYA==
X-Gm-Message-State: ACrzQf3foCcloURPh9IHSE7q6fGriT5WcMP5z8piGJJisFh+sevwRaHw
        x7JgYZW+fMgJA9bhdpY/sWxAiqnKJQM=
X-Google-Smtp-Source: AMsMyM770LljWrp5Q4xIriT9pYW6hWLwVtO/x0/Mnhn/PfGZNdDiWtbrRKBLP5YulKLkaD8WLnraRg==
X-Received: by 2002:a65:6d8a:0:b0:43c:9fcc:cb24 with SMTP id bc10-20020a656d8a000000b0043c9fcccb24mr605969pgb.477.1665074389518;
        Thu, 06 Oct 2022 09:39:49 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.230])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902bb8100b0017bf6061ee4sm4779760pls.117.2022.10.06.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:39:48 -0700 (PDT)
Date:   Thu, 6 Oct 2022 09:39:46 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz8E0lSmsMMB6KeO@sultan-box.localdomain>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
 <Yz55w4gNtZn8JzmG@linutronix.de>
 <Yz7JXEaTFWa1VLKJ@zx2c4.com>
 <Yz7M5zJmzKSk/LYH@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7M5zJmzKSk/LYH@linutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Oct 06, 2022 at 02:41:11PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-10-06 06:26:04 [-0600], Jason A. Donenfeld wrote:
> > e) del_timer_sync() on line 5 is called, and its `base->running_timer !=
> >    timer` check is false, because of step (c).
> 
> If `base->running_timer != timer` then the timer ('s callback) is not
> currently active/ running. Therefore it can be removed from the timer
> bucket (in case it is pending in the future).
> If `base->running_timer == timer` then the timer ('s callback) is
> currently active. del_timer_sync() will loop in cpu_relax() until the
> callback finished. And then try again.
> > f) `stack.timer` gets freed / goes out of scope.
> > 
> > g) The callback scheduled from step (b) runs, and we have a UaF.
> > 
> > That's, anyway, what I understand Sultan to have pointed out to me. In
> > looking at this closely, though, to write this email, I noticed that
> > add_timer_on() does set TIMER_MIGRATING, which lock_timer_base() spins
> > on. So actually, maybe this scenario should be accounted for? Sultan, do
> > you care to comment here?
> 
> During TIMER_MIGRATING the del_timer_sync() caller will spin until the
> condition is over. So it can remove the timer from the right bucket and
> check if it is active vs the right bucket.

My concern stems from the design of add_timer_on(). Specifically, add_timer_on()
expects the timer to not already be pending or running.

Because of this, add_timer_on() doesn't check `base->running_timer` and doesn't
wait for the timer to finish running, because it expects the timer to be
completely idle. Giving add_timer_on() a timer which is already running is a
bug, as made clear by the `BUG_ON(timer_pending(timer) || !timer->function);`.

But since a timer is marked as not-pending prior to when it runs, add_timer_on()
can't detect if the timer is actively running; the above BUG_ON() won't be
tripped. So the UaF scenario I forsee is that doing this:
    add_timer_on(timer, 0);
    // timer is actively running on CPU0, timer is no longer pending
    add_timer_on(timer, 1); // changes timer base, won't wait for timer to stop
    del_timer_sync(timer); // only checks CPU1 timer base for the running timer

may result in the del_timer_sync() not waiting for the timer function to finish
running on CPU0 from the `add_timer_on(timer, 0);`, since add_timer_on() won't
wait for the timer function to finish running before changing the timer base.
And since Jason's timer is declared on the stack, his timer callback function
would dereference `stack.timer` after it's been freed.

> Sebastian

Sultan
