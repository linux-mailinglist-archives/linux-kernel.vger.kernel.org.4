Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9635EBB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiI0HB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiI0HBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:01:45 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4884647D7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:01:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o64so10898323oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E70VKyNLfpMrN2tn7yjuSAsildf4GsIvIX1OrG9E27A=;
        b=UlhRPDv8KPSw5JAfrPJnfDIOW8t6C5FofP5Prw+qe8oCdExQfzbSkHqYw9dhGZqdwY
         9O/IcEBXe3TKQL4qDnAsBzgM4NGT1vjK0WfFzvwwKwvrVEb73lQXEYeJB4BV8YMNHntj
         9QS96gOTmOaCEe4qBkSttmdlT2ayErfE17jzU4rCx4G7ZlDsOk0MAUmUh4yBe7qYsDUf
         ROAPNwj73sQMg1AuvDqz+IoEL3Dz1I/oraIzDUM/GIkaeWhwTTwTHCf32VZfviV32XwI
         039lsOHpsSVKQsysW5ZkkaXmw0008PIh5c3R5G3PO7tgE3ujDL3PbQQKkpaE7UkLDi11
         X5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E70VKyNLfpMrN2tn7yjuSAsildf4GsIvIX1OrG9E27A=;
        b=lqOsfPyWi/n5vpf9BjnLlP33fZbJre2XpwxpYaSnexCQ7SMiSfTRllTBzx8dlaw2cq
         izVuSBfSmtlunOckjutLfrbs/WM1Wl1p4Z4KmFZrVsY5w50LjDa8DZhAIbzf3ZmCEE+G
         yiCPzwL3LR/harSOTHEdit9zjIJBiyijosWs+/IqcQNtnaLsdXmoiu21EpsXekB6XgBp
         t9IXax0dVniOb+X/VCUtUhkjgFX0HncpsaccCJogWRLKW1fQdzv80290yr5Ztu+RHTiy
         7C/YgAlNyQkA9mxekGts51HNpg4EGACpaZRMd0R12u1XeiZCTiI1RFn+LE1VzlFuB19j
         YzhQ==
X-Gm-Message-State: ACrzQf3m5OQsyHUKs55mZ/QEsHQww8LgjzmbYsgS91ArCgjKkKcf5drt
        1bFhS3wjwVyUcYuZtXxBiBl+a88hjMJX37/s4OqqXg==
X-Google-Smtp-Source: AMsMyM48X52ODBTPeaSHNnAoqOvvgHXVb73r8V2XWVzzxofRB/Dj3lT4BzwCNHtWbEXNso+iipBKIqOGxW4X/1wJlWo=
X-Received: by 2002:aca:4286:0:b0:350:a3fd:f6df with SMTP id
 p128-20020aca4286000000b00350a3fdf6dfmr1140069oia.61.1664262098931; Tue, 27
 Sep 2022 00:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220927002715.2142353-1-mizhang@google.com>
In-Reply-To: <20220927002715.2142353-1-mizhang@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 27 Sep 2022 00:01:22 -0700
Message-ID: <CAAeT=FwqWkbhFLHvr12A2rYdzZuDJWBti=jKQRargvAb6bKtaA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Cleanup the __get_fault_info() to take out
 the code that validates HPFAR
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingwei,

On Mon, Sep 26, 2022 at 5:27 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> Cleanup __get_fault_info() to take out the code that checks HPFAR. The
> conditions in __get_fault_info() that checks if HPFAR contains a valid IPA
> is slightly messy in that several conditions are written within one IF
> statement acrossing multiple lines and are connected with different logical
> operators. Among them, some conditions come from ARM Spec, while others
> come from CPU erratum. This makes the code hard to read and difficult to
> extend.
>
> So, cleanup the function to improve the readability. In particular,
> explicitly specify each condition separately within a newly created inline
> function.
>
> No functional changes are intended.
>
> Suggested-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/arm64/kvm/hyp/include/hyp/fault.h | 36 ++++++++++++++++----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
> index 1b8a2dcd712f..4575500d26ff 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/fault.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
> @@ -41,12 +41,6 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>         return true;
>  }
>
> -static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
> -{
> -       u64 hpfar, far;
> -
> -       far = read_sysreg_el2(SYS_FAR);
> -
>         /*
>          * The HPFAR can be invalid if the stage 2 fault did not
>          * happen during a stage 1 page table walk (the ESR_EL2.S1PTW
> @@ -58,14 +52,30 @@ static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
>          * permission fault or the errata workaround is enabled, we
>          * resolve the IPA using the AT instruction.
>          */
> -       if (!(esr & ESR_ELx_S1PTW) &&
> -           (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
> -            (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
> -               if (!__translate_far_to_hpfar(far, &hpfar))
> -                       return false;
> -       } else {
> +static inline bool __hpfar_is_valid(u64 esr)

Unlike what the name implies, this function returns true for some
cases that HPFAR is not valid (i.e. SEA).  I think the function
returns true when KVM doesn't need HPFAR, or when HPFAR is valid.
IMHO the name might be a bit misleading, although I don't have
a good name for this.  It would be nice to state that in the
comment at least.

Thank you,
Reiji


> +{
> +       if (esr & ESR_ELx_S1PTW)
> +               return true;
> +
> +       if ((esr & ESR_ELx_FSC_TYPE) == FSC_PERM)
> +               return false;
> +
> +       if (cpus_have_final_cap(ARM64_WORKAROUND_834220))
> +               return false;
> +
> +       return true;
> +}
> +
> +static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
> +{
> +       u64 hpfar, far;
> +
> +       far = read_sysreg_el2(SYS_FAR);
> +
> +       if (!__hpfar_is_valid(esr) && !__translate_far_to_hpfar(far, &hpfar))
> +               return false;
> +       else
>                 hpfar = read_sysreg(hpfar_el2);
> -       }
>
>         fault->far_el2 = far;
>         fault->hpfar_el2 = hpfar;
>
> base-commit: c59fb127583869350256656b7ed848c398bef879
> --
> 2.37.3.998.g577e59143f-goog
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
