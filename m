Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42BE6ED3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjDXRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjDXRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:54:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FF76BB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:53:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-518d325b8a2so4916437a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682358833; x=1684950833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A/OOVQszAo19NkFFicWYt7Qdu7ANiP0rHvHX9DAp1s=;
        b=L9d/CQqAZlPwQvaJS5kMoGW+YVSLMPWYH3mzZPHgp7G4xq2ADniyV219TV0jGMdx4q
         MOXc9JFQrqaoisXkrmRCFiydK3x0gZwP0t1Q8Qd4nnQsCIH5uXv13Jl0Su1APVfafTir
         XsK/1DqvhEQfdEzL7iXSCH/lNj+CORS6tPoV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358833; x=1684950833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A/OOVQszAo19NkFFicWYt7Qdu7ANiP0rHvHX9DAp1s=;
        b=FsS45praxVmaSmjCcSXia1DbDmdhOjfxfJNAmDIpKlg418SzsEwapHlQ5Xq0HOXUlB
         4DkdkpcZ4kUSduaLpvNT3HdI9vb2oZ5VIrvxSeQFfiHzszg1SS3U6Mjhrf2muIKFSY32
         M0ugQ2F06C4dKuSxKSiq9plZdWIVbFGwLAJUpDroU879WGNGybaPmhFZSMGS+8YsokBA
         W1xYnptxOGy8qWV0O5GSVqDkYPKdvheyfNW8i3lJWub//aly9+x/rQN2F6vSQ4e7dx9B
         oQEbIyASeduifJEEaVg2U585GGwrunSV3f2OIP1TKBjC/pBii76zeYg7jYD2qdZnS1JH
         hmcA==
X-Gm-Message-State: AAQBX9eSy6Q6sJBgaNw0BNoU7ulmzp1qNoFCxfcluA0+No/cPQ79zWS3
        +xsdAQjrPoZ3ccNaoK+qKbnU61cyVjOlslXCHCA=
X-Google-Smtp-Source: AKy350YcdlZeDM3Byt1erUAXHV5O87QNkRHjpcpstGZuPelFk7gfeqvIo6ZU8LCifrOEeoZqMT3V6g==
X-Received: by 2002:a17:90a:a381:b0:247:35f8:81d2 with SMTP id x1-20020a17090aa38100b0024735f881d2mr14907685pjp.29.1682358833476;
        Mon, 24 Apr 2023 10:53:53 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b0024721450664sm8486700pjb.41.2023.04.24.10.53.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 10:53:53 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1a6e5be6224so704885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:53:52 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bcd:b0:315:8e3a:f546 with SMTP id
 x13-20020a056e021bcd00b003158e3af546mr23458ilv.6.1682358812275; Mon, 24 Apr
 2023 10:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.3.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
In-Reply-To: <20230419155341.v8.3.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 10:53:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWkott-nuPtV56PGGJdaYqSK5zf_DLGjG_AzGb9vHAoA@mail.gmail.com>
Message-ID: <CAD=FV=WWkott-nuPtV56PGGJdaYqSK5zf_DLGjG_AzGb9vHAoA@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] arm64: smp: Assign and setup an IPI as NMI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> From: Sumit Garg <sumit.garg@linaro.org>
>
> Assign an unused IPI which can be turned as NMI using ipi_nmi framework.
> Also, invoke corresponding dynamic IPI setup/teardown APIs.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Tested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v8:
> - dynamic_ipi_setup() and dynamic_ipi_teardown() no longer take cpu param
>
>  arch/arm64/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4e8327264255..94ff063527c6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -43,6 +43,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nmi.h>
>  #include <asm/numa.h>
>  #include <asm/processor.h>
>  #include <asm/smp_plat.h>
> @@ -938,6 +939,8 @@ static void ipi_setup(int cpu)
>
>         for (i =3D 0; i < nr_ipi; i++)
>                 enable_percpu_irq(ipi_irq_base + i, 0);
> +
> +       dynamic_ipi_setup();
>  }
>
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -950,6 +953,8 @@ static void ipi_teardown(int cpu)
>
>         for (i =3D 0; i < nr_ipi; i++)
>                 disable_percpu_irq(ipi_irq_base + i);
> +
> +       dynamic_ipi_teardown();
>  }
>  #endif
>
> @@ -971,6 +976,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>                 irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>         }
>
> +       if (n > nr_ipi)
> +               set_smp_dynamic_ipi(ipi_base + nr_ipi);

From thinking about this patch more, I'm guessing that the biggest
objection someone could have is that this uses up the "last" IPI slot
in any systems that are stuck with only 8. Is that the reason that
this patch series stagnated in the past, or was it something else?

If this is truly the concern that people have, it doesn't look like it
would be terribly hard to combine the existing IPI_CPU_STOP and
IPI_CPU_CRASH_STOP. Presumably we could just get rid of the "crash
stop" IPI and have the normal "stop" IPI do the crash if
"waiting_for_crash_ipi" is non-zero. If that's the thing blocking the
series from moving forward then I can add that to the series, or we
could just wait until someone actually needs another IPI. ;-)

-Doug
