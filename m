Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D537B734F10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjFSJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFSJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:04:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE55B4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:04:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a20c744ebso3794237a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1687165485; x=1689757485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOMkMMAr2Gg0bJAi4+JqalAqrnOAduCDY6ClopKhu7o=;
        b=lxfJQE0xX3I5jYqy0UEhvatNi1bEe0LGgP/lmC+ZElBgNg8sCnadykEjHqFC/p8GUZ
         izgUIZptlaFMrc8RDR4jfovxA/95RIVzNUUjt0goz5x9tNml47o7KEgjlNGeuUIFlzzM
         Kczl256i4qumx9ZEC8E+fYH4DzRutLAjcl15Sq8Gz5IDXxWBaA3BulNihk3nNoOLSCN5
         Gyfz7P03rL+tiOSJ+8sWw0K8lYOqYyqu6fXCaeURDBfebaAGuMrGy4kMT+MSq12Khjoa
         +VpnP5757yuYBbTTMKYT2K5vTTNNmN/jtuIr4gh2rfewpbPm44EtvxoRipKYSQpHFGgQ
         R9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687165485; x=1689757485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOMkMMAr2Gg0bJAi4+JqalAqrnOAduCDY6ClopKhu7o=;
        b=NAlgGOpqAXNB9ajSKRQYkDveDTiERix/CQPbB3q6mI88+MbUcYEUZvKMtYZixoj89q
         tTulpSaFS77YphF8ZGPWAccJz9DsdN73BXXXCazpnAQZ57yoC5IMpsa26OtMOqBoG5VX
         377IGbSLo4/kOC5C0uApNInVX9gPM1RN54qtFl9y8WwKB1IznRITlZ/NeyYH+wmno3RU
         AIfiMPka6yeg31R4XtPjfZeQwvPau8OMx/UuKuRS5NZv3NwxLnM75nR967RdRnvu3i95
         Cid2XvyWkaKZNzok+/K2rLF3ppfKk8LD0dOsSoDoCon7+j6z2K5dPl+ZyEMM8J6LBC0V
         DKTg==
X-Gm-Message-State: AC+VfDy6ZR4nNBFwCgiXAqYtoiDAbRzJQY+igXszG5wmEjEutMC0jM1k
        mj2uJowsp1rHN+ZQByTQ8jpEtQJZ9dg1Aopyd8uWNQ==
X-Google-Smtp-Source: ACHHUZ768q3f6zOzDHZ7Hx9YSEKq+8wOdyRXvCMU8hq5SVfPwpgMrdOf2DcZ4MrsHubHFDfXQzUhn4Ddv1whxrE6xW0=
X-Received: by 2002:a17:907:a41e:b0:976:b93f:26db with SMTP id
 sg30-20020a170907a41e00b00976b93f26dbmr8200640ejc.53.1687165484807; Mon, 19
 Jun 2023 02:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230612111044.87775-1-apatel@ventanamicro.com>
In-Reply-To: <20230612111044.87775-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 19 Jun 2023 14:34:33 +0530
Message-ID: <CAAhSdy2H8fhb84Q7kn==6pdRod_CcZ1hWyr3niDBGKfr4e-mQg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Allow Svnapot extension for Guest/VM
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 4:41=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Svnapot extension for Guest/VM.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Queued this patch for Linux-6.5

Thanks,
Anup

> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu.c             | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 61d7fecc4899..a1ca18408bbd 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -122,6 +122,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZICBOZ,
>         KVM_RISCV_ISA_EXT_ZBB,
>         KVM_RISCV_ISA_EXT_SSAIA,
> +       KVM_RISCV_ISA_EXT_SVNAPOT,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 2db62c6c0d3e..7b355900f235 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -61,6 +61,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(SSAIA),
>         KVM_ISA_EXT_ARR(SSTC),
>         KVM_ISA_EXT_ARR(SVINVAL),
> +       KVM_ISA_EXT_ARR(SVNAPOT),
>         KVM_ISA_EXT_ARR(SVPBMT),
>         KVM_ISA_EXT_ARR(ZBB),
>         KVM_ISA_EXT_ARR(ZIHINTPAUSE),
> @@ -102,6 +103,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsign=
ed long ext)
>         case KVM_RISCV_ISA_EXT_SSAIA:
>         case KVM_RISCV_ISA_EXT_SSTC:
>         case KVM_RISCV_ISA_EXT_SVINVAL:
> +       case KVM_RISCV_ISA_EXT_SVNAPOT:
>         case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
>         case KVM_RISCV_ISA_EXT_ZBB:
>                 return false;
> --
> 2.34.1
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
