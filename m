Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D849364384C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiLEWo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLEWoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:44:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94835EE1C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:44:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h11so20987899wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OCax83xDsYSpyiNzI9sqYOdkCRRhZ6cCXQ1yHGNJjg=;
        b=WAnXLY/b3nV5yl5dYmp8ymC7g0Kx6oh6t3SRZC7gUj+tPrCWXQI+bihwrEO/Qo6tEK
         QKwzYCxY6Rtf+Ui5lyfu9C/OgLMuumwpqkydYEcgRygkHT7PJTtNb79ke3P0cQn2iVTh
         02s3H21WbMOCe+uUYiKwPrGBKTvRxlm7sfyHSCEA5JjxFekyn70Rf9s/y0+/fAcTBXks
         ImGbCsMQC+8i2onLiQlyKGTGZYNO9HTkt2HX8DXM1L0eo5zcO2bmKtnvJZDUGHu3l3j0
         6SxesCX5Df88c1Cv2SyK86han8fArbcZ2A4UhGukDuZP7Pl8GIfHrEtBLUFcyxjpH0h9
         1DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OCax83xDsYSpyiNzI9sqYOdkCRRhZ6cCXQ1yHGNJjg=;
        b=bT8UR49sWXxHWMcFuJHDjlDjLoZlmQ+kzoY20qhSddC/Rg43DSelBYRCrsMCZzJs2p
         iKjinKczANETOVozNZ89if8eKnSza8HisWGZFmCZOF12pClql0ee0w5kbjyn0NkRjqlF
         sjDfy7kdwYGUUipj8jiU251jNdyDlqTv2tn32aGEv/ASOd2qlnoatw7YMHcQP2C60B4N
         aryoqRHPuI4+NP0zR0Y9Dbe2jUgrn8NraeMPkHN5HDUvcp0Fh9fNzZB0RWgkd+EVf8Nw
         o4OOZtoCdQCVy3vjsbzKBpg+WLGMMiYknn6KMehKFNV2wySENCCXYvJVPhl6OmDz441O
         fFFQ==
X-Gm-Message-State: ANoB5pkDyLSNrU3MuVJw7tlnw0qtKzD1MCOGEd++aAq5aoER1CJXCLon
        tAjYVSEgeSmxT3Ere0PLBUTKwMk6+6ul3zH6gmn8wA==
X-Google-Smtp-Source: AA0mqf7gU/+7r0Fj2+0b35BhYbym5BUbTbio+hF2/U2DuUO1zT0jymIqa7BoPnMM54h2EvfsUmearGJhn7uuiIQpc2Q=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr41412374wrj.40.1670280261674; Mon, 05
 Dec 2022 14:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20221129192924.1580537-1-irogers@google.com> <Y43qt8YRP1M8lTvP@kernel.org>
In-Reply-To: <Y43qt8YRP1M8lTvP@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Dec 2022 14:44:09 -0800
Message-ID: <CAP-5=fXgAhqpGUCxWM1V48TtyGTBPT-=uihoyaEDdGLZD_S4=w@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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

On Mon, Dec 5, 2022 at 4:57 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Tue, Nov 29, 2022 at 11:29:24AM -0800, Ian Rogers escreveu:
> > If LIBTRACEEVENT_DYNAMIC is enabled then avoid the install step for
> > the plugins. If disabled correct DESTDIR so that the plugins are
> > installed under <lib>/traceevent/plugins.
> >
> > Fixes: ef019df01e20 ("perf build: Install libtraceevent locally when bu=
ilding")
> > Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.perf | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a17a6ea85e81..f4cd946fe91a 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugin=
s
> >
> >  install-traceevent-plugins: libtraceevent_plugins
> >       $(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=3D$(LIBTRACEEVENT_P=
LUGINS_OUTPUT) \
> > -             DESTDIR=3D$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix=3D \
> > +             DESTDIR=3D$(DESTDIR_SQ) prefix=3D \
> >               $(LIBTRACEEVENT_FLAGS) install
> >  endif
> >
> > @@ -1093,7 +1093,11 @@ install-tests: all install-gtk
> >               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(per=
fexec_instdir_SQ)/tests/shell/coresight'
> >       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> >
> > -install-bin: install-tools install-tests install-traceevent-plugins
> > +install-bin: install-tools install-tests
> > +
> > +ifndef LIBTRACEEVENT_DYNAMIC
> > +install-bin: install-traceevent-plugins
> > +endif
> >
> >  install: install-bin try-install-man
>
> After applying this:
>
> =E2=AC=A2[acme@toolbox perf]$ alias m
> alias m=3D'perf stat -e cycles:u,instructions:u make -k BUILD_BPF_SKEL=3D=
1 CORESIGHT=3D1 O=3D/tmp/build/perf -C tools/perf install-bin && git status=
 && perf test python'
> =E2=AC=A2[acme@toolbox perf]$
>
> =E2=AC=A2[acme@toolbox perf]$ m
> make: Entering directory '/var/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' di=
ffers from latest version at 'arch/x86/include/asm/msr-index.h'
> diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-i=
ndex.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_reg=
s.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.=
h'
> diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/=
uapi/asm/perf_regs.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' di=
ffers from latest version at 'arch/arm64/include/asm/cputype.h'
> diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cpu=
type.h
> Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/sys=
call.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/sysc=
all.tbl'
> diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/k=
ernel/syscalls/syscall.tbl
>
>   INSTALL libsubcmd_headers
>   INSTALL traceevent_headers
>   INSTALL libapi_headers
>   INSTALL libperf_headers
>   INSTALL libsymbol_headers
>   INSTALL libbpf_headers
>   CC      /tmp/build/perf/builtin-annotate.o
>   CC      /tmp/build/perf/builtin-diff.o
>   CC      /tmp/build/perf/builtin-evlist.o
>   CC      /tmp/build/perf/builtin-sched.o
>   CC      /tmp/build/perf/builtin-buildid-list.o
>   CC      /tmp/build/perf/builtin-buildid-cache.o
>   CC      /tmp/build/perf/builtin-record.o
>   INSTALL trace_plugins
>   GEN     /tmp/build/perf/python/perf.so
>   CC      /tmp/build/perf/builtin-report.o
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-stat.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-timechart.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-top.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-script.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-kmem.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
>   CC      /tmp/build/perf/builtin-lock.o
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-kvm.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-inject.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
>   CC      /tmp/build/perf/builtin-mem.o
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
>   CC      /tmp/build/perf/builtin-c2c.o
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
>   CC      /tmp/build/perf/builtin-kwork.o
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
>   CC      /tmp/build/perf/builtin-trace.o
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> install: cannot create directory =E2=80=98/lib64/traceevent=E2=80=99: Per=
mission denied
> install: cannot create regular file '/lib64/traceevent/plugins': No such =
file or directory
> make[3]: *** [Makefile:211: install] Error 1
> make[2]: *** [Makefile.perf:886: install-traceevent-plugins] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
>   CC      /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
>   CC      /tmp/build/perf/bench/synthesize.o
>   CC      /tmp/build/perf/bench/inject-buildid.o
>   CC      /tmp/build/perf/ui/browsers/header.o
>   CC      /tmp/build/perf/tests/evsel-tp-sched.o
>   CC      /tmp/build/perf/arch/x86/util/intel-pt.o
>   CC      /tmp/build/perf/arch/x86/util/intel-bts.o
>   LD      /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
>   LD      /tmp/build/perf/bench/perf-in.o
>   LD      /tmp/build/perf/ui/browsers/perf-in.o
>   CC      /tmp/build/perf/tests/code-reading.o
>   CC      /tmp/build/perf/tests/sample-parsing.o
>   LD      /tmp/build/perf/arch/x86/util/perf-in.o
>   CC      /tmp/build/perf/tests/topology.o
>   LD      /tmp/build/perf/ui/perf-in.o
>   CC      /tmp/build/perf/util/build-id.o
>   CC      /tmp/build/perf/tests/time-utils-test.o
>   CC      /tmp/build/perf/util/event.o
>   CC      /tmp/build/perf/tests/demangle-java-test.o
>   CC      /tmp/build/perf/tests/demangle-ocaml-test.o
>   LD      /tmp/build/perf/arch/x86/perf-in.o
>   CC      /tmp/build/perf/util/evsel.o
>   CC      /tmp/build/perf/util/evsel_fprintf.o
>   LD      /tmp/build/perf/arch/perf-in.o
>   LD      /tmp/build/perf/tests/perf-in.o
>   CC      /tmp/build/perf/util/header.o
>   CC      /tmp/build/perf/util/session.o
>   CC      /tmp/build/perf/util/s390-sample-raw.o
>   CC      /tmp/build/perf/util/amd-sample-raw.o
>   CC      /tmp/build/perf/util/ordered-events.o
>   CC      /tmp/build/perf/util/thread.o
>   CC      /tmp/build/perf/util/trace-event-parse.o
>   CC      /tmp/build/perf/util/trace-event-read.o
>   CC      /tmp/build/perf/util/trace-event-info.o
>   CC      /tmp/build/perf/util/trace-event-scripting.o
>   CC      /tmp/build/perf/util/trace-event.o
>   CC      /tmp/build/perf/util/sort.o
>   CC      /tmp/build/perf/util/hist.o
>   CC      /tmp/build/perf/util/stat.o
>   CC      /tmp/build/perf/util/synthetic-events.o
>   CC      /tmp/build/perf/util/auxtrace.o
>   CC      /tmp/build/perf/util/intel-pt.o
>   CC      /tmp/build/perf/util/intel-bts.o
>   CC      /tmp/build/perf/util/arm-spe.o
>   CC      /tmp/build/perf/util/hisi-ptt.o
>   CC      /tmp/build/perf/util/s390-cpumsf.o
>   CC      /tmp/build/perf/util/scripting-engines/trace-event-perl.o
>   CC      /tmp/build/perf/util/cs-etm.o
>   CC      /tmp/build/perf/util/scripting-engines/trace-event-python.o
>   CC      /tmp/build/perf/util/dlfilter.o
>   CC      /tmp/build/perf/util/time-utils.o
>   CC      /tmp/build/perf/util/bpf_off_cpu.o
>   CC      /tmp/build/perf/util/probe-file.o
>   CC      /tmp/build/perf/util/probe-event.o
>   LD      /tmp/build/perf/util/scripting-engines/perf-in.o
>   CC      /tmp/build/perf/util/unwind-libunwind-local.o
>   CC      /tmp/build/perf/util/unwind-libunwind.o
>   CC      /tmp/build/perf/util/data-convert-bt.o
>   CC      /tmp/build/perf/util/data-convert-json.o
>   LD      /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
>   CC      /tmp/build/perf/util/jitdump.o
>   LD      /tmp/build/perf/scripts/perf-in.o
>   CC      /tmp/build/perf/util/bpf-event.o
>   LD      /tmp/build/perf/util/perf-in.o
>   LD      /tmp/build/perf/perf-in.o
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 =
O=3D/tmp/build/perf -C tools/perf install-bin':
>
>      9,363,188,016      cycles:u
>     17,153,393,661      instructions:u                   #    1.83  insn =
per cycle
>
>        2.837743632 seconds time elapsed
>
>        2.316326000 seconds user
>        2.136834000 seconds sys
>
>
> =E2=AC=A2[acme@toolbox perf]$

Thanks the following fixes it:

```
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins

install-traceevent-plugins: libtraceevent_plugins
       $(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR)
O=3D$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-               DESTDIR=3D$(DESTDIR_SQ) prefix=3D \
+               DESTDIR=3D$(DESTDIR_SQ)$(prefix) prefix=3D \
               $(LIBTRACEEVENT_FLAGS) install
endif
```

I'll rebase on tmp.perf/core and send the outstanding patches.

Thanks,
Ian
