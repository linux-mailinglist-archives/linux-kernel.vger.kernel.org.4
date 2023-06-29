Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3711B742F83
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjF2Vb4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 17:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjF2Vbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:31:49 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30013F5;
        Thu, 29 Jun 2023 14:31:47 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5773f41c1dcso2132707b3.1;
        Thu, 29 Jun 2023 14:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074306; x=1690666306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoENgYvXFLite5/xMgXTrtXiVpAbaDQ9fsoEG3w0OLA=;
        b=Lp4EkjHxJNUEmrX9VtFdA6xnngVpiCjlAM6ml9fl1IH1aUP3b7oY5SbgEdfIDrVJvJ
         BgBrqCAsKZe95OcecnhsaEbPfA++F9RvpJmDCb4O83AmayvMpstT1wgYL/XCAfERgAEB
         Ag9E9TfVxr73LhKJHzAYwWnF08jMJ1cH8+wD9DmGkElam0QxtlIfWRyfi+6KzwvnuT1y
         Fjt/M127qvfJok7rss/1dAfC7eHNLW9jIP1sfY84xZN3q60Bo4mqPLGUkAD51NjWQ5hz
         Q+4/M45usIZ/rvB5NgvM17T1DPhXtwyNG3vIgJNx+c5fUubQZQTFf9w5kU8e9G8YtkTt
         DBlA==
X-Gm-Message-State: ABy/qLah7vaZa4Kmb3OiRzRsiQgBkTki6m3uJ4VZnYPzFyw8OpekO1YX
        OOFM+Gglzz108vaOLidNKc6lJDYV2v9/CCsApRY=
X-Google-Smtp-Source: APBJJlHokpAkUFadL2QgrAZ2q/30Xl/epYQBSSEn/8mKrLBcEzR0CGXdNOWWDltlmQfe3fiUrDiwRZOUzf6KRLkIgHY=
X-Received: by 2002:a25:19c1:0:b0:c00:92c8:542f with SMTP id
 184-20020a2519c1000000b00c0092c8542fmr779020ybz.60.1688074306279; Thu, 29 Jun
 2023 14:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Jun 2023 14:31:34 -0700
Message-ID: <CAM9d7cgX-vnwkrQMMHn2C1sCjm3YO=xaigmMTsrbkg+fHk2H2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Add metric has_event, update intel vendor events
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Jun 23, 2023 at 8:10 AM Ian Rogers <irogers@google.com> wrote:
>
> Add a new has_event function for metrics so that events that can be
> disabled by the kernel/firmware don't cause metrics to fail. Use this
> function for Intel transaction metrics fixing "perf all metrics test"
> on systems with TSX disabled. The update conversion script is posted in:
> https://github.com/intel/perfmon/pull/90
>
> Re-generate Intel vendor events using:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> Adding rocketlake support, uncore and many core events for meteorlake,
> and smaller updates for cascakelakex, icelake, icelakex,
> sapphirerapids, skylake, skylakex and tigerlake.
>
> v2. Handle failed memory allocated for evlist, John Garry.
>
> Ian Rogers (12):
>   perf expr: Add has_event function
>   perf jevents: Support for has_event function
>   perf vendor metrics intel: Make transaction metrics conditional
>   perf vendor events intel: Add rocketlake events/metrics
>   perf vendor events intel: Update meteorlake to 1.03
>   perf vendor events intel: Update cascadelakex to 1.19
>   perf vendor events intel: Update icelake to 1.19
>   perf vendor events intel: Update icelakex to 1.21
>   perf vendor events intel: Update sapphirerapids to 1.14
>   perf vendor events intel: Update skylake to 57
>   perf vendor events intel: Update skylakex to 1.31
>   perf vendor events intel: Update tigerlake to 1.13

My tigerlake laptop now passes the all metrics test with this.
It used to fail like below:

  event syntax error:
'{cpu/cycles-t,metric-id=cpu!3cycles!1t!3/,cpu/tx-start,m..'
                            \___ unknown term 'cycles-t' for pmu 'cpu'

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
