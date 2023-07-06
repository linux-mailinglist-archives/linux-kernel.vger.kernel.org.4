Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5B749B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjGFMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjGFMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:01:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD571199F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5Ff0242TZ8YlYYk+tSnfq1b/kH2bKlT8Fihn15PQck=; b=parUxzalQixgWc/OkgNNEk/i+Y
        9C3/TNn6ZkzieUcucOTA7I3/N/FQN9CvF3adw2ezpo9JHYuWoC4fofP1O7UiOIDlPNd3BsgMcN2Ns
        8Wrf2fH9ahJf3YnRRw9FuXgd+kRs5yHJtGjKK/kgWo5NywJLXBlRuXvpSzMzViD9rRXEZ5dKP/jGw
        P5sHX5YngKj7Eld3dzLuHvE0UjR83M1H4WF0m23TKigYF7bWjDk9Fx51PaFYwreIbYU/WuSF59R1R
        uB4nFsqozqBk/hJ8G8Ue/aOjIfNkiiY4HHVNwItykf/iS0Ffs2eOdWwD4IIcKGvCMJTYineiLygGO
        QBDhzNog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHNfU-00B2Ja-73; Thu, 06 Jul 2023 12:01:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41DD43001E7;
        Thu,  6 Jul 2023 14:01:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 284052026E954; Thu,  6 Jul 2023 14:01:03 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:01:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Henry Wu <triangletrap12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Possible race in rt_mutex_adjust_prio_chain
Message-ID: <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:08:20PM +0800, Henry Wu wrote:
> Hi,
> 
> I found that it's not safe to change waiter->prio after waiter
> dequeued from mutex's waiter rbtree because it's still on owner's
> pi_waiters rbtree. From my analysis, waiters on pi_waiters rbtree
> should be protected by pi_lock of task which have pi_waiters and
> corresponding rt_mutex's wait_lock, but pi_waiters is shared by many
> locks owned by this task, so actually we serialize changes on
> pi_waiters only by pi_lock.
> 
> `rt_mutex_adjust_prio_chain' changes key of nodes of pi_waiters rbtree
> without pi_lock and pi_waiters rbtree's invariant is violated. Maybe
> we are enqueuing waiter on other cpu and pi_waiters rbtree will be
> corrupted.

Are you talking about [7];

Where we do waiter_update_prio() while only
holding [L] rtmutex->wait_lock.

VS

rt_mutex_adjust_prio() / task_top_pi_waiter() that accesses ->pi_waiters
while holding [P] task->pi_lock.

?

I'll go stare at that in more detail -- but I wanted to verify that's
what you're talking about.

> I attach a source file which can trigger this violation. I tested it
> on Ubuntu 20.04 LTS with 5.4 kernel.

Well, that's a horribly old kernel :-( Please double check on v6.4 and
consult that code for the discussion above -- I'm really not too
interested in debugging something ancient.
