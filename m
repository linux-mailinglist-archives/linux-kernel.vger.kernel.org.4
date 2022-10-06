Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B95F6642
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJFMlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJFMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:41:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791488E9B8;
        Thu,  6 Oct 2022 05:41:15 -0700 (PDT)
Date:   Thu, 6 Oct 2022 14:41:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665060073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MMPcKf9F1/2/vMYQPdhouNSSpWXHJ8lbaTT/pcZEL8=;
        b=B4jDCZe45EMiTYcRwUxKpJFXs+GVJcNEfl3cK+Vqnv3flta+Ciey7tUEaVX98drlabNwGt
        s2R0wIGEg9qvqDK5maqph1ChgESQ4yCCRBWE9r5GWBjxlrPVYFlJPwHQnL60p3xYzG/HcQ
        JaGfSs39F4kxKiTc8tXw160j56br2f8q9+zHRsLFEQ4ROh9EVsdGRWYuKsRfqQcXR8R6nF
        MnaQKGmg3GMGQ35QeRxmtzvs7TtY9jsxo76b3osu/KEzB0kd5uNu44CI2HPoNqE80oZyJ1
        ZhDQAt641axip/h4GBwlYTeichbuXW5gZsLXYlRXZlIk59eeHtJkRw42pugkYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665060073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MMPcKf9F1/2/vMYQPdhouNSSpWXHJ8lbaTT/pcZEL8=;
        b=0131keFlC/RIBFVE8ywl48xXejRD4/fVEA0gq9uJVZELDvY2AfHZa5t/1mfSHgAfWZGeoC
        epMyZYPAHK5Vs0Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz7M5zJmzKSk/LYH@linutronix.de>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
 <Yz55w4gNtZn8JzmG@linutronix.de>
 <Yz7JXEaTFWa1VLKJ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7JXEaTFWa1VLKJ@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-06 06:26:04 [-0600], Jason A. Donenfeld wrote:
> e) del_timer_sync() on line 5 is called, and its `base->running_timer !=
>    timer` check is false, because of step (c).

If `base->running_timer != timer` then the timer ('s callback) is not
currently active/ running. Therefore it can be removed from the timer
bucket (in case it is pending in the future).
If `base->running_timer == timer` then the timer ('s callback) is
currently active. del_timer_sync() will loop in cpu_relax() until the
callback finished. And then try again.

> f) `stack.timer` gets freed / goes out of scope.
> 
> g) The callback scheduled from step (b) runs, and we have a UaF.
> 
> That's, anyway, what I understand Sultan to have pointed out to me. In
> looking at this closely, though, to write this email, I noticed that
> add_timer_on() does set TIMER_MIGRATING, which lock_timer_base() spins
> on. So actually, maybe this scenario should be accounted for? Sultan, do
> you care to comment here?

During TIMER_MIGRATING the del_timer_sync() caller will spin until the
condition is over. So it can remove the timer from the right bucket and
check if it is active vs the right bucket.

> Jason

Sebastian
