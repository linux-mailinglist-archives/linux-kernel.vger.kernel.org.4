Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E246BC3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCPCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCPCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:15:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADBAFF1B;
        Wed, 15 Mar 2023 19:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 072DFB81FA5;
        Thu, 16 Mar 2023 02:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589A4C433D2;
        Thu, 16 Mar 2023 02:15:30 +0000 (UTC)
Date:   Wed, 15 Mar 2023 22:15:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230315221528.22132c3c@gandalf.local.home>
In-Reply-To: <20230316012516.GK860405@mit.edu>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230315151415.2534e11c@gandalf.local.home>
        <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
        <ZBIbloFMm5xRsjfn@pc636>
        <20230315153448.6914f85b@gandalf.local.home>
        <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
        <20230315162840.106a5b4f@gandalf.local.home>
        <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
        <20230316012516.GK860405@mit.edu>
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

On Wed, 15 Mar 2023 21:25:16 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Wed, Mar 15, 2023 at 06:08:19PM -0400, Joel Fernandes wrote:
> > 
> > I am doubtful there may be a future where it does not sleep. Why?
> > Because you need an rcu_head *somewhere*.  
> 
> I think the real problem was that this won't sleep:
> 
>    kfree_rcu(ptr, rhf);
> 
> While this *could* sleep:
> 
>    kfree_rcu(ptr);
> 
> So the the original sin was to try to make the same mistake that C++
> did --- which is to think that it's good to have functions that have
> the same name but different function signatures, and in some cases,
> different semantic meanings because they have different implementations.
> 
> Personally, this is why I refuse to use C++ for any of my personal
> projects --- this kind of "magic" looks good, but it's a great way to
> potentially shoot yourself (or worse, your users) in the foot.
> 
> So separating out the two-argument kfree_rcu() from the one-argument
> kfree_rcu(), by renaming the latter to something else is IMHO, a
> Really F***** Good Idea.  So while, sure, kfree_rcu_mightsleep() might
> be a little awkward, the name documents the potential landmind
> involved with using that function, that's a good thing.  Because do
> you really think users will always conscientiously check the
> documentation and/or the implementation before using the interface?  :-)

I agree with everything you said above, and feel that having the same name
with two different semantics was not a good way to go. Not to mention, I
avoid C++ for basically the same reasons (plus others).

> 
> If you hate that name, one other possibility is to try to use the
> two-argument form kfree_rcu() and arrange to *have* a rcu_head in the
> structure.  That's going to be better from a performance perspective,
> and thus kinder to the end user than using rcu_synchronize().

Which is the what I last suggested doing.

  https://lore.kernel.org/all/20230315183648.5164af0f@gandalf.local.home/

-- Steve
