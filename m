Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8064531A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLGEjj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Dec 2022 23:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGEjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:39:37 -0500
X-Greylist: delayed 1896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 20:39:35 PST
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FD0456D73;
        Tue,  6 Dec 2022 20:39:35 -0800 (PST)
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
Thread-Index: AQHZCWttIym3Q6GeZEeVWIMC3IQoba5hyAuw
Date:   Wed, 7 Dec 2022 03:45:03 +0000
Message-ID: <bd15822f364145228de8ad83a38c9d26@baidu.com>
References: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
 <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
 <87mt80g2fp.ffs@tglx>
In-Reply-To: <87mt80g2fp.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.14]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2022-12-07 11:45:03:504
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.32
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
> Sent: Tuesday, December 6, 2022 8:08 PM
> To: Rafael J. Wysocki <rafael@kernel.org>; Li,Rongqing <lirongqing@baidu.com>
> Cc: mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> x86@kernel.org; rafael@kernel.org; daniel.lezcano@linaro.org;
> peterz@infradead.org; akpm@linux-foundation.org; tony.luck@intel.com;
> jpoimboe@kernel.org; linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: Re: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
> mwait_idle is used
> 
> On Tue, Dec 06 2022 at 12:59, Rafael J. Wysocki wrote:
> > On Tue, Dec 6, 2022 at 7:43 AM <lirongqing@baidu.com> wrote:
> >>
> >> +bool is_mwait_idle(void)
> >> +{
> >> +       return x86_idle == mwait_idle; }
> >> +EXPORT_SYMBOL_GPL(is_mwait_idle);
> 
> No, this is just another adhoc check, which scratches ONE particular itch.
> 
> >> @@ -111,6 +112,9 @@ static int __init haltpoll_init(void)
> >>         if (!kvm_para_available() || !haltpoll_want())
> >>                 return -ENODEV;
> >>
> >> +       if (is_mwait_idle())
> >> +               return -ENODEV;
> >> +
> >
> > So perhaps you could make default_enter_idle() be a bit more careful
> > about what it calls as the "default idle" routine?
> 
> Correct. arch_cpu_idle() is the one which should be called.
> 

Greats,  using arch_cpu_idle() can get best latency,

Before change, "sockperf ping-pong -i 127.0.0.1 -p 20001  --tcp " latency is:
sockperf: Summary: Latency is 6.245 usec

this patch, disable cpuidle-haltpoll
sockperf: Summary: Latency is 4.671 usec


using arch_cpu_idle() in default_enter_idle()
sockperf: Summary: Latency is 4.285 usec


thanks

-LiRongQing


> Thanks,
> 
>         tglx
