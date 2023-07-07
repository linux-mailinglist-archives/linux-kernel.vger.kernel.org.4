Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60474B897
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGGVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGGVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:13:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683B2702;
        Fri,  7 Jul 2023 14:12:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8bbce9980so16786585ad.2;
        Fri, 07 Jul 2023 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688764357; x=1691356357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+zbVeGsIu88HXn6Bzuf24zwb+/jDouBgewDVwqhr3c=;
        b=ZN5rkvBZLv9HYk1H7ecMPvpCji31Y7vvcmqn76vlvh3LT/4P4ck5sK9vAaQmKlPmSu
         WfC+WZYtV1Z2gYlamzblzi142y4tr+GLuVYd6HusBcTEFMcmEpfxuSkO3EnWPUaeEnEa
         XOGm3Fcgobne83qKc0q2lU5D9doYk7F+jkKAK4VCHcdwdC14PdCYeXVqALdnEmxuVFEl
         duZY9O9ihxn/7YrLU19a+Ehnza8aRkG5/byUUYSOcYXJUL7p4jrS1QsrefRVbT+d6QPV
         Uq6CNE6+hBtKIXGXD7+3EEyhyvXi4iyT7wbqCzFebeGHCl5Z/8FEerZFETW7hnQjMlVU
         WsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764357; x=1691356357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+zbVeGsIu88HXn6Bzuf24zwb+/jDouBgewDVwqhr3c=;
        b=hby25NwqmF32F9kby6wzdMvphtDDGf7XF6bcBv+7v6vsbzZzkl0LhTgHN4meFhGtx/
         4AwSUdZ14ZRceTXW+xC4c8u55E1630SnH4HOK6olGYQ2gBQvb2ZCDgiLe9AN8JkhJCl4
         azepH4ZsiXlrc0oN31X7WfWFKcyNFMS5sS+FUuNI/9610pBcAICRcfAAJ/ophhp5gHPF
         yI9VRkWXMb1mp5Bw6al6MWTpy8NwNsR7RVggIsUe/LzihbvRl8IkrOdEqR3GztzeufmL
         a9MulMzbRDrOUjuigMXnz3TMF6dk2fftKYxNG04dCx0ePxAHY7IxTOJophheFLH8sLcG
         oJ/Q==
X-Gm-Message-State: ABy/qLY8Ung3ue98weYPDvEcTxLxysXC4ZoxUV7EnBJmxYcunoUT3cYy
        2c6WyfpNZZ2wL/DaX62pnTo=
X-Google-Smtp-Source: APBJJlGKmQyrnTpCKGltFX4nFuyb/76UEU8UIZyH0PVpB0NhdZ/6X3pDJfo3TuSpvfwA59jaxJIQ+g==
X-Received: by 2002:a17:902:f546:b0:1b8:ae12:563f with SMTP id h6-20020a170902f54600b001b8ae12563fmr6246952plf.29.1688764357184;
        Fri, 07 Jul 2023 14:12:37 -0700 (PDT)
Received: from yoga ([2400:1f00:13:8a1c:1db1:98d9:af8d:f09b])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001b03cda6389sm3687832plg.10.2023.07.07.14.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:12:36 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Sat, 8 Jul 2023 02:42:29 +0530
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] scripts: python: Extact necessary information
 from process event
Message-ID: <ZKh/vWsn2EiRV/9E@yoga>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
 <de3f6251d7b0f202fac59224b9820b584233d871.1688585597.git.anupnewsmail@gmail.com>
 <CAM9d7ci_xuVVQM9h3TdT23PsyfM5iHa8x=58k8aPQ=FfaWw8iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ci_xuVVQM9h3TdT23PsyfM5iHa8x=58k8aPQ=FfaWw8iA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:35:02PM -0700, Namhyung Kim wrote:
> Hi Anup,
> 
> On Wed, Jul 5, 2023 at 12:42 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The script takes in a sample event dictionary(param_dict) and retrieves
> > relevant data such as time stamp, PID, TID, thread name, and call stack
> > information. If available, the call stack is parsed to include function
> > names and the associated DSO, which are requires for creating json schema.
> > Also few libaries has been included which will be used in later commit.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > new file mode 100644
> > index 000000000000..ce663840d212
> > --- /dev/null
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -0,0 +1,37 @@
> > +#!/usr/bin/env python3

I believe this is not needed as we are using perf-script-python interface.

> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Usage:
> > +#
> > +#     perf record -a -g -F 99 sleep 1
> > +#     perf script firefox-gecko-converter.py
> > +
> > +from __future__ import print_function
> 
> Is this needed for python3?

No, it is not needed. I will remove it.

>
> > +import os
> > +import sys
> > +import json
> > +from functools import reduce
> > +
> > +sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> > +       '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> > +
> > +from perf_trace_context import *
> > +from Core import *
> > +
> > +def process_event(param_dict):
> > +       time_stamp = (param_dict['sample']['time'] // 1000) / 1000
> > +       pid = param_dict['sample']['pid']
> > +       tid = param_dict['sample']['tid']
> > +       thread_name = param_dict['comm']
> > +       start_time = time_stamp if not start_time else start_time
> > +       if param_dict['callchain']:
> > +               stack = []
> > +               for call in param_dict['callchain']:
> > +                       if 'sym' not in call:
> > +                               continue
> > +                       stack.append(call['sym']['name'] + f' (in {call["dso"]})')
> > +               if len(stack) != 0:
> > +                       stack = stack[::-1]
> > +       else:
> > +               mod = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
> 
> Why is it 'mod' instead of 'sym' or 'func'?

I will change it to 'func'. It will be more meaningful.

> 
> Thanks,
> Namhyung
> 
> 
> > +               dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
> > --
> > 2.34.1
> >
