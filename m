Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2D6CF14C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC2RoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2RoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:44:16 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE259ED;
        Wed, 29 Mar 2023 10:44:12 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r84so10913655oih.11;
        Wed, 29 Mar 2023 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680111852;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50QTP45WY6pvn3yZ3i6RkBzEDvZP2fVH5iPA1Ib3bVk=;
        b=ZXeaZOMY8TwVzWjeXC0/zMJ528ILJgW7jupdBIe5PH1RR9vJ+0zf/X4WGjjKBaEx4L
         mZUoZimDHjb80cjWS1arXe8sOH5Qp9OfVtdZnJeS4IfL+oeHzEZjxs6KbgVxYiULFa0H
         xnakT1vGRPpyxkrqzpaPI70SMz20/X4dsR2ZMJlnjoVQKw3txigMz41IWyeyOjWdJLTc
         0bZmU2/RIC0I5VpG8kfe3aPj9Td4cTssRvJ4zjnK73prjMy1k5v8GHiEda8hvVBTX+MH
         pTTISSqmU0OXct4TZ1p+xYGCzTXOtqcMeT/f+4cRFh0R2UAAXwLp91SezMt62StL/TTp
         nQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111852;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50QTP45WY6pvn3yZ3i6RkBzEDvZP2fVH5iPA1Ib3bVk=;
        b=FX50TNuIVyccFx/EBBrkf4SNPdHTu53z0tfObIBgd8qwRnD/wzCUFJrOQn3EMFMHDi
         rql3MA+57vZxzAEz09xkHWynMp37sFIBMsSV79odMlkA+zlIsoVgjpI/oLebXMSUJS7D
         vEaxKXgNWtkeGpHviPFghFyHAeU0SyEyv/OzuQrpmIMe0fAYA1kn6i4mrNzz/Q5ifEN0
         uOrmAufG+eznnKtwbTzbe20UCyI8wW8jKVDQPOX+qqQAsn8kPHtCxhrutdgO/Q22+gbr
         6PfRPBBz5d03FcLs9gL6HPAcpKC/T44g4NIJN5v3GTBE5Phso64RzsF8P7eP6xxrghOe
         5gJA==
X-Gm-Message-State: AO0yUKWOQx53PelCSfOFPztm37shuVaIx71xugO1SdjYVDh/+5nuu6YK
        XSt7KvU92ibGrHTCUxeVXpU=
X-Google-Smtp-Source: AK7set8NQrCxkB7VeBc2tVbXE4aVV2EPvvcPR/7ZRJ31RYAO+pmyLcPndKg3Qx+5zhcKTuqVEy1zLg==
X-Received: by 2002:aca:1810:0:b0:386:d2fc:989a with SMTP id h16-20020aca1810000000b00386d2fc989amr8346264oih.54.1680111852268;
        Wed, 29 Mar 2023 10:44:12 -0700 (PDT)
Received: from [127.0.0.1] (177-57-192-121.3g.claro.net.br. [177.57.192.121])
        by smtp.gmail.com with ESMTPSA id x127-20020a4a4185000000b0053d9be4be68sm6127740ooa.19.2023.03.29.10.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:44:11 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:44:06 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>,
        Oliver Sang <oliver.sang@intel.com>
CC:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andres Freund <andres@anarazel.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tom Rix <trix@redhat.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bacme=3Atmp=2Eperf-tools-next=5D_=5Bperf_build=5D_?= =?US-ASCII?Q?a980755beb=3A_perf-sanity-tests=2Eperf=2Emake=2Efail?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fVV-3jYnJsrLZjqoJz3DzmT4b5t==Y3joC0NHgpz-qp-w@mail.gmail.com>
References: <202303222158.8975b36d-oliver.sang@intel.com> <CAP-5=fV3x_=6JqVsX8Z_+5bz67de_5JcWX-1B=So18wpMK3r=A@mail.gmail.com> <ZCPX5bYv0zK+/a6u@xsang-OptiPlex-9020> <CAP-5=fVV-3jYnJsrLZjqoJz3DzmT4b5t==Y3joC0NHgpz-qp-w@mail.gmail.com>
Message-ID: <2F03A3D5-0441-4CCB-A64A-E17B1D6295A9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 29, 2023 1:54:39 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> =
wrote:
>On Tue, Mar 28, 2023 at 11:17=E2=80=AFPM Oliver Sang <oliver=2Esang@intel=
=2Ecom> wrote:
>>
>> hi Ian,
>>
>> On Wed, Mar 22, 2023 at 09:03:28AM -0700, Ian Rogers wrote:
>> > On Wed, Mar 22, 2023 at 7:20=E2=80=AFAM kernel test robot <oliver=2Es=
ang@intel=2Ecom> wrote:
>> > >
>> > >
>> > > Greeting,
>> > >
>> > > FYI, we noticed perf-sanity-tests=2Eperf=2Emake=2Efail due to commi=
t (built with gcc-11):
>> > >
>> > > commit: a980755beb5aca9002e1c95ba519b83a44242b5b ("perf build: Make=
 BUILD_BPF_SKEL default, rename to NO_BPF_SKEL")
>> > > https://git=2Ekernel=2Eorg/cgit/linux/kernel/git/acme/linux=2Egit t=
mp=2Eperf-tools-next
>> > >
>> > > in testcase: perf-sanity-tests
>> > > version: perf-x86_64-e8d018dd0257-1_20230320
>> > > with following parameters:
>> > >
>> > >         perf_compiler: clang
>> > >
>> > > [   98=2E290078][  T246] make perf failed
>> >
>> > Hi Oliver,
>> >
>> > Could we add NO_BPF_SKEL=3D1 to the build flags? The idea with changi=
ng
>> > the default is that is what most users want and so we want the BPF
>> > skeleton to be opt-out rather than opt-in=2E
>>
>> Thanks a lot for guidance!
>>
>> I added NO_BPF_SKEL=3D1 then make perf can pass upon this commit=2E
>> I also tried to add BUILD_BPF_SKEL=3D1 while make perf for parent, it w=
ill fail=2E
>>
>> since you said in commit message
>> "BPF skeleton support is now key to a number of perf features=2E"
>> we will start to fix make issue=2E


So, does that mean that you guys will not use NO_BPF_SKEL=3D1 and instead =
will try to have what is needed to build with the default: with BPF skel an=
d the features enabled by them?

If that is the case: great!

- Arnaldo=20

>>
>> Thanks!
>
>This is great Oliver, many thanks!
>Ian
>
>> >
>> > Thanks,
>> > Ian
>> >
>> > >
>> > > To reproduce:
>> > >
>> > >         git clone https://github=2Ecom/intel/lkp-tests=2Egit
>> > >         cd lkp-tests
>> > >         sudo bin/lkp install job=2Eyaml           # job file is att=
ached in this email
>> > >         bin/lkp split-job --compatible job=2Eyaml # generate the ya=
ml file for lkp run
>> > >         sudo bin/lkp run generated-yaml-file
>> > >
>> > >         # if come across any failure that blocks the test,
>> > >         # please remove ~/=2Elkp and /lkp dir to run from a clean s=
tate=2E
>> > >
>> > >
>> > >
>> > > --
>> > > 0-DAY CI Kernel Test Service
>> > > https://github=2Ecom/intel/lkp-tests
>> > >
>> > >
>> >
