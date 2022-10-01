Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644825F17BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiJAA70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJAA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:59:21 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0171AF90C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso4210515plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=pUJ8lsVIJf7TL6+xh2Qa1ktW0pNw9qF5SOtFc21ozc0=;
        b=EHxckeTL1GlAOvFEilkBQbLD6ds1ejPwB5HYa+q6bReCiccdbj6zC8h52WYChW07Hc
         eGpLZDyOes7qwgMhNdFpH7VkR4xSgnABSGvCIny9yMdtFaZG/iVLcyFn+isxJG+jB4cz
         rZc/c4GcKXGwR6P55J1vDqQbCW/9jMTJDFcbf6xYG2VqSR+/izOd++dhsFayfe1lP+mQ
         7MJOineUi9jmPQi8uqti3cCCu+S7uPZaUY4QQmYnxrc2k1rmPLZMD/vT1UyTE5OnTRRl
         Ph7MtLjXP+DhkurHFZTmGBqcH3BJA5SHK8kCBVpT/RKB+LZ5EQhEyZEG10ybziWuFyBi
         OFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=pUJ8lsVIJf7TL6+xh2Qa1ktW0pNw9qF5SOtFc21ozc0=;
        b=rYjFAyQ9d06sQ5LS7GbDek0/l3CT/Q+QKohYShzSa1B+D93LPY5YQKLxajNkNDxvMH
         DbP8d7J8OMs0PxKRc283VbPKUU5/bThLsEcYcc3H5L8bJgqIIZTsDFVW1Cwrk6O+RTjv
         jnWXboXm1h6dX3Ecv6DBfyvC3X6Ef0mPWwmT/tiIareSZ3Pl4bOmINkivSaBQz7OQU8u
         N6nZR8QjXcvJad2iA8YmNNO70932HbOBQl6ds8lrxpPbSP4kwpYWvG3v2+U33mAlZoJc
         MGNGWkyJlfWoTPA5RDP20C+JliYOFgPHuiueuSrdL3aIZa1H6pT4+3ucfRFtwT0P172l
         OLgA==
X-Gm-Message-State: ACrzQf36LaV9fNlELOGapd15qilIPJj1W7OCyJFZ3rP2y2Zy9DsiyZQk
        eFDZn3Oj/IiIrerY0eOX33nu3sZlJtM=
X-Google-Smtp-Source: AMsMyM427lSvL7dveKM7cWZJs9QN8HrabJ4Fbs51cuKCu4aVR61KKeLheiN/vjBxNQvc9SbyPcj+j9hU6sc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr517093pjt.1.1664585959605; Fri, 30 Sep
 2022 17:59:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:58:44 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-2-seanjc@google.com>
Subject: [PATCH v4 01/32] KVM: x86: Blindly get current x2APIC reg value on
 "nodecode write" traps
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

When emulating a x2APIC write in response to an APICv/AVIC trap, get the
the written value from the vAPIC page without checking that reads are
allowed for the target register.  AVIC can generate trap-like VM-Exits on
writes to EOI, and so KVM needs to get the written value from the backing
page without running afoul of EOI's write-only behavior.

Alternatively, EOI could be special cased to always write '0', e.g. so
that the sanity check could be preserved, but x2APIC on AMD is actually
supposed to disallow non-zero writes (not emulated by KVM), and the
sanity check was a byproduct of how the KVM code was written, i.e. wasn't
added to guard against anything in particular.

Fixes: 70c8327c11c6 ("KVM: x86: Bug the VM if an accelerated x2APIC trap occurs on a "bad" reg")
Fixes: 1bd9dfec9fd4 ("KVM: x86: Do not block APIC write for non ICR registers")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d7639d126e6c..05d079fc2c66 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2284,23 +2284,18 @@ void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	u64 val;
 
-	if (apic_x2apic_mode(apic)) {
-		if (KVM_BUG_ON(kvm_lapic_msr_read(apic, offset, &val), vcpu->kvm))
-			return;
-	} else {
-		val = kvm_lapic_get_reg(apic, offset);
-	}
-
 	/*
 	 * ICR is a single 64-bit register when x2APIC is enabled.  For legacy
 	 * xAPIC, ICR writes need to go down the common (slightly slower) path
 	 * to get the upper half from ICR2.
 	 */
 	if (apic_x2apic_mode(apic) && offset == APIC_ICR) {
+		val = kvm_lapic_get_reg64(apic, APIC_ICR);
 		kvm_apic_send_ipi(apic, (u32)val, (u32)(val >> 32));
 		trace_kvm_apic_write(APIC_ICR, val);
 	} else {
 		/* TODO: optimize to just emulate side effect w/o one more write */
+		val = kvm_lapic_get_reg(apic, offset);
 		kvm_lapic_reg_write(apic, offset, (u32)val);
 	}
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

