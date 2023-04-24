Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE856D3C66
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDCEZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDCEZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:25:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9AD83DA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:24:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h31so16685212pgl.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 21:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1680495899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DUWV9ktqlDY/BbjAabfUWG15IVJ8NNADNU0tp46NqU=;
        b=ecCTgHwD+RX5VqoH89r+CLiINbWmHhR+Doo+KG6KQPo5T9RpBIFceUdzn8stTHl1KY
         qwvrNkD1b36X3KW4mXOefj+7llceiyqvhRV0ro1ZZ8VvAtwv71Zq1/iQ6cZQOwJrQdCs
         TTzpCj8DU44ITnJXab5cryMIo9/P277vU029M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680495899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DUWV9ktqlDY/BbjAabfUWG15IVJ8NNADNU0tp46NqU=;
        b=64ZLmxG40ToJnwVi/FNbyjpnrIbwKH9L99NBuvPJAGq4JMprTtzS/HMBQFVdo3rtPs
         64FmEpfG3mMzMl4QSl+EDrInM/3OCpERRggk5TqXTtJCCzeeAINKQfZoo5iZSj1qzyjq
         dAKqibCraUKZtxwdlH/aoq8F5eSW1QPljXbsyqU4ZERg7GlN/3hlZSnVim+XsGYPszjh
         9hp/Ww+rtKe2KL+v9qR4hOfej5C4adY77u2otEW/4qYSZuv97vC0wNKwfZ/9Rx48j5uH
         RRBcNgTe1CwYPwuBxX0Tr9g0fUIB6kJXy0QLzY3uYDvHqf1U2Dm2BmFoX43tneSkO2xC
         Ng5Q==
X-Gm-Message-State: AAQBX9cqCjHnmNxXakx8h3xG+62LLAKkn3SEA3JY5qgdoRiBw8wTwOsY
        A5XrIHEC2MtCjEztw7DWP6sn9ubPyjBYXOFu/Hgx
X-Google-Smtp-Source: AKy350buPR6+d9jPTSOjsqUWE4vPnoVCi1WyVz7aXHC5S1Qdm0BMiGAb7aL0Tx+OP3pzy3gzY6/7lWFNCwWLO5eD3gs=
X-Received: by 2002:a05:6a00:130c:b0:623:129f:6269 with SMTP id
 j12-20020a056a00130c00b00623129f6269mr16947692pfu.1.1680495899232; Sun, 02
 Apr 2023 21:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230401112730.2105240-1-apatel@ventanamicro.com>
In-Reply-To: <20230401112730.2105240-1-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 3 Apr 2023 09:54:47 +0530
Message-ID: <CAOnJCUJ9zgEjMDVo+rBuhzfaBWY1iaCL6Dy0Og+-QU3x4+GSmA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Allow Zbb extension for Guest/VM
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 1, 2023 at 4:57=E2=80=AFPM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Zbb extension for Guest/VM.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu.c             | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index d8ead5952ed9..47a7c3958229 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -106,6 +106,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_SVINVAL,
>         KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
>         KVM_RISCV_ISA_EXT_ZICBOM,
> +       KVM_RISCV_ISA_EXT_ZBB,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 3112697cb12d..02b49cb94561 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -61,6 +61,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(SSTC),
>         KVM_ISA_EXT_ARR(SVINVAL),
>         KVM_ISA_EXT_ARR(SVPBMT),
> +       KVM_ISA_EXT_ARR(ZBB),
>         KVM_ISA_EXT_ARR(ZIHINTPAUSE),
>         KVM_ISA_EXT_ARR(ZICBOM),
>  };
> @@ -99,6 +100,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigne=
d long ext)
>         case KVM_RISCV_ISA_EXT_SSTC:
>         case KVM_RISCV_ISA_EXT_SVINVAL:
>         case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
> +       case KVM_RISCV_ISA_EXT_ZBB:
>                 return false;
>         default:
>                 break;
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
