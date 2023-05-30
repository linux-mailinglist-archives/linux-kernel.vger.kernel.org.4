Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72C715845
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjE3IVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjE3IVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDBB109
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685434822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aY2YSl5uzQn0bKr7cqCprNBdKjjsdiQdkTd6UGejfIg=;
        b=I1Q2v6+8HGpmxoC1MSkl7NZ0pnKZ1X+m6tNnaUAxKvdn6VqxH6Cr9tQv6Et22bOkQ2Pg3h
        2CTBG1ayh93uGWH3R1E/rSF3iK+iNBxuPWbFYGAFHW0fxMsLiuthWapPR+FFzkOiZXxQSC
        QEPF46UoCfdEXv/z6sU2N3XgjiznBgY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-u4FfI7ntMvK-QHMx1h318Q-1; Tue, 30 May 2023 04:20:17 -0400
X-MC-Unique: u4FfI7ntMvK-QHMx1h318Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CD503C0D843;
        Tue, 30 May 2023 08:20:16 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E89BF40CFD45;
        Tue, 30 May 2023 08:20:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>, longman@redhat.com
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
        <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
        <87wn0r6id9.fsf@oldenburg.str.redhat.com>
        <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
Date:   Tue, 30 May 2023 10:20:09 +0200
In-Reply-To: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 29 May 2023 15:48:44 -0400")
Message-ID: <87sfbew7ra.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

>> I don't see why we can't stick this directly into struct rseq because
>> it's all public anyway.
>
> The motivation for moving this to a different cache line is to handle
> the prior comment from Boqun, who is concerned that busy-waiting
> repeatedly loading a field from struct rseq will cause false-sharing
> and make other stores to that cache line slower, especially stores to
> rseq_cs to begin rseq critical sections, thus slightly increasing the
> overhead of rseq critical sections taken while mutexes are held.

Hmm.  For context, in glibc, we have to place struct rseq on a fixed
offset from the start of a page (or even some larger alignment) for all
threads.  In the future (once we move the thread control block off the
top of the userspace stack, where it resides since the LinuxThreads
days), it is likely that the pointer difference between different
threads will also be a multiple of a fairly large power of two
(something like 2**20 might be common).  Maybe this will make caching
even more difficult?

> If we want to embed this field into struct rseq with its own cache
> line, then we need to add a lot of padding, which is inconvenient.
>
> That being said, perhaps this is premature optimization, what do you
> think ?

Maybe?  I don't know how the access patterns will look like.  But I
suspect that once we hit this case, performance will not be great
anyway, so the optimization is perhaps unnecessary?

The challenge is that once we put stuff at fixed offsets, we can't
transparently fix it later.  It would need more auxv entries with
further offsets, or accessing this data through some indirection,
perhaps via vDSO helpers.

>> The TID field would be useful in its own right.
>
> Indeed, good point.
>
> While we are there, I wonder if we should use the thread_pointer() as
> lock identifier, or if the address of struct rseq is fine ?

Hard to tell until we'll see what the futex integration looks like, I
think.

Thanks,
Florian

