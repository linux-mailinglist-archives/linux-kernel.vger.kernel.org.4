Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463FC6DF715
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDLNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDLNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E245272
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZOpVsBLi+QPCjVijyE4qoD9CwMV07gYwgw6yzHIKbL4=; b=C9rIX4ON3O2xfHHNQbIz10igWB
        HRO1ciN9LO1/OsPlWUUYIa27fkMUQ8Hq2untQ2+p/BzyqMazMDE45kW8l6oIZrFdx8/J32V7XBlmt
        Y+1r5rplAALwNUBjdR9pJdUBIREyJ+JoOMgGwG/Kg3JLJpOIpE2wkI6vCv8Q8AVhVXgBtepY6q1kr
        uoTwngsEexnSknqEJKcWfDlpbfks7KTtDuvMEm8evIjTtTKEuVzfJBc3HYMfbqzYrHR+T/5IbF8ie
        Px82+T9dh5AyvRiM8v8u6JPk1x9erF52OP7LcPZ8juLKk3hkaY/MbN3md3NX8iYEvjdod8egxaryI
        pDPZjnIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmaRc-006tjv-Fp; Wed, 12 Apr 2023 13:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80A203002A6;
        Wed, 12 Apr 2023 15:23:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6795625E5A3B1; Wed, 12 Apr 2023 15:23:27 +0200 (CEST)
Date:   Wed, 12 Apr 2023 15:23:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Message-ID: <20230412132327.GA629496@hirez.programming.kicks-ass.net>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
 <20230412131533.GH628377@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412131533.GH628377@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:15:33PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 07, 2023 at 10:08:22PM -0700, Josh Poimboeuf wrote:
> > On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
> > > Make __get_wchan() use arch_stack_walk() directly to
> > > avoid open-coding of unwind logic.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > Can we just have a shared version of __get_wchan() for all
> > CONFIG_ARCH_STACKWALK arches?
> 
> Didn't I do that a while back ? I can't seem to actually find the
> patch-set though :/

Could be this series:

  https://lkml.kernel.org/r/20211022150933.883959987@infradead.org

And this here:

  https://lore.kernel.org/lkml/CAHk-=wjHbKfck1Ws4Y0pUZ7bxdjU9eh2WK0EFsv65utfeVkT9Q@mail.gmail.com/

might be why I dropped it.. I can't remember.
