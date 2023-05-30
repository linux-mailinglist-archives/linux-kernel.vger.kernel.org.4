Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B49716152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjE3NQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjE3NQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:16:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A0F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:16:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d57cd373fso3833142b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452579; x=1688044579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1zQhS2/5jkiBmblcH1oQk10zWpL+bEnBI7IhlI9oIk=;
        b=lbXs+dQ9NgilxVcTPf3KJTwb6STClSOSGoQ7bji1QZH6AeacbsrcDGhncJyxmSiZgY
         Sfecw3aknkpgNhDrhxyF0SIMZR1BDPgbN0lVtzYkQCmqHYGG7mfFikmD+bPz/bX6okb7
         f0C6UUCSBciwUq2A0BRlKtjHZO80epP+poV1LxIlAginWEyVkX+9x4D73IIzcK2ggrsC
         dI8KeDG1dVO6FumvnuTlWXbSclHP+P+oL7Gx3oXnc4JQnPH+JSxYFzr9pGTyph/0PUmg
         ptud3ApaevPvduGjb8SB0RtXJ6bZhHYRC3aj0hSmg9Uk2I9RCuVumzZA0uW7LzeAs759
         tjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452579; x=1688044579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1zQhS2/5jkiBmblcH1oQk10zWpL+bEnBI7IhlI9oIk=;
        b=jMM+rd3znMbiTfU2Ow8CJRDmBwfoa89JE8hfVEu9h3VmxnvqGwSl699Zs78wthsvMt
         lqqwiOUY3yQce20nTl/HPKvofXsa15CaVmcWksWETF/lEs8ubLyqIIaN+oF+fZnKkRMm
         6IZq2CPDBkqk5P2xxdIMVCu5OFHs6xsEbB6znOlI3VhBvGDPme6cn7nzg8Pb+Q9P7weK
         vwaP2KC5xhb8XAnP1GCYgSTQdQBp1635K6xxhiEeP4SBS/FI4db4SVWgSBDQ328fBK5Z
         PKbPE0bOsF4Y9yc1R+XJqe+FyK1YB7nz+l0uXtLX5AdWL/NGg2F32wfdqtTBv7eHlY9U
         Dkhw==
X-Gm-Message-State: AC+VfDy5kgr59HxLqVx40nLndsMB9olNsK278HXcPEnhnG/gYr9Ti4TQ
        tl8NQr+gag3KB08gRXhqDBLT0A==
X-Google-Smtp-Source: ACHHUZ4bAYm1QAvopIyI87kRCWQK1nedCga4l56oL5VLx/Vmicj5uCts0HruZhPVw+hx8ssoZsEtZQ==
X-Received: by 2002:a17:902:ce82:b0:1af:e116:4b42 with SMTP id f2-20020a170902ce8200b001afe1164b42mr11155878plg.34.1685452578868;
        Tue, 30 May 2023 06:16:18 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-210.hinet-ip.hinet.net. [211.75.219.210])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902868900b001ae8b4dc49bsm10239988plo.13.2023.05.30.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:16:18 -0700 (PDT)
Date:   Tue, 30 May 2023 21:16:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        denik@chromium.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf cs-etm: Track exception level
Message-ID: <20230530131610.GA2219355@leoy-yangtze.lan>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-4-james.clark@arm.com>
 <CAJ9a7Vj99VVDC6Xjyg1cYza-nOk62xPKg7rA4b5XBcU5B=oWVw@mail.gmail.com>
 <830d2a40-655d-7f16-a969-cadbe5b2a1c5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830d2a40-655d-7f16-a969-cadbe5b2a1c5@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:24:45AM +0100, James Clark wrote:

[...]

> >> -static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> >> +static struct machine *cs_etm__get_machine(struct cs_etm_auxtrace *etm,
> >> +                                          ocsd_ex_level el)
> >>  {
> >> -       struct machine *machine;
> >> +       /*
> >> +        * Not perfect, but assume anything in EL1 is the default guest, and
> >> +        * everything else is the host. nHVE and pKVM may not work with this
> >> +        * assumption. And distinguishing between guest and host userspaces
> >> +        * isn't currently supported either. Neither is multiple guest support.
> >> +        * All this does is reduce the likeliness of decode errors where we look
> >> +        * into the host kernel maps when it should have been the guest maps.
> >> +        */
> > 
> > What effect does this have if I am running with host only, kernel at
> > EL1, e.g. any platform that is not running an EL2 kernel?
> 
> I suppose I didn't think about that case. It looks like you'd have to
> start using --guest-vmlinux instead of --vmlinux to decode. But that's
> probably not what we want.

IIUC, it's not about how to pass kernel image path with options
"--guest-vmlinux" or "--vmlinux".

Let's think a case: Cortex-A53 CPU which doesn't support VHE, or any
Arm CPUs which disable the VHE feature.  In this case, the host OS and
guest OS both run in EL1, only the a KVM hypervisor runs in EL2.

You could see with below change, no matter the host OS and guest OS,
both use DEFAULT_GUEST_KERNEL_ID to retrieve the guest machine.  At
the end, this change will break perf tool for host OS.

> Is that a standard configuration though? I'm wondering if we need to
> support that out of the box, or needing the extra command line argument
> is ok? It seems like it's hard to make anything just work without the
> user providing extra info.

Essentially, we need more info to make decision if a system runs in host
or guest, if only depend on it's EL1 or other execptions, it's hard to
say it's running in host or guest.  We can look into more details:

- If CPU enables VHE, then the host kernel runs in EL2 and the guest
  kernel runs in EL1;

- If CPU only enables nVHE (or CPU doesn't support VHE at all), then
  both the host kernel and the guest kernel runs in EL1;

I think we need to retrieve more info from /sys/ node or /proc node:

- We need to know if VHE is enabled or not;

- If CPU doesn't enable VHE, then both host and guest kernels run in
  EL1, so we need to use extra info to distinguish it's a host kernel
  or guest kernel.

To be honest, I don't have answers for above two items.  I will think
a bit more and will share back if have any finding.

Thanks,
Leo

> After this change we also wanted to start setting exclude_guest=1 by
> default, so technically this change is only needed when exclude_guest=0.
> Otherwise we could assume it's always the host regardless of the EL. It
> should be quite easy to check what that setting was in this switch
> statement, but it would be temporarily broken in the mean time. And also
> we can only make exclude_guest work with FEAT_TRF (v8.4 onwards)
> 
> > 
> > Mike
> > 
> > 
> >> +       switch (el) {
> >> +       case ocsd_EL1:
> >> +               return machines__find_guest(&etm->session->machines,
> >> +                                           DEFAULT_GUEST_KERNEL_ID);
> >> +       case ocsd_EL3:
> >> +       case ocsd_EL2:
> >> +       case ocsd_EL0:
> >> +       case ocsd_EL_unknown:
> >> +       default:
> >> +               return &etm->session->machines.host;
> >> +       }
> >> +}
> >>
> >> -       machine = &etmq->etm->session->machines.host;
> >> +static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
> >> +                          ocsd_ex_level el)
> >> +{
> >> +       struct machine *machine = cs_etm__get_machine(etmq->etm, el);
> >>
> >>         if (address >= machine__kernel_start(machine)) {
> >>                 if (machine__is_host(machine))
> >> @@ -893,10 +919,14 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> >>         } else {
> >>                 if (machine__is_host(machine))
> >>                         return PERF_RECORD_MISC_USER;
> >> -               else if (perf_guest)
> >> +               else {
> >> +                       /*
> >> +                        * Can't really happen at the moment because
> >> +                        * cs_etm__get_machine() will always return
> >> +                        * machines.host for any non EL1 trace.
> >> +                        */
> >>                         return PERF_RECORD_MISC_GUEST_USER;
> >> -               else
> >> -                       return PERF_RECORD_MISC_HYPERVISOR;
> >> +               }
> >>         }
> >>  }
> >>
> >> @@ -913,11 +943,12 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> >>         if (!etmq)
> >>                 return 0;
> >>
> >> -       cpumode = cs_etm__cpu_mode(etmq, address);
> >>         tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
> >>         if (!tidq)
> >>                 return 0;
> >>
> >> +       cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
> >> +
> >>         if (!thread__find_map(tidq->thread, cpumode, address, &al))
> >>                 return 0;
> >>
> >> @@ -1296,9 +1327,10 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
> >>  }
> >>
> >>  static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
> >> -                              struct cs_etm_traceid_queue *tidq, pid_t tid)
> >> +                              struct cs_etm_traceid_queue *tidq, pid_t tid,
> >> +                              ocsd_ex_level el)
> >>  {
> >> -       struct machine *machine = &etm->session->machines.host;
> >> +       struct machine *machine = cs_etm__get_machine(etm, el);
> >>
> >>         if (tid != -1) {
> >>                 thread__zput(tidq->thread);
> >> @@ -1308,10 +1340,12 @@ static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
> >>         /* Couldn't find a known thread */
> >>         if (!tidq->thread)
> >>                 tidq->thread = machine__idle_thread(machine);
> >> +
> >> +       tidq->el = el;
> >>  }
> >>
> >> -int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> >> -                        pid_t tid, u8 trace_chan_id)
> >> +int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid, u8 trace_chan_id,
> >> +                        ocsd_ex_level el)
> >>  {
> >>         struct cs_etm_traceid_queue *tidq;
> >>
> >> @@ -1319,7 +1353,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> >>         if (!tidq)
> >>                 return -EINVAL;
> >>
> >> -       cs_etm__set_thread(etmq->etm, tidq, tid);
> >> +       cs_etm__set_thread(etmq->etm, tidq, tid, el);
> >>         return 0;
> >>  }
> >>
> >> @@ -1389,7 +1423,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >>         struct perf_sample sample = {.ip = 0,};
> >>
> >>         event->sample.header.type = PERF_RECORD_SAMPLE;
> >> -       event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
> >> +       event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
> >>         event->sample.header.size = sizeof(struct perf_event_header);
> >>
> >>         /* Set time field based on etm auxtrace config. */
> >> @@ -1448,7 +1482,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
> >>         ip = cs_etm__last_executed_instr(tidq->prev_packet);
> >>
> >>         event->sample.header.type = PERF_RECORD_SAMPLE;
> >> -       event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
> >> +       event->sample.header.misc = cs_etm__cpu_mode(etmq, ip, tidq->prev_el);
> >>         event->sample.header.size = sizeof(struct perf_event_header);
> >>
> >>         /* Set time field based on etm auxtrace config. */
> >> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> >> index 70cac0375b34..88e9b25a8a9f 100644
> >> --- a/tools/perf/util/cs-etm.h
> >> +++ b/tools/perf/util/cs-etm.h
> >> @@ -232,10 +232,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >>  struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
> >>
> >>  #ifdef HAVE_CSTRACE_SUPPORT
> >> +#include <opencsd/ocsd_if_types.h>
> >>  int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
> >>  int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
> >> -int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> >> -                        pid_t tid, u8 trace_chan_id);
> >> +int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid, u8 trace_chan_id,
> >> +                        ocsd_ex_level el);
> >>  bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
> >>  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> >>                                               u8 trace_chan_id);
> >> --
> >> 2.34.1
> >>
> > 
> > 
