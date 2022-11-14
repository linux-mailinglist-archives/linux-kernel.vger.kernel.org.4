Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9808627D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiKNMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKNMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:20:43 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3483222A0;
        Mon, 14 Nov 2022 04:20:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d20so12895033ljc.12;
        Mon, 14 Nov 2022 04:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbjuoRrIf4yoLtJPrfhCjpRfUTSXH41VEourASZkn8s=;
        b=Xpf3GvnjHi39RV0QhlmLV4yQfSnW6zSwPOneEsYhjx1wEbp5a7FVesMP1t6wPvJmFE
         kDgKulspLcq8BAm8DeAGhy4u+flrdJDGpBbWxYYSHXNhu9PhO4I7CXMgslryiD7iuKpe
         ryYYtRrL1HdCeD3WLoJj1w/rPQgbNVwc68Ly49cFKMOrXpgin2yCgB9TGyGb7aievrkT
         6J2xjPnb75z1NcV0Rvmw8dwj/Prw9Fag8nLDU5h2L9ot8nFUh2vPSkTW2x2maswdwIk4
         LWBrcxjQAz90xUqX7aq9aYizbEEJrUZRHrpj0+YGqp1ffNX0gKXQAxjJAUL+f+UPhRiK
         6zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbjuoRrIf4yoLtJPrfhCjpRfUTSXH41VEourASZkn8s=;
        b=pdutFUMM1T731gynn7FOEymB0/3GpbJZwCBD+ucMuFoFMlftXbE191RgojyX5yVxNE
         CHwVzxalFkLJI8noq1aB4jEUubMmZMsA7NB8dwMW+6IjAWmViSQLRNyMaUJMBbOXLyru
         +/3LVw5NCrlcGCuWzuFarHCdEJMg4qFQVOGtMJhZUDIAINVu3lN2soeCPD1+N7b/OSEb
         Xocfo4FZHhowgCi5SQAa67+r4cU2XrX2vNieyvXSZk0pZjxgITfblj9ES6U0OCD8rM47
         mPPfwjUlVziNXf87yA6AAo75sR+VD5QMw57yTLKHUEjFjJxa2RqEyuUEUv7WSdLJFqlf
         JjhQ==
X-Gm-Message-State: ANoB5pl2CmXOi+r85gecEqyJNnOf6KPS2GYbS4ZukOa2vM83xKv7DzQA
        Ml5MZHjZOpfN0kSdtKV/tOE=
X-Google-Smtp-Source: AA0mqf4833AUvChkJiWEpwTbUqxdkz6TLgKXEjTln2tusy7MpI9LMpfy5HfaOWW1q7fD8lO9YFNzdQ==
X-Received: by 2002:a2e:7219:0:b0:277:5e9d:508a with SMTP id n25-20020a2e7219000000b002775e9d508amr4309942ljc.191.1668428440816;
        Mon, 14 Nov 2022 04:20:40 -0800 (PST)
Received: from pc636 (host-90-235-0-38.mobileonline.telia.com. [90.235.0.38])
        by smtp.gmail.com with ESMTPSA id p21-20020a056512235500b00498fc3d4d15sm1809497lfu.190.2022.11.14.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 04:20:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 14 Nov 2022 13:20:33 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y3Iyka86FlUh9D1P@pc636>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
 <Y22ry4Q2OY2zovco@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y22ry4Q2OY2zovco@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > > Hi,
> > > 
> > > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > 
> > > > > On ChromeOS, using this with the increased timeout, we see that we
> > > > almost always
> > > > > never need to initiate a new grace period. Testing also shows this frees
> > > > large
> > > > > amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> > > > >
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > > v1->v2: Same logic but use polled grace periods instead of sampling
> > > > gp_seq.
> > > > >
> > > > >  kernel/rcu/tree.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 591187b6352e..ed41243f7a49 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > >
> > > > >  /**
> > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace
> > > > period
> > > > > + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor
> > > > work.
> > > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a
> > > > grace period
> > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a
> > > > grace period
> > > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > >       raw_spinlock_t lock;
> > > > >       struct delayed_work monitor_work;
> > > > > +     unsigned long gp_snap;
> > > > >       bool initialized;
> > > > >       int count;
> > > > >
> > > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu
> > > > *krcp)
> > > > >                       mod_delayed_work(system_wq, &krcp->monitor_work,
> > > > delay);
> > > > >               return;
> > > > >       }
> > > > > +     krcp->gp_snap = get_state_synchronize_rcu();
> > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > >  }
> > > > >
> > > > How do you guarantee a full grace period for objects which proceed
> > > > to be placed into an input stream that is not yet detached?
> > > 
> > > 
> > > Just replying from phone as I’m OOO today.
> > > 
> > > Hmm, so you’re saying that objects can be queued after the delayed work has
> > > been queued, but processed when the delayed work is run? I’m looking at
> > > this code after few years so I may have missed something.
> > > 
> > > That’s a good point and I think I missed that. I think your version did too
> > > but I’ll have to double check.
> > > 
> > > The fix then is to sample the clock for the latest object queued, not for
> > > when the delayed work is queued.
> > > 
> > The patch i sent gurantee it. Just in case see v2:
> 
> You are right and thank you! CBs can be queued while the monitor timer is in
> progress. So we need to sample unconditionally. I think my approach is still
> better since I take advantage of multiple seconds (I update snapshot on every
> CB queue monitor and sample in the monitor handler).
> 
> Whereas your patch is snapshotting before queuing the regular work and when
> the work is executed (This is a much shorter duration and I bet you would be
> blocking in cond_synchronize..() more often).
> 
There is a performance test that measures a taken time and memory
footprint, so you can do a quick comparison. A "rcutorture" can be
run with various parameters to figure out if a patch that is in question
makes any difference.

Usually i run it as:

<snip>
#! /usr/bin/env bash

LOOPS=10

for (( i=0; i<$LOOPS; i++ )); do
        tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
        --kconfig CONFIG_NR_CPUS=64 \
        --kconfig CONFIG_RCU_NOCB_CPU=y \
        --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
        --kconfig CONFIG_RCU_LAZY=n \
        --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
        echo "Done $i"
done
<snip>

just run it from your linux sandbox.

--
Uladzislau Rezki
