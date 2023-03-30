Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13F6D05A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjC3M7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjC3M7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:59:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B6E9EF5;
        Thu, 30 Mar 2023 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UL7W2tzjfyF4OgCjneaPuyZJqekRRwSCQhOyLLp43Jk=; b=nNmNcxwTdfBZooOAXeHgpqbzac
        YmZZ8wDDt2nH3z0jCIVkowr8x23tD6YxwwOAk6rAj8pTshUdDULUJITs7DiMEnPIaQNNw3xdsb/qx
        vSsgqu0QhfwhfmbKxgxIXjHuHfFU5wmgILJMSy7WPBjDxoisImaE5nTo6nCecH1MlxmDov5Gf6gqS
        +v1s0zvqKVRA0nacCNdep+UhUke0JaJ65D8q2wX+C4CNd/qsv56zEftf/ztcO05U10c5QYSgWmK03
        ygAc9exCCi/hEYF8wFxKH4oREB4Ggofzi4H4gbVTTvy+peteD+OVwOOjHTHWplCF33JVEeE1dtUYT
        PM2lo0Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phrsG-00AQFb-3c; Thu, 30 Mar 2023 12:59:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BC07300134;
        Thu, 30 Mar 2023 14:59:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 618F320134244; Thu, 30 Mar 2023 14:59:27 +0200 (CEST)
Date:   Thu, 30 Mar 2023 14:59:27 +0200
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
Message-ID: <20230330125927.GD124812@hirez.programming.kicks-ass.net>
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

> +impl CondVar {
> +    /// Constructs a new condvar initialiser.
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            _pin: PhantomPinned,
> +            // SAFETY: `__init_waitqueue_head` initialises the waitqueue head, and both `name` and
> +            // `key` have static lifetimes so they live indefinitely.
> +            wait_list <- unsafe {
> +                Opaque::ffi_init2(
> +                    bindings::__init_waitqueue_head,
> +                    name.as_char_ptr(),
> +                    key.as_ptr(),
> +                )
> +            },
> +        })
> +    }
> +
> +    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> +
> +        // SAFETY: `wait` points to valid memory.
> +        unsafe { bindings::init_wait(wait.get()) };
> +
> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> +        unsafe {
> +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> +        };

I can't read this rust gunk, but where is the condition test gone?

Also, where is the loop gone to?

> +
> +        // SAFETY: No arguments, switches to another thread.
> +        guard.do_unlocked(|| unsafe { bindings::schedule() });
> +
> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> +        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
> +    }
> +
> +    /// Releases the lock and waits for a notification in interruptible mode.
> +    ///
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep, reacquiring the lock on wake up. It wakes up when notified by
> +    /// [`CondVar::notify_one`] or [`CondVar::notify_all`], or when the thread receives a signal.
> +    /// It may also wake up spuriously.
> +    ///
> +    /// Returns whether there is a signal pending.
> +    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
> +    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
> +        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
> +        Task::current().signal_pending()
> +    }
> +
> +    /// Releases the lock and waits for a notification in uninterruptible mode.
> +    ///
> +    /// Similar to [`CondVar::wait`], except that the wait is not interruptible. That is, the
> +    /// thread won't wake up due to signals. It may, however, wake up supirously.
> +    pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
> +        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard)
> +    }
> +
> +    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
> +    fn notify(&self, count: i32, flags: u32) {
> +        // SAFETY: `wait_list` points to valid memory.
> +        unsafe {
> +            bindings::__wake_up(
> +                self.wait_list.get(),
> +                bindings::TASK_NORMAL,
> +                count,
> +                flags as _,
> +            )
> +        };
> +    }
> +
> +    /// Wakes a single waiter up, if any.
> +    ///
> +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> +    /// completely (as opposed to automatically waking up the next waiter).
> +    pub fn notify_one(&self) {
> +        self.notify(1, 0);
> +    }
> +
> +    /// Wakes all waiters up, if any.
> +    ///
> +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> +    /// completely (as opposed to automatically waking up the next waiter).
> +    pub fn notify_all(&self) {
> +        self.notify(0, 0);
> +    }
> +}
