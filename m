Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57856FF2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbjEKN2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjEKN2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:28:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE017173B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:26:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683811583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=317Fz8QUimiJg2kKcfYfUmJedbcz95B0Vapr8bFk5xY=;
        b=K3qiIlTnud9sLrTAV/N+UouhioiaKLetD4FWjSmOapH4NunU1NNRb9tdC2V6Zy4LXowg30
        qgLdPQEoxwEIAdhIdXol+bARY9/Of3ft9J325k8Vz2CxRm/mB2FrITBzR+f5UQnymZe/0F
        HwW2l7nEb1r7n9ZSQGpUolkiDF0jE+ul/h1pbeCbZYR7uTU3n9dYggvbuh+MltyIRyefxt
        OqSwlZL2uf1zuwqznEMAAZfL4DOVCd27MWAjbSQKiFCXqUrmENjgtaXIdYfGhdtfL4mjge
        RV2wVGGooTmD1zkPkzXk6C+oST7sh1hKKOx41uzJFOhF30r5DoMMQEjT2e6KrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683811583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=317Fz8QUimiJg2kKcfYfUmJedbcz95B0Vapr8bFk5xY=;
        b=80VGekiZSvMCvi7cZ0mcR4fnW1ZISYo1PjmJOca/mJZeoc8W8z3TZBr8ipGtz6HQvSEdHl
        WGkJ2+Fd/0snSxDQ==
To:     Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] threads: Update PID limit comment according to futex
 UAPI change
In-Reply-To: <87mt2bc9wz.ffs@tglx>
References: <20200302112939.8068-1-jannh@google.com>
 <20200303102540.GC2579@hirez.programming.kicks-ass.net>
 <8736apede7.fsf@nanos.tec.linutronix.de> <87mt2bc9wz.ffs@tglx>
Date:   Thu, 11 May 2023 15:26:22 +0200
Message-ID: <87jzxfc83l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11 2023 at 14:47, Thomas Gleixner wrote:
>> #define FUTEX_TID_MASK          0x3fffffff
>
> That futex mask is irrelevant because there is another limitiation for
> the PID space namely posix CPU timers:
>
> static inline clockid_t make_process_cpuclock(const unsigned int pid,
> 		                              const clockid_t clock)
> {
> 	return ((~pid) << 3) | clock;
> }
>
> That existed even before we fiddled with robust futexes and puts a hard
> limit of 29 bits on the PID space.

Actually it's worse than this. The limit is 28 bits because posix CPU
timers rely on this:

static const struct k_clock *clockid_to_kclock(const clockid_t id)
{
	clockid_t idx = id;

	if (id < 0) {
		return (id & CLOCKFD_MASK) == CLOCKFD ?
			&clock_posix_dynamic : &clock_posix_cpu;
	}
        ....

So TID must be smaller than 2^28 because if bit 28 would be set, then
the resulting clock would be positive after shift.

Sigh...

