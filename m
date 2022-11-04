Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE05619A32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiKDOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiKDOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:38:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD30303F4;
        Fri,  4 Nov 2022 07:36:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d26so13729845eje.10;
        Fri, 04 Nov 2022 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbI2QD5UMs4NHXnChO3Yb2pwO6s4X4JcbZn2M8Fkfew=;
        b=gNwZsJ71w0WB1ijO8qhTbMDr93hj8/oIvBBZt/r+dWTQ1sBXrm/MCVGHjmP73KNqpu
         M5qC52KxXbcq0TvzYo+/wSqhtDVCTFCawJs5RxCqjP2eKimkH+7vHCmgiA/WOQKL16QR
         6Xx+PzNh3faR2kJseRA4I7ElYnCIps+kvJ6PAsNvKqK0X+I40AsHz4YtKVxqI6ijYOde
         HDCw5eEz5CswnalwzsfUxYDqsDCQY0Oi3+5WmIUI4DpHW0xA2z4C4FXbWUhKw6bUHieM
         Avo1JxIrwkhZ9JwNOF/20Kr+NRrU6wqMX7z/HuWpkJ+VGUvnaoCPEKSVrj464p8Oxz5Y
         n5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbI2QD5UMs4NHXnChO3Yb2pwO6s4X4JcbZn2M8Fkfew=;
        b=TtyM3uoUiCcOFqQQHwUaL3seRP+EpsWTFWH+VkJByHwSUwrCSI6COtej7wqe4bVpXt
         eIxJfu0KGL4jso6eaihqyPeEp0gUczAnT7hqz9gP2fJxZCZw8L8di1yGNBi7WweKrdfC
         kXywb19YLx9caCgUkLyqCzoaa7tzPHDjJu0DJKpiySTJiCneW9k17D1ttzRCId2XsfPF
         9bWR5Dpd45AfxLfXl0dkOYNN/TygA7tXwLz+/Ymov0vL2fahjoSdbDwINYR6x1JOWFFK
         W1rBJMEIewKTLrOBPXYnWqzZlhKjo0n2WNPHLUcPHJ4JOOrIe753s5iYbvs9ELN38Mqp
         Z0yA==
X-Gm-Message-State: ACrzQf2ZSQI/+2D5316eqX/L8LqVUiRMxwR7jLbxRWO3wPQxScoquDvx
        dc0pim06QX5rHYsqVhrwvf0=
X-Google-Smtp-Source: AMsMyM7P8lYkc7sPcBWqSE3zEBKP+RbMXkWMfPWimF8wBLwHVsl871neEyeuucrytYW7/9Rccz3z8A==
X-Received: by 2002:a17:907:6288:b0:78d:ab30:c374 with SMTP id nd8-20020a170907628800b0078dab30c374mr34859893ejc.266.1667572561249;
        Fri, 04 Nov 2022 07:36:01 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7db4a000000b00461621cae1fsm1982024edt.16.2022.11.04.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 4 Nov 2022 15:35:59 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2UjT4yuFvU5d6FU@pc638.lan>
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2O3Bz0DMEBZF+83@pc638.lan>
 <20221103175143.GB5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103175143.GB5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > This concern works in both cases. I mean in default configuration and
> > with a posted patch. The reclaim work, which name is kfree_rcu_work() only
> > does a progress when a gp is passed so the rcu_work_rcufn() can queue
> > our reclaim kworker.
> > 
> > As it is now:
> > 
> > 1. Collect pointers, then we decide to drop them we queue the
> >    monitro_work() worker to the system_wq.
> > 
> > 2. The monitor work, kfree_rcu_work(), tries to attach or saying
> > it by another words bypass a "backlog" to "free" channels.
> > 
> > 3. It invokes the queue_rcu_work() that does call_rcu_flush() and
> > in its turn it queues our worker from the handler. So the worker
> > is run after GP is passed.
> 
> So as it is now, we are not tying up a kworker kthread while waiting
> for the grace period, correct?  We instead have an RCU callback queued
> during that time, and the kworker kthread gets involved only after the
> grace period ends.
> 
Yes. The reclaim kworker is not kicked until a wrapper callback pushed
via queue_rcu_work() -> call_rcu_flush() is invoked by the nocb-kthread:

<snip>
static void rcu_work_rcufn(struct rcu_head *rcu)
{
...
	/* read the comment in __queue_work() */
	local_irq_disable();
	__queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
	local_irq_enable();
}

bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
{
...
	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
		rwork->wq = wq;
		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
..
<snip>

rcu_work_rcufn() callback runs our reclaim work after a full grace period.
There is not so good dependency. If it is number, say, 10 000 in the cblist
then we just wait for our time in a queue.

> > With a patch: 
> > 
> > [1] and [2] steps are the same. But on third step we do:
> > 
> > 1. Record the GP status for last in channel;
> > 2. Directly queue the drain work without any call_rcu() helpers;
> > 3. On the reclaim worker entry we check if GP is passed;
> > 4. If not it invokes synchronize_rcu().
> 
> And #4 changes that, by (sometimes) tying up a kworker kthread for the
> full grace period.
> 
Yes if GP is not passed we need to wait it anyway. Like this is done in
default case. call_rcu()'s callback waits for a full grace period also
and after that queues the work.

It is the same. But patched version can proceed reclaim right away if
"during the fly" the GP is passed. On my tests i see it is ~30-40% of
cases.

With a patch it also does not require go over RCU-core layer that is
definitely longer.

> > The patch eliminates extra steps by not going via RCU-core route
> > instead it directly invokes the reclaim worker where it either
> > proceed or wait a GP if needed.
> 
> I agree that the use of the polled API could be reducing delays, which
> is a good thing.  Just being my usual greedy self and asking "Why not
> both?", that is use queue_rcu_work() instead of synchronize_rcu() in
> conjunction with the polled APIs so as to avoid both the grace-period
> delay and the tying up of the kworker kthread.
> 
> Or am I missing something here?
> 
Looks like not :) 

1.
I was thinking about tracking a GP status for set of objects. With last
in one we need to keep it updated for the whole set. Such objects can be
freed faster, for example from monitor kworker. All other can go over
queue_rcu_work().

This is more complex design but probably could be better. It will require
split such chains for whom a GP is passed and not.

Please note there can be hidden problems and what i wrote might not be
easily applicable.

The patch i sent is an attempt to optimize it by not introducing the
big delta to current design.

2. 
call_rcu()
   -> queue_work();
          -> do reclaim

queue_work();
    -> synchronize_rcu() or not if passed, do reclaim

I can miss something though, why the latest is a bad way?

--
Uladzislau Rezki
