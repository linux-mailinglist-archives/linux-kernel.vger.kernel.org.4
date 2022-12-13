Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BF64BABC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiLMRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiLMRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:15:09 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FF76279;
        Tue, 13 Dec 2022 09:15:08 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id l17so1885279vkk.3;
        Tue, 13 Dec 2022 09:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aP+igB0NaircxiSkGrnkdOtF08vfazQfrJeriBa6Dg=;
        b=a/yYLXDMvd9VOEXFjQOVmO8O+D1+oUxiKwFaXwinnMGgeBAG/aY/40ZEemwe6Q9Mhg
         hsLM9iIbhWP/Qxv7W+k0EAWZnNBsxu/b2GEj2OmZkSLoL3aRaDaU8gIKesp9eG8Va89l
         yP9rJZAc1KiPQK+THcqyDxW3s4xBbHdBXe9/1KK/2+Weo01H/AReGfzdxlBZx73KUF9l
         f9UrcT/+ap0fX3WYGlxKULn+V6ZnwVoWhStnx2QL7cRJIMWt1ikwY/v+ELzdBe1tZ1p3
         VEFgmk0x3IqmmkeuCTU9iIpZHhnIhJIhMrRXwtLfmK1Ddk87blHjiqqRVI1oLhUbEUwn
         lz8w==
X-Gm-Message-State: ANoB5pm8wahtKRadylwEMYxZhATdi8ZWLGtXQq8MHJ0ISpXaRvoPzYNN
        hpyOWbHTRIY+cjgJZ5aeG/01w3iTfq2zww==
X-Google-Smtp-Source: AA0mqf6SgxemQ55PkdkD98xgLHlzxm24HIV5Csb9Y9zAn72OVWrtjFPY5qyUqj964xChfnRueCG2nA==
X-Received: by 2002:a1f:a10e:0:b0:3be:16a9:6019 with SMTP id k14-20020a1fa10e000000b003be16a96019mr8691301vke.9.1670951707474;
        Tue, 13 Dec 2022 09:15:07 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a0f1300b006e16dcf99c8sm8264306qkl.71.2022.12.13.09.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:15:07 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-417b63464c6so101451337b3.8;
        Tue, 13 Dec 2022 09:15:06 -0800 (PST)
X-Received: by 2002:a0d:dd4b:0:b0:370:61f5:b19e with SMTP id
 g72-20020a0ddd4b000000b0037061f5b19emr27207087ywe.316.1670951706562; Tue, 13
 Dec 2022 09:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Dec 2022 18:14:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXeeCoHNt0tSD51HmexQG7qVBnJO+-_pURix7fr678LNQ@mail.gmail.com>
Message-ID: <CAMuHMdXeeCoHNt0tSD51HmexQG7qVBnJO+-_pURix7fr678LNQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Dec 12, 2022 at 12:55 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Pass direction and operation to ALT_CMO_OP() macro.
>
> Vendors might want to perform different operations based on the direction
> and callbacks (arch_sync_dma_for_device/arch_sync_dma_for_cpu/
> arch_dma_prep_coherent) so to handle such cases pass the direction and
> operation to ALT_CMO_OP() macro. This is in preparation for adding errata
> for the Andes CPU core.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -124,7 +124,7 @@ asm volatile(ALTERNATIVE(                                           \
>  #define THEAD_flush_A0 ".long 0x0275000b"
>  #define THEAD_SYNC_S   ".long 0x0190000b"
>
> -#define ALT_CMO_OP(_op, _start, _size, _cachesize)                     \
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)         \

Since commit a49ab905a1fc8630 ("RISC-V: Implement arch specific PMEM
APIs") in riscv/for-next, there are two new users of this macro,
which need to be updated to (add two zeroes?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
