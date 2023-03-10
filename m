Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB96B3B45
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCJJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:48:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD688474F2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:47:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so4514663wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678441666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6J6lRuGpbM7E9O7f7bljUjx0eKgcV/6jZ6mdNRRq+4=;
        b=JUZ6MS0ezJc5yh4n6KTD+iS0WsCulf8ihBW2NAvKNEq0/OB5Yl3u3Id3vcVGms8+Zh
         dy0R5ZAoYZe1+5BB4Ca7JUS88v8KD9qo3j2ZtpZ3YcD6dhav6UfqVvBndyVRy4znafUr
         SnyvqHVNZEfBo+F2qRp6xuk0sVwvpBO5NzGxZbWL64VKd3PuD6o4m+7enUFb65JiLMrD
         5Jvj7gBmtNYyrjDHsAI5NaAPtnjzy0RkGbkThWLIaSy6KlT9qCaNhB2m3HYD5+ztqRIL
         fDTxQFZDR13CddYNIljUltNoKv1Caa4FNdhMJm/MCwABN/OoQJutLpcdhPMIoHPiZaL8
         5CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6J6lRuGpbM7E9O7f7bljUjx0eKgcV/6jZ6mdNRRq+4=;
        b=Rz1pc1qmeyBLhbe3fF11SFcW3GCjP5mhCFb1GG+3VrtWFhBX4K/WaqYhECEW+kX4cq
         Vg6AKftloFN0d/28l/tRiIFnwAtL3lIjEC6HUexjdp2x+BWzQNB/oMbLQEB4bhJ/3hmI
         pKIezOcmL6LG50ao9j7/WChz1TuM8ovsAy6LurJpz5gbg0OhiMlOxzqPv7uEoZWiQRw8
         bpHoDx5KHhhfIfaIMkGrmogw2wMt4NXmcLo8kgonMLMxJiS/uZqqbETs1vuzsTcF9/2o
         XIHBqzpqJeQdko3oxvfrjFxsuF49OoRdTLR/ApApqbcDoe4r0cgQQ+UQtoZDA7bFbBwp
         VNnA==
X-Gm-Message-State: AO0yUKV1fVOEcujiaRuY0bS0iks03wBZyPLBMSGZPzrP5yrJOVe4Xart
        2xRxbVG1jBTSCyShKVvqXhJ2pg==
X-Google-Smtp-Source: AK7set+hIKDyMZLEzQZwJrQZ4Ml18aDplEsgmJbGeNc4aX7RXiRyHxB8XeJIUJU9oYunTbo6EYqvmg==
X-Received: by 2002:a05:600c:198e:b0:3eb:2f3b:4477 with SMTP id t14-20020a05600c198e00b003eb2f3b4477mr1930695wmq.28.1678441666270;
        Fri, 10 Mar 2023 01:47:46 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g9-20020a7bc4c9000000b003e20970175dsm2410949wmk.32.2023.03.10.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:47:46 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v7 2/4] mm: Introduce memblock_isolate_memory
Date:   Fri, 10 Mar 2023 10:45:37 +0100
Message-Id: <20230310094539.764357-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230310094539.764357-1-alexghiti@rivosinc.com>
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function allows to split a region in memblock.memory and will be
useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
allows to isolate the kernel text/rodata and then avoid to map those
regions with a PUD/P4D/PGD.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..2f7ef97c0da7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -125,6 +125,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_isolate_memory(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..d8cf1c9eccf0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -753,7 +753,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 	int idx;
 	struct memblock_region *rgn;
 
-	*start_rgn = *end_rgn = 0;
+	if (start_rgn && end_rgn)
+		*start_rgn = *end_rgn = 0;
 
 	if (!size)
 		return 0;
@@ -795,6 +796,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 					       memblock_get_region_node(rgn),
 					       rgn->flags);
 		} else {
+			if (!end_rgn || !start_rgn)
+				continue;
+
 			/* @rgn is fully contained, record it */
 			if (!*end_rgn)
 				*start_rgn = idx;
@@ -805,6 +809,22 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 	return 0;
 }
 
+/**
+ * memblock_isolate_memory - isolate given range from memblock.memory
+ * @base: base of range to isolate
+ * @size: size of range to isolate
+ *
+ * Call memblock_isolate_range on memblock.memory to isolate the given range.
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
+
+int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_isolate_range(&memblock.memory, base, size, NULL, NULL);
+}
+
 static int __init_memblock memblock_remove_range(struct memblock_type *type,
 					  phys_addr_t base, phys_addr_t size)
 {
-- 
2.37.2

