Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC246BBDF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCOU2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCOU2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:28:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7559D0;
        Wed, 15 Mar 2023 13:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B816AB81F15;
        Wed, 15 Mar 2023 20:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDE4C433D2;
        Wed, 15 Mar 2023 20:28:41 +0000 (UTC)
Date:   Wed, 15 Mar 2023 16:28:40 -0400
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
Message-ID: <20230315162840.106a5b4f@gandalf.local.home>
In-Reply-To: <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230315151415.2534e11c@gandalf.local.home>
        <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
        <ZBIbloFMm5xRsjfn@pc636>
        <20230315153448.6914f85b@gandalf.local.home>
        <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 15:57:02 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > I was going to suggest "kvfree_rcu_might_synchronize()" but that's just
> > getting ridiculous.  
> 
> No, synchronize() is incorrect. The code really can sleep for other
> reasons like memory allocation. It is not that simple of an
> implementation as one may imagine. mightsleep is really the correct
> wording IMHO.
> 
> > Still, I will replace that code back to a kfree() and rcu_synchonize() than
> > to let that other name get in.  
> 
> I think it is too late for that for now, we already have conversions
> going into the other subsystems, that means we'll have to redo all
> that over again (even if it sounded like a good idea, which it is
> not).
> 
> I would rather you just did: "#define kvfree_rcu_tracing
> #kvfree_rcu_mightsleep", or something like that, if it is really a
> problem. ;-)
> 
> Also you are really the first person I know of who has a problem with that name.

I guess you didn't read Jens's reply.

The main issue I have with this, is that "might_sleep" is just an
implementation issue. It has *nothing* to do with what the call is about.
It is only about freeing something with RCU. It has nothing to do with
sleeping. I don't use it because it might sleep. I use it to free something.

If you don't like kvfree_rcu_synchronization() then call it
kvfree_rcu_headless() and note that currently it can sleep. Because in
the future, if we come up with an implementation where we it doesn't sleep,
then we don't need to go and rename all the users in the future.

See where I have the problem with the name "might_sleep"?

-- Steve

