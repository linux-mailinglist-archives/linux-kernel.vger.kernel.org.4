Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9E6FFE96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjELB5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjELB5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:57:38 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C13BE53;
        Thu, 11 May 2023 18:57:36 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx6ekOnV1kQ_kHAA--.13667S3;
        Fri, 12 May 2023 09:57:34 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxXrMMnV1kocdWAA--.23198S2;
        Fri, 12 May 2023 09:57:33 +0800 (CST)
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
Subject: [PATCH v3 0/4] LoongArch: Add kernel address sanitizer support
Date:   Fri, 12 May 2023 09:57:27 +0800
Message-Id: <20230512015731.23787-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxXrMMnV1kocdWAA--.23198S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFy3GrWkCr45Jw1DGryUWrg_yoW5tw1fpa
        9rur95Gr4UGrnayrZ7t348ur13J3Z3Ka12qFyay395AF45Wr10vr4vkryDZF9rG3y8JFy0
        q3WrGwn0gF4jya7anT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I
        6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1/8 of kernel addresses reserved for shadow memory. But for LoongArch,
There are a lot of holes between different segments and valid address
space (256T available) is insufficient to map all these segments to kasan
shadow memory with the common formula provided by kasan core, saying
(addr >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET

So LoongArch has a arch-specific mapping formula, different segments are
mapped individually, and only limited space lengths of these specific
segments are mapped to shadow.

At early boot stage the whole shadow region populated with just one
physical page (kasan_early_shadow_page). Later, this page is reused as
readonly zero shadow for some memory that kasan currently don't track.
After mapping the physical memory, pages for shadow memory are allocated
and mapped.

Functions like memset()/memcpy()/memmove() do a lot of memory accesses.
If bad pointer passed to one of these function it is important to be
caught. Compiler's instrumentation cannot do this since these functions
are written in assembly.

KASan replaces memory functions with manually instrumented variants.
Original functions declared as weak symbols so strong definitions in
mm/kasan/kasan.c could replace them. Original functions have aliases
with '__' prefix in names, so we could call non-instrumented variant
if needed.

Changes v2 -> v3:
- Rebased on 6.4-rc1
- Add Makefile ``KASAN_SANITIZE`` annotation for tlb related files
  to adapt to multiple cores.

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

Qing Zhang (4):
  kasan: Add __HAVE_ARCH_SHADOW_MAP to support arch specific mapping
  kasan: Add (pmd|pud)_init for LoongArch zero_(pud|p4d)_populate
    process
  LoongArch: Simplify the processing of jumping new kernel for KASLR
  LoongArch: Add kernel address sanitizer support

 Documentation/dev-tools/kasan.rst             |   4 +-
 .../features/debug/KASAN/arch-support.txt     |   2 +-
 .../translations/zh_CN/dev-tools/kasan.rst    |   2 +-
 arch/loongarch/Kconfig                        |   7 +
 arch/loongarch/include/asm/kasan.h            | 120 +++++++++
 arch/loongarch/include/asm/pgtable.h          |   7 +
 arch/loongarch/include/asm/setup.h            |   2 +-
 arch/loongarch/include/asm/string.h           |  20 ++
 arch/loongarch/kernel/Makefile                |   6 +
 arch/loongarch/kernel/head.S                  |  13 +-
 arch/loongarch/kernel/relocate.c              |   8 +-
 arch/loongarch/kernel/setup.c                 |   4 +
 arch/loongarch/lib/memcpy.S                   |   4 +-
 arch/loongarch/lib/memmove.S                  |  16 +-
 arch/loongarch/lib/memset.S                   |   4 +-
 arch/loongarch/mm/Makefile                    |   2 +
 arch/loongarch/mm/kasan_init.c                | 255 ++++++++++++++++++
 arch/loongarch/vdso/Makefile                  |   4 +
 include/linux/kasan.h                         |   2 +
 mm/kasan/init.c                               |  18 +-
 mm/kasan/kasan.h                              |   6 +
 21 files changed, 478 insertions(+), 28 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kasan.h
 create mode 100644 arch/loongarch/mm/kasan_init.c

-- 
2.36.0

