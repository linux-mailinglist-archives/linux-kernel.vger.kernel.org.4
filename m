Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149296F0E34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjD0WKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0WKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:10:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DB35BD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:10:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f32588c13so1365689866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682633450; x=1685225450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyoa/O+xLiuZWHEuPVWItqEbSS644YOhbq3/kpsTdWI=;
        b=uIkFDXD7Gl/5Hged7cy5WzDVEKQLJdxQEgEsJ1xG0dt//zGEZ5cf/fWM5ZrvvknWw7
         MKEC9kJsNz6NlMHXpjgbBicFkyB7nyfyy7UO9UeHBQcQE/chBKOvcZrMBm98w8ldGdYW
         HOqP/UaJUCXG2mZsHlp+NOMZHlATpTFSQXMfXoYrzxfzb1JhvsWHRnHj13kK4uO220s+
         Da/4UKrw12aOt9TdO24U2SLVIAGcQXRPY9X4O7w0hAHmvMm6lruS5PMvqzf/EKS16dqN
         o6xsG3K2AHYaZuHGdlu1z27vpSg2pjsncIWA+oRxD7Vy/qJ7XpEdDt5PM/rahjNBDk5J
         OP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633450; x=1685225450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oyoa/O+xLiuZWHEuPVWItqEbSS644YOhbq3/kpsTdWI=;
        b=akX0Fb49fGf4EzE8QWjuIPLQr3v+bFi8eDsStPCiMkI6ZmznQ64AHpW9ifNG7zDySd
         DQPcroaIVB5ZK9TT/yeLEvhpc/elrIZuHIdPldUTP0aHKx2VUh6P4vF1PqDuoJB0vuE4
         TXeBYRX37l7bWOmhnqscF+A5VkJ8MSaaybqQFmLZyBRoE4n8XSy0Fw4C+bHjBfy0gkQx
         xgd3vBHNCPa/TnyLgxtnedO5l0TP9OwYTlCQApxiE7nJ9oBIxHOGFIUPneWrKxJ8dgnK
         gbGRCJ/cR126v48PIc93OHHHraem08B8FiAtzDMwZ7YeoMrdBiITCPbEKoHOO4sLWnNs
         a15Q==
X-Gm-Message-State: AC+VfDwb0cB99kGvtqz0xEkJU9+n9/PkzCKPLiJxae3LAQtzZkehcqiQ
        o42Ap07/xkfvBtLvxGt7y8E6Zvu2GV5R9P/IpXc=
X-Google-Smtp-Source: ACHHUZ4DJDiASltZaBlAGInmkmTC8QVWuBREO5qpOYmqWvjKalZg/u0vzUfmhyTrDWjgz8+QGDtm8g==
X-Received: by 2002:a17:907:701:b0:94f:865d:fb8d with SMTP id xb1-20020a170907070100b0094f865dfb8dmr3486711ejb.11.1682633449563;
        Thu, 27 Apr 2023 15:10:49 -0700 (PDT)
Received: from leoy-huanghe ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id pv22-20020a170907209600b0094f0025983fsm10330876ejb.84.2023.04.27.15.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:10:49 -0700 (PDT)
Date:   Fri, 28 Apr 2023 06:10:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] perf: cs-etm: Validate options after applying
 themperf_pmu__format_bits
Message-ID: <20230427221047.GA174797@leoy-huanghe>
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-5-james.clark@arm.com>
 <20230427151228.GA152865@leoy-huanghe>
 <dac76dd5-d5f0-61dd-fafe-f939f1ebc413@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac76dd5-d5f0-61dd-fafe-f939f1ebc413@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:52:06PM +0100, James Clark wrote:

[...]

> >> -static int cs_etm_set_context_id(struct auxtrace_record *itr,
> >> -				 struct evsel *evsel, int cpu)
> >> +static int cs_etm_validate_context_id(struct auxtrace_record *itr,
> >> +				      struct evsel *evsel, int cpu)
> >>  {
> >> -	struct cs_etm_recording *ptr;
> >> -	struct perf_pmu *cs_etm_pmu;
> >> +	struct cs_etm_recording *ptr =
> >> +		container_of(itr, struct cs_etm_recording, itr);
> >> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> >>  	char path[PATH_MAX];
> >> -	int err = -EINVAL;
> >> +	int err;
> >>  	u32 val;
> >> -	u64 contextid;
> >> +	u64 contextid =
> >> +		evsel->core.attr.config &
> >> +		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
> >> +		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
> > 
> > Seems to me, this would break backward compability.
> > 
> > The old kernel (before 5.11) doesn't provide 'contextid1' and
> > 'contextid2', so we always check the entry 'contextid' rather than
> > 'contextid1' and 'contextid2'.
> > 
> > With this change, if a kernel doesn't contain 'contextid1' and
> > 'contextid2' formats, will perf tool never trace for contexid?
> > 
> 
> No because I changed to to be purely validation, so the format flags
> would still be applied. But yes I think you are right there is a small
> issue.
> 
> Now validation of 'contextid' isn't done on pre 5.11 kernels. But that
> only checks for ETMv3 anyway.

IIUC, 'contextid' is not only used for ETMv3.  Just quotes the comments
from drivers/hwtracing/coresight/coresight-etm-perf.c:

  73 /*
  74  * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
  75  * when the kernel is running at EL1; when the kernel is at EL2,
  76  * the PID is in CONTEXTIDR_EL2.
  77  */

ETMv4 uses 'contextid' as well, since the user space needs to know which
exception level's PID should be traced, e.g. when CPU runs in EL2
'contextid' is set as ETM_OPT_CTXTID2, the perf tool will set 'contextid2'
to tell driver to trace CONTEXTIDR_EL2.

We can only verify 'contextid', and set 'contextid1' or 'contextid2' based
on CPU running exception level, finally driver knows how to trace PID.

Thanks,
Leo

> Validation of 'contextid1' and
> 'contextid2' isn't a problem, because if the kernel doesn't support them
> they can't be applied on the command line anyway.
>
> I can fix it by checking for 'contextid' and ETMv3 first and then doing
> 'contextid1' and 'contextid2' after.
