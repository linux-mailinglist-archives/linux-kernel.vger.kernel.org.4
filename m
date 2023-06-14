Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375D8730177
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbjFNOQO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245510AbjFNOP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:15:57 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1841721;
        Wed, 14 Jun 2023 07:15:55 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-982777bf157so15722166b.0;
        Wed, 14 Jun 2023 07:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752154; x=1689344154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTER5f5XTlC8X6NXqMj8tbNb+e//nPKPLWvBEp8cBrc=;
        b=aimGgRURmn3k+rnaJ73dFkUtaqKR2ggPVJ35aIIh+i4p3LK3mkrrmuS9+SuFMRI89O
         Uej58JphOApwQi+2ps9j/NLwmXkob2mEoiFwI5l+4YvVitn/eJxJhqo16or5mg8Pyqak
         ooSNJ6ts9ySU4OCBREkrNai2jkBeNh0JsnJ5tztf7wLEB9JIL4gy1BePHj+R3U19Ut+E
         tmjubku1UwgFU1JO6nUnroGknT7RwF8XcBcMAwZLjo1SxQoOGk17DwsDJguq6ZML5iPT
         NCjQDK6zdb8frUC76PlbaTveJu11Jabo60ypLCIcn7FEZdq5btBLsXIVMyMaVYbjWlY0
         450g==
X-Gm-Message-State: AC+VfDyNbvfbF3x1yypxTmEGNV/1vq6qkGlFD1jcJXr1q/cQamH6XQBJ
        egmZuMlotLMCENfLWxCS1/ZuPDppKnfWIh1wxBE=
X-Google-Smtp-Source: ACHHUZ7sToZuVvzl24vIPOmhUom4heAy6fxlazGTOkPr//gjXp8g2bw574QxNNlE0Kh1HWW0xzh2q8dn8ANldSv3b4M=
X-Received: by 2002:a17:906:72c4:b0:974:ae1d:ad0b with SMTP id
 m4-20020a17090672c400b00974ae1dad0bmr12756809ejl.3.1686752153796; Wed, 14 Jun
 2023 07:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <12237421.O9o76ZdvQC@kreacher> <20230614084734.GD1639749@hirez.programming.kicks-ass.net>
In-Reply-To: <20230614084734.GD1639749@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jun 2023 16:15:41 +0200
Message-ID: <CAJZ5v0gK4ZCx04yidYvUJLKmT8rn-+CicPTgD0-Qvupn2y9fCQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Saket Dumbre <saket.dumbre@intel.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 13, 2023 at 05:25:07PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The addition of might_sleep() to down_timeout() caused the latter to
> > enable interrupts unconditionally in some cases, which in turn broke
> > the ACPI S3 wakeup path in acpi_suspend_enter(), where down_timeout()
> > is called by acpi_disable_all_gpes() via acpi_ut_acquire_mutex().
> >
> > Namely, if CONFIG_DEBUG_ATOMIC_SLEEP is set, might_sleep() causes
> > might_resched() to be used and if CONFIG_PREEMPT_VOLUNTARY is set,
> > this triggers __cond_resched() which may call preempt_schedule_common(),
> > so __schedule() gets invoked and it ends up with enabled interrupts (in
> > the prev == next case).
>
> Urgh, so that code was relying on the lack of contention to not trigger
> the schedule path -- with the added might_sleep() it triggers a
> preemption point.

Right.

> > Now, enabling interrupts early in the S3 wakeup path causes the kernel
> > to crash.
> >
> > Address this by modifying acpi_suspend_enter() to disable GPEs without
> > attempting to acquire the sleeping lock which is not needed in that code
> > path anyway.
> >
> > Fixes: 99409b935c9a locking/semaphore: Add might_sleep() to down_*() family
>
> $ git show -s --pretty='format:%h ("%s")' 99409b935c9a
> 99409b935c9a ("locking/semaphore: Add might_sleep() to down_*() family")

Right, thanks!

> > Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> > ---
> >  drivers/acpi/acpica/achware.h |    2 --
> >  drivers/acpi/sleep.c          |   16 ++++++++++++----
> >  include/acpi/acpixf.h         |    1 +
> >  3 files changed, 13 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/acpica/achware.h
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/achware.h
> > +++ linux-pm/drivers/acpi/acpica/achware.h
> > @@ -101,8 +101,6 @@ acpi_status
> >  acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
> >                      acpi_event_status *event_status);
> >
> > -acpi_status acpi_hw_disable_all_gpes(void);
> > -
> >  acpi_status acpi_hw_enable_all_runtime_gpes(void);
> >
> >  acpi_status acpi_hw_enable_all_wakeup_gpes(void);
> > Index: linux-pm/include/acpi/acpixf.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/acpixf.h
> > +++ linux-pm/include/acpi/acpixf.h
> > @@ -761,6 +761,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
> >                                                    acpi_event_status
> >                                                    *event_status))
> >  ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
> > +ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
> >  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
> >  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
> >  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -636,11 +636,19 @@ static int acpi_suspend_enter(suspend_st
> >       }
> >
> >       /*
> > -      * Disable and clear GPE status before interrupt is enabled. Some GPEs
> > -      * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
> > -      * acpi_leave_sleep_state will reenable specific GPEs later
> > +      * Disable all GPE and clear their status bits before interrupts are
> > +      * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
> > +      * prevent them from producing spurious interrups.
> > +      *
> > +      * acpi_leave_sleep_state() will reenable specific GPEs later.
> > +      *
> > +      * Because this code runs on one CPU with disabled interrupts (all of
> > +      * the other CPUs are offline at that time), it need not acquire any
> > +      * sleeping locks which maybe harmful due to instrumentation even if
> > +      * those locks are not contended, so avoid doing that by using a low-
> > +      * level library routine here.
>
> I'm not sure I'd call the implicit preemption point 'instrumentation'
> but yeah, fair enough I suppose.

OK, I'll send a v2 with this clarified.

> >        */
> > -     acpi_disable_all_gpes();
> > +     acpi_hw_disable_all_gpes();
> >       /* Allow EC transactions to happen. */
> >       acpi_ec_unblock_transactions();
