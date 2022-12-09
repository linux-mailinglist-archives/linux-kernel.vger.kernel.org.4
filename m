Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FF648177
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiLILRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLILQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:16:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B36B6FF0F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:16:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AFCA23A;
        Fri,  9 Dec 2022 03:16:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.39.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C089A3F73B;
        Fri,  9 Dec 2022 03:16:36 -0800 (PST)
Date:   Fri, 9 Dec 2022 11:16:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: Prohibit instrumentation on
 arch_stack_walk()
Message-ID: <Y5MZEhIpBYd81lZV@FVFF77S0Q05N>
References: <166994750386.439920.1754385804350980158.stgit@devnote3>
 <166994751368.439920.3236636557520824664.stgit@devnote3>
 <Y4n66ioPq0BZF4Pi@FVFF77S0Q05N>
 <20221206094137.389e4c374f4be060af19f33a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206094137.389e4c374f4be060af19f33a@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:41:37AM +0900, Masami Hiramatsu wrote:
> On Fri, 2 Dec 2022 13:17:30 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> > I had a go at testing this patch, and it fixes the crash with the reproducer
> > above, but there are plenty of other instances in stacktrace.c that lead to the
> > same sort of crash, e.g.
> > 
> > # echo p stackinfo_get_task >> ${TRACEFS}/kprobe_events
> > # echo 1 > ${TRACEFS}/events/kprobes/enable
> 
> Oops, thanks for pointing! Hmm, I thought stackinfo_get_task() is an
> inlined function usually. Maybe we should make it nokprobe_inline.
> But this is just one case. I need to scan all symbols to trace...

FWIW, due to other instrumentation issues I've started doing a larger noinstr
cleanup on arm64 which should address this, as fixing this properly involves
also modifying a bunch of underlying helpers (e.g. preempt_count()).

I can Cc you when sending that out, if you'd like? That'll probably be in the
new year.

Thanks,
Mark.
