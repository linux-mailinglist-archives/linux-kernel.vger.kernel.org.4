Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756F640C12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiLBRXy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiLBRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:23:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D3A47E8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:23:00 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NP0BB6vySz6885p;
        Sat,  3 Dec 2022 01:22:26 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 18:22:57 +0100
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 17:22:57 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Fri, 2 Dec 2022 17:22:57 +0000
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
Thread-Index: AQHZBX5i+O6kpX6hIUORQi0+nA93wa5ZMZeAgAAQIzCAADgrAIABE1xw
Date:   Fri, 2 Dec 2022 17:22:57 +0000
Message-ID: <4905c14d2bc547a391d626416a20a2e9@huawei.com>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
        <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
        <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
 <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
In-Reply-To: <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.158.0]
Content-Type: text/plain; charset="iso-8859-1"
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

Hi Alan,

-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] 
Sent: Thursday, December 1, 2022 9:21 PM


> > In my opinion it is already an example of OOTA, which I would define as an
> >    rfi | ctrl | addr | data | fence
> > cycle.

> That's not an unreasonable point of view (if you put rfe *rather than* rfi), 

I wanted to very explicitly add rfi, because the lack of consideration of rfi is partially the issue in these examples.
But in being preoccupied with doing so I forgot rfe, thanks for catching that --- the correct version should be 
    rfi | rfe | ctrl | addr | data | fence
modulo anything else I've forgotten.
	
> but to me OOTA suggests something more: a value arising as if by magic rather than as a result of a computation.  In your version of the litmus test there is WRITE_ONCE(*y, 1), so it's a little understandable that you could end up with 1 as the final values of x and y.  But in my version, no values get computed anywhere, so the final value of x and y might just as easily be 1 or 56789 -- it literally arises "out of thin air".

Maybe one can distinguish further between OOTA values (which are arbitrary, not-computed values) and more generally OOTA behaviors.

How do you feel about examples like the one below:

void *y[2];
void *x[2] = { (void*)&y[1], (void*)&y[0] };

P0() {
    void **t = (void**)(x[0]);
    *t = (void*)(t-1);
}
P1() {
    void **u = (void**)(x[1]);	
    *u = (void*)(u+1);
}

In this test case the locations x[0] and x[1] exist in the program and are accessed, but their addresses are never (explicitly) taken or stored anywhere.
Nevertheless t=&x[1] and u=&x[0] could happen in an appropriately weak memory model (if the data races make you unhappy, you can add relaxed atomic/marked accesses); but not arbitrary values --- if t is not &x[1], it must be &y[1].

To me, OOTA suggests simply that the computation can not happen "organically" in a step-by-step way, but can only pop into existence as a whole, "out of thin air" (unless one allows for very aggressive speculation and rollback).

In this context I always picture the famous Baron Münchhausen, who pulled himself from mire by his own hair. (Which is an obviously false story because gentlemen at that time were wearing wigs, and a wig could not possibly carry his weight...)

best wishes,
jonas
