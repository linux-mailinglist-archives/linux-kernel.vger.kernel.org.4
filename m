Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1465F8E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAFBP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjAFBPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:15:16 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93DB32245
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:52 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h14-20020a17090adb8e00b002264c50f36aso44900pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6hlceM30Jbe/aO6Zo5aK3/yVy9oHh4ItTVnXmjKPlGU=;
        b=DcPb1qUmg7YoNAiRnrOTms0+X2InGNfOnaIJCUywCz0TjNATymUn0rZht9kPh1bYoy
         x/0b6nsj0j5zWG9+87qJ8O3dw7Ng+4VU7nw79ltSWrfsa4ykz+gZvepfAWFi6/Gq+x+j
         2vaMZW4QDtV7w9AWz3y8QOBUISI41CXh8om3PjOBKC5y4b3nhif0kTHzsczzIQs/BEU1
         QIlkfaEbAYJ7y+h9iONXkUhYExHOruVjj+fgVVfDZYJ00AUV16JtavxUTNBzsjKoEe1S
         yzDEWgFMLeddHqAK3R7IwL8VHrb6wVwlyo5f2wkZyuxPJaPEB5unpB/ic0NyE+doq2/p
         qD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hlceM30Jbe/aO6Zo5aK3/yVy9oHh4ItTVnXmjKPlGU=;
        b=nfm2aHdSC03BwysUkexb4xBQs8g9F+cCX3pN/PdNTxHxECOUa4Rhnx9HUrdzO9dI/g
         w9N47t1wvSB0vi3hbj49ow1ikk3On4l+3G3JSpikW7piJg60g7kv0XTeJEfgO0axqc9Z
         +jgjceHxW1y8oQLX0Dm1dmOow9XGTbJp0PgFwiJkjs5vf6arBbOg6VG0SzJzweFkHFDo
         0TB85pm3+BTLIHuiuy/cUi7ZmoipZ4XuWPNAVUEmXbBe2loG5elJfKeEPwbL0gKTc+3P
         sTSIr9UDUs6XMJKaYsWYtmwTHZTfcj0QjGWk7btRLzNsj4GCgMyesqfsBms7IqdiUV66
         EhHQ==
X-Gm-Message-State: AFqh2kr1l4k8WvClJDXjbMNLDznLOequxl1nISev0KGWkCD0szHNvEvy
        PN0arW0dTnCNMWzWQeMHf/PM+5Q1EBg=
X-Google-Smtp-Source: AMrXdXvsBWPz/jQPJ0hhAaHa3gbYN1tslfVwRMDp2UU6Zzuh1ejjfNG7L4wTL72BU0eN3nK5TYbkycUGLQw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1584:0:b0:581:1083:2cc5 with SMTP id
 126-20020a621584000000b0058110832cc5mr2680623pfv.14.1672967626186; Thu, 05
 Jan 2023 17:13:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:52 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-20-seanjc@google.com>
Subject: [PATCH v5 19/33] KVM: x86: Skip redundant x2APIC logical mode
 optimized cluster setup
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 2567998b692c..fd7726ff95c6 100644
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
@@ -320,6 +325,18 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 			continue;
 		}
 
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
@@ -386,11 +403,6 @@ static inline void kvm_apic_set_dfr(struct kvm_lapic *apic, u32 val)
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
2.39.0.314.g84b9a713c41-goog

