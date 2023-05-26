Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7F712297
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbjEZIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbjEZIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:47:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77660119
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:47:53 -0700 (PDT)
Date:   Fri, 26 May 2023 10:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685090871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7shyX3MoA1ObGPbTAReAORP7f8FP4eKlcPBqPCjZQAo=;
        b=hILVUR2fcLzZYxs9vCgrYHjJ63TYxGq+J2EpBfFQCw0xbT8h2B5qE3BzfQOQGhN1sfBXAv
        bxT27KVhVxH8II+4pOyENO4vxYR8znD03xjMQMqcW2V5XS94SdYpS4R4wWakGxtxwuUY7+
        y/UIoO4f0Re69MGERg7xy3nJEf8rB3rQHl1nBmpRGUCvhBwn7xWyksJ89ZPL/TVVxMjLid
        FJ7zVXr0bJAESA+PvZV1bITYxomWxC2C8o/0ErqDhlNXrecd1VF8YOqII3H/FpZrkos9Yt
        MnDg8fa0UR3+ReSnFFvqdR5RlmB1EXXV7dbX8OozzbT/H9+edUYayms6EHmFqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685090871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7shyX3MoA1ObGPbTAReAORP7f8FP4eKlcPBqPCjZQAo=;
        b=OgZhxI0Pakm8V0cUCrIhyJdSXNBPBxo4LrCNnLFwXgESmjnrEr4mxi9o/VGlAfqkYY5gy6
        GpZn4s60O44aAhBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <20230526084749.Fb8g4H-s@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525165244.GV83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-25 18:52:44 [+0200], Peter Zijlstra wrote:
> Urgh...
> 
> I've ended up with the below.. I've tried folding it with
> ttwu_state_match() but every attempt so far makes it an unholy mess.
> 
> Now, if only we had proper lock guard then we could drop another few
> lines, but alas.

perfect, thank you.
Tested the bits.

Sebastian
