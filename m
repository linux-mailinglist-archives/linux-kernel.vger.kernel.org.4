Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36872C39E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjFLMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjFLMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:01:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F31A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:01:51 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686571308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXPsijKOjNBu+D96lWBYZGtCNyuqxCY50KRJRUXtWow=;
        b=DAe4aLsD9cMM346mOj988ywc6/LZJLolUkAoDt8+2rx4/ycyrPssR6H6ar8yL6Y9wAiN/G
        pk2IhopsYJZ2fOVohSmluYnSqmOjiwPb8nzVLWDG1LLgrBgv9jR0dCkTLnlTs4ngn2eho2
        dWl4ru5V0kXgKdPUXq6IiXZjKIjfEgXmGZJXZ3COGu1KureJihBY3J4JYhnL77xUqxVGpZ
        jaXTP66eP7O36+d3l3qTfFSXplZ+tDb2NJwfQvP3lIzvA4u0d0BxY+6oTpgmnrp3UTCYgB
        7zzbjAsqttFFbizJGELiBCaW0A416uzDVWNj0dJxchvW+bMGWLqxCREIJSPNPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686571308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXPsijKOjNBu+D96lWBYZGtCNyuqxCY50KRJRUXtWow=;
        b=C7jG8bsD9LV/2VM9YtMsDa/19uad7Uyx/djTg8uBG3Yh5R2nyu6ZPqPEMVWzf26sjPJ6oy
        KCNIjAx1UxkppOAw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
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
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v7 15/21] timer: Add get next timer interrupt functionality
 for remote CPUs
In-Reply-To: <ZICaY9/vpEPoHE7q@lothringen>
Message-ID: <519693b6-fc4e-8d25-f597-393847c18677@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de> <20230524070629.6377-16-anna-maria@linutronix.de> <ZICaY9/vpEPoHE7q@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023, Frederic Weisbecker wrote:

> On Wed, May 24, 2023 at 09:06:23AM +0200, Anna-Maria Behnsen wrote:
> > +# ifdef CONFIG_SMP
> > +/**
> > + * fetch_next_timer_interrupt_remote
> > + * @basej:	base time jiffies
> > + * @basem:	base time clock monotonic
> > + * @tevt:	Pointer to the storage for the expiry values
> > + * @cpu:	Remote CPU
> > + *
> > + * Stores the next pending local and global timer expiry values in the
> > + * struct pointed to by @tevt. If a queue is empty the corresponding
> > + * field is set to KTIME_MAX. If local event expires before global
> > + * event, global event is set to KTIME_MAX as well.
> > + *
> > + * Caller needs to make sure timer base locks are held (use
> > + * timer_lock_remote_bases() for this purpose). Caller must make sure
> > + * interrupts are reopened, if required.
> 
> That last sentence looks weird. All we want is the caller to call this
> and the timer_[un]lock functions with interrupts disabled.
> 
> Now of course at some point the caller will need to unmask the IRQs
> but heh, not our problem :)

I'll drop the last sentence :)

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 

