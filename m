Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655FD749501
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjGFFfU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 01:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGFFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:35:18 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26931BD6;
        Wed,  5 Jul 2023 22:35:16 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so262332e87.3;
        Wed, 05 Jul 2023 22:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688621715; x=1691213715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1PlvNNiTnUdsZiP/Cax+GwYe1YLGfv4AkH8z3c/IKA=;
        b=c5lfu9A7ZU1c8bnSk2y8juJ2iLVlEj2nYhr503GcnWDNEOJhD2veGn2APeZMZ8FE8a
         3RCFCXmTnCo0XFk21AmrVTyhtNWwtCNpKt/Qnl1Qwang2Lej1X9xIgvuqh4nhitJpk7L
         H7IrFsLzFBisWdbcJ652sT1kMpzEJVy1ETD3PnU4NxW7qhwlUbfFwE9cCuF6dfayDJhc
         jJkiyi59qntJs0lmnb8QjBWq+JBe91IRYQHolrE1TwsethrHyuaOnrczzUf0aR3dSCbF
         hGLF890VO5JizhVrKVnJfV/T33x7taiJIv8ugpfshukgMc12kTkqUi0rgmBf6LP7BQFV
         IQJg==
X-Gm-Message-State: ABy/qLYDCpNGu5HvJU+TICUwYw3zWtU4LkRBpjznY6RIuwjmDRjgrdlL
        mEEc0tSHbX7HsDNB4F0u5hmhQ00V81B+hZZEmSVlTiLh
X-Google-Smtp-Source: APBJJlGffOjXMxygP8buFVxNENn2+hvMW54upEJ37vUqAmtLeRbWC3tXSO4RLYtl8B2IrjOFfxwcjAfV7hKdrs9fInY=
X-Received: by 2002:a19:7114:0:b0:4f9:56aa:26c5 with SMTP id
 m20-20020a197114000000b004f956aa26c5mr636564lfc.25.1688621714815; Wed, 05 Jul
 2023 22:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688585597.git.anupnewsmail@gmail.com> <de3f6251d7b0f202fac59224b9820b584233d871.1688585597.git.anupnewsmail@gmail.com>
In-Reply-To: <de3f6251d7b0f202fac59224b9820b584233d871.1688585597.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 22:35:02 -0700
Message-ID: <CAM9d7ci_xuVVQM9h3TdT23PsyfM5iHa8x=58k8aPQ=FfaWw8iA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] scripts: python: Extact necessary information from
 process event
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Anup,

On Wed, Jul 5, 2023 at 12:42 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> The script takes in a sample event dictionary(param_dict) and retrieves
> relevant data such as time stamp, PID, TID, thread name, and call stack
> information. If available, the call stack is parsed to include function
> names and the associated DSO, which are requires for creating json schema.
> Also few libaries has been included which will be used in later commit.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> new file mode 100644
> index 000000000000..ce663840d212
> --- /dev/null
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -0,0 +1,37 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Usage:
> +#
> +#     perf record -a -g -F 99 sleep 1
> +#     perf script firefox-gecko-converter.py
> +
> +from __future__ import print_function

Is this needed for python3?

> +import os
> +import sys
> +import json
> +from functools import reduce
> +
> +sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> +       '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +
> +from perf_trace_context import *
> +from Core import *
> +
> +def process_event(param_dict):
> +       time_stamp = (param_dict['sample']['time'] // 1000) / 1000
> +       pid = param_dict['sample']['pid']
> +       tid = param_dict['sample']['tid']
> +       thread_name = param_dict['comm']
> +       start_time = time_stamp if not start_time else start_time
> +       if param_dict['callchain']:
> +               stack = []
> +               for call in param_dict['callchain']:
> +                       if 'sym' not in call:
> +                               continue
> +                       stack.append(call['sym']['name'] + f' (in {call["dso"]})')
> +               if len(stack) != 0:
> +                       stack = stack[::-1]
> +       else:
> +               mod = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'

Why is it 'mod' instead of 'sym' or 'func'?

Thanks,
Namhyung


> +               dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
> --
> 2.34.1
>
