Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92C727CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjFHK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjFHK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:26:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E163173B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:26:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6532671ccc7so366437b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686219962; x=1688811962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xkH3r1pvwgUrEo7Gtm0dIWmSa6nSh/lG9Vqe1Of73g=;
        b=nCZY15shRf0+YCOaFOuY8X6w310iPAZUYi5ASkQz/GUc+4dSc2cReU0+52jpmuft1b
         zgRskJqRB9fkL8XXnZXtSGXpDEiQT3BsO1De6EkspTxOfkC7L1/My9JygCq3fEI5DVi3
         gIZ8n1z9SzT8oR85zl9AJLdkOhhKpzMKA38CfDUFMNh3BPtoHjzUjRbbrn29AMGqT0F/
         zu2wsnbm1hwaE4pjxWEmVcbQkkPkVGvF5UzRSs4IG0HYp0380HCk0LZjOxYvbLkanv/1
         2eahg6XTZb7T4cCEZtQIc/e0qfI3USBtTHh1PlSGPKru2u9a+yQrVvaFuDoJ9Ic/yvd4
         s/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219962; x=1688811962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xkH3r1pvwgUrEo7Gtm0dIWmSa6nSh/lG9Vqe1Of73g=;
        b=XRXgbJxIYCaLu1eihKsN1gsR4fGBJ9EejFBV+tT8/db6buvfX+bJemk8R88ZoQ8jqg
         eWG3F/AhpdZB+0s1nNOLLAZcJWj+E1cWMarqd5QyJzD1swjLG+G1Quk86I+dmzWgo4VE
         mi3e5FX5ucNxHXolo0Hbf1pV+hOtxZiwVghxC/yrM3X7VTM6pqaJhadiBfwsFPhYeKXh
         NT434TgA5LeQCAk5PgS5uIbCbOqSKtaaQ60Q8pjLZOUpNbUxgEYRD0BTG8zJ6vxh5HSI
         kFlSE63v/GhVYnl3A22HqdysqCFI/dqDcVycQsujNRxdxd3pswb9UGzPmImGTGsroAav
         euJg==
X-Gm-Message-State: AC+VfDwk1buu0EyWm9+OU9hGqcvaoEKTslSbxGG0QoD7tXMGvsqiwdwX
        enLBWbxA4E72RC/80TgiyaDN2Q==
X-Google-Smtp-Source: ACHHUZ5JTCRE7fcyNWts+H2vn0LEXWHBO6ClckfueGh8B+IzoyS9r/drZKEBPVRJZZdzupk6aKns1w==
X-Received: by 2002:a05:6a00:3a26:b0:659:3031:5037 with SMTP id fj38-20020a056a003a2600b0065930315037mr9799968pfb.3.1686219962556;
        Thu, 08 Jun 2023 03:26:02 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.101])
        by smtp.gmail.com with ESMTPSA id m23-20020aa79017000000b006410f4f3ecdsm822251pfo.83.2023.06.08.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:26:02 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:25:55 +0800
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
Message-ID: <20230608102555.GB123723@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
 <20230527090635.GB886420@leoy-yangtze.lan>
 <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
 <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:34:42AM +0100, James Clark wrote:

[...]

> >>> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
> >>>  		tmp = tidq->packet;
> >>>  		tidq->packet = tidq->prev_packet;
> >>>  		tidq->prev_packet = tmp;
> >>> +		thread__put(tidq->prev_thread);
> >>> +		tidq->prev_thread = thread__get(tidq->thread);
> >>
> >> Maybe cs_etm__packet_swap() is not the best place to update
> >> "tidq->prev_thread", since swapping packet doesn't mean it's necessarily
> >> thread switching; can we move this change into the cs_etm__set_thread()?
> >>
> > 
> > Yeah that might make more sense. I can move it there if we decide to
> > keep this change.
> > 
> 
> Unfortunately I don't think I can make this change. It seems like
> putting the previous thread swap in  cs_etm__set_thread() has different
> semantics to keeping all the swaps together in cs_etm__packet_swap().

Thanks for trying this.

> This is because if you swap the thread in cs_etm__packet_swap() the
> previous packet and next packet can have the _same_ thread if there
> happened to be no change. However if you only swap previous thread in
> cs_etm__set_thread(), that means that the previous thread is always
> different to the next one. This has a huge difference on the decoding
> because two adjacent packets on the same thread will say they branched
> from the previous thread that ran, not the previous thread on the
> previous packet.

Seems to me, this is a synchronization issue between the field
'tidq->prev_thread' and 'tidq->prev_packet'.

It's still hard for me to understand "two adjacent packets on the same
thread will say they branched from the previous thread that ran", IIUC,
even we move thread swapping into cs_etm__set_thread(), if the two
adjacent packets are in the same thread context, we can skip to update
fields 'tidq->prev_thread' and 'tidq->prev_packet'.

So I am curious if below cs_etm__set_thread() works or not?

static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
			       struct cs_etm_traceid_queue *tidq, pid_t tid)
{
	struct machine *machine = &etm->session->machines.host;

	/* No context switching, bail out */
	if ((tidq->thread->tid != tid)
		return;

	/* If tid is -1, we simply use idle thread context */
	if (tid == -1)
		goto find_idle_thread;

	/*
	 * The new incoming tid is different from current thread,
	 * so it's to switch to the next thread context.
	 */

	/* Swap thread contexts */
	thread__put(tidq->prev_thread);
	tidq->prev_thread = thread__get(tidq->thread);

	/* Find thread context for new tid */
	thread__zput(tidq->thread);
	tidq->thread = machine__find_thread(machine, -1, tid);

find_idle_thread:
	/* Couldn't find a known thread */
	if (!tidq->thread)
		tidq->thread = machine__idle_thread(machine);
}

Thanks,
Leo
