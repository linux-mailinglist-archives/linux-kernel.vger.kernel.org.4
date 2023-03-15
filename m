Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7301A6BBFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCOW0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCOW0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B284968D5;
        Wed, 15 Mar 2023 15:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4E2861E91;
        Wed, 15 Mar 2023 22:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF29CC4339C;
        Wed, 15 Mar 2023 22:26:30 +0000 (UTC)
Date:   Wed, 15 Mar 2023 18:26:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230315182628.39329315@gandalf.local.home>
In-Reply-To: <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230315151415.2534e11c@gandalf.local.home>
        <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
        <ZBIbloFMm5xRsjfn@pc636>
        <20230315153448.6914f85b@gandalf.local.home>
        <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
        <20230315162840.106a5b4f@gandalf.local.home>
        <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 18:08:19 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> I am doubtful there may be a future where it does not sleep. Why?
> Because you need an rcu_head *somewhere*. Unlike with debubojects,
> which involves a lock-free per-CPU pool and a locked global pool, and
> has the liberty to shutdown if it runs out of objects -- in RCU code
> it doesn't have that liberty and it has to just keep working.  The
> kfree_rcu code does have pools of rcu_head as well, but that is not
> thought to be enough to prevent OOM when memory needs to be given
> back.  AFAIK -- the synchronize_rcu() in there is a last resort and
> undesirable (supposed to happen only when running out of
> objects/memory).

And everything you said above is still implementation, and the user of
kvfree_rcu() doesn't care.

The only thing different about the two cases is that one is headless.

> 
> Also "mightsleep" means just that -- *might*.  That covers the fact
> that sleeping may not happen ;-).

Yes, and even though you are doubtful of it not ever having a non-sleep
implementation, there is still a chance that there might be something
someday.

> 
> This is just my opinion and I will defer to Uladzislau, Paul and you
> on how to proceed. Another option is "cansleep" which has the same
> number of characters as headless. I don't believe expecting users to
> read comments is practical, since we did already have comments and
> there was a bug in the usage that triggered this whole series.

The point of "headless" is that is the rational for this version of
kvfree_rcu(). It doesn't have a head. That's an API name that users care
about.

Why not call it kvfree_rcu_alloc() ? It allocates right?

We have might_sleep() in lots of places. In fact, the default is things
might sleep. We don't need to call it out. That's what the might_sleep()
call is for. Usually it's the non sleep version that is special.

We could call the normal kvfree_rcu() "kvfree_rcu_inatomic()" ;-)

But I guess that would be a bigger change.

-- Steve
