Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7F6CC97F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjC1Rm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1Rmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:42:53 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E44EB7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:42:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3e0965f70ecso148431cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680025369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MryBYpKkjt5pvCBSDiE08vKTWgofNZCGUWPLSfY8ijc=;
        b=LmG0ej1RJ/d3yywCK9YDhJBh6r2jI6TTzmPQgP6K1/Ox9s6JJ7C/EWSmGKHOnCFFSo
         uNAr3FeURxfJOar4X07dKTCW4GftpJ82ECDXH5QPKK2yMChpya5olD9Y4wVSoE8LCZGW
         jJQRhze0DWCUCqXqDexssRRIroCDS2ZZvAjUlE9sXenzdWu/M+loS1NlxwtWHhQEn3YD
         1WeFZzi+9xeCeUBrDnbQvUaDF8OPU6KqNOG8hi2SExt1DHj+9TRTOzeqnOVraq0SJa7P
         4a/ihCphs+6MUeQiAVkVBvAl/+6oX48rJABXOszboh88JfnU6fPilLsM9kWjX3sZstEw
         G2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MryBYpKkjt5pvCBSDiE08vKTWgofNZCGUWPLSfY8ijc=;
        b=PKaSgLrikyqlxs6duN3DQnNsgh0FSF/6lfL2uObO4LU6zdY337EHEl5nftXS8EKsOo
         kNvXuqGwJnEh8MZTJmgyGV94xEL1LvK3Qz3IT2Er+9j528BYL1ztI1ZuAgbYBwPWo8YG
         2+BFMwVFGYra100Kd5ZxsDt6MRJpHKWp3Xlbhz4naeFHKUV+vUhVTtlR399vlQI8zd5e
         e+Sj/GULidybtNaaK/Ks2Zu9hGN4jnwR8TD2COG1lGK6twaY+BS/7o1qoPcLu9pkCAgy
         fuQPCf6pRVdEDK/Dm8TvOkWCyL/kiuxg2+s0kNi3Jj8cHh1UjBSeGTtYv/3QyyVbqiZR
         2N6Q==
X-Gm-Message-State: AAQBX9cguE1dnxgFCEfQMjiwZooObVieMj6I3Rx9RYDx8L6ut/jPCxTE
        YJtMz+ZQpm4Qov1tfNMbf8ZaaP/D6uT3DT7UCPKD4Q==
X-Google-Smtp-Source: AKy350YzfbEfwoJgsa4AnN7Bwc3/JP/ETg/piTxPh9DmZyB7oHoV6WIu8zMGAn4LGZMvS0qIhQEKRIH60WTCVznMDqY=
X-Received: by 2002:a05:622a:14d2:b0:3ab:6af8:4182 with SMTP id
 u18-20020a05622a14d200b003ab6af84182mr417368qtx.3.1680025368903; Tue, 28 Mar
 2023 10:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com> <fe36e38f-d42f-efe5-bb3c-cf802f8001a9@intel.com>
 <CAP-5=fV749yr+wMMYjm87ThnM7ESd+i4Ko=+6H+cuCNdKJM50A@mail.gmail.com> <cf2bd4c9-c895-2533-cce2-28e9d6b89f1f@intel.com>
In-Reply-To: <cf2bd4c9-c895-2533-cce2-28e9d6b89f1f@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Mar 2023 10:42:37 -0700
Message-ID: <CAP-5=fVrhu38oHEPjG52Eo=i8HRdfxDGhDxQhS_+xu-49wRAAg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Simplify linking against tools/perf code
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:12=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 28/03/23 19:14, Ian Rogers wrote:
> > On Tue, Mar 28, 2023 at 6:24=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 28/03/23 04:40, Ian Rogers wrote:
> >>> When fuzzing something like parse-events, having the main function in
> >>> perf.c alongside global variables like input_name means that
> >>> input_name must be redeclared with the fuzzer function's
> >>> main. However, as the fuzzer is using the tools/perf code as a librar=
y
> >>> this causes backward linking reference that the linker may warn
> >>> about. Reorganize perf.c and perf.h to avoid potential backward
> >>> references, or so that the declaration/definition locations are more
> >>> consistent.
> >>>
> >>
> >> Seems like it could be a pain to maintain.
> >>
> >> Did you consider just adding:
> >>
> >> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> >> index 82bbe0ca858b..a75dd47d68ee 100644
> >> --- a/tools/perf/perf.c
> >> +++ b/tools/perf/perf.c
> >> @@ -456,6 +456,7 @@ static int libperf_print(enum libperf_print_level =
level,
> >>         return veprintf(level, verbose, fmt, ap);
> >>  }
> >>
> >> +#ifndef CUSTOM_MAIN
> >>  int main(int argc, const char **argv)
> >>  {
> >>         int err;
> >> @@ -576,3 +577,4 @@ int main(int argc, const char **argv)
> >>  out:
> >>         return 1;
> >>  }
> >> +#endif
> >>
> >
> > It's possible. Would need to make the static functions not warn about
> > being declared and not used. I still think that just aligning
> > definitions and declarations yields the most expected code and will
> > lead to fewer problems in the long run.
>
> Making perf source dependent on an unknown derivative makes
> things more complicated.
>
> If you are not going to contribute it to perf, then a
> suggestion is along the lines of the following:

There's not an issue with contribution, most of the fuzzers are very
simple. For example, here is the coresight fuzzer we run:

```
#include <fuzzer/FuzzedDataProvider.h>

extern "C" {
#include "tools/perf/util/cs-etm-decoder/cs-etm-decoder.h"
}

static void null_packet_dump(const char *) {}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
 FuzzedDataProvider fdp(data, size);
 int num_cpu =3D fdp.ConsumeIntegralInRange(1, 1024);
 struct cs_etm_decoder_params d_params;
 std::unique_ptr<struct cs_etm_trace_params[]>
     t_params(new cs_etm_trace_params[num_cpu]);

 for(int i=3D0; i < num_cpu; ++i) {
   t_params[i].protocol =3D
fdp.ConsumeIntegralInRange(static_cast<int>(CS_ETM_PROTO_ETMV3)
,

static_cast<int>(CS_ETM_PROTO_PTM));
   fdp.ConsumeData(&t_params[i].etmv4, sizeof(struct cs_etmv4_trace_params)=
);
 }

 d_params.packet_printer =3D null_packet_dump;
 d_params.operation =3D CS_ETM_OPERATION_DECODE;
 d_params.data =3D NULL;
 d_params.formatted =3D true;
 d_params.fsyncs =3D false;
 d_params.hsyncs =3D false;
 d_params.frame_aligned =3D true;

 std::unique_ptr<struct cs_etm_decoder, decltype(&cs_etm_decoder__free)>
     decoder(cs_etm_decoder__new(num_cpu, &d_params, t_params.get()),
             cs_etm_decoder__free);

 if (decoder =3D=3D nullptr)
   return 0;

 do {
   size_t consumed;
  uint8_t buf[1024];
   size_t len =3D fdp.ConsumeData(buf, sizeof(buf));

   int ret =3D cs_etm_decoder__process_data_block(
       decoder.get(), 0, buf, len, &consumed);
   if (ret)
     return 0;

 } while (fdp.remaining_bytes() > 0);

 return 0;
}
```
Most of the code is boiler plate around a single function call. The
issues are build support, where to put the fuzzer generated test
corpus, the code is C++, etc.

> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 82bbe0ca858b..6a7fe1534664 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -456,7 +456,18 @@ static int libperf_print(enum libperf_print_level le=
vel,
>         return veprintf(level, verbose, fmt, ap);
>  }
>
> $ git diff
> +#ifdef CUSTOM_MAIN
> +int main(void)
> +{
> +       printf("This is not perf\n");
> +       return 0;
> +}
> +
> +int perf_main(int argc, const char **argv);
> +int perf_main(int argc, const char **argv)
> +#else
>  int main(int argc, const char **argv)
> +#endif
>  {
>         int err;
>         const char *cmd;
> $ make EXTRA_CFLAGS=3D"-DCUSTOM_MAIN" NO_BPF_SKEL=3D1 -C tools/perf >/dev=
/null
> Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs fro=
m latest version at 'include/uapi/linux/in.h'
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' =
differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_reg=
s.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.=
h'
> Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' diffe=
rs from latest version at 'include/linux/coresight-pmu.h'
> Makefile.config:587: No sys/sdt.h found, no SDT events are defined, pleas=
e install systemtap-sdt-devel or systemtap-sdt-dev
> Makefile.config:805: Missing perl devel files. Disabling perl scripting s=
upport, please install perl-ExtUtils-Embed/libperl-dev
> Makefile.config:1046: No libbabeltrace found, disables 'perf data' CTF fo=
rmat support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1075: No alternatives command found, you need to set JDIR=
=3D to point to the root of your Java directory
> Makefile.config:1137: libpfm4 not found, disables libpfm4 support. Please=
 install libpfm4-dev
> $ tools/perf/perf version
> This is not perf
>

Sure, I'm aware of how the #ifdef would function. What I'm saying is
that even with a CUSTOM_MAIN ifdef, which wouldn't be necessary with
my patches as you can drop the object file, the refactoring in the
patches still makes sense.

  perf ui: Move window resize signal functions

It isn't clear why these UI functions should be in perf.c given window
resizing is a UI issue.

  perf usage: Move usage strings

The usage strings were in builtin.h and not perf.h, so the
declaration/definition didn't align. util.h declares usage(), although
the definition is in usage.c, the variables are moved to match this.

  perf header: Move perf_version_string declaration

perf_version_string is defined in header.c and so declaring it in
header.h rather than perf.h is consistent.

  perf version: Use regular verbose flag

Just remove an unnecessary global by repurposing the existing global
for the job.

  perf util: Move input_name to util

There's no reference to input_name in perf.c and so util.c is as
sensible a location. Having this be a global is something of an
encapsulation fail, but cleaning that up wasn't the point of these
patches. The variable is used in util, so reaching up a directory to
get it feels somewhat unnatural.

  perf util: Move perf_guest/host declarations

As with input_name.

Thanks,
Ian
