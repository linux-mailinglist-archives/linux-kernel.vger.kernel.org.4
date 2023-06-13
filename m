Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8672E55A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbjFMOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjFMOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:11:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC641BF6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:11:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9b7de94e7so261721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686665485; x=1689257485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2LF9vBWVJQkS6czPL0Pv2fjbjvivuqLhhTJoeKI85o=;
        b=eOc0Q8d7lPdI3kibv7sV4Mj0eWfWVBCIEaay6nhFgqS6LS2aNQV8OJ1oXY5gduFwWX
         VBpqp0FF3NVEcf5WDjGYW/MlAwyYABiLHWFdP2d1CLa3KsPpd19F+UlBvUMA6/4CtF8R
         hhsyBmNga0I9t1kTnL2fQluqzyW8Uwc8V5ctFO7XUSZSvSrHjBahu8T6ropkv4OJfqoM
         3/XhrIQeACbmSSHafPZn5Y4PKQbt1eF30FxywobbsB/gj/QmhgZF7V3//4dd0Q58Raqq
         YZ4hdsVqS5LX1x5DZ3vCItoj5agl1v+0VOn4vq8Bg/FfnRwZFsTFcGX89DE/cOra2tIA
         AnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665485; x=1689257485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2LF9vBWVJQkS6czPL0Pv2fjbjvivuqLhhTJoeKI85o=;
        b=FKMw7Q0zcQAxo3TwB7bzdAv4v3GZwAAydK+BU7u87lQHGbVhKM42pbNVe5jkDaFIcO
         7qj/MX0wdav9J//GLqC6NMmhMKflI1xAuVfi7Xfi3Teuc0BzYIJKQ/IE9iTw4nqZzuRq
         CUItBFNTpuimy0j17ZyTvYnCWxuOKIJ2xOzoOOdmpgv6mbp1UpyOFFVu8t2nEdWzNhPG
         J6wRb2xcQsjhbTB5121hr0Vep26VQIf86bDfwye2FdFsR7Z2bFvaTrSiZG7oWy46mmBU
         1J0sZ/u3ewtKAbMylROhykwoQQHsxUh6lTlQPqbZ2BiohRh/GL/BSS6rx1IsW6XzFIYQ
         oDkw==
X-Gm-Message-State: AC+VfDwnvrw0mWjYGf3NrMknHieuBqvAGEbOvRJ01TG/VJF98t/iZQjL
        +BP9PSx3uQ9q5iM+RrikmV49pCA5T0s23UtUHDkdAg==
X-Google-Smtp-Source: ACHHUZ793wdky6OiuPesPx0XJMBo0KhUj7K5W2/npON3A0AE4RGdyfYTut2scZUdQHzKdgJ3Cx8ljfuVTl16uXLqH84=
X-Received: by 2002:a05:622a:e:b0:3f3:75c2:7466 with SMTP id
 x14-20020a05622a000e00b003f375c27466mr151492qtw.8.1686665484255; Tue, 13 Jun
 2023 07:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230531154333.364167-1-irogers@google.com> <ZIdtO9xVsP6Ytb0q@kernel.org>
 <d844e513-2731-fab3-70bc-408c16e5dd55@intel.com> <CAP-5=fVM47-tTV7TCN40gtSF2XQMAh1PaMiRhBv88sL_eM0=sA@mail.gmail.com>
 <91a9fb58-7906-e9bc-c964-6c26a8ff0905@intel.com>
In-Reply-To: <91a9fb58-7906-e9bc-c964-6c26a8ff0905@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 07:11:12 -0700
Message-ID: <CAP-5=fVDrRUxFq_chShyrt=sPc2T+S7i_bukV1tKUd-A1UPe8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tests x86: Generate entire instruction struct
 in C files
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 3:38=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 13/06/23 09:03, Ian Rogers wrote:
> > On Mon, Jun 12, 2023 at 10:01=E2=80=AFPM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>
> >> On 12/06/23 22:08, Arnaldo Carvalho de Melo wrote:
> >>> Em Wed, May 31, 2023 at 08:43:32AM -0700, Ian Rogers escreveu:
> >>>> Generate the entire struct in the C files. Later changes will break
> >>>> apart the struct and so two phases of output are necessary, this isn=
't
> >>>> possible if part of the struct is declared in insn-x86.c.
> >>>
> >>> Adrian,
> >>>
> >>>       Could you please take a look at these two patches?
> >>
> >> I will try to get to them today, but if you are worried about tests,
> >> why not split them into another executable.  e.g. perf test runs
> >> perf-test, where 'perf' is built without test support and 'perf-test'
> >> is built with it.
> >
> > So two binaries would be more disk space and a bunch of re-engineering
>
> Do you have an example where disk space was a problem?  Embedded
> systems should probably package a minimal perf anyway.

So there are two issues:
1) disk space - the bug that came to me was in regard to the perf
binary size in cloud images
2) memory usage in contexts like perf record - we time how long perf
takes to run and kill it if it takes 3x longer than it should. There
is a correlation between long execution times and limited memory
within the container the command is running.

Thanks,
Ian

> > in things like tests, would perf-test be copied to perf for shell
> > tests? Would we then need the json events in it? The json
> > events/metrics are by far the biggest contributor to the binary size,
> > but I have plans for them. In this case I was just going after a low
> > hanging disk and runtime memory savings.
>
> We should probably have more config options though:
>         NO_TESTS
>         NO_METRICS
>
> Might be worth thinking about promoting more than 1 perf package, say:
>         perf-full vs perf-minimal
>
> >
> > Thanks,
> > Ian
> >
> >>>
> >>> Thanks in advance,
> >>>
> >>> - Arnaldo
> >>>
> >>>> The instructions rdpkru and wrpkru are already part of the source da=
ta
> >>>> and so the duplicate values are removed from the structs in
> >>>> insn-x86.c. erets and eretu won't assemble, so special case them for
> >>>> x86-64.
> >>>>
> >>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>> ---
> >>>>  .../perf/arch/x86/tests/gen-insn-x86-dat.awk  |   6 +-
> >>>>  tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |   4 +-
> >>>>  tools/perf/arch/x86/tests/insn-x86-dat-32.c   |  65 +++----
> >>>>  tools/perf/arch/x86/tests/insn-x86-dat-64.c   | 163 +++++++++------=
---
> >>>>  tools/perf/arch/x86/tests/insn-x86.c          |  23 ++-
> >>>>  5 files changed, 138 insertions(+), 123 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk b/tools/=
perf/arch/x86/tests/gen-insn-x86-dat.awk
> >>>> index 1a29f6379bde..5a7de9ff77e7 100644
> >>>> --- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
> >>>> +++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
> >>>> @@ -5,6 +5,7 @@
> >>>>  #
> >>>>
> >>>>  BEGIN {
> >>>> +    print "// SPDX-License-Identifier: GPL-2.0"
> >>>>      print "/*"
> >>>>      print " * Generated by gen-insn-x86-dat.sh and gen-insn-x86-dat=
.awk"
> >>>>      print " * from insn-x86-dat-src.c for inclusion by insn-x86.c"
> >>>> @@ -18,13 +19,16 @@ BEGIN {
> >>>>
> >>>>  / Start here / {
> >>>>      going =3D 1
> >>>> +    printf "static const struct test_data %s[] =3D {\n", struct_nam=
e
> >>>>  }
> >>>>
> >>>>  / Stop here / {
> >>>>      going =3D 0
> >>>> +    print "{{0}, 0, 0, NULL, NULL, NULL},"
> >>>> +    print "};"
> >>>>  }
> >>>>
> >>>> -/^\s*[0-9a-fA-F]+\:/ {
> >>>> +/^[[:blank:]]*[0-9a-fA-F]+:/ {
> >>>>      if (going) {
> >>>>              colon_pos =3D index($0, ":")
> >>>>              useful_line =3D substr($0, colon_pos + 1)
> >>>> diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh b/tools/p=
erf/arch/x86/tests/gen-insn-x86-dat.sh
> >>>> index 0d0a003a9c5e..c087b9695cba 100755
> >>>> --- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
> >>>> +++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
> >>>> @@ -19,7 +19,7 @@ echo "Compiling insn-x86-dat-src.c to 64-bit objec=
t"
> >>>>
> >>>>  gcc -g -c insn-x86-dat-src.c
> >>>>
> >>>> -objdump -dSw insn-x86-dat-src.o | awk -f gen-insn-x86-dat.awk > ins=
n-x86-dat-64.c
> >>>> +objdump -dSw insn-x86-dat-src.o | awk -v struct_name=3Dtest_data_64=
 -f gen-insn-x86-dat.awk > insn-x86-dat-64.c
> >>>>
> >>>>  rm -f insn-x86-dat-src.o
> >>>>
> >>>> @@ -27,7 +27,7 @@ echo "Compiling insn-x86-dat-src.c to 32-bit objec=
t"
> >>>>
> >>>>  gcc -g -c -m32 insn-x86-dat-src.c
> >>>>
> >>>> -objdump -dSw insn-x86-dat-src.o | awk -f gen-insn-x86-dat.awk > ins=
n-x86-dat-32.c
> >>>> +objdump -dSw insn-x86-dat-src.o | awk -v struct_name=3Dtest_data_32=
 -f gen-insn-x86-dat.awk > insn-x86-dat-32.c
> >>>>
> >>>>  rm -f insn-x86-dat-src.o
> >>>>
> >>>> diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/per=
f/arch/x86/tests/insn-x86-dat-32.c
> >>>> index ba429cadb18f..a4ad5a5d1cb6 100644
> >>>> --- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
> >>>> +++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
> >>>> @@ -5,8 +5,9 @@
> >>>>   * Do not change this code.
> >>>>  */
> >>>>
> >>>> +static const struct test_data test_data_32[] =3D {
> >>>>  {{0x0f, 0x31, }, 2, 0, "", "",
> >>>> -"0f 31                \trdtsc  ",},
> >>>> +"0f 31                \trdtsc",},
> >>>>  {{0xc4, 0xe2, 0x7d, 0x13, 0xeb, }, 5, 0, "", "",
> >>>>  "c4 e2 7d 13 eb       \tvcvtph2ps %xmm3,%ymm5",},
> >>>>  {{0x62, 0x81, 0x78, 0x56, 0x34, 0x12, }, 6, 0, "", "",
> >>>> @@ -1686,19 +1687,19 @@
> >>>>  {{0x0f, 0x1b, 0x84, 0x08, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>>  "0f 1b 84 08 78 56 34 12 \tbndstx %bnd0,0x12345678(%eax,%ecx,1)",},
> >>>>  {{0xf2, 0xe8, 0xfc, 0xff, 0xff, 0xff, }, 6, 0xfffffffc, "call", "un=
conditional",
> >>>> -"f2 e8 fc ff ff ff    \tbnd call fce <main+0xfce>",},
> >>>> +"f2 e8 fc ff ff ff    \tbnd call 14f7 <main+0x14f7>",},
> >>>>  {{0xf2, 0xff, 0x10, }, 3, 0, "call", "indirect",
> >>>>  "f2 ff 10             \tbnd call *(%eax)",},
> >>>>  {{0xf2, 0xc3, }, 2, 0, "ret", "indirect",
> >>>> -"f2 c3                \tbnd ret ",},
> >>>> +"f2 c3                \tbnd ret",},
> >>>>  {{0xf2, 0xe9, 0xfc, 0xff, 0xff, 0xff, }, 6, 0xfffffffc, "jmp", "unc=
onditional",
> >>>> -"f2 e9 fc ff ff ff    \tbnd jmp fd9 <main+0xfd9>",},
> >>>> +"f2 e9 fc ff ff ff    \tbnd jmp 1502 <main+0x1502>",},
> >>>>  {{0xf2, 0xe9, 0xfc, 0xff, 0xff, 0xff, }, 6, 0xfffffffc, "jmp", "unc=
onditional",
> >>>> -"f2 e9 fc ff ff ff    \tbnd jmp fdf <main+0xfdf>",},
> >>>> +"f2 e9 fc ff ff ff    \tbnd jmp 1508 <main+0x1508>",},
> >>>>  {{0xf2, 0xff, 0x21, }, 3, 0, "jmp", "indirect",
> >>>>  "f2 ff 21             \tbnd jmp *(%ecx)",},
> >>>>  {{0xf2, 0x0f, 0x85, 0xfc, 0xff, 0xff, 0xff, }, 7, 0xfffffffc, "jcc"=
, "conditional",
> >>>> -"f2 0f 85 fc ff ff ff \tbnd jne fe9 <main+0xfe9>",},
> >>>> +"f2 0f 85 fc ff ff ff \tbnd jne 1512 <main+0x1512>",},
> >>>>  {{0x0f, 0x3a, 0xcc, 0xc1, 0x00, }, 5, 0, "", "",
> >>>>  "0f 3a cc c1 00       \tsha1rnds4 $0x0,%xmm1,%xmm0",},
> >>>>  {{0x0f, 0x3a, 0xcc, 0xd7, 0x91, }, 5, 0, "", "",
> >>>> @@ -2002,7 +2003,7 @@
> >>>>  {{0x0f, 0xae, 0x38, }, 3, 0, "", "",
> >>>>  "0f ae 38             \tclflush (%eax)",},
> >>>>  {{0x0f, 0xae, 0xf8, }, 3, 0, "", "",
> >>>> -"0f ae f8             \tsfence ",},
> >>>> +"0f ae f8             \tsfence",},
> >>>>  {{0x66, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
> >>>>  "66 0f ae 30          \tclwb   (%eax)",},
> >>>>  {{0x66, 0x0f, 0xae, 0x35, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>> @@ -2012,7 +2013,7 @@
> >>>>  {{0x0f, 0xae, 0x30, }, 3, 0, "", "",
> >>>>  "0f ae 30             \txsaveopt (%eax)",},
> >>>>  {{0x0f, 0xae, 0xf0, }, 3, 0, "", "",
> >>>> -"0f ae f0             \tmfence ",},
> >>>> +"0f ae f0             \tmfence",},
> >>>>  {{0x0f, 0x1c, 0x00, }, 3, 0, "", "",
> >>>>  "0f 1c 00             \tcldemote (%eax)",},
> >>>>  {{0x0f, 0x1c, 0x05, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "", "",
> >>>> @@ -2038,17 +2039,17 @@
> >>>>  {{0x0f, 0xc7, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>>  "0f c7 9c c8 78 56 34 12 \txrstors 0x12345678(%eax,%ecx,8)",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x20, }, 4, 0, "", "",
> >>>> -"f3 0f ae 20          \tptwritel (%eax)",},
> >>>> +"f3 0f ae 20          \tptwrite (%eax)",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>> -"f3 0f ae 25 78 56 34 12 \tptwritel 0x12345678",},
> >>>> +"f3 0f ae 25 78 56 34 12 \tptwrite 0x12345678",},
> >>>>  {{0xf3, 0x0f, 0xae, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, ""=
, "",
> >>>> -"f3 0f ae a4 c8 78 56 34 12 \tptwritel 0x12345678(%eax,%ecx,8)",},
> >>>> +"f3 0f ae a4 c8 78 56 34 12 \tptwrite 0x12345678(%eax,%ecx,8)",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x20, }, 4, 0, "", "",
> >>>> -"f3 0f ae 20          \tptwritel (%eax)",},
> >>>> +"f3 0f ae 20          \tptwrite (%eax)",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>> -"f3 0f ae 25 78 56 34 12 \tptwritel 0x12345678",},
> >>>> +"f3 0f ae 25 78 56 34 12 \tptwrite 0x12345678",},
> >>>>  {{0xf3, 0x0f, 0xae, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, ""=
, "",
> >>>> -"f3 0f ae a4 c8 78 56 34 12 \tptwritel 0x12345678(%eax,%ecx,8)",},
> >>>> +"f3 0f ae a4 c8 78 56 34 12 \tptwrite 0x12345678(%eax,%ecx,8)",},
> >>>>  {{0x66, 0x0f, 0xae, 0xf3, }, 4, 0, "", "",
> >>>>  "66 0f ae f3          \ttpause %ebx",},
> >>>>  {{0x67, 0xf3, 0x0f, 0xae, 0xf0, }, 5, 0, "", "",
> >>>> @@ -2094,11 +2095,11 @@
> >>>>  {{0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>>  "0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%eax,%ecx,8)",},
> >>>>  {{0x0f, 0xae, 0xe8, }, 3, 0, "", "",
> >>>> -"0f ae e8             \tlfence ",},
> >>>> +"0f ae e8             \tlfence",},
> >>>>  {{0xf3, 0x0f, 0x1e, 0xc8, }, 4, 0, "", "",
> >>>>  "f3 0f 1e c8          \trdsspd %eax",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xea, }, 4, 0, "", "",
> >>>> -"f3 0f 01 ea          \tsaveprevssp ",},
> >>>> +"f3 0f 01 ea          \tsaveprevssp",},
> >>>>  {{0xf3, 0x0f, 0x01, 0x28, }, 4, 0, "", "",
> >>>>  "f3 0f 01 28          \trstorssp (%eax)",},
> >>>>  {{0xf3, 0x0f, 0x01, 0x2d, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>> @@ -2118,11 +2119,11 @@
> >>>>  {{0x66, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10=
, 0, "", "",
> >>>>  "66 0f 38 f5 94 c8 78 56 34 12 \twrussd %edx,0x12345678(%eax,%ecx,8=
)",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
> >>>> -"f3 0f 01 e8          \tsetssbsy ",},
> >>>> +"f3 0f 01 e8          \tsetssbsy",},
> >>>>  {{0x0f, 0x01, 0xee, }, 3, 0, "", "",
> >>>> -"0f 01 ee             \trdpkru ",},
> >>>> +"0f 01 ee             \trdpkru",},
> >>>>  {{0x0f, 0x01, 0xef, }, 3, 0, "", "",
> >>>> -"0f 01 ef             \twrpkru ",},
> >>>> +"0f 01 ef             \twrpkru",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
> >>>>  "f3 0f ae 30          \tclrssbsy (%eax)",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x35, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>> @@ -2130,9 +2131,9 @@
> >>>>  {{0xf3, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, ""=
, "",
> >>>>  "f3 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%eax,%ecx,8)",},
> >>>>  {{0xf3, 0x0f, 0x1e, 0xfb, }, 4, 0, "", "",
> >>>> -"f3 0f 1e fb          \tendbr32 ",},
> >>>> +"f3 0f 1e fb          \tendbr32",},
> >>>>  {{0xf3, 0x0f, 0x1e, 0xfa, }, 4, 0, "", "",
> >>>> -"f3 0f 1e fa          \tendbr64 ",},
> >>>> +"f3 0f 1e fa          \tendbr64",},
> >>>>  {{0xff, 0xd0, }, 2, 0, "call", "indirect",
> >>>>  "ff d0                \tcall   *%eax",},
> >>>>  {{0xff, 0x10, }, 2, 0, "call", "indirect",
> >>>> @@ -3110,18 +3111,24 @@
> >>>>  {{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
> >>>>  "f3 0f 3a f0 c0 00    \threset $0x0",},
> >>>>  {{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
> >>>> -"0f 01 e8             \tserialize ",},
> >>>> +"0f 01 e8             \tserialize",},
> >>>>  {{0xf2, 0x0f, 0x01, 0xe9, }, 4, 0, "", "",
> >>>> -"f2 0f 01 e9          \txresldtrk ",},
> >>>> +"f2 0f 01 e9          \txresldtrk",},
> >>>>  {{0xf2, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
> >>>> -"f2 0f 01 e8          \txsusldtrk ",},
> >>>> +"f2 0f 01 e8          \txsusldtrk",},
> >>>>  {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
> >>>> -"0f 01 cf             \tencls  ",},
> >>>> +"0f 01 cf             \tencls",},
> >>>>  {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
> >>>> -"0f 01 d7             \tenclu  ",},
> >>>> +"0f 01 d7             \tenclu",},
> >>>>  {{0x0f, 0x01, 0xc0, }, 3, 0, "", "",
> >>>> -"0f 01 c0             \tenclv  ",},
> >>>> +"0f 01 c0             \tenclv",},
> >>>>  {{0x0f, 0x01, 0xc5, }, 3, 0, "", "",
> >>>> -"0f 01 c5             \tpconfig ",},
> >>>> +"0f 01 c5             \tpconfig",},
> >>>>  {{0xf3, 0x0f, 0x09, }, 3, 0, "", "",
> >>>> -"f3 0f 09             \twbnoinvd ",},
> >>>> +"f3 0f 09             \twbnoinvd",},
> >>>> +{{0x0f, 0x01, 0xee, }, 3, 0, "", "",
> >>>> +"0f 01 ee             \trdpkru",},
> >>>> +{{0x0f, 0x01, 0xef, }, 3, 0, "", "",
> >>>> +"0f 01 ef             \twrpkru",},
> >>>> +{{0}, 0, 0, NULL, NULL, NULL},
> >>>> +};
> >>>> diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/per=
f/arch/x86/tests/insn-x86-dat-64.c
> >>>> index 3a47e98fec33..077ad34a30f2 100644
> >>>> --- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
> >>>> +++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
> >>>> @@ -5,8 +5,9 @@
> >>>>   * Do not change this code.
> >>>>  */
> >>>>
> >>>> +static const struct test_data test_data_64[] =3D {
> >>>>  {{0x0f, 0x31, }, 2, 0, "", "",
> >>>> -"0f 31                \trdtsc  ",},
> >>>> +"0f 31                \trdtsc",},
> >>>>  {{0xc4, 0xe2, 0x7d, 0x13, 0xeb, }, 5, 0, "", "",
> >>>>  "c4 e2 7d 13 eb       \tvcvtph2ps %xmm3,%ymm5",},
> >>>>  {{0x48, 0x0f, 0x41, 0xd8, }, 4, 0, "", "",
> >>>> @@ -1742,19 +1743,19 @@
> >>>>  {{0x0f, 0x1b, 0x84, 0x08, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
> >>>>  "0f 1b 84 08 78 56 34 12 \tbndstx %bnd0,0x12345678(%rax,%rcx,1)",},
> >>>>  {{0xf2, 0xe8, 0x00, 0x00, 0x00, 0x00, }, 6, 0, "call", "uncondition=
al",
> >>>> -"f2 e8 00 00 00 00    \tbnd callq f22 <main+0xf22>",},
> >>>> +"f2 e8 00 00 00 00    \tbnd call 16b5 <main+0x16b5>",},
> >>>>  {{0x67, 0xf2, 0xff, 0x10, }, 4, 0, "call", "indirect",
> >>>> -"67 f2 ff 10          \tbnd callq *(%eax)",},
> >>>> +"67 f2 ff 10          \tbnd call *(%eax)",},
> >>>>  {{0xf2, 0xc3, }, 2, 0, "ret", "indirect",
> >>>> -"f2 c3                \tbnd retq ",},
> >>>> +"f2 c3                \tbnd ret",},
> >>>>  {{0xf2, 0xe9, 0x00, 0x00, 0x00, 0x00, }, 6, 0, "jmp", "unconditiona=
l",
> >>>> -"f2 e9 00 00 00 00    \tbnd jmpq f2e <main+0xf2e>",},
> >>>> +"f2 e9 00 00 00 00    \tbnd jmp 16c1 <main+0x16c1>",},
> >>>>  {{0xf2, 0xe9, 0x00, 0x00, 0x00, 0x00, }, 6, 0, "jmp", "unconditiona=
l",
> >>>> -"f2 e9 00 00 00 00    \tbnd jmpq f34 <main+0xf34>",},
> >>>> +"f2 e9 00 00 00 00    \tbnd jmp 16c7 <main+0x16c7>",},
> >>>>  {{0x67, 0xf2, 0xff, 0x21, }, 4, 0, "jmp", "indirect",
> >>>> -"67 f2 ff 21          \tbnd jmpq *(%ecx)",},
> >>>> +"67 f2 ff 21          \tbnd jmp *(%ecx)",},
> >>>>  {{0xf2, 0x0f, 0x85, 0x00, 0x00, 0x00, 0x00, }, 7, 0, "jcc", "condit=
ional",
> >>>> -"f2 0f 85 00 00 00 00 \tbnd jne f3f <main+0xf3f>",},
> >>>> +"f2 0f 85 00 00 00 00 \tbnd jne 16d2 <main+0x16d2>",},
> >>>>  {{0x0f, 0x3a, 0xcc, 0xc1, 0x00, }, 5, 0, "", "",
> >>>>  "0f 3a cc c1 00       \tsha1rnds4 $0x0,%xmm1,%xmm0",},
> >>>>  {{0x0f, 0x3a, 0xcc, 0xd7, 0x91, }, 5, 0, "", "",
> >>>> @@ -2134,7 +2135,7 @@
> >>>>  {{0x41, 0x0f, 0xae, 0x38, }, 4, 0, "", "",
> >>>>  "41 0f ae 38          \tclflush (%r8)",},
> >>>>  {{0x0f, 0xae, 0xf8, }, 3, 0, "", "",
> >>>> -"0f ae f8             \tsfence ",},
> >>>> +"0f ae f8             \tsfence",},
> >>>>  {{0x66, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
> >>>>  "66 0f ae 30          \tclwb   (%rax)",},
> >>>>  {{0x66, 0x41, 0x0f, 0xae, 0x30, }, 5, 0, "", "",
> >>>> @@ -2150,7 +2151,7 @@
> >>>>  {{0x41, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
> >>>>  "41 0f ae 30          \txsaveopt (%r8)",},
> >>>>  {{0x0f, 0xae, 0xf0, }, 3, 0, "", "",
> >>>> -"0f ae f0             \tmfence ",},
> >>>> +"0f ae f0             \tmfence",},
> >>>>  {{0x0f, 0x1c, 0x00, }, 3, 0, "", "",
> >>>>  "0f 1c 00             \tcldemote (%rax)",},
> >>>>  {{0x41, 0x0f, 0x1c, 0x00, }, 4, 0, "", "",
> >>>> @@ -2282,7 +2283,7 @@
> >>>>  {{0x41, 0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, ""=
, "",
> >>>>  "41 0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%r8,%rcx,8)",},
> >>>>  {{0x0f, 0xae, 0xe8, }, 3, 0, "", "",
> >>>> -"0f ae e8             \tlfence ",},
> >>>> +"0f ae e8             \tlfence",},
> >>>>  {{0xf3, 0x0f, 0x1e, 0xc8, }, 4, 0, "", "",
> >>>>  "f3 0f 1e c8          \trdsspd %eax",},
> >>>>  {{0xf3, 0x41, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
> >>>> @@ -2292,7 +2293,7 @@
> >>>>  {{0xf3, 0x49, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
> >>>>  "f3 49 0f 1e c8       \trdsspq %r8",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xea, }, 4, 0, "", "",
> >>>> -"f3 0f 01 ea          \tsaveprevssp ",},
> >>>> +"f3 0f 01 ea          \tsaveprevssp",},
> >>>>  {{0xf3, 0x0f, 0x01, 0x28, }, 4, 0, "", "",
> >>>>  "f3 0f 01 28          \trstorssp (%rax)",},
> >>>>  {{0xf3, 0x41, 0x0f, 0x01, 0x28, }, 5, 0, "", "",
> >>>> @@ -2344,11 +2345,11 @@
> >>>>  {{0x66, 0x49, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12,=
 }, 11, 0, "", "",
> >>>>  "66 49 0f 38 f5 94 c8 78 56 34 12 \twrussq %rdx,0x12345678(%r8,%rcx=
,8)",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
> >>>> -"f3 0f 01 e8          \tsetssbsy ",},
> >>>> +"f3 0f 01 e8          \tsetssbsy",},
> >>>>  {{0x0f, 0x01, 0xee, }, 3, 0, "", "",
> >>>> -"0f 01 ee             \trdpkru ",},
> >>>> +"0f 01 ee             \trdpkru",},
> >>>>  {{0x0f, 0x01, 0xef, }, 3, 0, "", "",
> >>>> -"0f 01 ef             \twrpkru ",},
> >>>> +"0f 01 ef             \twrpkru",},
> >>>>  {{0xf3, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
> >>>>  "f3 0f ae 30          \tclrssbsy (%rax)",},
> >>>>  {{0xf3, 0x41, 0x0f, 0xae, 0x30, }, 5, 0, "", "",
> >>>> @@ -2360,105 +2361,105 @@
> >>>>  {{0xf3, 0x41, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10=
, 0, "", "",
> >>>>  "f3 41 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%r8,%rcx,8)",}=
,
> >>>>  {{0xf3, 0x0f, 0x1e, 0xfb, }, 4, 0, "", "",
> >>>> -"f3 0f 1e fb          \tendbr32 ",},
> >>>> +"f3 0f 1e fb          \tendbr32",},
> >>>>  {{0xf3, 0x0f, 0x1e, 0xfa, }, 4, 0, "", "",
> >>>> -"f3 0f 1e fa          \tendbr64 ",},
> >>>> +"f3 0f 1e fa          \tendbr64",},
> >>>>  {{0xff, 0xd0, }, 2, 0, "call", "indirect",
> >>>> -"ff d0                \tcallq  *%rax",},
> >>>> +"ff d0                \tcall   *%rax",},
> >>>>  {{0xff, 0x10, }, 2, 0, "call", "indirect",
> >>>> -"ff 10                \tcallq  *(%rax)",},
> >>>> +"ff 10                \tcall   *(%rax)",},
> >>>>  {{0x41, 0xff, 0x10, }, 3, 0, "call", "indirect",
> >>>> -"41 ff 10             \tcallq  *(%r8)",},
> >>>> +"41 ff 10             \tcall   *(%r8)",},
> >>>>  {{0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indir=
ect",
> >>>> -"ff 14 25 78 56 34 12 \tcallq  *0x12345678",},
> >>>> +"ff 14 25 78 56 34 12 \tcall   *0x12345678",},
> >>>>  {{0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indir=
ect",
> >>>> -"ff 94 c8 78 56 34 12 \tcallq  *0x12345678(%rax,%rcx,8)",},
> >>>> +"ff 94 c8 78 56 34 12 \tcall   *0x12345678(%rax,%rcx,8)",},
> >>>>  {{0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", =
"indirect",
> >>>> -"41 ff 94 c8 78 56 34 12 \tcallq  *0x12345678(%r8,%rcx,8)",},
> >>>> +"41 ff 94 c8 78 56 34 12 \tcall   *0x12345678(%r8,%rcx,8)",},
> >>>>  {{0xf2, 0xff, 0xd0, }, 3, 0, "call", "indirect",
> >>>> -"f2 ff d0             \tbnd callq *%rax",},
> >>>> +"f2 ff d0             \tbnd call *%rax",},
> >>>>  {{0xf2, 0xff, 0x10, }, 3, 0, "call", "indirect",
> >>>> -"f2 ff 10             \tbnd callq *(%rax)",},
> >>>> +"f2 ff 10             \tbnd call *(%rax)",},
> >>>>  {{0xf2, 0x41, 0xff, 0x10, }, 4, 0, "call", "indirect",
> >>>> -"f2 41 ff 10          \tbnd callq *(%r8)",},
> >>>> +"f2 41 ff 10          \tbnd call *(%r8)",},
> >>>>  {{0xf2, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", =
"indirect",
> >>>> -"f2 ff 14 25 78 56 34 12 \tbnd callq *0x12345678",},
> >>>> +"f2 ff 14 25 78 56 34 12 \tbnd call *0x12345678",},
> >>>>  {{0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", =
"indirect",
> >>>> -"f2 ff 94 c8 78 56 34 12 \tbnd callq *0x12345678(%rax,%rcx,8)",},
> >>>> +"f2 ff 94 c8 78 56 34 12 \tbnd call *0x12345678(%rax,%rcx,8)",},
> >>>>  {{0xf2, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "c=
all", "indirect",
> >>>> -"f2 41 ff 94 c8 78 56 34 12 \tbnd callq *0x12345678(%r8,%rcx,8)",},
> >>>> +"f2 41 ff 94 c8 78 56 34 12 \tbnd call *0x12345678(%r8,%rcx,8)",},
> >>>>  {{0x3e, 0xff, 0xd0, }, 3, 0, "call", "indirect",
> >>>> -"3e ff d0             \tnotrack callq *%rax",},
> >>>> +"3e ff d0             \tnotrack call *%rax",},
> >>>>  {{0x3e, 0xff, 0x10, }, 3, 0, "call", "indirect",
> >>>> -"3e ff 10             \tnotrack callq *(%rax)",},
> >>>> +"3e ff 10             \tnotrack call *(%rax)",},
> >>>>  {{0x3e, 0x41, 0xff, 0x10, }, 4, 0, "call", "indirect",
> >>>> -"3e 41 ff 10          \tnotrack callq *(%r8)",},
> >>>> +"3e 41 ff 10          \tnotrack call *(%r8)",},
> >>>>  {{0x3e, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", =
"indirect",
> >>>> -"3e ff 14 25 78 56 34 12 \tnotrack callq *0x12345678",},
> >>>> +"3e ff 14 25 78 56 34 12 \tnotrack call *0x12345678",},
> >>>>  {{0x3e, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", =
"indirect",
> >>>> -"3e ff 94 c8 78 56 34 12 \tnotrack callq *0x12345678(%rax,%rcx,8)",=
},
> >>>> +"3e ff 94 c8 78 56 34 12 \tnotrack call *0x12345678(%rax,%rcx,8)",}=
,
> >>>>  {{0x3e, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "c=
all", "indirect",
> >>>> -"3e 41 ff 94 c8 78 56 34 12 \tnotrack callq *0x12345678(%r8,%rcx,8)=
",},
> >>>> +"3e 41 ff 94 c8 78 56 34 12 \tnotrack call *0x12345678(%r8,%rcx,8)"=
,},
> >>>>  {{0x3e, 0xf2, 0xff, 0xd0, }, 4, 0, "call", "indirect",
> >>>> -"3e f2 ff d0          \tnotrack bnd callq *%rax",},
> >>>> +"3e f2 ff d0          \tnotrack bnd call *%rax",},
> >>>>  {{0x3e, 0xf2, 0xff, 0x10, }, 4, 0, "call", "indirect",
> >>>> -"3e f2 ff 10          \tnotrack bnd callq *(%rax)",},
> >>>> +"3e f2 ff 10          \tnotrack bnd call *(%rax)",},
> >>>>  {{0x3e, 0xf2, 0x41, 0xff, 0x10, }, 5, 0, "call", "indirect",
> >>>> -"3e f2 41 ff 10       \tnotrack bnd callq *(%r8)",},
> >>>> +"3e f2 41 ff 10       \tnotrack bnd call *(%r8)",},
> >>>>  {{0x3e, 0xf2, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "c=
all", "indirect",
> >>>> -"3e f2 ff 14 25 78 56 34 12 \tnotrack bnd callq *0x12345678",},
> >>>> +"3e f2 ff 14 25 78 56 34 12 \tnotrack bnd call *0x12345678",},
> >>>>  {{0x3e, 0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "c=
all", "indirect",
> >>>> -"3e f2 ff 94 c8 78 56 34 12 \tnotrack bnd callq *0x12345678(%rax,%r=
cx,8)",},
> >>>> +"3e f2 ff 94 c8 78 56 34 12 \tnotrack bnd call *0x12345678(%rax,%rc=
x,8)",},
> >>>>  {{0x3e, 0xf2, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10=
, 0, "call", "indirect",
> >>>> -"3e f2 41 ff 94 c8 78 56 34 12 \tnotrack bnd callq *0x12345678(%r8,=
%rcx,8)",},
> >>>> +"3e f2 41 ff 94 c8 78 56 34 12 \tnotrack bnd call *0x12345678(%r8,%=
rcx,8)",},
> >>>>  {{0xff, 0xe0, }, 2, 0, "jmp", "indirect",
> >>>> -"ff e0                \tjmpq   *%rax",},
> >>>> +"ff e0                \tjmp    *%rax",},
> >>>>  {{0xff, 0x20, }, 2, 0, "jmp", "indirect",
> >>>> -"ff 20                \tjmpq   *(%rax)",},
> >>>> +"ff 20                \tjmp    *(%rax)",},
> >>>>  {{0x41, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
> >>>> -"41 ff 20             \tjmpq   *(%r8)",},
> >>>> +"41 ff 20             \tjmp    *(%r8)",},
> >>>>  {{0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indire=
ct",
> >>>> -"ff 24 25 78 56 34 12 \tjmpq   *0x12345678",},
> >>>> +"ff 24 25 78 56 34 12 \tjmp    *0x12345678",},
> >>>>  {{0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indire=
ct",
> >>>> -"ff a4 c8 78 56 34 12 \tjmpq   *0x12345678(%rax,%rcx,8)",},
> >>>> +"ff a4 c8 78 56 34 12 \tjmp    *0x12345678(%rax,%rcx,8)",},
> >>>>  {{0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "=
indirect",
> >>>> -"41 ff a4 c8 78 56 34 12 \tjmpq   *0x12345678(%r8,%rcx,8)",},
> >>>> +"41 ff a4 c8 78 56 34 12 \tjmp    *0x12345678(%r8,%rcx,8)",},
> >>>>  {{0xf2, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
> >>>> -"f2 ff e0             \tbnd jmpq *%rax",},
> >>>> +"f2 ff e0             \tbnd jmp *%rax",},
> >>>>  {{0xf2, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
> >>>> -"f2 ff 20             \tbnd jmpq *(%rax)",},
> >>>> +"f2 ff 20             \tbnd jmp *(%rax)",},
> >>>>  {{0xf2, 0x41, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
> >>>> -"f2 41 ff 20          \tbnd jmpq *(%r8)",},
> >>>> +"f2 41 ff 20          \tbnd jmp *(%r8)",},
> >>>>  {{0xf2, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "=
indirect",
> >>>> -"f2 ff 24 25 78 56 34 12 \tbnd jmpq *0x12345678",},
> >>>> +"f2 ff 24 25 78 56 34 12 \tbnd jmp *0x12345678",},
> >>>>  {{0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "=
indirect",
> >>>> -"f2 ff a4 c8 78 56 34 12 \tbnd jmpq *0x12345678(%rax,%rcx,8)",},
> >>>> +"f2 ff a4 c8 78 56 34 12 \tbnd jmp *0x12345678(%rax,%rcx,8)",},
> >>>>  {{0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "j=
mp", "indirect",
> >>>> -"f2 41 ff a4 c8 78 56 34 12 \tbnd jmpq *0x12345678(%r8,%rcx,8)",},
> >>>> +"f2 41 ff a4 c8 78 56 34 12 \tbnd jmp *0x12345678(%r8,%rcx,8)",},
> >>>>  {{0x3e, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
> >>>> -"3e ff e0             \tnotrack jmpq *%rax",},
> >>>> +"3e ff e0             \tnotrack jmp *%rax",},
> >>>>  {{0x3e, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
> >>>> -"3e ff 20             \tnotrack jmpq *(%rax)",},
> >>>> +"3e ff 20             \tnotrack jmp *(%rax)",},
> >>>>  {{0x3e, 0x41, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
> >>>> -"3e 41 ff 20          \tnotrack jmpq *(%r8)",},
> >>>> +"3e 41 ff 20          \tnotrack jmp *(%r8)",},
> >>>>  {{0x3e, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "=
indirect",
> >>>> -"3e ff 24 25 78 56 34 12 \tnotrack jmpq *0x12345678",},
> >>>> +"3e ff 24 25 78 56 34 12 \tnotrack jmp *0x12345678",},
> >>>>  {{0x3e, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "=
indirect",
> >>>> -"3e ff a4 c8 78 56 34 12 \tnotrack jmpq *0x12345678(%rax,%rcx,8)",}=
,
> >>>> +"3e ff a4 c8 78 56 34 12 \tnotrack jmp *0x12345678(%rax,%rcx,8)",},
> >>>>  {{0x3e, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "j=
mp", "indirect",
> >>>> -"3e 41 ff a4 c8 78 56 34 12 \tnotrack jmpq *0x12345678(%r8,%rcx,8)"=
,},
> >>>> +"3e 41 ff a4 c8 78 56 34 12 \tnotrack jmp *0x12345678(%r8,%rcx,8)",=
},
> >>>>  {{0x3e, 0xf2, 0xff, 0xe0, }, 4, 0, "jmp", "indirect",
> >>>> -"3e f2 ff e0          \tnotrack bnd jmpq *%rax",},
> >>>> +"3e f2 ff e0          \tnotrack bnd jmp *%rax",},
> >>>>  {{0x3e, 0xf2, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
> >>>> -"3e f2 ff 20          \tnotrack bnd jmpq *(%rax)",},
> >>>> +"3e f2 ff 20          \tnotrack bnd jmp *(%rax)",},
> >>>>  {{0x3e, 0xf2, 0x41, 0xff, 0x20, }, 5, 0, "jmp", "indirect",
> >>>> -"3e f2 41 ff 20       \tnotrack bnd jmpq *(%r8)",},
> >>>> +"3e f2 41 ff 20       \tnotrack bnd jmp *(%r8)",},
> >>>>  {{0x3e, 0xf2, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "j=
mp", "indirect",
> >>>> -"3e f2 ff 24 25 78 56 34 12 \tnotrack bnd jmpq *0x12345678",},
> >>>> +"3e f2 ff 24 25 78 56 34 12 \tnotrack bnd jmp *0x12345678",},
> >>>>  {{0x3e, 0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "j=
mp", "indirect",
> >>>> -"3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%rax,%rc=
x,8)",},
> >>>> +"3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%rax,%rcx=
,8)",},
> >>>>  {{0x3e, 0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10=
, 0, "jmp", "indirect",
> >>>> -"3e f2 41 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%r8,%=
rcx,8)",},
> >>>> +"3e f2 41 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%r8,%r=
cx,8)",},
> >>>>  {{0xc4, 0xe2, 0x78, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
> >>>>  "c4 e2 78 49 04 c8    \tldtilecfg (%rax,%rcx,8)",},
> >>>>  {{0xc4, 0xc2, 0x78, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
> >>>> @@ -2486,7 +2487,7 @@
> >>>>  {{0xc4, 0xc2, 0x79, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
> >>>>  "c4 c2 79 4b 14 c8    \ttileloaddt1 (%r8,%rcx,8),%tmm2",},
> >>>>  {{0xc4, 0xe2, 0x78, 0x49, 0xc0, }, 5, 0, "", "",
> >>>> -"c4 e2 78 49 c0       \ttilerelease ",},
> >>>> +"c4 e2 78 49 c0       \ttilerelease",},
> >>>>  {{0xc4, 0xe2, 0x7a, 0x4b, 0x0c, 0xc8, }, 6, 0, "", "",
> >>>>  "c4 e2 7a 4b 0c c8    \ttilestored %tmm1,(%rax,%rcx,8)",},
> >>>>  {{0xc4, 0xc2, 0x7a, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
> >>>> @@ -2496,17 +2497,17 @@
> >>>>  {{0xc4, 0xe2, 0x7b, 0x49, 0xf8, }, 5, 0, "", "",
> >>>>  "c4 e2 7b 49 f8       \ttilezero %tmm7",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xee, }, 4, 0, "", "",
> >>>> -"f3 0f 01 ee          \tclui   ",},
> >>>> +"f3 0f 01 ee          \tclui",},
> >>>>  {{0xf3, 0x0f, 0xc7, 0xf0, }, 4, 0, "", "",
> >>>>  "f3 0f c7 f0          \tsenduipi %rax",},
> >>>>  {{0xf3, 0x41, 0x0f, 0xc7, 0xf0, }, 5, 0, "", "",
> >>>>  "f3 41 0f c7 f0       \tsenduipi %r8",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xef, }, 4, 0, "", "",
> >>>> -"f3 0f 01 ef          \tstui   ",},
> >>>> +"f3 0f 01 ef          \tstui",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xed, }, 4, 0, "", "",
> >>>> -"f3 0f 01 ed          \ttestui ",},
> >>>> +"f3 0f 01 ed          \ttestui",},
> >>>>  {{0xf3, 0x0f, 0x01, 0xec, }, 4, 0, "", "",
> >>>> -"f3 0f 01 ec          \tuiret  ",},
> >>>> +"f3 0f 01 ec          \tuiret",},
> >>>>  {{0x62, 0xf5, 0x6c, 0x48, 0x58, 0xcb, }, 6, 0, "", "",
> >>>>  "62 f5 6c 48 58 cb    \tvaddph %zmm3,%zmm2,%zmm1",},
> >>>>  {{0x62, 0xf5, 0x6c, 0x48, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12,=
 }, 11, 0, "", "",
> >>>> @@ -3880,18 +3881,24 @@
> >>>>  {{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
> >>>>  "f3 0f 3a f0 c0 00    \threset $0x0",},
> >>>>  {{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
> >>>> -"0f 01 e8             \tserialize ",},
> >>>> +"0f 01 e8             \tserialize",},
> >>>>  {{0xf2, 0x0f, 0x01, 0xe9, }, 4, 0, "", "",
> >>>> -"f2 0f 01 e9          \txresldtrk ",},
> >>>> +"f2 0f 01 e9          \txresldtrk",},
> >>>>  {{0xf2, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
> >>>> -"f2 0f 01 e8          \txsusldtrk ",},
> >>>> +"f2 0f 01 e8          \txsusldtrk",},
> >>>>  {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
> >>>> -"0f 01 cf             \tencls  ",},
> >>>> +"0f 01 cf             \tencls",},
> >>>>  {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
> >>>> -"0f 01 d7             \tenclu  ",},
> >>>> +"0f 01 d7             \tenclu",},
> >>>>  {{0x0f, 0x01, 0xc0, }, 3, 0, "", "",
> >>>> -"0f 01 c0             \tenclv  ",},
> >>>> +"0f 01 c0             \tenclv",},
> >>>>  {{0x0f, 0x01, 0xc5, }, 3, 0, "", "",
> >>>> -"0f 01 c5             \tpconfig ",},
> >>>> +"0f 01 c5             \tpconfig",},
> >>>>  {{0xf3, 0x0f, 0x09, }, 3, 0, "", "",
> >>>> -"f3 0f 09             \twbnoinvd ",},
> >>>> +"f3 0f 09             \twbnoinvd",},
> >>>> +{{0x0f, 0x01, 0xee, }, 3, 0, "", "",
> >>>> +"0f 01 ee             \trdpkru",},
> >>>> +{{0x0f, 0x01, 0xef, }, 3, 0, "", "",
> >>>> +"0f 01 ef             \twrpkru",},
> >>>> +{{0}, 0, 0, NULL, NULL, NULL},
> >>>> +};
> >>>> diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/=
x86/tests/insn-x86.c
> >>>> index 7b5eb8baf0f2..447f7ba1eff3 100644
> >>>> --- a/tools/perf/arch/x86/tests/insn-x86.c
> >>>> +++ b/tools/perf/arch/x86/tests/insn-x86.c
> >>>> @@ -18,21 +18,8 @@ struct test_data {
> >>>>      const char *asm_rep;
> >>>>  };
> >>>>
> >>>> -const struct test_data test_data_32[] =3D {
> >>>>  #include "insn-x86-dat-32.c"
> >>>> -    {{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \t=
rdpkru"},
> >>>> -    {{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \t=
wrpkru"},
> >>>> -    {{0}, 0, 0, NULL, NULL, NULL},
> >>>> -};
> >>>> -
> >>>> -const struct test_data test_data_64[] =3D {
> >>>>  #include "insn-x86-dat-64.c"
> >>>> -    {{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \t=
rdpkru"},
> >>>> -    {{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \t=
wrpkru"},
> >>>> -    {{0xf2, 0x0f, 0x01, 0xca}, 4, 0, "erets", "indirect", "f2 0f 01=
 ca  \terets"},
> >>>> -    {{0xf3, 0x0f, 0x01, 0xca}, 4, 0, "eretu", "indirect", "f3 0f 01=
 ca  \teretu"},
> >>>> -    {{0}, 0, 0, NULL, NULL, NULL},
> >>>> -};
> >>>>
> >>>>  static int get_op(const char *op_str)
> >>>>  {
> >>>> @@ -156,6 +143,16 @@ static int test_data_set(const struct test_data=
 *dat_set, int x86_64)
> >>>>              if (test_data_item(dat, x86_64))
> >>>>                      ret =3D -1;
> >>>>      }
> >>>> +    if (x86_64) {
> >>>> +            const struct test_data eret[] =3D {
> >>>> +                    {{0xf2, 0x0f, 0x01, 0xca}, 4, 0,
> >>>> +                     "erets", "indirect", "f2 0f 01 ca  \terets"},
> >>>> +                    {{0xf3, 0x0f, 0x01, 0xca}, 4, 0,
> >>>> +                     "eretu", "indirect", "f3 0f 01 ca  \teretu"},
> >>>> +            };
> >>>> +            if (test_data_item(&eret[0], x86_64) || test_data_item(=
&eret[1], x86_64))
> >>>> +                    ret =3D -1;
> >>>> +    }
> >>>>
> >>>>      return ret;
> >>>>  }
> >>>> --
> >>>> 2.41.0.rc0.172.g3f132b7071-goog
> >>>>
> >>>
> >>
>
