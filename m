Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6956A6556
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCACMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCACMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:12:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8D37F13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:12:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79AE8B80ED2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B5AC433A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677636761;
        bh=WQwj4g+c6pia1p0AWFf8ndGN1cpwyLT1z+Tt2NxY50c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MXqfTTplRPjeJYjPqPOYxOhxto+XhkJR/uC+bVfw6Ugtk0bw7VlkPzFj+GTZF/EVZ
         J+HDDnRU5z4H5z8SAkUtFMPfsYzytzoyjCpYNwLUPkbTxzWUL0WFyASu+6pfwzx2i6
         1//6PRxduSNz/zrZDv+jpemY/JcAIoSCnBG8iZ7sIBBCuAfBWNaYvqaQp3Bvgcudzf
         JnmUsUM8EnRo1T/1XRyS/YHVib1BK0ir/T/45y5rP8zUu4AujdRrLZoISLM29hNDuc
         P6I8Z4PWZ4rwOLW+orCGCrgSi/qGkqI9vRkU0hLjd+on1Pd5dTphpKat/UqiXpizN2
         f0r8lWjxemkYw==
Received: by mail-ed1-f43.google.com with SMTP id o15so45522039edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:12:40 -0800 (PST)
X-Gm-Message-State: AO0yUKVTiRzIGZBlBHmacYk3OsT+ef7QvArQtliF2hsGuJEjWO2aSTKb
        BMtz8H4LleGD7SZ57QVRWMiiIjLjiMhDXc9AGjA=
X-Google-Smtp-Source: AK7set/hKUduL3lG+qsAohuQwiOTLLYsYAQXWwQU/yAFelANu/NMhX1IUEhgF6SyNuV/72lOL/2bkdwugZuZo5VIkOM=
X-Received: by 2002:a17:906:1c10:b0:877:747c:9745 with SMTP id
 k16-20020a1709061c1000b00877747c9745mr2230256ejg.8.1677636759184; Tue, 28 Feb
 2023 18:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20230228215435.3366914-1-heiko@sntech.de> <20230228215435.3366914-3-heiko@sntech.de>
In-Reply-To: <20230228215435.3366914-3-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Mar 2023 10:12:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS6unB89L7OBXA9EyuzAmczenuLZxsHogTcaYVnYV4TuQ@mail.gmail.com>
Message-ID: <CAJF2gTS6unB89L7OBXA9EyuzAmczenuLZxsHogTcaYVnYV4TuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        samuel@sholland.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:54=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wro=
te:
>
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> T-Head C9xx cores implement an older version (0.7.1) of the vector
> specification.
>
> Relevant changes concerning the kernel are:
> - different placement of the SR_VS bit for the vector unit status
> - different encoding of the vsetvli instruction
> - different instructions for loads and stores
>
> And a fixed VLEN of 128.
>
> The in-kernel access to vector instances is limited to the save and
> restore of process states so the above mentioned areas can simply be
> handled via the alternatives framework, similar to other T-Head specific
> issues.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/Kconfig.erratas           |  13 +++
>  arch/riscv/errata/thead/errata.c     |  32 ++++++
>  arch/riscv/include/asm/csr.h         |  26 ++++-
>  arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
>  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
>  5 files changed, 256 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 69621ae6d647..624cefc9fcd7 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -79,4 +79,17 @@ config ERRATA_THEAD_PMU
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD_VECTOR
> +       bool "Apply T-Head Vector errata"
> +       depends on ERRATA_THEAD && RISCV_ISA_V
> +       default y
> +       help
> +         The T-Head C9xx cores implement an earlier version 0.7.1
> +         of the vector extensions.
> +
> +         This will apply the necessary errata to handle the non-standard
> +         behaviour via when switch to and from vector mode for processes=
.
> +
> +         If you don't know what to do here, say "Y".
> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index fac5742d1c1e..55b3aaa2468a 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -12,6 +12,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/errata_list.h>
>  #include <asm/patch.h>
> +#include <asm/vector.h>
>  #include <asm/vendorid_list.h>
>
>  static bool errata_probe_pbmt(unsigned int stage,
> @@ -63,6 +64,34 @@ static bool errata_probe_pmu(unsigned int stage,
>         return true;
>  }
>
> +static bool errata_probe_vector(unsigned int stage,
> +                               unsigned long arch_id, unsigned long impi=
d)
> +{
> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_VECTOR))
> +               return false;
> +
> +       /* target-c9xx cores report arch_id and impid as 0 */
> +       if (arch_id !=3D 0 || impid !=3D 0)
> +               return false;
> +
> +       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT) {
> +               /*
> +                * Disable VECTOR to detect illegal usage of vector in ke=
rnel.
> +                * This is normally done in _start_kernel but with the
> +                * vector-1.0 SR_VS bits. VS is using [24:23] on T-Head's
> +                * vector-0.7.1 and the vector-1.0-bits are unused there.
> +                */
> +               csr_clear(CSR_STATUS, SR_VS_THEAD);
> +               return false;
> +       }
> +
> +       /* let has_vector() return true and set the static vlen */
> +       static_branch_enable(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_VECTOR=
]);
> +       riscv_vsize =3D 128 / 8 * 32;
> +
> +       return true;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>                               unsigned long archid, unsigned long impid)
>  {
> @@ -77,6 +106,9 @@ static u32 thead_errata_probe(unsigned int stage,
>         if (errata_probe_pmu(stage, archid, impid))
>                 cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
>
> +       if (errata_probe_vector(stage, archid, impid))
> +               cpu_req_errata |=3D BIT(ERRATA_THEAD_VECTOR);
> +
>         return cpu_req_errata;
>  }
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 8b06f2472915..8d16c11487aa 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -24,11 +24,27 @@
>  #define SR_FS_CLEAN    _AC(0x00004000, UL)
>  #define SR_FS_DIRTY    _AC(0x00006000, UL)
>
> -#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
> -#define SR_VS_OFF       _AC(0x00000000, UL)
> -#define SR_VS_INITIAL   _AC(0x00000200, UL)
> -#define SR_VS_CLEAN     _AC(0x00000400, UL)
> -#define SR_VS_DIRTY     _AC(0x00000600, UL)
> +#define SR_VS_OFF              _AC(0x00000000, UL)
> +
> +#define SR_VS_1_0              _AC(0x00000600, UL) /* Vector Status */
How about keep SR_VS?

> +#define SR_VS_INITIAL_1_0      _AC(0x00000200, UL)
> +#define SR_VS_CLEAN_1_0                _AC(0x00000400, UL)
> +#define SR_VS_DIRTY_1_0                _AC(0x00000600, UL)
> +
> +#define SR_VS_THEAD            _AC(0x01800000, UL) /* Vector Status */
How about?

#ifdef ERRATA_THEAD_VECTOR
#define SR_VS_0_7

> +#define SR_VS_INITIAL_THEAD    _AC(0x00800000, UL)
> +#define SR_VS_CLEAN_THEAD      _AC(0x01000000, UL)
> +#define SR_VS_DIRTY_THEAD      _AC(0x01800000, UL)
> +
> +/*
> + * Always default to vector-1.0 handling in assembly and let the broken
> + * implementations handle their case separately.
> + */
> +#ifdef __ASSEMBLY__
> +#define SR_VS                  SR_VS_1_0
> +#else
> +
> +#endif
>
>  #define SR_XS          _AC(0x00018000, UL) /* Extension Status */
>  #define SR_XS_OFF      _AC(0x00000000, UL)
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 95e626b7281e..3f93cdd1599f 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -19,7 +19,8 @@
>  #define        ERRATA_THEAD_PBMT 0
>  #define        ERRATA_THEAD_CMO 1
>  #define        ERRATA_THEAD_PMU 2
> -#define        ERRATA_THEAD_NUMBER 3
> +#define        ERRATA_THEAD_VECTOR 3
> +#define        ERRATA_THEAD_NUMBER 4
>  #endif
>
>  #define        CPUFEATURE_SVPBMT 0
> @@ -157,6 +158,65 @@ asm volatile(ALTERNATIVE(                           =
               \
>         : "=3Dr" (__ovl) :                                               =
 \
>         : "memory")
>
> +#ifdef CONFIG_ERRATA_THEAD_PBMT
> +
> +#define ALT_VS_SHIFT 61
> +#define ALT_THEAD_VS_SHIFT 59
> +#define ALT_THEAD_SR_VS(_val, _vs)                                     \
> +asm(ALTERNATIVE(  "li %0, %1\t\nslli %0,%0,%3",                         =
       \
> +                 "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,        \
> +                       ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)    \
> +               : "=3Dr"(_val)                                           =
 \
> +               : "I"(prot##_MAIN >> ALT_SVPBMT_SHIFT),         \
> +                 "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),            \
> +                 "I"(ALT_SVPBMT_SHIFT),                                \
> +                 "I"(ALT_THEAD_PBMT_SHIFT))
> +#else
> +#define ALT_THEAD_SR_VS(_val ## _MAIN)
> +#endif
> +
> +#ifdef CONFIG_ERRATA_THEAD_VECTOR
> +
> +#define THEAD_C9XX_CSR_VXSAT                   0x9
> +#define THEAD_C9XX_CSR_VXRM                    0xa
> +
> +/*
> + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an old=
er
> + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
> + * vsetvli     t4, x0, e8, m8, d1
> + */
> +#define THEAD_VSETVLI_T4X0E8M8D1       ".long  0x00307ed7\n\t"
> +
> +/*
> + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
> + * encoding as the standard vse8.v and vle8.v, compilers seem to optimiz=
e
> + * the call resulting in a different encoding and then using a value for
> + * the "mop" field that is not part of vector-0.7.1
> + * So encode specific variants for vstate_save and _restore.
> + */
> +#define THEAD_VSB_V_V0T0               ".long  0x02028027\n\t"
> +#define THEAD_VSB_V_V8T0               ".long  0x02028427\n\t"
> +#define THEAD_VSB_V_V16T0              ".long  0x02028827\n\t"
> +#define THEAD_VSB_V_V24T0              ".long  0x02028c27\n\t"
> +#define THEAD_VLB_V_V0T0               ".long  0x012028007\n\t"
> +#define THEAD_VLB_V_V8T0               ".long  0x012028407\n\t"
> +#define THEAD_VLB_V_V16T0              ".long  0x012028807\n\t"
> +#define THEAD_VLB_V_V24T0              ".long  0x012028c07\n\t"
> +
> +#define ALT_SR_VS_VECTOR_1_0_SHIFT     9
> +#define ALT_SR_VS_THEAD_SHIFT          23
> +
> +#define ALT_SR_VS(_val, prot)                                          \
> +asm(ALTERNATIVE("li %0, %1\t\nslli %0,%0,%3",                          \
> +               "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,          \
> +               ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)        \
> +               : "=3Dr"(_val)                                           =
 \
> +               : "I"(prot##_1_0 >> ALT_SR_VS_VECTOR_1_0_SHIFT),        \
> +                 "I"(prot##_THEAD >> ALT_SR_VS_THEAD_SHIFT),           \
> +                 "I"(ALT_SR_VS_VECTOR_1_0_SHIFT),                      \
> +                 "I"(ALT_SR_VS_THEAD_SHIFT))
> +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index ad9e6161dd89..ad91f783316e 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -15,6 +15,55 @@
>  #include <asm/hwcap.h>
>  #include <asm/csr.h>
>  #include <asm/asm.h>
> +#include <asm/errata_list.h>
> +
> +#ifdef CONFIG_ERRATA_THEAD_VECTOR
> +
> +static inline u32 riscv_sr_vs(void)
> +{
> +       u32 val;
> +
> +       ALT_SR_VS(val, SR_VS);
> +       return val;
> +}
> +
> +static inline u32 riscv_sr_vs_initial(void)
> +{
> +       u32 val;
> +
> +       ALT_SR_VS(val, SR_VS_INITIAL);
> +       return val;
> +}
> +
> +static inline u32 riscv_sr_vs_clean(void)
> +{
> +       u32 val;
> +
> +       ALT_SR_VS(val, SR_VS_CLEAN);
> +       return val;
> +}
> +
> +static inline u32 riscv_sr_vs_dirty(void)
> +{
> +       u32 val;
> +
> +       ALT_SR_VS(val, SR_VS_DIRTY);
> +       return val;
> +}
> +
> +#define SR_VS          riscv_sr_vs()
> +#define SR_VS_INITIAL  riscv_sr_vs_initial()
> +#define SR_VS_CLEAN    riscv_sr_vs_clean()
> +#define SR_VS_DIRTY    riscv_sr_vs_dirty()
> +
> +#else /* CONFIG_ERRATA_THEAD_VECTOR */
> +
> +#define SR_VS          SR_VS_1_0
> +#define SR_VS_INITIAL  SR_VS_INITIAL_1_0
> +#define SR_VS_CLEAN    SR_VS_CLEAN_1_0
> +#define SR_VS_DIRTY    SR_VS_DIRTY_1_0
> +
> +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
>
>  #define CSR_STR(x) __ASM_STR(x)
>
> @@ -29,6 +78,7 @@ static __always_inline bool has_vector(void)
>  static inline void __vstate_clean(struct pt_regs *regs)
>  {
>         regs->status =3D (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> +
>  }
>
>  static inline void vstate_off(struct pt_regs *regs)
> @@ -58,30 +108,75 @@ static __always_inline void rvv_disable(void)
>
>  static __always_inline void __vstate_csr_save(struct __riscv_v_state *de=
st)
>  {
> -       asm volatile (
> +       register u32 t1 asm("t1") =3D (SR_FS);
> +
> +       /*
> +        * CSR_VCSR is defined as
> +        * [2:1] - vxrm[1:0]
> +        * [0] - vxsat
> +        * The earlier vector spec implemented by T-Head uses separate
> +        * registers for the same bit-elements, so just combine those
> +        * into the existing output field.
> +        *
> +        * Additionally T-Head cores need FS to be enabled when accessing
> +        * the VXRM and VXSAT CSRs, otherwise ending in illegal instructi=
ons.
> +        */
> +       asm volatile (ALTERNATIVE(
>                 "csrr   %0, " CSR_STR(CSR_VSTART) "\n\t"
>                 "csrr   %1, " CSR_STR(CSR_VTYPE) "\n\t"
>                 "csrr   %2, " CSR_STR(CSR_VL) "\n\t"
>                 "csrr   %3, " CSR_STR(CSR_VCSR) "\n\t"
> +               __nops(5),
> +               "csrs   sstatus, t1\n\t"
> +               "csrr   %0, " CSR_STR(CSR_VSTART) "\n\t"
> +               "csrr   %1, " CSR_STR(CSR_VTYPE) "\n\t"
> +               "csrr   %2, " CSR_STR(CSR_VL) "\n\t"
> +               "csrr   %3, " CSR_STR(THEAD_C9XX_CSR_VXRM) "\n\t"
> +               "slliw  %3, %3, " CSR_STR(VCSR_VXRM_SHIFT) "\n\t"
> +               "csrr   t4, " CSR_STR(THEAD_C9XX_CSR_VXSAT) "\n\t"
> +               "or     %3, %3, t4\n\t"
> +               "csrc   sstatus, t1\n\t",
> +               THEAD_VENDOR_ID,
> +               ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>                 : "=3Dr" (dest->vstart), "=3Dr" (dest->vtype), "=3Dr" (de=
st->vl),
> -                 "=3Dr" (dest->vcsr) : :);
> +                 "=3Dr" (dest->vcsr) : "r"(t1) : "t4");
>  }
>
>  static __always_inline void __vstate_csr_restore(struct __riscv_v_state =
*src)
>  {
> -       asm volatile (
> +       register u32 t1 asm("t1") =3D (SR_FS);
> +
> +       /*
> +        * Similar to __vstate_csr_save above, restore values for the
> +        * separate VXRM and VXSAT CSRs from the vcsr variable.
> +        */
> +       asm volatile (ALTERNATIVE(
>                 "vsetvl  x0, %2, %1\n\t"
>                 "csrw   " CSR_STR(CSR_VSTART) ", %0\n\t"
>                 "csrw   " CSR_STR(CSR_VCSR) ", %3\n\t"
> +               __nops(6),
> +               "csrs   sstatus, t1\n\t"
> +               "vsetvl  x0, %2, %1\n\t"
> +               "csrw   " CSR_STR(CSR_VSTART) ", %0\n\t"
> +               "srliw  t4, %3, " CSR_STR(VCSR_VXRM_SHIFT) "\n\t"
> +               "andi   t4, t4, " CSR_STR(VCSR_VXRM_MASK) "\n\t"
> +               "csrw   " CSR_STR(THEAD_C9XX_CSR_VXRM) ", t4\n\t"
> +               "andi   %3, %3, " CSR_STR(VCSR_VXSAT_MASK) "\n\t"
> +               "csrw   " CSR_STR(THEAD_C9XX_CSR_VXSAT) ", %3\n\t"
> +               "csrc   sstatus, t1\n\t",
> +               THEAD_VENDOR_ID,
> +               ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>                 : : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> -                   "r" (src->vcsr) :);
> +                   "r" (src->vcsr), "r"(t1): "t4");
>  }
>
>  static inline void __vstate_save(struct __riscv_v_state *save_to, void *=
datap)
>  {
>         rvv_enable();
>         __vstate_csr_save(save_to);
> -       asm volatile (
> +
> +       asm volatile (ALTERNATIVE(
> +               "nop\n\t"
>                 "vsetvli        t4, x0, e8, m8, ta, ma\n\t"
>                 "vse8.v         v0, (%0)\n\t"
>                 "add            %0, %0, t4\n\t"
> @@ -89,8 +184,18 @@ static inline void __vstate_save(struct __riscv_v_sta=
te *save_to, void *datap)
>                 "add            %0, %0, t4\n\t"
>                 "vse8.v         v16, (%0)\n\t"
>                 "add            %0, %0, t4\n\t"
> -               "vse8.v         v24, (%0)\n\t"
> -               : : "r" (datap) : "t4", "memory");
> +               "vse8.v         v24, (%0)\n\t",
> +               "mv             t0, %0\n\t"
> +               THEAD_VSETVLI_T4X0E8M8D1
> +               THEAD_VSB_V_V0T0
> +               "addi           t0, t0, 128\n\t"
> +               THEAD_VSB_V_V8T0
> +               "addi           t0, t0, 128\n\t"
> +               THEAD_VSB_V_V16T0
> +               "addi           t0, t0, 128\n\t"
> +               THEAD_VSB_V_V24T0, THEAD_VENDOR_ID,
> +               ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
> +               : : "r" (datap) : "t0", "t4", "memory");
>         rvv_disable();
>  }
>
> @@ -98,7 +203,9 @@ static inline void __vstate_restore(struct __riscv_v_s=
tate *restore_from,
>                                     void *datap)
>  {
>         rvv_enable();
> -       asm volatile (
> +
> +       asm volatile (ALTERNATIVE(
> +               "nop\n\t"
>                 "vsetvli        t4, x0, e8, m8, ta, ma\n\t"
>                 "vle8.v         v0, (%0)\n\t"
>                 "add            %0, %0, t4\n\t"
> @@ -106,8 +213,20 @@ static inline void __vstate_restore(struct __riscv_v=
_state *restore_from,
>                 "add            %0, %0, t4\n\t"
>                 "vle8.v         v16, (%0)\n\t"
>                 "add            %0, %0, t4\n\t"
> -               "vle8.v         v24, (%0)\n\t"
> -               : : "r" (datap) : "t4");
> +               "vle8.v         v24, (%0)\n\t",
> +
> +               "mv             t0, %0\n\t"
> +               THEAD_VSETVLI_T4X0E8M8D1
> +               THEAD_VLB_V_V0T0
> +               "addi           t0, t0, 128\n\t"
> +               THEAD_VLB_V_V8T0
> +               "addi           %0, %0, 128\n\t"
> +               THEAD_VLB_V_V16T0
> +               "addi           %0, %0, 128\n\t"
> +               THEAD_VLB_V_V24T0, THEAD_VENDOR_ID,
> +               ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
> +               : : "r" (datap) : "t0", "t4");
> +
>         __vstate_csr_restore(restore_from);
>         rvv_disable();
>  }
> --
> 2.39.0
>


--=20
Best Regards
 Guo Ren
