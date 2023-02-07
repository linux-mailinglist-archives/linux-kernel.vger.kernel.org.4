Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432868CDDB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBGECB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBGEB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:01:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8B75FD6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:01:50 -0800 (PST)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8CxzvAtzeFj_GcPAA--.30627S3;
        Tue, 07 Feb 2023 12:01:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC74szeFj5jkrAA--.17338S2;
        Tue, 07 Feb 2023 12:01:48 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: add checksum optimization for 64-bit system
Date:   Tue,  7 Feb 2023 12:01:48 +0800
Message-Id: <20230207040148.1801169-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxC74szeFj5jkrAA--.17338S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3JrW5ZF4UtryxurW3ZFyUAwb_yoWxWF4kpF
        nxAr9Ygr4UGF1I9r92yrWIqr43Ja1kGr12grZIgFy8ArW7X347Jrs3KrZYvFy7Gw4fGFyx
        Zay5KF1agFs3JaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loongArch platform is 64-bit system, which supports 8 bytes memory
accessing, generic checksum function uses 4 byte memory access.
This patch adds 8-bytes memory access optimization for checksum
function on loongArch. And the code comes from arm64 system.

When network hw checksum is disabled, iperf performance improves
about 10% with this patch.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/checksum.h |  50 +++++++++
 arch/loongarch/lib/Makefile           |   2 +-
 arch/loongarch/lib/csum.c             | 142 ++++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/checksum.h
 create mode 100644 arch/loongarch/lib/csum.c

diff --git a/arch/loongarch/include/asm/checksum.h b/arch/loongarch/include/asm/checksum.h
new file mode 100644
index 000000000000..c9d5af206604
--- /dev/null
+++ b/arch/loongarch/include/asm/checksum.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2016 ARM Ltd.
+ */
+#ifndef __ASM_CHECKSUM_H
+#define __ASM_CHECKSUM_H
+
+#include <linux/in6.h>
+
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+
+static inline __sum16 csum_fold(__wsum csum)
+{
+	u32 sum = (__force u32)csum;
+
+	sum += (sum >> 16) | (sum << 16);
+	return ~(__force __sum16)(sum >> 16);
+}
+#define csum_fold csum_fold
+
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	__uint128_t tmp;
+	u64 sum;
+	int n = ihl; /* we want it signed */
+
+	tmp = *(const __uint128_t *)iph;
+	iph += 16;
+	n -= 4;
+	tmp += ((tmp >> 64) | (tmp << 64));
+	sum = tmp >> 64;
+	do {
+		sum += *(const u32 *)iph;
+		iph += 4;
+	} while (--n > 0);
+
+	sum += ((sum >> 32) | (sum << 32));
+	return csum_fold((__force __wsum)(sum >> 32));
+}
+#define ip_fast_csum ip_fast_csum
+
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+
+#include <asm-generic/checksum.h>
+
+#endif	/* __ASM_CHECKSUM_H */
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 40bde632900f..6ba6df411f90 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -4,4 +4,4 @@
 #
 
 lib-y	+= delay.o memset.o memcpy.o memmove.o \
-	   clear_user.o copy_user.o dump_tlb.o unaligned.o
+	   clear_user.o copy_user.o dump_tlb.o unaligned.o csum.o
diff --git a/arch/loongarch/lib/csum.c b/arch/loongarch/lib/csum.c
new file mode 100644
index 000000000000..0f7e3a5ce96a
--- /dev/null
+++ b/arch/loongarch/lib/csum.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2019-2020 Arm Ltd.
+
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kernel.h>
+
+#include <net/checksum.h>
+
+/* Looks dumb, but generates nice-ish code */
+static u64 accumulate(u64 sum, u64 data)
+{
+	__uint128_t tmp;
+
+	tmp = (__uint128_t)sum + data;
+	return tmp + (tmp >> 64);
+}
+
+/*
+ * We over-read the buffer and this makes KASAN unhappy. Instead, disable
+ * instrumentation and call kasan explicitly.
+ */
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
+{
+	unsigned int offset, shift, sum;
+	const u64 *ptr;
+	u64 data, sum64 = 0;
+
+	if (unlikely(len == 0))
+		return 0;
+
+	offset = (unsigned long)buff & 7;
+	/*
+	 * This is to all intents and purposes safe, since rounding down cannot
+	 * result in a different page or cache line being accessed, and @buff
+	 * should absolutely not be pointing to anything read-sensitive. We do,
+	 * however, have to be careful not to piss off KASAN, which means using
+	 * unchecked reads to accommodate the head and tail, for which we'll
+	 * compensate with an explicit check up-front.
+	 */
+	kasan_check_read(buff, len);
+	ptr = (u64 *)(buff - offset);
+	len = len + offset - 8;
+
+	/*
+	 * Head: zero out any excess leading bytes. Shifting back by the same
+	 * amount should be at least as fast as any other way of handling the
+	 * odd/even alignment, and means we can ignore it until the very end.
+	 */
+	shift = offset * 8;
+	data = *ptr++;
+	data = (data >> shift) << shift;
+
+	/*
+	 * Body: straightforward aligned loads from here on (the paired loads
+	 * underlying the quadword type still only need dword alignment). The
+	 * main loop strictly excludes the tail, so the second loop will always
+	 * run at least once.
+	 */
+	while (unlikely(len > 64)) {
+		__uint128_t tmp1, tmp2, tmp3, tmp4;
+
+		tmp1 = *(__uint128_t *)ptr;
+		tmp2 = *(__uint128_t *)(ptr + 2);
+		tmp3 = *(__uint128_t *)(ptr + 4);
+		tmp4 = *(__uint128_t *)(ptr + 6);
+
+		len -= 64;
+		ptr += 8;
+
+		/* This is the "don't dump the carry flag into a GPR" idiom */
+		tmp1 += (tmp1 >> 64) | (tmp1 << 64);
+		tmp2 += (tmp2 >> 64) | (tmp2 << 64);
+		tmp3 += (tmp3 >> 64) | (tmp3 << 64);
+		tmp4 += (tmp4 >> 64) | (tmp4 << 64);
+		tmp1 = ((tmp1 >> 64) << 64) | (tmp2 >> 64);
+		tmp1 += (tmp1 >> 64) | (tmp1 << 64);
+		tmp3 = ((tmp3 >> 64) << 64) | (tmp4 >> 64);
+		tmp3 += (tmp3 >> 64) | (tmp3 << 64);
+		tmp1 = ((tmp1 >> 64) << 64) | (tmp3 >> 64);
+		tmp1 += (tmp1 >> 64) | (tmp1 << 64);
+		tmp1 = ((tmp1 >> 64) << 64) | sum64;
+		tmp1 += (tmp1 >> 64) | (tmp1 << 64);
+		sum64 = tmp1 >> 64;
+	}
+	while (len > 8) {
+		__uint128_t tmp;
+
+		sum64 = accumulate(sum64, data);
+		tmp = *(__uint128_t *)ptr;
+
+		len -= 16;
+		ptr += 2;
+
+		data = tmp >> 64;
+		sum64 = accumulate(sum64, tmp);
+	}
+	if (len > 0) {
+		sum64 = accumulate(sum64, data);
+		data = *ptr;
+		len -= 8;
+	}
+	/*
+	 * Tail: zero any over-read bytes similarly to the head, again
+	 * preserving odd/even alignment.
+	 */
+	shift = len * -8;
+	data = (data << shift) >> shift;
+	sum64 = accumulate(sum64, data);
+
+	/* Finally, folding */
+	sum64 += (sum64 >> 32) | (sum64 << 32);
+	sum = sum64 >> 32;
+	sum += (sum >> 16) | (sum << 16);
+	if (offset & 1)
+		return (u16)swab32(sum);
+
+	return sum >> 16;
+}
+
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum csum)
+{
+	__uint128_t src, dst;
+	u64 sum = (__force u64)csum;
+
+	src = *(const __uint128_t *)saddr->s6_addr;
+	dst = *(const __uint128_t *)daddr->s6_addr;
+
+	sum += (__force u32)htonl(len);
+	sum += (u32)proto << 24;
+	src += (src >> 64) | (src << 64);
+	dst += (dst >> 64) | (dst << 64);
+
+	sum = accumulate(sum, src >> 64);
+	sum = accumulate(sum, dst >> 64);
+
+	sum += ((sum >> 32) | (sum << 32));
+	return csum_fold((__force __wsum)(sum >> 32));
+}
+EXPORT_SYMBOL(csum_ipv6_magic);
-- 
2.27.0

