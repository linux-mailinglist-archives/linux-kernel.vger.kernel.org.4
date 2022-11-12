Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E56267C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiKLHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKLHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:46:51 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06C4732B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:46:50 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso7609522fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q63GJUSuDThP3uhtQba7IfspRKrI38ddEA7KDeMNEBs=;
        b=OU6VbUzxoJagZDCAhkjPlwn+dxRYKXSdHS3bm8UzVpdr8cEmzHxPs09JjfkImTKJN+
         XFcsoC1FAX6ofpuAHdIai45gSdgIofR2A/1UQpByFY1wXPa4AWDTqWtrHBXOwNIQ1hKB
         M58koGCywJ5peiq0aXvLGnIuwgNYfX2ec3S90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q63GJUSuDThP3uhtQba7IfspRKrI38ddEA7KDeMNEBs=;
        b=h8sFxGqzJElwfuBxq2eSdrd3FOqmCg72tDiS1LoK0Ll7oY5Y/gYG5ZV0Jte7XIQCwa
         bMkaD8qfwX1k3bZjKUwJL9JyyWyJl///j7DaF0nSjEpJdHAoNfRI7Pz7nlZd+G+WVDG+
         fV2E5x0gJ5TnMMzhkiC6MPZiRZKfzWcta34EOKxm4L8GDV8m493qwXNw1T7daMna9YwM
         3ngYRHyLVylAtppvexm1UoIw1bDNmLFWvY67vDfBka85RN65jfZbVfvn5mxY+/Y5RpmY
         T0SI52z0J4BjFz8rpmX7suF7vcns9dNHLBt/aNTEVnQ12El07jH4HSuiyqNVmc25wqys
         dcDg==
X-Gm-Message-State: ANoB5pk5xPFavJqPiKvw1mVe+FOyt9AKW3CU+5LW47mgFqxwlKowmPXs
        RA/ykCms1kKHZAuS45jflQqrAGfGFea6l/6zutaf
X-Google-Smtp-Source: AA0mqf5UZ4i28VsBcXzC38GqHTvV3wPQq6gV4LbNJlcIfzZ/TtpvLnkdm9eKU7eM+H6GimyjKU6Bf9PqVPrLqR+IgVU=
X-Received: by 2002:a05:6870:518:b0:13b:be90:a68a with SMTP id
 j24-20020a056870051800b0013bbe90a68amr2736045oao.181.1668239209389; Fri, 11
 Nov 2022 23:46:49 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUK5Z6i39f5MJaRFhorGjcmBR=p_MapY_TDcR1e274wtpA@mail.gmail.com>
 <mhng-76ad1ec7-7ad6-4223-9e6f-321ac56d6dee@palmer-ri-x1c9a>
In-Reply-To: <mhng-76ad1ec7-7ad6-4223-9e6f-321ac56d6dee@palmer-ri-x1c9a>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 11 Nov 2022 23:46:38 -0800
Message-ID: <CAOnJCUKKqJmJXvebn=12NciDe7iw016jpN6me-ZCH=50cCm+hg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Do not issue remote fences until smp is available
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        anup@brainfault.org, damien.lemoal@wdc.com,
        devicetree@vger.kernel.org, jszhang@kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 1:42 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 31 Oct 2022 12:26:05 PDT (-0700), atishp@atishpatra.org wrote:
> > On Mon, Oct 31, 2022 at 12:12 PM Conor Dooley <conor@kernel.org> wrote:
> >>
> >> On Fri, Oct 28, 2022 at 04:19:29PM -0700, Atish Patra wrote:
> >> > It is useless to issue remote fences if there is a single core
> >> > available. It becomes a bottleneck for sbi based rfences where
> >> > we will be making those ECALLs for no reason. Early code patching
> >> > because of static calls end up in this path.
> >> >
> >> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>
> >> Hey Atish,
> >> This doesn't apply for me to either fixes or for-next. What branch does
> >> it apply to?
> >> Thanks,
> >> Conor.
> >>
> >> > ---
> >> >  arch/riscv/mm/cacheflush.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> >> > index f10cb47eac3a..7fafc8c26505 100644
> >> > --- a/arch/riscv/mm/cacheflush.c
> >> > +++ b/arch/riscv/mm/cacheflush.c
> >> > @@ -19,6 +19,10 @@ void flush_icache_all(void)
> >> >  {
> >> >       local_flush_icache_all();
> >> >
> >> > +     /* No need to issue remote fence if only 1 cpu is online */
> >> > +     if (num_online_cpus() == 1)
> >> > +             return;
> >> > +
> >> >       if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> >> >               sbi_remote_fence_i(NULL);
> >> >       else
> >> > --
> >> > 2.34.1
> >> >
> >
> > Sorry I forgot to specify the dependencies for this patch. This patch
> > is based on Anup's IPI series [1] as
> > I assumed the IPI series would go first. I can rebase on top of the
> > master if required.
> > However, the issue will manifest only after Jisheng's patch[2] which
> > moved the sbi_init to earlier and introduced the
> > static key in the paging_init path.
> >
> > [1] https://patchwork.kernel.org/project/linux-riscv/patch/20220820065446.389788-8-apatel@ventanamicro.com/
> > [2] https://lore.kernel.org/lkml/20220716115059.3509-1-jszhang@kernel.org/
>
> IMO we should just stop issuing the SBI remote fences at all, with the
> code to do IPI-based fences we're just adding complexity for the slow
> case.

Sure. We can do that too. However, that will have some performance
impact for any platform(existing and future ones) without imsic.

Is that acceptable ? Maybe it will encourage every vendor to implement
AIA instead of PLIC ;)

--
Regards,
Atish
