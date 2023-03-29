Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB96CD93E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjC2MRQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC2MRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:17:15 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05041BC5;
        Wed, 29 Mar 2023 05:17:13 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id ek18so62406514edb.6;
        Wed, 29 Mar 2023 05:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DShqxr4qsaywny3Edkqb64hMKKyKlgUunkfAdtTqeEc=;
        b=Jg+ir531VFweKkumDnhkFc0FgE/i8LG3z9wAp8FiaHOYpoAz6PPKLtFlVkctn666M0
         c0G5BBRsqnFWabM354ykVCD/EGJe9kAza5gHYgiUEyDUjx4mC1g//cyy//E94kxCnk65
         zGKWYWc65G/CZsznkhT6V429LAsNVUqH5l9eOVN+b+Gwkq927eaYrxOhDlQcPT9xwNwi
         0ro1aeHBapOknESw+zA5+pJPy1oFKUNa56/nkXxWvSz59HnErRwIshiqC33yK2cQWwiC
         WBVZLMoChGOyJAu66j6suqxT7kFxaU+pGq/6sApxwYPhwtp/noLyT98Uju8VYMPNtsRr
         sn0g==
X-Gm-Message-State: AAQBX9fkfTZPTwpZf74dGL7EaB95EMe2ZTYHs0sHUIhJsMpKep/9l0Kp
        qIIlwu58Yh0Y85i4eJK4SyG8sHmenE1i2Y9ftQU=
X-Google-Smtp-Source: AKy350a42BNZly7NT1YAwXG/xznlsRLm0qlSStJr0m15aL3s8F1xXbZi14AmXLyXGBW3zFxuIWjdqfACe78pd+6oxxo=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr9258696ejc.2.1680092232323; Wed, 29 Mar
 2023 05:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-16-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0iidC0LxqpE60J5HHQhvv8iHjMGdxM89-7p-QQE99qVEQ@mail.gmail.com> <20230328234119.GA8958@ranerica-svr.sc.intel.com>
In-Reply-To: <20230328234119.GA8958@ranerica-svr.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 14:17:01 +0200
Message-ID: <CAJZ5v0jgSObZnVHJed_qPtGLcryZsTpysVHFgFdZNzYOuhbc2Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/24] thermal: intel: hfi: Report the IPC class score
 of a CPU
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 1:30 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, Mar 27, 2023 at 06:50:13PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > Implement the arch_get_ipcc_score() interface of the scheduler. Use the
> > > performance capabilities of the extended Hardware Feedback Interface table
> > > as the IPC score.
> > >
> > > Cc: Ben Segall <bsegall@google.com>
> > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > Cc: Mel Gorman <mgorman@suse.de>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > Changes since v2:
> > >  * None
> > >
> > > Changes since v1:
> > >  * Adjusted the returned HFI class (which starts at 0) to match the
> > >    scheduler IPCC class (which starts at 1). (PeterZ)
> > >  * Used the new interface names.
> > > ---
> > >  arch/x86/include/asm/topology.h   |  2 ++
> > >  drivers/thermal/intel/intel_hfi.c | 27 +++++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > > index ffcdac3f398f..c4fcd9c3c634 100644
> > > --- a/arch/x86/include/asm/topology.h
> > > +++ b/arch/x86/include/asm/topology.h
> > > @@ -229,8 +229,10 @@ void init_freq_invariance_cppc(void);
> > >
> > >  #if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
> > >  void intel_hfi_update_ipcc(struct task_struct *curr);
> > > +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
> > >
> > >  #define arch_update_ipcc intel_hfi_update_ipcc
> > > +#define arch_get_ipcc_score intel_hfi_get_ipcc_score
> > >  #endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
> > >
> > >  #endif /* _ASM_X86_TOPOLOGY_H */
> > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > index 530dcf57e06e..fa9b4a678d92 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -206,6 +206,33 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
> > >         curr->ipcc = msr.split.classid + 1;
> > >  }
> > >
> > > +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
> > > +{
> > > +       unsigned short hfi_class;
> >
> > It looks like the variable above is only used to save a subtraction or
> > addition of 1 to something going forward.
> >
> > > +       int *scores;
> > > +
> > > +       if (cpu < 0 || cpu >= nr_cpu_ids)
> > > +               return -EINVAL;
> > > +
> > > +       if (ipcc == IPC_CLASS_UNCLASSIFIED)
> > > +               return -EINVAL;
> > > +
> > > +       /*
> > > +        * Scheduler IPC classes start at 1. HFI classes start at 0.
> > > +        * See note intel_hfi_update_ipcc().
> > > +        */
> > > +       hfi_class = ipcc - 1;
> > > +
> > > +       if (hfi_class >= hfi_features.nr_classes)
> >
> > Personally, I would do
> >
> > if (ipcc >= hfi_features.nr_classes + 1)
> >
> > here and ->
> >
> > > +               return -EINVAL;
> > > +
> > > +       scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
> > > +       if (!scores)
> > > +               return -ENODEV;
> > > +
> >
> > -> scores[ipcc - 1]
>
> Sure, I can get rid of hfi_class.
>
> >
> > below.
> >
> > > +       return READ_ONCE(scores[hfi_class]);
> >
> > And why does this need to use READ_ONCE()?
>
> This is the corresponding read of the WRITE_ONCE in patch 13. The CPU
> handling the HFI interrupt, very likely a different CPU, updates
> scores[hfi_class]. My intention is to let that write to complete before
> reading the score here.

However, READ_ONCE()/WRITE_ONCE() only affect compiler optimizations
AFAICS.  What if the CPUs running the code reorder the instructions?

In any case, IMV the reason why READ_ONCE() is used needs to be clear
to the reviewers from the patch itself (and to a casual reader of the
code from the code itself).

> >
> > > +}
> > > +
> > >  static int alloc_hfi_ipcc_scores(void)
> > >  {
> > >         if (!cpu_feature_enabled(X86_FEATURE_ITD))
> > > --
