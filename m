Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5805EF98B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiI2Px6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiI2Pxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:53:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D41BEA4E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:53:17 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mdd7D5F2BzHtlg;
        Thu, 29 Sep 2022 23:48:24 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 23:53:13 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 23:53:12 +0800
Message-ID: <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
Date:   Thu, 29 Sep 2022 23:52:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
To:     Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        <len.brown@intel.com>, <wangxiongfeng2@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
 <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
 <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
 <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
Content-Language: en-US
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/2 15:28, Zhang Rui wrote:
> On Mon, 2020-11-30 at 20:21 +0100, Thomas Gleixner wrote:
>> Feng,
>>
>> On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
>>> On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
>>>> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
>>>> Yes, that can happen. But OTOH, we should start to think about
>>>> the
>>>> requirements for using the TSC watchdog.
> 
> My original proposal is to disable jiffies and refined-jiffies as the
> clocksource watchdog, because they are not reliable and it's better to
> use clocksource that has a hardware counter as watchdog, like the patch
> below, which I didn't sent out for upstream.
> 
>>From cf9ce0ecab8851a3745edcad92e072022af3dbd9 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 19 Jun 2020 22:03:23 +0800
> Subject: [RFC PATCH] time/clocksource: do not use refined-jiffies as watchdog
> 
> On IA platforms, if HPET is disabled, either via x86 early-quirks, or
> via kernel commandline, refined-jiffies will be used as clocksource
> watchdog in early boot phase, before acpi_pm timer registered.
> 
> This is not a problem if jiffies are accurate.
> But in some cases, for example, when serial console is enabled, it may
> take several milliseconds to write to the console, with irq disabled,
> frequently. Thus many ticks may become longer than it should be.
> 
> Using refined-jiffies as watchdog in this case breaks the system because
> a) duration calculated by refined-jiffies watchdog is always consistent
>    with the watchdog timeout issued using add_timer(), say, around 500ms.
> b) duration calculated by the running clocksource, usually TSC on IA
>    platforms, reflects the real time cost, which may be much larger.
> This results in the running clocksource being disabled erroneously.
> 
> This is reproduced on ICL because HPET is disabled in x86 early-quirks,
> and also reproduced on a KBL and a WHL platform when HPET is disabled
> via command line.
> 
> BTW, commit fd329f276eca
> ("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping") is
> another example that refined-jiffies causes the same problem when ticks
> become slow for some other reason.

Hi, Zhang Rui, we have met the same problem as you mentioned above. I have
tested the following modification. It can solve the problem. Do you have plan
to push it to upstream ?

Thanks,
Liao Yu

> 
> IMO, the right solution is to only use hardware clocksource as watchdog.
> Then even if ticks are slow, both the running clocksource and the watchdog
> returns real time cost, and they still match.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  kernel/time/clocksource.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 02441ead3c3b..e7e703858fa6 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -364,6 +364,10 @@ static void clocksource_select_watchdog(bool fallback)
>  		watchdog = NULL;
>  
>  	list_for_each_entry(cs, &clocksource_list, list) {
> +		/* Do not use refined-jiffies as clocksource watchdog */
> +		if (cs->rating <= 2)
> +			continue;
> +
>  		/* cs is a clocksource to be watched. */
>  		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY)
>  			continue;

