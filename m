Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8E6F4B70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjEBUhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEBUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:37:22 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB51997
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:37:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3311833ba3dso156655ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683059840; x=1685651840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Cl+EqDeYwpTNeDyJZ31cWxa2e7SIFMBY+Z+r+9CTeM=;
        b=RoE+6ObKk+Ofk7Ps/wn5WI10EqZLQwmhPRozbE2ZSakrN7Xaq0YaERAw0+rOd7Stoc
         3ojazmjJ8k2LZwNBmsH/62gjYAF1gMzbrkvs5GwP/0ZuI0RjhR7PMmPZMq9jDqOzF4aq
         PccfjEK87WMbnLPlwOM0rckBIJbaduL2jC8q9KuFjMRti2ry+x40B7WmvgMwdIbqfhYn
         t4Wb25WZYvgbyKpq37O/s8HavFjMEHY8g+CyEykP8X+czykNQ41CJTO+NsFelff75ljl
         j/JnuBHoWW/0og7moMOKss3F9ExA8JVMUP2AL6iuFDnoUsFl7HiIladdEm2+DO0f75NF
         6tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059840; x=1685651840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Cl+EqDeYwpTNeDyJZ31cWxa2e7SIFMBY+Z+r+9CTeM=;
        b=Uc82L9ohnE/gsUognapN/ZDvhg1Eb6DECbTeDGCubG/d2o5v2Ydw9JgCpniKDoi1qQ
         X27NdoQcZydnuzwQHCdl8SKZRBX1hFKHKCxuUhi6pManenqd8D8+XcTrjjx4l97ePsTD
         0/hQQMLnl55C5uSfWS4Vol6rvJ5XzFrwbSwa455thHkCaHjt9knTLHYW9EcuX6NC4kHj
         exWSIFnF48Ec1EzAyzyiui0yJbjvEmK/cZ1CqHhDoaxW5zAthZem7U/b39MkIIsB7Fqp
         OiB6TXlzYtfhDLIZdEaF/8LgMKrHZY2yX+96T8Q4w2TfjYo5XZGaqm6Gg5GXx0GQlMHO
         WgBw==
X-Gm-Message-State: AC+VfDyk2ZmNEmtpH1zrHv6kxAUX8k5Jg9P/mwpVKr5nXmUeLUoxUcPz
        7HQw0jcTeUT1v6jFMl0x6BHapC3VOMyUnvzz1I8yVA==
X-Google-Smtp-Source: ACHHUZ75SsGaI9x5mLnHNfrvwr3lXTjJQxO+5cZDVkg8RLDJbVmEjlQf6e4l6ixWHvLHNMXWECbK55bHC57ZYECbiSY=
X-Received: by 2002:a05:6e02:178d:b0:326:55d0:efad with SMTP id
 y13-20020a056e02178d00b0032655d0efadmr76821ilu.12.1683059839895; Tue, 02 May
 2023 13:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230502203135.24794-1-jinli.xiao@nyu.edu>
In-Reply-To: <20230502203135.24794-1-jinli.xiao@nyu.edu>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 13:37:04 -0700
Message-ID: <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
Subject: Re: [PATCH] perf python: Set error messages on call failure
To:     Jinli Xiao <jinli.xiao@nyu.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 1:31=E2=80=AFPM Jinli Xiao <jinli.xiao@nyu.edu> wrot=
e:
>
> Updates the perf python binding to provide more informative error
> messages to the user when there is a call failure. The changes include
> setting error messages on several different scenarios when the package
> needs to return -1 or NULL.
>
> Signed-off-by: Jinli Xiao <jinli.xiao@nyu.edu>

Nice! Would it be possible to test this? We could do a shell test:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/tests/shell

Thanks,
Ian

> ---
>  tools/perf/util/python.c | 61 ++++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 42e8b813d010..7e6b12e87744 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -635,12 +635,16 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map *=
pcpus,
>         char *cpustr =3D NULL;
>
>         if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|s",
> -                                        kwlist, &cpustr))
> +                                        kwlist, &cpustr)) {
> +               PyErr_BadArgument();
>                 return -1;
> +       }
>
>         pcpus->cpus =3D perf_cpu_map__new(cpustr);
> -       if (pcpus->cpus =3D=3D NULL)
> +       if (pcpus->cpus =3D=3D NULL) {
> +               PyErr_SetFromErrno(PyExc_OSError);
>                 return -1;
> +       }
>         return 0;
>  }
>
> @@ -704,12 +708,16 @@ static int pyrf_thread_map__init(struct pyrf_thread=
_map *pthreads,
>         int pid =3D -1, tid =3D -1, uid =3D UINT_MAX;
>
>         if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|iii",
> -                                        kwlist, &pid, &tid, &uid))
> +                                        kwlist, &pid, &tid, &uid)) {
> +               PyErr_BadArgument();
>                 return -1;
> +       }
>
>         pthreads->threads =3D thread_map__new(pid, tid, uid);
> -       if (pthreads->threads =3D=3D NULL)
> +       if (pthreads->threads =3D=3D NULL) {
> +               PyErr_SetFromErrno(PyExc_OSError);
>                 return -1;
> +       }
>         return 0;
>  }
>
> @@ -839,13 +847,18 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevs=
el,
>                                          &enable_on_exec, &task, &waterma=
rk,
>                                          &precise_ip, &mmap_data, &sample=
_id_all,
>                                          &attr.wakeup_events, &attr.bp_ty=
pe,
> -                                        &attr.bp_addr, &attr.bp_len, &id=
x))
> +                                        &attr.bp_addr, &attr.bp_len, &id=
x)) {
> +               PyErr_BadArgument();
>                 return -1;
> +       }
>
>         /* union... */
>         if (sample_period !=3D 0) {
> -               if (attr.sample_freq !=3D 0)
> -                       return -1; /* FIXME: throw right exception */
> +               if (attr.sample_freq !=3D 0) {
> +                       PyErr_SetString(PyExc_ValueError,
> +                                       "perf: sample_freq and sample_per=
iod are mutually exclusive");
> +                       return -1;
> +               }
>                 attr.sample_period =3D sample_period;
>         }
>
> @@ -892,8 +905,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel =
*pevsel,
>         static char *kwlist[] =3D { "cpus", "threads", "group", "inherit"=
, NULL };
>
>         if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist,
> -                                        &pcpus, &pthreads, &group, &inhe=
rit))
> +                                        &pcpus, &pthreads, &group, &inhe=
rit)) {
> +               PyErr_BadArgument();
>                 return NULL;
> +       }
>
>         if (pthreads !=3D NULL)
>                 threads =3D ((struct pyrf_thread_map *)pthreads)->threads=
;
> @@ -957,8 +972,10 @@ static int pyrf_evlist__init(struct pyrf_evlist *pev=
list,
>         struct perf_cpu_map *cpus;
>         struct perf_thread_map *threads;
>
> -       if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
> +       if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads)) {
> +               PyErr_BadArgument();
>                 return -1;
> +       }
>
>         threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
>         cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;
> @@ -980,8 +997,10 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_evlis=
t *pevlist,
>         int pages =3D 128, overwrite =3D false;
>
>         if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ii", kwlist,
> -                                        &pages, &overwrite))
> +                                        &pages, &overwrite)) {
> +               PyErr_BadArgument();
>                 return NULL;
> +       }
>
>         if (evlist__mmap(evlist, pages) < 0) {
>                 PyErr_SetFromErrno(PyExc_OSError);
> @@ -999,8 +1018,10 @@ static PyObject *pyrf_evlist__poll(struct pyrf_evli=
st *pevlist,
>         static char *kwlist[] =3D { "timeout", NULL };
>         int timeout =3D -1, n;
>
> -       if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|i", kwlist, &tim=
eout))
> +       if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|i", kwlist, &tim=
eout)) {
> +               PyErr_BadArgument();
>                 return NULL;
> +       }
>
>         n =3D evlist__poll(evlist, timeout);
>         if (n < 0) {
> @@ -1057,8 +1078,10 @@ static PyObject *pyrf_evlist__add(struct pyrf_evli=
st *pevlist,
>         PyObject *pevsel;
>         struct evsel *evsel;
>
> -       if (!PyArg_ParseTuple(args, "O", &pevsel))
> +       if (!PyArg_ParseTuple(args, "O", &pevsel)) {
> +               PyErr_BadArgument();
>                 return NULL;
> +       }
>
>         Py_INCREF(pevsel);
>         evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> @@ -1093,12 +1116,16 @@ static PyObject *pyrf_evlist__read_on_cpu(struct =
pyrf_evlist *pevlist,
>         int err;
>
>         if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist,
> -                                        &cpu, &sample_id_all))
> +                                        &cpu, &sample_id_all)) {
> +               PyErr_BadArgument();
>                 return NULL;
> +       }
>
>         md =3D get_md(evlist, cpu);
> -       if (!md)
> +       if (!md) {
> +               PyErr_SetFromErrno(PyExc_OSError);
>                 return NULL;
> +       }
>
>         if (perf_mmap__read_init(&md->core) < 0)
>                 goto end;
> @@ -1324,6 +1351,8 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel=
 *pevsel,
>                                   PyObject *args, PyObject *kwargs)
>  {
>  #ifndef HAVE_LIBTRACEEVENT
> +       PyErr_SetString(PyExc_OSError,
> +                       "perf: tracepoint support not compiled in");
>         return NULL;
>  #else
>         struct tep_event *tp_format;
> @@ -1332,8 +1361,10 @@ static PyObject *pyrf__tracepoint(struct pyrf_evse=
l *pevsel,
>         char *name =3D NULL;
>
>         if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ss", kwlist,
> -                                        &sys, &name))
> +                                        &sys, &name)) {
> +               PyErr_BadArgument();
>                 return NULL;
> +       }
>
>         tp_format =3D trace_event__tp_format(sys, name);
>         if (IS_ERR(tp_format))
> --
> 2.39.2
>
