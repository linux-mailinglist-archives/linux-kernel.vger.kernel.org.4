Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C291C61E8D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKGDFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKGDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:05:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9109560FF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:05:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d26so26666697eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDkpvmLdCcNS/SK5D2IL8ltTmU7MAjuwj9on9XdxjqM=;
        b=O2GdYT7cMyZAwXXzVaGGer2516sCwb8nVa+3zH1uKyisQxoW9HAvhvHCOOJeufiTbl
         F3Np7E0Q60MoiXXzv7QKKfVpPuct8EOqbYhrz0wkX1SdRI+8oB73JExLBlUhlEORndI0
         oR5Ci6Q9Zji0dGkOeDy61S11yj8qgzFtdaxDEMNt1vXTTwBDofXJXEd/zzO2opd/NDJm
         j1f/gZ4KRV3uPIBqcQXujsk4akPpTe+2a2n4m0j+UpZ//j9kycunMnHpdO3L/Ji7eqnQ
         U523Q+8cijpVSXguZZnGJMRJTHTEr5k6EgUTEZqzTJSespExVQpXPGZ+H7/pFHIEuIGk
         PlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDkpvmLdCcNS/SK5D2IL8ltTmU7MAjuwj9on9XdxjqM=;
        b=0GdjoDFa5v5krUxUd+UDLBpi199Ti0b+oKTP3HspDZCv4GYwy+WAAnPBodVISvAPZj
         hlxIEIibJ+ZcGIxNYMfgrCfvDbwbeGCXuwPQhnkrzQTpwxtOy4DIlp4UdVJz/wsafles
         WzMnILGEO1tCnprahdYUURRg6l9GpnuaTtkLFBbNO4uPETzLGwt3D9XvyVRxX2BZtEkU
         +KBX6nEmpn6JC8H6g186Ol9wobtnyJMMhAUeWXT9L7P8+MGGkpvcAZFZOr4dD6ftctLR
         +huTFni8MJACHsSPoKSZCJGOHEl3PS0j5jzUKtCgHW+9Lb03P5nTpfnWAt18AfwUFvGw
         n2RQ==
X-Gm-Message-State: ACrzQf1X6yAt2xhHqpRmYooKxYxf9GczRlWFRRpmGQ+b3mmFUTeHfvXL
        zoZq5R8VF3z6ziPQ7kyJ+PqXW0yMB7GU0HhgD8uRlQ==
X-Google-Smtp-Source: AMsMyM525hQagKYMIlOIdqQEy/Sx/ht089FGqr8YQw810BAnhG6hulq/sfu3BFpHCBMEkVy5m+xwSwFEwA0SvamrVJs=
X-Received: by 2002:a17:906:eec7:b0:733:189f:b07a with SMTP id
 wu7-20020a170906eec700b00733189fb07amr46182007ejb.230.1667790314965; Sun, 06
 Nov 2022 19:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com> <20221102231911.3107438-23-seanjc@google.com>
In-Reply-To: <20221102231911.3107438-23-seanjc@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 7 Nov 2022 08:35:03 +0530
Message-ID: <CAAhSdy01NfFuHCsA1mrcxERL+=8F=PQbD_Nu7qvdKQOyQ_p9Tw@mail.gmail.com>
Subject: Re: [PATCH 22/44] KVM: RISC-V: Do arch init directly in riscv_kvm_init()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 4:49 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Fold the guts of kvm_arch_init() into riscv_kvm_init() instead of
> bouncing through kvm_init()=>kvm_arch_init().  Functionally, this is a
> glorified nop as invoking kvm_arch_init() is the very first action
> performed by kvm_init().
>
> Moving setup to riscv_kvm_init(), which is tagged __init, will allow
> tagging more functions and data with __init and __ro_after_init.  And
> emptying kvm_arch_init() will allow dropping the hook entirely once all
> architecture implementations are nops.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/main.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index a146fa0ce4d2..cb063b8a9a0f 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -66,6 +66,15 @@ void kvm_arch_hardware_disable(void)
>  }
>
>  int kvm_arch_init(void *opaque)
> +{
> +       return 0;
> +}
> +
> +void kvm_arch_exit(void)
> +{
> +}
> +
> +static int __init riscv_kvm_init(void)
>  {
>         const char *str;
>
> @@ -110,15 +119,6 @@ int kvm_arch_init(void *opaque)
>
>         kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
>
> -       return 0;
> -}
> -
> -void kvm_arch_exit(void)
> -{
> -}
> -
> -static int __init riscv_kvm_init(void)
> -{
>         return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>  }
>  module_init(riscv_kvm_init);
> --
> 2.38.1.431.g37b22c650d-goog
>
