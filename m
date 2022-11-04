Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E388F61A346
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKDVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:24:44 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4E4E42F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:24:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso4322882plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG1mlrDYCYVQ66+gGflTWD0vEgGOvioVVAQzm046g0w=;
        b=ArHTBmvCIKJmEkGvU+CZmdhiyP8UqJKmOJqB9oJvmfgv6zudO+mQRBa9XH+f6XfJFV
         OKc3s5OzvclNBHKkw/hmysyh/TN9Vsl3VnReicavvBJNLojL8WMd5cJz978mzvkV7yUc
         rYBC2LRtheyP+eOVNNMS+9Xqq3fuGtPKtm/RzmANDWuJg+IKutvIA3TzOhLBzNzU4vLy
         q9HSGs2DXqZC3MnuG5eTGwxz3BkxaKGaqx0RyHHPEC7nd12TKJLkYnkkzWxlq/9KGXGz
         gZb/pNQgql4Ul7Mprq7oGKnA2KMaWBY7ltUYsWQ1kDQHNMzWh5bX+ETOPgJa4tTN088L
         HHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG1mlrDYCYVQ66+gGflTWD0vEgGOvioVVAQzm046g0w=;
        b=r1rjqggFSg8mXuOWj6d+J2fV5qOQ8qDFVzi02rKTblsKfJzLhw/xxUmONSHFaw8PJ2
         NbB7CCgrm5gfHMbUVnG/S0SwYX0pPV8NJCJWUynKjWv2RBVLAUEdB3HAl/SGLe52RT9q
         9uBj8qJPvklZkHgtwhNwSUhDmbANwUaEp0RGTu6I09XRbv7UU/rK1aE508ufITyrew+8
         h6NDkJ1GYstxWxfH+Mj/X2Z7nPXZfby8lhsGiyL3MLjxmscSsCpxmV1tcdLLznOoitmM
         AazzbnzdPdElIGRQx2DJeNGfl23Su9r+qbc/yNp2Z9kINCG7x8Vd4Vem5cF8sLmudYq2
         ppnw==
X-Gm-Message-State: ACrzQf3rG6n6GewX1TSIA9jJ2aZsBatm4sXDP3/xysK/dbaVcArS5/N7
        9wnG+2/anHYzzUggT+udUHUFQ9vnRrM=
X-Google-Smtp-Source: AMsMyM7AVeLM7PmIzLjphIKFJNsq1ci68vRCopo5NkygXFIZwdNm8uu/qgpW0CNXoY6ypFIm7mg+z6+qCOc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f304:b0:182:2589:db21 with SMTP id
 c4-20020a170902f30400b001822589db21mr394567ple.151.1667597075466; Fri, 04 Nov
 2022 14:24:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 21:24:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104212433.1339826-1-seanjc@google.com>
Subject: [PATCH] x86/mm: Populate KASAN shadow for per-CPU GDT mapping in CPU
 entry area
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Sean Christopherson <seanjc@google.com>
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

Bounce through cea_map_percpu_pages() when setting protections for the
per-CPU GDT mapping so that KASAN populates a shadow for said mapping.
Failure to populate the shadow will result in a not-present #PF during
KASAN validation if the kernel performs a software lookup into the GDT.

The bug is most easily reproduced by doing a sigreturn with a garbage
CS in the sigcontext, e.g.

  int main(void)
  {
    struct sigcontext regs;

    syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
    syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
    syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);

    memset(&regs, 0, sizeof(regs));
    regs.cs = 0x1d0;
    syscall(__NR_rt_sigreturn);
    return 0;
  }

to coerce the kernel into doing a GDT lookup to compute CS.base when
reading the instruction bytes on the subsequent #GP to determine whether
or not the #GP is something the kernel should handle, e.g. to fixup UMIP
violations or to emulate CLI/STI for IOPL=3 applications.

  BUG: unable to handle page fault for address: fffffbc8379ace00
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 16c03a067 P4D 16c03a067 PUD 15b990067 PMD 15b98f067 PTE 0
  Oops: 0000 [#1] PREEMPT SMP KASAN
  CPU: 3 PID: 851 Comm: r2 Not tainted 6.1.0-rc3-next-20221103+ #432
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kasan_check_range+0xdf/0x190
  Call Trace:
   <TASK>
   get_desc+0xb0/0x1d0
   insn_get_seg_base+0x104/0x270
   insn_fetch_from_user+0x66/0x80
   fixup_umip_exception+0xb1/0x530
   exc_general_protection+0x181/0x210
   asm_exc_general_protection+0x22/0x30
  RIP: 0003:0x0
  Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  RSP: 0003:0000000000000000 EFLAGS: 00000202
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000001d0
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index dff9001e5e12..4a6440461c10 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -195,7 +195,7 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
-	cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
+	cea_map_percpu_pages(&cea->gdt, get_cpu_gdt_rw(cpu), 1, gdt_prot);
 
 	cea_map_percpu_pages(&cea->entry_stack_page,
 			     per_cpu_ptr(&entry_stack_storage, cpu), 1,

base-commit: 81214a573d19ae2fa5b528286ba23cd1cb17feec
-- 
2.38.1.431.g37b22c650d-goog

