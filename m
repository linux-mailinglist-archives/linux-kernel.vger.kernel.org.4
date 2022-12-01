Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0363F616
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLARVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Dec 2022 12:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLARVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:21:49 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF026AFCD6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:21:48 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNNCL5Bdsz67KPV;
        Fri,  2 Dec 2022 01:21:18 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 18:21:46 +0100
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 1 Dec 2022 17:21:46 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Thu, 1 Dec 2022 17:21:46 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
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
Thread-Index: AQHZBX5i+O6kpX6hIUORQi0+nA93wa5ZMZeAgAAQIzA=
Date:   Thu, 1 Dec 2022 17:21:45 +0000
Message-ID: <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
 <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
In-Reply-To: <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.158.83]
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

Thanks a lot for the helpful and detailed comments!
Three minor points before I send a new patch:

> even if W' or R' (or both!) is plain.	

The "is" sounds slightly weird to me in the sentence because the last part I read is 
"(or both!)", so I would slightly prefer "are" here.

> On the other hand, if you change the second "dependencies" to "ones" and "unmarked" to "plain", maybe the whole thing will fit on one line.

It fits even if I changed the second dependencies to "those" instead of "ones", i.e.,
(* Redefine dependencies to include those carried through plain accesses *)

which I would prefer.

> if you replaced the whole conditional with a simple
>	WRITE_ONCE(*y, *z2);
> then the litmus test would become an example of OOTA!

In my opinion it is already an example of OOTA, which I would define as an
   rfi | ctrl | addr | data | fence
cycle.

Let me know if you agree with these deviations from your suggestion
and have a great time,

jonas

PS: 
> When a colon is followed by a clause (as opposed to a list), it is customary to capitalize the first letter of that clause, just like we capitalize the first letter at the start of a sentence.

In German, we also capitalize after a colon; but my English teachers used to deduct many points throughout my adolescent life whenever I capitalized like that. I still remember some of that red ink with near perfect clarity. So I eventually really took it to heart and started pedantically not-capitalizing after every colon.
Now the only time it ever mattered in my adult life, I find that I should do it German Style (or, as I just learned, APA & AP Style).
I suppose life is that way sometimes.

have a lot of fun,
jonas
