Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDA7417F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF1SWU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jun 2023 14:22:20 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:59582 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjF1SWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:22:16 -0400
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bff89873d34so32740276.2;
        Wed, 28 Jun 2023 11:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976536; x=1690568536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN9pyN3LvmrlubEFEmUp4FLP23KLhwvTmvzQKkIhMho=;
        b=MCsZmSlSh/cn1wn7q1ASyhTFiZ54yBwAgwqQY7lKMqMYk3a2cuobnjEj8bWLudRgWB
         zljgQbKft7Ux+SN/VbNDmx76OVZR3pTRW/ITpwZea3Mhan8GbXNHCbIcF/dh0DZ3orsE
         r6iK0VErlizJsvF7ShLN78a4eDkYa32DiZ22DGY23PnBoOJklmyA7kYhpMbpJdRYAop3
         ZGgRdk4HfqFHLXq4CE4QNpnvfopa2CnQGPFW3b+83R5RopD+1TlFwmhjN+sqR+0HAd1d
         d99DNW5nhfvFZ8A4Qp/HDfpzUcVdtGjU6OwTcYO5NpM50/mk1Js7Bau5eo7Jf1AlTHk+
         diXA==
X-Gm-Message-State: AC+VfDyU4GwKsmYxzyN1x9hjYuk9W+1mHILgyW1N5SDWBQ4GIHAZY0BL
        LEyeOu2ZotUx9RqfMVADSMfXZruV0qy/KIIXhnA=
X-Google-Smtp-Source: ACHHUZ7qYcXP/WLsuFJNiIl/sAOmUw3kRaTQ0lISyJjoY7FMLNxKt5cB4mt+9oPXsOGS3LmH+x3V1+I2tuaglDC8fLo=
X-Received: by 2002:a25:cf91:0:b0:c14:3d56:bf65 with SMTP id
 f139-20020a25cf91000000b00c143d56bf65mr9674102ybg.4.1687976535709; Wed, 28
 Jun 2023 11:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230516103413.21e34bb6@canb.auug.org.au> <20230628113748.071d8d80@canb.auug.org.au>
In-Reply-To: <20230628113748.071d8d80@canb.auug.org.au>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Jun 2023 11:22:04 -0700
Message-ID: <CAM9d7ciqQSp3zWNeq-P0r8pGN=6jJBWyxK=LzUz2SYm_kAaG4g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 27, 2023 at 6:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 16 May 2023 10:34:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the tip tree got conflicts in:
> >
> >   tools/perf/arch/x86/include/arch-tests.h
> >   tools/perf/arch/x86/tests/arch-tests.c
> >
> > between commit:
> >
> >   ae4aa00a1a93 ("perf test: Move x86 hybrid tests to arch/x86")
> >
> > from the perf tree and commit:
> >
> >   78075d947534 ("perf test: Add selftest to test IBS invocation via core pmu events")
> >
> > from the tip tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

Thanks for the email and the resolution.  Looks ok to me.
I'll note this in my pull request.


> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc tools/perf/arch/x86/include/arch-tests.h
> > index 33d39c1d3e64,93d3b8877baa..000000000000
> > --- a/tools/perf/arch/x86/include/arch-tests.h
> > +++ b/tools/perf/arch/x86/include/arch-tests.h
> > @@@ -11,7 -11,7 +11,8 @@@ int test__intel_pt_pkt_decoder(struct t
> >   int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
> >   int test__bp_modify(struct test_suite *test, int subtest);
> >   int test__x86_sample_parsing(struct test_suite *test, int subtest);
> >  +int test__hybrid(struct test_suite *test, int subtest);
> > + int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
> >
> >   extern struct test_suite *arch_tests[];
> >
> > diff --cc tools/perf/arch/x86/tests/arch-tests.c
> > index 147ad0638bbb,b5c85ab8d92e..000000000000
> > --- a/tools/perf/arch/x86/tests/arch-tests.c
> > +++ b/tools/perf/arch/x86/tests/arch-tests.c
> > @@@ -22,15 -22,7 +22,16 @@@ struct test_suite suite__intel_pt =
> >   DEFINE_SUITE("x86 bp modify", bp_modify);
> >   #endif
> >   DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
> >  +static struct test_case hybrid_tests[] = {
> >  +    TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
> >  +    { .name = NULL, }
> >  +};
> >  +
> >  +struct test_suite suite__hybrid = {
> >  +    .desc = "x86 hybrid",
> >  +    .test_cases = hybrid_tests,
> >  +};
> > + DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
> >
> >   struct test_suite *arch_tests[] = {
> >   #ifdef HAVE_DWARF_UNWIND_SUPPORT
> > @@@ -44,6 -36,6 +45,7 @@@
> >       &suite__bp_modify,
> >   #endif
> >       &suite__x86_sample_parsing,
> >  +    &suite__hybrid,
> > +     &suite__amd_ibs_via_core_pmu,
> >       NULL,
> >   };
>
> This is now a conflict between the perf tree and Linus' tree.

Yep, thanks!

Namhyung
