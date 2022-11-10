Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C602624BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKJUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiKJUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:35:16 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0874E41E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:15 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ch8-20020a17090af40800b002140ba517b6so1629980pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u6Cw0ZmfOshKtE4Fs73s8CsSsDU0YsFyudltt9Q+W64=;
        b=F/+UCskf44ADzGslt/IGpWoJh4u6oVd2pp653aShhnTg9HGbG3ZOsV/FfEAlnWOv5l
         xsKVf7wW/egGgeqeM0wcau4N13Ku8o7LmHx1T3stlAJ8yJvPcQ1cBg+QcQV9iwsd2e8E
         HeVgQc8NwGhGuWRTVRY/EwK8DiqhRfwl3cwXbOB+JFTihHxEBUJbpnksAnzIm8pRoFIO
         9hsDruJByPgnUprVEPZoDYLLHYmVnWC+FpwJdKXALBXK8nN4FiMI/iw3lGWT8Q5JcCeg
         E8HLRuikgjnjtYd/4ZOd0xFNDQJuJrgDYUSkmPio/aXmZjRLhsZGIDceELpbs7rsc7cf
         P7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6Cw0ZmfOshKtE4Fs73s8CsSsDU0YsFyudltt9Q+W64=;
        b=LErW4KZWEDVZZ9Y/mLpinhOuYT5adKhTcDe+NO4mPd9aWlY/UJrCN3dJwkQ5XnO0Ic
         x7F+3preOBYIjt7ouOMBMlszSUpbpfwdTBQWtb2WyeEueQ8/+tyzHomVvn+ZX2Zgqzz+
         sFDukQWoSUy5CVp42+1vDd7thstpwBu5P0n9PI8mwAHe/QgCXTB8DM0+k2q3/r1c3YKu
         whimpVhnnXXszJ5rd0d49jvsSjhl174H942howCjubQ4OoTdgXZuyyv1VzpVTgYDaWS2
         94rdcktNAAivBNLtWxvtRZ4wF3S3UVE7WiURIwV6RrGxmox3zywkW67RhS9BHaHcuHJa
         0O/g==
X-Gm-Message-State: ACrzQf0VlqAdGjkqpGVV9K713CoJ5nIJfOiLfbe1tNYAuIyGPssR34ks
        aPDVva7LyzlHU2WAgFeM8Ec2Kh98krg=
X-Google-Smtp-Source: AMsMyM7vjPqvAsQewFeWzKk356hhUxKe3WeNFeH9NgriWh/GJdOOF5HI5op5QD6jNFKnHutO93ukwPXPHbM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1595:0:b0:566:9f68:c0ad with SMTP id
 143-20020a621595000000b005669f68c0admr3437397pfv.57.1668112515250; Thu, 10
 Nov 2022 12:35:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 20:35:04 +0000
In-Reply-To: <20221110203504.1985010-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221110203504.1985010-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110203504.1985010-6-seanjc@google.com>
Subject: [PATCH v2 5/5] x86/kasan: Populate shadow for shared chunk of the CPU
 entry area
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
index afc5e129ca7b..af82046348a0 100644
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
+	kasan_populate_early_shadow((void *)shadow_cea_begin,
+				    (void *)shadow_cea_per_cpu_begin);
+
 	kasan_populate_early_shadow((void *)shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
-- 
2.38.1.431.g37b22c650d-goog

