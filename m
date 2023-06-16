Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27CE732B19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjFPJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343718AbjFPJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:08:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37553C2F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:06:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-311183ef595so278448f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686906408; x=1689498408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOWt+C9wEbLfjqdZhINVftMFCjAyDqGa14a9jKJ2WVI=;
        b=G6ROQg++vHQw4V3AtetwK7l7I5esMSVoruTnh8EyN/ijS6Re627CdPP8YQcXToUru9
         iuqVdpH0b4lB44E9kOAOyVyBF/2xAk95vDbiu5xBjuHfnNjC23zAuSx2Eb1+RW6cHgiF
         9JtSG8Hp2cjJedaPfxojke6Bh6ve5fzpoRRVyNSaFmCUCoAIqaBsUTowv+WSRdQ8QqSR
         WeGBcYRpT4TSKUHD2UFGtrItMtVfjY73IJPhIqWiCeMtVpL0zdDBsrD9gnlu5mocCoUw
         dQXQLwbcxBbNok8aNe9hogrAcK/TOVuBxW6ywxaUOjFDfvVx1Q1TPmNqxncB+BEgdrJq
         TlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906408; x=1689498408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOWt+C9wEbLfjqdZhINVftMFCjAyDqGa14a9jKJ2WVI=;
        b=XO4wqPUEQWlDJoA/jLFecUQO6gw+W+Pul2cS+w2O+CH1tTyW6BxZNr+vVImnTlHiVO
         dkMWmVMEbo6BQ9fbVdjqvCnrQwAS6zHRxZevcaaDBPUal37ENdbS568VhQhoU/BMYSyb
         gZ3zXOYRzbud5pptbTULANEOLnr1PWqG56MRqY2tCA3jSncb0+n6BA4J7U+5vupe58Bb
         J9l4frIyVUeiedkBLV1frSccJgrrWIkwt/nztVFdR2EBnEq1sK82F4C7P64TwHqz2cXh
         vwSKjMYxxRi3HZCSpOO/4teYapTxCCn01VWwv+awP1/i+QrYYotskRFvOJyxD+Zi45Nj
         emFQ==
X-Gm-Message-State: AC+VfDx3AcJOTGROozA21DxLZIO1VsMUOmFEvvYMN3ql/UUtNQLnVY1S
        zy+O2fZs13typ62YP29FW/aWdMGuKqgWYRPrKbgdeQ==
X-Google-Smtp-Source: ACHHUZ6yG3gf4Y6nAcZIL+5rY4JrqDkcntRqtoN/pU/vG2fH73sWA4VKxmw9Z3uL8QL75OuCCXdqoVlqQndqO/kfeKU=
X-Received: by 2002:a5d:44cf:0:b0:310:4fa3:5b0f with SMTP id
 z15-20020a5d44cf000000b003104fa35b0fmr626635wrr.69.1686906408314; Fri, 16 Jun
 2023 02:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-10-alexghiti@rivosinc.com> <CAOnJCU+n0O9oQmd1Vs3kimaBai7vbaf5RiMRFyvphCCLCGMB1A@mail.gmail.com>
In-Reply-To: <CAOnJCU+n0O9oQmd1Vs3kimaBai7vbaf5RiMRFyvphCCLCGMB1A@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 16 Jun 2023 11:06:37 +0200
Message-ID: <CAHVXubgGqRLN3cb=eEW8zXHto6ZqJGg4LoFi=rEnuBCztYtV=w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] tools: lib: perf: Implement riscv mmap support
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:43=E2=80=AFAM Atish Patra <atishp@atishpatra.org=
> wrote:
>
> On Fri, May 12, 2023 at 2:03=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > riscv now support mmaping hardware counters so add what's needed to
> > take advantage of that in libperf.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 0d1634cedf44..65f250e0ef92 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
> >
> >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> >
> > +#elif __riscv_xlen =3D=3D 64
> > +
>
> This is applicable for RV32 as well. No ?
> otherwise, you won't need CSR_CYCLEH

Admittedly, I have not checked rv32 at all in this series and the code
below is a copy-paste. I'd say that rv32 support is out of scope for
this series, is that ok with you?

>
> > +#define CSR_CYCLE      0xc00
> > +#define CSR_TIME       0xc01
> > +#define CSR_CYCLEH     0xc80
> > +
> > +#define csr_read(csr)                                          \
> > +({                                                             \
> > +       register unsigned long __v;                             \
> > +               __asm__ __volatile__ ("csrr %0, " #csr          \
> > +                : "=3Dr" (__v) :                                 \
> > +                : "memory");                                   \
> > +                __v;                                           \
> > +})
> > +
> > +static unsigned long csr_read_num(int csr_num)
> > +{
> > +#define switchcase_csr_read(__csr_num, __val)           {\
> > +       case __csr_num:                                 \
> > +               __val =3D csr_read(__csr_num);            \
> > +               break; }
> > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > +       switchcase_csr_read(__csr_num + 1, __val)}
> > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > +
> > +       unsigned long ret =3D 0;
> > +
> > +       switch (csr_num) {
> > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > +       switchcase_csr_read_32(CSR_CYCLEH, ret)
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +#undef switchcase_csr_read_32
> > +#undef switchcase_csr_read_16
> > +#undef switchcase_csr_read_8
> > +#undef switchcase_csr_read_4
> > +#undef switchcase_csr_read_2
> > +#undef switchcase_csr_read
> > +}
> > +
> > +static u64 read_perf_counter(unsigned int counter)
> > +{
> > +       return csr_read_num(CSR_CYCLE + counter);
> > +}
> > +
> > +static u64 read_timestamp(void)
> > +{
> > +       return csr_read_num(CSR_TIME);
> > +}
> > +
> >  #else
> >  static u64 read_perf_counter(unsigned int counter __maybe_unused) { re=
turn 0; }
> >  static u64 read_timestamp(void) { return 0; }
> > --
> > 2.37.2
> >
>
>
> --
> Regards,
> Atish
