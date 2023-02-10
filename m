Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C26691BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBJJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjBJJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:51:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508EA7167A;
        Fri, 10 Feb 2023 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oV4xKsk7lXX7CjGVzoMYBOAyKJn4TjkfME7gpeXO2mQ=; b=a6iqzx6S4qFym6qzT4XsncLZpo
        sPikSyK3HbA55SGymHak2HTZOikjlhfWF5CLZgYt+PxXSspxYKnr2liwgCg+jX+e72x7oA+7eKTkB
        vnrRHJij3Qsc4SxJ0XztvdXrSeIOrh2b7V2DvRh/vwjHeS9gd1m0lYumxS9Ux8yxb1WhCLRxzyehr
        5vjqJJxpDuSqA8ZAkTrECI3vYl7i+lU6+hSDp1nG7sFB4Q2YVJUefsW2dOOXEVRaHTWkLmkAxQiBu
        nXkVvDaWTFkl44jSfSU0rYp7B92qLAOrrVrjUzE69fJcs4R9pWJ8I8v+owsm96LB2msCcELBv6exA
        OmaYGmBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQQ3a-00304B-Ct; Fri, 10 Feb 2023 09:51:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B27730012F;
        Fri, 10 Feb 2023 10:51:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B47C420A1CFBA; Fri, 10 Feb 2023 10:51:00 +0100 (CET)
Date:   Fri, 10 Feb 2023 10:51:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <Y+YThNzVa1ECIuYM@hirez.programming.kicks-ass.net>
References: <20230207135147.5ce618d6@gandalf.local.home>
 <20230207135402.38f73bb6@gandalf.local.home>
 <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
 <20230209232305.672dd0249e0db41552b28763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209232305.672dd0249e0db41552b28763@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:23:05PM +0900, Masami Hiramatsu wrote:

> BTW, currently kprobe event rejects this __pfx_ symbols because it is notrace
> symbols, thus we can trace it if CONFIG_KPROBE_EVENTS_ON_NOTRACE=y.
> But I guess it should not probe that place always because it should never
> executed right?

Execution can take place in those ranges when X86_FEATURE_CALL_DEPTH is
enabled or when CONFIG_KCFI && X86_FEATURE_IBT.

In the first of those cases the prefix bytes are filled with call
accounting instructions and every direct call to $sym is patched to
point to __pfx_$sym+6 (aka $sym-10).

  https://lore.kernel.org/all/20220915111039.092790446@infradead.org/

In the second case (FineIBT) it is probably easiest if you look at the
comment in arch/x86/kernel/alternative.c near CONFIG_FINEIBT.

  https://lore.kernel.org/all/20221027092812.185993858@infradead.org/

The __pfx_ and __cfi_ symbols are the same (in fact, when
CONFIG_CFI_CLANG=y the compiler generates them and objtool no longer
emits the __pfx_ symbols).

  https://lore.kernel.org/all/20221028194453.592512209@infradead.org/
