Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7E64AE39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiLMDa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiLMDal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:30:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214D1B9DA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:30:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b0af5bcbd3so153978907b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IBv/w73Qp92ge1mM27QBzL+EeWNcmNZL8sCukn+Lbm4=;
        b=j1dAHXAbK+4Msudj/HHnf6xN0DoV2u8oMGpZ7vBKKgYi2Blq6OUUjTqN9ZP0SwhFiP
         NQ5nh8QW3M8k0o+0tds9o810RMiKNAyZXYos+Zgt9GsKrx6AwXoFgKvt+uDGbyohj6aO
         auwrDD8vpnKfBwKdT/fcl7YtQOVSzTrniF9OWjE55wXZSDTezwRVQE3nBi4XxDtA4UpE
         H2UlZRwSsEN51GK39gm/fvQ6BX/fje/UalOmmkNzCZjMRDl3+PRCWS/nY7yrrm2Cg3CM
         yNdSmGflIo0wl6geay22FSuESwbPUhMAcSiKVh7iQ/HzVoC2AVPD1K25cUarEl2vKnGT
         jXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBv/w73Qp92ge1mM27QBzL+EeWNcmNZL8sCukn+Lbm4=;
        b=EuibIVIlk50MKspUnFD2qnPgLTTUkahxrlxnCEDjk9Rlsh6m0TmjnaqJF6yimpP+mF
         C5953iVbO3olrSzoIH1L9hp6jUjPz0hADn5HbNE9LEmkoUpEV/iSkI89G6LgQDsKKb3z
         Apssogy5wUXoDh0gg8NtD+MNLsSXK/732hEA2r1Kfc37/9USFIy0/7x2oJ4RUeHfptPj
         SO9npQQ6gn20ON1SQwXkgfONpo3P/KBCxMAN2Mp8tniH5NEMmfCYoV1NVy5zCy7l9pqV
         QdP/9NSQU+XQ2bqu8/3yFK8t9xSVYxeLp8x8aUIJuMuO+BgOKIZsD2cTcFvoXj1MVvH0
         R5jA==
X-Gm-Message-State: ANoB5plnWqLrvYmOZBaL/dQflOZQAcXoWJED9Z3N1biwFZkl5ZvD9E16
        i5hvzZz92UAcTcWfTTLWeQKoYWbvrE0=
X-Google-Smtp-Source: AA0mqf6us1on1ziXtX1eKOb09yJ76Cqa0/NE+3KBi4uKTDOtFdvp9wcLX7R1t5pCrVhdSSkJPTXxHs37W/U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:57c3:0:b0:3c4:bb7a:9443 with SMTP id
 l186-20020a8157c3000000b003c4bb7a9443mr723618ywb.138.1670902240356; Mon, 12
 Dec 2022 19:30:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 03:30:29 +0000
In-Reply-To: <20221213033030.83345-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213033030.83345-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213033030.83345-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: x86/mmu: Don't install TDP MMU SPTE if SP has
 unexpected level
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hoo <robert.hu@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
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

Don't install a leaf TDP MMU SPTE if the parent page's level doesn't
match the target level of the fault, and instead have the vCPU retry the
faulting instruction after warning.  Continuing on is completely
unnecessary as the absolute worst case scenario of retrying is DoSing
the vCPU, whereas continuing on all but guarantees bigger explosions, e.g.

  ------------[ cut here ]------------
  kernel BUG at arch/x86/kvm/mmu/tdp_mmu.c:559!
  invalid opcode: 0000 [#1] SMP
  CPU: 1 PID: 1025 Comm: nx_huge_pages_t Tainted: G        W          6.1.0-rc4+ #64
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:__handle_changed_spte.cold+0x95/0x9c
  RSP: 0018:ffffc9000072faf8 EFLAGS: 00010246
  RAX: 00000000000000c1 RBX: ffffc90000731000 RCX: 0000000000000027
  RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: ffff888277c5b4c8
  RBP: 0600000112400bf3 R08: ffff888277c5b4c0 R09: ffffc9000072f9a0
  R10: 0000000000000001 R11: 0000000000000001 R12: 06000001126009f3
  R13: 0000000000000002 R14: 0000000012600901 R15: 0000000012400b01
  FS:  00007fba9f853740(0000) GS:ffff888277c40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000010aa7a003 CR4: 0000000000172ea0
  Call Trace:
   <TASK>
   kvm_tdp_mmu_map+0x3b0/0x510
   kvm_tdp_page_fault+0x10c/0x130
   kvm_mmu_page_fault+0x103/0x680
   vmx_handle_exit+0x132/0x5a0 [kvm_intel]
   vcpu_enter_guest+0x60c/0x16f0
   kvm_arch_vcpu_ioctl_run+0x1e2/0x9d0
   kvm_vcpu_ioctl+0x271/0x660
   __x64_sys_ioctl+0x80/0xb0
   do_syscall_64+0x2b/0x50
   entry_SYSCALL_64_after_hwframe+0x46/0xb0
   </TASK>
  Modules linked in: kvm_intel
  ---[ end trace 0000000000000000 ]---

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index fd4ae99790d7..cc1fb9a65620 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1063,7 +1063,9 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	int ret = RET_PF_FIXED;
 	bool wrprot = false;
 
-	WARN_ON(sp->role.level != fault->goal_level);
+	if (WARN_ON_ONCE(sp->role.level != fault->goal_level))
+		return RET_PF_RETRY;
+
 	if (unlikely(!fault->slot))
 		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
 	else
-- 
2.39.0.rc1.256.g54fd8350bd-goog

