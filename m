Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876816D0551
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjC3Mwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjC3Mwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:52:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1CC55B7;
        Thu, 30 Mar 2023 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LbriNcVAfY0UBPuz6jCJeTcqNiFUFNZB08aDLtgpT/A=; b=G+wU3ww+N8ZKrDEEm+k3MVeXsp
        AozFQ/e5GK+eLPLTHEo0asbNced1a6eoDaynCcHy5mXw8pwX0oUcequD4vH5zwIgaL4AVLSL5qOJW
        /AiQXMF7g+VF11RkCM9+cxbFHifxKqHN0+EWjyxOb06hSZU6pd2sYpQqvliROc68NT7M50FA4yR/4
        sbSf5HhDp1axHNCwOy4mCxQYyOj9wTvVESS2CgRTpFTF2RMxi0zoQGF2S3q9JXzzZfu2l7nQAAHgE
        yfS5B9zCf0f2TXmC1av0tDEslPFeHeaWPu2N5lkT5/5A0ZSeNpwI8SqiUNSkaSj30Uco8HuKZmmHF
        nRS9J40Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phrlQ-00APu7-0Q; Thu, 30 Mar 2023 12:52:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 716AE300134;
        Thu, 30 Mar 2023 14:52:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5101920134244; Thu, 30 Mar 2023 14:52:23 +0200 (CEST)
Date:   Thu, 30 Mar 2023 14:52:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 12/13] rust: sync: introduce `CondVar`
Message-ID: <20230330125223.GC124812@hirez.programming.kicks-ass.net>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-12-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330043954.562237-12-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 01:39:53AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is the traditional condition variable or monitor synchronisation
> primitive. It is implemented with C's `wait_queue_head_t`.
> 
> It allows users to release a lock and go to sleep while guaranteeing
> that notifications won't be missed. This is achieved by enqueuing a wait
> entry before releasing the lock.
> 

> +/// A conditional variable.
> +///
> +/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
> +/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
> +/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
> +/// [`CondVar::notify_all`]) or because the thread received a signal. It may also wake up
> +/// spuriously.

Urgh so wide :-/

But no, threads can *always* and for any reason, have spurious wakeups.

Also, is this hard tied to mutex? If so, you should probably use swait
instead of wait.
