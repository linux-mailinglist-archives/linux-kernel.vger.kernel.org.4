Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50995B3443
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIIJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiIIJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:43:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B5D5737;
        Fri,  9 Sep 2022 02:43:15 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3450990b0aeso12396037b3.12;
        Fri, 09 Sep 2022 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CjOr/xVdCatVWvrfBKrHvrf5/qwfqa22a/dV5JbB6Ns=;
        b=Wdb6x0hGfcz3f+ab9h93qPN15RUgQQOKVi2aFt+pDNe0fL0DvMs6qxRm/afiQ0zHms
         GuHo+QHZDfWCwP3x5Nhw2KtErCDmCFGD+Ev7WiFgzoU/lsin2IQViX0UW9n5lMSDAwxy
         Cc/xODhSz68S8kGpdq8vfRyxiYl+0hmK36cqqJt4K+oPIrs7/7flOmqVlzaq4x0fOeOR
         2ZiFyzHdxqeYxvn/Lspa9cikJuXK91RfxdLAnT9+cFw5YJkBN3ApsZyCxfNct7Tto7/d
         q3dFPx4BWvjN1uF+rGiWafmwO26m1yV7vi02ykBoH6Ox9jwdr+mW2/A+VZz3/WP7PmHj
         BwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CjOr/xVdCatVWvrfBKrHvrf5/qwfqa22a/dV5JbB6Ns=;
        b=MixkcJoKx4xjNN6MAIEAC2jseRhx35h14ZYHEE7v0AmOsA8poYcPw9zVtDBkQlk+k5
         18JP6SuAmbTcxfygvMCvWYp0XgdIaBBlGrV7v53awjmx3Kv5xsHRz4fOCb3BLhMRBL5M
         is5uD48Ug6cAUHanMgIYwCLmObzbbrfXaCoyp+Ga037zD7vi6Ha3+2nUngmckJVMKcJA
         6gFcW74XFx39NLEEqNsF7OnKPD20Gvi7qONtcHJLH2UWIT1OUyllCg7H6H9F2LnwgpP/
         1EGGTmn2xO61Z5Pp5THuBcFHq6Jmp+JbZ9XOBaNqFCSfDCtEpvEGhG8ZhdK+hdNtiewC
         RZRQ==
X-Gm-Message-State: ACgBeo1GiHvS2QeKbXXHUt0SPJzhnc+CEV7h+qcrfi3xBN9Ex+qBO6oP
        rzwuw6hXaZXMt9Wt0V+l4qbWgoubrmZlp1CzxsjGDykh07s=
X-Google-Smtp-Source: AA6agR6rVJh6TPlfqtSjbFfxwPrDCj6n15t/wcCkrItZvLKXf3DDre4zvFAl//4/COVWHFsukMwmkRQPTc4zgSco0pI=
X-Received: by 2002:a0d:f701:0:b0:32a:17d3:d189 with SMTP id
 h1-20020a0df701000000b0032a17d3d189mr11100556ywf.401.1662716594449; Fri, 09
 Sep 2022 02:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085505.15536-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220909085505.15536-1-lukas.bulwahn@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 9 Sep 2022 11:43:03 +0200
Message-ID: <CAKXUXMzuwzE4bSmq7okPo3Y2h6q_83NeERm8P9yQ1i393vyNBg@mail.gmail.com>
Subject: Re: [PATCH] ppc: select HAVE_PATA_PLATFORM in PPC instead of creating
 a PPC dependency
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 10:55 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit cc18e0fea790 ("LIBATA: Add HAVE_PATA_PLATFORM to select
> PATA_PLATFORM driver") introduces config HAVE_PATA_PLATFORM, and expects
> that all architectures simply select this config when the architecture
> supports using the PATA_PLATFORM driver.
>
> This is properly implemented already for all architectures except for the
> powerpc architecture. Implement this for powerpc now.
>
> Adjust the config of the powerpc architecture to use the config
> HAVE_PATA_PLATFORM and simplify the config PATA_PLATFORM to not mention
> any specific architecture anymore.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Please ignore this patch and pick:

https://lore.kernel.org/linuxppc-dev/20220909090343.21886-1-lukas.bulwahn@gmail.com/

Lukas

> ---
>  arch/powerpc/Kconfig | 1 +
>  drivers/ata/Kconfig  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 39d71d7701bd..2575e21b6e6b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -237,6 +237,7 @@ config PPC
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI                         if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
>         select HAVE_OPTPROBES
> +       select HAVE_PATA_PLATFORM
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_EVENTS_NMI             if PPC64
>         select HAVE_PERF_REGS
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 1c9f4fb2595d..ed3547165528 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1103,7 +1103,7 @@ config PATA_PCMCIA
>
>  config PATA_PLATFORM
>         tristate "Generic platform device PATA support"
> -       depends on EXPERT || PPC || HAVE_PATA_PLATFORM
> +       depends on EXPERT || HAVE_PATA_PLATFORM
>         help
>           This option enables support for generic directly connected ATA
>           devices commonly found on embedded systems.
> --
> 2.17.1
>
