Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0646D5B10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjDDImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDDImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:42:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C1A21BFE;
        Tue,  4 Apr 2023 01:42:04 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Ax69nZ4itkOl0WAA--.34269S3;
        Tue, 04 Apr 2023 16:42:01 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxwOTW4itkYRYVAA--.55009S2;
        Tue, 04 Apr 2023 16:41:59 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/6] LoongArch: Add kernel address sanitizer support 
Date:   Tue,  4 Apr 2023 16:41:42 +0800
Message-Id: <20230404084148.744-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxwOTW4itkYRYVAA--.55009S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFyfuryDuw4kZr4rXw4kXrb_yoWrJrWkpa
        9rur95GF48Grs2yrn7t34Uur13J3Z3Kay2qFyay34rCF43Wr10vryv9ryDZF9rG3y8JFy0
        qw4rG3Z8XFWYyaDanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxUsw0eDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Address Sanitizer (KASAN) is a dynamic memory safety error detector
designed to find out-of-bounds and use-after-free bugs, Generic KASAN is
supported on LoongArch now.

1/8 of kernel addresses reserved for shadow memory. But for LoongArch,
There are a lot of holes between different segments and valid address
space(256T available) is insufficient to map all these segments to kasan
shadow memory with the common formula provided by kasan core, saying
addr >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET

So LoongArch has a ARCH specific mapping formula,different segments
are mapped individually, and only limited length of space of that
specific segment is mapped to shadow.

At early boot stage the whole shadow region populated with just
one physical page (kasan_early_shadow_page). Later, this page is
reused as readonly zero shadow for some memory that Kasan currently
don't track.
After mapping the physical memory, pages for shadow memory are
allocated and mapped.

Functions like memset/memmove/memcpy do a lot of memory accesses.
If bad pointer passed to one of these function it is important
to catch this. Compiler's instrumentation cannot do this since
these functions are written in assembly.
KASan replaces memory functions with manually instrumented variants.
Original functions declared as weak symbols so strong definitions
in mm/kasan/kasan.c could replace them. Original functions have aliases
with '__' prefix in name, so we could call non-instrumented variant
if needed.

Changes v1 -> v2:
Suggested by Andrey:
- Make two separate patches for changes to public files.
- Removes unnecessary judgments in check_region_inline.
- Add pud/pmd_init __weak define.
- Add Empty function kasan_(early)_init when CONFIG_KASAN turned off.
Suggested by Huacai:
- Split the simplified relocation patch.
Suggested by Youling:
- Add ARCH_HAS_FORTIFY_SOURCE in Kconfig and split into separate patches.
- update `Documentation/translations/zh_CN/dev-tools/kasan.rst`.
- Use macros to avoid using magic values directly.
- Modify patch sequence.
- Remove redundant tab.
- Modify submission information.

Qing Zhang (6):
  LoongArch: Simplified randomization layout after jump new kernel
    processing
  LoongArch: Fix _CONST64_(x) as unsigned
  LoongArch: Add kernel address sanitizer support
  kasan: Add __HAVE_ARCH_SHADOW_MAP to support arch specific mapping
  kasan: Add (pmd|pud)_init for LoongArch zero_(pud|p4d)_populate
    process
  LoongArch: Add ARCH_HAS_FORTIFY_SOURCE

 Documentation/dev-tools/kasan.rst             |   4 +-
 .../features/debug/KASAN/arch-support.txt     |   2 +-
 .../translations/zh_CN/dev-tools/kasan.rst    |   2 +-
 arch/loongarch/Kconfig                        |   8 +
 arch/loongarch/include/asm/addrspace.h        |   4 +-
 arch/loongarch/include/asm/kasan.h            | 125 +++++++++
 arch/loongarch/include/asm/pgtable.h          |   7 +
 arch/loongarch/include/asm/setup.h            |   2 +-
 arch/loongarch/include/asm/string.h           |  20 ++
 arch/loongarch/kernel/Makefile                |   3 +
 arch/loongarch/kernel/head.S                  |  12 +-
 arch/loongarch/kernel/relocate.c              |   8 +-
 arch/loongarch/kernel/setup.c                 |   4 +
 arch/loongarch/lib/memcpy.S                   |   4 +-
 arch/loongarch/lib/memmove.S                  |  13 +-
 arch/loongarch/lib/memset.S                   |   4 +-
 arch/loongarch/mm/Makefile                    |   2 +
 arch/loongarch/mm/kasan_init.c                | 255 ++++++++++++++++++
 arch/loongarch/vdso/Makefile                  |   4 +
 include/linux/kasan.h                         |   2 +
 mm/kasan/init.c                               |  18 +-
 mm/kasan/kasan.h                              |   6 +
 22 files changed, 481 insertions(+), 28 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kasan.h
 create mode 100644 arch/loongarch/mm/kasan_init.c

-- 
2.20.1

