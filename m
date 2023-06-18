Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC17346E9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjFRQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFRQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:02:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361391AB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:02:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so280075666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1687104171; x=1689696171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRbzBkciEPo/VwBwcSi1eZcepCh3WEZDv0XNNTPYER8=;
        b=PwMG1rS/T0zMkIJb0NktFrkHaDuOvE9rVTTXi9SygbdwcNq1MkZ5ogL981oWNKxdXB
         bPEuLwf7V8KhrkfNCB1j80iuxZfgdfdHTOVhMjAO1pzhoAnTITzRI47jJTMa/Q64FOu6
         y0Zg5JYwUsRJm7pszI1pnT7RkboXvX6MJ/MpHx+7ppzDY37ZsW3uMNNGdJVQ3PZCjdh4
         Qh0BrbGStI3AY2gdMu3Q4QtL07Mf+PwbWvbUoU3qYVwKpdWbntLaTwnx/cqP5LhdlzsN
         0AMROUj/kAvNMWN2yL7AV5oxBpCFC1R/YRGyX+5vxFdmHMroh/nu3NhGcD1fql/xWfQS
         rNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687104171; x=1689696171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRbzBkciEPo/VwBwcSi1eZcepCh3WEZDv0XNNTPYER8=;
        b=kikyYaTMHxhNKT4OJUubPQtpc1JGWhZgLTRHUdf7j72X3yLLBRIY3Xxjtpidx+g7cm
         wET2BYKvD7a/pdBg0qGPmW3mD8vXKmygiRA7Nz9AFOQ3bzv+8BqEgRYzsqxsX80TSyAE
         0SqHLV+YV5yW/vozf8IaoVeeyWd64jeGw681pGTaQlHT0XbN/vY4UvZvwJMRpzbUcE8q
         +5usybm6AxZnwF36ZIxJHIMgmkTi7YPC1hDKmZ3UvWbPxU1QXZ1Xc5S6PyP6GFwLP/Dw
         WECUfrQF6hw9G3AO4pQ/6z1DgK4b4t2j2SsrJnnL6ezondiqiABDrOfpLjG/tk9S0noe
         fYJw==
X-Gm-Message-State: AC+VfDx8CsKsqlTQ+AcljweR90YqRriR3dZgo3GUdhWxktxwDEDCbONj
        gH7kXUBaQcHGTbc5U6Z+PaHBprmU9QTKP1S3n27Zww==
X-Google-Smtp-Source: ACHHUZ76bSKd7iFZYOKBq6Bi4aoQhk/ver2w1iruH0Fe1LaOVqdlt/rdgLfTiLHof5C57D4/VPNytqb4y52AGQTHTDg=
X-Received: by 2002:a17:907:8a08:b0:987:ae30:4b8c with SMTP id
 sc8-20020a1709078a0800b00987ae304b8cmr4476266ejc.70.1687104171484; Sun, 18
 Jun 2023 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230616142203.168996-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230616142203.168996-1-ben.dooks@codethink.co.uk>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 18 Jun 2023 21:32:39 +0530
Message-ID: <CAAhSdy2Hb7aMbOdw12GZCtZCc0WcJn3-hxZmvgpMfmYhuZs-EQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: kvm: define vcpu_sbi_ext_pmu in header
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        palmer@dabbelt.com, atishp@atishpatra.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 7:52=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> Sparse is giving a warning about vcpu_sbi_ext_pmu not being
> defined, so add a definition to the relevant header to fix
> the following:
>
> arch/riscv/kvm/vcpu_sbi_pmu.c:81:37: warning: symbol 'vcpu_sbi_ext_pmu' w=
as not declared. Should it be static?
>
> Fixes: cbddc4c4cb9e ("RISC-V: KVM: Add SBI PMU extension support")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Queued this for 6.5

Thanks,
Anup

> ---
> v2:
>   - correct the fixes tag as suggested by Conor Dooley
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h | 3 +++
>  arch/riscv/kvm/vcpu_sbi.c             | 4 +---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index 4278125a38a5..b94c7e958da7 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -66,4 +66,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext=
_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
> +#ifdef CONFIG_RISCV_PMU_SBI
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu;
> +#endif
>  #endif /* __RISCV_KVM_VCPU_SBI_H__ */
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index e52fde504433..c973d92a0ba5 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -20,9 +20,7 @@ static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext=
_v01 =3D {
>  };
>  #endif
>
> -#ifdef CONFIG_RISCV_PMU_SBI
> -extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu;
> -#else
> +#ifndef CONFIG_RISCV_PMU_SBI
>  static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu =3D {
>         .extid_start =3D -1UL,
>         .extid_end =3D -1UL,
> --
> 2.39.2
>
