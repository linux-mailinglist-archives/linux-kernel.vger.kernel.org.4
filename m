Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45E6459B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLGMU7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 07:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:20:57 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E537239;
        Wed,  7 Dec 2022 04:20:54 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
Thread-Topic: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
Thread-Index: AQHZCWttIym3Q6GeZEeVWIMC3IQoba5hyAuwgABojSD//5gWAIAAj+OQ
Date:   Wed, 7 Dec 2022 12:18:54 +0000
Message-ID: <795f272e68734e52afbe45d876f08dde@baidu.com>
References: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
 <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
 <87mt80g2fp.ffs@tglx> <59bf331606fc4d68a8aa866c50c902be@baidu.com>
 <875yenfnkz.ffs@tglx>
In-Reply-To: <875yenfnkz.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, December 7, 2022 7:41 PM
> To: Li,Rongqing <lirongqing@baidu.com>; Rafael J. Wysocki <rafael@kernel.org>
> Cc: mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> x86@kernel.org; rafael@kernel.org; daniel.lezcano@linaro.org;
> peterz@infradead.org; akpm@linux-foundation.org; tony.luck@intel.com;
> jpoimboe@kernel.org; linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: RE: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
> mwait_idle is used
> 
> On Wed, Dec 07 2022 at 10:49, Rongqing Li wrote:
> >> Before change, "sockperf ping-pong -i 127.0.0.1 -p 20001  --tcp " latency is:
> >> sockperf: Summary: Latency is 6.245 usec
> >>
> >> this patch, disable cpuidle-haltpoll
> >> sockperf: Summary: Latency is 4.671 usec
> >>
> >>
> >> using arch_cpu_idle() in default_enter_idle()
> >> sockperf: Summary: Latency is 4.285 usec
> >>
> >
> > When I did upper tests, I taskset sockperf server and client to
> > different cpus, so using arch_cpu_idle() in default_enter_idle() gets
> > better result.
> >
> > I test unixbench also, find that Don't loading cpuidle-haltholl can
> > get more performance on 8 cores (2 threads per core) intel cpu which
> > cstate is disabled in host
> >
> > Don't load cpuidle-haltpoll:
> > System Benchmarks Index Score
> 1995.8
> > System Benchmarks Index Score
> 8482.8
> >
> > Replace default_idle with arch_cpu_idle, and load cpuidle-haltpoll, code like
> below:
> > System Benchmarks Index Score
> 1971.4
> > System Benchmarks Index Score
> 8467.7
> >
> > So I think we should not load cpuidle-haltpoll driver when guest has
> > mwait
> 
> So in the above you got:
> 
> Driver loaded not modified:     6.245
> Driver not loaded:              4.671           ~25%
> Driver loaded modified:         4.285           ~30%
> 
> Now with unixbench:
> 
> Driver not loaded:              8482.8
> Driver loaded modified:         8467.7          ~0.2%
> 
> So because of 0.2% delta you justify to throw away a 5% win?
> 
> If you really care about the 0.2%, then blacklist the module for your use case.
> 

Ok, Build it as module by default

Thanks

-Li



