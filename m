Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E6744AC9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGASBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGASBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:01:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B9919B7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 11:01:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688234462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffUL6AuqBbv/oAgPmf6xSbMiUnyyc6NBmi2IZwk4Jw8=;
        b=wI4v+eqt1BDE/7iODtZTUIjacN0KQ4lIbfzlpHp/A9oVV+50ZoI7adt7kV8OW2TaaJdUXG
        RKVlofajPCI9r7nWYvd284/2bczvGMwYJcF2PjgzdvRZBv0nXeNlL3lpBDRQydK6kjwn0C
        MC+/Exsc6w4G/RsLyPWMOuHLzyInCuwxDGBnwUA+Iapu6Z2vfRszRBHQ9SLmfRCVOHVlA0
        4qF/SW4K1zs72qjTBgNcWI/kv1OLxwXPuk2PkkYYoVmqlrd5IfS0He1F7zBiURx2Gcuao/
        gubvSsRRQH8IaW8QhZ858c4/hwwGss/jGuQTDEgfQetMbeopD57LZGMl6j/EKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688234462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffUL6AuqBbv/oAgPmf6xSbMiUnyyc6NBmi2IZwk4Jw8=;
        b=ceRZEItGp9k3IKJOXgJV85owqjTCXkwy5nppK1MbfTr2ThdelTycC+HCuxLIL7mQKgrIzM
        Riu4oHkPaRx3LqCw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 14/45] posix-timers: Consolidate interval retrieval
In-Reply-To: <ZJ7g1NvmxnKqCLC9@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.816970056@linutronix.de>
 <ZJww66Svi84Bvw9Z@localhost.localdomain> <87ttuq14xp.ffs@tglx>
 <ZJ67nQ6Q8F3mu6Jb@lothringen> <875y75yu7u.ffs@tglx>
 <ZJ7g1NvmxnKqCLC9@lothringen>
Date:   Sat, 01 Jul 2023 20:01:01 +0200
Message-ID: <87bkgvy0iq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30 2023 at 16:04, Frederic Weisbecker wrote:
> On Fri, Jun 30, 2023 at 03:07:17PM +0200, Thomas Gleixner wrote:
>> How exactly does this end up being copied to user space if ret != 0?
>
> kc->timer_get() doesn't return any value.
>
> So before the patch, interval is retrieved only if the target is not reaped:
>
> timer_gettime() {
>     do_timer_gettime() {
>         posix_cpu_timer_get() {
>             p = cpu_timer_task_rcu(timer);
>             if (p)
>                 itp->interval = ....
>         }
>     }
> }
>
> After the patch it's retrieved unconditionally:
>
> timer_gettime() {
>     do_timer_gettime() {
>         //unconditionally set
>         itp->interval = ....
>         posix_cpu_timer_get() {
>             p = cpu_timer_task_rcu(timer);
>             if (!p)
>                 //doesn't return any value so no failure reported

Duh. you are right ...
