Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317B5E9E89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiIZKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiIZKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240B29C89;
        Mon, 26 Sep 2022 03:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE60B808BF;
        Mon, 26 Sep 2022 10:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92076C43144;
        Mon, 26 Sep 2022 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664186539;
        bh=/Grnw5xz+I8FeJB7NWVpe6UARW+6jjFTlGVEHBWm+v0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cp1U5xzNyG4OwkVcvIK0Ep7NskATFqbBNipTzoZgWOYiDIeV2Hs2kMAv74/kGM96S
         ZV3M+FX8Ej4mmOfX6ipvnldAS4ABLQho7mViTK4l+BpS/xgXMIqLt/avTMlLy8ZlP1
         zgNMKANbNz0iCDvoHUiz4H5J/siyGh5Brso07wT5sNA0XtyCnBLX1ZHjitc4czDFav
         DW0VV3WHj7PRe4JTuElzeQqpuV99EYHQyZwkZdTrhcVOEVrMKT+ysr5rZLMxN9wTpL
         jBAjkkfD3lMkgmZACpjuMq4QgzkdeleXe4EaxvaFhIsQsAwpg1hry0xEUKi31+Qb4c
         WCDx7yDqU3Uzg==
Received: by mail-lf1-f47.google.com with SMTP id s6so9987797lfo.7;
        Mon, 26 Sep 2022 03:02:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf1nI8GpGTTXUv6/hXSzpWzdkUqz4ydWQdZxXU73VjJ67+iCTtZN
        t1Pu/keSh64UobDc/iT1KnVrFY+IVHh6nxQp2+I=
X-Google-Smtp-Source: AMsMyM4CQ3pZhFj8Q+q89hGqMMZBYT4id5ilbdDeqbmq6l6XyHFrXbWWYOpiDp0wEIwXbGg+bbAAsSIIv0QVgK65pQ4=
X-Received: by 2002:a05:6512:c0f:b0:49b:1e8c:59fd with SMTP id
 z15-20020a0565120c0f00b0049b1e8c59fdmr7979360lfu.426.1664186536095; Mon, 26
 Sep 2022 03:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com> <20220926093620.99898-17-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20220926093620.99898-17-tianjia.zhang@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Sep 2022 12:02:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF8Fi9cG4p6udRYT4LbCAj0UBXQL12nmQBFEWvZsVX7Wg@mail.gmail.com>
Message-ID: <CAMj1kXF8Fi9cG4p6udRYT4LbCAj0UBXQL12nmQBFEWvZsVX7Wg@mail.gmail.com>
Subject: Re: [PATCH 16/16] crypto: arm64/sm4 - add ARMv9 SVE cryptography
 acceleration implementation
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Mark Brown)

Hello Tianjia,

On Mon, 26 Sept 2022 at 11:37, Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> Scalable Vector Extension (SVE) is the next-generation SIMD extension for
> arm64. SVE allows flexible vector length implementations with a range of
> possible values in CPU implementations. The vector length can vary from a
> minimum of 128 bits up to a maximum of 2048 bits, at 128-bit increments.
> The SVE design guarantees that the same application can run on different
> implementations that support SVE, without the need to recompile the code.
>
> SVE was originally introduced by ARMv8, and ARMv9 introduced SVE2 to
> expand and improve it. Similar to the Crypto Extension supported by the
> NEON instruction set for the algorithm, SVE also supports the similar
> instructions, called cryptography acceleration instructions, but this is
> also optional instruction set.
>
> This patch uses SM4 cryptography acceleration instructions and SVE2
> instructions to optimize the SM4 algorithm for ECB/CBC/CFB/CTR modes.
> Since the encryption of CBC/CFB cannot be parallelized, the Crypto
> Extension instruction is used.
>

Given that we currently do not support the use of SVE in kernel mode,
this patch cannot be accepted at this time (but the rest of the series
looks reasonable to me, although I have only skimmed over the patches)

In view of the disappointing benchmark results below, I don't think
this is worth the hassle at the moment. If we can find a case where
using SVE in kernel mode truly makes a [favorable] difference, we can
revisit this, but not without a thorough analysis of the impact it
will have to support SVE in the kernel. Also, the fact that SVE may
also cover cryptographic extensions does not necessarily imply that a
micro-architecture will perform those crypto transformations in
parallel and so the performance may be the same even if VL > 128.

In summary, please drop this patch for now, and once there are more
encouraging performance numbers, please resubmit it as part of a
series that explicitly enables SVE in kernel mode on arm64, and
documents the requirements and constraints.

I have cc'ed Mark who has been working on the SVE support., who might
have something to add here as well.

Thanks,
Ard.



> Since no test environment with a Vector Length (VL) greater than 128 bits
> was found, the performance data was obtained on a machine with a VL is
> 128 bits, because this driver is enabled when the VL is greater than 128
> bits, so this performance is only for reference. It can be seen from the
> data that there is little difference between the data optimized by Crypto
> Extension and SVE (VL=128 bits), and the optimization effect will be more
> obvious when VL=256 bits or longer.
>
> Benchmark on T-Head Yitian-710 2.75 GHz, the data comes from the 218 mode
> of tcrypt, and compared with that optimized by Crypto Extension.  The
> abscissas are blocks of different lengths. The data is tabulated and the
> unit is Mb/s:
>
> sm4-ce      |      16       64      128      256     1024     1420     4096
> ------------+--------------------------------------------------------------
>     ECB enc |  315.18  1162.65  1815.66  2553.50  3692.91  3727.20  4001.93
>     ECB dec |  316.06  1172.97  1817.81  2554.66  3692.18  3786.54  4001.93
>     CBC enc |  304.82   629.54   768.65   864.72   953.90   963.32   974.06
>     CBC dec |  306.05  1142.53  1805.11  2481.67  3522.06  3587.87  3790.99
>     CFB enc |  309.48   635.70   774.44   865.85   950.62   952.68   968.24
>     CFB dec |  315.98  1170.38  1828.75  2509.72  3543.63  3539.40  3793.25
>     CTR enc |  285.83  1036.59  1583.50  2147.26  2933.54  2954.66  3041.14
>     CTR dec |  285.29  1037.47  1584.67  2145.51  2934.10  2950.89  3041.62
>
> sm4-sve-ce (VL = 128 bits)
>     ECB enc |  310.00  1154.70  1813.26  2579.74  3766.90  3869.45  4100.26
>     ECB dec |  315.60  1176.22  1838.06  2593.69  3774.95  3878.42  4098.83
>     CBC enc |  303.44   622.65   764.67   861.40   953.18   963.05   973.77
>     CBC dec |  302.13  1091.15  1689.10  2267.79  3182.84  3242.68  3408.92
>     CFB enc |  296.62   620.41   762.94   858.96   948.18   956.04   967.67
>     CFB dec |  291.23  1065.50  1637.33  2228.12  3158.52  3213.35  3403.83
>     CTR enc |  272.27   959.35  1466.34  1934.24  2562.80  2595.87  2695.15
>     CTR dec |  273.40   963.65  1471.83  1938.97  2563.12  2597.25  2694.54
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/arm64/crypto/Kconfig           |   19 +
>  arch/arm64/crypto/Makefile          |    3 +
>  arch/arm64/crypto/sm4-sve-ce-core.S | 1028 +++++++++++++++++++++++++++
>  arch/arm64/crypto/sm4-sve-ce-glue.c |  332 +++++++++
>  4 files changed, 1382 insertions(+)
>  create mode 100644 arch/arm64/crypto/sm4-sve-ce-core.S
>  create mode 100644 arch/arm64/crypto/sm4-sve-ce-glue.c
>
> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index 6793d5bc3ee5..bbb5a7a08af5 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -249,6 +249,25 @@ config CRYPTO_SM4_ARM64_CE_BLK
>           - ARMv8 Crypto Extensions
>           - NEON (Advanced SIMD) extensions
>
> +config CRYPTO_SM4_ARM64_SVE_CE_BLK
> +       tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (ARMv9 cryptography acceleration with SVE2)"
> +       depends on KERNEL_MODE_NEON
> +       select CRYPTO_SKCIPHER
> +       select CRYPTO_SM4
> +       select CRYPTO_SM4_ARM64_CE_BLK
> +       help
> +         Length-preserving ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
> +         with block cipher modes:
> +         - ECB (Electronic Codebook) mode (NIST SP800-38A)
> +         - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
> +         - CFB (Cipher Feedback) mode (NIST SP800-38A)
> +         - CTR (Counter) mode (NIST SP800-38A)
> +
> +         Architecture: arm64 using:
> +         - ARMv8 Crypto Extensions
> +         - ARMv9 cryptography acceleration with SVE2
> +         - NEON (Advanced SIMD) extensions
> +
>  config CRYPTO_SM4_ARM64_NEON_BLK
>         tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (NEON)"
>         depends on KERNEL_MODE_NEON
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index 4818e204c2ac..355dd9053434 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -38,6 +38,9 @@ sm4-ce-gcm-y := sm4-ce-gcm-glue.o sm4-ce-gcm-core.o
>  obj-$(CONFIG_CRYPTO_SM4_ARM64_NEON_BLK) += sm4-neon.o
>  sm4-neon-y := sm4-neon-glue.o sm4-neon-core.o
>
> +obj-$(CONFIG_CRYPTO_SM4_ARM64_SVE_CE_BLK) += sm4-sve-ce.o
> +sm4-sve-ce-y := sm4-sve-ce-glue.o sm4-sve-ce-core.o
> +
>  obj-$(CONFIG_CRYPTO_GHASH_ARM64_CE) += ghash-ce.o
>  ghash-ce-y := ghash-ce-glue.o ghash-ce-core.o
>
> diff --git a/arch/arm64/crypto/sm4-sve-ce-core.S b/arch/arm64/crypto/sm4-sve-ce-core.S
> new file mode 100644
> index 000000000000..caecbdf2536c
> --- /dev/null
> +++ b/arch/arm64/crypto/sm4-sve-ce-core.S
> @@ -0,0 +1,1028 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * SM4 Cipher Algorithm for ARMv9 Crypto Extensions with SVE2
> + * as specified in
> + * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
> + *
> + * Copyright (C) 2022, Alibaba Group.
> + * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +.arch  armv8-a+crypto+sve+sve2
> +
> +.irp b, 0, 15, 24, 25, 26, 27, 28, 29, 30, 31
> +       .set .Lv\b\().4s, \b
> +.endr
> +
> +.irp b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, \
> +               16, 24, 25, 26, 27, 28, 29, 30, 31
> +       .set .Lz\b\().s, \b
> +.endr
> +
> +.macro sm4e, vd, vn
> +       .inst 0xcec08400 | (.L\vn << 5) | .L\vd
> +.endm
> +
> +.macro sm4e_sve, zd, zn
> +       .inst 0x4523e000 | (.L\zn << 5) | .L\zd
> +.endm
> +
> +
> +/* Register macros */
> +
> +#define RCTR        z16
> +#define RCTRv       v16
> +#define RIV         z16
> +#define RIVv        v16
> +#define RSWAP128    z17
> +#define RZERO       z18
> +#define RLE128_INC  z19
> +
> +#define RTMP0       z20
> +#define RTMP0v      v20
> +#define RTMP1       z21
> +#define RTMP2       z22
> +#define RTMP3       z23
> +
> +
> +/* Helper macros. */
> +
> +#define SM4_PREPARE(ptr)                                       \
> +               adr_l           x7, .Lbswap128_mask;            \
> +               ptrue           p0.b, ALL;                      \
> +               rdvl            x5, #1;                         \
> +               ld1b            {RSWAP128.b}, p0/z, [x7];       \
> +                                                               \
> +               ld1             {v24.16b-v27.16b}, [ptr], #64;  \
> +               ld1             {v28.16b-v31.16b}, [ptr];       \
> +               dup             z24.q, z24.q[0];                \
> +               dup             z25.q, z25.q[0];                \
> +               dup             z26.q, z26.q[0];                \
> +               dup             z27.q, z27.q[0];                \
> +               dup             z28.q, z28.q[0];                \
> +               dup             z29.q, z29.q[0];                \
> +               dup             z30.q, z30.q[0];                \
> +               dup             z31.q, z31.q[0];
> +
> +#define SM4_SVE_CE_CRYPT_BLK(b0)                               \
> +               revb            b0.s, p0/m, b0.s;               \
> +               sm4e_sve        b0.s, z24.s;                    \
> +               sm4e_sve        b0.s, z25.s;                    \
> +               sm4e_sve        b0.s, z26.s;                    \
> +               sm4e_sve        b0.s, z27.s;                    \
> +               sm4e_sve        b0.s, z28.s;                    \
> +               sm4e_sve        b0.s, z29.s;                    \
> +               sm4e_sve        b0.s, z30.s;                    \
> +               sm4e_sve        b0.s, z31.s;                    \
> +               tbl             b0.b, {b0.b}, RSWAP128.b;       \
> +               revb            b0.s, p0/m, b0.s;
> +
> +#define SM4_SVE_CE_CRYPT_BLK4(b0, b1, b2, b3)                  \
> +               revb            b0.s, p0/m, b0.s;               \
> +               revb            b1.s, p0/m, b1.s;               \
> +               revb            b2.s, p0/m, b2.s;               \
> +               revb            b3.s, p0/m, b3.s;               \
> +               sm4e_sve        b0.s, z24.s;                    \
> +               sm4e_sve        b1.s, z24.s;                    \
> +               sm4e_sve        b2.s, z24.s;                    \
> +               sm4e_sve        b3.s, z24.s;                    \
> +               sm4e_sve        b0.s, z25.s;                    \
> +               sm4e_sve        b1.s, z25.s;                    \
> +               sm4e_sve        b2.s, z25.s;                    \
> +               sm4e_sve        b3.s, z25.s;                    \
> +               sm4e_sve        b0.s, z26.s;                    \
> +               sm4e_sve        b1.s, z26.s;                    \
> +               sm4e_sve        b2.s, z26.s;                    \
> +               sm4e_sve        b3.s, z26.s;                    \
> +               sm4e_sve        b0.s, z27.s;                    \
> +               sm4e_sve        b1.s, z27.s;                    \
> +               sm4e_sve        b2.s, z27.s;                    \
> +               sm4e_sve        b3.s, z27.s;                    \
> +               sm4e_sve        b0.s, z28.s;                    \
> +               sm4e_sve        b1.s, z28.s;                    \
> +               sm4e_sve        b2.s, z28.s;                    \
> +               sm4e_sve        b3.s, z28.s;                    \
> +               sm4e_sve        b0.s, z29.s;                    \
> +               sm4e_sve        b1.s, z29.s;                    \
> +               sm4e_sve        b2.s, z29.s;                    \
> +               sm4e_sve        b3.s, z29.s;                    \
> +               sm4e_sve        b0.s, z30.s;                    \
> +               sm4e_sve        b1.s, z30.s;                    \
> +               sm4e_sve        b2.s, z30.s;                    \
> +               sm4e_sve        b3.s, z30.s;                    \
> +               sm4e_sve        b0.s, z31.s;                    \
> +               sm4e_sve        b1.s, z31.s;                    \
> +               sm4e_sve        b2.s, z31.s;                    \
> +               sm4e_sve        b3.s, z31.s;                    \
> +               tbl             b0.b, {b0.b}, RSWAP128.b;       \
> +               tbl             b1.b, {b1.b}, RSWAP128.b;       \
> +               tbl             b2.b, {b2.b}, RSWAP128.b;       \
> +               tbl             b3.b, {b3.b}, RSWAP128.b;       \
> +               revb            b0.s, p0/m, b0.s;               \
> +               revb            b1.s, p0/m, b1.s;               \
> +               revb            b2.s, p0/m, b2.s;               \
> +               revb            b3.s, p0/m, b3.s;
> +
> +#define SM4_SVE_CE_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7)  \
> +               revb            b0.s, p0/m, b0.s;               \
> +               revb            b1.s, p0/m, b1.s;               \
> +               revb            b2.s, p0/m, b2.s;               \
> +               revb            b3.s, p0/m, b3.s;               \
> +               revb            b4.s, p0/m, b4.s;               \
> +               revb            b5.s, p0/m, b5.s;               \
> +               revb            b6.s, p0/m, b6.s;               \
> +               revb            b7.s, p0/m, b7.s;               \
> +               sm4e_sve        b0.s, z24.s;                    \
> +               sm4e_sve        b1.s, z24.s;                    \
> +               sm4e_sve        b2.s, z24.s;                    \
> +               sm4e_sve        b3.s, z24.s;                    \
> +               sm4e_sve        b4.s, z24.s;                    \
> +               sm4e_sve        b5.s, z24.s;                    \
> +               sm4e_sve        b6.s, z24.s;                    \
> +               sm4e_sve        b7.s, z24.s;                    \
> +               sm4e_sve        b0.s, z25.s;                    \
> +               sm4e_sve        b1.s, z25.s;                    \
> +               sm4e_sve        b2.s, z25.s;                    \
> +               sm4e_sve        b3.s, z25.s;                    \
> +               sm4e_sve        b4.s, z25.s;                    \
> +               sm4e_sve        b5.s, z25.s;                    \
> +               sm4e_sve        b6.s, z25.s;                    \
> +               sm4e_sve        b7.s, z25.s;                    \
> +               sm4e_sve        b0.s, z26.s;                    \
> +               sm4e_sve        b1.s, z26.s;                    \
> +               sm4e_sve        b2.s, z26.s;                    \
> +               sm4e_sve        b3.s, z26.s;                    \
> +               sm4e_sve        b4.s, z26.s;                    \
> +               sm4e_sve        b5.s, z26.s;                    \
> +               sm4e_sve        b6.s, z26.s;                    \
> +               sm4e_sve        b7.s, z26.s;                    \
> +               sm4e_sve        b0.s, z27.s;                    \
> +               sm4e_sve        b1.s, z27.s;                    \
> +               sm4e_sve        b2.s, z27.s;                    \
> +               sm4e_sve        b3.s, z27.s;                    \
> +               sm4e_sve        b4.s, z27.s;                    \
> +               sm4e_sve        b5.s, z27.s;                    \
> +               sm4e_sve        b6.s, z27.s;                    \
> +               sm4e_sve        b7.s, z27.s;                    \
> +               sm4e_sve        b0.s, z28.s;                    \
> +               sm4e_sve        b1.s, z28.s;                    \
> +               sm4e_sve        b2.s, z28.s;                    \
> +               sm4e_sve        b3.s, z28.s;                    \
> +               sm4e_sve        b4.s, z28.s;                    \
> +               sm4e_sve        b5.s, z28.s;                    \
> +               sm4e_sve        b6.s, z28.s;                    \
> +               sm4e_sve        b7.s, z28.s;                    \
> +               sm4e_sve        b0.s, z29.s;                    \
> +               sm4e_sve        b1.s, z29.s;                    \
> +               sm4e_sve        b2.s, z29.s;                    \
> +               sm4e_sve        b3.s, z29.s;                    \
> +               sm4e_sve        b4.s, z29.s;                    \
> +               sm4e_sve        b5.s, z29.s;                    \
> +               sm4e_sve        b6.s, z29.s;                    \
> +               sm4e_sve        b7.s, z29.s;                    \
> +               sm4e_sve        b0.s, z30.s;                    \
> +               sm4e_sve        b1.s, z30.s;                    \
> +               sm4e_sve        b2.s, z30.s;                    \
> +               sm4e_sve        b3.s, z30.s;                    \
> +               sm4e_sve        b4.s, z30.s;                    \
> +               sm4e_sve        b5.s, z30.s;                    \
> +               sm4e_sve        b6.s, z30.s;                    \
> +               sm4e_sve        b7.s, z30.s;                    \
> +               sm4e_sve        b0.s, z31.s;                    \
> +               sm4e_sve        b1.s, z31.s;                    \
> +               sm4e_sve        b2.s, z31.s;                    \
> +               sm4e_sve        b3.s, z31.s;                    \
> +               sm4e_sve        b4.s, z31.s;                    \
> +               sm4e_sve        b5.s, z31.s;                    \
> +               sm4e_sve        b6.s, z31.s;                    \
> +               sm4e_sve        b7.s, z31.s;                    \
> +               tbl             b0.b, {b0.b}, RSWAP128.b;       \
> +               tbl             b1.b, {b1.b}, RSWAP128.b;       \
> +               tbl             b2.b, {b2.b}, RSWAP128.b;       \
> +               tbl             b3.b, {b3.b}, RSWAP128.b;       \
> +               tbl             b4.b, {b4.b}, RSWAP128.b;       \
> +               tbl             b5.b, {b5.b}, RSWAP128.b;       \
> +               tbl             b6.b, {b6.b}, RSWAP128.b;       \
> +               tbl             b7.b, {b7.b}, RSWAP128.b;       \
> +               revb            b0.s, p0/m, b0.s;               \
> +               revb            b1.s, p0/m, b1.s;               \
> +               revb            b2.s, p0/m, b2.s;               \
> +               revb            b3.s, p0/m, b3.s;               \
> +               revb            b4.s, p0/m, b4.s;               \
> +               revb            b5.s, p0/m, b5.s;               \
> +               revb            b6.s, p0/m, b6.s;               \
> +               revb            b7.s, p0/m, b7.s;
> +
> +#define SM4_CE_CRYPT_BLK(b0)                                   \
> +               rev32           b0.16b, b0.16b;                 \
> +               sm4e            b0.4s, v24.4s;                  \
> +               sm4e            b0.4s, v25.4s;                  \
> +               sm4e            b0.4s, v26.4s;                  \
> +               sm4e            b0.4s, v27.4s;                  \
> +               sm4e            b0.4s, v28.4s;                  \
> +               sm4e            b0.4s, v29.4s;                  \
> +               sm4e            b0.4s, v30.4s;                  \
> +               sm4e            b0.4s, v31.4s;                  \
> +               rev64           b0.4s, b0.4s;                   \
> +               ext             b0.16b, b0.16b, b0.16b, #8;     \
> +               rev32           b0.16b, b0.16b;
> +
> +#define inc_le128(zctr)                                                \
> +               mov             RCTRv.d[1], x8;                 \
> +               mov             RCTRv.d[0], x7;                 \
> +               mov             zctr.d, RLE128_INC.d;           \
> +               dup             RCTR.q, RCTR.q[0];              \
> +               adds            x8, x8, x5, LSR #4;             \
> +               adclt           zctr.d, RCTR.d, RZERO.d;        \
> +               adclt           RCTR.d, zctr.d, RZERO.d;        \
> +               adc             x7, x7, xzr;                    \
> +               trn1            zctr.d, RCTR.d, zctr.d;         \
> +               revb            zctr.d, p0/m, zctr.d;
> +
> +#define inc_le128_4x(zctr0, zctr1, zctr2, zctr3)               \
> +               mov             v8.d[1], x8;                    \
> +               mov             v8.d[0], x7;                    \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr0.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v9.d[1], x8;                    \
> +               mov             v9.d[0], x7;                    \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr1.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v10.d[1], x8;                   \
> +               mov             v10.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr2.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v11.d[1], x8;                   \
> +               mov             v11.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr3.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               dup             z8.q, z8.q[0];                  \
> +               dup             z9.q, z9.q[0];                  \
> +               dup             z10.q, z10.q[0];                \
> +               dup             z11.q, z11.q[0];                \
> +               adclt           zctr0.d, z8.d, RZERO.d;         \
> +               adclt           zctr1.d, z9.d, RZERO.d;         \
> +               adclt           zctr2.d, z10.d, RZERO.d;        \
> +               adclt           zctr3.d, z11.d, RZERO.d;        \
> +               adclt           z8.d, zctr0.d, RZERO.d;         \
> +               adclt           z9.d, zctr1.d, RZERO.d;         \
> +               adclt           z10.d, zctr2.d, RZERO.d;        \
> +               adclt           z11.d, zctr3.d, RZERO.d;        \
> +               trn1            zctr0.d, z8.d, zctr0.d;         \
> +               trn1            zctr1.d, z9.d, zctr1.d;         \
> +               trn1            zctr2.d, z10.d, zctr2.d;        \
> +               trn1            zctr3.d, z11.d, zctr3.d;        \
> +               revb            zctr0.d, p0/m, zctr0.d;         \
> +               revb            zctr1.d, p0/m, zctr1.d;         \
> +               revb            zctr2.d, p0/m, zctr2.d;         \
> +               revb            zctr3.d, p0/m, zctr3.d;
> +
> +#define inc_le128_8x(zctr0, zctr1, zctr2, zctr3,               \
> +                    zctr4, zctr5, zctr6, zctr7)                \
> +               mov             v8.d[1], x8;                    \
> +               mov             v8.d[0], x7;                    \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr0.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v9.d[1], x8;                    \
> +               mov             v9.d[0], x7;                    \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr1.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v10.d[1], x8;                   \
> +               mov             v10.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr2.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v11.d[1], x8;                   \
> +               mov             v11.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr3.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v12.d[1], x8;                   \
> +               mov             v12.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr4.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v13.d[1], x8;                   \
> +               mov             v13.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr5.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v14.d[1], x8;                   \
> +               mov             v14.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr6.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               mov             v15.d[1], x8;                   \
> +               mov             v15.d[0], x7;                   \
> +               adds            x8, x8, x5, LSR #4;             \
> +               mov             zctr7.d, RLE128_INC.d;          \
> +               adc             x7, x7, xzr;                    \
> +               dup             z8.q, z8.q[0];                  \
> +               dup             z9.q, z9.q[0];                  \
> +               dup             z10.q, z10.q[0];                \
> +               dup             z11.q, z11.q[0];                \
> +               dup             z12.q, z12.q[0];                \
> +               dup             z13.q, z13.q[0];                \
> +               dup             z14.q, z14.q[0];                \
> +               dup             z15.q, z15.q[0];                \
> +               adclt           zctr0.d, z8.d, RZERO.d;         \
> +               adclt           zctr1.d, z9.d, RZERO.d;         \
> +               adclt           zctr2.d, z10.d, RZERO.d;        \
> +               adclt           zctr3.d, z11.d, RZERO.d;        \
> +               adclt           zctr4.d, z12.d, RZERO.d;        \
> +               adclt           zctr5.d, z13.d, RZERO.d;        \
> +               adclt           zctr6.d, z14.d, RZERO.d;        \
> +               adclt           zctr7.d, z15.d, RZERO.d;        \
> +               adclt           z8.d, zctr0.d, RZERO.d;         \
> +               adclt           z9.d, zctr1.d, RZERO.d;         \
> +               adclt           z10.d, zctr2.d, RZERO.d;        \
> +               adclt           z11.d, zctr3.d, RZERO.d;        \
> +               adclt           z12.d, zctr4.d, RZERO.d;        \
> +               adclt           z13.d, zctr5.d, RZERO.d;        \
> +               adclt           z14.d, zctr6.d, RZERO.d;        \
> +               adclt           z15.d, zctr7.d, RZERO.d;        \
> +               trn1            zctr0.d, z8.d, zctr0.d;         \
> +               trn1            zctr1.d, z9.d, zctr1.d;         \
> +               trn1            zctr2.d, z10.d, zctr2.d;        \
> +               trn1            zctr3.d, z11.d, zctr3.d;        \
> +               trn1            zctr4.d, z12.d, zctr4.d;        \
> +               trn1            zctr5.d, z13.d, zctr5.d;        \
> +               trn1            zctr6.d, z14.d, zctr6.d;        \
> +               trn1            zctr7.d, z15.d, zctr7.d;        \
> +               revb            zctr0.d, p0/m, zctr0.d;         \
> +               revb            zctr1.d, p0/m, zctr1.d;         \
> +               revb            zctr2.d, p0/m, zctr2.d;         \
> +               revb            zctr3.d, p0/m, zctr3.d;         \
> +               revb            zctr4.d, p0/m, zctr4.d;         \
> +               revb            zctr5.d, p0/m, zctr5.d;         \
> +               revb            zctr6.d, p0/m, zctr6.d;         \
> +               revb            zctr7.d, p0/m, zctr7.d;
> +
> +
> +.align 3
> +SYM_FUNC_START(sm4_sve_ce_crypt)
> +       /* input:
> +        *   x0: round key array, CTX
> +        *   x1: dst
> +        *   x2: src
> +        *   w3: nblocks
> +        */
> +       uxtw            x3, w3
> +       SM4_PREPARE(x0)
> +
> +.Lcrypt_loop_8x:
> +       sub             x3, x3, x5, LSR #1              /* x3 - (8 * VL) */
> +       tbnz            x3, #63, .Lcrypt_4x
> +
> +       ld1b            {z0.b}, p0/z, [x2]
> +       ld1b            {z1.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z2.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z3.b}, p0/z, [x2, #3, MUL VL]
> +       ld1b            {z4.b}, p0/z, [x2, #4, MUL VL]
> +       ld1b            {z5.b}, p0/z, [x2, #5, MUL VL]
> +       ld1b            {z6.b}, p0/z, [x2, #6, MUL VL]
> +       ld1b            {z7.b}, p0/z, [x2, #7, MUL VL]
> +
> +       SM4_SVE_CE_CRYPT_BLK8(z0, z1, z2, z3, z4, z5, z6, z7)
> +
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +       st1b            {z4.b}, p0, [x1, #4, MUL VL]
> +       st1b            {z5.b}, p0, [x1, #5, MUL VL]
> +       st1b            {z6.b}, p0, [x1, #6, MUL VL]
> +       st1b            {z7.b}, p0, [x1, #7, MUL VL]
> +
> +       addvl           x2, x2, #8
> +       addvl           x1, x1, #8
> +
> +       cbz             x3, .Lcrypt_end
> +       b               .Lcrypt_loop_8x
> +
> +.Lcrypt_4x:
> +       add             x3, x3, x5, LSR #1
> +       cmp             x3, x5, LSR #2
> +       blt             .Lcrypt_loop_1x
> +
> +       sub             x3, x3, x5, LSR #2              /* x3 - (4 * VL) */
> +
> +       ld1b            {z0.b}, p0/z, [x2]
> +       ld1b            {z1.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z2.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z3.b}, p0/z, [x2, #3, MUL VL]
> +
> +       SM4_SVE_CE_CRYPT_BLK4(z0, z1, z2, z3)
> +
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +
> +       addvl           x2, x2, #4
> +       addvl           x1, x1, #4
> +
> +       cbz             x3, .Lcrypt_end
> +
> +.Lcrypt_loop_1x:
> +       cmp             x3, x5, LSR #4
> +       blt             .Lcrypt_ce_loop_1x
> +
> +       sub             x3, x3, x5, LSR #4              /* x3 - VL */
> +
> +       ld1b            {z0.b}, p0/z, [x2]
> +
> +       SM4_SVE_CE_CRYPT_BLK(z0)
> +
> +       st1b            {z0.b}, p0, [x1]
> +
> +       addvl           x2, x2, #1
> +       addvl           x1, x1, #1
> +
> +       cbz             x3, .Lcrypt_end
> +       b               .Lcrypt_loop_1x
> +
> +.Lcrypt_ce_loop_1x:
> +       sub             x3, x3, #1
> +
> +       ld1             {v0.16b}, [x2], #16
> +       SM4_CE_CRYPT_BLK(v0)
> +       st1             {v0.16b}, [x1], #16
> +
> +       cbnz            x3, .Lcrypt_ce_loop_1x
> +
> +.Lcrypt_end:
> +       ret
> +SYM_FUNC_END(sm4_sve_ce_crypt)
> +
> +.align 3
> +SYM_FUNC_START(sm4_sve_ce_cbc_dec)
> +       /* input:
> +        *   x0: round key array, CTX
> +        *   x1: dst
> +        *   x2: src
> +        *   x3: iv (big endian, 128 bit)
> +        *   w4: nblocks
> +        */
> +       uxtw            x4, w4
> +       SM4_PREPARE(x0)
> +
> +       ld1             {RIVv.16b}, [x3]
> +       ext             RIV.b, RIV.b, RIV.b, #16
> +
> +.Lcbc_dec_loop_8x:
> +       sub             x4, x4, x5, LSR #1              /* x4 - (8 * VL) */
> +       tbnz            x4, #63, .Lcbc_dec_4x
> +
> +       ld1b            {z15.b}, p0/z, [x2]
> +       ld1b            {z14.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z13.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z12.b}, p0/z, [x2, #3, MUL VL]
> +       ld1b            {z11.b}, p0/z, [x2, #4, MUL VL]
> +       ld1b            {z10.b}, p0/z, [x2, #5, MUL VL]
> +       ld1b            {z9.b}, p0/z, [x2, #6, MUL VL]
> +       ld1b            {z8.b}, p0/z, [x2, #7, MUL VL]
> +       rev             z0.b, z15.b
> +       rev             z1.b, z14.b
> +       rev             z2.b, z13.b
> +       rev             z3.b, z12.b
> +       rev             z4.b, z11.b
> +       rev             z5.b, z10.b
> +       rev             z6.b, z9.b
> +       rev             z7.b, z8.b
> +       rev             RTMP0.b, RIV.b
> +       ext             z7.b, z7.b, z6.b, #16
> +       ext             z6.b, z6.b, z5.b, #16
> +       ext             z5.b, z5.b, z4.b, #16
> +       ext             z4.b, z4.b, z3.b, #16
> +       ext             z3.b, z3.b, z2.b, #16
> +       ext             z2.b, z2.b, z1.b, #16
> +       ext             z1.b, z1.b, z0.b, #16
> +       ext             z0.b, z0.b, RTMP0.b, #16
> +       rev             z7.b, z7.b
> +       rev             z6.b, z6.b
> +       rev             z5.b, z5.b
> +       rev             z4.b, z4.b
> +       rev             z3.b, z3.b
> +       rev             z2.b, z2.b
> +       rev             z1.b, z1.b
> +       rev             z0.b, z0.b
> +       mov             RIV.d, z8.d
> +
> +       SM4_SVE_CE_CRYPT_BLK8(z15, z14, z13, z12, z11, z10, z9, z8)
> +
> +       eor             z0.d, z0.d, z15.d
> +       eor             z1.d, z1.d, z14.d
> +       eor             z2.d, z2.d, z13.d
> +       eor             z3.d, z3.d, z12.d
> +       eor             z4.d, z4.d, z11.d
> +       eor             z5.d, z5.d, z10.d
> +       eor             z6.d, z6.d, z9.d
> +       eor             z7.d, z7.d, z8.d
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +       st1b            {z4.b}, p0, [x1, #4, MUL VL]
> +       st1b            {z5.b}, p0, [x1, #5, MUL VL]
> +       st1b            {z6.b}, p0, [x1, #6, MUL VL]
> +       st1b            {z7.b}, p0, [x1, #7, MUL VL]
> +
> +       addvl           x2, x2, #8
> +       addvl           x1, x1, #8
> +
> +       cbz             x4, .Lcbc_dec_end
> +       b               .Lcbc_dec_loop_8x
> +
> +.Lcbc_dec_4x:
> +       add             x4, x4, x5, LSR #1
> +       cmp             x4, x5, LSR #2
> +       blt             .Lcbc_dec_loop_1x
> +
> +       sub             x4, x4, x5, LSR #2              /* x4 - (4 * VL) */
> +
> +       ld1b            {z15.b}, p0/z, [x2]
> +       ld1b            {z14.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z13.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z12.b}, p0/z, [x2, #3, MUL VL]
> +       rev             z0.b, z15.b
> +       rev             z1.b, z14.b
> +       rev             z2.b, z13.b
> +       rev             z3.b, z12.b
> +       rev             RTMP0.b, RIV.b
> +       ext             z3.b, z3.b, z2.b, #16
> +       ext             z2.b, z2.b, z1.b, #16
> +       ext             z1.b, z1.b, z0.b, #16
> +       ext             z0.b, z0.b, RTMP0.b, #16
> +       rev             z3.b, z3.b
> +       rev             z2.b, z2.b
> +       rev             z1.b, z1.b
> +       rev             z0.b, z0.b
> +       mov             RIV.d, z12.d
> +
> +       SM4_SVE_CE_CRYPT_BLK4(z15, z14, z13, z12)
> +
> +       eor             z0.d, z0.d, z15.d
> +       eor             z1.d, z1.d, z14.d
> +       eor             z2.d, z2.d, z13.d
> +       eor             z3.d, z3.d, z12.d
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +
> +       addvl           x2, x2, #4
> +       addvl           x1, x1, #4
> +
> +       cbz             x4, .Lcbc_dec_end
> +
> +.Lcbc_dec_loop_1x:
> +       cmp             x4, x5, LSR #4
> +       blt             .Lcbc_dec_ce
> +
> +       sub             x4, x4, x5, LSR #4              /* x4 - VL */
> +
> +       ld1b            {z15.b}, p0/z, [x2]
> +       rev             RTMP0.b, RIV.b
> +       rev             z0.b, z15.b
> +       ext             z0.b, z0.b, RTMP0.b, #16
> +       rev             z0.b, z0.b
> +       mov             RIV.d, z15.d
> +
> +       SM4_SVE_CE_CRYPT_BLK(z15)
> +
> +       eor             z0.d, z0.d, z15.d
> +       st1b            {z0.b}, p0, [x1]
> +
> +       addvl           x2, x2, #1
> +       addvl           x1, x1, #1
> +
> +       cbz             x4, .Lcbc_dec_end
> +       b               .Lcbc_dec_loop_1x
> +
> +.Lcbc_dec_ce:
> +       rev             RIV.s, RIV.s
> +       tbl             RIV.b, {RIV.b}, RSWAP128.b
> +
> +.Lcbc_dec_ce_loop_1x:
> +       sub             x4, x4, #1
> +
> +       ld1             {v15.16b}, [x2], #16
> +       mov             v0.16b, RIVv.16b
> +       mov             RIVv.16b, v15.16b
> +       SM4_CE_CRYPT_BLK(v15)
> +       eor             v0.16b, v0.16b, v15.16b
> +       st1             {v0.16b}, [x1], #16
> +
> +       cbnz            x4, .Lcbc_dec_ce_loop_1x
> +
> +       ext             RIV.b, RIV.b, RIV.b, #16
> +
> +.Lcbc_dec_end:
> +       /* store new IV */
> +       rev             RIV.s, RIV.s
> +       tbl             RIV.b, {RIV.b}, RSWAP128.b
> +       st1             {RIVv.16b}, [x3]
> +
> +       ret
> +SYM_FUNC_END(sm4_sve_ce_cbc_dec)
> +
> +.align 3
> +SYM_FUNC_START(sm4_sve_ce_cfb_dec)
> +       /* input:
> +        *   x0: round key array, CTX
> +        *   x1: dst
> +        *   x2: src
> +        *   x3: iv (big endian, 128 bit)
> +        *   w4: nblocks
> +        */
> +       uxtw            x4, w4
> +       SM4_PREPARE(x0)
> +
> +       ld1             {RIVv.16b}, [x3]
> +       ext             RIV.b, RIV.b, RIV.b, #16
> +
> +.Lcfb_dec_loop_8x:
> +       sub             x4, x4, x5, LSR #1              /* x4 - (8 * VL) */
> +       tbnz            x4, #63, .Lcfb_dec_4x
> +
> +       ld1b            {z15.b}, p0/z, [x2]
> +       ld1b            {z14.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z13.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z12.b}, p0/z, [x2, #3, MUL VL]
> +       ld1b            {z11.b}, p0/z, [x2, #4, MUL VL]
> +       ld1b            {z10.b}, p0/z, [x2, #5, MUL VL]
> +       ld1b            {z9.b}, p0/z, [x2, #6, MUL VL]
> +       ld1b            {z8.b}, p0/z, [x2, #7, MUL VL]
> +       rev             z0.b, z15.b
> +       rev             z1.b, z14.b
> +       rev             z2.b, z13.b
> +       rev             z3.b, z12.b
> +       rev             z4.b, z11.b
> +       rev             z5.b, z10.b
> +       rev             z6.b, z9.b
> +       rev             z7.b, z8.b
> +       rev             RTMP0.b, RIV.b
> +       ext             z7.b, z7.b, z6.b, #16
> +       ext             z6.b, z6.b, z5.b, #16
> +       ext             z5.b, z5.b, z4.b, #16
> +       ext             z4.b, z4.b, z3.b, #16
> +       ext             z3.b, z3.b, z2.b, #16
> +       ext             z2.b, z2.b, z1.b, #16
> +       ext             z1.b, z1.b, z0.b, #16
> +       ext             z0.b, z0.b, RTMP0.b, #16
> +       rev             z7.b, z7.b
> +       rev             z6.b, z6.b
> +       rev             z5.b, z5.b
> +       rev             z4.b, z4.b
> +       rev             z3.b, z3.b
> +       rev             z2.b, z2.b
> +       rev             z1.b, z1.b
> +       rev             z0.b, z0.b
> +       mov             RIV.d, z8.d
> +
> +       SM4_SVE_CE_CRYPT_BLK8(z0, z1, z2, z3, z4, z5, z6, z7)
> +
> +       eor             z0.d, z0.d, z15.d
> +       eor             z1.d, z1.d, z14.d
> +       eor             z2.d, z2.d, z13.d
> +       eor             z3.d, z3.d, z12.d
> +       eor             z4.d, z4.d, z11.d
> +       eor             z5.d, z5.d, z10.d
> +       eor             z6.d, z6.d, z9.d
> +       eor             z7.d, z7.d, z8.d
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +       st1b            {z4.b}, p0, [x1, #4, MUL VL]
> +       st1b            {z5.b}, p0, [x1, #5, MUL VL]
> +       st1b            {z6.b}, p0, [x1, #6, MUL VL]
> +       st1b            {z7.b}, p0, [x1, #7, MUL VL]
> +
> +       addvl           x2, x2, #8
> +       addvl           x1, x1, #8
> +
> +       cbz             x4, .Lcfb_dec_end
> +       b               .Lcfb_dec_loop_8x
> +
> +.Lcfb_dec_4x:
> +       add             x4, x4, x5, LSR #1
> +       cmp             x4, x5, LSR #2
> +       blt             .Lcfb_dec_loop_1x
> +
> +       sub             x4, x4, x5, LSR #2              /* x4 - (4 * VL) */
> +
> +       ld1b            {z15.b}, p0/z, [x2]
> +       ld1b            {z14.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z13.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z12.b}, p0/z, [x2, #3, MUL VL]
> +       rev             z0.b, z15.b
> +       rev             z1.b, z14.b
> +       rev             z2.b, z13.b
> +       rev             z3.b, z12.b
> +       rev             RTMP0.b, RIV.b
> +       ext             z3.b, z3.b, z2.b, #16
> +       ext             z2.b, z2.b, z1.b, #16
> +       ext             z1.b, z1.b, z0.b, #16
> +       ext             z0.b, z0.b, RTMP0.b, #16
> +       rev             z3.b, z3.b
> +       rev             z2.b, z2.b
> +       rev             z1.b, z1.b
> +       rev             z0.b, z0.b
> +       mov             RIV.d, z12.d
> +
> +       SM4_SVE_CE_CRYPT_BLK4(z0, z1, z2, z3)
> +
> +       eor             z0.d, z0.d, z15.d
> +       eor             z1.d, z1.d, z14.d
> +       eor             z2.d, z2.d, z13.d
> +       eor             z3.d, z3.d, z12.d
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +
> +       addvl           x2, x2, #4
> +       addvl           x1, x1, #4
> +
> +       cbz             x4, .Lcfb_dec_end
> +
> +.Lcfb_dec_loop_1x:
> +       cmp             x4, x5, LSR #4
> +       blt             .Lcfb_dec_ce
> +
> +       sub             x4, x4, x5, LSR #4              /* x4 - VL */
> +
> +       ld1b            {z15.b}, p0/z, [x2]
> +       rev             RTMP0.b, RIV.b
> +       rev             z0.b, z15.b
> +       ext             z0.b, z0.b, RTMP0.b, #16
> +       rev             z0.b, z0.b
> +       mov             RIV.d, z15.d
> +
> +       SM4_SVE_CE_CRYPT_BLK(z0)
> +
> +       eor             z0.d, z0.d, z15.d
> +       st1b            {z0.b}, p0, [x1]
> +
> +       addvl           x2, x2, #1
> +       addvl           x1, x1, #1
> +
> +       cbz             x4, .Lcfb_dec_end
> +       b               .Lcfb_dec_loop_1x
> +
> +.Lcfb_dec_ce:
> +       rev             RIV.s, RIV.s
> +       tbl             RIV.b, {RIV.b}, RSWAP128.b
> +
> +.Lcfb_dec_ce_loop_1x:
> +       sub             x4, x4, #1
> +
> +       ld1             {v15.16b}, [x2], #16
> +       mov             v0.16b, RIVv.16b
> +       mov             RIVv.16b, v15.16b
> +       SM4_CE_CRYPT_BLK(v0)
> +       eor             v0.16b, v0.16b, v15.16b
> +       st1             {v0.16b}, [x1], #16
> +
> +       cbnz            x4, .Lcfb_dec_ce_loop_1x
> +
> +       ext             RIV.b, RIV.b, RIV.b, #16
> +
> +.Lcfb_dec_end:
> +       /* store new IV */
> +       rev             RIV.s, RIV.s
> +       tbl             RIV.b, {RIV.b}, RSWAP128.b
> +       st1             {RIVv.16b}, [x3]
> +
> +       ret
> +SYM_FUNC_END(sm4_sve_ce_cfb_dec)
> +
> +.align 3
> +SYM_FUNC_START(sm4_sve_ce_ctr_crypt)
> +       /* input:
> +        *   x0: round key array, CTX
> +        *   x1: dst
> +        *   x2: src
> +        *   x3: ctr (big endian, 128 bit)
> +        *   w4: nblocks
> +        */
> +       uxtw            x4, w4
> +       SM4_PREPARE(x0)
> +
> +       dup             RZERO.d, #0
> +       adr_l           x6, .Lle128_inc
> +       ld1b            {RLE128_INC.b}, p0/z, [x6]
> +
> +       ldp             x7, x8, [x3]
> +       rev             x7, x7
> +       rev             x8, x8
> +
> +.Lctr_loop_8x:
> +       sub             x4, x4, x5, LSR #1              /* x4 - (8 * VL) */
> +       tbnz            x4, #63, .Lctr_4x
> +
> +       inc_le128_8x(z0, z1, z2, z3, z4, z5, z6, z7)
> +
> +       ld1b            {z8.b}, p0/z, [x2]
> +       ld1b            {z9.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z10.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z11.b}, p0/z, [x2, #3, MUL VL]
> +       ld1b            {z12.b}, p0/z, [x2, #4, MUL VL]
> +       ld1b            {z13.b}, p0/z, [x2, #5, MUL VL]
> +       ld1b            {z14.b}, p0/z, [x2, #6, MUL VL]
> +       ld1b            {z15.b}, p0/z, [x2, #7, MUL VL]
> +
> +       SM4_SVE_CE_CRYPT_BLK8(z0, z1, z2, z3, z4, z5, z6, z7)
> +
> +       eor             z0.d, z0.d, z8.d
> +       eor             z1.d, z1.d, z9.d
> +       eor             z2.d, z2.d, z10.d
> +       eor             z3.d, z3.d, z11.d
> +       eor             z4.d, z4.d, z12.d
> +       eor             z5.d, z5.d, z13.d
> +       eor             z6.d, z6.d, z14.d
> +       eor             z7.d, z7.d, z15.d
> +
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +       st1b            {z4.b}, p0, [x1, #4, MUL VL]
> +       st1b            {z5.b}, p0, [x1, #5, MUL VL]
> +       st1b            {z6.b}, p0, [x1, #6, MUL VL]
> +       st1b            {z7.b}, p0, [x1, #7, MUL VL]
> +
> +       addvl           x2, x2, #8
> +       addvl           x1, x1, #8
> +
> +       cbz             x4, .Lctr_end
> +       b               .Lctr_loop_8x
> +
> +.Lctr_4x:
> +       add             x4, x4, x5, LSR #1
> +       cmp             x4, x5, LSR #2
> +       blt             .Lctr_loop_1x
> +
> +       sub             x4, x4, x5, LSR #2              /* x4 - (4 * VL) */
> +
> +       inc_le128_4x(z0, z1, z2, z3)
> +
> +       ld1b            {z8.b}, p0/z, [x2]
> +       ld1b            {z9.b}, p0/z, [x2, #1, MUL VL]
> +       ld1b            {z10.b}, p0/z, [x2, #2, MUL VL]
> +       ld1b            {z11.b}, p0/z, [x2, #3, MUL VL]
> +
> +       SM4_SVE_CE_CRYPT_BLK4(z0, z1, z2, z3)
> +
> +       eor             z0.d, z0.d, z8.d
> +       eor             z1.d, z1.d, z9.d
> +       eor             z2.d, z2.d, z10.d
> +       eor             z3.d, z3.d, z11.d
> +
> +       st1b            {z0.b}, p0, [x1]
> +       st1b            {z1.b}, p0, [x1, #1, MUL VL]
> +       st1b            {z2.b}, p0, [x1, #2, MUL VL]
> +       st1b            {z3.b}, p0, [x1, #3, MUL VL]
> +
> +       addvl           x2, x2, #4
> +       addvl           x1, x1, #4
> +
> +       cbz             x4, .Lctr_end
> +
> +.Lctr_loop_1x:
> +       cmp             x4, x5, LSR #4
> +       blt             .Lctr_ce_loop_1x
> +
> +       sub             x4, x4, x5, LSR #4              /* x4 - VL */
> +
> +       inc_le128(z0)
> +       ld1b            {z8.b}, p0/z, [x2]
> +
> +       SM4_SVE_CE_CRYPT_BLK(z0)
> +
> +       eor             z0.d, z0.d, z8.d
> +       st1b            {z0.b}, p0, [x1]
> +
> +       addvl           x2, x2, #1
> +       addvl           x1, x1, #1
> +
> +       cbz             x4, .Lctr_end
> +       b               .Lctr_loop_1x
> +
> +.Lctr_ce_loop_1x:
> +       sub             x4, x4, #1
> +
> +       /* inc_le128 for CE */
> +       mov             v0.d[1], x8
> +       mov             v0.d[0], x7
> +       adds            x8, x8, #1
> +       rev64           v0.16b, v0.16b
> +       adc             x7, x7, xzr
> +
> +       ld1             {v8.16b}, [x2], #16
> +
> +       SM4_CE_CRYPT_BLK(v0)
> +
> +       eor             v0.16b, v0.16b, v8.16b
> +       st1             {v0.16b}, [x1], #16
> +
> +       cbnz            x4, .Lctr_ce_loop_1x
> +
> +.Lctr_end:
> +       /* store new CTR */
> +       rev             x7, x7
> +       rev             x8, x8
> +       stp             x7, x8, [x3]
> +
> +       ret
> +SYM_FUNC_END(sm4_sve_ce_ctr_crypt)
> +
> +.align 3
> +SYM_FUNC_START(sm4_sve_get_vl)
> +       /* VL in bytes */
> +       rdvl            x0, #1
> +
> +       ret
> +SYM_FUNC_END(sm4_sve_get_vl)
> +
> +
> +       .section        ".rodata", "a"
> +       .align 4
> +.Lbswap128_mask:
> +       .byte           0x0c, 0x0d, 0x0e, 0x0f, 0x08, 0x09, 0x0a, 0x0b
> +       .byte           0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03
> +       .byte           0x1c, 0x1d, 0x1e, 0x1f, 0x18, 0x19, 0x1a, 0x1b
> +       .byte           0x14, 0x15, 0x16, 0x17, 0x10, 0x11, 0x12, 0x13
> +       .byte           0x2c, 0x2d, 0x2e, 0x2f, 0x28, 0x29, 0x2a, 0x2b
> +       .byte           0x24, 0x25, 0x26, 0x27, 0x20, 0x21, 0x22, 0x23
> +       .byte           0x3c, 0x3d, 0x3e, 0x3f, 0x38, 0x39, 0x3a, 0x3b
> +       .byte           0x34, 0x35, 0x36, 0x37, 0x30, 0x31, 0x32, 0x33
> +       .byte           0x4c, 0x4d, 0x4e, 0x4f, 0x48, 0x49, 0x4a, 0x4b
> +       .byte           0x44, 0x45, 0x46, 0x47, 0x40, 0x41, 0x42, 0x43
> +       .byte           0x5c, 0x5d, 0x5e, 0x5f, 0x58, 0x59, 0x5a, 0x5b
> +       .byte           0x54, 0x55, 0x56, 0x57, 0x50, 0x51, 0x52, 0x53
> +       .byte           0x6c, 0x6d, 0x6e, 0x6f, 0x68, 0x69, 0x6a, 0x6b
> +       .byte           0x64, 0x65, 0x66, 0x67, 0x60, 0x61, 0x62, 0x63
> +       .byte           0x7c, 0x7d, 0x7e, 0x7f, 0x78, 0x79, 0x7a, 0x7b
> +       .byte           0x74, 0x75, 0x76, 0x77, 0x70, 0x71, 0x72, 0x73
> +       .byte           0x8c, 0x8d, 0x8e, 0x8f, 0x88, 0x89, 0x8a, 0x8b
> +       .byte           0x84, 0x85, 0x86, 0x87, 0x80, 0x81, 0x82, 0x83
> +       .byte           0x9c, 0x9d, 0x9e, 0x9f, 0x98, 0x99, 0x9a, 0x9b
> +       .byte           0x94, 0x95, 0x96, 0x97, 0x90, 0x91, 0x92, 0x93
> +       .byte           0xac, 0xad, 0xae, 0xaf, 0xa8, 0xa9, 0xaa, 0xab
> +       .byte           0xa4, 0xa5, 0xa6, 0xa7, 0xa0, 0xa1, 0xa2, 0xa3
> +       .byte           0xbc, 0xbd, 0xbe, 0xbf, 0xb8, 0xb9, 0xba, 0xbb
> +       .byte           0xb4, 0xb5, 0xb6, 0xb7, 0xb0, 0xb1, 0xb2, 0xb3
> +       .byte           0xcc, 0xcd, 0xce, 0xcf, 0xc8, 0xc9, 0xca, 0xcb
> +       .byte           0xc4, 0xc5, 0xc6, 0xc7, 0xc0, 0xc1, 0xc2, 0xc3
> +       .byte           0xdc, 0xdd, 0xde, 0xdf, 0xd8, 0xd9, 0xda, 0xdb
> +       .byte           0xd4, 0xd5, 0xd6, 0xd7, 0xd0, 0xd1, 0xd2, 0xd3
> +       .byte           0xec, 0xed, 0xee, 0xef, 0xe8, 0xe9, 0xea, 0xeb
> +       .byte           0xe4, 0xe5, 0xe6, 0xe7, 0xe0, 0xe1, 0xe2, 0xe3
> +       .byte           0xfc, 0xfd, 0xfe, 0xff, 0xf8, 0xf9, 0xfa, 0xfb
> +       .byte           0xf4, 0xf5, 0xf6, 0xf7, 0xf0, 0xf1, 0xf2, 0xf3
> +
> +.Lle128_inc:
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x0d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       .byte           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> diff --git a/arch/arm64/crypto/sm4-sve-ce-glue.c b/arch/arm64/crypto/sm4-sve-ce-glue.c
> new file mode 100644
> index 000000000000..fc797b72b5f0
> --- /dev/null
> +++ b/arch/arm64/crypto/sm4-sve-ce-glue.c
> @@ -0,0 +1,332 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * SM4 Cipher Algorithm, using ARMv9 Crypto Extensions with SVE2
> + * as specified in
> + * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
> + *
> + * Copyright (C) 2022, Alibaba Group.
> + * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/crypto.h>
> +#include <linux/kernel.h>
> +#include <linux/cpufeature.h>
> +#include <asm/neon.h>
> +#include <asm/simd.h>
> +#include <crypto/internal/simd.h>
> +#include <crypto/internal/skcipher.h>
> +#include <crypto/sm4.h>
> +#include "sm4-ce.h"
> +
> +asmlinkage void sm4_sve_ce_crypt(const u32 *rkey, u8 *dst,
> +                                const u8 *src, unsigned int nblocks);
> +asmlinkage void sm4_sve_ce_cbc_dec(const u32 *rkey_dec, u8 *dst,
> +                                  const u8 *src, u8 *iv,
> +                                  unsigned int nblocks);
> +asmlinkage void sm4_sve_ce_cfb_dec(const u32 *rkey_enc, u8 *dst,
> +                                  const u8 *src, u8 *iv,
> +                                  unsigned int nblocks);
> +asmlinkage void sm4_sve_ce_ctr_crypt(const u32 *rkey_enc, u8 *dst,
> +                                    const u8 *src, u8 *iv,
> +                                    unsigned int nblocks);
> +asmlinkage unsigned int sm4_sve_get_vl(void);
> +
> +
> +static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
> +                     unsigned int key_len)
> +{
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +       if (key_len != SM4_KEY_SIZE)
> +               return -EINVAL;
> +
> +       kernel_neon_begin();
> +       sm4_ce_expand_key(key, ctx->rkey_enc, ctx->rkey_dec,
> +                         crypto_sm4_fk, crypto_sm4_ck);
> +       kernel_neon_end();
> +
> +       return 0;
> +}
> +
> +static int ecb_crypt(struct skcipher_request *req, const u32 *rkey)
> +{
> +       struct skcipher_walk walk;
> +       unsigned int nbytes;
> +       int err;
> +
> +       err = skcipher_walk_virt(&walk, req, false);
> +
> +       while ((nbytes = walk.nbytes) > 0) {
> +               const u8 *src = walk.src.virt.addr;
> +               u8 *dst = walk.dst.virt.addr;
> +               unsigned int nblocks;
> +
> +               nblocks = nbytes / SM4_BLOCK_SIZE;
> +               if (nblocks) {
> +                       kernel_neon_begin();
> +
> +                       sm4_sve_ce_crypt(rkey, dst, src, nblocks);
> +
> +                       kernel_neon_end();
> +               }
> +
> +               err = skcipher_walk_done(&walk, nbytes % SM4_BLOCK_SIZE);
> +       }
> +
> +       return err;
> +}
> +
> +static int ecb_encrypt(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +       return ecb_crypt(req, ctx->rkey_enc);
> +}
> +
> +static int ecb_decrypt(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +       return ecb_crypt(req, ctx->rkey_dec);
> +}
> +
> +static int cbc_crypt(struct skcipher_request *req, const u32 *rkey,
> +                    void (*sm4_cbc_crypt)(const u32 *rkey, u8 *dst,
> +                               const u8 *src, u8 *iv, unsigned int nblocks))
> +{
> +       struct skcipher_walk walk;
> +       unsigned int nbytes;
> +       int err;
> +
> +       err = skcipher_walk_virt(&walk, req, false);
> +
> +       while ((nbytes = walk.nbytes) > 0) {
> +               const u8 *src = walk.src.virt.addr;
> +               u8 *dst = walk.dst.virt.addr;
> +               unsigned int nblocks;
> +
> +               nblocks = nbytes / SM4_BLOCK_SIZE;
> +               if (nblocks) {
> +                       kernel_neon_begin();
> +
> +                       sm4_cbc_crypt(rkey, dst, src, walk.iv, nblocks);
> +
> +                       kernel_neon_end();
> +               }
> +
> +               err = skcipher_walk_done(&walk, nbytes % SM4_BLOCK_SIZE);
> +       }
> +
> +       return err;
> +}
> +
> +static int cbc_encrypt(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +       return cbc_crypt(req, ctx->rkey_enc, sm4_ce_cbc_enc);
> +}
> +
> +static int cbc_decrypt(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +       return cbc_crypt(req, ctx->rkey_dec, sm4_sve_ce_cbc_dec);
> +}
> +
> +static int cfb_crypt(struct skcipher_request *req,
> +                    void (*sm4_cfb_crypt)(const u32 *rkey, u8 *dst,
> +                               const u8 *src, u8 *iv, unsigned int nblocks))
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +       struct skcipher_walk walk;
> +       unsigned int nbytes;
> +       int err;
> +
> +       err = skcipher_walk_virt(&walk, req, false);
> +
> +       while ((nbytes = walk.nbytes) > 0) {
> +               const u8 *src = walk.src.virt.addr;
> +               u8 *dst = walk.dst.virt.addr;
> +               unsigned int nblocks;
> +
> +               nblocks = nbytes / SM4_BLOCK_SIZE;
> +               if (nblocks) {
> +                       kernel_neon_begin();
> +
> +                       sm4_cfb_crypt(ctx->rkey_enc, dst, src,
> +                                     walk.iv, nblocks);
> +
> +                       kernel_neon_end();
> +
> +                       dst += nblocks * SM4_BLOCK_SIZE;
> +                       src += nblocks * SM4_BLOCK_SIZE;
> +                       nbytes -= nblocks * SM4_BLOCK_SIZE;
> +               }
> +
> +               /* tail */
> +               if (walk.nbytes == walk.total && nbytes > 0) {
> +                       u8 keystream[SM4_BLOCK_SIZE];
> +
> +                       sm4_ce_crypt_block(ctx->rkey_enc, keystream, walk.iv);
> +                       crypto_xor_cpy(dst, src, keystream, nbytes);
> +                       nbytes = 0;
> +               }
> +
> +               err = skcipher_walk_done(&walk, nbytes);
> +       }
> +
> +       return err;
> +}
> +
> +static int cfb_encrypt(struct skcipher_request *req)
> +{
> +       return cfb_crypt(req, sm4_ce_cfb_enc);
> +}
> +
> +static int cfb_decrypt(struct skcipher_request *req)
> +{
> +       return cfb_crypt(req, sm4_sve_ce_cfb_dec);
> +}
> +
> +static int ctr_crypt(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
> +       struct skcipher_walk walk;
> +       unsigned int nbytes;
> +       int err;
> +
> +       err = skcipher_walk_virt(&walk, req, false);
> +
> +       while ((nbytes = walk.nbytes) > 0) {
> +               const u8 *src = walk.src.virt.addr;
> +               u8 *dst = walk.dst.virt.addr;
> +               unsigned int nblocks;
> +
> +               nblocks = nbytes / SM4_BLOCK_SIZE;
> +               if (nblocks) {
> +                       kernel_neon_begin();
> +
> +                       sm4_sve_ce_ctr_crypt(ctx->rkey_enc, dst, src,
> +                                            walk.iv, nblocks);
> +
> +                       kernel_neon_end();
> +
> +                       dst += nblocks * SM4_BLOCK_SIZE;
> +                       src += nblocks * SM4_BLOCK_SIZE;
> +                       nbytes -= nblocks * SM4_BLOCK_SIZE;
> +               }
> +
> +               /* tail */
> +               if (walk.nbytes == walk.total && nbytes > 0) {
> +                       u8 keystream[SM4_BLOCK_SIZE];
> +
> +                       sm4_ce_crypt_block(ctx->rkey_enc, keystream, walk.iv);
> +                       crypto_inc(walk.iv, SM4_BLOCK_SIZE);
> +                       crypto_xor_cpy(dst, src, keystream, nbytes);
> +                       nbytes = 0;
> +               }
> +
> +               err = skcipher_walk_done(&walk, nbytes);
> +       }
> +
> +       return err;
> +}
> +
> +static struct skcipher_alg sm4_algs[] = {
> +       {
> +               .base = {
> +                       .cra_name               = "ecb(sm4)",
> +                       .cra_driver_name        = "ecb-sm4-sve-ce",
> +                       .cra_priority           = 500,
> +                       .cra_blocksize          = SM4_BLOCK_SIZE,
> +                       .cra_ctxsize            = sizeof(struct sm4_ctx),
> +                       .cra_module             = THIS_MODULE,
> +               },
> +               .min_keysize    = SM4_KEY_SIZE,
> +               .max_keysize    = SM4_KEY_SIZE,
> +               .setkey         = sm4_setkey,
> +               .encrypt        = ecb_encrypt,
> +               .decrypt        = ecb_decrypt,
> +       }, {
> +               .base = {
> +                       .cra_name               = "cbc(sm4)",
> +                       .cra_driver_name        = "cbc-sm4-sve-ce",
> +                       .cra_priority           = 500,
> +                       .cra_blocksize          = SM4_BLOCK_SIZE,
> +                       .cra_ctxsize            = sizeof(struct sm4_ctx),
> +                       .cra_module             = THIS_MODULE,
> +               },
> +               .min_keysize    = SM4_KEY_SIZE,
> +               .max_keysize    = SM4_KEY_SIZE,
> +               .ivsize         = SM4_BLOCK_SIZE,
> +               .setkey         = sm4_setkey,
> +               .encrypt        = cbc_encrypt,
> +               .decrypt        = cbc_decrypt,
> +       }, {
> +               .base = {
> +                       .cra_name               = "cfb(sm4)",
> +                       .cra_driver_name        = "cfb-sm4-sve-ce",
> +                       .cra_priority           = 500,
> +                       .cra_blocksize          = 1,
> +                       .cra_ctxsize            = sizeof(struct sm4_ctx),
> +                       .cra_module             = THIS_MODULE,
> +               },
> +               .min_keysize    = SM4_KEY_SIZE,
> +               .max_keysize    = SM4_KEY_SIZE,
> +               .ivsize         = SM4_BLOCK_SIZE,
> +               .chunksize      = SM4_BLOCK_SIZE,
> +               .setkey         = sm4_setkey,
> +               .encrypt        = cfb_encrypt,
> +               .decrypt        = cfb_decrypt,
> +       }, {
> +               .base = {
> +                       .cra_name               = "ctr(sm4)",
> +                       .cra_driver_name        = "ctr-sm4-sve-ce",
> +                       .cra_priority           = 500,
> +                       .cra_blocksize          = 1,
> +                       .cra_ctxsize            = sizeof(struct sm4_ctx),
> +                       .cra_module             = THIS_MODULE,
> +               },
> +               .min_keysize    = SM4_KEY_SIZE,
> +               .max_keysize    = SM4_KEY_SIZE,
> +               .ivsize         = SM4_BLOCK_SIZE,
> +               .chunksize      = SM4_BLOCK_SIZE,
> +               .setkey         = sm4_setkey,
> +               .encrypt        = ctr_crypt,
> +               .decrypt        = ctr_crypt,
> +       }
> +};
> +
> +static int __init sm4_sve_ce_init(void)
> +{
> +       if (sm4_sve_get_vl() <= 16)
> +               return -ENODEV;
> +
> +       return crypto_register_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
> +}
> +
> +static void __exit sm4_sve_ce_exit(void)
> +{
> +       crypto_unregister_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
> +}
> +
> +module_cpu_feature_match(SVESM4, sm4_sve_ce_init);
> +module_exit(sm4_sve_ce_exit);
> +
> +MODULE_DESCRIPTION("SM4 ECB/CBC/CFB/CTR using ARMv9 Crypto Extensions with SVE2");
> +MODULE_ALIAS_CRYPTO("sm4-sve-ce");
> +MODULE_ALIAS_CRYPTO("sm4");
> +MODULE_ALIAS_CRYPTO("ecb(sm4)");
> +MODULE_ALIAS_CRYPTO("cbc(sm4)");
> +MODULE_ALIAS_CRYPTO("cfb(sm4)");
> +MODULE_ALIAS_CRYPTO("ctr(sm4)");
> +MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.24.3 (Apple Git-128)
>
