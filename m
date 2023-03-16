Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092F76BC3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCPCXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCPCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:23:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67D1CF46;
        Wed, 15 Mar 2023 19:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B90ECB81FA4;
        Thu, 16 Mar 2023 02:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38822C4339C;
        Thu, 16 Mar 2023 02:23:25 +0000 (UTC)
Date:   Wed, 15 Mar 2023 22:23:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <20230315222323.7afe82e7@gandalf.local.home>
In-Reply-To: <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230201150815.409582-5-urezki@gmail.com>
        <ZAni8Q1NW9cWrvHJ@pc636>
        <20230315183648.5164af0f@gandalf.local.home>
        <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
        <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
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

On Wed, 15 Mar 2023 17:37:30 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> 
> That does work, and I am guessing that the size increase is not a big
> problem for you there.

Well, I was fine with it as long as it stayed in the headers, where
ugliness is warmly welcomed. Just ask all the #ifdefs.

> 
> > That's a cop out, just removing the one case you care about. Fact is
> > the naming is awful, and the 1/2 argument thing is making it worse.
> > If a big change is warranted, why not do it right and ACTUALLY
> > get it right?  
> 
> You both do realize that the kvfree_rcu_mightsleep() definition is
> already in mainline, right?
> 
> Anyway, to sum up, kvfree_rcu_mightsleep()--or whatever the entire
> community eventually decides to name it--can do any of the following:
> 
> 1.	Put the pointer into an already allocated array of pointers.
> 
> 2.	Allocate a new array of pointers, have the allocation succeed
> 	without sleeping, then put the pointer into an already allocated
> 	array of pointers.
> 
> 3.	Allocate a new array of pointers, have the allocation succeed
> 	after sleeping, then put the pointer into an already allocated
> 	array of pointers.
> 
> 4.	Attempt to allocate a new array of pointers, have the allocation
> 	fail (presumably after sleeping), then invoke synchronize_rcu()
> 	directly.
> 
> Too much fun!  ;-)
> 

  kvfree_rcu_kitchen_sink() ?

  kvfree_rcu_goldie_locks()?

I honestly like the name "headless" as that perfectly describes the
difference between kvfree_rcu(arg1, arg2) and kvfree_rcu(arg1).

Whereas mightsleep() is confusing to me because it doesn't tell me why
kvfree_rcu() has two args and kvfree_rcu_mightsleep() has only one.
Usually, code that has two sleep variants is about limiting the
functionality of the atomic friendly one.

-- Steve

