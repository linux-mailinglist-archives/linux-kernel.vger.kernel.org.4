Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8801E6CD92C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC2MNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2MNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:13:43 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BE1A8;
        Wed, 29 Mar 2023 05:13:42 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id w9so62414470edc.3;
        Wed, 29 Mar 2023 05:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjeu4VmyyyTeDLcxdUp4fgPNGQ6EeHxHPvZajGU2QbU=;
        b=7ZJOoC3feoDJnEa8kOwhfW78BPNoAZ6vGKG6iAe3Vf/yw5m21mH0nxz8BCh+rxlCka
         BTIIh6R90wkt1tWMJyN4sfFgBAsROt1rA9ONGLGUJ6+0Y+BVCRLFXiBlvukOB1o0WqOu
         61EyB5ghAz54uBUoDcSk2ry17xN+W+P3DkWe7UVdvquNvVsPwNBQAjqwJTX/ncDx4WmS
         mv3vJCXbCaSdvjYUo3wmBmMRoaF9JxNsdUAnQvO5TzaTc1LsQF5Q6lIEZDkQTwoffw2c
         pA0nDfbM47pN/74X3nZ+yX3x22OnlTwdyml3bvc99U8Uq3Y3I8botVVffMN1a20RdpKB
         wW2g==
X-Gm-Message-State: AAQBX9eGZu1abC3WocVOwhRMTlje1wrMj5X+ic6jJczgU6iadTUVgImi
        BPKq2cYDhopI47HSQ/7ryT28M6EtTvZJqQSawOk=
X-Google-Smtp-Source: AKy350bpqRTT8ur86JxyGdFh3xBWbeNU+pQwsPX2u1UP8gk8+z/1z9r7PYF3ZVgnJU5ELFa/+a6EyaVVZRqvqEOHrqc=
X-Received: by 2002:a50:d49e:0:b0:4fc:ebe2:2fc9 with SMTP id
 s30-20020a50d49e000000b004fcebe22fc9mr9471483edi.3.1680092020711; Wed, 29 Mar
 2023 05:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-15-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hGKKPiK86Z5PcG-EEHU7a=3d-4S2miRqNPuwjS1tF0BQ@mail.gmail.com> <20230328234149.GB8958@ranerica-svr.sc.intel.com>
In-Reply-To: <20230328234149.GB8958@ranerica-svr.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 14:13:29 +0200
Message-ID: <CAJZ5v0gOqNzpC9kqpBtqP1D2-OLNqWCf=ZYpzu9b0tqFcgBWYQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/24] thermal: intel: hfi: Update the IPC class of the
 current task
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

On Wed, Mar 29, 2023 at 1:31 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, Mar 27, 2023 at 06:42:28PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > Use Intel Thread Director classification to update the IPC class of a
> > > task. Implement the arch_update_ipcc() interface of the scheduler.
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
> > >  * Removed the implementation of arch_has_ipc_classes().
> > >
> > > Changes since v1:
> > >  * Adjusted the result the classification of Intel Thread Director to start
> > >    at class 1. Class 0 for the scheduler means that the task is
> > >    unclassified.
> > >  * Redefined union hfi_thread_feedback_char_msr to ensure all
> > >    bit-fields are packed. (PeterZ)
> > >  * Removed CONFIG_INTEL_THREAD_DIRECTOR. (PeterZ)
> > >  * Shortened the names of the functions that implement IPC classes.
> > >  * Removed argument smt_siblings_idle from intel_hfi_update_ipcc().
> > >    (PeterZ)
> > > ---
> > >  arch/x86/include/asm/topology.h   |  6 ++++++
> > >  drivers/thermal/intel/intel_hfi.c | 32 +++++++++++++++++++++++++++++++
> > >  2 files changed, 38 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > > index 458c891a8273..ffcdac3f398f 100644
> > > --- a/arch/x86/include/asm/topology.h
> > > +++ b/arch/x86/include/asm/topology.h
> > > @@ -227,4 +227,10 @@ void init_freq_invariance_cppc(void);
> > >  #define arch_init_invariance_cppc init_freq_invariance_cppc
> > >  #endif
> > >
> > > +#if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
> > > +void intel_hfi_update_ipcc(struct task_struct *curr);
> > > +
> > > +#define arch_update_ipcc intel_hfi_update_ipcc
> > > +#endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
> > > +
> > >  #endif /* _ASM_X86_TOPOLOGY_H */
> > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > index b06021828892..530dcf57e06e 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -72,6 +72,17 @@ union cpuid6_edx {
> > >         u32 full;
> > >  };
> > >
> > > +#ifdef CONFIG_IPC_CLASSES
> > > +union hfi_thread_feedback_char_msr {
> > > +       struct {
> > > +               u64     classid : 8;
> > > +               u64     __reserved : 55;
> > > +               u64     valid : 1;
> > > +       } split;
> > > +       u64 full;
> > > +};
> > > +#endif
> > > +
> > >  /**
> > >   * struct hfi_cpu_data - HFI capabilities per CPU
> > >   * @perf_cap:          Performance capability
> > > @@ -174,6 +185,27 @@ static struct workqueue_struct *hfi_updates_wq;
> > >  #ifdef CONFIG_IPC_CLASSES
> > >  static int __percpu *hfi_ipcc_scores;
> > >
> > > +void intel_hfi_update_ipcc(struct task_struct *curr)
> > > +{
> > > +       union hfi_thread_feedback_char_msr msr;
> > > +
> > > +       /* We should not be here if ITD is not supported. */
> > > +       if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
> > > +               pr_warn_once("task classification requested but not supported!");
> > > +               return;
> > > +       }
> > > +
> > > +       rdmsrl(MSR_IA32_HW_FEEDBACK_CHAR, msr.full);
> > > +       if (!msr.split.valid)
> > > +               return;
> > > +
> > > +       /*
> > > +        * 0 is a valid classification for Intel Thread Director. A scheduler
> > > +        * IPCC class of 0 means that the task is unclassified. Adjust.
> > > +        */
> > > +       curr->ipcc = msr.split.classid + 1;
> > > +}
> >
> > Wouldn't it be better to return the adjusted value from this function
> > and let the caller store it where appropriate?
> >
> > It doesn't look like it is necessary to pass the task_struct pointer to it.
>
> Judging from this patch alone, yes, it does not make much sense to pass a
> task_struct as argument. In patch 21, however, this function uses various
> members of task_struct and makes it more convenient to have it as argument,
> no?

I'm not convinced about this, but anyway it is better to combine the
two patches in such cases IMO.

The way it is done now confuses things from my perspective.

> >
> > > +
> > >  static int alloc_hfi_ipcc_scores(void)
> > >  {
> > >         if (!cpu_feature_enabled(X86_FEATURE_ITD))
> > > --
