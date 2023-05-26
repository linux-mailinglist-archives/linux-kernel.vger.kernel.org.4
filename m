Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE17130A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbjEZXvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbjEZXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:50:59 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D679E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:50:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-521262a6680so1328766a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685145055; x=1687737055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ1i2DguubB/+TBn/4idJEX6+htUYXJLnvWqgTtQ+sE=;
        b=oHPPJs2TrWWxfVTfh0L6PYe6vc/Ms3IcW3ZenHdvhI3xb0N3mUWHwvhAXg2lKBbnSA
         mGVb1+PpZ7crIlrD6Gi52A7680Hg0E9PY+orIMxLbSDHx8zW9k3j5kx0LAdcsNRTx2Mu
         1cFTeCdL1HR9ofonVDVrdvKpRD+5jjtuyDlZ6S2hswUNAhTQhKIAFoYB6cLZpxt5t9lm
         NRaANo4FDjvt0UczMWprEBMSVeDVmXFbuzF6wASwyQRf6tl3a/7Y9HhhzhVknO2Pzw7y
         WNXNjV6Ae/vC7RVVO7IjPopqgPsw7T7vxeBf7XRY9VDCzXYVTXEWrxs//V2fYQ64wfrK
         z5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685145055; x=1687737055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ1i2DguubB/+TBn/4idJEX6+htUYXJLnvWqgTtQ+sE=;
        b=M6DbV6PFi0QzBzKp/GlMHIBOwe3lCztaRqBpsNJiTd4uvg3PsZY1xYjIDr5uQ2ANvx
         Gk/CZVr9YhQ2ChAMl4Y7LnoOe1h3Vm6Ot8ynGDIPo8D/Kfueoyi2UCT4bwhCLwGyznG9
         JfNycopUymzxIwQ4+QWsKUDrvcEp+4jL+V/YCz5x8+tdESBGO+Enz0rpl/r+RDCPgdFM
         z4q+s/IWX4V2UqmA0B+MCqsiDPXFL3xcka16/BfG/z5RubUsx1/dHdewvFEt5kRCBfD4
         pBHtrJaVbiUY73EZS2uN4sY3HpGyQUMhnulR2/7F1KgeTQtW/mwtWLM2LQ+Pa/0I1dei
         Lguw==
X-Gm-Message-State: AC+VfDzlT0pSII3hED82zQO6llmrFTB9KN7evtEp37E+RyOKYsPH09oD
        epXCti3wyITHbx+k+p0fEXqVhpvwSas=
X-Google-Smtp-Source: ACHHUZ63QxfDBJN5gcO9zbQioZ92vLq9NWqlULPbXcgIfsDEZwl5bOocAFcUbzwZq1IWilptEAhIrasqwCw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6c2:0:b0:53f:5c6c:3d18 with SMTP id
 185-20020a6306c2000000b0053f5c6c3d18mr205156pgg.10.1685145054665; Fri, 26 May
 2023 16:50:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 26 May 2023 16:50:47 -0700
In-Reply-To: <20230526235048.2842761-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230526235048.2842761-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526235048.2842761-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: x86: Retry APIC optimized map recalc if vCPU is added/enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retry the optimized APIC map recalculation if an APIC-enabled vCPU shows
up between allocating the map and filling in the map data.  Conditionally
reschedule before retrying even though the number of vCPUs that can be
created is bounded by KVM.  Retrying a few thousand times isn't so slow
as to be hugely problematic, but it's not blazing fast either.

Reset xapic_id_mistach on each retry as a vCPU could change its xAPIC ID
between loops, but do NOT reset max_id.  The map size also factors in
whether or not a vCPU's local APIC is hardware-enabled, i.e. userspace
and/or the guest can theoretically keep KVM retrying indefinitely.  The
only downside is that KVM will allocate more memory than is strictly
necessary if the vCPU with the highest x2APIC ID disabled its APIC while
the recalculation was in-progress.

Refresh kvm->arch.apic_map_dirty to opportunistically change it from
DIRTY => UPDATE_IN_PROGRESS to avoid an unnecessary recalc from a
different task, i.e. if another task is waiting to attempt an update
(which is likely since a retry happens if and only if an update is
required).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3c300a196bdf..cadeaba25e65 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -381,7 +381,8 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 	u32 max_id = 255; /* enough space for any xAPIC ID */
-	bool xapic_id_mismatch = false;
+	bool xapic_id_mismatch;
+	int r;
 
 	/* Read kvm->arch.apic_map_dirty before kvm->arch.apic_map.  */
 	if (atomic_read_acquire(&kvm->arch.apic_map_dirty) == CLEAN)
@@ -391,9 +392,14 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		  "Dirty APIC map without an in-kernel local APIC");
 
 	mutex_lock(&kvm->arch.apic_map_lock);
+
+retry:
 	/*
-	 * Read kvm->arch.apic_map_dirty before kvm->arch.apic_map
-	 * (if clean) or the APIC registers (if dirty).
+	 * Read kvm->arch.apic_map_dirty before kvm->arch.apic_map (if clean)
+	 * or the APIC registers (if dirty).  Note, on retry the map may have
+	 * not yet been marked dirty by whatever task changed a vCPU's x2APIC
+	 * ID, i.e. the map may still show up as in-progress.  In that case
+	 * this task still needs to retry and copmlete its calculation.
 	 */
 	if (atomic_cmpxchg_acquire(&kvm->arch.apic_map_dirty,
 				   DIRTY, UPDATE_IN_PROGRESS) == CLEAN) {
@@ -402,6 +408,15 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		return;
 	}
 
+	/*
+	 * Reset the mismatch flag between attempts so that KVM does the right
+	 * thing if a vCPU changes its xAPIC ID, but do NOT reset max_id, i.e.
+	 * keep max_id strictly increasing.  Disallowing max_id from shrinking
+	 * ensures KVM won't get stuck in an infinite loop, e.g. if the vCPU
+	 * with the highest x2APIC ID is toggling its APIC on and off.
+	 */
+	xapic_id_mismatch = false;
+
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		if (kvm_apic_present(vcpu))
 			max_id = max(max_id, kvm_x2apic_id(vcpu->arch.apic));
@@ -420,9 +435,15 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		if (!kvm_apic_present(vcpu))
 			continue;
 
-		if (kvm_recalculate_phys_map(new, vcpu, &xapic_id_mismatch)) {
+		r = kvm_recalculate_phys_map(new, vcpu, &xapic_id_mismatch);
+		if (r) {
 			kvfree(new);
 			new = NULL;
+			if (r == -E2BIG) {
+				cond_resched();
+				goto retry;
+			}
+
 			goto out;
 		}
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

