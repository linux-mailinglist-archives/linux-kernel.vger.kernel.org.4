Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242445F612F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJFGqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJFGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:46:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0BD8A7DD;
        Wed,  5 Oct 2022 23:46:30 -0700 (PDT)
Date:   Thu, 6 Oct 2022 08:46:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665038788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EvcY12akHbBMuHyFiQ/dz49uFOmgCXQuCdnSEWvOeI=;
        b=tcjwFrkHdzvvH91jeJZS4dgO5lcvpV6GSFGLZuSGCERs7TtCblTyJvKN8M8b7ZL/tjzllY
        uT0DjCjjEJSHGXVCJnih0QhtMsey2NASLqUYpi/jJ4WCul5PHAEDEeVhsOYvqb7aQeUqRj
        okLJO8pce5TBfzC9OgfOpIsYKPaZFKk4himhP6vZSubo6rXphS2k/ohibwpD5Oapb/6ySW
        ExQURIzwkztQKTD4OIX4rmBjUeKYfiTIoET6dya4JJAamWSa4JQg/SxCMkk1tKhMz6p9Ya
        HP2N59cq+TLyh3qHprA6hcN6Q1pDSkB492XbXhDtNniFNnR7En//hvTuVH1s/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665038788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EvcY12akHbBMuHyFiQ/dz49uFOmgCXQuCdnSEWvOeI=;
        b=eDSz1xb5CBft1AXQc1oiUkwTchoAC6ZuGGcQiJxj/+7KyAtY9Ti47B+J4smGNgmJUOZ/jx
        i0WtJi0s5tmlCqDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz55w4gNtZn8JzmG@linutronix.de>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz3yQzaNUcdIuUMX@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-05 23:08:19 [+0200], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> On Wed, Oct 05, 2022 at 07:26:42PM +0200, Sebastian Andrzej Siewior wrote:
> > That del_timer_sync() at the end is what you want. If the timer is
> > pending (as in enqueued in the timer wheel) then it will be removed
> > before it is invoked. If the timer's callback is invoked then it will
> > spin until the callback is done.
> 
> del_timer_sync() is not guaranteed to succeed with add_timer_on() being
> used in conjunction with timer_pending() though. That's why I've
> abandoned this.

But why? The timer is added to a timer-base on a different CPU. Should
work.

> Jason

Sebastian
