Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDA63B3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiK1VJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiK1VJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:09:27 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE914030
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:09:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id l127so13038782oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilVgGC8TOxHzgJU/67Xu5FjqKUjFndYhRBD1pSBbUXQ=;
        b=lMZqt+KmgNbP1xC1+0PEw1zG7OaHp+6QccMIYADd+TiGioedQISw+Bf0QI6CqLDEqu
         nh9IlSILqfeP5yROj2or137eOdwz0TtEf0hKQzW0cHr7UAlBi6eZE5jjT5Ht38Cb0K1s
         MgDKQVhDFeRzba2/3FDM1BmzLnnYbQxqGs2f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilVgGC8TOxHzgJU/67Xu5FjqKUjFndYhRBD1pSBbUXQ=;
        b=R75y7NcG4Nc/ggNUCVJYIk/RJgIkN6eII8nfIRz+kzd54UpMF2CEZs1L6SsIZ7aGz+
         WInlJlcn5O3WVN08C+UsK8QgZhvb9eUWyG6RxLRRUYFMBcfcF+SmffvWwFtQ9SWt/pWf
         wyqKIgxcFDNG7a6uepVA0mprWu1xhuekVTCvaETr0AdNnQW2hJvTgCU8d/GnUSN7Q7Hb
         3TDobaORlDEspkC3YbWd4pq+vK1VkxjONxjtRx9CikBdzH++MHCksYmymghk6WZPUP6o
         8CR6dEJ+wK5xyEn0wm2d6Uar9AnLIfjyyzrW8JbwHVzXgjDJfg12tbutpnzlzw8l4WPQ
         sV8A==
X-Gm-Message-State: ANoB5pks2LuJ2esoNNLkPGZ7N/Amn24JuXqH94l5IDEEASE2U4XmwYy0
        SlPgxiUoOqmkhtBc4/PVLN5ijQY+kfiairqtMuaf
X-Google-Smtp-Source: AA0mqf4VPR4z8hBPap7MOUP+bfI/yUr6Hc/zRJpKRmEImo2WSYflhgiYPEGYjq1l59c2HcOT2pepYwYUt4fDHY55jMk=
X-Received: by 2002:a05:6808:51:b0:359:f091:104 with SMTP id
 v17-20020a056808005100b00359f0910104mr29358704oic.274.1669669764575; Mon, 28
 Nov 2022 13:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20221128161424.608889-1-apatel@ventanamicro.com> <20221128161424.608889-9-apatel@ventanamicro.com>
In-Reply-To: <20221128161424.608889-9-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 28 Nov 2022 13:09:13 -0800
Message-ID: <CAOnJCULA77d+S37aPuC_kJAi769beasdgsK+WfkZe623SsYEow@mail.gmail.com>
Subject: Re: [PATCH 8/9] RISC-V: KVM: Add ONE_REG interface for mvendorid,
 marchid, and mimpid
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

On Mon, Nov 28, 2022 at 8:15 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> We add ONE_REG interface for VCPU mvendorid, marchid, and mimpid
> so that KVM user-space can change this details to support migration
> across heterogeneous hosts.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h |  3 +++
>  arch/riscv/kvm/vcpu.c             | 27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 8985ff234c01..92af6f3f057c 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -49,6 +49,9 @@ struct kvm_sregs {
>  struct kvm_riscv_config {
>         unsigned long isa;
>         unsigned long zicbom_block_size;
> +       unsigned long mvendorid;
> +       unsigned long marchid;
> +       unsigned long mimpid;
>  };
>
>  /* CORE registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 312a8a926867..7c08567097f0 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -276,6 +276,15 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
>                         return -EINVAL;
>                 reg_val = riscv_cbom_block_size;
>                 break;
> +       case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> +               reg_val = vcpu->arch.mvendorid;
> +               break;
> +       case KVM_REG_RISCV_CONFIG_REG(marchid):
> +               reg_val = vcpu->arch.marchid;
> +               break;
> +       case KVM_REG_RISCV_CONFIG_REG(mimpid):
> +               reg_val = vcpu->arch.mimpid;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -338,6 +347,24 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
>                 return -EOPNOTSUPP;
> +       case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> +               if (!vcpu->arch.ran_atleast_once)
> +                       vcpu->arch.mvendorid = reg_val;
> +               else
> +                       return -EBUSY;
> +               break;
> +       case KVM_REG_RISCV_CONFIG_REG(marchid):
> +               if (!vcpu->arch.ran_atleast_once)
> +                       vcpu->arch.marchid = reg_val;
> +               else
> +                       return -EBUSY;
> +               break;
> +       case KVM_REG_RISCV_CONFIG_REG(mimpid):
> +               if (!vcpu->arch.ran_atleast_once)
> +                       vcpu->arch.mimpid = reg_val;
> +               else
> +                       return -EBUSY;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
