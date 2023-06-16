Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367E4732B17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjFPJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFPJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:08:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF213C00
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b++CNjLUS/0LmSGyySsEgsZjcL5GFL38dvM7EjtSaH8=; b=TyRg4k2e6fMBdxJlIHyY3BTOGa
        AzkKNS0nYz9pQZWeb/gHB8sPvTOtIESjefkQ8uSUDvq0koEwjSVSVTh4WBMn68SoQxDAppq2S3IQN
        PRwOsGnIAfXM1M66uW7vHWUD5dXofHGTVkgkq0n/5/m1qbSIEANB0o0KYHITxKDyyLm0j7RIUQRb/
        noCqF0Ttz+GLEU5xrtv+8u1bbkNmjeXrzE+M8Kdzf6i5Hc/u0uPlXEVIbrVVbm4/AhDV4IgRMf8au
        gIbA9yf0L65CHbWncKMfkl+B1lO/nZ0kaYtjnWJPF61tUC3yr7AKVEA1nCxtksegkX31U8aDbW2En
        CH8iHcZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA5Pi-008nV4-42; Fri, 16 Jun 2023 09:06:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBE913002F0;
        Fri, 16 Jun 2023 11:06:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C5E5245F1E45; Fri, 16 Jun 2023 11:06:37 +0200 (CEST)
Date:   Fri, 16 Jun 2023 11:06:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
Message-ID: <20230616090637.GB4253@hirez.programming.kicks-ass.net>
References: <20230603082519.1088285-1-maz@kernel.org>
 <ZIcarHx0qbfC2iyy@FVFF77S0Q05N>
 <20230612145423.GC83892@hirez.programming.kicks-ass.net>
 <86r0qgbu4j.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r0qgbu4j.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:03:24PM +0100, Marc Zyngier wrote:
> On Mon, 12 Jun 2023 15:54:23 +0100,
> Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Mon, Jun 12, 2023 at 02:16:28PM +0100, Mark Rutland wrote:
> > > On Sat, Jun 03, 2023 at 09:25:19AM +0100, Marc Zyngier wrote:
> > > > Reiji reports that the arm64 implementation of arch_perf_update_userpage()
> > > > is now ignored and replaced by the dummy stub in core code.
> > > > This seems to happen since the PMUv3 driver was moved to driver/perf.
> > > 
> > > I guess we should have a Cc stable then?
> > > 
> > > The below implies this has always been on dodgy ground, and so it's probably
> > > inaccurate to give this a Fixes tag pointing to the move.
> > > 
> > > > As it turns out, dropping the __weak attribute from the *prototype*
> > > > of the function solves the problem. You're right, this doesn't seem
> > > > to make much sense. And yet... It appears that both symbols get
> > > > flagged as weak, and that the first one to appear in the link order
> > > > wins:
> > > > 
> > > > $ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
> > > > 0000000000001db0 W arch_perf_update_userpage
> > > 
> > > Ah, so having it on th *declaration* will apply to any *definition*. :/
> > 
> > Yikes..
> > 
> > > That suggests this is a bad pattern generally, and we should probably remove
> > > the other __weak instances in headers. Lukcily it seems there aren't that many:
> > > 
> > > [mark@lakrids:~/src/linux]% git grep __weak -- **/*.h | wc -l
> > > 50
> > > 
> > > IMO we'd should aim to remove __weak entirely; it causes a number of weird
> > > things like this and it'd be much easier to manage with a small amount of
> > > ifdeffery.
> > > 
> > > Peter, thoughts?
> > 
> > Not a fan of __weak myself, after having had to deal with how the
> > compilers actually make it work.
> > 
> > Where do I queue this? perf/urgent?
> 
> That'd be my preference, as arm64 is currently a bit broken and I'd
> like 6.4 to be functional.

Can I get a Fixes tag?
