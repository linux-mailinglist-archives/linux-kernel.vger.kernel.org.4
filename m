Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD2616A94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKBRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKBRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:24:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F217275F8;
        Wed,  2 Nov 2022 10:24:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so29402145lfk.0;
        Wed, 02 Nov 2022 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VY5slvT3+MXfQbgGek2mDVAHXRD9O8PZiUJl8aEKBQ=;
        b=BtUy3YYaQZUZ8j+aU/PZrSY7FuREOAoLTBcbU4nnIslJ7/oW5UYCH9fZykG+5tY2x5
         AH180dapNtA9unK5SmzIXEFyPUoTVHdvA0pqe8wsC4jLV5z6aVZd77/LXrX1c/68IC2R
         zzyssjzJwiom33cR6+RO8Dk+6l7ewC4xbE0WJAuqjbgkBSaphZK/jEQNgOu05UBntCVa
         CCfsG8W8D1oXEiGSlY/Pg2k6p8cj210g5ljFFg5AWa6OIJLXZYu6/roHk7Vrol2yCYE6
         m9ek7sAj0JkOM5P9hY/Nl667WdKBwZeRshYKZbrBZybJaRpgKqnBVkPHYrF43Wu6X4nb
         qqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VY5slvT3+MXfQbgGek2mDVAHXRD9O8PZiUJl8aEKBQ=;
        b=1oS0Yq564CNmdgHV27KB1ShjY7V8oCve9jm5a45lbopiBGRdZtUQWcwz6hvCYiBSWw
         rcZkCgI/8iE4KZgzirov007VGz4hyzPN95p3bPuflYFs6cxHBdVpDOOUrusAnnDP49XZ
         Dh16C4xM9gE0qOqHt7F3llRhgtzVAQZr0i7cxkFfpZcZsYSSiBahwaadIo/oiqzY9RpS
         cBvWXTStfl5FKJ1AjW4gBWSyF+69RCcIKpQTNziMvEoRBF9oHLJtvNbCsSiyUAB63God
         eb7OTW22qYAaJ7pSM2xJi3VfPlisiSGNf8paDZBfLNWgn9U03JTwMeyUXx2yMMlyPrea
         4kcQ==
X-Gm-Message-State: ACrzQf1fCeGcaZHnenvVVMTECRPGy3m30rJYytPLBvJbJq8Iu/At9CzZ
        tvKd/V1AzipYiw9eweKStZc=
X-Google-Smtp-Source: AMsMyM7yUtEFd9+0XoWhkDmxq5IR1b4of9yd3tsyWIvEPXrur8HUQprAXK0tPyckqvXmHJ5zD00TJw==
X-Received: by 2002:a19:7009:0:b0:4b1:11a3:789e with SMTP id h9-20020a197009000000b004b111a3789emr3463790lfc.39.1667409863217;
        Wed, 02 Nov 2022 10:24:23 -0700 (PDT)
Received: from pc636 (host-90-235-23-76.mobileonline.telia.com. [90.235.23.76])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b004a03fd4476esm2070991lfz.287.2022.11.02.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:24:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 2 Nov 2022 18:24:20 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2KnxKDebPKiqTFZ@pc636>
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636>
 <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
 <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:35:44AM -0700, Paul E. McKenney wrote:
> On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
> > On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> > > > On ChromeOS, I am (almost) always seeing the optimization trigger.
> > > > Tested boot up and trace_printk'ing how often it triggers.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 591187b6352e..3e4c50b9fd33 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > >
> > > >  /**
> > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > > > + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
> > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > > > @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > >       raw_spinlock_t lock;
> > > >       struct delayed_work monitor_work;
> > > > +     struct rcu_data *rdp;
> > > > +     unsigned long last_gp_seq;
> > > >       bool initialized;
> > > >       int count;
> > > >
> > > > @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> > > >                       mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > >               return;
> > > >       }
> > > > +     krcp->last_gp_seq = krcp->rdp->gp_seq;
> > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > >  }
> > > >
> > > > @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > >                       // be that the work is in the pending state when
> > > >                       // channels have been detached following by each
> > > >                       // other.
> > > > -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > > > +                     //
> > > > +                     // NOTE about gp_seq wrap: In case of gp_seq overflow,
> > > > +                     // it is possible for rdp->gp_seq to be less than
> > > > +                     // krcp->last_gp_seq even though a GP might be over. In
> > > > +                     // this rare case, we would just have one extra GP.
> > > > +                     if (krcp->last_gp_seq &&
> > > >
> > > This check can be eliminated i think. A kfree_rcu_cpu is defined as
> > > static so by default the last_gp_set is set to zero.
> > 
> > Ack.
> > 
> > > > @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
> > > >       for_each_possible_cpu(cpu) {
> > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > >
> > > > +             krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > +             krcp->last_gp_seq = 0;
> > > >
> > > Yep. This one can be just dropped.
> > >
> > > But all the rest looks good :) I will give it a try from test point of
> > > view. It is interested from the memory footprint point of view.
> > 
> > Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it
> > is still worth a test.
> 
> Just for completeness, the main purpose of rdp->gp_seq is to reject
> quiescent states that were seen during already-completed grace periods.
> 
So it means that instead of gp_seq reading we should take a snaphshot
of the current state:

snp = get_state_synchronize_rcu();

and later on do a:

cond_synchronize_rcu(snp);

to wait for a GP. Or if the poll_state_synchronize_rcu(oldstate)) != 0
queue_rcu_work().

Sorry for a description using the RCU API functions name :) 

--
Uladzislau Rezki
