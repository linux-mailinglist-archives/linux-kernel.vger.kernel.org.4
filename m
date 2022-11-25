Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1C638202
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKYBJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKYBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:09:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D06218D;
        Thu, 24 Nov 2022 17:09:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2126062283;
        Fri, 25 Nov 2022 01:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75265C43470;
        Fri, 25 Nov 2022 01:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669338542;
        bh=zfRbgeoDt+0w8suP97JdY8IGodoPcBClGb0g/AKVKn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I8aXaRszPF/veSAbWEYRcLxcNqrUsMqCU5eJinXNbShTpzKrfSmrQn3WOyHmqlEGx
         4kfJ9DdgaiLffQxIcxpN0XB0q0RnymsMqcMh9cEdmvkTDnMJbA4x49mMsPNPqasxiM
         rIyTK36hZi3qRWOL0qIi/MwE26ZMWUXX/FZn0SqCo+i/pMgtPDCiy716/smyieTKf0
         ObJquvfWW1x943Q3gzkB4KzdVsiy5OUp4rQPos0NlTvZ0a/Gzzs4lyakFGykxh5jvZ
         F9Ckm5RiSzeowCsbrel4405ntNHcYkqIriGmox3l+7q34dkboTTpmMivN9aCVw9N3a
         b9q6y2N3aBv1A==
Received: by mail-ej1-f47.google.com with SMTP id bj12so7114697ejb.13;
        Thu, 24 Nov 2022 17:09:02 -0800 (PST)
X-Gm-Message-State: ANoB5pklpI6Xl11oxKPcqXBstGpWOszpbbUAgbKALgeeWMLi+VNitKuk
        0XsuSENYYIEFqO+ePTgPhiNzulHdK/SpGVzjZFk=
X-Google-Smtp-Source: AA0mqf7TDoMcea3d4L5NnABHgmFcULHsWPvS6JfIzA15FV2fCNMd6KySlQJTTrsxjo1ZCRP4f7zVcLVRn1hn5rlG9R0=
X-Received: by 2002:a17:906:6a8e:b0:78d:a136:7332 with SMTP id
 p14-20020a1709066a8e00b0078da1367332mr29488840ejr.355.1669338540456; Thu, 24
 Nov 2022 17:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221124172207.153718-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221124172207.153718-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 25 Nov 2022 09:08:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT7XEXmLWpP6nnSNRms9kj2NQR2dOA5N+V2UmnsurJogQ@mail.gmail.com>
Message-ID: <CAJF2gTT7XEXmLWpP6nnSNRms9kj2NQR2dOA5N+V2UmnsurJogQ@mail.gmail.com>
Subject: Re: [PATCH DO NOT REVIEW v4 4/7] riscv: errata: andes: Fix auipc-jalr
 addresses in patched alternatives
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 1:22 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This patch is added just for building purpose, as patch [0] will export
> this in its next version.
>
> https://patchwork.kernel.org/project/linux-riscv/patch/20221110164924.529386-6-heiko@sntech.de/
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note, as Heiko will be exporting riscv_alternative_fix_auipc_jalr() function
> so that it can be used other erratas Ive just included for compilation.
> ---
>  arch/riscv/errata/andes/errata.c | 71 ++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> index ec3e052ca8c7..4061ad4983bc 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -13,9 +13,80 @@
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/errata_list.h>
> +#include <asm/parse_asm.h>
>  #include <asm/patch.h>
> +#include <asm/sbi.h>
>  #include <asm/vendorid_list.h>
>
> +/* Copy of Heiko's code from patch [0]
> + * [0] https://patchwork.kernel.org/project/linux-riscv/patch/20221110164924.529386-6-heiko@sntech.de/
Move it to commit-msg. No link in the code.

> + */
> +DECLARE_INSN(jalr, MATCH_JALR, MASK_JALR)
> +DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
> +
> +static inline bool is_auipc_jalr_pair(long insn1, long insn2)
> +{
> +       return is_auipc_insn(insn1) && is_jalr_insn(insn2);
> +}
> +
> +#define JALR_SIGN_MASK         BIT(I_IMM_SIGN_OPOFF - I_IMM_11_0_OPOFF)
> +#define JALR_OFFSET_MASK       I_IMM_11_0_MASK
> +#define AUIPC_OFFSET_MASK      U_IMM_31_12_MASK
> +#define AUIPC_PAD              (0x00001000)
> +#define JALR_SHIFT             I_IMM_11_0_OPOFF
> +
> +#define to_jalr_imm(offset)                                            \
> +       ((offset & I_IMM_11_0_MASK) << I_IMM_11_0_OPOFF)
> +
> +#define to_auipc_imm(offset)                                           \
> +       ((offset & JALR_SIGN_MASK) ?                                    \
> +       ((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) :                    \
> +       (offset & AUIPC_OFFSET_MASK))
> +
> +static void riscv_alternative_fix_auipc_jalr(unsigned int *alt_ptr,
> +                                            unsigned int len, int patch_offset)
> +{
> +       int num_instr = len / sizeof(u32);
> +       unsigned int call[2];
> +       int i;
> +       int imm1;
> +       u32 rd1;
> +
> +       for (i = 0; i < num_instr; i++) {
> +               /* is there a further instruction? */
> +               if (i + 1 >= num_instr)
> +                       continue;
> +
> +               if (!is_auipc_jalr_pair(*(alt_ptr + i), *(alt_ptr + i + 1)))
> +                       continue;
> +
> +               /* call will use ra register */
> +               rd1 = EXTRACT_RD_REG(*(alt_ptr + i));
> +               if (rd1 != 1)
> +                       continue;
> +
> +               /* get and adjust new target address */
> +               imm1 = EXTRACT_UTYPE_IMM(*(alt_ptr + i));
> +               imm1 += EXTRACT_ITYPE_IMM(*(alt_ptr + i + 1));
> +               imm1 -= patch_offset;
> +
> +               /* pick the original auipc + jalr */
> +               call[0] = *(alt_ptr + i);
> +               call[1] = *(alt_ptr + i + 1);
> +
> +               /* drop the old IMMs */
> +               call[0] &= ~(U_IMM_31_12_MASK);
> +               call[1] &= ~(I_IMM_11_0_MASK << I_IMM_11_0_OPOFF);
> +
> +               /* add the adapted IMMs */
> +               call[0] |= to_auipc_imm(imm1);
> +               call[1] |= to_jalr_imm(imm1);
> +
> +               /* patch the call place again */
> +               patch_text_nosync(alt_ptr + i, call, 8);
> +       }
> +}
> +
>  static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
>  {
>         if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
