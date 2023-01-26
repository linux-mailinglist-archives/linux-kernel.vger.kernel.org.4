Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD567D51B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjAZTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAZTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:10:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634F190
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:10:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so2325030wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZVlCpe2YPL2TN3TFT9AqKB26L5YrQ2SxKcA4F5aIVA=;
        b=bqiPNBtPCGC3Dt5ZQRSVrAtgB5YTmuDiUyV/bySZ3En9FH7ZiSa+3d475afcxorzQL
         BcBlMbWZDlAEDRT8ehVmM0H18jLP84kk0FLIv0Th5HBB0ttBFsp/BuxMDv0O7yaMozMF
         u1EioQKIUN1hAO89sTx5webSx+SGSqK0BjKDDCKwf+LEh2Mt9LZT2Ou2rHrOOliSxMQQ
         8BdQXRmTW/3GxO7FNLYC3jipX4GwYJxCAGpsd/nkLjiI4K5ulSdS9vB+ajB9oebDL2Um
         7//AfPRGk5idWtx1cFt6Rx2JCbX9hZ4je6PhcI3I+7Tzg6wmnKIK8YZAHi+zpsRa8JdP
         qOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZVlCpe2YPL2TN3TFT9AqKB26L5YrQ2SxKcA4F5aIVA=;
        b=4Sv/AM6vto3HKmkJrKgDxInOBfpsccnUeV9j172DYskAZFY+1s4jCC0wGUDXjNb18R
         SJKGbq1JIuLOxYtkpbRC1OAjmdvyiQMyKAu6oQjrMVmfUAcoFsPd46UW9Qjv9gUAA1dp
         Lr5Ea+NwPG+rOGYlMp7NJGaxbK+hXM7tBY0AaAIXXqkBspaGyXuOwl28bcY1p8GB+cdY
         x+/KnmEPnm5kLPY5r6o5TF7PRMTkZUtZknIHQnsosQ2MBwbkW7LzsHsNwW2F5U38yF8j
         r1hiN2EabGeswTYDpJuG0Qt0benZR/zFvA8uJ5RbNZjmDcAPQQUQooMyU7YdTgwfj158
         rq2g==
X-Gm-Message-State: AO0yUKXlW9gv4tTk3Eo+OwI3HsCDdzz1hSvLAONkRRPPJRZf37s2u0tj
        p4mPK4QDxVXuO03ESQKb/OZlJlNxLsSUYpzavRFR/w==
X-Google-Smtp-Source: AK7set/mmUq2VJuJRVgzRa/6Xnzlcx41hw/h5rvmYu2jYOJyL5sIkbF+l18j3dzlNgKOqoIJLVRMJ/NxowqhDSYUYuY=
X-Received: by 2002:a5d:5341:0:b0:2bf:b79f:73f0 with SMTP id
 t1-20020a5d5341000000b002bfb79f73f0mr345146wrv.654.1674760213868; Thu, 26 Jan
 2023 11:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com> <20230126011854.198243-3-irogers@google.com>
 <e74b8293-5d30-7522-6e5e-a7c7994039c5@oracle.com>
In-Reply-To: <e74b8293-5d30-7522-6e5e-a7c7994039c5@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 Jan 2023 11:10:01 -0800
Message-ID: <CAP-5=fUrHqAtP-yRDYi4G4oo-PX-2YF8tyB=BBk2t0iM_U3__g@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] perf jevents metric: Add ability to rewrite
 metrics in terms of others
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 7:59 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 26/01/2023 01:18, Ian Rogers wrote:
> > Add RewriteMetricsInTermsOfOthers that iterates over pairs of names
> > and expressions trying to replace an expression, within the current
> > expression, with its name.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> hmmm ... did you test this for many python versions?
>
> Maybe this patch causes this error:
>
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 7, in <module>
>     import metric
>   File "/home/john/acme/tools/perf/pmu-events/metric.py", line 549, in
> <module>
>     def RewriteMetricsInTermsOfOthers(metrics: list[Tuple[str, Expression]]
> TypeError: 'type' object is not subscriptable
> make[3]: *** [pmu-events/Build:26: pmu-events/pmu-events.c] Error 1
> make[2]: *** [Makefile.perf:676: pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>
> I have python 3.6.15
>
> Thanks,
> John

Apologies, I have to test python3.6 with docker and so if I think the
change is small enough.. My error, will spin v5.

Thanks,
Ian

>
