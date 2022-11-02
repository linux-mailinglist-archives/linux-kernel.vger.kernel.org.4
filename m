Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300E616F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiKBUyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKBUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:54:03 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7068D65E9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:54:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id i17-20020a170902cf1100b00183e2a963f5so11939plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DP6Vz9iL0RlSaCYvirKZYjgQfbvTBUMyha6I3zFcOmY=;
        b=QjwaCGvbGka7XMhNLDn7aFQL0++Yn0EPdP+DSYDpcpQPhmenMWMLg5xAKRmvRdxAOK
         dAV/JiQeg2q4NVVKpyHV09iJWusW6WxdOi0a2+ffSQ9hSc1iDIFtqKO1ruBPYlurFZ+g
         7rMp3uQxtpHPndcgMXIEiKM5oAeKWlpjbKapbsu3aUvheZM5LibJpTjzSz8k2d2VITWp
         NLcslt1f3UNLNkd3BzHVvvA73QW+1rPQcqSFnGUbp9MPfMJXQJU6sSb7rgyrT0rngoBJ
         HAkzzZJOqIvjCXjA2stygmj5L5niYvyoXPl8KGTWKcfW0hfCuUuBHGPJaOdiZD80H7zH
         Y3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DP6Vz9iL0RlSaCYvirKZYjgQfbvTBUMyha6I3zFcOmY=;
        b=xZE7BTZFrt2uu/dBDkttzYE4Bd26zh3OH05+U45r6DujZJ8BwCvX94kxCXfyXkp3S1
         Sp/N+GY5UeqOCO5aRMc39NsqS6MQZ1MSpU/9iSU3+QFdrWVA97oI/UtLeIFcposugTPB
         tpuKfxjVwreXt7vRuu7vV8OdIS1+x5Rfj7gRYiq4WRJ44NBkpRxsTJo2IrYhp42vDCbq
         hQcfivgCWKGsLIxnim1w8FlWpzRmuTX7buA0dk7+17erd1mR48iUPHqY/nGstcM4heYA
         y6u9Vi3mssQSR8p2Cq0715PvqIzELB62Af0TSx312x4EpGDvNX6oTrOjRhvzqQSp3ysa
         /ewg==
X-Gm-Message-State: ACrzQf21Rn9Ow9BAFQgFJ0O8q3L26m1eYMINceD6KRzPcQpDqKoaiXtL
        mp9CfTqVyMfOQTH+Ee3Qup9YTIOP+xBJ1HEnzk0pq4fX2WJt93rvwnTWrHv2ifcBoE//39zOUFB
        3nlM1FitHNXwBFyfF4NaDwsMcbJN4qURDfOK5ij3FvccdERm63fh+ePJfXQgyx9MLzhPixJF9
X-Google-Smtp-Source: AMsMyM7Ob4hJ10H8x0X5FE8OSoFlNs6vFoc5b7/Y6ocniDFi5W6BAzjyOycoyJB24joAcsjEIwsW21krNTZN
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:1d06:b0:56b:ec38:27e9 with SMTP
 id a6-20020a056a001d0600b0056bec3827e9mr26575631pfx.71.1667422442741; Wed, 02
 Nov 2022 13:54:02 -0700 (PDT)
Date:   Wed,  2 Nov 2022 20:53:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102205359.1260980-1-bgardon@google.com>
Subject: [PATCH v2] KVM: x86: Use SRCU to protect zap in __kvm_set_or_clear_apicv_inhibit()
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Anish Ghulati <aghulati@google.com>,
        Ben Gardon <bgardon@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_zap_gfn_range() must be called in an SRCU read-critical section, but
there is no SRCU annotation in __kvm_set_or_clear_apicv_inhibit(). This
can lead to the following warning via
kvm_arch_vcpu_ioctl_set_guest_debug() if a Shadow MMU is in use (TDP
MMU disabled or nesting):

[ 1416.659809] =============================
[ 1416.659810] WARNING: suspicious RCU usage
[ 1416.659839] 6.1.0-dbg-DEV #1 Tainted: G S        I
[ 1416.659853] -----------------------------
[ 1416.659854] include/linux/kvm_host.h:954 suspicious rcu_dereference_check() usage!
[ 1416.659856]
...
[ 1416.659904]  dump_stack_lvl+0x84/0xaa
[ 1416.659910]  dump_stack+0x10/0x15
[ 1416.659913]  lockdep_rcu_suspicious+0x11e/0x130
[ 1416.659919]  kvm_zap_gfn_range+0x226/0x5e0
[ 1416.659926]  ? kvm_make_all_cpus_request_except+0x18b/0x1e0
[ 1416.659935]  __kvm_set_or_clear_apicv_inhibit+0xcc/0x100
[ 1416.659940]  kvm_arch_vcpu_ioctl_set_guest_debug+0x350/0x390
[ 1416.659946]  kvm_vcpu_ioctl+0x2fc/0x620
[ 1416.659955]  __se_sys_ioctl+0x77/0xc0
[ 1416.659962]  __x64_sys_ioctl+0x1d/0x20
[ 1416.659965]  do_syscall_64+0x3d/0x80
[ 1416.659969]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Always take the KVM SRCU read lock in __kvm_set_or_clear_apicv_inhibit()
to protect the GFN to memslot translation. The SRCU read lock is not
technically required when no Shadow MMUs are in use, since the TDP MMU
walks the paging structures from the roots and does not need to look up
GFN translations in the memslots, but make the SRCU locking
unconditional for simplicty.

In most cases, the SRCU locking is taken care of in the vCPU run loop,
but when called through the KVM_SET_GUEST_DEBUG IOCTL, the SRCU read
lock is missing.

Tested: ran tools/testing/selftests/kvm/x86_64/debug_regs on a DBG
	build. This patch causes the suspicious RCU warning to disappear.
	Note that the warning is hit in __kvm_zap_rmaps(), so
	kvm_memslots_have_rmaps() must return true in order for this to
	repro (i.e. the TDP MMU must be off or nesting in use.)

Reported-by: Greg Thelen <gthelen@google.com>
Fixes: 36222b117e36 ("KVM: x86: don't disable APICv memslot when inhibited")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cd9eb13e2ed7..6d853e5f683d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10091,7 +10091,10 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 		kvm->arch.apicv_inhibit_reasons = new;
 		if (new) {
 			unsigned long gfn = gpa_to_gfn(APIC_DEFAULT_PHYS_BASE);
+			int idx = srcu_read_lock(&kvm->srcu);
+
 			kvm_zap_gfn_range(kvm, gfn, gfn+1);
+			srcu_read_unlock(&kvm->srcu, idx);
 		}
 	} else {
 		kvm->arch.apicv_inhibit_reasons = new;
-- 
2.38.1.431.g37b22c650d-goog

