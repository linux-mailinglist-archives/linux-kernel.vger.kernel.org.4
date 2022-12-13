Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6564BB72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiLMR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiLMR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:58:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC41F62F;
        Tue, 13 Dec 2022 09:57:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c66so18873583edf.5;
        Tue, 13 Dec 2022 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f74flBhltkIF6Kyzm1psBFvXaiR1ZpsFYBiux/pnBP0=;
        b=h5saAjMhrH0HxaWeXItI+PASmkeSYJ2PQdO9BLbEOFZMfii8fwzQnWRsbK/4SKxc7s
         rD4KG/Q1ZPION2xh25FfyL8e0ZB2Qd2fzVMGloq3ccKc3fh7BhotnxOssEIU6NXTOmPw
         Ed0iTBqXWx2VVGJY2IcdbQFnpw0qfxiYeO5x4JEkEvIV37SnFXK3JBVkwiC/r04njS8y
         DeZAUot9otBwpYzTq8BRqdksVkGzl71NkXIVhCIZ99z1EG+3khhsYIauwGuirflTgh0V
         TCYybUkkwvY/s4CVK+hSzWpo0fEViGSEK8W+W0wklZBuO2soqu75jQ+l5cX7FKRhBJgT
         3ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f74flBhltkIF6Kyzm1psBFvXaiR1ZpsFYBiux/pnBP0=;
        b=i2BDavDhjQNQdURhqVmzR6+aovWcnNeWUaclauTtIYXpwnB535isAA4CYxs48KQBVF
         QFW1Gp8FXbxWxY5yxkKLMpoWvr/B0xP1CDNcz9oadwjHCfFeSKe73c7pAdTPx70w4lp6
         zlQpC8/EmuJ16/Ey3BSNSkQfoYO0Eo9DUW3nAK9KIfBUePmEP2sWT3pY0sFsBWydVvUs
         MBEbNmRkPE99SI2t4I6X5xcROs4TN55EkVaFLObkygGOurJ3xpj1ZSDTY7inkhHvwMz8
         TMEtO8nzlah2ziFfXqMnGCC6Ce+SdK6Th2MshOOoMKoHa1XgBix9MEHIbIhn7oxX4upl
         6qog==
X-Gm-Message-State: ANoB5plTu5Umg5e+l22/EDfEliMkZng608xJ+8WGgbBTQzmWTnjtZ+YG
        0mWMLmoHwBGcsOoR8qsd11c71bub01ii/zukuLc=
X-Google-Smtp-Source: AA0mqf5BkB6tOs9ZGs9+GqphqnUcCfvk0twwLhRnghScakJzu5AIhu6mkb8wvOOc7fcyfPZ5034mmUZ5ehkKT3Pvgc4=
X-Received: by 2002:a05:6402:1f87:b0:468:7df:c38c with SMTP id
 c7-20020a0564021f8700b0046807dfc38cmr20457565edc.150.1670954276964; Tue, 13
 Dec 2022 09:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXeeCoHNt0tSD51HmexQG7qVBnJO+-_pURix7fr678LNQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXeeCoHNt0tSD51HmexQG7qVBnJO+-_pURix7fr678LNQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 13 Dec 2022 17:57:30 +0000
Message-ID: <CA+V-a8tuCV-p-BR3nAKZ+4Z1GnRus8eEKJZ_sBaTaa2mjqBb1w@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Dec 13, 2022 at 5:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Dec 12, 2022 at 12:55 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Pass direction and operation to ALT_CMO_OP() macro.
> >
> > Vendors might want to perform different operations based on the direction
> > and callbacks (arch_sync_dma_for_device/arch_sync_dma_for_cpu/
> > arch_dma_prep_coherent) so to handle such cases pass the direction and
> > operation to ALT_CMO_OP() macro. This is in preparation for adding errata
> > for the Andes CPU core.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -124,7 +124,7 @@ asm volatile(ALTERNATIVE(                                           \
> >  #define THEAD_flush_A0 ".long 0x0275000b"
> >  #define THEAD_SYNC_S   ".long 0x0190000b"
> >
> > -#define ALT_CMO_OP(_op, _start, _size, _cachesize)                     \
> > +#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)         \
>
> Since commit a49ab905a1fc8630 ("RISC-V: Implement arch specific PMEM
> APIs") in riscv/for-next, there are two new users of this macro,
> which need to be updated to (add two zeroes?).
>
Thanks for pointing that out, I'll rebase on for-next. I think -1
would be a better option than zeros.

Cheers,
Prabhakar
