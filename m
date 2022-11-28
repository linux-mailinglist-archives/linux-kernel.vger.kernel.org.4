Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3397A63B3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiK1VIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiK1VIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:08:16 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D2A46E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:07:39 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id e205so12997643oif.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0FNGgIcUuNCpA9Y9gi862KOUxRRENxcyaW7zlUvyPA=;
        b=Ky5DoOUUHPMkVp410wTsY19+tvY84MsUuCl1ggQXdgoTqVd3RdraVJzY8pKA5NpZ0l
         WCZSFSi4hv43yLLNYUJTMT9HqifM8M39izGYtApDIN4Nk5frsZ/bpF6qKuycefNgGk8z
         afeY2nsROdYu49kDMdApsnjQVKROVaQCnP3oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0FNGgIcUuNCpA9Y9gi862KOUxRRENxcyaW7zlUvyPA=;
        b=8HVhc/q9774dTxbO/HmXGoVpB3bM4WImTtqZah7KX8IjGj7y+2htzfky8gUbWHYNRt
         rEvE46F2pkSPxlc8+aK47J81+E8FAsiPliMtxhUxwh0kL3iQYBKeGrBMq6sawoWIu5CA
         DgA3DOicoAY1g7IndSQDqvm2sVXBgJh9h8f2B6n3RcpcNQ7zKL+sS1GjiqZHHnTgw+UD
         4h4m94ZwyIEuxxd9og3VSU4PCAsbJuIFdBegTYSuI3byD/km0IeZ+r9X57Imbs0bUc+F
         YroUbWvllwyfSHj1j4TJHBLHyaVKtzJZ3q8G9o+iztcacoR25iRrW90/p1yZztxfeYPG
         zy6A==
X-Gm-Message-State: ANoB5pl+6wjl2kTxyAYQol8hF6/unkZ6wVaRsorEPlUr67SSRmDCG4Cx
        3DAGJuQvxATjh3iLduZh9Gd/ZZq2Bdwg71BhSFB5
X-Google-Smtp-Source: AA0mqf60qCnqGEvcePSoSgN8ZuI9R5R/l1ZJ2jFT3sjZ21drA4GBHWvJy3Gx9s0n0FFCxp8tEBghJjjk+vdZIRCeIpM=
X-Received: by 2002:a05:6808:a90:b0:35b:aa33:425a with SMTP id
 q16-20020a0568080a9000b0035baa33425amr4727887oij.181.1669669658557; Mon, 28
 Nov 2022 13:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20221128161424.608889-1-apatel@ventanamicro.com> <20221128161424.608889-7-apatel@ventanamicro.com>
In-Reply-To: <20221128161424.608889-7-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 28 Nov 2022 13:07:27 -0800
Message-ID: <CAOnJCUJ6b5=e=k19q0Q51Gptgw_QSr_989cN8q0xoBN+yq=Mmw@mail.gmail.com>
Subject: Re: [PATCH 6/9] RISC-V: Export sbi_get_mvendorid() and friends
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 8:14 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The sbi_get_mvendorid(), sbi_get_marchid(), and sbi_get_mimpid()
> can be used by KVM module so let us export these functions.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kernel/sbi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..5c87db8fdff2 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
>  }
> +EXPORT_SYMBOL_GPL(sbi_get_mvendorid);
>
>  long sbi_get_marchid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
>  }
> +EXPORT_SYMBOL_GPL(sbi_get_marchid);
>
>  long sbi_get_mimpid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
>  }
> +EXPORT_SYMBOL_GPL(sbi_get_mimpid);
>
>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
>  {
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
