Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0555FADD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJKHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJKHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:52:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853F89CE9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p5u8i9zTRRNLIolI+IkATTCyNCue1jMsbdlNvIHMfHI=; b=QPLMYOZHba/KAgbawU8wrdm/AD
        O1ktBHTcIQfeEjGrxJXTCCOfz8l8br0GrJoaDKB+HmmyCPlKfgfG9Xc800t3yGMGJKzY/TabYG7WU
        vxVLmSStNRZVCDIzqtauielfoZaSa3OpOAbYE0yhgaMulUgbvkaKPWSiMjRnSDDl/upQWs96hL6Ta
        0LmopxOhLK6NyCvfrZs7GJwnulX9PAXJrUNVFaZjY6NAsTy+ZtUGXGr2TWVAJfE+lcOSDlk0fv/MG
        I7orGrqq16AMGwKKExeR9P8cBIZrlJc0YF5fXSYOPQYupOxavRAR5aqbu/GzjiAdaq9sTCQKMbFUu
        Be9Q+o+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiA3o-002WRT-A8; Tue, 11 Oct 2022 07:52:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98BDB300445;
        Tue, 11 Oct 2022 09:52:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B96320D7E1AB; Tue, 11 Oct 2022 09:52:19 +0200 (CEST)
Date:   Tue, 11 Oct 2022 09:52:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0Ugs/udnBh0Hv3C@hirez.programming.kicks-ass.net>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:23:10AM -0700, Dave Hansen wrote:
> On 10/9/22 18:23, Feng Tang wrote:
> >>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> >>> index cafacb2e58cc..b4ea79cb1d1a 100644
> >>> --- a/arch/x86/kernel/tsc.c
> >>> +++ b/arch/x86/kernel/tsc.c
> >>> @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> >>>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >>>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >>>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> >>> -	    nr_online_nodes <= 2)
> >>> +	    nr_online_nodes <= 8)
> >> So you're saying all 8 socket systems since Broadwell (?) are TSC
> >> sync'ed ?
> > No, I didn't mean that. I haven't got chance to any 8 sockets
> > machine, and I got a report last month that on one 8S machine,
> > the TSC was judged 'unstable' by HPET as watchdog.
> 
> That's not a great check.  Think about numa=fake=4U, for instance.  Or a
> single-socket system with persistent memory and high bandwidth memory.
> 
> Basically 'nr_online_nodes' is a software construct.  It's going to be
> really hard to infer anything from it about what the _hardware_ is.

We have both c->phys_proc_id and c->logical_proc_id along with
logical_packages.

I'm thinking you want something like max(c->phys_proc_id) <= 4. Because
even if you only populate 4 sockets of an 8 socket server you're up a
creek without no paddles.

But it all comes down to how much drugs the firmware teams have had :/
It is entirely possible to enumerate with phys_proc_id==42 on a 2 socket
system.
