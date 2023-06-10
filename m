Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50B72A876
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjFJCdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjFJCdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:33:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265B35B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 19:33:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso893862a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686364429; x=1688956429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+TP2T19FLHbxj1l53UvgzYdwbtMohqVKDwqwF982rw=;
        b=G1E1F9WSS4+1fkzUZ7Mp4inia74sPOxPgs88tlf7BBDNPK1OVmlabBpOoaA60N4hX7
         b6xgY8/viGCwxWjSBVva4HA9vpmewqsvqUVyE44hlHwwe1UF7YtgQMx6YqBNu6L1L8Q4
         m0tVnk8JtiXdiot4nv/qZua+iY93UX6Ym6pjMUTipeGvPLjHXIT1brPpYgQWdpPRMUp6
         G8Ve9zJ6bopm9885SCTk0xYRbH8zS2J2l86TsFvSK7yKRGnavS3hRXEldQoCzdUXvUvL
         RI+hdcRFc/8IMLjn0GhkQ+ZP/Ju/mPXLnT+DF5w5r2+CB/xLzmGRqFf3V7ioMcS/anBU
         cCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686364429; x=1688956429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+TP2T19FLHbxj1l53UvgzYdwbtMohqVKDwqwF982rw=;
        b=jCA1HeIGCGSIC8wjy4fgZ84+igbMUtPW7lUzNw7ZNS5B0v/pMqZFlPxwQR4i5TKNy/
         BOZ/HEWsOvT6XALTecx4YtQefIg0RINTXKyQZTK/iNKwXxw24LlzI8BSp3lk8Hdz7yMT
         BHykz5Hwzj2YJk2wI+lEykS/XAGJqO0M3C1i/dRAGgcWgaJhTVoKzFOwTRKm1tz+TSbV
         ZDkgvIdxFMrnCsJ833ReF6rjY4EFNRWXGY8nqbu9M9bqELn+4AFtALXo1fs3e1tb/uWi
         H9jKOsqGcXKWpen2w2KgD6H4yR+KId15BTvlf+PmCEz9uTojdUYG5c2Yi3mnfOAO63Vo
         uLlw==
X-Gm-Message-State: AC+VfDxdLYvBIlCuN2ffLqBSQBfC2FqWRi7KJEtA4qmz18XnCcbQUQiE
        r8lAFgigMmlUTJ4tkJ1sO8+1+g==
X-Google-Smtp-Source: ACHHUZ6D23hSKxYpLazYa38zXVd1CIvdlcTn/RZJBWicF0Z3UOq5HXvM6qXYYtF5c2mZwM90IdZZTA==
X-Received: by 2002:a05:6a20:1584:b0:10b:b166:8836 with SMTP id h4-20020a056a20158400b0010bb1668836mr2965108pzj.47.1686364428966;
        Fri, 09 Jun 2023 19:33:48 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.107])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7929a000000b0064b0326494asm3197288pfa.150.2023.06.09.19.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 19:33:48 -0700 (PDT)
Date:   Sat, 10 Jun 2023 10:33:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
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
Subject: Re: [PATCH v2 4/5] perf cs-etm: Track exception level
Message-ID: <20230610023335.GC174906@leoy-huanghe>
References: <20230608105930.1389276-1-james.clark@arm.com>
 <20230608105930.1389276-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608105930.1389276-5-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:59:28AM +0100, James Clark wrote:
> Currently we assume all trace belongs to the host machine so when
> the decoder should be looking at the guest kernel maps it can crash
> because it looks at the host ones instead.
> 
> Avoid one scenario (guest kernel running at EL1) by assigning the
> default guest machine to this trace. For userspace trace it's still not
> possible to determine guest vs host, but the PIDs should help in this
> case.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Just input a thought for support both host and guest machines, seems to
me, a feasibe solution is CoreSight can extend its capability to trace
below system registers together:

- VTTBR_EL2.vmid
- CONTEXTIDR_EL2
- CONTEXTIDR_EL1

So:

VTTBR_EL2.vmid == 0: host machine, CONTEXTIDR_EL2 is for tracing PID
VTTBR_EL2.vmid != 0: guest machine, CONTEXTIDR_EL1 is for tracing PID

So far we only can trace either CONTEXTIDR_EL2 (and it's even a bit
mess that we save CONTEXTIDR_EL2 into 'elem->context.vmid') or
CONTEXTIDR_EL1, this is the main reason it's hard for perf to
distinguish host and guest.  I know you might have discussed this yet,
here I just record some ideas in case later we can review it.

Thanks,
Leo

> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  7 +-
>  tools/perf/util/cs-etm.c                      | 75 +++++++++++++++----
>  tools/perf/util/cs-etm.h                      |  7 +-
>  3 files changed, 67 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 2af641d26866..44c49acd6bff 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -561,12 +561,13 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>  		break;
>  	}
>  
> +	if (cs_etm__etmq_set_tid_el(etmq, tid, trace_chan_id,
> +				    elem->context.exception_level))
> +		return OCSD_RESP_FATAL_SYS_ERR;
> +
>  	if (tid == -1)
>  		return OCSD_RESP_CONT;
>  
> -	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
> -		return OCSD_RESP_FATAL_SYS_ERR;
> -
>  	/*
>  	 * A timestamp is generated after a PE_CONTEXT element so make sure
>  	 * to rely on that coming one.
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index e0904f276e89..916e86f003f4 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -14,7 +14,6 @@
>  #include <linux/types.h>
>  #include <linux/zalloc.h>
>  
> -#include <opencsd/ocsd_if_types.h>
>  #include <stdlib.h>
>  
>  #include "auxtrace.h"
> @@ -88,6 +87,8 @@ struct cs_etm_traceid_queue {
>  	union perf_event *event_buf;
>  	struct thread *thread;
>  	struct thread *prev_thread;
> +	ocsd_ex_level prev_el;
> +	ocsd_ex_level el;
>  	struct branch_stack *last_branch;
>  	struct branch_stack *last_branch_rb;
>  	struct cs_etm_packet *prev_packet;
> @@ -482,6 +483,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>  
>  	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
>  	tidq->trace_chan_id = trace_chan_id;
> +	tidq->el = tidq->prev_el = ocsd_EL_unknown;
>  	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
>  					       queue->tid);
>  	tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
> @@ -621,6 +623,7 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>  		tmp = tidq->packet;
>  		tidq->packet = tidq->prev_packet;
>  		tidq->prev_packet = tmp;
> +		tidq->prev_el = tidq->el;
>  		thread__put(tidq->prev_thread);
>  		tidq->prev_thread = thread__get(tidq->thread);
>  	}
> @@ -882,11 +885,43 @@ static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
>  	return evsel->core.attr.type == aux->pmu_type;
>  }
>  
> -static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> +static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
> +					   ocsd_ex_level el)
>  {
> -	struct machine *machine;
> +	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
>  
> -	machine = &etmq->etm->session->machines.host;
> +	/*
> +	 * For any virtualisation based on nVHE (e.g. pKVM), or host kernels
> +	 * running at EL1 assume everything is the host.
> +	 */
> +	if (pid_fmt == CS_ETM_PIDFMT_CTXTID)
> +		return &etmq->etm->session->machines.host;
> +
> +	/*
> +	 * Not perfect, but otherwise assume anything in EL1 is the default
> +	 * guest, and everything else is the host. Distinguishing between guest
> +	 * and host userspaces isn't currently supported either. Neither is
> +	 * multiple guest support. All this does is reduce the likeliness of
> +	 * decode errors where we look into the host kernel maps when it should
> +	 * have been the guest maps.
> +	 */
> +	switch (el) {
> +	case ocsd_EL1:
> +		return machines__find_guest(&etmq->etm->session->machines,
> +					    DEFAULT_GUEST_KERNEL_ID);
> +	case ocsd_EL3:
> +	case ocsd_EL2:
> +	case ocsd_EL0:
> +	case ocsd_EL_unknown:
> +	default:
> +		return &etmq->etm->session->machines.host;
> +	}
> +}
> +
> +static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
> +			   ocsd_ex_level el)
> +{
> +	struct machine *machine = cs_etm__get_machine(etmq, el);
>  
>  	if (address >= machine__kernel_start(machine)) {
>  		if (machine__is_host(machine))
> @@ -896,10 +931,14 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
>  	} else {
>  		if (machine__is_host(machine))
>  			return PERF_RECORD_MISC_USER;
> -		else if (perf_guest)
> +		else {
> +			/*
> +			 * Can't really happen at the moment because
> +			 * cs_etm__get_machine() will always return
> +			 * machines.host for any non EL1 trace.
> +			 */
>  			return PERF_RECORD_MISC_GUEST_USER;
> -		else
> -			return PERF_RECORD_MISC_HYPERVISOR;
> +		}
>  	}
>  }
>  
> @@ -916,11 +955,12 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  	if (!etmq)
>  		return 0;
>  
> -	cpumode = cs_etm__cpu_mode(etmq, address);
>  	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
>  	if (!tidq)
>  		return 0;
>  
> +	cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
> +
>  	if (!thread__find_map(tidq->thread, cpumode, address, &al))
>  		return 0;
>  
> @@ -1298,10 +1338,11 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
>  	return etmq->buf_len;
>  }
>  
> -static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
> -			       struct cs_etm_traceid_queue *tidq, pid_t tid)
> +static void cs_etm__set_thread(struct cs_etm_queue *etmq,
> +			       struct cs_etm_traceid_queue *tidq, pid_t tid,
> +			       ocsd_ex_level el)
>  {
> -	struct machine *machine = &etm->session->machines.host;
> +	struct machine *machine = cs_etm__get_machine(etmq, el);
>  
>  	if (tid != -1) {
>  		thread__zput(tidq->thread);
> @@ -1311,10 +1352,12 @@ static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
>  	/* Couldn't find a known thread */
>  	if (!tidq->thread)
>  		tidq->thread = machine__idle_thread(machine);
> +
> +	tidq->el = el;
>  }
>  
> -int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> -			 pid_t tid, u8 trace_chan_id)
> +int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
> +			    u8 trace_chan_id, ocsd_ex_level el)
>  {
>  	struct cs_etm_traceid_queue *tidq;
>  
> @@ -1322,7 +1365,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>  	if (!tidq)
>  		return -EINVAL;
>  
> -	cs_etm__set_thread(etmq->etm, tidq, tid);
> +	cs_etm__set_thread(etmq, tidq, tid, el);
>  	return 0;
>  }
>  
> @@ -1392,7 +1435,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	struct perf_sample sample = {.ip = 0,};
>  
>  	event->sample.header.type = PERF_RECORD_SAMPLE;
> -	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
> +	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
>  	/* Set time field based on etm auxtrace config. */
> @@ -1451,7 +1494,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	ip = cs_etm__last_executed_instr(tidq->prev_packet);
>  
>  	event->sample.header.type = PERF_RECORD_SAMPLE;
> -	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
> +	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip, tidq->prev_el);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
>  	/* Set time field based on etm auxtrace config. */
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 2f47f4ec5b27..7cca37887917 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -251,10 +251,11 @@ enum cs_etm_pid_fmt {
>  };
>  
>  #ifdef HAVE_CSTRACE_SUPPORT
> +#include <opencsd/ocsd_if_types.h>
>  int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
> -enum pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
> -int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> -			 pid_t tid, u8 trace_chan_id);
> +enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
> +int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
> +			    u8 trace_chan_id, ocsd_ex_level el);
>  bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
>  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>  					      u8 trace_chan_id);
> -- 
> 2.34.1
> 
