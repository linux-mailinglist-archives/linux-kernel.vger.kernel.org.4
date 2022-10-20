Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1602606394
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJTOw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJTOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:52:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135511863FE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:52:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o65so17387903iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L4hC9xGAPxQZK0b7bUDieO83ecxw1p3pbelv9V7cXUE=;
        b=mJFzX/MYGHQausLER1disvCySU5IsbiOGNpnZQdLOhunHlcu9naeG82VJopHZVmYb2
         ZrqTwJim0Pg2iAxYPsjSonVlRPTECrKL4L2EDn1kQ55hz1FXzbwg1GusMiRUmiCD9ec8
         KQl1EAMkQSAQF0K7w1DuXL/dwy0fg6UBiOfNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4hC9xGAPxQZK0b7bUDieO83ecxw1p3pbelv9V7cXUE=;
        b=E0Tq6W8X/kH2y1dEQcs3fBdCl2JhXa6wy/M1ExUdJuYsVrz0Ojnqd1c+PknN/bKPVp
         lfk0TUyCxfSwVYixa0HN+xtaQfZLfJKCm6NxN39/zXEa5Kna864BzYnhbutQAzmMrWFQ
         qSsBK3eXQwJJsHBP1zMQNguJrM5na8qufeLJbPdXW1uj0/PiaJ75sP3nn9nF/wbfgY+p
         r/XjmaWjcfeW2NePQj3a1DQKewCQ8O6O9De+Hz3JE77uoRjSXooOssmrqXnHoyv4PDsj
         1oEXinhVExQBTM0y0bBRsCdhHwJdM31ES+4KGKzBr4WaIj18zdv4Y6nhaKrgQ262BeBN
         icgw==
X-Gm-Message-State: ACrzQf3Xd3ceBRtpeNyyxQx53JeeQUdaOUA+ukJ0V0DvPlH1RBc4om3R
        ZDYaFCCFHhA+Vc/2VbFdxQDyZc2eaj++sM58gRAEXg==
X-Google-Smtp-Source: AMsMyM5ganyMmZ1UMPapAiJ/WR3vvmTKM7Y9nURp1HnOcWWxo1jVJJIh/3UnzP0l22Tv2wnt+XPGBo7CF7AZVEJ3Gwk=
X-Received: by 2002:a05:6638:408b:b0:364:768:e8c2 with SMTP id
 m11-20020a056638408b00b003640768e8c2mr11153145jam.107.1666277535606; Thu, 20
 Oct 2022 07:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221019200137.70343645@gandalf.local.home> <CAEXW_YQ-fr7fG-cqHuaKVD8neV+avkwrGf_f_XPG33qzO97Wog@mail.gmail.com>
In-Reply-To: <CAEXW_YQ-fr7fG-cqHuaKVD8neV+avkwrGf_f_XPG33qzO97Wog@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 20 Oct 2022 10:52:04 -0400
Message-ID: <CAEXW_YQF_TaTxqwAj7xUjw6U_zDLSQpfhBq-=6WvAH=u3Z_t=A@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:43 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Steven,
>
> On Wed, Oct 19, 2022 at 8:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > Allow triggers to be enabled at kernel boot up. For example:
> >
> >   trace_trigger="sched_switch.stacktrace if prev_state == 2"
> >
> > The above will enable the stacktrace trigger on top of the sched_switch
> > event and only trigger if its prev_state is 2 (TASK_UNINTERRUPTIBLE). Then
> > at boot up, a stacktrace will trigger and be recorded in the tracing ring
> > buffer every time the sched_switch happens where the previous state is
> > TASK_INTERRUPTIBLE.
> >
> > As this calls into tracepoint logic during very early boot (before
> > interrupts are enabled), a check has to be done to see if early boot
> > interrupts are still disabled, and if so, avoid any call to RCU
> > synchronization, as that will enable interrupts and cause boot up issues.
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
>
> rest_init() -> rcu_scheduler_starting() sets RCU_SCHEDULER_INIT
>
> start_kernel() disables interrupts and does the dance you mentioned,
> while setting that early_ flag. start_kernel() is called from arch
> code.
>
> From your crash, the trace trigger is happening before the early_ boot
> flag is set to true.

My apologies. I meant, before early_boot_irqs_disabled is set to false.
