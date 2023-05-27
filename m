Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A259713393
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjE0JGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjE0JGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:06:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF7E3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:06:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d3578c25bso2103805b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685178405; x=1687770405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Th/2CdkYSffxqn+a5kfATTdZzNBhiqjv8/1oEFRsaQ8=;
        b=swpKci/XFYc82knSogXS3iRF6oaRbVxcKOC3km53iIFTc4IUoWmJLA5Ym/gTJVjirQ
         IDmaUDmh3mK9Wgg4abfbgEMHihj1W3Kpb+XX16Supshd9Y1UFFRZapWsGbJ4eWUIKNnP
         vXKFUU5W+Tl01eJeicZII5BFwIAhq2c5wgctdvDywSvxO519UV5GeX/wcfKFeD/ylHTp
         97iv6To8vC0uc9iuhm1vXbUh3GrikszWBxu7CfJ3fi/ON5ktra8+b0GgLomyoGJPL/rY
         HKICfPdWZxQj6nKtsquTYDZLzpFPo5XqhtKGwq+5VR944qkR2hI6ygkiygv2icjPnq6P
         EULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685178405; x=1687770405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th/2CdkYSffxqn+a5kfATTdZzNBhiqjv8/1oEFRsaQ8=;
        b=TiP5RXydS1Z0rQ7yQV1POCTb58krefN/5rDUZND9RTekwygCEX91EMDZ5vzQNfJTVg
         y79h8QEhPioRJvund4KuCpTpEpyB2UEnFUiiW7fGACnr0QO6a2Ddu2h9l55f9uAD0ul4
         2c1NbP2TbN2TLyAcx3lPjxaTwZCvTilIlylBcepXGlp4SVdevG46FTQaTEW9p8VBsH0H
         I9dpj+IZvtO2tVR+6Vf08xD3TCoCuggr2OpIFFDeEQSYa3d84uH3rnuoz2l8K7jJKmUD
         FQWXMalU2zjPhN5HaKNWmCpmoyBmMvWIUOHJjHPrPDVZ/6JK8YdynGIn89vby7jQGJyT
         UHLw==
X-Gm-Message-State: AC+VfDyhrTOt+Gs9J+C2sapP86h/3J7mqOqNk2ZY0FxewcJHv7IHJcrT
        Ny0wLOcKjgEyWqw3+wlN9+5ajg==
X-Google-Smtp-Source: ACHHUZ63xJO8hiOlOALtVX+qtnyTR/xYlZeXvYN1YQQY4IJsTzbGd/KqW7Hj7EUIzCZiXPdl/kM2Jg==
X-Received: by 2002:a05:6a00:891:b0:643:d40c:7db1 with SMTP id q17-20020a056a00089100b00643d40c7db1mr6866644pfj.3.1685178404926;
        Sat, 27 May 2023 02:06:44 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.126])
        by smtp.gmail.com with ESMTPSA id j12-20020aa78dcc000000b0064928cb5f03sm3797231pfr.69.2023.05.27.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:06:44 -0700 (PDT)
Date:   Sat, 27 May 2023 17:06:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
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
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
Message-ID: <20230527090635.GB886420@leoy-yangtze.lan>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524131958.2139331-3-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:19:56PM +0100, James Clark wrote:
> Branch samples currently use the IP of the previous packet as the from
> IP, and the IP of the current packet as the to IP. But it incorrectly
> uses the current thread. In some cases like a jump into a different
> exception level this will attribute to the incorrect process.

It's about the timing that branch has taken or not taken :)

If we think the branch sample as 'branch has taken', then current code
is doning right thing, otherwise, we need this fix.

> Fix it by tracking the previous thread in the same way the previous
> packet is tracked.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ebffc9052561..a997fe79d458 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -86,6 +86,7 @@ struct cs_etm_traceid_queue {
>  	size_t last_branch_pos;
>  	union perf_event *event_buf;
>  	struct thread *thread;
> +	struct thread *prev_thread;
>  	struct branch_stack *last_branch;
>  	struct branch_stack *last_branch_rb;
>  	struct cs_etm_packet *prev_packet;
> @@ -480,6 +481,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>  	tidq->trace_chan_id = trace_chan_id;
>  	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
>  					       queue->tid);
> +	tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
>  
>  	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
>  	if (!tidq->packet)
> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>  		tmp = tidq->packet;
>  		tidq->packet = tidq->prev_packet;
>  		tidq->prev_packet = tmp;
> +		thread__put(tidq->prev_thread);
> +		tidq->prev_thread = thread__get(tidq->thread);

Maybe cs_etm__packet_swap() is not the best place to update
"tidq->prev_thread", since swapping packet doesn't mean it's necessarily
thread switching; can we move this change into the cs_etm__set_thread()?

Thanks,
Leo

>  	}
>  }
>  
> @@ -791,6 +795,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>  		/* Free this traceid_queue from the array */
>  		tidq = etmq->traceid_queues[idx];
>  		thread__zput(tidq->thread);
> +		thread__zput(tidq->prev_thread);
>  		zfree(&tidq->event_buf);
>  		zfree(&tidq->last_branch);
>  		zfree(&tidq->last_branch_rb);
> @@ -1450,8 +1455,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
>  
>  	sample.ip = ip;
> -	sample.pid = tidq->thread->pid_;
> -	sample.tid = tidq->thread->tid;
> +	sample.pid = tidq->prev_thread->pid_;
> +	sample.tid = tidq->prev_thread->tid;
>  	sample.addr = cs_etm__first_executed_instr(tidq->packet);
>  	sample.id = etmq->etm->branches_id;
>  	sample.stream_id = etmq->etm->branches_id;
> -- 
> 2.34.1
> 
