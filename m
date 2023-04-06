Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156016DA27B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbjDFURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbjDFURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:17:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A01BD7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mFpvxPlspeoy9LDmMBY7APXBNJ5e/XNrdXF3NxrNXXw=; b=H2Yp1vNceuOId//xOj47ZDsS60
        cItSvbsseW0Xs+GWraSBzFA6eRyLU98hf574cFaaV6aVEmEu0ESRbFOXjyUbDTBO5MPA9KfTsJCZ2
        aE3+f0KTlek19+HRaToSO+/yXAZVtSfHROmNFT11O4up9QsGMne9zuZkmvQlext0W21kTixe0SFKX
        88+fGh+uMNaVYVpCOoArqfWaIlO4oCmPB6sjoziSMJjL7JB5+YtvyQVBYbgcgMZ2CWAoTctqOQkb0
        gQIUYaETjrk+c39s/BCFc4vVvomZowbeI0w5NhuYXFDbKHp9FciQMQaQoRG7H/alFIbmQAOTYdGWd
        gvY3jDCA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkW2P-0008SQ-2U; Thu, 06 Apr 2023 20:17:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 990DF300202;
        Thu,  6 Apr 2023 22:16:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D04F212E36AC; Thu,  6 Apr 2023 22:16:52 +0200 (CEST)
Date:   Thu, 6 Apr 2023 22:16:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
Message-ID: <20230406201652.GA409443@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com>
 <20230405202240.GE365912@hirez.programming.kicks-ass.net>
 <87o7o1lzko.fsf@oracle.com>
 <20230406201359.GC405948@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406201359.GC405948@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:13:59PM +0200, Peter Zijlstra wrote:
> +void irqentry_exit_cond_resched_tif(void)
> +{
> +#ifdef TIF_RESCHED_ALLOW
> +	if (resched_allowed()) {
> +		/* Sanity check RCU and thread stack */
> +		rcu_irq_exit_check_preempt();
> +		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> +			WARN_ON_ONCE(!on_thread_stack());
> +		if (need_resched())
> +			preempt_schedule_irq();

arguably this can simply call raw_irqentry_exit_cond_resched_tif()..
probably better than duplicating all that again.

> +	}
> +#endif
> +}
