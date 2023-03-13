Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817E26B8347
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCMU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCMU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:59:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99C126E3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:58:31 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h11so2329723ild.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678741107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz/F3ZMv7JJTYZGTybhdPyEf/RGnba1yVdkcAMI5UGs=;
        b=CX5N+6G4k61+cs5paeZTKqx3CgY3MqW1PGC3VLqiHAc3Lrd0ET11IpVzV0YbGQuAhT
         kN9pVSXmJaO4L+GH2fNmFZqiJe+kAanFT20RUughuKx+ZeCRJO2bsqE4d+iD9C6ICjY0
         39bzUoWEwWWcxvXCPs2v6my2T9ZGYzCX5248ogRVXVwe/VNO+xxfdIGbJNmcY0yeA4Je
         qmBMm9/otFx29sNbuFFVlWPreJqSlI4uyPY7XYirwAkxvWcN2yNJcMw0xGgVJ5ovTdOW
         lUbtm9J2jP+rUsEsx1DVMhtWTKuv9vIcaVjGuEklJPnYUArGp8ho3d3FX45CjsuAXyA0
         tj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz/F3ZMv7JJTYZGTybhdPyEf/RGnba1yVdkcAMI5UGs=;
        b=nKXGNVyYMMT5kjxQUlEmSBBeQkFxGeaOlUKi47HtYKJ9h74IixBNAkQqUWw+DkITi9
         q4b36jFFJfmAm/B/WIMj0hO8OocqIGfr41iVJfUyq4AwfL4SfOuOwgjIDgS3SXj7nNd1
         uW+L0/3INoMuFWJu5+jcLhH2N9XrGbWSwY9D3klIdJelMWrMFXVLp7u01qhjCZx+AeO0
         49mHfqFQJeLc83rOCZ5eS5dpmjxce4g3MfbET4F6dMTVbx+aQ/IU1zevfS95IPS37PFH
         LGQbF/Ehh3Rfmd5NfWxG1rXToEkkKYk0sGogazwo3DVhO/+GyDcrnZV8YeFwbktUaJfK
         veZw==
X-Gm-Message-State: AO0yUKU5BIOtIcinD1e3MAAtriyph9IgcSAAlS9nE85zTFX8UGfNtEIh
        fDtVgxlmytNLMLA3N+qX6mIXKBjzHhnsTIFSoS9YvQ==
X-Google-Smtp-Source: AK7set+Xi9ueG8OhlwmwlrRpeY2SXs9S254LzUANmFveR3Bx9FO9NaM1s5wYgid/T+MUYELve8vax69y6fNNKiJvEQ8=
X-Received: by 2002:a05:6e02:12a8:b0:323:17f1:e752 with SMTP id
 f8-20020a056e0212a800b0032317f1e752mr532220ilr.0.1678741107477; Mon, 13 Mar
 2023 13:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com> <20230308225912.1960990-7-irogers@google.com>
 <ZA+KjvtPyDDb0Xb5@kernel.org>
In-Reply-To: <ZA+KjvtPyDDb0Xb5@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 13:58:16 -0700
Message-ID: <CAP-5=fXdJ3UQMF47BVt4-mPdVnAyzPpFnWWCdh74WL89=+3VDQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] perf evsel: Add function to compute group PMU name
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 13, 2023 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Mar 08, 2023 at 02:59:07PM -0800, Ian Rogers escreveu:
> > The computed name respects software events and aux event groups, such
> > that the pmu_name is changed to be that of the aux event leader or
> > group leader for software events. This is done as a later change will
> > split events that are in different PMUs into different groups.
>
> This makes 'perf test python' to fail:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF =
maps, etc
>  19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 720242
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf-t=
ools-next/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-li=
nux-gnu.so: undefined symbol: evsel__is_aux_event
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> So I added the following patch, please run 'perf test' and 'make -C
> tools/perf build-test' before submitting patch series.
>
> - Arnaldo

Hmm.. was passing for me:

```
 19: 'import perf' in python                                         :
--- start ---
test child forked, pid 3161744
python usage test: "echo "import sys ;
sys.path.append('/tmp/perf/python'); import perf" | '/usr/bin/python3'
"
test child finished with 0
---- end ----
'import perf' in python: Ok
```

albeit:
```
$ nm /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so |grep is_aux_eve=
nt
                U evsel__is_aux_event
```

Perhaps there's some more aggressive linking flag I need to enable.

Thanks,
Ian

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index ab48ffbb644805df..be336f1b2b689602 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -93,6 +93,11 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const ch=
ar *name, const char *fmt,
>         return EOF;
>  }
>
> +bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
> +{
> +       return false;
> +}
> +
>  /*
>   * Add this one here not to drag util/metricgroup.c
>   */
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> >  tools/perf/util/evsel.h |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2dc2c24252bb..51d9650267d0 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
> >       return "unknown";
> >  }
> >
> > +const char *evsel__group_pmu_name(const struct evsel *evsel)
> > +{
> > +     const struct evsel *leader;
> > +
> > +     /* If the pmu_name is set use it. pmu_name isn't set for CPU and =
software events. */
> > +     if (evsel->pmu_name)
> > +             return evsel->pmu_name;
> > +     /*
> > +      * Software events may be in a group with other uncore PMU events=
. Use
> > +      * the pmu_name of the group leader to avoid breaking the softwar=
e event
> > +      * out of the group.
> > +      *
> > +      * Aux event leaders, like intel_pt, expect a group with events f=
rom
> > +      * other PMUs, so substitute the AUX event's PMU in this case.
> > +      */
> > +     leader  =3D evsel__leader(evsel);
> > +     if ((evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__is=
_aux_event(leader)) &&
> > +         leader->pmu_name) {
> > +             return leader->pmu_name;
> > +     }
> > +
> > +     return "cpu";
> > +}
> > +
> >  const char *evsel__metric_id(const struct evsel *evsel)
> >  {
> >       if (evsel->metric_id)
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 676c499323e9..d26745ca6147 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *=
bf, size_t size);
> >
> >  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char=
 *bf, size_t size);
> >  const char *evsel__name(struct evsel *evsel);
> > +const char *evsel__group_pmu_name(const struct evsel *evsel);
> >  const char *evsel__metric_id(const struct evsel *evsel);
> >
> >  static inline bool evsel__is_tool(const struct evsel *evsel)
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
>
> --
>
> - Arnaldo
