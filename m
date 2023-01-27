Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CA67E53D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjA0MbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjA0MbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:31:11 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEE125B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:30:51 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id k6so5159809vsk.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXbOCedr4ccvyqpszsqisN3gP/KXsEPBbDm+6PhPw+w=;
        b=YcTi3X41qXIaRCCbar1ly9AA5KzI6kHA1iP9KOSX0YMRiMWBJ5hn0HvZecpLg3zNaL
         wcBzG8EaA8lE/RmzmHduWCy/30TaGc5jmTaRb9o4s6HGWtRMWLvxVz5iNSwXmlTMoFgs
         3RYwzZg9aektP97POZ5GTd0Yq2oYCnBhZTsaISfCSYuwrub+ygFfTJ58csFVpavwi8mc
         jm3FbsO/Pj0oputYsRGESxvmidoK+nbyRAu2nleU/HA5z0X8qmec5oH/AjVKfo1rdry0
         q+P/yTzoPGlC5MQT5JXkSovZPq16zK5UREYZWQfCFtSGm17sZ0GQtlKkaSkk/GP1dm9H
         w6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXbOCedr4ccvyqpszsqisN3gP/KXsEPBbDm+6PhPw+w=;
        b=VYacehHjoTt9VUSZ6oGaEaY8yYeio6ImPsSzKvgXocOi0/O2GLLzlbVDBut6XnOVhm
         VoF58VQqnScPzsxOD7/Kar2Fzhp67weTplnCwqbuFmDuKz3XxwzGUHRKbp2tSvit+dpm
         nV8O9lbVLvBxGzPbVVNPkXNAuwNEeYYawXrHWnFs6TVoizD9Rc0t4V0rvP6La6QIWyBA
         vwJcN/Eg+C/DeMgVOnrbdwSYaZVQtIJlMGnEQn4W8J4WRC42+OybRvgzG1Ljrme4yEPW
         FgPgiulTs4A+YnYVvTUoOQuvzTq0TfuXAe7t1l1DlH0JkMd9szOd99RfwvUqJQ4owYla
         Lh/w==
X-Gm-Message-State: AFqh2krldYkGTgMaLZUPCWnWEqVBbmwf7B2Ac6hAmhwwTIYkLSCxoMqy
        pjPhtPr/E1deros07WVgQrovhsm1RAE6a/93jUP82A==
X-Google-Smtp-Source: AMrXdXsCSQxYQPaaZgb8ZrpS5jIH71fk0MOJ2S9ZfnoD7Fb95NpY267jdU6+LoiMumLzaJwoCjl+ZQbdcRHuXMRUztU=
X-Received: by 2002:a67:8c88:0:b0:3ce:8835:de03 with SMTP id
 o130-20020a678c88000000b003ce8835de03mr5149503vsd.50.1674822650200; Fri, 27
 Jan 2023 04:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <20221219102452.2860088-3-sumit.garg@linaro.org> <20230127115039.GA30505@willie-the-truck>
In-Reply-To: <20230127115039.GA30505@willie-the-truck>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 27 Jan 2023 18:00:39 +0530
Message-ID: <CAFA6WYNhqBBJaRun94xTqb8p-zFrmtUqfXxx1mXKwuANNsUuHw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 17:20, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 03:54:52PM +0530, Sumit Garg wrote:
> > Currently only the first attempt to single-step has any effect. After
> > that all further stepping remains "stuck" at the same program counter
> > value.
> >
> > Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
> > PSTATE.SS=1 should be set at each step before transferring the PE to the
> > 'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
> > since the second single-step.
> >
> > After the first single-step, the PE transferes to the 'Inactive' state,
> > with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
> > kernel_active_single_step()=true. Then the PE transferes to the
> > 'Active-pending' state when ERET and returns to the debugger by step
> > exception.
> >
> > Before this patch:
> > ==================
> > Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
> > [0]kdb>
> >
> > [0]kdb>
> > [0]kdb> bp write_sysrq_trigger
> > Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
> >     is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0
> >
> > [0]kdb> go
> > $ echo h > /proc/sysrq-trigger
> >
> > Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> > [1]kdb>
> >
> > After this patch:
> > =================
> > Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
> > [0]kdb> bp write_sysrq_trigger
> > Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
> >     is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0
> >
> > [0]kdb> go
> > $ echo h > /proc/sysrq-trigger
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
> > [1]kdb>
> >
> > Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> > Co-developed-by: Wei Li <liwei391@huawei.com>
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/arm64/include/asm/debug-monitors.h | 1 +
> >  arch/arm64/kernel/debug-monitors.c      | 5 +++++
> >  arch/arm64/kernel/kgdb.c                | 2 ++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> > index 7b7e05c02691..ce3875ad5cd3 100644
> > --- a/arch/arm64/include/asm/debug-monitors.h
> > +++ b/arch/arm64/include/asm/debug-monitors.h
> > @@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
> >  void kernel_enable_single_step(struct pt_regs *regs);
> >  void kernel_disable_single_step(void);
> >  int kernel_active_single_step(void);
> > +void kernel_regs_reset_single_step(struct pt_regs *regs);
> >
> >  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> >  int reinstall_suspended_bps(struct pt_regs *regs);
> > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > index 3da09778267e..9af898b22ed4 100644
> > --- a/arch/arm64/kernel/debug-monitors.c
> > +++ b/arch/arm64/kernel/debug-monitors.c
> > @@ -438,6 +438,11 @@ int kernel_active_single_step(void)
> >  }
> >  NOKPROBE_SYMBOL(kernel_active_single_step);
> >
> > +void kernel_regs_reset_single_step(struct pt_regs *regs)
> > +{
> > +     set_regs_spsr_ss(regs);
> > +}
>
> Just a nit on the naming here, but please can this be
> kernel_rewind_single_step() instead? I think it's closer to the rewind
> function we have for user tasks than the reset function.
>

Sure, I will do the renaming in the next version.

-Sumit

> Cheers,
>
> Will
