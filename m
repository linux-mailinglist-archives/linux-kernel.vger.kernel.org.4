Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D06E70C4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjEVSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEVSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:08:27 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8F102
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:08:25 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-335d6260e9bso17355ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684778904; x=1687370904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R88eZc6oRVIgdx43aldgqdN8vD6BmciC13RfWJDcM8=;
        b=MeZhfbAX3wjHPwFpHjyCnGZfGpJwdVVOLymYYvYsr6qMjNCVLvxZvJZj+cWzcrSpW1
         yPmX6Jk42C6euQvWs8H5BmHFga8WV1Bs6KUaLzq8n3U4nr7OWhVNMWXrur2KzEYHxcGg
         djHps3MCzWKVB/0R7pWm4Cy+28shlNeU+Pg8c9Ys603VKsB4lcB/liQSh/TJ1Rz9WItd
         cCjRpj5l9i6I8zhqSfq9WaVIvr++RSiP+eP1YcQoEd35LotX9AKeppKk2DhJBuQn/A06
         jIR2afm482lwdSfjXTU0li6RVRS3D/IXmFpN6ISfu6Z0fHs3+QOZjjV7I1BU59zOQdjm
         OK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684778904; x=1687370904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R88eZc6oRVIgdx43aldgqdN8vD6BmciC13RfWJDcM8=;
        b=OqBL7qWZVAtcXAzBLLr7PtOIGrL/g09S7EWbXQX1p1tjMpRKn8RXHsYPhAVNTmPUOB
         668BSNTS23cfWcpxv89Y1vb/Enfgn6n1/sxLlqWU8kdmV6YhAhj9kGSNg+AXjXXy37rp
         ZQjrA7ZL/O1GAsn7tWBWIwwZNxro6TIJNrO7eC4X6ZYrWKNuE6l/g1jn7Oz9Ta7UVHIi
         2WSpae3qoa46ROQN2xqROw9ZOU3qTrV/SYRFBNFNaM35OaEHTT4HPMtbx0Sta4xYl+J6
         /6fNQnQkbBze6JZM2TQZcYmsfg5+WPDswlMn7NfM1bPocR3kDxSSSC/SkINjwUQg26rT
         /S9A==
X-Gm-Message-State: AC+VfDyeJKygXF/8a5Xafj5kP5jhvzmq/wg59Hlq2ZhbCiNC1Nc499um
        0iv3DKr9VA7vNXsDcJYgIXjN2KSRBMPLzpDJVEphlw==
X-Google-Smtp-Source: ACHHUZ4pgighc0mqTBnWFVC/0BRYcKKJlRuZ99VM2ibXd+FdoPBoIYO0OO9OPCQ4KWSJZd/dKGwS9c0MAvhjcoIVDVk=
X-Received: by 2002:a92:c562:0:b0:335:5c4b:2f8a with SMTP id
 b2-20020a92c562000000b003355c4b2f8amr975152ilj.5.1684778904498; Mon, 22 May
 2023 11:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230520025537.1811986-1-leo.yan@linaro.org> <20230520025537.1811986-3-leo.yan@linaro.org>
In-Reply-To: <20230520025537.1811986-3-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 22 May 2023 11:08:12 -0700
Message-ID: <CAP-5=fU-+8Sdw0tfQNYN40tXanrzUgqv0=6jsHqGR9cgjkQa2A@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] perf parse-regs: Introduce functions arch__reg_{ip|sp}()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qi Liu <liuqi115@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Fri, May 19, 2023 at 7:56=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote:
>
> Ideally, we want util/perf_regs.c to be general enough and doesn't bind
> with specific architecture.
>
> But since util/perf_regs.c uses the macros PERF_REG_IP and PERF_REG_SP
> which are defined by architecture, thus util/perf_regs.c is dependent on
> architecture header (see util/perf_regs.h includes "<perf_regs.h>", here
> perf_regs.h is architecture specific header).
>
> As a step to generalize util/perf_regs.c, this commit introduces weak
> functions arch__reg_ip() and arch__reg_sp() and every architecture can
> define their own functions; thus, util/perf_regs.c doesn't need to use
> PERF_REG_IP and PERF_REG_SP anymore.
>
> This is a preparation to get rid of architecture specific header from
> util/perf_regs.h.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm/util/perf_regs.c     | 10 ++++++++++
>  tools/perf/arch/arm64/util/perf_regs.c   | 10 ++++++++++
>  tools/perf/arch/csky/util/perf_regs.c    | 10 ++++++++++
>  tools/perf/arch/mips/util/perf_regs.c    | 10 ++++++++++
>  tools/perf/arch/powerpc/util/perf_regs.c | 10 ++++++++++
>  tools/perf/arch/riscv/util/perf_regs.c   | 10 ++++++++++
>  tools/perf/arch/s390/util/perf_regs.c    | 10 ++++++++++
>  tools/perf/arch/x86/util/perf_regs.c     | 10 ++++++++++
>  tools/perf/util/perf_regs.c              | 10 ++++++++++
>  tools/perf/util/perf_regs.h              |  4 +++-
>  tools/perf/util/unwind-libdw.c           |  2 +-
>  tools/perf/util/unwind.h                 |  4 ++--
>  12 files changed, 96 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/u=
til/perf_regs.c
> index 2833e101a7c6..37aa3a2091bd 100644
> --- a/tools/perf/arch/arm/util/perf_regs.c
> +++ b/tools/perf/arch/arm/util/perf_regs.c
> @@ -4,3 +4,13 @@
>  const struct sample_reg sample_reg_masks[] =3D {
>         SMPL_REG_END
>  };
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_ARM_PC;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_ARM_SP;
> +}
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm=
64/util/perf_regs.c
> index 006692c9b040..dbe7f00b222b 100644
> --- a/tools/perf/arch/arm64/util/perf_regs.c
> +++ b/tools/perf/arch/arm64/util/perf_regs.c
> @@ -169,3 +169,13 @@ uint64_t arch__user_reg_mask(void)
>         }
>         return PERF_REGS_MASK;
>  }
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_ARM64_PC;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_ARM64_SP;
> +}
> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky=
/util/perf_regs.c
> index 2864e2e3776d..d230d7e640fd 100644
> --- a/tools/perf/arch/csky/util/perf_regs.c
> +++ b/tools/perf/arch/csky/util/perf_regs.c
> @@ -4,3 +4,13 @@
>  const struct sample_reg sample_reg_masks[] =3D {
>         SMPL_REG_END
>  };
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_CSKY_PC;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_CSKY_SP;
> +}
> diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips=
/util/perf_regs.c
> index 2864e2e3776d..64882ebc9287 100644
> --- a/tools/perf/arch/mips/util/perf_regs.c
> +++ b/tools/perf/arch/mips/util/perf_regs.c
> @@ -4,3 +4,13 @@
>  const struct sample_reg sample_reg_masks[] =3D {
>         SMPL_REG_END
>  };
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_MIPS_PC;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_MIPS_R29;
> +}
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/p=
owerpc/util/perf_regs.c
> index 8d07a78e742a..c84cd79986a8 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -226,3 +226,13 @@ uint64_t arch__intr_reg_mask(void)
>         }
>         return mask;
>  }
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_POWERPC_NIP;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_POWERPC_R1;
> +}
> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/ris=
cv/util/perf_regs.c
> index 2864e2e3776d..13bbddd139d0 100644
> --- a/tools/perf/arch/riscv/util/perf_regs.c
> +++ b/tools/perf/arch/riscv/util/perf_regs.c
> @@ -4,3 +4,13 @@
>  const struct sample_reg sample_reg_masks[] =3D {
>         SMPL_REG_END
>  };
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_RISCV_PC;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_RISCV_SP;
> +}
> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390=
/util/perf_regs.c
> index 2864e2e3776d..9b2297471090 100644
> --- a/tools/perf/arch/s390/util/perf_regs.c
> +++ b/tools/perf/arch/s390/util/perf_regs.c
> @@ -4,3 +4,13 @@
>  const struct sample_reg sample_reg_masks[] =3D {
>         SMPL_REG_END
>  };
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_S390_PC;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_S390_R15;
> +}
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/u=
til/perf_regs.c
> index 0ed177991ad0..c752a6e9cba6 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -312,3 +312,13 @@ uint64_t arch__intr_reg_mask(void)
>
>         return PERF_REGS_MASK;
>  }
> +
> +uint64_t arch__reg_ip(void)
> +{
> +       return PERF_REG_X86_IP;
> +}
> +
> +uint64_t arch__reg_sp(void)
> +{
> +       return PERF_REG_X86_SP;
> +}
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 8720ec6cf147..334c9a2b785d 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -20,6 +20,16 @@ uint64_t __weak arch__user_reg_mask(void)
>         return PERF_REGS_MASK;
>  }
>
> +uint64_t __weak arch__reg_ip(void)
> +{
> +       return 0;
> +}
> +
> +uint64_t __weak arch__reg_sp(void)
> +{
> +       return 0;
> +}
> +

Is there a need for the weak function if there is a definition for
every architecture? A problem with weak definitions is that they are
not part of the C standard, so strange things can happen such as
inlining - although I think this code is safe. Not having the weak
functions means that if someone tries to bring up a new architecture
they will get linker failures until they add the definitions. Failing
to link seems better than silently succeeding but then having to track
down runtime failures because these functions are returning 0.

Thanks,
Ian

>  #ifdef HAVE_PERF_REGS_SUPPORT
>
>  const char *perf_reg_name(int id, const char *arch)
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index ab4ec3f2a170..0a1460aaad37 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -26,13 +26,15 @@ enum {
>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>  uint64_t arch__intr_reg_mask(void);
>  uint64_t arch__user_reg_mask(void);
> +uint64_t arch__reg_ip(void);
> +uint64_t arch__reg_sp(void);
>
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  extern const struct sample_reg sample_reg_masks[];
>
>  #include <perf_regs.h>
>
> -#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP=
))
> +#define DWARF_MINIMAL_REGS ((1ULL << arch__reg_ip()) | (1ULL << arch__re=
g_sp()))
>
>  const char *perf_reg_name(int id, const char *arch);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index bdccfc511b7e..f308f2ea512b 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -252,7 +252,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>         if (!ui->dwfl)
>                 goto out;
>
> -       err =3D perf_reg_value(&ip, &data->user_regs, PERF_REG_IP);
> +       err =3D perf_reg_value(&ip, &data->user_regs, arch__reg_ip());
>         if (err)
>                 goto out;
>
> diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
> index b2a03fa5289b..0a98ea9d8c94 100644
> --- a/tools/perf/util/unwind.h
> +++ b/tools/perf/util/unwind.h
> @@ -43,11 +43,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>  #endif
>
>  #ifndef LIBUNWIND__ARCH_REG_SP
> -#define LIBUNWIND__ARCH_REG_SP PERF_REG_SP
> +#define LIBUNWIND__ARCH_REG_SP arch__reg_sp()
>  #endif
>
>  #ifndef LIBUNWIND__ARCH_REG_IP
> -#define LIBUNWIND__ARCH_REG_IP PERF_REG_IP
> +#define LIBUNWIND__ARCH_REG_IP arch__reg_ip()
>  #endif
>
>  int LIBUNWIND__ARCH_REG_ID(int regnum);
> --
> 2.39.2
>
