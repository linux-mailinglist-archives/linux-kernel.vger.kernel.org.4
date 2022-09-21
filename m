Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A75E5606
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiIUWFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIUWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D39E69C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5950362DC1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0702C433C1;
        Wed, 21 Sep 2022 22:05:39 +0000 (UTC)
Date:   Wed, 21 Sep 2022 18:06:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking: Provide a low overhead do_arch_spin_lock()
 API
Message-ID: <20220921180640.032d16fd@gandalf.local.home>
In-Reply-To: <20220921132152.1622616-2-longman@redhat.com>
References: <20220921132152.1622616-1-longman@redhat.com>
        <20220921132152.1622616-2-longman@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 09:21:51 -0400
Waiman Long <longman@redhat.com> wrote:

> There are some code paths in the kernel like tracing or rcu where they
> want to use a spinlock without the lock debugging overhead (lockdep,
> etc). Provide a do_arch_spin_lock() API with proper preemption disabling
> and enabling without any debugging or tracing overhead.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Please don't do this. arch_spin_lock() is very special, and if tracing did
it wrong, then it needs to be fixed in the tracing code.

Let's not add handlers to make it easier to use arch_spin_lock(). Tracing
is special and arch_spin_lock() helps keep it from tracing itself.

-- Steve
