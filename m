Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B164167C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLCLrM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 3 Dec 2022 06:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 06:47:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1165C6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 03:47:09 -0800 (PST)
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NPSh92pgTz67KSc;
        Sat,  3 Dec 2022 19:46:33 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 3 Dec 2022 11:47:06 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Sat, 3 Dec 2022 11:47:06 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools: memory-model: Make plain accesses carry
 dependencies
Thread-Topic: [PATCH] tools: memory-model: Make plain accesses carry
 dependencies
Thread-Index: AQHZBX5i+O6kpX6hIUORQi0+nA93wa5ZMZeAgAAQIzCAADgrAIABE1xwgAB/RoCAAP9b8A==
Date:   Sat, 3 Dec 2022 11:47:06 +0000
Message-ID: <bcacee1a2ce84123a664d783d108050e@huawei.com>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
        <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
        <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
        <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
        <4905c14d2bc547a391d626416a20a2e9@huawei.com>
 <Y4pec7lfQHwmH4V/@rowland.harvard.edu>
In-Reply-To: <Y4pec7lfQHwmH4V/@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.214.59]
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



-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] 
Sent: Friday, December 2, 2022 9:22 PM

> > void *y[2];
> > void *x[2] = { (void*)&y[1], (void*)&y[0] };
> > 
> > P0() {
> >     void **t = (void**)(x[0]);

> Now t holds a pointer to y[1].

Unfortunately, this kind of inductive reasoning (arguing about what happens based on what happened "before") is not possible with memory models that allow OOTA; as you put it, one must allow for loads reading from stores that haven't happened yet.
One such store (I promise!(*)) is a store to x[0] which writes &x[1]. Let's consider the alternative universe where we read from this future store, so now t holds a pointer to x[1].

> >     *t = (void*)(t-1);

> And now y[1] holds a pointer to y[0].

In our alternative universe, x[1] now holds a pointer to x[0].


> > }
> > P1() {
> >     void **u = (void**)(x[1]);	

> Now u holds a pointer to y[0].

In our alternative universe, u holds the pointer to x[0] stored by P0().

> >     *u = (void*)(u+1);

> And now y[0] holds a pointer to y[1].

In our alternative universe, now x[0] holds a pointer to x[1]. Behold, the store I promised would happen!

> > }

> The contents of x[] never get changed, so there's no question about the values of t and u.

They might get changed, by the stores *t=... and *u=...

Have fun,
Jonas

(*= because this example is provided free of charge, there is no actual promise, to the extent permitted by applicable law)
