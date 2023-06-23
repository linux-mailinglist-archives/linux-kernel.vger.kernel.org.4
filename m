Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9C73B6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFWMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:06:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9819F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:06:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnbZ427kNz4x0G;
        Fri, 23 Jun 2023 22:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1687521998;
        bh=14g21Mh5EhtW+URVViyzH8TLZLTiZeLvsA83Nr58f6M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jkyma8uqjskMwyNDlxmqd4CV5nhmm32UwhbZWW5zect5BD9l3IySuyg+2sPPeXgqD
         7s7+UoN8tRpVb0sM0GHgMeZLtJ/j87WLkphy6qAr8nJ9oD1dR8YtJwzyeK+rs65hHS
         2i+PKasIOuVG7QAQoOPqkPiTKZdFYlO31B57vTbXT8uQwu4xmYgCOFPcev+q5wPQyr
         VESqMEW+ckhkGWNpddp9ffdnmO3RSZJUrsyKXPwGr2s+2YhcIn91gMpe7d1yDyHN8F
         qSu83gulbchhRxFoMks0WK+lR5mHThJ5yJRGDX1P0sQALqbyMQstX7LgKjccewrgm9
         hW9V8rfX8wSrw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: Move arch_trigger_cpumask_backtrace from
 nmi.h to irq.h
In-Reply-To: <20230622202816.v2.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
References: <20230622202816.v2.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
Date:   Fri, 23 Jun 2023 22:06:28 +1000
Message-ID: <875y7ez8l7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> writes:
> The powerpc architecture was the only one that defined
> arch_trigger_cpumask_backtrace() in asm/nmi.h instead of
> asm/irq.h. Move it to be consistent.
>
> This fixes compile time errors introduced by commit 7ca8fe94aa92
> ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH"). That commit
> caused <asm/nmi.h> to stop being included if the hardlockup detector
> wasn't enabled. The specific errors were:
>   error: implicit declaration of function =E2=80=98nmi_cpu_backtrace=E2=
=80=99
>   error: implicit declaration of function =E2=80=98nmi_trigger_cpumask_ba=
cktrace=E2=80=99
>
> NOTE: when moving this into irq.h, we also change the guards from just
> checking if "CONFIG_NMI_IPI" is defined to also checking if
> "CONFIG_PPC_BOOK3S_64" is defined. This matches the code in
> arch/powerpc/kernel/stacktrace.c. Previously this worked because
> <asm.nmi.h> was included if "CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH" was
> defined. For powerpc that's only selected if "CONFIG_PPC_BOOK3S_64" is
> defined.
>
> Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARC=
H")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Closes: https://lore.kernel.org/r/871qi5otdh.fsf@mail.lhotse
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'd expect that this would land in Andrew Morton's tree along with the
> other lockup detector stuff.
>
> Changes in v2:
> - Change the guards to include CONFIG_PPC_BOOK3S_64.

Thanks, this fixes all the build errors AFAICS.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

>  arch/powerpc/include/asm/irq.h | 6 ++++++
>  arch/powerpc/include/asm/nmi.h | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/ir=
q.h
> index 94dffa1dd223..f257cacb49a9 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -53,5 +53,11 @@ void __do_IRQ(struct pt_regs *regs);
>=20=20
>  int irq_choose_cpu(const struct cpumask *mask);
>=20=20
> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
> +extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> +					   bool exclude_self);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +#endif
> +
>  #endif /* _ASM_IRQ_H */
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nm=
i.h
> index ce25318c3902..49a75340c3e0 100644
> --- a/arch/powerpc/include/asm/nmi.h
> +++ b/arch/powerpc/include/asm/nmi.h
> @@ -9,12 +9,6 @@ void watchdog_hardlockup_set_timeout_pct(u64 pct);
>  static inline void watchdog_hardlockup_set_timeout_pct(u64 pct) {}
>  #endif
>=20=20
> -#ifdef CONFIG_NMI_IPI
> -extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> -					   bool exclude_self);
> -#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> -#endif
> -
>  extern void hv_nmi_check_nonrecoverable(struct pt_regs *regs);
>=20=20
>  #endif /* _ASM_NMI_H */
> --=20
> 2.41.0.162.gfafddb0af9-goog
