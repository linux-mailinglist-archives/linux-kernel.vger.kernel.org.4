Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD972D983
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjFMFuV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 01:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjFMFuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:50:18 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394193;
        Mon, 12 Jun 2023 22:50:17 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4635c158e2aso1435245e0c.3;
        Mon, 12 Jun 2023 22:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686635416; x=1689227416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsx620+1M90qrU4V38kYMgmC7IznSroVoq6oc0YB+sE=;
        b=k8Z6HE2+obOa/WFEGowyR11EINKva/INij0RxavUqPvfa6IdPSum07+Bzd41mf7Wbq
         DBJoWfiwM2+GctnEoKVcEbPFfmRZDpT5wqJVddZ/V5quLRT2xY9Y+Xv1EI7n6D2qYVH7
         q7zLrDBDvTZwVocD4xWV/TLq1QNu+l79AwZCAI3V3GUoGJQXZucXg/ZyUWXxb+eJSOyp
         1837Bu+sr9OMqAp3jKKrMJZNZlzYwFvfQ6sK7DuxieJ+Ie3Og7zDW0av4VySgafZh2d9
         MGR1Os1CisMeIp0K/t0T+9VuocN1ikS4IqHAaaEi2uwv3T1+wkgO2Z7tS1paTekRm5l6
         yzQg==
X-Gm-Message-State: AC+VfDxFed4KIg6Ilyq1ULSHdLj9A0/tHS0+rDXBCJH2GXAOauUehdwW
        IhtPkAPc/NrdMyPc3MR8CiXIVOiJa/wwlozT2Dw=
X-Google-Smtp-Source: ACHHUZ75SSTZ8MOA1nBxrAdL89bFnviFrt8Aqn8XAGlNUqTsDWpLRPiQok+KBlPBcBEv5zJ5hZXMZ8HSdQYIG5MsE0Y=
X-Received: by 2002:a1f:c192:0:b0:45e:890e:f3cc with SMTP id
 r140-20020a1fc192000000b0045e890ef3ccmr4237944vkf.4.1686635416471; Mon, 12
 Jun 2023 22:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
 <a24634f7-be80-6ca2-9df7-1624fe11c281@arm.com> <c291692c-7db8-b4cc-e17a-422c75ad8daa@huawei.com>
In-Reply-To: <c291692c-7db8-b4cc-e17a-422c75ad8daa@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 12 Jun 2023 22:50:05 -0700
Message-ID: <CAM9d7chqy-RztC943JOgRLcEHvKZN8rS542q3xxW63==KGY3CQ@mail.gmail.com>
Subject: Re: [RFC] Adding support for setting the affinity of the recording process
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
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

Hello,

On Mon, Jun 12, 2023 at 7:28 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2023/6/12 23:27, James Clark wrote:
> >
> >
> > On 12/06/2023 11:26, Yang Jihong wrote:
> >> Hello everyone,
> >>
> >> Currently, perf-record supports profiling an existing process, thread,
> >> or a specified command.
> >>
> >> Sometimes we may need to set CPU affinity of the target process before
> >> recording:
> >>
> >>    # taskset -pc <cpus> <pid>
> >>    # perf record -p <pid> -- sleep 10
> >>
> >> or:
> >>
> >>    # perf record -- `taskset -c <cpus> COMMAND`
> >>
> >> I'm thinking about getting perf to support setting the affinity of the
> >> recording process, for example:
> >>
> >> 1. set the CPU affinity of the <pid1> process to <cpus1>, <pid2> process
> >> to <cpus2>,  and record:
> >>
> >>    # perf record -p <pid1>/<cpus1>:<pid2>/<cpus2> -- sleep 10
> >>
> >
> > I'm not sure if this is necessary. You can already do this with taskset
> > when you launch the processes or for existing ones.
>
> Yes, that's what we're doing now, and I'm thinking about whether perf
> can support this "taskset" feature.

I agree with James that it looks out of scope of perf tools.
You can always use `taskset` for external processes.

>
> >
> >> and
> >>
> >> 2. set CPU affinity of the COMMAND and record:
> >>
> >>    # perf record --taskset-command <cpus> COMMAND
> >>
> >> In doing so, perf, as an observer, actually changes some of the
> >> properties of the target process, which may be contrary to the purpose
> >> of perf tool.
> >>
> >>
> >> Will we consider accepting this approach?
> >>
> >
> > For #2 I do this sometimes, but I prefix the perf command with taskset
> > because otherwise there is a small time between when taskset does its
> > thing and launching the child process that it runs in the wrong place.
> >
> > Then one issue with the above method is that perf itself gets pinned to
> > those CPUs as well. I suppose that could influence your application but
> > I've never had an issue with it.
> >
> > If you really can't live with perf also being pinned to those CPUs I
> > would say it makes sense to add options for #2. Otherwise I would just
> > run everything under taskset and no changes are needed.
>
> If "perf" process and the target process are pinned to the same CPU,
> and the CPU usage of the target process is high, the perf data
> collection may be affected. Therefore, in this case, we may need to pin
> the target process and "perf" to different CPUs.
>
> >
> > I think you would still need to have perf itself pinned to the CPUs just
> > before it does the fork and exec, and then after that it can undo its
> > pinning. Otherwise you'd still get that small time running on the wrong
> > cores.
> >
>
> Thanks for your advice, or we can support setting different affinities
> for the "perf" process and the target process.

When it comes to controlling `perf`, you can use --threads=<spec>
option which supports fairly complex control for parallelism and
affinity.

Thanks,
Namhyung
