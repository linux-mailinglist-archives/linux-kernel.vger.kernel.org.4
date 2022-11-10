Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7A624BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiKJUfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKJUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:35:13 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A051D30F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id nl16-20020a17090b385000b002138288fd51so4048050pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XS7y2dqHGNcxgJtQwV0riGq39Rt6nVME96ygRYhND24=;
        b=Qw3kbAB+E1OduRUrhVsKsgtgd5I2wewKT6KoO0Y9ijqeZACVtTZ/XHViHG3gOPunM7
         hLyU3uMXWnVPGcTkGBVwL0g3cCAymIbjfK6bWFPxJzUhdPfL+XW8u72DYtptNgO7bcGa
         yMqpnFsksm9T3SeElwUPRO97HFhV/o+3xSs4idxDnalvW3kbPte5DJzgoLL5iVOB+M8Z
         H8XB+oHbgeOb7qyL4eLJW2r+zMqVAuqFqcof546vGbBfA0G/NoV0LL8eghXlclaOpR9U
         JZovawC8tI4gfPIoiOo5sS8BHPrMuWQNbZlRmFwyIRc4zdTeIlLrRa6R/b63gTdKr5aX
         vLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS7y2dqHGNcxgJtQwV0riGq39Rt6nVME96ygRYhND24=;
        b=EHR3Ccsk5jOHJ44KiQI2Zw4qbWcW6emunvLY/kn226sE+2j0QHJMJcEB71W2HReSV6
         VeNIno1lx32uKjhXcsqH2fDQlc2818B5Yt9tFY3Rr+5KJaaUvr6kZHgU8Lmib79XTX/T
         xhIZERQyKhJ9xRyhzzk2Lk7QKqBWmF7SvUmUuiZHi89b9jtygfPQcjdbJT6M7abEpvOU
         9pFy9900h7RZ9rFRVY8OUToZc1CgsoEJdTl67/vY8Sf6qrvp4w7TP25G/U3KyBKh0MNh
         /Nu3mG2gJpks7xlSwWzrKU5BapTCSzAsxi2JgOYZ2tfNZAw/ETl0Q1oZNo1lgrOvQ89/
         rPUQ==
X-Gm-Message-State: ACrzQf1nMAJinlVQSeelYyjcBfleeMJ71LMhJ2J/CcSBo8or/RAYXS1T
        jabavgceWr3bJ+oQtiY3x1juYN0f63g=
X-Google-Smtp-Source: AMsMyM7xIpANwIuE6PtwYsUVANO3G7fI/7sO65l5+QNYJs/NTYwlTdz2tpr7Q+pNYuWqAmERr4T+klbMLPQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7523:b0:213:8a69:c502 with SMTP id
 q32-20020a17090a752300b002138a69c502mr67876165pjk.153.1668112511765; Thu, 10
 Nov 2022 12:35:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 20:35:02 +0000
In-Reply-To: <20221110203504.1985010-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221110203504.1985010-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110203504.1985010-4-seanjc@google.com>
Subject: [PATCH v2 3/5] x86/kasan: Rename local CPU_ENTRY_AREA variables to
 shorten names
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Sean Christopherson <seanjc@google.com>,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
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

Rename the CPU entry area variables in kasan_init() to shorten their
names, a future fix will reference the beginning of the per-CPU portion
of the CPU entry area, and shadow_cpu_entry_per_cpu_begin is a bit much.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/kasan_init_64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index d1416926ad52..ad7872ae10ed 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -331,7 +331,7 @@ void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
 void __init kasan_init(void)
 {
 	int i;
-	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
+	void *shadow_cea_begin, *shadow_cea_end;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
@@ -372,16 +372,16 @@ void __init kasan_init(void)
 		map_range(&pfn_mapped[i]);
 	}
 
-	shadow_cpu_entry_begin = (void *)CPU_ENTRY_AREA_BASE;
-	shadow_cpu_entry_begin = kasan_mem_to_shadow(shadow_cpu_entry_begin);
-	shadow_cpu_entry_begin = (void *)round_down(
-			(unsigned long)shadow_cpu_entry_begin, PAGE_SIZE);
+	shadow_cea_begin = (void *)CPU_ENTRY_AREA_BASE;
+	shadow_cea_begin = kasan_mem_to_shadow(shadow_cea_begin);
+	shadow_cea_begin = (void *)round_down(
+			(unsigned long)shadow_cea_begin, PAGE_SIZE);
 
-	shadow_cpu_entry_end = (void *)(CPU_ENTRY_AREA_BASE +
+	shadow_cea_end = (void *)(CPU_ENTRY_AREA_BASE +
 					CPU_ENTRY_AREA_MAP_SIZE);
-	shadow_cpu_entry_end = kasan_mem_to_shadow(shadow_cpu_entry_end);
-	shadow_cpu_entry_end = (void *)round_up(
-			(unsigned long)shadow_cpu_entry_end, PAGE_SIZE);
+	shadow_cea_end = kasan_mem_to_shadow(shadow_cea_end);
+	shadow_cea_end = (void *)round_up(
+			(unsigned long)shadow_cea_end, PAGE_SIZE);
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
@@ -403,9 +403,9 @@ void __init kasan_init(void)
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
-		shadow_cpu_entry_begin);
+		shadow_cea_begin);
 
-	kasan_populate_early_shadow(shadow_cpu_entry_end,
+	kasan_populate_early_shadow(shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
 	kasan_populate_shadow((unsigned long)kasan_mem_to_shadow(_stext),
-- 
2.38.1.431.g37b22c650d-goog

