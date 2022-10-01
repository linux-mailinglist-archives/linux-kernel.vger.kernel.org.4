Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013675F17BF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiJABAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiJAA7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:59:49 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546A1C057A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m10-20020a170902db0a00b001789bd49db9so4247044plx.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=s9F27/phkQq2UQGJLhx33mCxKn5dPEvZBbt0R8d9G7c=;
        b=fVH/qF1VZKyMyRjY/sLnhdTFwZfP8qKuRGbH2a2ebgYrKogmw4x4xwb2fnlWpS/2xl
         F29kBEqJOjzSH1Cji+Y71p7q4YqvE3CLbiKnLlaZAGcKSg/XFSRY0oqRW6rrjfaq2FzC
         Jz5NDxZgvY7tmLQmGMz0BNIV5hrQMwIgA17Rd2u1KX1gZv5Pxn6zz33yLNxeWUpoh5oa
         NsTSenYxDTFxgnVohl0xvD/art9c3z/54Njxpkz+LHl+yA+Kp6UOcIb/pqDH3x3Qt+Zl
         hQYofVJqnLSKmAU38R6dSNHMR5+A/1Ic50E/SG8DJm1yv2DIbRN6poNY2AvCoN5iLWG8
         EfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=s9F27/phkQq2UQGJLhx33mCxKn5dPEvZBbt0R8d9G7c=;
        b=D9NZb5Iv7Cosx0e4rOo23bR1F9CGxWJHOa6N+GjEl7acXlgt3BHHgHSuwKm7+ZXjMN
         by3lNZeuMyowt2nx9+/yoQFnKZsh0E/rpNqIIOpF35AzHyphK0qYaACZZsSQMvx3Alpj
         ig/91qa9LH4jgjISgYe1eIUWVMyN8tXzlhsuYFqWKIhZ7ToPkeyaYb+zdyK6pRZFFO1o
         xpUaCTrziJBfzva3l4WgD/Qfy8vZDs73KCwRcSj1T0ERsE5bu0JA9+ytNzv9zWNM9BU/
         uD3E7OUBXfMpOqnEGxpstSjId0mf6lCQqII1UB0637iSiVv9xt+xVbLh7oDyBCoS/OdX
         nkfA==
X-Gm-Message-State: ACrzQf3hzFMgEq5BsN3eGoc6+mNwzCWTjrfeaOcFh82XpISrz68CGFJa
        UvXAAJNeSMuNPZ4wzfAMU1cvb8WDZvw=
X-Google-Smtp-Source: AMsMyM42mHWCz7/oR4t6O2pNVuSHVJkTVJO3X4u2N6jAKZTmdNTqJpNzaauhhc/vYu1KRHG06ThcQRY7F1k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e742:b0:176:dc6b:eecc with SMTP id
 p2-20020a170902e74200b00176dc6beeccmr11705111plf.104.1664585970588; Fri, 30
 Sep 2022 17:59:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:58:50 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-8-seanjc@google.com>
Subject: [PATCH v4 07/32] KVM: x86: Don't inhibit APICv/AVIC if xAPIC ID
 mismatch is due to 32-bit ID
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Truncate the vcpu_id, a.k.a. x2APIC ID, to an 8-bit value when comparing
it against the xAPIC ID to avoid false positives (sort of) on systems
with >255 CPUs, i.e. with IDs that don't fit into a u8.  The intent of
APIC_ID_MODIFIED is to inhibit APICv/AVIC when the xAPIC is changed from
it's original value,

The mismatch isn't technically a false positive, as architecturally the
xAPIC IDs do end up being aliased in this scenario, and neither APICv
nor AVIC correctly handles IPI virtualization when there is aliasing.
However, KVM already deliberately does not honor the aliasing behavior
that results when an x2APIC ID gets truncated to an xAPIC ID.  I.e. the
resulting APICv/AVIC behavior is aligned with KVM's existing behavior
when KVM's x2APIC hotplug hack is effectively enabled.

If/when KVM provides a way to disable the hotplug hack, APICv/AVIC can
piggyback whatever logic disables the optimized APIC map (which is what
provides the hotplug hack), i.e. so that KVM's optimized map and APIC
virtualization yield the same behavior.

For now, fix the immediate problem of APIC virtualization being disabled
for large VMs, which is a much more pressing issue than ensuring KVM
honors architectural behavior for APIC ID aliasing.

Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 251856ba0750..2503f162eb95 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2078,7 +2078,12 @@ static void kvm_lapic_xapic_id_updated(struct kvm_lapic *apic)
 	if (KVM_BUG_ON(apic_x2apic_mode(apic), kvm))
 		return;
 
-	if (kvm_xapic_id(apic) == apic->vcpu->vcpu_id)
+	/*
+	 * Deliberately truncate the vCPU ID when detecting a modified APIC ID
+	 * to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a 32-bit
+	 * value.
+	 */
+	if (kvm_xapic_id(apic) == (u8)apic->vcpu->vcpu_id)
 		return;
 
 	kvm_set_apicv_inhibit(apic->vcpu->kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

