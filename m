Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069E711F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjEZGBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjEZGBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:01:09 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330F125;
        Thu, 25 May 2023 23:01:07 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-456d241fcdcso90337e0c.0;
        Thu, 25 May 2023 23:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685080866; x=1687672866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyyvopx0qx2J/HSG6Wcv+o30ueEsw+4dnHLmLntqWO0=;
        b=bNy5AALy57U9ftCANNuw6TDyUEnVrSGCKhjt1M0OJ9PbbkFCpgikMUHZIh7tY2I4U9
         225p8L9qcfBi59Ofe3v/59LkTeF6ZHtLHzslM9aTUUO8Atc5/jz4+JWkW/ydQpgkhTRb
         loMALBPlQE+ibgV72DNdHliGsS7VMkSmYLWybORlxQWv9jNHrvESdK8BSt+gx9kUDt/c
         1NImG3zJKtae1pITh8c265GMQfvhh/9ZGOxmoUFt+zItLAormv9RcN7TjDhh4ecTaNuo
         SFP31cSaB9tUWgMD+wXpDIyPVZ72O++gT7ccuILsUp0JDsDsTy5amVWS5/kuGtcXA1H7
         u5lw==
X-Gm-Message-State: AC+VfDxxDuQgxC8IiGpHP9jbAuePZ00zrPkpAErdoY/MDVt97bgBuqai
        VFx2TjpHRCDbv4iIP2ydDNHc32Kho3JLO9oaeWQ=
X-Google-Smtp-Source: ACHHUZ4R3VkfaZqO0u4ktzwQDLEQ6WefzmiPcpcOcO9OEnJ9lihnKylFnHJWVR6rd0jIeg1vjSN/xkNrVbCZzmQTAUU=
X-Received: by 2002:a1f:3d17:0:b0:3ea:7af1:9ea4 with SMTP id
 k23-20020a1f3d17000000b003ea7af19ea4mr156594vka.12.1685080866267; Thu, 25 May
 2023 23:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com> <20230525071133.2066610-2-irogers@google.com>
 <CAM9d7cgaSPbnjoA6bv8fwkpoyc6nCdXOOrbmBm_jGbZbm3a_4w@mail.gmail.com> <CAP-5=fX0BnzQacr1NRQfis42osk07BuKJ9BqNTf7pGBMoj4ORA@mail.gmail.com>
In-Reply-To: <CAP-5=fX0BnzQacr1NRQfis42osk07BuKJ9BqNTf7pGBMoj4ORA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 May 2023 23:00:54 -0700
Message-ID: <CAM9d7ci5NhKTUPv_+v5t-exVOSESTzpV4BrUCfQhXbFLrV0kDg@mail.gmail.com>
Subject: Re: [PATCH v1 01/16] perf header: Make nodes dynamic in write_mem_topology
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, May 25, 2023 at 7:39 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, May 25, 2023 at 12:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, May 25, 2023 at 12:12 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Avoid a large static array, dynamically allocate the nodes avoiding a
> > > hard coded limited as well.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/header.c | 33 +++++++++++++++++++++------------
> > >  1 file changed, 21 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index 2dde3ca20de5..80593ed8c79b 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -24,6 +24,7 @@
> > >  #include <bpf/libbpf.h>
> > >  #endif
> > >  #include <perf/cpumap.h>
> > > +#include <tools/libc_compat.h> // reallocarray
> > >
> > >  #include "dso.h"
> > >  #include "evlist.h"
> > > @@ -1396,13 +1397,14 @@ static int memory_node__sort(const void *a, const void *b)
> > >         return na->node - nb->node;
> > >  }
> > >
> > > -static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
> > > +static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
> > >  {
> > >         char path[PATH_MAX];
> > >         struct dirent *ent;
> > >         DIR *dir;
> > > -       u64 cnt = 0;
> > >         int ret = 0;
> > > +       size_t cnt = 0, size = 0;
> > > +       struct memory_node *nodes = NULL;
> > >
> > >         scnprintf(path, PATH_MAX, "%s/devices/system/node/",
> > >                   sysfs__mountpoint());
> > > @@ -1426,16 +1428,24 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
> > >                 if (r != 1)
> > >                         continue;
> > >
> > > -               if (WARN_ONCE(cnt >= size,
> > > -                       "failed to write MEM_TOPOLOGY, way too many nodes\n")) {
> > > -                       closedir(dir);
> > > -                       return -1;
> > > -               }
> > > +               if (cnt >= size) {
> > > +                       struct memory_node *new_nodes =
> > > +                               reallocarray(nodes, cnt + 4, sizeof(*nodes));
> > >
> > > +                       if (!new_nodes) {
> > > +                               pr_err("Failed to write MEM_TOPOLOGY, size %zd nodes\n", size);
> > > +                               free(nodes);
> > > +                               closedir(dir);
> > > +                               return -ENOMEM;
> > > +                       }
> > > +                       nodes = new_nodes;
> > > +                       size += 4;
> > > +               }
> > >                 ret = memory_node__read(&nodes[cnt++], idx);
> >
> > I think you need to handle error cases here.
> >
> > Thanks,
> > Namhyung
>
> Not sure I follow. The reallocarray tests for failure, frees nodes and
> returns -ENOMEM on error.

Right, but I think it would leak the nodes when the
memory_node__read() fails.

Thanks,
Namhyung
