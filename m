Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D506A32EB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBZQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBZQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:51:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD1AD01
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m3LKRfwWOygQSqjjFNX6N36fuKaq420ca2aHaGAmSyk=; b=ocvA04vq84hrPUkqBZMnRxrdpG
        PCm+To25twTQp+6YOcheJs5nGRvJjhmquzJIZeBJSqzfZSIe0fK75GFWpvxyaVTAAzMDtBmchlot4
        Q4oEh4PlKGuoLHgWAtKX23Sjojh0BgMAnus0RDHBMAG1reUKRFcAuAR+N3dJhCfMaAcl05LQjeVhi
        2z7TcXhf+3G1wKm4Aksuq1BGuLfAe1fum66DuooQ8zO3b5EMCJEtBp10VEwjhcXUzMqXbbwXIL2Pq
        VCiRg1HNvUUAZgo10SU7pWS2TM/0vBc/4SiA2+LShdDMMdFI42CglW56AiY5VOeBhFuJNxRXNZB9W
        NY3Zkz9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWKEu-00H1KZ-Lm; Sun, 26 Feb 2023 16:51:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7EBB73001E7;
        Sun, 26 Feb 2023 17:51:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63300203C00E1; Sun, 26 Feb 2023 17:51:07 +0100 (CET)
Date:   Sun, 26 Feb 2023 17:51:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <Y/uN+89FlTw45uiA@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 04:04:35PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 23, 2023 at 01:26:45PM +0100, Peter Zijlstra wrote:
> > @@ -1072,7 +1067,7 @@ rwsem_down_read_slowpath(struct rw_semap
> >  	for (;;) {
> >  		set_current_state(state);
> >  		if (!smp_load_acquire(&waiter.task)) {
> > -			/* Matches rwsem_mark_wake()'s smp_store_release(). */
> > +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> >  			break;
> >  		}
> >  		if (signal_pending_state(state, current)) {
> > @@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
> >  	} else {
> >  		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
> 
> Found it; if we remove the try_write_lock below, then at least this
> new-waiter path needs to still do a trylock.
> 
> Let me go test the other patches on top of all this and push out a fresh
> set if that all still works.

queue.git locking/core

We'll see what the robots make of it.
