Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C187E5FF0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJNOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:50:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77729353;
        Fri, 14 Oct 2022 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=249VpeP5z23JCwoRImQsSaQUvJdFuBIcLotEmhMimd4=; b=aMZnZDf75nFx/l4E8yVY2CYUIW
        4Zawy1yqyfjRnf1akSd7M+uO12IBhOM0meTDGEOcE/TpDPithdjb1LQEFjgBZDUep7s8NSWy1kkq/
        0mnRIAqZcr0tpbrguBJkE1DonuWqDesT8aT4OPIYYJNogF5BzA1LM4MNk/gLWPJ+dxcDHkIBIrOcI
        FNHi3YpMa30HoCpHeABIB2Mn5czC9NMN0C0ip6bUUPVCBlmH4BwOQJCYIWYN2VCbPx5JNc9RomzKg
        2uPpz9bfjk0TH/phISnueuUNQRdN2yqSoBJ/XEjkjmn7pSAktdbeF1gGnmPeFRdHiLc6QbTP2MTLH
        wH9nklMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojM0w-007hQ8-OC; Fri, 14 Oct 2022 14:50:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77E2030008D;
        Fri, 14 Oct 2022 16:50:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C9C22C17FC1F; Fri, 14 Oct 2022 16:50:12 +0200 (CEST)
Date:   Fri, 14 Oct 2022 16:50:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, ndesaulniers@google.com,
        srw@sladewatkins.net, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf: Rewrite core context handling
Message-ID: <Y0l3JDtF9NaLIF+X@hirez.programming.kicks-ass.net>
References: <Y0VTn0qLWd925etP@hirez.programming.kicks-ass.net>
 <ba47d079-6d97-0412-69a0-fa15999b5024@amd.com>
 <Y0V3kOWInrvCvVtk@hirez.programming.kicks-ass.net>
 <Y0WsRItHmfI5uaq3@hirez.programming.kicks-ass.net>
 <174fb540-ec18-eeca-191d-c02e1f1005d2@amd.com>
 <Y0awHa8oS5yal5M9@hirez.programming.kicks-ass.net>
 <Y0cn1xazYpNmqhRo@hirez.programming.kicks-ass.net>
 <99caec5f-dcdf-70c6-8909-11552ce42a20@amd.com>
 <Y0fvpQEEl/tK6mJ5@hirez.programming.kicks-ass.net>
 <0df72f8e-1c17-2140-c841-5a75fb43db14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df72f8e-1c17-2140-c841-5a75fb43db14@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 03:26:07PM +0530, Ravi Bangoria wrote:
> On 13-Oct-22 4:29 PM, Peter Zijlstra wrote:
> > On Thu, Oct 13, 2022 at 03:37:23PM +0530, Ravi Bangoria wrote:
> > 
> >>> -	refcount_t			refcount;
> >>> +	refcount_t			refcount; /* event <-> ctx */
> >>
> >> Ok. We need to remove all those // XXX get/put_ctx() from code
> >> which we added to make refcount a pmu_ctx <-> ctx.
> > 
> > Them already gone :-) I've not yet fixed up the typoes, but current
> > version should be here:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/core
> > 
> > Thanks!
> 
> I've been running perf-fuzzer on Xeon machine since yesterday and I don't see any
> issue. Will do the same on my AMD machine as well over the weekend.

Awesome -- I've started fuzzing on the ADL (with the big.LITTLE PMU
setup) and I've had it run on my very aged IVB-EP machine. Both so far
(knock on wood) with no issues.

The most modern AMD machine I have at hand is a 2 socket Interlagos, and
I doubt anybody really much cares about that these days -- but I can run
it for giggles.
