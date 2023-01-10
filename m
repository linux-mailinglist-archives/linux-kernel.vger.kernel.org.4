Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382E663E46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjAJKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjAJKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:32:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D5F4086E;
        Tue, 10 Jan 2023 02:31:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A8A1FB;
        Tue, 10 Jan 2023 02:32:40 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.46.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666273F587;
        Tue, 10 Jan 2023 02:31:56 -0800 (PST)
Date:   Tue, 10 Jan 2023 10:31:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "revest@chromium.org" <revest@chromium.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH 0/8] arm64/ftrace: Add support for
 DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Y70+lFP5pegv10Nc@FVFF77S0Q05N>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <34e0144b19e149d99719a5ffc834f228@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e0144b19e149d99719a5ffc834f228@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:55:58AM +0000, David Laight wrote:
> From: Mark Rutland
> > Sent: 09 January 2023 13:58
> > 
> > This series adds a new DYNAMIC_FTRACE_WITH_CALL_OPS mechanism, and
> > enables support for this on arm64. This significantly reduces the
> > overhead of tracing when a callsite/tracee has a single associated
> > tracer, avoids a number of issues that make it undesireably and
> > infeasible to use dynamically-allocated trampolines (e.g. branch range
> > limitations), and makes it possible to implement support for
> > DYNAMIC_FTRACE_WITH_DIRECT_CALLS in future.
> > 
> > The main idea is to give each ftrace callsite an associated pointer to
> > an ftrace_ops. The architecture's ftrace_caller trampoline can recover
> > the ops pointer and invoke ops->func from this without needing to use
> > ftrace_ops_list_func, which has to iterate through all registered ops.
> > 
> > To do this, we use -fpatchable-function-entry=M,N, there N NOPs are
> > placed before the function entry point...
> 
> Doesn't this bump the minimum gcc version up to something like 9.0 ?

This doesn't bump the minimum GCC version, but users of older toolchains
won't get the speedup.

We already support -fpatchable-function-entry based ftrace with GCC 8+ (and
this is necessary to play nicely with pointer authentication), for older GCC
versions we still support using -pg / mcount.

> How does it interact with the 'CFI stuff' that also uses the same area?

There's some more detail in patch 8, but the summary is that they're mutually
exclusive for now (enforce by Kconfig), and I'm working with others to get
improved compiler support necessary for them to play nicely together.

Currently LLVM will place the type-hash before the pre-function NOPs, which
works if everything has pre-function NOPs, but doesn't work for calls between
instrumented and non-instrumented functions, since as the latter don't have
pre-function NOPs and the type hash is placed at a different offset. To make
them work better together we'll need some improved compiler support, and I'm
working with others for that currently.

GCC doesn't currently have KCFI support, but the plan is to match whatever LLVM
does.

Atop that we'll need some trivial changes to the asm function macros, but
without the underlying compiler support there's not much point.

Thanks,
Mark.
