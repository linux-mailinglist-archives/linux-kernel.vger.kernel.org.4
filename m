Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38F6429C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiLENnd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 08:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLENm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:42:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6472707
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:42:48 -0800 (PST)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NQl6226FJz6H7WK;
        Mon,  5 Dec 2022 21:39:54 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 5 Dec 2022 13:42:46 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Mon, 5 Dec 2022 13:42:46 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Thread-Topic: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Thread-Index: AQHZBkwkjuVXrORfWke+OSARjbJ/o65a8RAAgAEcUfCAAHmXAIAAGa0AgAACuoCAAA15gIAAG60AgAAPKuCAAI3IAIAB2Mmw
Date:   Mon, 5 Dec 2022 13:42:46 +0000
Message-ID: <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
In-Reply-To: <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.222.55]
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

> Without it, I guess the rationale of this patch is "plain accesses shouldn't be weaker than registers" or "This (plain accesses don't provide dependencies) is too conservative", and these don't seem very strong without a bigger motivation behind it.

Good points, thanks.


-----Original Message-----
From: Boqun Feng [mailto:boqun.feng@gmail.com] 
Sent: Sunday, December 4, 2022 9:33 AM
>
>  a real world code usage that needs this fix

Note that in the standard C world, 'int a' (and even 'register int a') declares an object, i.e., a memory location that is accessed with plain accesses. In my opinion, that 'int a' is a "register" in herd7 is an implementation artifact that hides the current weakness addressed by this patch.
So if you would actually analyze pretty much any code that looks like

   int a = <some atomic load>
   if (a == ...) { <some atomic store> }

then under the standard interpretation of that code, a is a memory location, and there is (in current LKMM) no control dependency, and the code would be considered broken by LKMM.

Or in another view, whether something that is (provably) never accessed externally is to be considered a 'register' or a 'memory location' should be an implementation detail of the compiler etc. (with the possibility to freely do reg2mem/mem2reg), and not have any effect on the ordering guarantees.
Notably most tools (GenMC for sure and I think also Dat3M) use such compiler transformations (especially mem2reg) because they live under the assumption that it doesn't change anything, but of course with current LKMM that renders all of these tools unsound; if you would carefully avoid to do any such transformations, then these tools would also report bugs in a lot more linux code.




> Also I'm in the impression that people love to put READ_ONCE()/WRITE_ONCE() when they have some ordering issues (in real world or with LKMM). 

Note that this would require to do 

  int a;
  WRITE_ONCE(&a, <some_atomic_load>);
  if (READ_ONCE(&a) == ...) { <some_atomic_store>; }

to get a control dependency, and imho violate the point of relaxed marked accesses -- to point out where races are, but no (additional) ordering is required.

> Although I don't like this

I like this and I have forwarded Paul's email to some friends who like not to put relaxed marked/atomic accesses in their code "because it makes the code less readable". I completely disagree -- marking racy accesses makes the code more readable because it lets us know when something is subject to concurrent access, and modifying the logic may break code of other threads.

What I don't like is relying on dependencies in the first place, since they are hard to maintain -- some innocuous optimizations that people might want to do (like adding some read in front of a bunch of writes to see if they're really necessary) bypass the ordering imposed by the dependency. So I generally advise to use acq loads instead, unless there is a measurable performance impact. But that's a completely separate discussion...

> Besides, could you also explain a little bit why only "data;rfi" can be "carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's because there are special cases when compilers can figure out a condition being true or an address being constant therefore break the dependency

Oh, good question. A bit hard for me to write down the answer clearly (which some people will claim that I don't understand it well myself, but I beg to differ :) :( :) ).

In a nutshell, it's because  x ->data  [Plain]  ->rfi  y ->... z  fulfils the same role as storing something in a register and then using it in a subsequent computation; x ->ctrl y ->... z (and ->addr) don't. So it's not due to smart compilers, just the fact that the other two cases seem unrelated to the problem being solved, and including them might introduce some unsoundness (not that I have checked if they do).

Mathematically I imagine the computation graph between register accesses/computations r_1,...,r_n and memory accesses m_1,...m_k that has an unlabeled edge  m_i -> r_j when m_i loads some data that is an input to the access/computation r_j, similarly it has an unlabeled edge r_i -> r_j  when the result of r_i is used as an input of r_j, and finally r_i ->data/ctrl/addr m_j when the value computed by r_j is the address/data or affects the ctrl of m_j.  So for example, if 'int a' were to declare a register, then
    int a = READ_ONCE(&x);
    if (a == 5) { WRITE_ONCE(&y,5); }
would have something like (*) 4 events  (*= since I'm avoiding fully formalizing the graph model here I don't really define to which extent one splits up register reads, computations, etc., so I'll do it somewhat arbitrarily)
m_1 = READ_ONCE(&x)
r_1 = store the result of m_1 in a
r_2 = compare the content of a to 5
m_2 = WRITE_ONCE(&y, 5)

with the edges m_1 -> r_1 -> r_2 ->ctrl m_2

Then in the LKMM graph, we would have m_i ->ctrl m_j (or data or addr) iff there is a path m_i -> r_x1 -> ... -> r_xl ->ctrl m_j (or data or addr).
So in the example above, m_1 ->ctrl m_2.

Now what we would do is look at what happens if the compiler/a tool/me/whatever interprets 'int a' as a memory location. Instead of r_1 and r_2 from above, we would have something like

m_1 = READ_ONCE(&x)
r_3 = the result of m_1 (stored in a CPU register)
m_3 = a := the r_3 result
m_4 = load from a
r_4 = the result of m_4 (stored in a CPU register)
m_2 = WRITE_ONCE(&y, 5)

with m_1 -> r_3 ->data -> m_3  ->rfi  m_4 -> r_4 ->ctrl m_2
and hence
m_1 ->data m_3 ->rfi m_4 ->ctrl m_2

What the patch does is make sure that even under this interpretation, we still have 
m_1 ->ctrl m_2
Note that this ->data ->rfi applies in every case where something is considered a register is turned into a memory location, because those cases always introduce a store with a fixed address (that memory location) where the data is the current content of the register, which is then read (internally) at the next time that data is picked up. A store to register never becomes a ctrl or addr edge, hence they are not included in the patch.

Please let me know if this is convincing and clear. If so we could link to your e-mail and my response to provide context, without having to put a huge explanation into the commit message. If that's not desirable I can also think about how to compress this into a shorter explanation.

Best wishes,
Jonas

PS:

> sometimes I'm just slow to understand things ;-)

Well, welcome in the club :D
