Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991787333B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFPOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:36:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32B30E3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:36:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9827bd8e0afso114920166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1686926187; x=1689518187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BACqnweRL61UjLrvkmQrlGuJAGVIBESiVvuLAZdqQgo=;
        b=SI9LdqWxDOWAVuG55cmvzVYPb5UqK7IiZ5dfEkIn7TqIshRNu/zoicyG1+0ZCxHS5o
         uo9sKJROKr+jJyWoUprePgJx0DGOHnCrk9lokCssSZ0y3YcAjd2erad5hYTEQd+xSr42
         8xPLgmcjFm3jDu3n8xA+fG29trDJbxZKAqOGZk7UWp4XbSHSL6WxaS0h/cvh9l5luSIr
         ajHPspUrYAblG+LJ2Wa+pjJTkhsBOSUDJSqGhfWBAKdiZE4YFJz+bmOF60YHc1UnmerB
         fMVUNX+rkssWKpjRBk0QjNWSp/sezaAZzLn/qjRftNnF3vpufRjwx8nL7W7yB5k8kXl6
         1MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926187; x=1689518187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BACqnweRL61UjLrvkmQrlGuJAGVIBESiVvuLAZdqQgo=;
        b=aHy9/BYaJBcK1oOMB4ps1/Wt6Uzu1Sx4G7fyy2cdsBM66BOFAFfMPdWOZ36XGiEbXx
         ViWD+nZSBYivarkYHxcfaSCxHydTsE+8qycpKEO9E74+xlDw1WpfxtFymY0q5BCK+J7l
         ewtCHv8hqMkJXr5pSOi4dMeAU7jHpLvSGRBsQi8dQSG0dw2M5sYalHJUKNhJoBEzgMBU
         WXHrM+S/1ZHGMIUvALhtcFOChYF2Tzjxfa0uxA5q97EjekHW1JVKGHrkbQ5VMe10PZvY
         eDY+yjoFswC/06yIF5mx1p3UHgHkzGO9k8HmzBQzYQCR5EOzhv1rIkloPtlGnWXoF5r8
         ha4g==
X-Gm-Message-State: AC+VfDxKzuEf1zWnj2cEJqYhLPXartHi7GyQbR17ObMtRPbhDpONWCLH
        dGgspn/WmNt2xHnIvV9pJNJ+MXN8LHsIa37YDipa9w==
X-Google-Smtp-Source: ACHHUZ6RJz+dJvapT4zI/sjWIJF+dBfDpbIVQmXDr5TNO0zmnnDqhOMJOYvim3qW9pYH7lUqULrkrWkjhVTbdzGASws=
X-Received: by 2002:a17:907:783:b0:982:c8d0:683f with SMTP id
 xd3-20020a170907078300b00982c8d0683fmr2002129ejb.18.1686926186692; Fri, 16
 Jun 2023 07:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230616142203.168996-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230616142203.168996-1-ben.dooks@codethink.co.uk>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 16 Jun 2023 20:06:14 +0530
Message-ID: <CAAhSdy0Yu6965Q1eS8gZq3-CkiD=s5hqdsC=VwHU7fnrJq=M9A@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: kvm: define vcpu_sbi_ext_pmu in header
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        palmer@dabbelt.com, atishp@atishpatra.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Please include Reviewed-by tags obtained on previous version

Regards,
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
