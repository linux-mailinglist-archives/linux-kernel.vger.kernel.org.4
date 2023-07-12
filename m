Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1072A75081B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjGLMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:23:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B03B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fb9uUBAWeKUKSGvwrV56h7znLSTMuzoCO7lSOEllzLs=; b=oxiU/FySZXg225dH8rympKBP3a
        qFHVptr3oS/U3eHP2p9D12Jp1oCfqaTWjNjuFU5XkZqNJphGVKGTIS/DuIpkZQ7XCGNtYvKGNRs2L
        rqPmhi9GinyVQzH7G/IF7qt3UWRSsaIkp5lGv7ymIlK2sAjibauBFff4F2k3t5t3CuzVH61+Zgrca
        5kNV3n5avriGTz9BPO1MWUeVojSFsA3Es83gSjSuynhipn1WveH3UY+XEZUa4bQKLCnFk82hoh96E
        gCu7yBXp4q2u32Wm710wmXzfObQuP+fiEf5hycEMA9zeomF1swJyIYm2Jw1UFQIEMK3SusCfpOOd8
        lEl7puYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJYru-00Gfpp-GQ; Wed, 12 Jul 2023 12:22:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E46730056F;
        Wed, 12 Jul 2023 14:22:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EC6C2CA56983; Wed, 12 Jul 2023 14:22:52 +0200 (CEST)
Date:   Wed, 12 Jul 2023 14:22:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kprateek.nayak@amd.com,
        aaron.lu@intel.com, clm@meta.com, tj@kernel.org,
        roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 6/7] sched: Shard per-LLC shared runqueues
Message-ID: <20230712122252.GG3100107@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-7-void@manifault.com>
 <20230711104958.GG3062772@hirez.programming.kicks-ass.net>
 <20230711195757.GD389526@maniforge>
 <ZK57IxhhZMw2ZaEA@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK57IxhhZMw2ZaEA@BLR-5CG11610CF.amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:36:27PM +0530, Gautham R. Shenoy wrote:

> On some Intel servers, it is possible that the CPU numbers are
> interleaved across the two sockets. On my 2 socket, 32Cores per socket
> Ice Lake Server, all the even numbered CPUs are in one socket and all
> the odd numbered CPUs in the other socket.
> 
> The SMT siblings are {0,64}, {2, 66}, .... on one socket and {1, 65},
> {3, 67}, .. on the other.

Yeah, Intel SMT enumeration is a mess. There's a random mix of {n,n+1}
and {0..n-1} {n..2n-1}. And then there's the fun hybrid stuff.  Those
appear to do {n,n+1} for the big cores and then continue with the small
cores in a dense set. My 8+8 ADL, has:

{0,1} {2,3} {4,5} {6,7} {8,9} {10,11} {12,13} {14,15} {16} {17} {18} {19} {20} {21} {22} {23}

I suspect it might be easier to re-number the whole show at boot to fit
a sane pattern rather than trying to match the various random garbage
gifted to us by the BIOS.


I wouldn't worry about it too much at this point.
