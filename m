Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D765F8ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjAFBQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjAFBP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:15:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059AA3E859
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:08 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a18-20020a62bd12000000b0056e7b61ec78so33190pff.17
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+6ioVOt6Y8ZSfzod+z4E7s6OaCseHKr4cxWSag07wVE=;
        b=O03cZ1UPddU8+XWJbySLwg3naywoqGigzTnJjgko5PE9IcKnBBaU5jVcmQtdY0IUfb
         oio/dzcsZGvSts18YYk/Av8B13MvrBhXlFRUuDK0yLNsOJWBi85p0sB/MZ1MD+y/3ZZB
         /s2g21t9mqzfA0erk1tjtpxXtyCn5AGjRZPmTnIOoKwOZTkcYC4omQh9wLxqqahT0jub
         lzVDgF7bYgo/pCVCXp9GjXJ9J89NBZnp/w7Dj957/VEmzMscANc264m0H1Lg6AcFmOBD
         DgXgqOnwy4ySU7l0z1Jeg4vNgbdZvnttpRpx7hadVpe4cGu1VWHrzFSvfBXXU1z2bjnq
         rKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6ioVOt6Y8ZSfzod+z4E7s6OaCseHKr4cxWSag07wVE=;
        b=3bgB+X2n1L/KQWi4cySerZ8YZxHc5m7Q/+neaaDB/w/0p47jAuDxdCtpQRfMiqh0SA
         55Quf05iiyTh1QKbNjkzaysqz7uirLPN+qJe3noZWbYrndfL9kHtsG0zd+jkzYclqxQ1
         KnX313Xn0EgbLOYh4TBHD1Xk/sJVlCGJPCDwhAoYPmJj0KBa0tuxDoq+A9lSOvz2tGLS
         x/QhhAJPgfVB4ggPKON3ARHJxFUMREz2DQeMfpRqQK7joe5KEQ68Qj5mXL6cMF9FwC7c
         hxZ7WKK+iG2ckhn4e0wmM83L8Yf0SiQpvS4YjLU79RHj4KCiuZEtygSvoCmM4yI5NfPi
         u/Tg==
X-Gm-Message-State: AFqh2koHRU2xupnMYjEAndNpfgbb71IrTr3JGb8w9EY7718B8AylB1ys
        /b3nEsLT7hgJHsGsX5JNgEry06M8EYo=
X-Google-Smtp-Source: AMrXdXvU+z8G6WL9sUSr49SDJHZoyA8j92U9Ai5TJks5PAdZnP3VkOSjGEgGIMU0vTB0Vro0DdkHJBRgGU0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ab05:b0:192:4d6a:2add with SMTP id
 ik5-20020a170902ab0500b001924d6a2addmr2740731plb.109.1672967631378; Thu, 05
 Jan 2023 17:13:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:55 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-23-seanjc@google.com>
Subject: [PATCH v5 22/33] KVM: x86: Honor architectural behavior for aliased
 8-bit APIC IDs
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

Apply KVM's hotplug hack if and only if userspace has enabled 32-bit IDs
for x2APIC.  If 32-bit IDs are not enabled, disable the optimized map to
honor x86 architectural behavior if multiple vCPUs shared a physical APIC
ID.  As called out in the changelog that added the hack, all CPUs whose
(possibly truncated) APIC ID matches the target are supposed to receive
the IPI.

  KVM intentionally differs from real hardware, because real hardware
  (Knights Landing) does just "x2apic_id & 0xff" to decide whether to
  accept the interrupt in xAPIC mode and it can deliver one interrupt to
  more than one physical destination, e.g. 0x123 to 0x123 and 0x23.

Applying the hack even when x2APIC is not fully enabled means KVM doesn't
correctly handle scenarios where the guest has aliased xAPIC IDs across
multiple vCPUs, as only the vCPU with the lowest vCPU ID will receive any
interrupts.  It's extremely unlikely any real world guest aliases APIC
IDs, or even modifies APIC IDs, but KVM's behavior is arbitrary, e.g. the
lowest vCPU ID "wins" regardless of which vCPU is "aliasing" and which
vCPU is "normal".

Furthermore, the hack is _not_ guaranteed to work!  The hack works if and
only if the optimized APIC map is successfully allocated.  If the map
allocation fails (unlikely), KVM will fall back to its unoptimized
behavior, which _does_ honor the architectural behavior.

Pivot on 32-bit x2APIC IDs being enabled as that is required to take
advantage of the hotplug hack (see kvm_apic_state_fixup()), i.e. won't
break existing setups unless they are way, way off in the weeds.

And an entry in KVM's errata to document the hack.  Alternatively, KVM
could provide an actual x2APIC quirk and document the hack that way, but
there's unlikely to ever be a use case for disabling the quirk.  Go the
errata route to avoid having to validate a quirk no one cares about.

Fixes: 5bd5db385b3e ("KVM: x86: allow hotplug of VCPU with APIC ID over 0xff")
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/x86/errata.rst | 11 ++++++
 arch/x86/kvm/lapic.c                  | 50 ++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
index 410e0aa63493..49a05f24747b 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -37,3 +37,14 @@ Nested virtualization features
 ------------------------------
 
 TBD
+
+x2APIC
+------
+When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM activates a hack/quirk that
+allows sending events to a single vCPU using its x2APIC ID even if the target
+vCPU has legacy xAPIC enabled, e.g. to bring up hotplugged vCPUs via INIT-SIPI
+on VMs with > 255 vCPUs.  A side effect of the quirk is that, if multiple vCPUs
+have the same physical APIC ID, KVM will deliver events targeting that APIC ID
+only to the vCPU with the lowest vCPU ID.  If KVM_X2APIC_API_USE_32BIT_IDS is
+not enabled, KVM follows x86 architecture when processing interrupts (all vCPUs
+matching the target APIC ID receive the interrupt).
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9c0554bae3b1..e9f258de91bd 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -274,10 +274,10 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		struct kvm_lapic *apic = vcpu->arch.apic;
 		struct kvm_lapic **cluster;
 		enum kvm_apic_logical_mode logical_mode;
+		u32 x2apic_id, physical_id;
 		u16 mask;
 		u32 ldr;
 		u8 xapic_id;
-		u32 x2apic_id;
 
 		if (!kvm_apic_present(vcpu))
 			continue;
@@ -285,16 +285,48 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		xapic_id = kvm_xapic_id(apic);
 		x2apic_id = kvm_x2apic_id(apic);
 
-		/* Hotplug hack: see kvm_apic_match_physical_addr(), ... */
-		if ((apic_x2apic_mode(apic) || x2apic_id > 0xff) &&
-				x2apic_id <= new->max_apic_id)
-			new->phys_map[x2apic_id] = apic;
 		/*
-		 * ... xAPIC ID of VCPUs with APIC ID > 0xff will wrap-around,
-		 * prevent them from masking VCPUs with APIC ID <= 0xff.
+		 * Apply KVM's hotplug hack if userspace has enable 32-bit APIC
+		 * IDs.  Allow sending events to vCPUs by their x2APIC ID even
+		 * if the target vCPU is in legacy xAPIC mode, and silently
+		 * ignore aliased xAPIC IDs (the x2APIC ID is truncated to 8
+		 * bits, causing IDs > 0xff to wrap and collide).
+		 *
+		 * Honor the architectural (and KVM's non-optimized) behavior
+		 * if userspace has not enabled 32-bit x2APIC IDs.  Each APIC
+		 * is supposed to process messages independently.  If multiple
+		 * vCPUs have the same effective APIC ID, e.g. due to the
+		 * x2APIC wrap or because the guest manually modified its xAPIC
+		 * IDs, events targeting that ID are supposed to be recognized
+		 * by all vCPUs with said ID.
 		 */
-		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
-			new->phys_map[xapic_id] = apic;
+		if (kvm->arch.x2apic_format) {
+			/* See also kvm_apic_match_physical_addr(). */
+			if ((apic_x2apic_mode(apic) || x2apic_id > 0xff) &&
+			    x2apic_id <= new->max_apic_id)
+				new->phys_map[x2apic_id] = apic;
+
+			if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
+				new->phys_map[xapic_id] = apic;
+		} else {
+			/*
+			 * Disable the optimized map if the physical APIC ID is
+			 * already mapped, i.e. is aliased to multiple vCPUs.
+			 * The optimized map requires a strict 1:1 mapping
+			 * between IDs and vCPUs.
+			 */
+			if (apic_x2apic_mode(apic))
+				physical_id = x2apic_id;
+			else
+				physical_id = xapic_id;
+
+			if (new->phys_map[physical_id]) {
+				kvfree(new);
+				new = NULL;
+				goto out;
+			}
+			new->phys_map[physical_id] = apic;
+		}
 
 		if (new->logical_mode == KVM_APIC_MODE_MAP_DISABLED ||
 		    !kvm_apic_sw_enabled(apic))
-- 
2.39.0.314.g84b9a713c41-goog

