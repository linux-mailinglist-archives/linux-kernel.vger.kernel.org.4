Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3097E680ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjA3K0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjA3K0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:26:17 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF75230EB6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:26:07 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id i185so11928625vsc.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hkA2BouTWIVCEzpH5DcRnnowd4/KGZPNwQpLgLcVdKA=;
        b=dsAo/vucpHuDG1Mwa0G8j3ilAQNwY3m1tta+M0vGvx/GTNKmVH50gqVdBLxIeBPOPq
         hFH96VXrZBLuxu3YuiawFv2BI3lqYlu+amsyeOFX0zQEdlR8G0AAdfl1wzBzpnF0CQKn
         6zIBDRtKo83YrSBGyJaFYOJnsEXeFQXh6AZwiSwwCcp50y28W44VBAs0S6RLB4KHr7xk
         Uqc/El91EL3roODW2WhjBOTU6Nut5lYRXfN98X104c5IvEEgvTHhAWlW4hHBrEnwTEw/
         I4w9DMdjh3RCnlUpSfnFmoY2oPqaLeVwMySPkfKCB5Dbi1s9ahUM6FaJDrMJTdaIwqNx
         QZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkA2BouTWIVCEzpH5DcRnnowd4/KGZPNwQpLgLcVdKA=;
        b=COXZsGQ4ERuUwZV2dN4ROr39yBLlZZRLLJ1GRxsnCXiWNwVv2DrbLH7FfqrpS4QkiM
         e8DIhwKhpSKQ+QE8AhKJwjxdzV7DoZieHC41w6drRA2d0USbp3HnXNrzLIWTb3xN2mex
         yfKDIh2j4DPT0e9NwGoyxL5oDyrf52nN2gUVlhw0FiGD3xEdNxDJtk+dd0Ef+7N1xxtn
         jILpi2Xy6CLTCxSlRjSC4ZPhrNrBp0Ry8oSj+KBVekqNuCrOAU4Q/H5eIoW7Xyz7Qrew
         HFVJuKP2GkwFVjD85n/Yis8HOUpBsvOvJBB127+AKgRVMbJpSp/j2bswGOH53vzSaaO7
         MWfg==
X-Gm-Message-State: AFqh2krDlEaWIYHhaRe4oVrgPRFDpGCxomDir2Qh3Pwq+BAypWHKFqRu
        Q4yPHeZ3ycsl/zHuYvEdhgduzX3H/BjmOIpk/Oatqg==
X-Google-Smtp-Source: AMrXdXuyWpCLTJxLo7/2GNEnqxvt/FzdRd/eNPGS9NLCfnbdRZH/oxwCLQ9FP6DWIlTFGdyEN7z7ABxxwI8Ibp0qujE=
X-Received: by 2002:a05:6102:c16:b0:3d3:e027:877a with SMTP id
 x22-20020a0561020c1600b003d3e027877amr6824978vss.0.1675074366736; Mon, 30 Jan
 2023 02:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20230129064956.143664-1-tjytimi@163.com>
In-Reply-To: <20230129064956.143664-1-tjytimi@163.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 30 Jan 2023 15:55:55 +0530
Message-ID: <CAK9=C2VaxNezv+M=s=ZSA-YDf_17+hcom_z1=_j2YkRHg-yg7Q@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
To:     Jinyu Tang <tjytimi@163.com>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        yuzhao@google.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com, guoren@kernel.org, tongtiangen@huawei.com,
        anup@brainfault.org, akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 12:21 PM Jinyu Tang <tjytimi@163.com> wrote:
>
> The arch_has_hw_pte_young() is false for riscv by default. If it's
> false, page table walk is almost skipped for MGLRU reclaim. And it
> will also cause useless step in __wp_page_copy_user().
>
> RISC-V Privileged Book says that riscv have two schemes to manage A
> and D bit.
>
> So add a config for selecting, the default is true. For simple
> implementation riscv CPU which just generate page fault, unselect it.

I totally disagree with this approach.

Almost all existing RISC-V platforms don't have HW support
PTE.A and PTE.D updates.

We want the same kernel image to run HW with/without PTE.A
and PTE.D updates so kconfig based approach is not going to
fly.

>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/Kconfig               | 10 ++++++++++
>  arch/riscv/include/asm/pgtable.h |  7 +++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..17c82885549c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -180,6 +180,16 @@ config PAGE_OFFSET
>         default 0x80000000 if 64BIT && !MMU
>         default 0xff60000000000000 if 64BIT
>
> +config ARCH_HAS_HARDWARE_PTE_YOUNG
> +       bool "Hardware Set PTE Access Bit"
> +       default y
> +       help
> +         Select if hardware set A bit when PTE is accessed. The default is
> +         'Y', because most RISC-V CPU hardware can manage A and D bit.
> +         But RISC-V may have simple implementation that do not support
> +         hardware set A bit but only generate page fault, for that case just
> +         unselect it.
> +
>  config KASAN_SHADOW_OFFSET
>         hex
>         depends on KASAN_GENERIC
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 4eba9a98d0e3..1db54ab4e1ba 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>          */
>         return ptep_test_and_clear_young(vma, address, ptep);
>  }
> +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG

> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> +static inline bool arch_has_hw_pte_young(void)
> +{
> +       return true;

Drop the kconfig option ARCH_HAS_HARDWARE_PTE_YOUNG
and instead use code patching to return true only when Svadu
ISA extension is available in DT ISA string.


> +}
> +#endif
>
>  #define pgprot_noncached pgprot_noncached
>  static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> --
> 2.30.2
>

Regards,
Anup
