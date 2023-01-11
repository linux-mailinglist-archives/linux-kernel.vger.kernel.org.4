Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1356658D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjAKKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjAKKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:18:15 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B52D56
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:18:12 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id g28-20020a0565123b9c00b004cc8a085997so1957753lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PBX6ktcO3Ge095CwaOXemPHb5zPjrq8Ho5XrQZ9Bxvg=;
        b=bqqcT2FVFiBu6f8kPh3KoIxAbk+mVUFALhsHjDK0hMLgCUAdL5me7vcjnxCx80rB9b
         Gzc07MjHzzZo2816B4wC2RA92p8pDRX3MjCVW2puJ8lsqZJ4YmrjEHfOC70KP6UXPbxX
         e/veF5hWoeXz34SghDx7p8yLY+6r5LH0SkgCVbwfO3yTG+xXz+LeBoSYVzS53I0tLfuq
         iotLNjTOjTzEF2CA4U+JNPCmQpps+cdfwJLD6VlPGQQkdbwBbiZIH7RvH21wDqyvtbls
         ZurKCqsftSnNBDyiSKGOMNsuSKEAtMiavAPDWCpK1HgxVuf50KTKSQSPvn1OgI0A4x1V
         uWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBX6ktcO3Ge095CwaOXemPHb5zPjrq8Ho5XrQZ9Bxvg=;
        b=i5/bqWiwzWTvj3yc9s/odiauuJ+EDi8LsYTXcGtIXoWHo0gVVHGzbj5sdZkQrCR7AG
         0T15/U4KU+Cb/cbQAJhtzqzu7wd/AfwwjNRGWkTO96AQOAtggYGO5Jh+1DG8XDTs2LS7
         amAddOcmc+UqN9g+iAZt+I+eHT+I9QdkqLwwWh3fOmrnVJ7cm1Uwio0Avs+lsv/DevJX
         1zfHEZME/sDjDuhz9ctI6f7ZlZQKmkF0JlnuC+FleDrtJ+tft3FdMEWP/NpBREeYbrNs
         59gIIfmI6MhqW3CVlpajl1F1WHNsqvTDGNWl9zpHhn4S0q+FKtoLqS00seQN6UkU8UUS
         u+7g==
X-Gm-Message-State: AFqh2ko+Wtf3lcNx9H/uGze4kEeK1qG9JgWLk/bMZdyn5jyrNCvmfVns
        Vo0uA1VSuldClzgQqewPYYv0DJckUPE=
X-Google-Smtp-Source: AMrXdXsiS/4gZ6OefjNUDp2d8XXZArpryqGnokNoLm4LvBVglaG84Is8mlOk89qrIJRcyI3+99wXhjp764E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c1cc:851a:3d0:4d31])
 (user=glider job=sendgmr) by 2002:a05:6512:3b07:b0:4b6:f1af:4263 with SMTP id
 f7-20020a0565123b0700b004b6f1af4263mr3407142lfv.114.1673432291206; Wed, 11
 Jan 2023 02:18:11 -0800 (PST)
Date:   Wed, 11 Jan 2023 11:18:06 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111101806.3236991-1-glider@google.com>
Subject: [PATCH] Revert "x86: kmsan: sync metadata pages on page fault"
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, elver@google.com,
        dvyukov@google.com, linux-mm@kvack.org, kasan-dev@googlegroups.com,
        luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        Qun-Wei Lin <qun-wei.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3f1e2c7a9099c1ed32c67f12cdf432ba782cf51f.

As noticed by Qun-Wei Lin, arch_sync_kernel_mappings() in
arch/x86/mm/fault.c is only used with CONFIG_X86_32, whereas KMSAN is
only supported on x86_64, where this code is not compiled.

The patch in question dates back to downstream KMSAN branch based on
v5.8-rc5, it sneaked into upstream unnoticed in v6.1.

Reported-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Link: https://github.com/google/kmsan/issues/91
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/mm/fault.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7b0d4ab894c8b..a498ae1fbe665 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -260,7 +260,7 @@ static noinline int vmalloc_fault(unsigned long address)
 }
 NOKPROBE_SYMBOL(vmalloc_fault);
 
-static void __arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
@@ -284,27 +284,6 @@ static void __arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
-{
-	__arch_sync_kernel_mappings(start, end);
-#ifdef CONFIG_KMSAN
-	/*
-	 * KMSAN maintains two additional metadata page mappings for the
-	 * [VMALLOC_START, VMALLOC_END) range. These mappings start at
-	 * KMSAN_VMALLOC_SHADOW_START and KMSAN_VMALLOC_ORIGIN_START and
-	 * have to be synced together with the vmalloc memory mapping.
-	 */
-	if (start >= VMALLOC_START && end < VMALLOC_END) {
-		__arch_sync_kernel_mappings(
-			start - VMALLOC_START + KMSAN_VMALLOC_SHADOW_START,
-			end - VMALLOC_START + KMSAN_VMALLOC_SHADOW_START);
-		__arch_sync_kernel_mappings(
-			start - VMALLOC_START + KMSAN_VMALLOC_ORIGIN_START,
-			end - VMALLOC_START + KMSAN_VMALLOC_ORIGIN_START);
-	}
-#endif
-}
-
 static bool low_pfn(unsigned long pfn)
 {
 	return pfn < max_low_pfn;
-- 
2.39.0.314.g84b9a713c41-goog

