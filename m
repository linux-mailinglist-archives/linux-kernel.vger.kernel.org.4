Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1F5F17E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiJABCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiJABB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:01:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F3BBF1D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7-20020a25bac7000000b006bca90f4fa0so5228468ybk.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=zGJjgeGb5byLUqJgqEY986KYGiQTamhxB3MKdq/8Nxs=;
        b=SgVLlvgS6iLoaJTazsHZsgnIzTArr/g8dO5/icu95n9EyKqI6z/C9+WZrRApHDDS/b
         NXb0om8dRMmQHnwquMIhUlXZ5fyFqQwakCOMrEW40kFS5DxwbUbKhEPVq0OSI6zPTYlF
         fHPJIgacfJ2YiBVbyrPwwDXTEZT51Mg9av+NxOFSiFaF0LAeOFMuf6QHlvMODZz7OVGa
         4XDU8WAn1U057GwvpEj3yQQfAdbAfhdckiFhf+5XbfF5LRn+F52wIm+iXBnM15Z8Kg7T
         1zGsF4qF9Hl6jCjYTBkONUuV1Xdc8QHZI531htpLyNSq3D72b8K0ROwIUuY9Mik1G9P8
         Y+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=zGJjgeGb5byLUqJgqEY986KYGiQTamhxB3MKdq/8Nxs=;
        b=SMC0FDZ50NdDawcz8vczOQo72LO7c296Blmujfz1jG/7bjZFta7Oq5A4GPcDZyyXe7
         LnfRtmS4IH9ue+aS9faLiqmqMNxTXvM5Ecq/P0FwXiQ6YZgr6RFNNcvEiSmtAJWj4Jm8
         sbexOW2X4aDe/12teCGfRc8cEHcZn1ALrWz1AseestQND8BeJNx7NokWxXTbfN+KEsPW
         qMxXhHhgDWeGeaxfME5iJmQQqke7xakAanfyuPnmNfTEuyB5b3hDQq6JuaChsGRUroBB
         GW5DgVqnnZG25F9LSaon9Ft0GyaNpPbdDkh1Czd6+4XP3Mdb9vnE5xOWbpGvoe6MA4tC
         tD7A==
X-Gm-Message-State: ACrzQf3EKsjyhQi2ANdbYtDT5LNX0nKmkkGFTCDDdJda16Bt2xO/x6eu
        udS1TBb7cug0yA17soobnXbPqQmfhYg=
X-Google-Smtp-Source: AMsMyM5oUcNAYKqngfw8uxXjqlArjGuLA67Dj2SROVnmKezZnVMPQAtfcw7SbomFa4FpIqhD0q1v+OEV+Dw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5cd:0:b0:6ae:a4be:ab42 with SMTP id
 196-20020a2505cd000000b006aea4beab42mr10394464ybf.323.1664585992779; Fri, 30
 Sep 2022 17:59:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:03 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-21-seanjc@google.com>
Subject: [PATCH v4 20/32] KVM: x86: Skip redundant x2APIC logical mode
 optimized cluster setup
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Skip the optimized cluster[] setup for x2APIC logical mode, as KVM reuses
the optimized map's phys_map[] and doesn't actually need to insert the
target apic into the cluster[].  The LDR is derived from the x2APIC ID,
and both are read-only in KVM, thus the vCPU's cluster[ldr] is guaranteed
to be the same entry as the vCPU's phys_map[x2apic_id] entry.

Skipping the unnecessary setup will allow a future fix for aliased xAPIC
logical IDs to simply require that cluster[ldr] is non-NULL, i.e. won't
have to special case x2APIC.

Alternatively, the future check could allow "cluster[ldr] == apic", but
that ends up being terribly confusing because cluster[ldr] is only set
at the very end, i.e. it's only possible due to x2APIC's shenanigans.

Another alternative would be to send x2APIC down a separate path _after_
the calculation and then assert that all of the above, but the resulting
code is rather messy, and it's arguably unnecessary since asserting that
the actual LDR matches the expected LDR means that simply testing that
interrupts are delivered correctly provides the same guarantees.

Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9989893fef69..fca8bbb44375 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -166,6 +166,11 @@ static bool kvm_use_posted_timer_interrupt(struct kvm_vcpu *vcpu)
 	return kvm_can_post_timer_interrupt(vcpu) && vcpu->mode == IN_GUEST_MODE;
 }
 
+static inline u32 kvm_apic_calc_x2apic_ldr(u32 id)
+{
+	return ((id >> 4) << 16) | (1 << (id & 0xf));
+}
+
 static inline bool kvm_apic_map_get_logical_dest(struct kvm_apic_map *map,
 		u32 dest_id, struct kvm_lapic ***cluster, u16 *mask) {
 	switch (map->logical_mode) {
@@ -315,6 +320,18 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		}
 		new->logical_mode = logical_mode;
 
+		/*
+		 * In x2APIC mode, the LDR is read-only and derived directly
+		 * from the x2APIC ID, thus is guaranteed to be addressable.
+		 * KVM reuses kvm_apic_map.phys_map to optimize logical mode
+		 * x2APIC interrupts by reversing the LDR calculation to get
+		 * cluster of APICs, i.e. no additional work is required.
+		 */
+		if (apic_x2apic_mode(apic)) {
+			WARN_ON_ONCE(ldr != kvm_apic_calc_x2apic_ldr(x2apic_id));
+			continue;
+		}
+
 		if (WARN_ON_ONCE(!kvm_apic_map_get_logical_dest(new, ldr,
 								&cluster, &mask))) {
 			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
@@ -381,11 +398,6 @@ static inline void kvm_apic_set_dfr(struct kvm_lapic *apic, u32 val)
 	atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
 }
 
-static inline u32 kvm_apic_calc_x2apic_ldr(u32 id)
-{
-	return ((id >> 4) << 16) | (1 << (id & 0xf));
-}
-
 static inline void kvm_apic_set_x2apic_id(struct kvm_lapic *apic, u32 id)
 {
 	u32 ldr = kvm_apic_calc_x2apic_ldr(id);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

