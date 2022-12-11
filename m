Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74C649246
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 04:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLKDaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 22:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 22:30:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6912749
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 19:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B91F160D27
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F97C433EF;
        Sun, 11 Dec 2022 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670729433;
        bh=wRIobwquSy08Tv0LJs3ziIB87YrLx/8nhlifA+ng4tI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=COwvuUMhLT1w595/Z62ZeDhM3fgXSsL9WJGnzmuog5Rd3DY87jZre81QsY0v9uRVQ
         atmFGugj0dHYz8J2FtejpBu+P0NVXRMh1sSrdatvYr5Mw5pzunI4qPNt47zqTDdg2+
         YWL6kVhzgzXF0eiNblr8S+vBNyvWTA7epWJNG0EraOv7eOCtb1APygannpY7q2HwkG
         OAytKPRissF7j0Yq0j4Gi4LVzVcAQrVm9LtmqCWX8yrjyQ3wO3N5ju6sK8BQ2cMn+2
         QmifXw1Kz2OSgRedSoS+iYO24QIxKlzvibIPiDMnsqN2nkgChaxmB2r8OWjiaklRGn
         DLPo1NuYFUGaA==
Date:   Sun, 11 Dec 2022 12:30:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: Prohibit instrumentation on
 arch_stack_walk()
Message-Id: <20221211123028.3b1aa794a1bcaf7f6dc92ac3@kernel.org>
In-Reply-To: <Y5MZEhIpBYd81lZV@FVFF77S0Q05N>
References: <166994750386.439920.1754385804350980158.stgit@devnote3>
        <166994751368.439920.3236636557520824664.stgit@devnote3>
        <Y4n66ioPq0BZF4Pi@FVFF77S0Q05N>
        <20221206094137.389e4c374f4be060af19f33a@kernel.org>
        <Y5MZEhIpBYd81lZV@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 11:16:34 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Dec 06, 2022 at 09:41:37AM +0900, Masami Hiramatsu wrote:
> > On Fri, 2 Dec 2022 13:17:30 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > > I had a go at testing this patch, and it fixes the crash with the reproducer
> > > above, but there are plenty of other instances in stacktrace.c that lead to the
> > > same sort of crash, e.g.
> > > 
> > > # echo p stackinfo_get_task >> ${TRACEFS}/kprobe_events
> > > # echo 1 > ${TRACEFS}/events/kprobes/enable
> > 
> > Oops, thanks for pointing! Hmm, I thought stackinfo_get_task() is an
> > inlined function usually. Maybe we should make it nokprobe_inline.
> > But this is just one case. I need to scan all symbols to trace...
> 
> FWIW, due to other instrumentation issues I've started doing a larger noinstr
> cleanup on arm64 which should address this, as fixing this properly involves
> also modifying a bunch of underlying helpers (e.g. preempt_count()).
> 
> I can Cc you when sending that out, if you'd like? That'll probably be in the
> new year.

Thanks Mark, yes, I'm interested in that work.
Until that, I'll finish making a script for testing kprobes widely on
kernel symbols.

Thank you,

> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
