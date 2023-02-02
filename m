Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37056877DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjBBIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBBIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:50:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7E761C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:49:57 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mc11so3850916ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YEMr8jwJtqEBvUW6IeEvoy6PFpQWvVltt0F9wihv4bc=;
        b=E4VeslbplWo822JEUy/TVhNC3AjWEJtICAApZgk4VjnANKU98n3UtBxM9Lx27SUzZb
         VCTl8nQfoW4L71CcnsAiYB4LB5F6+lGOeBiXou97b7WRakNcb1iB8m2OjwMHHMBm1TgB
         iueYKPTQQh/tNy7xaOgo7bssfHdq68ITQRKsRX4KWF8TTXyK1Nw9+yTzkuIG5W22lNUB
         NOWPKIysHGKjVu5FxtI3n5oqyd1doi3+rwy52r5uRu86hTtJ+McGGjd4FbURprZYu8SB
         fYyakX2igykkWwkEMcYDqWnm+tZ1bvInFqQLOhkrbUHZBktlmPmp9Zr9frSkCFv5TIft
         1m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEMr8jwJtqEBvUW6IeEvoy6PFpQWvVltt0F9wihv4bc=;
        b=rrS/f1MalLA++xqZX1xvRKRwJ2Mj9y7PPqtQqyiUMLzJIg5JJPnCD4Dkpqt34QpTdK
         DeYjBAbvVQO6Vg1FIyto/aLxbAEjQeCtIe0pS/mRDJ7loIWUmBw3HP7YyQJY3SMhWrBe
         nEzLj+cnsNd0keRQzXoavcBttlVnvyZr0RiLyG5t7BIt4sf1s3G2BbiSbNku/c8XbMuR
         CeG1725sTcSCCCWVXca/lCM4WsfwXJ5wn6q66vaxhCZUnhcmSFochCNKWcVGT0TTWu/m
         G8ncSzxF/1boRamd4kFDzL619k3irIv7rJ6HxebOs5JZ0ZXzA0IXeV0tVo0wP7SrIhnw
         89cQ==
X-Gm-Message-State: AO0yUKVhav5Sw64qOp7ZhJ742Ir8A6bozQWXumzqeBsm2qmR/4WHoJLA
        6sXRf3lQpXyBh23k9Q7RtLsdx9WGUIga+L29Wy8tWg==
X-Google-Smtp-Source: AK7set+38N6ru0VcJjhFUKCNehas73Jp8D6FAynbNoh9W4N5K+8dinXtsQKRFrjqrQ5QEKfdEvUkNXxWQWnqjKO2VgI=
X-Received: by 2002:a17:906:7e42:b0:86d:fa64:2941 with SMTP id
 z2-20020a1709067e4200b0086dfa642941mr1889020ejr.72.1675327795914; Thu, 02 Feb
 2023 00:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20230128082847.3055316-1-apatel@ventanamicro.com> <20230128082847.3055316-2-apatel@ventanamicro.com>
In-Reply-To: <20230128082847.3055316-2-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 2 Feb 2023 14:19:44 +0530
Message-ID: <CAAhSdy0GAwpUCTAXn_Gg==MMigFpkRSNHZMFvDQtZQ08zW_a9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RISC-V: KVM: Redirect illegal instruction traps to guest
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 1:59 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Andy Chiu <andy.chiu@sifive.com>
>
> The M-mode redirects an unhandled illegal instruction trap back
> to S-mode. However, KVM running in HS-mode terminates the VS-mode
> software when it receives illegal instruction trap. Instead, KVM
> should redirect the illegal instruction trap back to VS-mode, and
> let VS-mode trap handler decide the next step. This futher allows
> guest kernel to implement on-demand enabling of vector extension
> for a guest user space process upon first-use.
>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Queued this patch for Linux-6.3

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_exit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index af7c4bc07929..4ea101a73d8b 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -182,6 +182,12 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>         ret = -EFAULT;
>         run->exit_reason = KVM_EXIT_UNKNOWN;
>         switch (trap->scause) {
> +       case EXC_INST_ILLEGAL:
> +               if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV) {
> +                       kvm_riscv_vcpu_trap_redirect(vcpu, trap);
> +                       ret = 1;
> +               }
> +               break;
>         case EXC_VIRTUAL_INST_FAULT:
>                 if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
>                         ret = kvm_riscv_vcpu_virtual_insn(vcpu, run, trap);
> --
> 2.34.1
>
