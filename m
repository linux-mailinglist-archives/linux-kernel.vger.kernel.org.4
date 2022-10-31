Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54117613AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiJaPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiJaPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:47:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E86091261F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:47:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF3CA1FB;
        Mon, 31 Oct 2022 08:47:18 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.5.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D05D3F5A1;
        Mon, 31 Oct 2022 08:47:11 -0700 (PDT)
Date:   Mon, 31 Oct 2022 15:47:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH 3/4] ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
Message-ID: <Y1/t/NklI6/LS26Y@FVFF77S0Q05N>
References: <20221024140846.3555435-1-mark.rutland@arm.com>
 <20221024140846.3555435-4-mark.rutland@arm.com>
 <20221025174001.cf5a189a23aaeadc2c8887a2@kernel.org>
 <Y1e6znjOHCFGvLND@FVFF77S0Q05N>
 <20221026001754.3a7dba42b8d3633d335283ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026001754.3a7dba42b8d3633d335283ef@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:17:54AM +0900, Masami Hiramatsu wrote:
> On Tue, 25 Oct 2022 11:30:38 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, Oct 25, 2022 at 05:40:01PM +0900, Masami Hiramatsu wrote:
> > > Hi Mark,
> > > 
> > > On Mon, 24 Oct 2022 15:08:45 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > In subsequent patches we'll arrange for architectures to have an
> > > > ftrace_regs which is entirely distinct from pt_regs. In preparation for
> > > > this, we need to minimize the use of pt_regs to where strictly necessary
> > > > in the core ftrace code.
> > > > 
> > > > This patch adds new ftrace_regs_{get,set}_*() helpers which can be used
> > > > to manipulate ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y,
> > > > these can always be used on any ftrace_regs, and when
> > > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n these can be used when regs are
> > > > available. A new ftrace_regs_has_args(fregs) helper is added which code
> > > > can use to check when these are usable.
> > > 
> > > Can you also add the ftrace_regs_query_register_offset() as a wrapper of
> > > regs_query_register_offset()? I would like to use it for fprobe_events.
> > 
> > Sure!
> > 
> > Just to check, with FTRACE_WITH_REGS, does fprobe always sample the full
> > pt_regs, or do callers also need to check ftrace_regs_has_args(fregs)?
> 
> No, please return -ENOENT or any error value if the given register
> is not saved on arm64.

Sure, that's what I intend to implement for arm64. I'll use -EINVAL to match
the existing regs_query_register_offset() logic.

> Others will just return regs_query_register_offset(&fregs->regs, name). That
> is enough at this moment. Later we can improve it.

Sorry, what I was trying to ask was whether fprobe currently always set
FTRACE_OPS_FL_SAVE_REGS (which AFAICT it does); so I now agree that's
sufficient -- sorry for the noise!

Thanks,
Mark.
