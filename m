Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1966A6C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCAMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:54:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C72CC7F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC6D61290
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B59EC4339B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677675260;
        bh=nsAjfERmlYcwPCwRlGaZKt5QRBPCc6LjHfkvMN26bl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a698muagCddvVl3CDIHAIYRMgtMcCBtj584mVF/hFgrYFOjty+gro00FXeCVDc9fL
         rC0S3uGEe9+eXbm3Pjora2P9bdKI3KwA1qWp5TqqC1yMXcC1JeV5Y4/Qf6javE/WYL
         EO90Al8AgFaVHyTaZrhddYrmTdW02/WuQI077Qu2i+PPfn4slmjGwYyvqleTE3xe/h
         bjZRwBN5ShNx+tbLc5mETbAu5Z6bcWcN33qMXNFID++u3D3DB1LhR96p3hPPCcxHfa
         aGGl/I/0IHWqA+r3eLk0wltCXQ3ZZINgPdhWXkXxluCRuxxMz/WA//h4Xza92PFwdX
         q9DUuOZEYeRHA==
Received: by mail-ed1-f50.google.com with SMTP id o12so53270678edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:54:20 -0800 (PST)
X-Gm-Message-State: AO0yUKUn+9WoVzmljYoVrQQrRmIb/id/KUSOMrwzpuj/G4zYPOqH6vWR
        csI+m51HBvUMU8BxD5w4t5C4gUMmUPbP9Fx8Mn0=
X-Google-Smtp-Source: AK7set+gKy5PfoUAkxjPyqViMV5TLsZt5d1WtsqHlZa+P0ra5Ew9UlFJGwuPsmKCDxZYFDS/4dfjtQPEgxSjqt+fJAk=
X-Received: by 2002:a50:c319:0:b0:4ad:7439:cec3 with SMTP id
 a25-20020a50c319000000b004ad7439cec3mr3563374edb.7.1677675258664; Wed, 01 Mar
 2023 04:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20230216130914.156613-1-maobibo@loongson.cn>
In-Reply-To: <20230216130914.156613-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 1 Mar 2023 20:54:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6T_F4=D1i6GkJTczHY5i-FSa6o_oXiRdZFGOXBU=pwXg@mail.gmail.com>
Message-ID: <CAAhV-H6T_F4=D1i6GkJTczHY5i-FSa6o_oXiRdZFGOXBU=pwXg@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: add checksum optimization for 64-bit system
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        David Laight <David.Laight@aculab.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

I found the version here [1] provides more functions than this one. So
is it possible to take advantages from both versions?

[1] https://github.com/loongson/linux/commit/92a6df48ccb73dd2c3dc1799add08a=
df0e0b0deb

Huacai

On Thu, Feb 16, 2023 at 9:09=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> loongArch platform is 64-bit system, which supports 8 bytes memory
> accessing, generic checksum function uses 4 byte memory access.
> This patch adds 8-bytes memory access optimization for checksum
> function on loongArch. And the code comes from arm64 system.
>
> When network hw checksum is disabled, iperf performance improves
> about 10% with this patch.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> Changelog:
> v3: modify function accumulate() to handle better on loongarch platform,
>     maybe it's compiler optimization issue.
> v2: use rotation API in function csum_fold to reduce one instruction.
> ---
>  arch/loongarch/include/asm/checksum.h |  65 ++++++++++++
>  arch/loongarch/lib/Makefile           |   2 +-
>  arch/loongarch/lib/csum.c             | 141 ++++++++++++++++++++++++++
>  3 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/include/asm/checksum.h
>  create mode 100644 arch/loongarch/lib/csum.c
>
> diff --git a/arch/loongarch/include/asm/checksum.h b/arch/loongarch/inclu=
de/asm/checksum.h
> new file mode 100644
> index 000000000000..8a7d368d801d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/checksum.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2016 ARM Ltd.
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_CHECKSUM_H
> +#define __ASM_CHECKSUM_H
> +
> +#include <linux/in6.h>
> +
> +#define _HAVE_ARCH_IPV6_CSUM
> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +                       const struct in6_addr *daddr,
> +                       __u32 len, __u8 proto, __wsum sum);
> +
> +/*
> + * turns a 32-bit partial checksum (e.g. from csum_partial) into a
> + * 1's complement 16-bit checksum.
> + */
> +static inline __sum16 csum_fold(__wsum sum)
> +{
> +       u32 tmp =3D (__force u32)sum;
> +
> +       /*
> +        * swap the two 16-bit halves of sum
> +        * if there is a carry from adding the two 16-bit halves,
> +        * it will carry from the lower half into the upper half,
> +        * giving us the correct sum in the upper half.
> +        */
> +       return (__force __sum16)(~(tmp + rol32(tmp, 16)) >> 16);
> +}
> +#define csum_fold csum_fold
> +
> +/*
> + * This is a version of ip_compute_csum() optimized for IP headers,
> + * which always checksum on 4 octet boundaries.  ihl is the number
> + * of 32-bit words and is always >=3D 5.
> + */
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +       __uint128_t tmp;
> +       u64 sum;
> +       int n =3D ihl; /* we want it signed */
> +
> +       tmp =3D *(const __uint128_t *)iph;
> +       iph +=3D 16;
> +       n -=3D 4;
> +       tmp +=3D ((tmp >> 64) | (tmp << 64));
> +       sum =3D tmp >> 64;
> +       do {
> +               sum +=3D *(const u32 *)iph;
> +               iph +=3D 4;
> +       } while (--n > 0);
> +
> +       sum +=3D ror64(sum, 32);
> +       return csum_fold((__force __wsum)(sum >> 32));
> +}
> +#define ip_fast_csum ip_fast_csum
> +
> +extern unsigned int do_csum(const unsigned char *buff, int len);
> +#define do_csum do_csum
> +
> +#include <asm-generic/checksum.h>
> +
> +#endif /* __ASM_CHECKSUM_H */
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index 40bde632900f..6ba6df411f90 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -4,4 +4,4 @@
>  #
>
>  lib-y  +=3D delay.o memset.o memcpy.o memmove.o \
> -          clear_user.o copy_user.o dump_tlb.o unaligned.o
> +          clear_user.o copy_user.o dump_tlb.o unaligned.o csum.o
> diff --git a/arch/loongarch/lib/csum.c b/arch/loongarch/lib/csum.c
> new file mode 100644
> index 000000000000..a5e84b403c3b
> --- /dev/null
> +++ b/arch/loongarch/lib/csum.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2019-2020 Arm Ltd.
> +
> +#include <linux/compiler.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kernel.h>
> +
> +#include <net/checksum.h>
> +
> +static u64 accumulate(u64 sum, u64 data)
> +{
> +       sum +=3D data;
> +       if (sum < data)
> +               sum +=3D 1;
> +       return sum;
> +}
> +
> +/*
> + * We over-read the buffer and this makes KASAN unhappy. Instead, disabl=
e
> + * instrumentation and call kasan explicitly.
> + */
> +unsigned int __no_sanitize_address do_csum(const unsigned char *buff, in=
t len)
> +{
> +       unsigned int offset, shift, sum;
> +       const u64 *ptr;
> +       u64 data, sum64 =3D 0;
> +
> +       if (unlikely(len =3D=3D 0))
> +               return 0;
> +
> +       offset =3D (unsigned long)buff & 7;
> +       /*
> +        * This is to all intents and purposes safe, since rounding down =
cannot
> +        * result in a different page or cache line being accessed, and @=
buff
> +        * should absolutely not be pointing to anything read-sensitive. =
We do,
> +        * however, have to be careful not to piss off KASAN, which means=
 using
> +        * unchecked reads to accommodate the head and tail, for which we=
'll
> +        * compensate with an explicit check up-front.
> +        */
> +       kasan_check_read(buff, len);
> +       ptr =3D (u64 *)(buff - offset);
> +       len =3D len + offset - 8;
> +
> +       /*
> +        * Head: zero out any excess leading bytes. Shifting back by the =
same
> +        * amount should be at least as fast as any other way of handling=
 the
> +        * odd/even alignment, and means we can ignore it until the very =
end.
> +        */
> +       shift =3D offset * 8;
> +       data =3D *ptr++;
> +       data =3D (data >> shift) << shift;
> +
> +       /*
> +        * Body: straightforward aligned loads from here on (the paired l=
oads
> +        * underlying the quadword type still only need dword alignment).=
 The
> +        * main loop strictly excludes the tail, so the second loop will =
always
> +        * run at least once.
> +        */
> +       while (unlikely(len > 64)) {
> +               __uint128_t tmp1, tmp2, tmp3, tmp4;
> +
> +               tmp1 =3D *(__uint128_t *)ptr;
> +               tmp2 =3D *(__uint128_t *)(ptr + 2);
> +               tmp3 =3D *(__uint128_t *)(ptr + 4);
> +               tmp4 =3D *(__uint128_t *)(ptr + 6);
> +
> +               len -=3D 64;
> +               ptr +=3D 8;
> +
> +               /* This is the "don't dump the carry flag into a GPR" idi=
om */
> +               tmp1 +=3D (tmp1 >> 64) | (tmp1 << 64);
> +               tmp2 +=3D (tmp2 >> 64) | (tmp2 << 64);
> +               tmp3 +=3D (tmp3 >> 64) | (tmp3 << 64);
> +               tmp4 +=3D (tmp4 >> 64) | (tmp4 << 64);
> +               tmp1 =3D ((tmp1 >> 64) << 64) | (tmp2 >> 64);
> +               tmp1 +=3D (tmp1 >> 64) | (tmp1 << 64);
> +               tmp3 =3D ((tmp3 >> 64) << 64) | (tmp4 >> 64);
> +               tmp3 +=3D (tmp3 >> 64) | (tmp3 << 64);
> +               tmp1 =3D ((tmp1 >> 64) << 64) | (tmp3 >> 64);
> +               tmp1 +=3D (tmp1 >> 64) | (tmp1 << 64);
> +               tmp1 =3D ((tmp1 >> 64) << 64) | sum64;
> +               tmp1 +=3D (tmp1 >> 64) | (tmp1 << 64);
> +               sum64 =3D tmp1 >> 64;
> +       }
> +       while (len > 8) {
> +               __uint128_t tmp;
> +
> +               sum64 =3D accumulate(sum64, data);
> +               tmp =3D *(__uint128_t *)ptr;
> +
> +               len -=3D 16;
> +               ptr +=3D 2;
> +
> +               data =3D tmp >> 64;
> +               sum64 =3D accumulate(sum64, tmp);
> +       }
> +       if (len > 0) {
> +               sum64 =3D accumulate(sum64, data);
> +               data =3D *ptr;
> +               len -=3D 8;
> +       }
> +       /*
> +        * Tail: zero any over-read bytes similarly to the head, again
> +        * preserving odd/even alignment.
> +        */
> +       shift =3D len * -8;
> +       data =3D (data << shift) >> shift;
> +       sum64 =3D accumulate(sum64, data);
> +
> +       /* Finally, folding */
> +       sum64 +=3D (sum64 >> 32) | (sum64 << 32);
> +       sum =3D sum64 >> 32;
> +       sum +=3D (sum >> 16) | (sum << 16);
> +       if (offset & 1)
> +               return (u16)swab32(sum);
> +
> +       return sum >> 16;
> +}
> +
> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +                       const struct in6_addr *daddr,
> +                       __u32 len, __u8 proto, __wsum csum)
> +{
> +       __uint128_t src, dst;
> +       u64 sum =3D (__force u64)csum;
> +
> +       src =3D *(const __uint128_t *)saddr->s6_addr;
> +       dst =3D *(const __uint128_t *)daddr->s6_addr;
> +
> +       sum +=3D (__force u32)htonl(len);
> +       sum +=3D (u32)proto << 24;
> +       src +=3D (src >> 64) | (src << 64);
> +       dst +=3D (dst >> 64) | (dst << 64);
> +
> +       sum =3D accumulate(sum, src >> 64);
> +       sum =3D accumulate(sum, dst >> 64);
> +
> +       sum +=3D ((sum >> 32) | (sum << 32));
> +       return csum_fold((__force __wsum)(sum >> 32));
> +}
> +EXPORT_SYMBOL(csum_ipv6_magic);
> --
> 2.27.0
>
