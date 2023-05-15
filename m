Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB6703683
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjEORKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbjEORKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:10:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1D8A4A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:08:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f51ea3a062so274601cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684170522; x=1686762522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIbiC9cj1KePtZOLrlHrem/cf+4Waru7tYANSEf3zjI=;
        b=N8IrDzI5ZGRsisNrr9sIk+XW0ISmpfoBX6AaCzpTqtmxyhstN2XfPsjic0itZ4ylX0
         35Lo+m/iPby2FFDhgACMEZMxP1scGCdWfXORelYfz0PcnsRqbLp16i6p3cr745OKoc4D
         lInm5XbC/d+AFJXIVyN/VIdqUrokqaLJ+rgtFrwYmw5ghQ4/mtbc8dU0c+j7wzqNVtNk
         0c7ka/3Lc2HG1C9k6sMVL1njZnttQz9ERXCBDcZnet00CHLb2cjuo4GAJnDOPY9XRJEb
         7mWDa12fJuwus3//CAwyHBUW+QWAzkFx7ATYXfCzTiqCNiCXXeZHpw1TBBGajQx+ONPO
         3biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170522; x=1686762522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIbiC9cj1KePtZOLrlHrem/cf+4Waru7tYANSEf3zjI=;
        b=e7h/nZlDGokHwas8hvaidK6L7tLputnGoCvB+9BANGJc5nVYiQg/xbXhImpHvaCqPY
         +rwobeNOcldQJaJEi0+HpEwkPcclTEwIMGFI+2EQ7wKfzj/pSvkUQN3UCcQCQk7F+ZDB
         cvrg5Uisi8UCiusGEaY8ITEdu02dxsotHXnVZiTjajvRfEv8hL80bTJGB7tYIGMexhMI
         dtL417uKfYj0fHvlB7ZWcbrEda7fVs3z/HuXL7Vowb41seY+2YjO2Ihxtq3vCfV7ELYr
         7+eoD9pcS09Qyw319aiJizVQ3HI7L0Qi+WPo/aMm0Xy9D+1av9qkoWBbYx1m3Rdm34IZ
         yBhQ==
X-Gm-Message-State: AC+VfDyrYZ2KeVC+uSVsHDhMZFOtR2a7rPSfCcpUKJn3C0Icp3cHPCzl
        LyBKUhJ7wdzPofCGMk5CLoGK8YsT/Odno2pclPv19g==
X-Google-Smtp-Source: ACHHUZ4uVrEjbBmgaeLWyKN5WpJiG48pgOSBDd+qbzglXLF7mkTVLPk7deTZ5RU89OyoX80z6v51FnHSEnNrwGj07Lo=
X-Received: by 2002:ac8:5dd1:0:b0:3ef:3083:a437 with SMTP id
 e17-20020ac85dd1000000b003ef3083a437mr1253088qtx.18.1684170522372; Mon, 15
 May 2023 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230511062725.514752-1-namhyung@kernel.org>
In-Reply-To: <20230511062725.514752-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 10:08:31 -0700
Message-ID: <CAP-5=fVkLpcyuEjay_VUq9+K7nFRKPTCYr6SH-VBcrSfkKUoYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf annotate: Handle more instructions on x86
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
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

On Wed, May 10, 2023 at 11:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> I found some instructions didn't parse the operands properly.
> Add them to the table to fix the issue.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/annotate/instructions.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arc=
h/x86/annotate/instructions.c
> index 305872692bfd..5c7bec25fee4 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -35,12 +35,14 @@ static struct ins x86__instructions[] =3D {
>         { .name =3D "cs",         .ops =3D &mov_ops,  },
>         { .name =3D "dec",        .ops =3D &dec_ops,  },
>         { .name =3D "decl",       .ops =3D &dec_ops,  },
> +       { .name =3D "decq",       .ops =3D &dec_ops,  },
>         { .name =3D "divsd",      .ops =3D &mov_ops,  },
>         { .name =3D "divss",      .ops =3D &mov_ops,  },
>         { .name =3D "gs",         .ops =3D &mov_ops,  },
>         { .name =3D "imul",       .ops =3D &mov_ops,  },
>         { .name =3D "inc",        .ops =3D &dec_ops,  },
>         { .name =3D "incl",       .ops =3D &dec_ops,  },
> +       { .name =3D "incq",       .ops =3D &dec_ops,  },
>         { .name =3D "ja",         .ops =3D &jump_ops, },
>         { .name =3D "jae",        .ops =3D &jump_ops, },
>         { .name =3D "jb",         .ops =3D &jump_ops, },
> @@ -123,6 +125,8 @@ static struct ins x86__instructions[] =3D {
>         { .name =3D "test",       .ops =3D &mov_ops,  },
>         { .name =3D "testb",      .ops =3D &mov_ops,  },
>         { .name =3D "testl",      .ops =3D &mov_ops,  },
> +       { .name =3D "testq",      .ops =3D &mov_ops,  },
> +       { .name =3D "tzcnt",      .ops =3D &mov_ops,  },
>         { .name =3D "ucomisd",    .ops =3D &mov_ops,  },
>         { .name =3D "ucomiss",    .ops =3D &mov_ops,  },
>         { .name =3D "vaddsd",     .ops =3D &mov_ops,  },
> --
> 2.40.1.521.gf1e218fcd8-goog
>
