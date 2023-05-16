Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C365D704970
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjEPJhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjEPJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:37:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1BF2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:37:18 -0700 (PDT)
Date:   Tue, 16 May 2023 11:37:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684229836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9sQpT1Spda85MCW7ftr8Lrf17AZnmiHFvRqlsbIv1A=;
        b=IwZPVc2m/MG6rxH/Dv37Lp1QFyw6ZqghVeh9+nMT+18B1vV8lE3d3RoKC9B+n1yPyxhTwA
        zlVzz7jfBvfDsJBmsl9tocwANGu88jmXSrUQOBV9gSWLyhq++8OUYgPGJW5DT1a8FST5Qd
        wrjiXVbmfBiS9N1FMKWaM4o1HXSdOUc0g6z7O+ZwUAb1S9H+g7GDX1OSFfgft2vjX9U7nh
        4NtVgCMwH71Glyl5hcT8Ojp2OgJSIMhZRQz6qlLatNLnGbJCm4+8BTwN6N1rzn2Mf6xO2l
        GReeIeXQBnTVDVvaXvdt8l3SjofEiQ6kZF3Ycwr4p+TAx8Bjp/j7AaivUmsjfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684229836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9sQpT1Spda85MCW7ftr8Lrf17AZnmiHFvRqlsbIv1A=;
        b=pETW/++7D/mL0s5VQxZEFT3T28fDLjYDQabhcEZEULlEpsA6V5CxHTHgWTRr+3P36GCz1F
        6fSCKVAILnlduqDA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <20230516093715.cE8LUUcB@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
 <ZFty1fNMlnuLk4qF@localhost.localdomain>
 <20230515101936.3amAvw0T@linutronix.de>
 <398d7731-f5ca-a34-9e4-77da60c49d21@linutronix.de>
 <20230515124133.XkKOksjW@linutronix.de>
 <ZGNL427cvjGQ-7dY@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGNL427cvjGQ-7dY@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-16 11:24:51 [+0200], Frederic Weisbecker wrote:
> > This looks okay. I wouldn't suggest to hold the timer_base::lock or
> > tmigr_cpu::lock longer than needed. Both can be acquired independently
> > cross CPU and have explicit locking order. So it is fine.
> 
> 
>    LOCK(A)
>    LOCK(B)
>    UNLOCK(A)
>    UNLOCK(B)
> 
> 
> Cross rhymes aren't pretty in locking. They don't make the review smooth
> but yeah it's not incorrect either. And since I don't have a better way to
> propose...

tmigr_cpu::lock is required longer than timer_base::lock. You can't
acquire tmigr_cpu::lock -> timer_base::lock due to lock ordering.

So you follow the lock order, acquire what needed, drop everything else
to lower lock contention for others.

> > > Thanks,
> > > 
> > > 	Anna-Maria

Sebastian
