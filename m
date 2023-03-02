Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6E6A796E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCBCUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBCUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:20:19 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC0C23C5B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:20:12 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Axu5ezBwBkLRgHAA--.7908S3;
        Thu, 02 Mar 2023 10:19:31 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx6r05BwBkwXtFAA--.57447S3;
        Thu, 02 Mar 2023 10:17:29 +0800 (CST)
Message-ID: <f1d5f169-898a-9d7a-b932-ce0de20a217a@loongson.cn>
Date:   Thu, 2 Mar 2023 10:17:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] LoongArch: add checksum optimization for 64-bit system
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        David Laight <David.Laight@aculab.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230216130914.156613-1-maobibo@loongson.cn>
 <CAAhV-H6T_F4=D1i6GkJTczHY5i-FSa6o_oXiRdZFGOXBU=pwXg@mail.gmail.com>
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H6T_F4=D1i6GkJTczHY5i-FSa6o_oXiRdZFGOXBU=pwXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx6r05BwBkwXtFAA--.57447S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKF4DCF48Gw17GryUGF1DAwb_yoWfAF43pF
        yDtrn0gF48Xr1xtr12v3y3tFnxWws7GrnrKryagFy8Ar9Ivw1xJrn8KrZ09a43Jw1fGFy0
        vFWYgry3GFn3JaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/1 20:54, Huacai Chen 写道:
> Hi, Bibo,
> 
> I found the version here [1] provides more functions than this one. So
> is it possible to take advantages from both versions?
csum and copy user will take me much time:(  Just for csum there is no obvious
results between uint128 and interleave method, it depends on compiler version
also. I want to re-investigate two methods after LoongArch gcc optimization
version is stable.

Three methods are tested on LoongArch 3A5000 machine: uint128/asm/interleave
methods, interleave method gets double performance on x86 box compared with
uint128 method, however no better than LoongArch 3A5000 machine and one
ARM64 machine. The three test methods are listed at website:
https://github.com/bibo-mao/bench/tree/master/csum

Here is the result on 3A5000 machine, time unit is us, smaller for
better performance.

buf size    loops      uint128      asm       interleave
4096       0x100000     279824     373401     291508
1472       0x100000     109137     138224     106035
250        0x100000     29008      35838      23408
40         0x100000     9789       23408      9122

Regards
Bibo, mao
> 
> [1] https://github.com/loongson/linux/commit/92a6df48ccb73dd2c3dc1799add08adf0e0b0deb
> 
> Huacai
> 
> On Thu, Feb 16, 2023 at 9:09 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> loongArch platform is 64-bit system, which supports 8 bytes memory
>> accessing, generic checksum function uses 4 byte memory access.
>> This patch adds 8-bytes memory access optimization for checksum
>> function on loongArch. And the code comes from arm64 system.
>>
>> When network hw checksum is disabled, iperf performance improves
>> about 10% with this patch.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>> Changelog:
>> v3: modify function accumulate() to handle better on loongarch platform,
>>     maybe it's compiler optimization issue.
>> v2: use rotation API in function csum_fold to reduce one instruction.
>> ---
>>  arch/loongarch/include/asm/checksum.h |  65 ++++++++++++
>>  arch/loongarch/lib/Makefile           |   2 +-
>>  arch/loongarch/lib/csum.c             | 141 ++++++++++++++++++++++++++
>>  3 files changed, 207 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/loongarch/include/asm/checksum.h
>>  create mode 100644 arch/loongarch/lib/csum.c
>>
>> diff --git a/arch/loongarch/include/asm/checksum.h b/arch/loongarch/include/asm/checksum.h
>> new file mode 100644
>> index 000000000000..8a7d368d801d
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/checksum.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2016 ARM Ltd.
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + */
>> +#ifndef __ASM_CHECKSUM_H
>> +#define __ASM_CHECKSUM_H
>> +
>> +#include <linux/in6.h>
>> +
>> +#define _HAVE_ARCH_IPV6_CSUM
>> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>> +                       const struct in6_addr *daddr,
>> +                       __u32 len, __u8 proto, __wsum sum);
>> +
>> +/*
>> + * turns a 32-bit partial checksum (e.g. from csum_partial) into a
>> + * 1's complement 16-bit checksum.
>> + */
>> +static inline __sum16 csum_fold(__wsum sum)
>> +{
>> +       u32 tmp = (__force u32)sum;
>> +
>> +       /*
>> +        * swap the two 16-bit halves of sum
>> +        * if there is a carry from adding the two 16-bit halves,
>> +        * it will carry from the lower half into the upper half,
>> +        * giving us the correct sum in the upper half.
>> +        */
>> +       return (__force __sum16)(~(tmp + rol32(tmp, 16)) >> 16);
>> +}
>> +#define csum_fold csum_fold
>> +
>> +/*
>> + * This is a version of ip_compute_csum() optimized for IP headers,
>> + * which always checksum on 4 octet boundaries.  ihl is the number
>> + * of 32-bit words and is always >= 5.
>> + */
>> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>> +{
>> +       __uint128_t tmp;
>> +       u64 sum;
>> +       int n = ihl; /* we want it signed */
>> +
>> +       tmp = *(const __uint128_t *)iph;
>> +       iph += 16;
>> +       n -= 4;
>> +       tmp += ((tmp >> 64) | (tmp << 64));
>> +       sum = tmp >> 64;
>> +       do {
>> +               sum += *(const u32 *)iph;
>> +               iph += 4;
>> +       } while (--n > 0);
>> +
>> +       sum += ror64(sum, 32);
>> +       return csum_fold((__force __wsum)(sum >> 32));
>> +}
>> +#define ip_fast_csum ip_fast_csum
>> +
>> +extern unsigned int do_csum(const unsigned char *buff, int len);
>> +#define do_csum do_csum
>> +
>> +#include <asm-generic/checksum.h>
>> +
>> +#endif /* __ASM_CHECKSUM_H */
>> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
>> index 40bde632900f..6ba6df411f90 100644
>> --- a/arch/loongarch/lib/Makefile
>> +++ b/arch/loongarch/lib/Makefile
>> @@ -4,4 +4,4 @@
>>  #
>>
>>  lib-y  += delay.o memset.o memcpy.o memmove.o \
>> -          clear_user.o copy_user.o dump_tlb.o unaligned.o
>> +          clear_user.o copy_user.o dump_tlb.o unaligned.o csum.o
>> diff --git a/arch/loongarch/lib/csum.c b/arch/loongarch/lib/csum.c
>> new file mode 100644
>> index 000000000000..a5e84b403c3b
>> --- /dev/null
>> +++ b/arch/loongarch/lib/csum.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (C) 2019-2020 Arm Ltd.
>> +
>> +#include <linux/compiler.h>
>> +#include <linux/kasan-checks.h>
>> +#include <linux/kernel.h>
>> +
>> +#include <net/checksum.h>
>> +
>> +static u64 accumulate(u64 sum, u64 data)
>> +{
>> +       sum += data;
>> +       if (sum < data)
>> +               sum += 1;
>> +       return sum;
>> +}
>> +
>> +/*
>> + * We over-read the buffer and this makes KASAN unhappy. Instead, disable
>> + * instrumentation and call kasan explicitly.
>> + */
>> +unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
>> +{
>> +       unsigned int offset, shift, sum;
>> +       const u64 *ptr;
>> +       u64 data, sum64 = 0;
>> +
>> +       if (unlikely(len == 0))
>> +               return 0;
>> +
>> +       offset = (unsigned long)buff & 7;
>> +       /*
>> +        * This is to all intents and purposes safe, since rounding down cannot
>> +        * result in a different page or cache line being accessed, and @buff
>> +        * should absolutely not be pointing to anything read-sensitive. We do,
>> +        * however, have to be careful not to piss off KASAN, which means using
>> +        * unchecked reads to accommodate the head and tail, for which we'll
>> +        * compensate with an explicit check up-front.
>> +        */
>> +       kasan_check_read(buff, len);
>> +       ptr = (u64 *)(buff - offset);
>> +       len = len + offset - 8;
>> +
>> +       /*
>> +        * Head: zero out any excess leading bytes. Shifting back by the same
>> +        * amount should be at least as fast as any other way of handling the
>> +        * odd/even alignment, and means we can ignore it until the very end.
>> +        */
>> +       shift = offset * 8;
>> +       data = *ptr++;
>> +       data = (data >> shift) << shift;
>> +
>> +       /*
>> +        * Body: straightforward aligned loads from here on (the paired loads
>> +        * underlying the quadword type still only need dword alignment). The
>> +        * main loop strictly excludes the tail, so the second loop will always
>> +        * run at least once.
>> +        */
>> +       while (unlikely(len > 64)) {
>> +               __uint128_t tmp1, tmp2, tmp3, tmp4;
>> +
>> +               tmp1 = *(__uint128_t *)ptr;
>> +               tmp2 = *(__uint128_t *)(ptr + 2);
>> +               tmp3 = *(__uint128_t *)(ptr + 4);
>> +               tmp4 = *(__uint128_t *)(ptr + 6);
>> +
>> +               len -= 64;
>> +               ptr += 8;
>> +
>> +               /* This is the "don't dump the carry flag into a GPR" idiom */
>> +               tmp1 += (tmp1 >> 64) | (tmp1 << 64);
>> +               tmp2 += (tmp2 >> 64) | (tmp2 << 64);
>> +               tmp3 += (tmp3 >> 64) | (tmp3 << 64);
>> +               tmp4 += (tmp4 >> 64) | (tmp4 << 64);
>> +               tmp1 = ((tmp1 >> 64) << 64) | (tmp2 >> 64);
>> +               tmp1 += (tmp1 >> 64) | (tmp1 << 64);
>> +               tmp3 = ((tmp3 >> 64) << 64) | (tmp4 >> 64);
>> +               tmp3 += (tmp3 >> 64) | (tmp3 << 64);
>> +               tmp1 = ((tmp1 >> 64) << 64) | (tmp3 >> 64);
>> +               tmp1 += (tmp1 >> 64) | (tmp1 << 64);
>> +               tmp1 = ((tmp1 >> 64) << 64) | sum64;
>> +               tmp1 += (tmp1 >> 64) | (tmp1 << 64);
>> +               sum64 = tmp1 >> 64;
>> +       }
>> +       while (len > 8) {
>> +               __uint128_t tmp;
>> +
>> +               sum64 = accumulate(sum64, data);
>> +               tmp = *(__uint128_t *)ptr;
>> +
>> +               len -= 16;
>> +               ptr += 2;
>> +
>> +               data = tmp >> 64;
>> +               sum64 = accumulate(sum64, tmp);
>> +       }
>> +       if (len > 0) {
>> +               sum64 = accumulate(sum64, data);
>> +               data = *ptr;
>> +               len -= 8;
>> +       }
>> +       /*
>> +        * Tail: zero any over-read bytes similarly to the head, again
>> +        * preserving odd/even alignment.
>> +        */
>> +       shift = len * -8;
>> +       data = (data << shift) >> shift;
>> +       sum64 = accumulate(sum64, data);
>> +
>> +       /* Finally, folding */
>> +       sum64 += (sum64 >> 32) | (sum64 << 32);
>> +       sum = sum64 >> 32;
>> +       sum += (sum >> 16) | (sum << 16);
>> +       if (offset & 1)
>> +               return (u16)swab32(sum);
>> +
>> +       return sum >> 16;
>> +}
>> +
>> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>> +                       const struct in6_addr *daddr,
>> +                       __u32 len, __u8 proto, __wsum csum)
>> +{
>> +       __uint128_t src, dst;
>> +       u64 sum = (__force u64)csum;
>> +
>> +       src = *(const __uint128_t *)saddr->s6_addr;
>> +       dst = *(const __uint128_t *)daddr->s6_addr;
>> +
>> +       sum += (__force u32)htonl(len);
>> +       sum += (u32)proto << 24;
>> +       src += (src >> 64) | (src << 64);
>> +       dst += (dst >> 64) | (dst << 64);
>> +
>> +       sum = accumulate(sum, src >> 64);
>> +       sum = accumulate(sum, dst >> 64);
>> +
>> +       sum += ((sum >> 32) | (sum << 32));
>> +       return csum_fold((__force __wsum)(sum >> 32));
>> +}
>> +EXPORT_SYMBOL(csum_ipv6_magic);
>> --
>> 2.27.0
>>

