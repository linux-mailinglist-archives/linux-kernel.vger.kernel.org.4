Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB767DCBC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjA0DvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjA0DvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:51:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F559B78
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:51:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m2so9935752ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhXH+LjnQJy+TeeqGL7rkW4DgM2MxsYFE7DG5vchcB4=;
        b=B+rvX7pOPdV39M9bsZ5xmu8dal+4X8Dr2wK27ARpXKBZ9kCTugreLcVmkwC14GBYIK
         K7Hl+gvoQConiXD4xzaPTWkQQ4q4RqDvOyff4kLX6KliTYCaHFe3MpL7b4IrxD9+i65o
         WGTVg9zfptYSXi+4pboUALk01gTvBU5PTLBsU3GEy8W7VPH/Sp8uDPTscQXdFz9tNxWu
         n5/C8eS5NCw9fTouHYJB7BybpsVGHipyytc0KhI0MxHlJCFcpjX8BM2RA/NKob8pYscl
         gTnn5yBNrWnIkfH7VoYdmOyOSy3xiiCSL3Pu20GqzTaAVyTDcs4yrcSpqaQxvqsT/ZuS
         p93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhXH+LjnQJy+TeeqGL7rkW4DgM2MxsYFE7DG5vchcB4=;
        b=0dHDQmeT+lCRKU/yaUXnSroHnQ/Y3htxT1uffLOAhganiJjr67lKMmGJI8y/Cm7Gqo
         ZVwpz0k1ZPcXDcIMqeYVPN55Qplqi9/jJ91aV9mH+lXlprDLJ0FR2yASy/4i5CullI05
         O1Vghvn7CTJAoysWanplZa+dvZte/UO3KZ2jjvN4vJMp4fyIFCX002CWnI4yJZebUQ0l
         rMfngu29XT/x8JwbUdVGKoYQraf8eAYDohlvDseTHicGpVOBwgQxvgxwNsnDwFpMXkbJ
         HdvDH9phkiFxZQ+gw9tSLqn2rFfm7V2XWoYumAokMYNBNZyvlm/j7ziqCn2R+6dZgY1d
         m2bQ==
X-Gm-Message-State: AFqh2kokTyH1L3nJ0UObCOEu+Um/b064zFvbwvifDLDEjyTnWI2FxQkj
        d1KA+GWvxZOPTeodiykypYkVMth8Me5JOwMWz9hwgA==
X-Google-Smtp-Source: AMrXdXum5zSZENCqc9aXWct0JbjZ6VxCYt8cvgWug1VNIFkR20MtvAjaz8ZeEdwf9D5wKNWAd8lJDuBRkh/bbbmtkEw=
X-Received: by 2002:a17:906:3799:b0:781:541:8f1d with SMTP id
 n25-20020a170906379900b0078105418f1dmr4914571ejc.117.1674791475248; Thu, 26
 Jan 2023 19:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20230115154953.831-1-jszhang@kernel.org> <20230115154953.831-13-jszhang@kernel.org>
In-Reply-To: <20230115154953.831-13-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 27 Jan 2023 09:21:03 +0530
Message-ID: <CAAhSdy3DmSt1-i5AoeOt0e9snD+P8XpazAUTr0LoNfFCuA3+pw@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] riscv: KVM: Switch has_svinval() to riscv_has_extension_unlikely()
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 9:30 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> From: Andrew Jones <ajones@ventanamicro.com>
>
> Switch has_svinval() from static branch to the new helper
> riscv_has_extension_unlikely().
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/tlb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 309d79b3e5cd..aa3da18ad873 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -15,8 +15,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/insn-def.h>
>
> -#define has_svinval()  \
> -       static_branch_unlikely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_SVINVAL])
> +#define has_svinval()  riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
>
>  void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
>                                           gpa_t gpa, gpa_t gpsz,
> --
> 2.38.1
>
