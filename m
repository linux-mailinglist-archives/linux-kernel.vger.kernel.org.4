Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CD6D5B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjDDIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjDDInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:43:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A47162709;
        Tue,  4 Apr 2023 01:43:12 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_5cf4ytkr10WAA--.34838S3;
        Tue, 04 Apr 2023 16:43:11 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxT+Qc4ytkChcVAA--.55041S2;
        Tue, 04 Apr 2023 16:43:09 +0800 (CST)
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
Subject: [PATCH v2 4/6] kasan: Add __HAVE_ARCH_SHADOW_MAP to support arch specific mapping
Date:   Tue,  4 Apr 2023 16:43:06 +0800
Message-Id: <20230404084308.813-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxT+Qc4ytkChcVAA--.55041S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WryDtw1xWw18Xw1UAr17Awb_yoW8uw4UpF
        ZrGFyxtrs2qFy0ga43Cr4Uur15JrnaqF4ktrZIgw4rCFy5W3WvqF1q9F9Yyrn7Wr47tFyY
        vwn7ZFZxJr90q3DanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bhxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
        0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
        I7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU08gA7UUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the LoongArch, which has many holes between different segments
and valid address space(256T available) is insufficient to map all
these segments to kasan shadow memory with the common formula provided
by kasan core, We need architecture specific mapping formula,different
segments are mapped individually, and only limited length of space of
that specific segment is mapped to shadow.

Therefore, when the incoming address is converted to a shadow, we need
to add a condition to determine whether it is valid.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 include/linux/kasan.h | 2 ++
 mm/kasan/kasan.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f7ef70661ce2..3b91b941873d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -54,11 +54,13 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
+#ifndef __HAVE_ARCH_SHADOW_MAP
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
 	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
 		+ KASAN_SHADOW_OFFSET;
 }
+#endif
 
 int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a61eeee3095a..033335c13b25 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -291,16 +291,22 @@ struct kasan_stack_ring {
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
+#ifndef __HAVE_ARCH_SHADOW_MAP
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
 	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
+#endif
 
 static __always_inline bool addr_has_metadata(const void *addr)
 {
+#ifdef __HAVE_ARCH_SHADOW_MAP
+	return (kasan_mem_to_shadow((void *)addr) != NULL);
+#else
 	return (kasan_reset_tag(addr) >=
 		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
+#endif
 }
 
 /**
-- 
2.20.1

