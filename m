Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211C6F495B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjEBR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEBR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:57:16 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A71733
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:57:13 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so130355ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683050232; x=1685642232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rScdh7dUaDcvbRbmVDEX55qD+T0dpr5owrV8N/eD0dA=;
        b=01egEKqpVQq3zMLOyDcrYh0xrwtLFhJxd0dNhdA8A56VPaKEqtGAKIZjwVIHLzPPHA
         dmudT5pfDN9Tl0DsX17OlYUVajjN4MQ6EEL+Vgbws/Tw+oXkyDlfxO0ujN0iDaFsN5wu
         8aFpf/YG59WLV8cObSr3NRu5XPdKwmqV4999AakiPqFyUbsUT/7VeOc8Sw6YXgxOF48d
         u9NVLZIrskWynhbziBKh3ZZadTXZH4vxJGta9XMs0EQiAzAwH9dWfKbJCjkdpfsXKKIL
         ZVqfYWL2jCAWyG3m9dFeZuiiGxm1wXisXJEE5Lpes/1si3GTPhiwESnZO5ogUOh5AlpX
         VxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683050232; x=1685642232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rScdh7dUaDcvbRbmVDEX55qD+T0dpr5owrV8N/eD0dA=;
        b=FmS1n2p6lNLrWZBtPZ+oHCpj7K4iSUfZDmI/mNFTXY1/Zr2XQro8kKzjSoXL/RdI01
         f/j1spykgfVEi3VmC+WsME+oO1CLz80JV+ou2mLs0eIOkelwk6DyVLIfQG5AwKmToUfm
         uuVPDjI8HfmAEGohbC0/1gqdCRZLTCkadJvy9zfm/uGQulF7e0Kn4EjkqJFVfjnRIuxs
         ezMJ/5bFa1h/NMHTax1kRrIWtkowa7IAzhaKuC7LbwSaA4pXy26I29U3B+5ygsbFjj5d
         sd/BPck6nmdYn7YkPapdqNE8yFZXnaqoM6Ha6XyudR0BCiGydMr1fO3CxqXarlRAsDab
         qn2Q==
X-Gm-Message-State: AC+VfDzEV4h9IMmwqJydDSuPTZNLZ1JltBHQJ9dfqw88aIBjzAsfEgWg
        RsteISNBPTtnnMFoObmxDqO9jix/IdtptJ6W4M6CYA==
X-Google-Smtp-Source: ACHHUZ4HFL8j2FPxLAmqZpis463KY+tfMVTDTzPHNZCq8y3Xim++M3nzIcH1RbFRUNHdbHQrGCiihL8OzrbggI9E1OM=
X-Received: by 2002:a05:6e02:1bcc:b0:32b:1332:3d08 with SMTP id
 x12-20020a056e021bcc00b0032b13323d08mr30204ilv.0.1683050232085; Tue, 02 May
 2023 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-36-irogers@google.com>
 <91b218e9-1650-a032-3b23-be6134c33e4f@amd.com>
In-Reply-To: <91b218e9-1650-a032-3b23-be6134c33e4f@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 10:57:00 -0700
Message-ID: <CAP-5=fVj5QxOvLHMetc00e=c7B24uOX50ormxVivWtzvYupddw@mail.gmail.com>
Subject: Re: [PATCH v3 35/46] perf parse-events: Support hardware events as terms
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 3:56=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> > @@ -269,6 +279,16 @@ percore                  { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_PERCORE); }
> >  aux-output           { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_OUTPUT); }
> >  aux-sample-size              { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
> >  metric-id            { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
> > +cpu-cycles|cycles                            { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
> > +stalled-cycles-frontend|idle-cycles-frontend { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> > +stalled-cycles-backend|idle-cycles-backend   { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > +instructions                                 { return hw_term(yyscanne=
r, PERF_COUNT_HW_INSTRUCTIONS); }
> > +cache-references                             { return hw_term(yyscanne=
r, PERF_COUNT_HW_CACHE_REFERENCES); }
> > +cache-misses                                 { return hw_term(yyscanne=
r, PERF_COUNT_HW_CACHE_MISSES); }
> > +branch-instructions|branches                 { return hw_term(yyscanne=
r, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
> > +branch-misses                                        { return hw_term(=
yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
> > +bus-cycles                                   { return hw_term(yyscanne=
r, PERF_COUNT_HW_BUS_CYCLES); }
> > +ref-cycles                                   { return hw_term(yyscanne=
r, PERF_COUNT_HW_REF_CPU_CYCLES); }
>
> These are generic terms and thus can be added to _any_ pmus. Ex:
>
> Before:
> ```
> $ sudo ./perf stat -e amd_l3/cycles/ -C 0 -- sleep 1
> event syntax error: 'amd_l3/cycles/'
>                             \___ unknown term 'cycles' for pmu 'amd_l3'
> ```
>
> After:
> ```
> $ sudo ./perf stat -e amd_l3/cycles/ -C 0 -vv -- sleep 1
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   size                             136
>   config                           0xb00000000
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> Warning:
> amd_l3/cycles/ event is not supported by the kernel.
> failed to read counter amd_l3/cycles/
>
>  Performance counter stats for 'CPU(s) 0':
>
>    <not supported>      amd_l3/cycles/
>
>        1.059391819 seconds time elapsed
> ```
>
> Here `type=3D0` which means perf is trying to open event on HW pmu instea=
d
> of amd_l3//. `config` is 0xb00000000 where 0xb is amd_l3 pmu type:
>
> $ cat /sys/bus/event_source/devices/amd_l3/type
> 11
>
> Not sure if this is expected behavior.

I agree this is definitely a change, I'm not sure what we can do to
handle this better. Firstly, let's not be overly negative, the code
fixes it so that "branch-brs" (an AMD sysfs event) is now a valid
event name rather than a parse error. For the example above we have
the case of an unsupported event now not giving a parse error, only
possible as all PMUs were scanned, but giving an open error as the
event name matches in the list of hardware events but the extended
type encoding of the PMU yields a PMU that can't handle it.

I think parsing should be concerned with taking information to yield a
struct perf_event_attr. When it gets into the game of testing PMUs for
support then we easily get test regressions, as the test system may
lack the PMUs that are part of the test. We also get issues on hybrid
like PERF_TYPE_HW_CACHE events being supported by one PMU and not the
other. The existing hybrid behavior is to silently skip the events
that aren't supported - tested with a perf_event_open. The behavior
after these patches is to open the event on both PMUs but display not
supported/counted generally on the atom PMU. So the coding decision
there was to say parsing and opening are separate stages, and the
correct place to fail was in the open.

We could change the event parsing for this case, have different parser
notions of core PMU and every PMU, then only allow the hardware events
on the core PMU. This would require hard coding a core PMU list into
the parser and I'm not keen on that.

Thanks,
Ian
