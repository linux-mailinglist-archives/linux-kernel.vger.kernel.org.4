Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28F95EAE04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIZRT6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 13:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiIZRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78246EDD09
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 183C360F93
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E22C433B5;
        Mon, 26 Sep 2022 16:33:08 +0000 (UTC)
Date:   Mon, 26 Sep 2022 12:34:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
Message-ID: <20220926123416.6524c88b@gandalf.local.home>
In-Reply-To: <72644F1F-7A13-4CC1-8C24-BE271323FE94@gmail.com>
References: <20220913135213.720368-1-namit@vmware.com>
        <2D09BBFE-45F3-4B9C-8734-D002CA99FD94@gmail.com>
        <Yymds595qthVSnt0@hirez.programming.kicks-ass.net>
        <D0F82355-EB17-46A3-82AA-CC0B26344A08@gmail.com>
        <72644F1F-7A13-4CC1-8C24-BE271323FE94@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 18:31:24 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:

> Commit 45959ee7aa645 (“ftrace: Do not function trace inlined functions”)
> gives two reasons which correspond with what you were saying: (1)
> consistency and (2) function that should not be traced are mostly marked as
> inline.
> 
> I am not sure I fully agree with the arguments, specifically the consistency
> (any function might be inlined and not traceable). But I am too afraid/lazy
> to cause damage and fix it. I will remove the inline and play a bit with the
> kernel to see how it behaves.

The main concern is two fold.

1) In the beginning, the function tracer was very susceptible to recursion
crashes (it's much more robust now), and depending on whether the compiler
decided to inline a function or not, would decide if a recursive function
would crash the kernel or not. It was a nightmare to debug!

2) Consistency. I was tired of getting bug reports that would say "hey
kernel X on machine M1 has function F available for tracing, but kernel X on
machine M2 does not have function F available". It was that the compiler
for M1 did not inline the function where it did for M2.

-- Steve
