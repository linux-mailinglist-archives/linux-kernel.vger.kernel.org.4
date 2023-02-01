Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2C67F8D6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjA1Owt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjA1Owq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:52:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E6172B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:52:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g11so7129651eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijLxm1lKEfZs0IZlgOOAhHSKYX5QLiE4GGhNuEVcGng=;
        b=frQzbI8stra8ftvJmg/B4t7HWCvM9FnezzFATdbngE0HpGmiaL/TjPJIoSbNZ9A4VT
         TmqVpwwgbl9nEk931XnNjrIWQzD1UcenOwzz7GqmOsjVO7BYYbBpkzFJDhcxKpiEcTCX
         uzi6RWK9H2QU/hsKU3ApOaN/zDfb2Lmd4qhQ3vml3oB7T8z+VRPoQ2XASr0au1Tc8krm
         w/KeidcDztQFgvdZPPr37O235osye7NaYMTydT7lZdmtqzkxHCll2ApdWqQt9MGreTMW
         vXqptBUC9RS0RSP6flDXsebDs2Zk+3yAUrJhs3OYKD7CWrVsMAGNeuQ4LUaQCZyYZ+kN
         hU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijLxm1lKEfZs0IZlgOOAhHSKYX5QLiE4GGhNuEVcGng=;
        b=zyZtwGvsedfCggNuEloXLeS1ou2ULCrEaj73Jg7HzG9mOEZc01dezYkTfj39/dWPTm
         j66gwsUMV+877s7hcMiCDvOkGprgqfXmOyhsMAJbu87O76mUyk3SjBudXto/VUI0GAt8
         VTN2ZJ6o3rg7xz2bU8WiAZYjwMHZyeEBDn6UtvRTnEjXgy9p/Lwmkq6JxAzncCCP1He1
         +lcY1a5fD6PsYo37PER6rKPKwBzcv8sufpQHKyUkP+PBX7zIYpCMrODJLKQ5UQ0Ei50e
         55akSkg/5fWAUq9a6KyRyqUk1pr21iqgtKbVKs7vVKHcp9Sn7EqPrqeApg7xbE3hMxiT
         xYbg==
X-Gm-Message-State: AFqh2koV7VYTsyS4pbW3Yyl/mz2UlufCnUAlgfJi3RcGv7vbdSMaZ90n
        qnOivcZcbM2Fn0/ExMqWH0zJoHgVPoHaApqXFvVaHA==
X-Google-Smtp-Source: AMrXdXse7F8M1Kedc0Z1csa7K5rxc5NJv1iWBhk3K9TBNTVIFbV/IBRgCuYscAaDKH70PcJaPWPHOuAgkp3YkwYEPNY=
X-Received: by 2002:a05:6402:1008:b0:499:f0f:f788 with SMTP id
 c8-20020a056402100800b004990f0ff788mr7501420edu.25.1674917563804; Sat, 28 Jan
 2023 06:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20230127182558.2416400-1-atishp@rivosinc.com> <20230127182558.2416400-6-atishp@rivosinc.com>
In-Reply-To: <20230127182558.2416400-6-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 28 Jan 2023 20:22:31 +0530
Message-ID: <CAAhSdy1XKbb47OOQshy5NZjVZrS_eJUFeEWmDgJ2MigSKpVpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] RISC-V: KVM: Return correct code for hsm stop function
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:56 PM Atish Patra <atishp@rivosinc.com> wrote:
>
> According to the SBI specification, the stop function can only
> return error code SBI_ERR_FAILED. However, currently it returns
> -EINVAL which will be mapped SBI_ERR_INVALID_PARAM.
>
> Return an linux error code that maps to SBI_ERR_FAILED i.e doesn't map
> to any other SBI error code. While EACCES is not the best error code
> to describe the situation, it is close enough and will be replaced
> with SBI error codes directly anyways.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_hsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> index 2e915ca..619ac0f 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -42,7 +42,7 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu)
>  static int kvm_sbi_hsm_vcpu_stop(struct kvm_vcpu *vcpu)
>  {
>         if (vcpu->arch.power_off)
> -               return -EINVAL;
> +               return -EACCES;
>
>         kvm_riscv_vcpu_power_off(vcpu);
>
> --
> 2.25.1
>
