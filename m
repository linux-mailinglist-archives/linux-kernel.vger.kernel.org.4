Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A984641CCE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLDMFW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Dec 2022 07:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLDMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 07:05:19 -0500
X-Greylist: delayed 915 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Dec 2022 04:05:17 PST
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34519175A8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 04:05:16 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wyes.karny@amd.com" <wyes.karny@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH][RFC] x86: override prefer_mwait_c1_over_halt to avoid
 loading cpuidle-haltpoll driver
Thread-Topic: [PATCH][RFC] x86: override prefer_mwait_c1_over_halt to avoid
 loading cpuidle-haltpoll driver
Thread-Index: AQHZBn6jYStMiLz0YUyj1x+4POZvoq5dmZ8g
Date:   Sun, 4 Dec 2022 11:31:27 +0000
Message-ID: <aaac1d016a32407e9c1300283a60664f@baidu.com>
References: <1669952252-32710-1-git-send-email-lirongqing@baidu.com>
 <87fsdxprpr.ffs@tglx>
In-Reply-To: <87fsdxprpr.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.117.44]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2022-12-04 19:31:27:660
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.38
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
> Sent: Saturday, December 3, 2022 2:48 AM
> To: Li,Rongqing <lirongqing@baidu.com>; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; peterz@infradead.org;
> tony.luck@intel.com; wyes.karny@amd.com; linux-kernel@vger.kernel.org;
> rafael.j.wysocki@intel.com
> Subject: Re: [PATCH][RFC] x86: override prefer_mwait_c1_over_halt to avoid
> loading cpuidle-haltpoll driver
> 
> Li!
> 
> On Fri, Dec 02 2022 at 11:37, lirongqing@baidu.com wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> >
> > x86 KVM guests with MWAIT can load cpuidle-haltpoll driver, and will
> > cause performance degradation, so override prefer_mwait_c1_over_halt
> > to a new value, aviod loading cpuidle-haltpoll driver
> 
> Neither the subject line nor the above makes any sense to me.
> 
> prefer_mwait_c1_over_halt() is a function which is invoked and when it returns
> true then the execution ends up in the code path you are patching.
> 
> > @@ -889,6 +889,7 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
> >  	} else if (prefer_mwait_c1_over_halt(c)) {
> >  		pr_info("using mwait in idle threads\n");
> >  		x86_idle = mwait_idle;
> > +		boot_option_idle_override = IDLE_PREF_MWAIT;
> 
> What you do is setting boot_option_idle_override to a new value, but that has
> nothing to do with prefer_mwait_c1_over_halt() at all.
> 
> So how are you overriding that function to a new value?
> 
> But that's just a word smithing problem.
> 
> The real and way worse problem is that you pick a variable, which has the
> purpose to capture the idle override on the kernel command line, and modify it
> as you see fit, just to prevent that driver from loading.
> 
> select_idle_routine() reads it to check whether there was a command line
> override or not. But it is not supposed to write it. Why?
> 
> Have you checked what else evaluates that variable? Obviously not, because a
> simple grep would have told you:
> 
> drivers/cpuidle/cpuidle-haltpoll.c:     if (boot_option_idle_override !=
> IDLE_NO_OVERRIDE)
> drivers/idle/intel_idle.c:      if (boot_option_idle_override !=
> IDLE_NO_OVERRIDE)
> 
> Congratulations!
> 
> Your patch breaks the default setup of every recent Intel system on the planet
> because it not only prevents the cpuidle-haltpoll, but also the intel_idle driver
> from loading.
> 
> Seriously. It's not too much asked to do at least a simple grep and look at all
> _nine_ places which evaluate boot_option_idle_override.
> 

Sorry for the careless

Thanks for the review, I will send a new version, which export a function to tell haltpoll driver whether or not mwait is used, like below


diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73..159ef33 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -862,4 +862,6 @@ bool arch_is_platform_page(u64 paddr);
 #define arch_is_platform_page arch_is_platform_page
 #endif

+bool is_mwait_idle(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c21b734..330972c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -896,6 +896,12 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
                x86_idle = default_idle;
 }

+bool is_mwait_idle(void)
+{
+       return x86_idle == mwait_idle;
+}
+EXPORT_SYMBOL_GPL(is_mwait_idle);
+
 void amd_e400_c1e_apic_setup(void)
 {
        if (boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 3a39a7f..8cf1ddf 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -17,6 +17,7 @@
 #include <linux/sched/idle.h>
 #include <linux/kvm_para.h>
 #include <linux/cpuidle_haltpoll.h>
+#include <linux/processor.h>

 static bool force __read_mostly;
 module_param(force, bool, 0444);
@@ -111,6 +112,9 @@ static int __init haltpoll_init(void)
        if (!kvm_para_available() || !haltpoll_want())
                return -ENODEV;

+       if (is_mwait_idle())
+               return -ENODEV;
+
        cpuidle_poll_state_init(drv);

        ret = cpuidle_register_driver(drv);



Thanks

-Li
