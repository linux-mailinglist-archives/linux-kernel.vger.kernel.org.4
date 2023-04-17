Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7D6E50A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDQTK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091081703
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707DB620A0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F632C4339B;
        Mon, 17 Apr 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758625;
        bh=yCXjwKoRnqaD54nqpiHI7E6bMmJjLV9DRWQe3iPXcU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1jYU5nwi8VcN7iCsX4LB+6L2iZDQarFJEQPAFbOJkpD63dvSLOJS6E81JEFEGr+U
         hpEQyltNaE+ntyGtulDZati5Z7mjnW6HUYLloRWb30M8fBXkCWcm8GCJR5XfvaS1iS
         CPVLGhYmHOr/gcbfIuDGgKCDjhqOLn/fUWGx1yYKlro3/kSQYeBI2eIyON9vEikFAS
         AMPkq13IaRFmQokfF+erhO30b2kPhyjwxZ+dnS8FqpJ5d3XMW//0ekNv9k89cBwnX4
         V4VpNIaeBKaEInXdXuDYDWNY0L5NF7GfKVAoWKoMXswmZp6KjWjeehV1+PrPBbsxRn
         ep1i4V2diKGsQ==
Date:   Mon, 17 Apr 2023 20:10:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>
Subject: Re: [RFC PATCH 2/2] RISC-V: Add support for sqoscfg CSR
Message-ID: <20230417-culinary-capillary-4f1efd496691@spud>
References: <20230410043646.3138446-1-dfustini@baylibre.com>
 <20230410043646.3138446-3-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tw0z1flI5Ff7cn7l"
Content-Disposition: inline
In-Reply-To: <20230410043646.3138446-3-dfustini@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tw0z1flI5Ff7cn7l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Drew,

(Don't get your hopes up, I don't have anything really meaningful to
contribute, sorry.)

On Sun, Apr 09, 2023 at 09:36:46PM -0700, Drew Fustini wrote:
> Add support for the sqoscfg CSR defined in the Ssqosid ISA extension
> (Supervisor-mode Quality of Service ID). The CSR contains two fields:
>=20
>   - Resource Control ID (RCID) used determine resource allocation
>   - Monitoring Counter ID (MCID) used to track resource usage
>=20
> Requests from a hart to shared resources like cache will be tagged with
> these IDs. This allows the usage of shared resources to be associated
> with the task currently running on the hart.
>=20
> A sqoscfg field is added to thread_struct and has the same format as the
> sqoscfg CSR. This allows the scheduler to set the hart's sqoscfg CSR to
> contain the RCID and MCID for the task that is being scheduled in. The
> sqoscfg CSR is only written to if the thread_struct.sqoscfg is different
> from the current value of the CSR.
>=20
> A per-cpu variable cpu_sqoscfg is used to mirror that state of the CSR.
> This is because access to L1D hot memory should be several times faster
> than a CSR read. Also, in the case of virtualization, accesses to this
> CSR are trapped in the hypervisor.
>=20
> Link: https://github.com/riscv-non-isa/riscv-cmqri/blob/main/riscv-cbqri.=
pdf
> Co-developed-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> Signed-off-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Note: the Ssqosid extension and CBQRI spec are still in a draft state.
> The CSR address of sqoscfg is not final.
>=20
> Changes from the original patch [1]:
> - Rebase from 6.0 to 6.3
> - Simplify per-cpu variable from struct to u32 with just sqoscfg
> - Move qoscfg to thread_struct in arch/riscv/include/asm/processor.h
>   This avoids changing task_struct in /include/linux/sched.h
> - Reword commit description
> - Reword Kconfig description
>=20
> [1] https://github.com/rivosinc/linux/commit/8454b793a62be21d39e5826ef524=
1dfa06198ba9
>=20
>  arch/riscv/Kconfig                 | 19 ++++++++++++++
>  arch/riscv/include/asm/csr.h       |  8 ++++++
>  arch/riscv/include/asm/processor.h |  3 +++
>  arch/riscv/include/asm/qos.h       | 40 ++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/switch_to.h |  2 ++
>  5 files changed, 72 insertions(+)
>  create mode 100644 arch/riscv/include/asm/qos.h
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index cc02eb9eee1f..03f22b7fe34b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -418,6 +418,25 @@ config RISCV_ISA_SVNAPOT
> =20
>  	  If you don't know what to do here, say Y.
> =20
> +config RISCV_ISA_SSQOSID
> +	bool "Ssqosid extension support"
> +	default y
> +	help
> +	  Adds support for the Ssqosid ISA extension (Supervisor-mode
> +	  Quality of Service ID).

Could you add "long form" text in brackets here to the bool line, a la:
https://patchwork.kernel.org/project/linux-riscv/patch/20230405-pucker-cogw=
heel-3a999a94a2f2@wendy/

> +
> +	  Ssqosid defines the sqoscfg CSR which allows the system to tag
> +	  the running process with RCID (Resource Control ID) and MCID
> +	  (Monitoring Counter ID). The RCID is used determine resource
> +	  allocation. The MCID is used to track resource usage in event
> +	  counters.
> +
> +	  For example, a cache controller may use the RCID to apply a
> +	  cache partitioning scheme and use the MCID to track how much
> +	  cache a process, or a group of processes, is using.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config RISCV_ISA_SVPBMT
>  	bool "SVPBMT extension support"
>  	depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 7c2b8cdb7b77..17d04a0cacd6 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -59,6 +59,13 @@
>  #define SATP_ASID_MASK	_AC(0xFFFF, UL)
>  #endif
> =20
> +/* SQOSCFG fields */
> +#define SQOSCFG_RCID_MASK	_AC(0x00000FFF, UL)
> +#define SQOSCFG_MCID_MASK	SQOSCFG_RCID_MASK
> +#define SQOSCFG_MCID_SHIFT	16
> +#define SQOSCFG_MASK		((SQOSCFG_MCID_MASK << SQOSCFG_MCID_SHIFT) | \
> +				  SQOSCFG_RCID_MASK)
> +
>  /* Exception cause high bit - is an interrupt if set */
>  #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
> =20
> @@ -245,6 +252,7 @@
>  #define CSR_STVAL		0x143
>  #define CSR_SIP			0x144
>  #define CSR_SATP		0x180
> +#define CSR_SQOSCFG		0x181
> =20
>  #define CSR_STIMECMP		0x14D
>  #define CSR_STIMECMPH		0x15D
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index 94a0590c6971..724b2aa2732d 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -39,6 +39,9 @@ struct thread_struct {
>  	unsigned long s[12];	/* s[0]: frame pointer */
>  	struct __riscv_d_ext_state fstate;
>  	unsigned long bad_cause;
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +	u32 sqoscfg;
> +#endif
>  };
> =20
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> new file mode 100644
> index 000000000000..297e7fb64d80
> --- /dev/null
> +++ b/arch/riscv/include/asm/qos.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_QOS_H
> +#define _ASM_RISCV_QOS_H
> +
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +
> +#include <linux/sched.h>
> +#include <linux/jump_label.h>
> +
> +#include <asm/barrier.h>
> +#include <asm/csr.h>
> +#include <asm/hwcap.h>
> +
> +/* cached value of sqoscfg csr for each cpu */
> +static DEFINE_PER_CPU(u32, cpu_sqoscfg);
> +
> +static void __qos_sched_in(struct task_struct *task)
> +{
> +	u32 *cpu_sqoscfg_ptr =3D this_cpu_ptr(&cpu_sqoscfg);
> +	u32 thread_sqoscfg;
> +
> +	thread_sqoscfg =3D READ_ONCE(task->thread.sqoscfg);
> +
> +	if (thread_sqoscfg !=3D *cpu_sqoscfg_ptr) {
> +		*cpu_sqoscfg_ptr =3D thread_sqoscfg;
> +		csr_write(CSR_SQOSCFG, thread_sqoscfg);
> +	}
> +}
> +
> +static inline void qos_sched_in(struct task_struct *task)

"qos" is a pretty generic prefix, no? Do you think we'd be better off
prefixing this (and every other extension related thing) with `riscv_`?

> +{
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_SSQOSID))
> +		__qos_sched_in(task);
> +}
> +#else
> +
> +static inline void qos_sched_in(struct task_struct *task) {}
> +
> +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> +#endif /* _ASM_RISCV_QOS_H */
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 60f8ca01d36e..75d9bfd766af 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -12,6 +12,7 @@
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <asm/qos.h>
> =20
>  #ifdef CONFIG_FPU
>  extern void __fstate_save(struct task_struct *save_to);
> @@ -79,6 +80,7 @@ do {							\
>  	if (has_fpu())					\
>  		__switch_to_aux(__prev, __next);	\
>  	((last) =3D __switch_to(__prev, __next));		\
> +	qos_sched_in(__next);				\

Both FPU and vector do:
|	if (has_fpu())					\
|		__switch_to_fpu(__prev, __next);	\
|	if (has_vector())				\
|		__switch_to_vector(__prev, __next);	\

Is it just my OCD that wants ssqosid to be the same?
It'd also do away with that seems a bit weird to me: having
qos_sched_in() and __qos_sched_in().
Even if you don't make them similar, what's the rationale behind not
inverting the extension check & returning early from a single function.

This is kinda above my pay grade, so let me know what I've inevitably
missed,
Conor.

> =20
>  #endif /* _ASM_RISCV_SWITCH_TO_H */
> --=20
> 2.34.1
>=20

--Tw0z1flI5Ff7cn7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD2ZnAAKCRB4tDGHoIJi
0vLTAQDGkLnWsmQt646uefVhaTXvfTn0++As1HwREmulLGS+rgEA7r/IXR2OECZO
KbR7orDq25nByBfalRIlUutraceTjgk=
=IClB
-----END PGP SIGNATURE-----

--Tw0z1flI5Ff7cn7l--
