Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1FE732A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbjFPIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbjFPInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:43:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44342D77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:43:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b44d77e56bso8470161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686905008; x=1689497008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDKNwc2spJwBfD2I0zIbFW0EXN11ktfXXRri1gY5Wq4=;
        b=Q4BVOMxjOIj+1lvfbkrCmoferkJ4DrgoK2bY1m2+REfJQMIq1E8wARoLRu1Ucq0fch
         KW8AVDqi6q48jF0cCigWx4G9koByTKk0TO8dXqh6RQKVeUiQ5XlKID3vJ5479apMgKNj
         px0XvIXdo0H2dmHBJRA9CIMQt3MgDbcNsylek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686905008; x=1689497008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDKNwc2spJwBfD2I0zIbFW0EXN11ktfXXRri1gY5Wq4=;
        b=A4ACuJ0cifi/lVYum/naXW027JvAcdEvPZ5JDsfyqRiWwfBgpUzB5Otv7PQ2i/i92P
         PHH6fAD4eiDb2AqtfHI82ZQMo6x1wIYctS2NkWVv9G6NYLK1wHpAeRn2g1vpYKc9IdZA
         +52ap3QxIZmn5SBbm7T4ikyaP0zhqH+Ucx0FuNqzahZxpq0lY/L4tWESGvO9uEa7O0fX
         O6jzkSkTSdQYoZ4u4bzh3NIKvTiYCT4/mLKhWLn7yt6fOc4y+9UWgRIjyUF1h1Diw2p+
         L9YOA0Tcgo5JkH0Hy5FLCWLPgs4U/Biwiop7dUhblJ0qLs7/f13tGW/i3D6PLO/9ANu7
         c7dQ==
X-Gm-Message-State: AC+VfDx0EikpyJUaMpFvknlRuaS5JWMUVyNHza1NykmTW2sJu/HUVtlq
        eR73EDlR7+/MGnI2ijLlGRamz9fZIucRa7pOzOtr
X-Google-Smtp-Source: ACHHUZ588No8rZTW5BgVANgGiSevYvr7PcGyiQIzkpCtRm5EWtTsAu2/r8c06MBm/GyhWVIvHZI+/K/g+jEjYCbGYpk=
X-Received: by 2002:a05:651c:150:b0:2b0:919e:4265 with SMTP id
 c16-20020a05651c015000b002b0919e4265mr362266ljd.21.1686905008073; Fri, 16 Jun
 2023 01:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com> <20230512085321.13259-10-alexghiti@rivosinc.com>
In-Reply-To: <20230512085321.13259-10-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 16 Jun 2023 01:43:16 -0700
Message-ID: <CAOnJCU+n0O9oQmd1Vs3kimaBai7vbaf5RiMRFyvphCCLCGMB1A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] tools: lib: perf: Implement riscv mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 2:03=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> riscv now support mmaping hardware counters so add what's needed to
> take advantage of that in libperf.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 0d1634cedf44..65f250e0ef92 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
>
>  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
>
> +#elif __riscv_xlen =3D=3D 64
> +

This is applicable for RV32 as well. No ?
otherwise, you won't need CSR_CYCLEH

> +#define CSR_CYCLE      0xc00
> +#define CSR_TIME       0xc01
> +#define CSR_CYCLEH     0xc80
> +
> +#define csr_read(csr)                                          \
> +({                                                             \
> +       register unsigned long __v;                             \
> +               __asm__ __volatile__ ("csrr %0, " #csr          \
> +                : "=3Dr" (__v) :                                 \
> +                : "memory");                                   \
> +                __v;                                           \
> +})
> +
> +static unsigned long csr_read_num(int csr_num)
> +{
> +#define switchcase_csr_read(__csr_num, __val)           {\
> +       case __csr_num:                                 \
> +               __val =3D csr_read(__csr_num);            \
> +               break; }
> +#define switchcase_csr_read_2(__csr_num, __val)         {\
> +       switchcase_csr_read(__csr_num + 0, __val)        \
> +       switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)         {\
> +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> +       switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)         {\
> +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> +       switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)        {\
> +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> +       switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)        {\
> +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> +       switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +       unsigned long ret =3D 0;
> +
> +       switch (csr_num) {
> +       switchcase_csr_read_32(CSR_CYCLE, ret)
> +       switchcase_csr_read_32(CSR_CYCLEH, ret)
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +       return csr_read_num(CSR_CYCLE + counter);
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +       return csr_read_num(CSR_TIME);
> +}
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { retu=
rn 0; }
>  static u64 read_timestamp(void) { return 0; }
> --
> 2.37.2
>


--=20
Regards,
Atish
