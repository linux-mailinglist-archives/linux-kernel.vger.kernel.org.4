Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C26B6382
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 07:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCLG2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 01:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLG16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 01:27:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72E269A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 22:27:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r29so542890wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 22:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678602473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtv29KZX+XREe9cWzAMxT6V39t/L1NQeIC8ivHVuqS4=;
        b=o0/NYospeBO1+8cuP+NfwBHbLPcnYfw49cgYl3XTC5Ix9P6eV9x6V1BRXB92AePhzQ
         Xda0Eq54Oegsxn//6fhRY9YjbX9yCJ7g6vef56+Zl7ua5XAV+e3b/aWVTtgZZik5bBEc
         MXON0IdN9LwL9sevao0AitDnR2cTNtRkdOqYwR42RhK1GZiqOF4ZqSL01Mv42QaWl0P0
         1ypy2zSoVNkALt0IXZOgIVRVklSOQxbgNlaVpqIypfh9HkMv2mz8gxas5DaNrXMPgmnR
         QpeCZRPN9apuoktC8SI4zqi4UO15X+smd7H9PBd23iPa9w4keLmPvSImc9cB4t5DJDVs
         UU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678602473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtv29KZX+XREe9cWzAMxT6V39t/L1NQeIC8ivHVuqS4=;
        b=2lRYVxO5rhb4cc60ZWhH8/VOX7QSQM1K+/5VkeuS8pbijq0K1SWs0jvK+PE96SuBTG
         uUTrYnto2AGEjwNqZFKIT/hY/P39r3qm3521InxqzTBa+stmidvAE4KunycFLaTnI2Ih
         W+cE+xzGco9qzFyezOcO0ggeS3NZWzx5R8YQtTwVHvgKnNeCG0kiYOMG8SGa56Pevxr/
         lOiZZImrrgPIKPfyNb6EeT1kLsdD+vsyeuBhFLAcd0QsbqeS1r5B2N90SbC8dAzZNwAi
         veaf5x21T44kVDDw5UhQToee/9HW9oBgLqj3xdc5FA0GBI3iAIYe8wQIMcYFyQMAHHZj
         PVRA==
X-Gm-Message-State: AO0yUKVPa372D2Pm8Q3EyFavEv011YNmaTemRNL15RSlIIzIwtt3+4bC
        URYLE0NLFVU9awh1eKjZ2IpOkCXU3rtE5jhOY/lrEA==
X-Google-Smtp-Source: AK7set/W089nZRtqvQkaqo5MGXF43OWcIyaszLy3QrT1jn4BQxabvW3adNuV27z4WnO5yFKbt6/MdgsapvUuEkuPeEM=
X-Received: by 2002:adf:f189:0:b0:2ce:aaff:2a8c with SMTP id
 h9-20020adff189000000b002ceaaff2a8cmr151156wro.14.1678602473299; Sat, 11 Mar
 2023 22:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20230311112122.28894-1-p4ranlee@gmail.com>
In-Reply-To: <20230311112122.28894-1-p4ranlee@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 11 Mar 2023 22:27:41 -0800
Message-ID: <CAP-5=fWkAqX+Uy_XhXHjEx6sj-wpOJ+WQf=vMtRzRBS-0Kj32Q@mail.gmail.com>
Subject: Re: [PATCH] perf tools riscv: Add support for riscv lookup_binutils_path
To:     paranlee <p4ranlee@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Sat, Mar 11, 2023 at 3:22=E2=80=AFAM paranlee <p4ranlee@gmail.com> wrote=
:
>
> Add to know RISC-V binutils path.
> Secondarily, edit the code block with alphabetical order.
>
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> ---
>  tools/perf/arch/common.c | 51 +++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 59dd875fd5e4..058527ededdd 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -29,11 +29,23 @@ const char *const arm_triplets[] =3D {
>  };
>
>  const char *const arm64_triplets[] =3D {
> +       "aarch64-unknown-linux-",

Modifying ARM64 behavior should be a separate change.

>         "aarch64-linux-android-",
>         "aarch64-linux-gnu-",
>         NULL
>  };
>
> +const char *const mips_triplets[] =3D {
> +       "mips-unknown-linux-gnu-",
> +       "mipsel-linux-android-",
> +       "mips-linux-gnu-",
> +       "mips64-linux-gnu-",
> +       "mips64el-linux-gnuabi64-",
> +       "mips64-linux-gnuabi64-",
> +       "mipsel-linux-gnu-",
> +       NULL
> +};
> +

This will affect the blame history. It should probably be its own change to=
o.

>  const char *const powerpc_triplets[] =3D {
>         "powerpc-unknown-linux-gnu-",
>         "powerpc-linux-gnu-",
> @@ -43,6 +55,20 @@ const char *const powerpc_triplets[] =3D {
>         NULL
>  };
>
> +const char *const riscv32_triplets[] =3D {
> +       "riscv32-unknown-linux-gnu-",
> +       "riscv32-linux-android-",
> +       "riscv32-linux-gnu-",
> +       NULL
> +};
> +
> +const char *const riscv64_triplets[] =3D {
> +       "riscv64-unknown-linux-gnu-",
> +       "riscv64-linux-android-",
> +       "riscv64-linux-gnu-",
> +       NULL
> +};
> +
>  const char *const s390_triplets[] =3D {
>         "s390-ibm-linux-",
>         "s390x-linux-gnu-",
> @@ -78,17 +104,6 @@ const char *const x86_triplets[] =3D {
>         NULL
>  };
>
> -const char *const mips_triplets[] =3D {
> -       "mips-unknown-linux-gnu-",
> -       "mipsel-linux-android-",
> -       "mips-linux-gnu-",
> -       "mips64-linux-gnu-",
> -       "mips64el-linux-gnuabi64-",
> -       "mips64-linux-gnuabi64-",
> -       "mipsel-linux-gnu-",
> -       NULL
> -};
> -
>  static bool lookup_path(char *name)
>  {
>         bool found =3D false;
> @@ -164,18 +179,22 @@ static int perf_env__lookup_binutils_path(struct pe=
rf_env *env,
>                 path_list =3D arm_triplets;
>         else if (!strcmp(arch, "arm64"))
>                 path_list =3D arm64_triplets;
> +       else if (!strcmp(arch, "mips"))
> +               path_list =3D mips_triplets;
>         else if (!strcmp(arch, "powerpc"))
>                 path_list =3D powerpc_triplets;
> -       else if (!strcmp(arch, "sh"))
> -               path_list =3D sh_triplets;
> +       else if (!strcmp(arch, "riscv32"))
> +               path_list =3D riscv32_triplets;
> +       else if (!strcmp(arch, "riscv64"))
> +               path_list =3D riscv64_triplets;
>         else if (!strcmp(arch, "s390"))
> -               path_list =3D s390_triplets;
> +               path_list =3D s390_triplets;

whitespace issue?

> +       else if (!strcmp(arch, "sh"))
> +               path_list =3D sh_triplets;
>         else if (!strcmp(arch, "sparc"))
>                 path_list =3D sparc_triplets;
>         else if (!strcmp(arch, "x86"))
>                 path_list =3D x86_triplets;
> -       else if (!strcmp(arch, "mips"))
> -               path_list =3D mips_triplets;
>         else {
>                 ui__error("binutils for %s not supported.\n", arch);
>                 goto out_error;

I think in general we need to revamp this code. Two things that I see
that are missing are (1) support for perf config and (2) addr2line
should be configurable, you may want llvm-addr2line. Adding RISC-V is
of course important too :-)

Thanks,
Ian

> --
> 2.34.1
>
