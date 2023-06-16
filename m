Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86873319E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbjFPMw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFPMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:52:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500E30F7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pc2nHptoZyvja0c5oQk9KVyr6kxRddZ7zBs/vCuF+04=; b=UWzwiNkzX105QrRhSoW5b6JVvK
        jlUrrcskV14PjmWR0YtuSThtVVaqhVEiC9ThwV4dmiIMRPb/rVyUmPeG2WVzhw+ZQ9EH9+P4kTo8Q
        ZHJP+aKZOwkM1Cb3pDd1IO5cHgvOV8nV9yrSpTkunzC5r7ObWCnamOLWjR0AiZejVSofQLbZZVssv
        C43IXwhUHESuAJ6kBSLfRZedMHRbG6U5+sEdteufFSeAlYve+SEj4AoOA3LAQIB6ZGsNzA5VfyuRz
        KfQ+IFRL2YABACnV7EMz3IiJi3Q4oEzqNg5Aol2nq4KNgrYt3uB5lA52RRXt/i/+0y+hxQd/uuTon
        aG8a3Tbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA8w9-0090kh-05; Fri, 16 Jun 2023 12:52:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B440530020B;
        Fri, 16 Jun 2023 14:52:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 955AA27438941; Fri, 16 Jun 2023 14:52:19 +0200 (CEST)
Date:   Fri, 16 Jun 2023 14:52:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Reiji Watanabe <reijiw@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
Message-ID: <20230616125219.GF4253@hirez.programming.kicks-ass.net>
References: <20230616114831.3186980-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616114831.3186980-1-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:48:31PM +0100, Marc Zyngier wrote:
> Reiji reports that the arm64 implementation of arch_perf_update_userpage()
> is now ignored and replaced by the dummy stub in core code.
> This seems to happen since the PMUv3 driver was moved to driver/perf.
> 
> As it turns out, dropping the __weak attribute from the *prototype*
> of the function solves the problem. You're right, this doesn't seem
> to make much sense. And yet... It appears that both symbols get
> flagged as weak, and that the first one to appear in the link order
> wins:
> 
> $ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
> 0000000000001db0 W arch_perf_update_userpage
> 
> Dropping the attribute from the prototype restores the expected
> behaviour, and arm64 is able to enjoy arch_perf_update_userpage()
> again.
> 
> Fixes: 7755cec63ade ("arm64: perf: Move PMUv3 driver to drivers/perf")
> Fixes: f1ec3a517b43 ("kernel/events: Add a missing prototype for arch_perf_update_userpage()")
> Reported-by: Reiji Watanabe <reijiw@google.com>
> Tested-by: Reiji Watanabe <reijiw@google.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Thanks! in perf/urgent it goes
