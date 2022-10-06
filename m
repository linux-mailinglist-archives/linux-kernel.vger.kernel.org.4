Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D05F6B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiJFQP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJFQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:15:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A57665266
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V4NVYpP1YT+fA8f3Wmd6Cn01Iw4hE5hXGGRmCJ0X+Bk=; b=OYY60UvKbC6oHUX+5davBO+wOd
        RiRGW+8WreSj1Y3SD9pnbCvf7vLMrXK1IdkTSw7dMP+NpS0GS46NuojRV5PhIEXTL0IKxMveuH5Z0
        F+ta/8hVH/yEDACEPFgDC3cp6KvK4gCWQR+KAUbdGK1n1lZDg4w6MNAHIWKLX9x1pMqcQ5gwiAJUA
        Z3qhScXnaZ54ByJgEIlh7bsvEQ7YYRaAyXHNgDT0rzf5aev7Rok7HZhHn4BuPUEpnZPm6Na0UgJzW
        FFXZBg9jt9EagrJS/qzdRPV0Oke8aYyowT4eBZtGCOUKOPyVzqGssH0fh/h2DmOSiozvTEovuue7r
        7W+lio9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogTWW-001GZm-Cb; Thu, 06 Oct 2022 16:15:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BF0A30017D;
        Thu,  6 Oct 2022 18:14:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56D3E209DA438; Thu,  6 Oct 2022 18:14:59 +0200 (CEST)
Date:   Thu, 6 Oct 2022 18:14:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Brown, Len" <len.brown@intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu
 class-specific performance scores
Message-ID: <Yz7/A62YxHfmgYog@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-16-ricardo.neri-calderon@linux.intel.com>
 <YzLlk8NL5qkOOxzX@hirez.programming.kicks-ass.net>
 <20221005235959.GB29251@ranerica-svr.sc.intel.com>
 <Yz6XQHafjIpfkyyY@hirez.programming.kicks-ass.net>
 <Yz6cjzrmu8HNPhhy@hirez.programming.kicks-ass.net>
 <MN0PR11MB601075B47DC7626876CC91DAE05C9@MN0PR11MB6010.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR11MB601075B47DC7626876CC91DAE05C9@MN0PR11MB6010.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:05:18PM +0000, Brown, Len wrote:
> > > > Does any of that data actually ever change? Isn't the class score 
> > > > fixed per CPU type?
> 
> Depends on the chip.
> 
> As we described at LPC, the ADL chips shipping today update their
> tables in response to RAPL working to keep the system below PL1.
> Linux or user-space can scribble on PL1 at any time, so technically,
> this table update can happen at any time.
> 
> That said, it is true that, say, an ADL desktop part that operates
> with plenty of power and cooling will send the initial table and never
> have a need to update the table after that.

I have a NUC, so laptop part with limited thermals (the Lenovo P360
Ultra was announed just after I ordered the P360 Tiny). Still I wasn't
able to trigger this during normal operation.

> Upcoming chips are smarter and will give us more dynamic information.
> We expect the P-unit to send only "meaningful" changes, and that they
> Shall not occur more often than every 10ms.

Make *very* sure those upcoming chips don't broadcast that interrupt.
Broadcast interrupts are unconditional crap.

Broadcast interrupts every 10ms is terrifying crap and a good reason for
people to force disable this stuff.


