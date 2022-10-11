Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A25FB376
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJKNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJKNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:33:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7BE13D5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665495213; x=1697031213;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yu3qmwE7z5AN29MTBxAK8Vxbr09w0Sogy4HqWwAnwo=;
  b=myL05Rmj1SQrqUZX6gqNU4wK8nVs7pQP1u2S4isNGMVtu8RjUompvHXM
   8nN1K6HVP0wIreT1jUzOHtyGRTJ/54uhdsS3z6Tj+EEdiz/iF7YUmZjl2
   BiVPAkqBXQ6fdOxa+tEmdj/yRIVFPc1JPce2oIncnbzFv3l1Msx/OUxff
   mIa4biFH4H+QebZ5WyBxcfyLtOvBK9k+Bpm07Y2luPiDCnN8iNMwHH1BH
   FVBt3cKAJR8EbyitI0/Cuaq1BjDeJNZ604q2iUxtMwFs1sRDZAXhxn7DL
   +A/ijA/+qK3DEPSpP6laAWidLyuSM3oUKBJGAmL5g0fU7E1+4+rkQSQ6k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="305557097"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="305557097"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 06:33:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="657351677"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="657351677"
Received: from cdai2-mobl.ccr.corp.intel.com ([10.254.213.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 06:33:29 -0700
Message-ID: <aa5c745686127c5d1ff2496fcecc3ebf0839443c.camel@intel.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
From:   Zhang Rui <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Date:   Tue, 11 Oct 2022 21:33:26 +0800
In-Reply-To: <Y0Ugs/udnBh0Hv3C@hirez.programming.kicks-ass.net>
References: <20221009051209.393377-1-feng.tang@intel.com>
         <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
         <Y0N0ENurfliW315D@feng-clx>
         <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
         <Y0Ugs/udnBh0Hv3C@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-11 at 09:52 +0200, Peter Zijlstra wrote:
> On Mon, Oct 10, 2022 at 07:23:10AM -0700, Dave Hansen wrote:
> > On 10/9/22 18:23, Feng Tang wrote:
> > > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > > index cafacb2e58cc..b4ea79cb1d1a 100644
> > > > > --- a/arch/x86/kernel/tsc.c
> > > > > +++ b/arch/x86/kernel/tsc.c
> > > > > @@ -1217,7 +1217,7 @@ static void __init
> > > > > check_system_tsc_reliable(void)
> > > > >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > > > >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > > > >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > > > > -	    nr_online_nodes <= 2)
> > > > > +	    nr_online_nodes <= 8)
> > > > So you're saying all 8 socket systems since Broadwell (?) are
> > > > TSC
> > > > sync'ed ?
> > > No, I didn't mean that. I haven't got chance to any 8 sockets
> > > machine, and I got a report last month that on one 8S machine,
> > > the TSC was judged 'unstable' by HPET as watchdog.
> > 
> > That's not a great check.  Think about numa=fake=4U, for
> > instance.  Or a
> > single-socket system with persistent memory and high bandwidth
> > memory.
> > 
> > Basically 'nr_online_nodes' is a software construct.  It's going to
> > be
> > really hard to infer anything from it about what the _hardware_ is.
> 
> We have both c->phys_proc_id and c->logical_proc_id along with
> logical_packages.
> 
> I'm thinking you want something like max(c->phys_proc_id) <= 4.
> Because
> even if you only populate 4 sockets of an 8 socket server you're up a
> creek without no paddles.
> 
> But it all comes down to how much drugs the firmware teams have had
> :/
> It is entirely possible to enumerate with phys_proc_id==42 on a 2
> socket
> system.

topology_max_packages() or variable logical_packages can tell the
maximum packages.
But this check_system_tsc_reliable() is done in early boot phase where
we have boot cpu only. And the cpu topology is not built up at this
stage.

thanks,
rui

