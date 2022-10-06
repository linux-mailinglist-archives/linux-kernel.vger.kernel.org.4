Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A105F62D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiJFIgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJFIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:36:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB794130
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WTKyl5EoLMg1+e9UG559uyzJmEx5dO0BcnOrHhA+pIg=; b=MDyGBZITxhDi0FZt3Mx0MezB1q
        hK5aR/q1vk8POpoXwPYD1lvzUipD3FMU69keCeFkrhlHpAJIkgoCNu5tnhc4ffiFbW+fmjCEftzQk
        K+Fns82ExB5A4aZ7bZvBVnag7fGAVbj0HLO4KKdrNg/yOrdgxsM2WAmZbZblxc7uuVJc67zYuOvgA
        lYdr2OJRqb96e6r1sK0b33Hah0FR+OGJ3TpQu5ENabESTb9wfHlz9Rnbrfom2aRzY7kUARLYJ3gpx
        ZHWS+YpfPavYV5ncMS2a9GXdkmD4+cJwUuvi+xuXCdmI0WmYFJ35gPfzBhpPqavpQ2cyNQ0PGQwvi
        PyI92VEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogMLy-001CG2-6q; Thu, 06 Oct 2022 08:35:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 238E03001D6;
        Thu,  6 Oct 2022 10:35:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2BA3201FC2CE; Thu,  6 Oct 2022 10:35:36 +0200 (CEST)
Date:   Thu, 6 Oct 2022 10:35:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 23/23] x86/process: Reset hardware history in context
 switch
Message-ID: <Yz6TWL6zkD5Ee4/4@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
 <YzLyCD0P7MATFiVM@hirez.programming.kicks-ass.net>
 <20221003230758.GA22466@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003230758.GA22466@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 04:07:58PM -0700, Ricardo Neri wrote:
> On Tue, Sep 27, 2022 at 02:52:24PM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:
> > 
> > > +void reset_hardware_history(void)
> > > +{
> > > +	if (!static_cpu_has(X86_FEATURE_HRESET))
> > > +		return;
> 
> If I used cpu_feature_enabled(X86_FEATURE_ITD) along with the CONFIG_HFI_
> THERMAL and its corresponding DISABLE_MASK bit the code below would be
> compiled out.

Nobody cares about compiled out -- distro's must enable all this. So
what counts is the code size, and the alternative is smaller.

> > > +
> > > +	asm volatile("mov %0, %%eax;" __ASM_HRESET "\n" : :
> > > +		     "r" (hardware_history_features) : "%rax");
> > > +}
> > 
> > 	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
> > 			     : : "a" (hardware_history_features) : "memory");
> 
> Do you still prefer have implemented as an ALTERNATIVE?

Yes, look at the generated code.
