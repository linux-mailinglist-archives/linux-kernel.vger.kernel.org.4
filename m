Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007B15F8320
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJHFYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHFYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:24:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A500B80F43
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:24:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so9904743wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 22:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wiztzuOtCEU0Qby3b+Cjeapd1qrW2PKoKDkQzm29WU=;
        b=RcbW3GVtlnHb05sjjXDPAtbaHE2bUV0gUQ+qdGkL/3DfBMSyhZq02EpY/OU65jQXYC
         CfDvhaG/pDkAwsXPEkoAesBN3CapZZU0HssG60cEL33syEEoRHG+U+QpQdsfr8EF4fA9
         ecbP4bA7ievotCrf+0pL6izpuFBav/HIcinVZ0imW9SkFHoMQD+pyLWFsEXWfmoUBRUW
         D8dtLZRaCWU/YH1ipiZkCNy1U/snEqyGvk3i2A8652v/JmUDF3Usg7ze6UmKlZsDIvs3
         b3V3xQg9KDwiQvLPdZgrXsHx5Eyj8PrDFbBy+3Bv72trEpYH+G6VBGu88T6fmR83kCpz
         iY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wiztzuOtCEU0Qby3b+Cjeapd1qrW2PKoKDkQzm29WU=;
        b=Hf72NKYwX6ix6coqwdgShhvV3P9rLwGJpMBaz+ddVxqBUJB2vSkfdAbOI/LcejkV6q
         otiOmMOZj3HzcJVbZj43XfNvd0cvo88BI5dcaAXyD8Dt+dDDhOme846yO6e7GVrCaWGJ
         mIKmhQ67rGyLRlvdgUaoPx60ajSZsB9wZGJ0IB8/ZF1l/5g/CcT5z2OBNTVxmuIBrBNx
         T2GBljrL51hG4josrKTzhuVIqMfk1Wn8IgGyBJkVwCjvpoCdyixkDMWQ0p1woIHyLArh
         hJKKTTqsrgr165SXBdtPzB/1hD7vKgOeGHDMjVbYVnLplswvFTh0BM+Er6rQsY/mwKI6
         wRrw==
X-Gm-Message-State: ACrzQf30KNnwih4K0x5r1kTs/YzS+U0ey8Gv6KsAvbbOYtU7W8Z5B9RN
        I9HJaBgZPaT+4E9mWnZ6jk5pRVzbxLw=
X-Google-Smtp-Source: AMsMyM6+sI0N/LOg+PomLfgsupYRT76OkFfck2VOI4p2vwVvqWetsIPnWTbBQEKKEHdKqU36eDO10Q==
X-Received: by 2002:a5d:6c6f:0:b0:22e:3fdf:4b27 with SMTP id r15-20020a5d6c6f000000b0022e3fdf4b27mr5224179wrz.150.1665206668299;
        Fri, 07 Oct 2022 22:24:28 -0700 (PDT)
Received: from localhost ([88.83.123.243])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b4c40378casm10513537wmb.39.2022.10.07.22.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 22:24:27 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     openrisc@lists.librecores.org, Jann Horn <jannh@google.com>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached
Date:   Sat,  8 Oct 2022 06:24:21 +0100
Message-Id: <20221008052422.29695-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

Since commit 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page
walker"), walk_page_range() on kernel ranges won't work anymore,
walk_page_range_novma() must be used instead.

Note: I don't have an openrisc development setup, so this is completely
untested.

Fixes: 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Repost to include LKML.
 - Added my SOB
 - I tested this by booking this on the qemu virt platform and it works fine.

 arch/openrisc/kernel/dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index a82b2caaa560..b3edbb33b621 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -74,10 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
-	mmap_read_lock(&init_mm);
-	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
-			NULL);
-	mmap_read_unlock(&init_mm);
+	mmap_write_lock(&init_mm);
+	error = walk_page_range_novma(&init_mm, va, va + size,
+			&set_nocache_walk_ops, NULL, NULL);
+	mmap_write_unlock(&init_mm);
 
 	if (error)
 		return ERR_PTR(error);
@@ -88,11 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
 	unsigned long va = (unsigned long)cpu_addr;
 
-	mmap_read_lock(&init_mm);
+	mmap_write_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
-	WARN_ON(walk_page_range(&init_mm, va, va + size,
-			&clear_nocache_walk_ops, NULL));
-	mmap_read_unlock(&init_mm);
+	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
+			&clear_nocache_walk_ops, NULL, NULL));
+	mmap_write_unlock(&init_mm);
 }
 
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
-- 
2.37.2

