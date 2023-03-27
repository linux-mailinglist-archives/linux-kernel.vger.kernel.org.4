Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2569D6CA163
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjC0K2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjC0K1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:27:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3144AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yb2808RVvtr1c/zy1MjoBjgEof73gxJO5E1QJR1tBi4=; b=OMmZ/uakblLjWj4Yva6f/FfLRl
        JGdKB3Ewa5GQ1geU0QlL+Ai5Rl8ybAetcgWI/V9FOrS4+E0hyHauF6VNUNbkZmar5czU4ff02OXv3
        Dpi1hZS9h8QtnZbqMIQlgeAq/OgT2rWKrDpgR6SZdIVTCQ9rDr5jFnfC5NeTIkPPkEajVCwhCdrT6
        B0nZpT/DBQJgAIqvoy7fe310i9WlsEd/oXy1OZBSgzPlZM6JXW3YJ3CjHpWIKeplwQ45mjj02ZvN+
        Ropke+z/MIH1iHDus1x2pwtzpdIiR8Xnq+ZpuKUmi9Bp8JmNTE2yltvtZ8Owh79Ge9NhSwdAT5zdm
        CFIaryWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgk4L-007JZO-1X; Mon, 27 Mar 2023 10:27:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 751F2300289;
        Mon, 27 Mar 2023 12:27:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42046202F7F75; Mon, 27 Mar 2023 12:27:15 +0200 (CEST)
Date:   Mon, 27 Mar 2023 12:27:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/6 v5 RESEND] seccomp: add the synchronous mode for
 seccomp_unotify
Message-ID: <20230327102715.GA7701@hirez.programming.kicks-ass.net>
References: <20230308073201.3102738-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:31:55PM -0800, Andrei Vagin wrote:

> Kees is ready to take this patch set, but wants to get Acks from the
> sched folks.
> 

> Andrei Vagin (4):
>   seccomp: don't use semaphore and wait_queue together
>   sched: add a few helpers to wake up tasks on the current cpu
>   seccomp: add the synchronous mode for seccomp_unotify
>   selftest/seccomp: add a new test for the sync mode of
>     seccomp_user_notify
> 
> Peter Oskolkov (1):
>   sched: add WF_CURRENT_CPU and externise ttwu

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
