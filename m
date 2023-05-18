Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADA708763
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjERR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjERR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:59:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CCDB;
        Thu, 18 May 2023 10:59:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3909756b8b1so844990b6e.1;
        Thu, 18 May 2023 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684432777; x=1687024777;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3RZ484p2SQ7TxSccE0/ZDJkbe9UYR5m17S/JmLq0VRc=;
        b=Pt5lc058I1U0eKntpmnf6AmBTmfzAXhGZPXf3f7ZL8k7/N+Z/VTQHgbN62ZQ4yDFLp
         C6RdbXyrhoYLGuwy7OKrIUD+ArTiGo3o9IgURojrFhiKMBzt0exyVRHZzMh7maNKStLX
         Dxrj42D/cKCUzz5NUX4yCKKCmMO6SdNFoCGmL5HCOESWMZz49Hy5Co1MTV43MZR0iUYf
         tY07fKUaalWJISSlCQEOlo4k4yq+4Dt5uUgfUyunE6tXZY7On3Em+LCzXsYE9kqjGKB7
         t3mdQOFNwvt5NQBVp7x+0+RBDgeVj/lg3uFlD9U0YLJYgTr+aPlkyz4ZMMHuvLjDX4GA
         u3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432777; x=1687024777;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RZ484p2SQ7TxSccE0/ZDJkbe9UYR5m17S/JmLq0VRc=;
        b=CX2FC8EiRh44S+jP+BZyEOtdYMNpTQ2CAox47SE1gL3+UQP0oUK584lAGdjEynB68m
         NYcqfgddaqBJF2yfDuPo0RaCWC5t7mBJHKGHrDTd6PleAo0Qr9HvSZt00fTsN9R554px
         R+Ep7HvlCUde8L5mome8QmXnUs9u4nc1DnIr8YXStOhFHci/m7Ep95zfJEjvFEpyDSOf
         EYf41WcZPu2JLzzYNCY/FzWuSmQeBWEEsX8IKaAa3iIRcGnCLZzIwwkH1TIHaGkVNA9R
         cjDiaYvtPkb8CsITEU125E4yLY3s86wdM+HUPGepf1c3ThlMm29+R0vtZ0Ll4YUZu07o
         xoYQ==
X-Gm-Message-State: AC+VfDyE8HKREofxeJI9dDeNO5E5GNzmigZJpJ5NmgxI1MrBZhp0pLzm
        T7y+j+p8LgrEqKHzr+75q+k=
X-Google-Smtp-Source: ACHHUZ7wvbFwrbwfJyso5tvo+RO6RA9saOfmJkwM5rTA+0ms7qi1jYOGSS3k0Gu0XljGe47pme0UTw==
X-Received: by 2002:a05:6808:1a1e:b0:387:1e2a:fed2 with SMTP id bk30-20020a0568081a1e00b003871e2afed2mr1647930oib.49.1684432777332;
        Thu, 18 May 2023 10:59:37 -0700 (PDT)
Received: from [127.0.0.1] (177-57-195-112.3g.claro.net.br. [177.57.195.112])
        by smtp.gmail.com with ESMTPSA id i9-20020a056820138900b00552465a754esm658600oow.44.2023.05.18.10.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:59:36 -0700 (PDT)
Date:   Thu, 18 May 2023 14:59:26 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/2=5D_perf_test_attr=3A_?= =?US-ASCII?Q?Update_no_event/metric_expectations?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9178149c-45e8-3de4-58db-b8b8d27b3a08@linux.intel.com>
References: <20230517225707.2682235-1-irogers@google.com> <64f329a9-09a3-aa84-a354-23a919062d09@arm.com> <ZGYYJ/biKyeFNJjL@kernel.org> <f753beda-2d5e-c391-520a-450b186fd4d4@linux.intel.com> <9178149c-45e8-3de4-58db-b8b8d27b3a08@linux.intel.com>
Message-ID: <053C65F5-503E-4DF8-8882-0B9EF1581D03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 18, 2023 2:45:06 PM GMT-03:00, "Liang, Kan" <kan=2Eliang@linux=2Ein=
tel=2Ecom> wrote:
>Hi Arnaldo,
>
>On 2023-05-18 8:55 a=2Em=2E, Liang, Kan wrote:
>> On 2023-05-18 8:20 a=2Em=2E, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, May 18, 2023 at 08:50:14AM +0100, James Clark escreveu:
>>>>
>>>> On 17/05/2023 23:57, Ian Rogers wrote:
>>>>> Previously hard coded events/metrics were used, update for the use o=
f
>>>>> the TopdownL1 json metric group=2E
>>>>>
>>>>> Fixes: 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default i=
f present")
>>>>> Signed-off-by: Ian Rogers <irogers@google=2Ecom>
>>>>> ---
>>>>>  tools/perf/tests/attr/base-stat            |   2 +-
>>>>>  tools/perf/tests/attr/test-stat-default    |  80 ++++++++-----
>>>>>  tools/perf/tests/attr/test-stat-detailed-1 |  95 +++++++++------
>>>>>  tools/perf/tests/attr/test-stat-detailed-2 | 119 +++++++++++-------=
-
>>>>>  tools/perf/tests/attr/test-stat-detailed-3 | 127 ++++++++++++------=
---
>>>>>  5 files changed, 249 insertions(+), 174 deletions(-)
>>>>>
>>>> Reviewed-by: James Clark <james=2Eclark@arm=2Ecom>
>>> Thanks, applied both patches to perf-tools=2E
>>>
>> Could you please hold patch 1 for a while?
>
>Sorry for the noise=2E

That's not noise, I value your reviews, please keep doing them=2E

>Ian has addressed my concerns=2E The patch looks good to me now=2E
>It also fixes a "Failed" on my Cascade Lake machine=2E
>
>Tested-by: Kan Liang <kan=2Eliang@linux=2Eintel=2Ecom>

Thanks !

>But for long term, we probably need a better solution to avoid keeping
>adding such non-architectural events in the test case=2E

Yes, the situation now is different than the one when this test was put in=
 place by Jiri (IIRC)=2E

- Arnaldo
