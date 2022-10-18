Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C87602888
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJRJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJRJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:40:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA689E2C3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+oHCmlSrQtOe8KtXGCGb0Hin+gSSgOm6PLxBdj0ubKs=; b=Y+ZmAXaWxb7eioaQCzFdKi4Yvw
        8D1TQ1fu8m2Uc0N9P2PNrei7toGIWqnw6Q8sVeBaWs7f3ympxkJWLP28TNbTlAshM190Jsz9sPZ+j
        wvQNvy8B4XJD5w1NUl4afrqcQ2k1RHECOVjuaH2Ac76siUv8stzUqu5g50pumWffVT4ewmsfddMYL
        hfffRoUAYs9rVqbrwISxVU5tnNiDYKzvPKlMBOeTjHl8ogWV3/yPn2FwL77m5P0RBP/aD1j257l4b
        vbaM4AALzT20cAMJrAZy89fLpamOCh5euDPqaxpgcd/+vHuTayD10IEo+pD30jAizoASqvHW7kgIY
        o71RJPnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okj56-00AdTz-G0; Tue, 18 Oct 2022 09:40:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 663AD30004F;
        Tue, 18 Oct 2022 11:40:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47A692C3855A4; Tue, 18 Oct 2022 11:40:11 +0200 (CEST)
Date:   Tue, 18 Oct 2022 11:40:11 +0200
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/fair: Avoid unnecessary migrations within SMT
 domains
Message-ID: <Y050e5XQkaUrwr5j@hirez.programming.kicks-ass.net>
References: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
 <20221018023527.GB23064@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018023527.GB23064@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 07:35:27PM -0700, Ricardo Neri wrote:
> On Thu, Aug 25, 2022 at 03:55:25PM -0700, Ricardo Neri wrote:
> > Intel processors that support Intel Turbo Boost Max 3.0 use asym_packing
> > to assign higher priorities to CPUs with higher maximum frequencies. It
> > artificially assigns, however, a lower priority to the higher-numbered
> > SMT siblings to ensure that they are used last.
> > 
> > This results in unnecessary task migrations within the SMT domains.
> > 
> > On processors with a mixture of higher-frequency SMT cores and lower-
> > frequency non-SMT cores (such as Intel hybrid processors), a lower-
> > priority CPU pulls tasks from the higher-priority cores if more than one
> > SMT sibling is busy.
> > 
> > Do not use different priorities for each SMT sibling. Instead, tweak the
> > asym_packing load balancer to recognize SMT cores with more than one
> > busy sibling and let lower-priority CPUs pull tasks.
> > 
> > Removing these artificial priorities avoids superfluous migrations and
> > lets lower-priority cores inspect all SMT siblings for the busiest queue.
> 
> Hello. I'd like to know if there are any comments on these patches. This
> patchset is a requisite for the IPC classes of tasks patchset [1].

Urgh.. so I'm not liking this, afaict you're sprinkling SMT2
assumptions.

Why can't we make arch_asym_cpu_priority() depend on CPU state? Doesn't
it then magically work?
