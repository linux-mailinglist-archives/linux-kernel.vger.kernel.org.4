Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E76629B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiKOOGB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 09:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiKOOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:05:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052F2A409
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:05:42 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBSZD1GSmz6H74v;
        Tue, 15 Nov 2022 22:03:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 15:05:39 +0100
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 14:05:39 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.031;
 Tue, 15 Nov 2022 14:05:39 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Thread-Topic: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Thread-Index: AQHY+E4/7Sf4Z7j0EUaRPuQVW9Z9Y64/rrBw
Date:   Tue, 15 Nov 2022 14:05:39 +0000
Message-ID: <1453ec4a0b7549009eff21d899053c50@huawei.com>
References: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
In-Reply-To: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.150.120]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




	
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> Sent: Monday, November 14, 2022 6:26 PM

Hi Alan,
thanks for preparing this!

> Jonas has pointed out a weakness in the Linux Kernel Memory Model.
> Namely, the memory ordering properties of atomic operations are not
> monotonic: An atomic op with full-barrier semantics does not always provide ordering as strong as one with release-barrier semantics.

Note that I believe it was Viktor who originally pointed out this weakness to me
in private communication. My contribution (besides chatting with you) is to
check that the solution does indeed restore the monotonicity (not just on some
litmus tests but in general).

So I would change the wording to "Viktor has pointed out a weakness in the Linux
Kernel Memory Model."


> +let rmw-sequence = (rf ; rmw)*

I would perhaps suggest to only consider external read-from in rmw-sequences, as
below:
+let rmw-sequence = (rfe ; rmw)*

The reason I (slightly) prefer this is that this is sufficient to imply
monotonicity.
Also there is some minor concern that the patch that results in the stricter
model (i.e., rmw-sequence = (rf ; rmw)*) might be incorrect on some hypothetical
future architecture in which RMWs can be merged in the store coalescing queue
with earlier stores to the same location. This is exemplified in the following
litmus test:

C atomics-not-monotonic-2

{}

P0(int *x, atomic_t *y)
{
    int r1;
	WRITE_ONCE(*x, 1);
	smp_store_release(y, 0);
	r1 = atomic_inc_return_relaxed(y);
}

P1(atomic_t *y)
{
	int r1;

	r1 = atomic_inc_return(y);
}

P2(int *x, atomic_t *y)
{
	int r2;
	int r3;

	r2 = atomic_read(y);
	smp_rmb();
	r3 = READ_ONCE(*x);
}

exists (2:r2=2 /\ 2:r3=0)

Here such a hypothetical future architecture could merge the operations to *y by
P0 into a single store, effectively turning the code of P0 into

P0(int *x, atomic_t *y)
{
    int r1;
	WRITE_ONCE(*x, 1);
	WRITE_ONCE(*y, 1);
	r1 = 0;
}

The stricter patch would not be sound with this hypothetical architecture, while
the more relaxed patch should be.

I don't think such a future architecture is likely since I don't expect there to
be any practical performance impact. At the same time I also don't currently see
any advantage of the stricter model.

For this reason I would slightly prefer the more relaxed model.



> +Rmw sequences have a special property in the LKMM: They can extend the 
> +cumul-fence relation.  That is, if we have:
> +
> +	U ->cumul-fence X -> rmw-sequence Y
> +
> +then also U ->cumul-fence Y.  Thinking about this in terms of the 
> +operational model, U ->cumul-fence X says that the store U propagates 
> +to each CPU before the store X does.  Then the fact that X and Y are 
> +linked by an rmw sequence means that U also propagates to each CPU 
> +before Y does.
> +

Here I would add that the rmw sequences also play a similar role in the
w-post-bounded relation. For example as follows:

+Rmw sequences have a special property in the LKMM: They can extend the 
+cumul-fence and w-post-bounded relations.  That is, if we have:
+
+	U ->cumul-fence X -> rmw-sequence Y
+
+then also U ->cumul-fence Y, and analogously if we have
+
+	U ->w-post-bounded X -> rmw-sequence Y
+
+then also U ->w-post-bounded Y. Thinking about this in terms of the 
+operational model, U ->cumul-fence X says that the store U propagates 
+to each CPU before the store X does.  Then the fact that X and Y are 
+linked by an rmw sequence means that U also propagates to each CPU 
+before Y does.
+


Best wishes,
jonas
