Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFE68F688
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBHSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBHSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:04:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5E17158
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MXWv/XpzhFL/3Svn1wfLOdz+zJmzMB7DykCoFL92t/A=; b=bLmbWiK28rXhW7Vn68Q128CJ9A
        6ps0GP+EVhDle+gD/SgAyhuiYGW91GcuMpIvKemFAjntYYKqwUmBFi2Z9x9GBwIzgrDlf5OEv/Vkz
        x8r20n6n+pRUY+wIK+J5pOSx+7XmmS5+vi7yjs7jQUX+5WwUrdHlGsM/XpVm3HsSd1/ERrrHrvxlj
        a47lwSM4dvG0JK+xsjpJIC9765/kRBOJroBWVU5jonnPWCwgVUfJexiyNq1spqgc8zULB+jtxLGqI
        sQWYRPk57ZrKCM0TQcW3vw3TamfY7u7RpMKpxLK0r6p2KnDhIUmWcesbGpuXkcLbMWg9B437KQ3yU
        oSrfaGsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPomb-007Wp1-2o;
        Wed, 08 Feb 2023 18:03:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BA8D300399;
        Wed,  8 Feb 2023 19:03:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53E3F20F05D4E; Wed,  8 Feb 2023 19:03:39 +0100 (CET)
Date:   Wed, 8 Feb 2023 19:03:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Message-ID: <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
References: <20230208073533.715-1-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208073533.715-1-bharata@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 01:05:28PM +0530, Bharata B Rao wrote:

> - Perf uses IBS and we are using the same IBS for access profiling here.
>   There needs to be a proper way to make the use mutually exclusive.

No, IFF this lives it needs to use in-kernel perf.

> - Is tying this up with NUMA balancing a reasonable approach or
>   should we look at a completely new approach?

Is it giving sufficient win to be worth it, afaict it doesn't come even
close to justifying it.

> - Hardware provided access information could be very useful for driving
>   hot page promotion in tiered memory systems. Need to check if this
>   requires different tuning/heuristics apart from what NUMA balancing
>   already does.

I think Huang Ying looked at that from the Intel POV and I think the
conclusion was that it doesn't really work out. What you need is
frequency information, but the PMU doesn't really give you that. You
need to process a *ton* of PMU data in-kernel.


