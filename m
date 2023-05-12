Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B25B6FFE9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjELB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbjELB5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:57:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B4C55B1;
        Thu, 11 May 2023 18:57:40 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxRukSnV1kW_kHAA--.13368S3;
        Fri, 12 May 2023 09:57:38 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxXrMMnV1kocdWAA--.23198S4;
        Fri, 12 May 2023 09:57:37 +0800 (CST)
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
Subject: [PATCH v3 2/4] kasan: Add (pmd|pud)_init for LoongArch zero_(pud|p4d)_populate process
Date:   Fri, 12 May 2023 09:57:29 +0800
Message-Id: <20230512015731.23787-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230512015731.23787-1-zhangqing@loongson.cn>
References: <20230512015731.23787-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxXrMMnV1kocdWAA--.23198S4
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ArW5Zry3GF4fXry5Ar1UJrb_yoW8AF47pF
        WUK3W0qw47XanrXws3Jr1vgry7Jan3K3W7Kay2kr1rJ345XrWUXFy8Jr1q9rs8AFWkZFyS
        yan3Kr9xC3WDJaDanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnLID5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch populates pmd/pud with invalid_pmd_table/invalid_pud_table in
pagetable_init, So pmd_init/pud_init(p) is required, define them as __weak
in mm/kasan/init.c, like mm/sparse-vmemmap.c.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 mm/kasan/init.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..a7fa223b96e4 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -139,6 +139,10 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 	return 0;
 }
 
+void __weak __meminit pmd_init(void *addr)
+{
+}
+
 static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 				unsigned long end)
 {
@@ -166,8 +170,9 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pud_populate(&init_mm, pud,
-					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+				pmd_init(p);
+				pud_populate(&init_mm, pud, p);
 			}
 		}
 		zero_pmd_populate(pud, addr, next);
@@ -176,6 +181,10 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 	return 0;
 }
 
+void __weak __meminit pud_init(void *addr)
+{
+}
+
 static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				unsigned long end)
 {
@@ -207,8 +216,9 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				p4d_populate(&init_mm, p4d,
-					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+				pud_init(p);
+				p4d_populate(&init_mm, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
-- 
2.36.0

