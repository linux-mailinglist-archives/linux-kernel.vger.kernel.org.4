Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3260CD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiJYNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiJYNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:21:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1B100BE3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:21:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s22-20020a17090a075600b002130d2ad62aso5190255pje.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8KtedNQ3fP0U8VQoj6DrMRW+x6Fkh+uxmHkaye/9oY=;
        b=i2VqmPfuFtqcpxui+WXnUeaQHFbY+mNQQFVteeXRhH05pS1/FxRLx5HI6f2v+6yemA
         pORtulEl1ySw1U+5vlbsoUMXNGp4IiHdA59adeefoZxW69YflKiU+gDG6XI2fCn6XSbw
         IAU26gCCosfcWefCa5Hlzf6DHdGQAio3bfVls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8KtedNQ3fP0U8VQoj6DrMRW+x6Fkh+uxmHkaye/9oY=;
        b=edUss8xvDxxd/UI0y5VVYbVQ9yqhUpSq+Ml6mGdFO7wbTxGuw6TO8vVcH0yKibLBXE
         0DkqO9BhP5t/XCOyt2vXJvlxo86Iz6VkNwcJ6BTjSqDIehOwrD2/mIe6T53Uz+SrPK7c
         E3SbwNWgAX3KwiYfum1hsNNkBtanRNg2hiE9l9xT9KvYSXxkvCq48qq1YK6O8P8BPrkK
         deMZCXoHy7TVdL4ruPCMrUwEJDuBaprZ2RmF39l9yulNQD+OpjqGAsHJF/6zk5332VY6
         vBsuq7JBhbWHXks+QHkuPNt051aL57ziB/jJ2HiyFWHXIA3IREjnYTpPYVOsZbUHThYb
         ARtA==
X-Gm-Message-State: ACrzQf1nHDhxhYUAJ7aLLOCWU2Jmoy+XiPZCNAg0aCJktv4Sluf/h08I
        ayvVPQKV7Zwmt2HY06KmI5dDHfHafrQ8oQdxvvK/ow==
X-Google-Smtp-Source: AMsMyM6wIv78d+d+lx3JBhsboCfWmDSd/1f7T+KXPZgpdj1ITrvQJoc+cYXw4El6kOCR8bBZOVzLP7lAIrkGoREchCU=
X-Received: by 2002:a17:902:f1cc:b0:186:6670:e3da with SMTP id
 e12-20020a170902f1cc00b001866670e3damr26936213plc.41.1666704069128; Tue, 25
 Oct 2022 06:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221024140846.3555435-1-mark.rutland@arm.com>
 <20221024140846.3555435-4-mark.rutland@arm.com> <20221025174001.cf5a189a23aaeadc2c8887a2@kernel.org>
 <Y1e6znjOHCFGvLND@FVFF77S0Q05N>
In-Reply-To: <Y1e6znjOHCFGvLND@FVFF77S0Q05N>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 25 Oct 2022 15:20:57 +0200
Message-ID: <CABRcYm+JREGhH+S+it0XQ8qWfa3Px68=LDZCf9vT=roZpztsXg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:30 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 25, 2022 at 05:40:01PM +0900, Masami Hiramatsu wrote:
> > Hi Mark,
> >
> > On Mon, 24 Oct 2022 15:08:45 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > > In subsequent patches we'll arrange for architectures to have an
> > > ftrace_regs which is entirely distinct from pt_regs. In preparation for
> > > this, we need to minimize the use of pt_regs to where strictly necessary
> > > in the core ftrace code.
> > >
> > > This patch adds new ftrace_regs_{get,set}_*() helpers which can be used
> > > to manipulate ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y,
> > > these can always be used on any ftrace_regs, and when
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n these can be used when regs are
> > > available. A new ftrace_regs_has_args(fregs) helper is added which code
> > > can use to check when these are usable.
> >
> > Can you also add the ftrace_regs_query_register_offset() as a wrapper of
> > regs_query_register_offset()? I would like to use it for fprobe_events.
>
> Sure!
>
> Just to check, with FTRACE_WITH_REGS, does fprobe always sample the full
> pt_regs, or do callers also need to check ftrace_regs_has_args(fregs)?

Currently, we have:
config FPROBE
    depends on DYNAMIC_FTRACE_WITH_REGS

Because fprobe registers its ftrace ops with FTRACE_OPS_FL_SAVE_REGS
and calls ftrace_get_regs() to give pt_regs to registered fprobe
callbacks.

We'll need to refactor fprobe a bit to support ||
DYNAMIC_FTRACE_WITH_ARGS and therefore work on arm64.

> I ask because if neither of those are the case, with FTRACE_WITH_REGS,
> ftrace_regs_query_register_offset() would accept names of registers which might
> not have been sampled, and could give offsets to uninitialized memory.

Indeed, if one were to call the regs_query_register_offset() on a
pt_regs that comes out of a ftrace trampoline with FTRACE_WITH_REGS,
for example in a fprobe callback, one could get offsets to
uninitialized memory already (for the registers we can't get outside
of an exception handler on arm64 for example iiuc)

And it'd get way worse with FTRACE_WITH_ARGS if we implement
ftrace_regs_query_register_offset() by calling
regs_query_register_offset() for ftrace_regs that contain sparse
pt_regs.

> Atop that, I'm not exactly sure what to implement for powerpc/s390/x86 here. If
> those might be used without a full pt_regs, I think
> ftrace_regs_query_register_offset() should also take the fregs as a parameter
> and use that to check which registers are available.

I think it would make sense for a ftrace_regs_query_register_offset()
to only return offsets to the registers that are actually saved by the
arch in a ftrace_regs (whether that's WITH_ARGS or WITH_REGS).

But that also means that if we introduce "fprobe_events" in the
tracing sysfs interface, we can't have it support a %REG syntax
compatible with the one in "kprobe_events" anyway.

Masami, how about having "fprobe_events" only support $argN, $retval
etc but no %REG, from the beginning ? Then it would be clear to users
that fprobe can not guarantee registers and we'd never have to fake
registers when we don't have them. Users would have to make a decision
between using fprobe which is fast but only has arguments and return
value and kprobe which is slow but has all registers.

I realize this has consequences for the kretprobe and rethook
unification plan but if we have fprobe_events support %REG at the
beginning, we'd have to break it at some point down the line anyway
right ?

> ... does that make sense to you?
>
> Thanks,
> Mark.
