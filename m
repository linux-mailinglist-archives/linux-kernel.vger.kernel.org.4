Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C276BC344
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCPBZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:25:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8829E337
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:25:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32G1PGa1016681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 21:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678929920; bh=lRx3gB9ap1EU+d75/csSNwe0A4dHCtawrnOTXZn7ddo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Yu5uk0NjxrYfB58RIIejQd3EMkiasqodMOITziDE1FeTVU8jRs7h23i7+Qvo91Jtr
         fVcKVwYr1tPrl19o4jASSmXIRYyIobjzCwti0KOXfOIquDAXHBHcn8s3MKb2eBVYzx
         3gQK6PeBn0fCUHRp2lY4lX6WVyMHlp/xLirlls5yEYhx0e8/mYGpiBPdYypYT/pdd6
         5XFUEfmKJGZeScfWOcBTiCUcCXLLw0u0cxpDSZ1+sg01vuKR148/uGeX+VdGVGC0SX
         QopNVdfBOIJfVYyP5HPjuQSb6/nyWC5L3LgqltGnDemb4uUrPMBMMky7JOxGGzpd7b
         wB0gOul3336RA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D2E4515C5830; Wed, 15 Mar 2023 21:25:16 -0400 (EDT)
Date:   Wed, 15 Mar 2023 21:25:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20230316012516.GK860405@mit.edu>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
 <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home>
 <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home>
 <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:08:19PM -0400, Joel Fernandes wrote:
> 
> I am doubtful there may be a future where it does not sleep. Why?
> Because you need an rcu_head *somewhere*.

I think the real problem was that this won't sleep:

   kfree_rcu(ptr, rhf);

While this *could* sleep:

   kfree_rcu(ptr);

So the the original sin was to try to make the same mistake that C++
did --- which is to think that it's good to have functions that have
the same name but different function signatures, and in some cases,
different semantic meanings because they have different implementations.

Personally, this is why I refuse to use C++ for any of my personal
projects --- this kind of "magic" looks good, but it's a great way to
potentially shoot yourself (or worse, your users) in the foot.

So separating out the two-argument kfree_rcu() from the one-argument
kfree_rcu(), by renaming the latter to something else is IMHO, a
Really F***** Good Idea.  So while, sure, kfree_rcu_mightsleep() might
be a little awkward, the name documents the potential landmind
involved with using that function, that's a good thing.  Because do
you really think users will always conscientiously check the
documentation and/or the implementation before using the interface?  :-)

If you hate that name, one other possibility is to try to use the
two-argument form kfree_rcu() and arrange to *have* a rcu_head in the
structure.  That's going to be better from a performance perspective,
and thus kinder to the end user than using rcu_synchronize().

Cheers,

					- Ted
