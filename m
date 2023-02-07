Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEE68DCDA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBGPWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjBGPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:22:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E19736681
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:22:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s8so8546912pgg.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MoFBSQBzSf0fT1cCkVolLoLGiXS5UnRqIR10/tmIk94=;
        b=RoIqDNrJkIIHVHTPel0ZaBUhNb0n/kA5KK7s0gplBhuaQyxi1cPqqzpFkQdoZzZsp+
         YvpEiGr1gDnoPafg9nmE0w9Jo7j4ev+mDF7i4pwC/nsXygGihj6arBE3wRR7F7tDLUUP
         xn5QiX9oFg3htVkVXflhc9/qEh5Igqmp7X66k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoFBSQBzSf0fT1cCkVolLoLGiXS5UnRqIR10/tmIk94=;
        b=K5LR0ciTQgkdwJoV++LCqFnVZmq5nPditkEt6+wdBMw25lrxOJmVMs1p+vtdXs+IgR
         8nF3KVqGj2cK2v6cQFcgc8F+jZ/+2/QnvAZ/pfDtVMxoJIKp/T4vvzD4tZlJ6A9BGPeZ
         KvNU3Mfe51i+SFsCv9zFnxbqQdJmukSGxykqc1F0D4XgopIgdraeDrGoclQZUbkE5GSk
         BnRRlwL3v0JHtDYkBjNYkhN9yfDXOcVsvDrZSpa55b0ZKjWhHUNotfQQnjvMLtlu4WVG
         3QVAqwe/88QOxnSetL3Rp6NlZ526VaQkVDPYdbuDeGRrYfet6IxQl0ABr8ACcxW+fr5L
         ts9w==
X-Gm-Message-State: AO0yUKWoBGY7K7wbll0g0IlHJ2N0gfKkljuOgZnfd14ZmM69Yl6LssTi
        Yzwe5vLNpW1okzphALx0pi4RYSroVqKnhzp2n4eOqN3O2GvdCc5eU+A=
X-Google-Smtp-Source: AK7set/0dDymGJs4u4sgWflAsdvJCYNyuErraEjKyIDbTpV24ZUFw+mbiYTq1CpYkfoC+9AvD31u1QIn1095Vh9xPOA=
X-Received: by 2002:a62:3808:0:b0:5a6:5841:6570 with SMTP id
 f8-20020a623808000000b005a658416570mr923337pfa.51.1675783321117; Tue, 07 Feb
 2023 07:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-2-revest@chromium.org>
 <Y9vPAdFBJF/gKXaO@FVFF77S0Q05N.cambridge.arm.com> <CABRcYmLrYXuP-yio0dy4WskENn81Qw2WS0ArMp=rdHuiGyjYhQ@mail.gmail.com>
In-Reply-To: <CABRcYmLrYXuP-yio0dy4WskENn81Qw2WS0ArMp=rdHuiGyjYhQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 7 Feb 2023 16:21:49 +0100
Message-ID: <CABRcYmL7exDGnBTzj-DHLSf49_tz6bSDfjn9CDLO9ZEbfFyh-w@mail.gmail.com>
Subject: Re: [PATCH 1/8] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 6:37 PM Florent Revest <revest@chromium.org> wrote:
>
> On Thu, Feb 2, 2023 at 4:02 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Looking at samples/ftrace/, as of this patch we have a few samples that are
> > almost identical, modulo the function being traced, and some different register
> > shuffling for arguments:
> >
> > * ftrace-direct.c and ftrace-direct-multi.c
> > * ftrace-direct-modify.c and ftrace-direct-modify
> >
> > ... perhaps it would be better to just delete the !multi versions ?
>
> The multi versions hook two functions and the !multi hook just one but
> I agree that this granularity in coverage is probably just a
> maintenance burden and doesn't help with much! :)
> I'll delete the !multi in v2, as part of the patch 2 and patch 1 will
> just migrate the selftest to use the multi API.

Actually, I'm not sure anymore if we should delete the !multi samples...

I realized that they are also used as part of the ftrace selftests in:
- tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
- tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc

It does not really make sense to use the ftrace-direct-muti sample as
a drop-in replacement for the ftrace-direct sample there since they
don't really do the same thing so we would either need to change the
test a bit or the multi sample.
Also, we would still need to adapt the ftrace-direct-too sample since
it has no multi equivalent and is required there.

It's certainly doable but now it feels to me like going one step too
far with the refactoring within the scope of this series. Do you think
it's worth it ? I have 70% of that work done already so I'm happy to
finish it but I thought I should check back before sending a v2 that's
more complex than anticipated.
