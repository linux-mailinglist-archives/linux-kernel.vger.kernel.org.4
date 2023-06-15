Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D67731377
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbjFOJUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbjFOJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:20:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE419B5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VJf8eYHVYCsVZWGj5WU5NKUE6RcPsFfWXduJSEsZwhw=; b=adNoPsIf3rftxigO9zc1H9H3bO
        Co9nWpcn9ca7+/d4bP/HGUKbaNYil5WVCj9XR/HD5i/q0y8r66zISHqUvqSakM/7JUn+kAkNUytJl
        0NsbFm7M1ysAYE0qoM0bcIjnMfAhFwvO5B93fsrYdt2wY9w1rfv2ibOKh9epStSQv9piUOyWRU5rx
        QGsBrSHjoZvjXT/YxiHn9n7kfwKqWrMsL0oy5BWCSmibK9q5XTMgwDPU/mBiqqW+msuxbNiQe8NVW
        mS5u6bo1G6eCE1sWmD02QTlw8IdbwP7IilA2X0Dr1yDyXa2b/BXPB6EhjR74CFQh+93fOneV4P6mk
        dp9hxO/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9j9T-007R8Y-2J; Thu, 15 Jun 2023 09:20:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78B6F3002A9;
        Thu, 15 Jun 2023 11:20:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DDA3265FBBD4; Thu, 15 Jun 2023 11:20:21 +0200 (CEST)
Date:   Thu, 15 Jun 2023 11:20:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052523.1106821-2-feng.tang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:25:23PM +0800, Feng Tang wrote:
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduced to solve problem that
> sometimes TSC clocksource is wrongly judged as unstable by watchdog
> like 'jiffies', HPET, etc.
> 
> In it, the hardware socket number is a key factor for judging whether
> to disable the watchdog for TSC, and 'nr_online_nodes' was chosen as
> an estimation due to it is needed in early boot phase before
> registering 'tsc-early' clocksource, where all none-boot CPUs are not
> brought up yet.
> 
> In recent patch review, Dave and Rui pointed out there are many cases
> in which 'nr_online_nodes' is not accurate, like:
> 
> * numa emulation (numa=fake=4 etc.)
> * numa=off
> * platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
> * SNC (sub-numa cluster) mode enabled
> * 'nr_cpus=' and 'maxcpus=' kernel cmdline parameter setup
> 
> Peter Zijlstra suggested 'logical_packages', and it seems to be the
> best option we have as it covers all the cases above except the
> last one. But it is only usable after smp_init() and all CPUs are
> brought up, while 'tsc-early' is initialized before that.
> 
> One solution is to skip the watchdog for 'tsc-early' clocksource,
> and move the check after smp_init(), while before 'tsc' clocksource
> is registered, where 'logical_packages' could be used.
> 
> For 'nr_cpus' and 'maxcpus' cmdline case, the global flag
> 'package_count_unreliable' will be set to true and the watchdog
> will be kept as is.

So I have at least two machines where I boot with 'possible_cpus=#'
because the BIOS MADT is reporting a stupid number of CPUs that aren't
actually there.

So I think I'm lucky and side-stepped this nonsense, but if someone were
to use nr_cpus= for this same purpose, they get screwed over and get the
watchdog. Sad day for them I suppose.

I realize there might not be a perfect solution, but I'm also struggling
to see the value of the whole package_count_unreliable thing.
