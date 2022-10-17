Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B360106F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJQNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJQNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:47:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0652813
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:47:12 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y80so9061881iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tp5Hh6O/9A3srRlAZuCsYvFyaZFl+pX5X5HoG/4ElAU=;
        b=BkU5qF0dzUpUIC9KulmtP0BV02i/Hc+ZIukXmznU6DSFGPncHSk5xOwsfVBE12TSjy
         BP2RcKTW68QFdfFkoEMiYIh45Lnr0sNlqCMJNSceCwDypaKdo22u9xFM3kexofmLH/zg
         xq37h5vc/v60b2DbaTlJKTLBcbmcCkr0I1L40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tp5Hh6O/9A3srRlAZuCsYvFyaZFl+pX5X5HoG/4ElAU=;
        b=RoFP+1nq4mno02x40ZIhor95fWmcH/wqmKFcefJ2rhmJCWoxWhjVSS4NfaS+IgKR5+
         B4+/S7y+lgBbPP9s9hafBAF7tmHN6F9NH9r6xXUT1ARDAcZ0qKZQbKXaOaVmra5MhDeV
         YQ/2evzqvCnPTRQhR19RBsot9lzFLvhFeoeeUjuqpjBn4iL4QGBW8MZwgCLfthhKtFtD
         nIuW/Q72gtFVKxdJI/vCQwTIHB8l1Nuwk5JAImagUzdkb11M7s7Tk7I9dBsJ35KTnbGb
         LczqPv4rtBD4BSeYDG2WbH/Bcc5b01/Vvyu1P6DToLwPUC9CURvAzR6cBmFTNQ/NS7jq
         sthA==
X-Gm-Message-State: ACrzQf2fg0ruTHjXx4fTpN01NZ9C9muiIrgcwssw/9OrqbxvD3r7McRk
        00FQ9seLvGXI5bonmuL+I3iB6zmFXqDUwx54x+2O+w==
X-Google-Smtp-Source: AMsMyM47AVWwcAp7qkyKwstKtc+LVH7Vc9Mv6/Oad//okiRD3lriys+APzVwh5TYSft0aMfQYHPP0jnatDn0qJf/4EE=
X-Received: by 2002:a05:6638:408b:b0:364:768:e8c2 with SMTP id
 m11-20020a056638408b00b003640768e8c2mr5433037jam.107.1666014431529; Mon, 17
 Oct 2022 06:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221016162305.2489629-1-joel@joelfernandes.org> <20221017133738.GE5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221017133738.GE5600@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 17 Oct 2022 09:47:00 -0400
Message-ID: <CAEXW_YS8TkqX8acJESE54woR2adyiBOQq0ZRZKTLTqLGkkHPuQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] rcu: call_rcu() power improvements
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 9:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Oct 16, 2022 at 04:22:52PM +0000, Joel Fernandes (Google) wrote:
> > v9 version of RCU lazy patches based on rcu/next branch.
> >  Only change since v8 is this discussion:
> >  https://lore.kernel.org/rcu/20221011180142.2742289-1-joel@joelfernandes.org/T/#m8eff15110477f3430b3b02561b66f7b0d34a73b0
> >
> > To facilitate easier merge, I dropped tracing and other patches and just
> > implemented the new changes. I will post the tracing patches later along with
> > rcutop as I need to add new tracepoints that Frederic suggested.
> >
> > Main recent changes:
> > 1. rcu_barrier() wake up only for lazy bypass list.
> > 2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
> > 3. Take care of some callers using call_rcu_flush() API.
> > 4. Several refactorings suggested by Paul/Frederic.
> > 5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
> >
> > I am seeing good performance and power with these patches on real ChromeOS x86
> > asymmetric hardware.
> >
> > Earlier cover letter with lots of details is here:
> > https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/
> >
[...]
>
> Very good, thank you all!
>
> I have pulled these in for further review and testing.
>
> I am holding off on the last one ("rcu/debug: Add wake-up debugging for
> lazy callbacks") for the immediate future, but let's see how it goes.

Thanks! And nice timing with RCU just turning 20 years old ;-)

 - Joel




>
>                                                         Thanx, Paul
>
> > Frederic Weisbecker (1):
> > rcu: Fix missing nocb gp wake on rcu_barrier()
> >
> > Joel Fernandes (Google) (9):
> > rcu: Make call_rcu() lazy to save power
> > rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
> > rcuscale: Add laziness and kfree tests
> > percpu-refcount: Use call_rcu_flush() for atomic switch
> > rcu/sync: Use call_rcu_flush() instead of call_rcu
> > rcu/rcuscale: Use call_rcu_flush() for async reader test
> > rcu/rcutorture: Use call_rcu_flush() where needed
> > rxrpc: Use call_rcu_flush() instead of call_rcu()
> > rcu/debug: Add wake-up debugging for lazy callbacks
> >
> > Uladzislau Rezki (2):
> > scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
> > workqueue: Make queue_rcu_work() use call_rcu_flush()
> >
> > Vineeth Pillai (1):
> > rcu: shrinker for lazy rcu
> >
> > drivers/scsi/scsi_error.c |   2 +-
> > include/linux/rcupdate.h  |   7 ++
> > kernel/rcu/Kconfig        |  15 +++
> > kernel/rcu/lazy-debug.h   | 154 +++++++++++++++++++++++++++
> > kernel/rcu/rcu.h          |   8 ++
> > kernel/rcu/rcuscale.c     |  70 +++++++++++-
> > kernel/rcu/rcutorture.c   |  16 +--
> > kernel/rcu/sync.c         |   2 +-
> > kernel/rcu/tiny.c         |   2 +-
> > kernel/rcu/tree.c         | 149 ++++++++++++++++++--------
> > kernel/rcu/tree.h         |  12 ++-
> > kernel/rcu/tree_exp.h     |   2 +-
> > kernel/rcu/tree_nocb.h    | 217 ++++++++++++++++++++++++++++++++------
> > kernel/workqueue.c        |   2 +-
> > lib/percpu-refcount.c     |   3 +-
> > net/rxrpc/conn_object.c   |   2 +-
> > 16 files changed, 565 insertions(+), 98 deletions(-)
> > create mode 100644 kernel/rcu/lazy-debug.h
> >
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
