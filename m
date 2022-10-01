Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD45F19FE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 07:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJAFSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 01:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJAFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 01:18:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60539142519
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664601493; x=1696137493;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXpAGqoik6XPTiIt0anAVc/uvoqilMxahx1jChFkMq8=;
  b=jE47xOO8NXBGpQucOfVBevGs22UC6qNnT0ZyqNiCEsil49FHn3ahs2DQ
   5nGr0dZoPEIlr5uVc22NqEWQhP0rWDRkQet4QNQyj2zXuVmCQIlXnX1PG
   1tjvUH29YNWB9EIG+HX/9hoq+LwkmNtLHTtXBQeYduWf9JtEf6V/SkgUF
   pOYKngEZ2IZWaNPQXVgpEwPBeHJ35mMN2buxLDY20pFizXs7T4aFcjC0p
   2FdalUbbMQpbZhSFMSlNmvZEw7IaUoWpkN2JYBzGYVYNFWxdEcYAQEXvq
   P9QadiAwuWSg9jZM+x7MwkFXQs/oGNu5oczON2ZuV8UGh98efXitpME8Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="302319573"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="302319573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 22:18:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="600650760"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="600650760"
Received: from shantian-mobl.ccr.corp.intel.com ([10.254.208.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 22:18:08 -0700
Message-ID: <6491ee0f8d29d1498c79a91d712920ee96879b15.camel@intel.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
From:   Zhang Rui <rui.zhang@intel.com>
To:     Feng Tang <feng.tang@intel.com>, Yu Liao <liaoyu15@huawei.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        len.brown@intel.com, Xie XiuQi <xiexiuqi@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Date:   Sat, 01 Oct 2022 13:18:05 +0800
In-Reply-To: <YzbBOuX37XpUiP4y@feng-clx>
References: <20201126012421.GA92582@shbuild999.sh.intel.com>
         <87eekfk8bd.fsf@nanos.tec.linutronix.de>
         <20201127061131.GB105524@shbuild999.sh.intel.com>
         <87eekairc0.fsf@nanos.tec.linutronix.de>
         <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
         <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
         <YzY6e0UwDAyU1GrX@feng-clx>
         <44206484-620d-abaf-4fb9-fc4ef1c9184f@huawei.com>
         <YzZDLBKbDTbNr45b@feng-clx>
         <119b669e-aafb-4d73-e94e-ef119f909cfa@huawei.com>
         <YzbBOuX37XpUiP4y@feng-clx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-30 at 18:13 +0800, Feng Tang wrote:
> > 

> On Fri, Sep 30, 2022 at 05:45:29PM +0800, Yu Liao wrote:
> [...]
> > > > > > Hi, Zhang Rui, we have met the same problem as you
> > > > > > mentioned above. I have
> > > > > > tested the following modification. It can solve the
> > > > > > problem. Do you have plan
> > > > > > to push it to upstream ?
> > > > > 
> > > > > Hi Liao Yu,
> > > > > 
> > > > > Could you provoide more details? Like, what ARCH is the
> > > > > platform (x86
> > > > > or others), client or sever, if sever, how many sockets
> > > > > (2S/4S/8S)?
> > > > > 
> > > > > The error kernel log will also be helpful.
> > > > 
> > > > Hi, Feng Tang,
> > > > 
> > > > It's a X86 Sever. lscpu print the following information:
> > > > 
> > > > Architecture:                    x86_64
> > > > CPU op-mode(s):                  32-bit, 64-bit
> > > > Byte Order:                      Little Endian
> > > > Address sizes:                   46 bits physical, 48 bits
> > > > virtual
> > > > CPU(s):                          224
> > > > On-line CPU(s) list:             0-223
> > > > Thread(s) per core:              2
> > > > Core(s) per socket:              28
> > > > Socket(s):                       4
> > > > NUMA node(s):                    4
> > > > Vendor ID:                       GenuineIntel
> > > > CPU family:                      6
> > > > Model:                           85
> > > > Model name:                      Intel(R) Xeon(R) Platinum 8180
> > > > CPU @ 2.50GHz
> > > > Stepping:                        4
> > > > CPU MHz:                         3199.379
> > > > CPU max MHz:                     3800.0000
> > > > CPU min MHz:                     1000.0000
> > > > BogoMIPS:                        5000.00
> > > > Virtualization:                  VT-x
> > > > L1d cache:                       3.5 MiB
> > > > L1i cache:                       3.5 MiB
> > > > L2 cache:                        112 MiB
> > > > L3 cache:                        154 MiB
> > > > NUMA node0 CPU(s):               0-27,112-139
> > > > NUMA node1 CPU(s):               28-55,140-167
> > > > NUMA node2 CPU(s):               56-83,168-195
> > > > NUMA node3 CPU(s):               84-111,196-223
> > > > 
> > > > Part of the kernel log is as follows.
> > > > 
> > > > [    1.144402] smp: Brought up 4 nodes, 224 CPUs
> > > > [    1.144402] smpboot: Max logical packages: 4
> > > > [    1.144402] smpboot: Total of 224 processors activated
> > > > (1121097.93 BogoMIPS)
> > > > [    1.520003] clocksource: timekeeping watchdog on CPU2:
> > > > Marking clocksource
> > > > 'tsc-early' as unstable because the skew is too large:
> > > > [    1.520010] clocksource:                       'refined-
> > > > jiffies' wd_now:
> > > > fffb7210 wd_last: fffb7018 mask: ffffffff
> > > > [    1.520013] clocksource:                       'tsc-early'
> > > > cs_now:
> > > > 6606717afddd0 cs_last: 66065eff88ad4 mask: ffffffffffffffff
> > > > [    1.520015] tsc: Marking TSC unstable due to clocksource
> > > > watchdog
> > > > [    5.164635] node 0 initialised, 98233092 pages in 4013ms
> > > > [    5.209294] node 3 initialised, 98923232 pages in 4057ms
> > > > [    5.220001] node 2 initialised, 99054870 pages in 4068ms
> > > > [    5.222282] node 1 initialised, 99054870 pages in 4070ms
> > > 
> > > Thanks Xiaofeng for the info.
> > > 
> > > Could you try the below patch? It is kinda extension of 
> > > 
> > > b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC on
> > > qualified platorms") 
> > > 
> > > which I have run limited test on some 4 sockets Haswell and
> > > Cascadelake
> > > AP x86 servers.
> > > 
> > > 
> > > Thanks,
> > > Feng
> > > ---
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index cafacb2e58cc..b4ea79cb1d1a 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -1217,7 +1217,7 @@ static void __init
> > > check_system_tsc_reliable(void)
> > >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > > -	    nr_online_nodes <= 2)
> > > +	    nr_online_nodes <= 8)
> > >  		tsc_disable_clocksource_watchdog();
> > >  }
> > >  
> > > 
> > Hi Feng,
> > 
> > I tested this patch on a previous server and it fixes the issue.
>  
> Thanks for the testing, please do let us know if there is any TSC
> problem after long time or stress running.
> 
> Plan to send the patch for merging.
> 

Good to know.

This patch fixes the TSC issue for IA.
while the patch at 
https://lore.kernel.org/lkml/YzZDLBKbDTbNr45b@feng-clx/T/#m34094630193e8320c6d75e9c8aeabe7633e051d2
impacts more Arches but I'm not sure if similar problem is observed on
other Arches as well. So I will hold it for now.

thanks,
rui

