Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC26AD6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCGFFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:05:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DBA302AF;
        Mon,  6 Mar 2023 21:05:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x11so8357215pln.12;
        Mon, 06 Mar 2023 21:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678165506;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAr/4rZLY/xW2VZEGvfJ9vcha1fPxJBixn7intPRfv8=;
        b=WkCNp7TSaFq1NkStkRRYZf/7HaSOKOYxyg90uy+CWLTCGTo10DoEcaclgmrNVAmQGd
         F0eYRS9Ept+4HdVgZ/Udc7Mu4on10dxvK4uMzKcKkSzWyei6ehYoG3+3UgQX2WiH3h7j
         99T54plxLO+Yitet0Tq/GTHLecJfBjZQOTS2rX6j6uzXLTDJ1y/E+GMvjSx8L8uRBA/k
         iokVfgi5827693E05NqR7ZGq7U+qB+N7fajZDPRhRKk8ZrfkY/T1ifewq0t3i9Vv/T5y
         djXx8rqtqpmGopvsJlT5n9nMYZP7HTFXeU0FpwYbgD/dXmdN7CrqyVA9y1kuTuItMv5h
         Lw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678165506;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAr/4rZLY/xW2VZEGvfJ9vcha1fPxJBixn7intPRfv8=;
        b=INoBtD4F17Bjoo+sHit7PgStMF8kLv48UA8l2aFs6QPcWcc/obZomX1TObtNlpVZMP
         fgj3mrqTRvtOkOJ7//OoUMKnrQnbcVly5kCpeZaRSXNmHh3wM6vS5vV/cW0mwE0TPRIt
         T/IfKnu4MXNOceSKnZadEsszLqoaWqhZeOsdWBJU32uRV4rrLE9ZlcwpWc8XtC3eGYjx
         p1ljke9Fsv+UZVIywL61lWt9DBFlraJxfzcLgD3Tw5IrLdCvlh1kodoVshbz3lJK9C1U
         qbjCyXrZa4RvqmbyKC1yEgUj7YnHCG4jec4zy8C1C9Lvhc0gwjf0ZlnjiCw+Y+qa6z3Z
         YEfw==
X-Gm-Message-State: AO0yUKXB05F9FoSRKJmnq4nkorra0JFm/M5P4UWye/NAHwkMGKGi+GYP
        JwTQtlJqP3HSgxk3ZCIsYwg=
X-Google-Smtp-Source: AK7set9xG2nILH4DDb0/bsgn5KroT2orbcWVxChMuR5XTi8NyBVoYfcVbAvq+8KCW1mCDCO4Kv/knw==
X-Received: by 2002:a17:903:1d1:b0:19e:6947:3b27 with SMTP id e17-20020a17090301d100b0019e69473b27mr17886346plh.58.1678165506568;
        Mon, 06 Mar 2023 21:05:06 -0800 (PST)
Received: from localhost ([203.220.77.23])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902cf4700b0019adfb96084sm7550173plg.36.2023.03.06.21.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:05:05 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Mar 2023 15:05:01 +1000
Message-Id: <CQZW0SBFI6QM.3FW6O6LJ0PVS1@bobo>
Subject: Re: [RFC PATCH 04/13] powerpc/dexcr: Support userspace ROP
 protection
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Benjamin Gray" <bgray@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Cc:     <ajd@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <cmr@bluescreens.de>
X-Mailer: aerc 0.13.0
References: <20221128024458.46121-1-bgray@linux.ibm.com>
 <20221128024458.46121-5-bgray@linux.ibm.com>
In-Reply-To: <20221128024458.46121-5-bgray@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 28, 2022 at 12:44 PM AEST, Benjamin Gray wrote:
> The ISA 3.1B hashst and hashchk instructions use a per-cpu SPR HASHKEYR
> to hold a key used in the hash calculation. This key should be different
> for each process to make it harder for a malicious process to recreate
> valid hash values for a victim process.
>
> Add support for storing a per-thread hash key, and setting/clearing
> HASHKEYR appropriately.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/kexec.h |  3 +++
>  arch/powerpc/include/asm/processor.h       |  1 +
>  arch/powerpc/include/asm/reg.h             |  1 +
>  arch/powerpc/kernel/process.c              | 12 ++++++++++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/kexec.h b/arch/powerpc/in=
clude/asm/book3s/64/kexec.h
> index 563baf94a962..163de935df28 100644
> --- a/arch/powerpc/include/asm/book3s/64/kexec.h
> +++ b/arch/powerpc/include/asm/book3s/64/kexec.h
> @@ -24,6 +24,9 @@ static inline void reset_sprs(void)
>  	if (cpu_has_feature(CPU_FTR_ARCH_31))
>  		mtspr(SPRN_DEXCR, 0);
> =20
> +	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
> +		mtspr(SPRN_HASHKEYR, 0);
> +
>  	/*  Do we need isync()? We are going via a kexec reset */
>  	isync();
>  }
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/=
asm/processor.h
> index c17ec1e44c86..2381217c95dc 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -264,6 +264,7 @@ struct thread_struct {
>  	unsigned long   mmcr3;
>  	unsigned long   sier2;
>  	unsigned long   sier3;
> +	unsigned long	hashkeyr;
> =20
>  #endif
>  };
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index cdd1f174c399..854664cf844f 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -384,6 +384,7 @@
>  #define SPRN_HRMOR	0x139	/* Real mode offset register */
>  #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
>  #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
> +#define SPRN_HASHKEYR	0x1D4	/* Non-privileged hashst/hashchk key registe=
r */
>  #define SPRN_ASDR	0x330	/* Access segment descriptor register */
>  #define SPRN_DEXCR	0x33C	/* Dynamic execution control register */
>  #define   DEXCR_PRO_MASK(aspect)	__MASK(63 - (32 + (aspect)))	/* Aspect =
number to problem state aspect mask */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 17d26f652b80..4d7b0c7641d0 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1229,6 +1229,9 @@ static inline void restore_sprs(struct thread_struc=
t *old_thread,
>  	    old_thread->tidr !=3D new_thread->tidr)
>  		mtspr(SPRN_TIDR, new_thread->tidr);
> =20
> +	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
> +		mtspr(SPRN_HASHKEYR, new_thread->hashkeyr);

I wonder if we'd want to avoid switching it when switching to kernel
threads, and from kernel thread back to the same user thread. Might
want to optimise it to do that in future but for an initial enablement
patch this is okay.

> +
>  	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>  		unsigned long new_dexcr =3D get_thread_dexcr(new_thread);
> =20
> @@ -1818,6 +1821,10 @@ int copy_thread(struct task_struct *p, const struc=
t kernel_clone_args *args)
>  		childregs->ppr =3D DEFAULT_PPR;
> =20
>  	p->thread.tidr =3D 0;
> +#endif
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
> +		p->thread.hashkeyr =3D current->thread.hashkeyr;
>  #endif

Similar comment about your accessor style, if we had get/set_thread_hashkey=
r()
functions then no ifdef required.

I think it is not quite per-process? I don't actually know how the user
toolchain side is put together, but I'm thinking we can not give it a new
salt on fork(), but we could on exec(). I think we could actually give
each thread their own salt within a process too, right?

I don't know off the top of my head whether that can be translated into
a simple test at the copy_thread level. For now you're giving out a new
salt on exec I think, which should be fine at least to start with.

Thanks,
Nick

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>  	/*
>  	 * Run with the current AMR value of the kernel
> @@ -1947,6 +1954,11 @@ void start_thread(struct pt_regs *regs, unsigned l=
ong start, unsigned long sp)
>  	current->thread.load_tm =3D 0;
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
>  #ifdef CONFIG_PPC_BOOK3S_64
> +	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE)) {
> +		current->thread.hashkeyr =3D get_random_long();
> +		mtspr(SPRN_HASHKEYR, current->thread.hashkeyr);
> +	}
> +
>  	if (cpu_has_feature(CPU_FTR_ARCH_31))
>  		mtspr(SPRN_DEXCR, get_thread_dexcr(&current->thread));
>  #endif /* CONFIG_PPC_BOOK3S_64 */
> --=20
> 2.38.1

