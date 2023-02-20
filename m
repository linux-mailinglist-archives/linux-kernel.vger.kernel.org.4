Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAE69C8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBTKgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjBTKgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:36:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E54EE18AA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:36:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C64415BF;
        Mon, 20 Feb 2023 02:36:53 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE29C3F703;
        Mon, 20 Feb 2023 02:36:08 -0800 (PST)
Date:   Mon, 20 Feb 2023 10:35:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor.dooley@microchip.com,
        penberg@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
Message-ID: <Y/NNDXlXth2HgSUf@FVFF77S0Q05N>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
 <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
 <Y9juYX8Bt1Z55lv0@FVFF77S0Q05N>
 <20230217002351.112635f4fb35f84002666d29@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217002351.112635f4fb35f84002666d29@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:23:51AM +0900, Masami Hiramatsu wrote:
> On Tue, 31 Jan 2023 10:33:05 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, Jan 31, 2023 at 09:48:29AM +0800, Guo Ren wrote:
> > > On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Masami, Steve, and I had a chat at the tracing summit late last year (which
> > unfortunately, was not recorded), and what we'd like to do is get each
> > architecture to have FPROBE (and FTRACE_WITH_ARGS), at which point OPTPROBE
> > and KRETPROBE become redundant and could be removed.
> 
> No, the fprobe will replace the KRETPROBE but not OPTPROBE. The OPTPROBE
> is completely different one. Fprobe is used only for function entry, but
> optprobe is applied to the function body.

Sorry, I had OPTPROBE and KPROBE_ON_FTRACE confused in my head, and was
thinking that FPROBE would supersede KPROBE_ON_FTRACE and KRETPROBE.

> > i.e. we'd keep KPROBES as a "you can trace any instruction" feature, but in the
> > few cases where OPTPROBES can make things fater by using FTRACE, you should
> > just use that directly via FPROBE.
> 
> I think what you are saying is KPROBE_ON_FTRACE, and that will be replaced by
> FPROBES.

Yes, sorry for the confusion.

Mark.
