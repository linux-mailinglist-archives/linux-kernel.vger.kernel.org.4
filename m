Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142AF61A000
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiKDSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiKDSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:33:00 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00440919
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:32:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q3-20020a17090311c300b0017898180dddso4120501plh.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YYBJ31ou5Rwg5LoGtjJ6FG68fLUfYn1uUGIk9MyRKGY=;
        b=lSOSZi+kphdHFzsfDzuxPltgdYT52XM9vY5sOjBzYtVo0p2a1WGY/nTF11dzy8Qbx8
         ez1v5pmtsDrjYrir1duKzoEcT0qcI0g4kWaXGKHs4w1r3UM3X3tUgQ8qOZioUqbgqyeb
         7RrYIa7XhuH5JbZ1TLX3yoZ5EQafu4N/7G108aQOf3w0N6ZtRs6rsuQxxcbzzUyV4ANi
         k6JFOVVConNg+UlCWbyXqapxwbpAty/FwQEd6zOf5bWeiAad6+ZqYsyIYEaa4vkYu6hX
         Baa0w3EULQ5pVyq6f0u6UOAP+cI3sAwFz9DtPeHjV3OyccRoR8qPsYvul2C9eMIqzZvr
         Sopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYBJ31ou5Rwg5LoGtjJ6FG68fLUfYn1uUGIk9MyRKGY=;
        b=IIQLy2fOzY7/DV6yYfGA1YS1QXo99p3Y0I1dct5Uoeb1YbbJDFqu5CzDJz8nbVteV+
         S7OgmAVq3YRD7UuxiKYCNuVKt+ZSU4Esy4cEcLBeNFjDl/WBlqdHXay7ImFz8guzMfId
         LJCD4P+u1N72i7JSd4CHyI3Ux2vTZkyj8sYK09J1Apz3U5jPJezmV87aJeQkQa8rcnDc
         1lyuOPA/mHCCkgNSII+jMrJlS7pCX/tg5C9aA+PxxI9PsqotjZLExN4ScHk6REFZOAsj
         hd3m/J6WLbKpGmZn8oVLZ5Kb2BJwEkvxMNYqbGhLKRSCKCcOPp5y3F/soTPFGZ62ekdb
         tr4g==
X-Gm-Message-State: ACrzQf1k5EB2PGGJlQc+oXTiJoomp+ihyJhiRE1DKj10jMxwwJPkdIay
        duoUNMLigzTdrO4YIDcy+9Y048p7x5U=
X-Google-Smtp-Source: AMsMyM5AzYyUyY4WLPr0o7OeQqIFQaRG+NcbCZ2jehe2vxhaONBNiLQ0/sbFDkHT0pjDK29vN/bWCU5LarI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2886:b0:565:c4e2:2634 with SMTP id
 ch6-20020a056a00288600b00565c4e22634mr366477pfb.0.1667586777418; Fri, 04 Nov
 2022 11:32:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 18:32:47 +0000
In-Reply-To: <20221104183247.834988-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221104183247.834988-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104183247.834988-4-seanjc@google.com>
Subject: [PATCH 3/3] x86/kasan: Populate shadow for shared chunk of the CPU
 entry area
From:   Sean Christopherson <seanjc@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
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

Popuplate the shadow for the shared portion of the CPU entry area, i.e.
the read-only IDT mapping, during KASAN initialization.  A recent change
modified KASAN to map the per-CPU areas on-demand, but forgot to keep a
shadow for the common area that is shared amongst all CPUs.

Map the common area in KASAN init instead of letting idt_map_in_cea() do
the dirty work so that it Just Works in the unlikely event more shared
data is shoved into the CPU entry area.

The bug manifests as a not-present #PF when software attempts to lookup
an IDT entry, e.g. when KVM is handling IRQs on Intel CPUs (KVM performs
direct CALL to the IRQ handler to avoid the overhead of INTn):

 BUG: unable to handle page fault for address: fffffbc0000001d8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 16c03a067 P4D 16c03a067 PUD 0
 Oops: 0000 [#1] PREEMPT SMP KASAN
 CPU: 5 PID: 901 Comm: repro Tainted: G        W          6.1.0-rc3+ #410
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:kasan_check_range+0xdf/0x190
  vmx_handle_exit_irqoff+0x152/0x290 [kvm_intel]
  vcpu_run+0x1d89/0x2bd0 [kvm]
  kvm_arch_vcpu_ioctl_run+0x3ce/0xa70 [kvm]
  kvm_vcpu_ioctl+0x349/0x900 [kvm]
  __x64_sys_ioctl+0xb8/0xf0
  do_syscall_64+0x2b/0x50
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Reported-by: syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/kasan_init_64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index afc5e129ca7b..0302491d799d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -341,7 +341,7 @@ void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
 
 void __init kasan_init(void)
 {
-	unsigned long shadow_cea_begin, shadow_cea_end;
+	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
 	int i;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
@@ -384,6 +384,7 @@ void __init kasan_init(void)
 	}
 
 	shadow_cea_begin = kasan_mem_to_shadow_align_down(CPU_ENTRY_AREA_BASE);
+	shadow_cea_per_cpu_begin = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_PER_CPU);
 	shadow_cea_end = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_BASE +
 						      CPU_ENTRY_AREA_MAP_SIZE);
 
@@ -409,6 +410,15 @@ void __init kasan_init(void)
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
 		(void *)shadow_cea_begin);
 
+	/*
+	 * Populate the shadow for the shared portion of the CPU entry area.
+	 * Shadows for the per-CPU areas are mapped on-demand, as each CPU's
+	 * area is randomly placed somewhere in the 512GiB range and mapping
+	 * the entire 512GiB range is prohibitively expensive.
+	 */
+	kasan_populate_shadow(shadow_cea_begin,
+			      shadow_cea_per_cpu_begin, 0);
+
 	kasan_populate_early_shadow((void *)shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
-- 
2.38.1.431.g37b22c650d-goog

