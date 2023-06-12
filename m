Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20A772C8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjFLOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFLOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:54:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EC10A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xy+SYhrM7RlVNzZxFzAWCPsWAl2CRd9k+U+jDm6Cq4E=; b=fvCz3vBoL4Kcr2PHBIVKbzlSWG
        b7qVtnDn5yl03rPcqDmmbthkz0bGM+3IQbUyboMZRBdaZ6vNs26kgCJQkcB/wjKMku2AcqHSG1rx8
        bUYE/h6uyx/NnIdOmwRovIJ+RHn2b+wWMyS5i563EH+okJaxxBWkumo/Z1Arwk2pXeU0pGV74zjT8
        FsgVcUGXUTzNY0PGlRu9CbChajdcoZpNwsyylL64I0J7JCy9Nh6krBjHx9XisQ0ozKohuXd9FyZfU
        NTAyKhfmrtf17bFkyS3bELCZG/uP+wGY21lVHfG6aTU1IZcqIwbVHcxr4Mcv+q6Je0YOHYESPFRni
        x/PyecJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8iw3-002k4U-Lh; Mon, 12 Jun 2023 14:54:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B99E300188;
        Mon, 12 Jun 2023 16:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32A0920D7062B; Mon, 12 Jun 2023 16:54:23 +0200 (CEST)
Date:   Mon, 12 Jun 2023 16:54:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
Message-ID: <20230612145423.GC83892@hirez.programming.kicks-ass.net>
References: <20230603082519.1088285-1-maz@kernel.org>
 <ZIcarHx0qbfC2iyy@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIcarHx0qbfC2iyy@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:16:28PM +0100, Mark Rutland wrote:
> On Sat, Jun 03, 2023 at 09:25:19AM +0100, Marc Zyngier wrote:
> > Reiji reports that the arm64 implementation of arch_perf_update_userpage()
> > is now ignored and replaced by the dummy stub in core code.
> > This seems to happen since the PMUv3 driver was moved to driver/perf.
> 
> I guess we should have a Cc stable then?
> 
> The below implies this has always been on dodgy ground, and so it's probably
> inaccurate to give this a Fixes tag pointing to the move.
> 
> > As it turns out, dropping the __weak attribute from the *prototype*
> > of the function solves the problem. You're right, this doesn't seem
> > to make much sense. And yet... It appears that both symbols get
> > flagged as weak, and that the first one to appear in the link order
> > wins:
> > 
> > $ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
> > 0000000000001db0 W arch_perf_update_userpage
> 
> Ah, so having it on th *declaration* will apply to any *definition*. :/

Yikes..

> That suggests this is a bad pattern generally, and we should probably remove
> the other __weak instances in headers. Lukcily it seems there aren't that many:
> 
> [mark@lakrids:~/src/linux]% git grep __weak -- **/*.h | wc -l
> 50
> 
> IMO we'd should aim to remove __weak entirely; it causes a number of weird
> things like this and it'd be much easier to manage with a small amount of
> ifdeffery.
> 
> Peter, thoughts?

Not a fan of __weak myself, after having had to deal with how the
compilers actually make it work.

Where do I queue this? perf/urgent?
