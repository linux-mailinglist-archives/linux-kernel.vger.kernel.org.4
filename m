Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E05BF229
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiIUAd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiIUAdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:33:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40880796B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:33:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 66-20020a251145000000b006a7b4a27d04so3690813ybr.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=6n3oC51LepjybeCO/G1gnLj/7i8/kZTfCzCfh49ZsFY=;
        b=W1Ft16I2z4KyotR0zf9JcaxskVjiFIoTSvcCvM9GzqpfMZjOnkUbTlyR/YK2GifRmv
         QrwJq8VMURYEAE2WuDaeBV1lpmfmiUr9qttHXPB25xmfj0zo/Rm8dS6hBczWKfely1To
         iBZYJPxQgEmeTx4V8oSgxXgoc7fmc8jL0B2eJu/Yc6c7NQPqonrY7m5HwsjgveG5t8/q
         DMeMlr+fihRcdrCqNFWVENW4RNE2K4oabECK0hGgUMWhs07ZJGDjNFB5aD/IHo4M7B6i
         xV1aDtVsD/LclbxQq81QXFA9WSGbWt0X054O++Zklv0EWWKP7bGtdKwjb1syoi10fSBt
         trFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=6n3oC51LepjybeCO/G1gnLj/7i8/kZTfCzCfh49ZsFY=;
        b=kiZwg71MIP0hxwh2IpAVyb0GqAjlrV6C1anKjXI2FOPGfChpD8kucwVjPWDMgMTMRs
         JduD1YQQ68Jy+wL2KP4rysdm6+aYylonvWzDBJoxmk6ghxyH85bGybxSPpGpdrewJVxw
         wIqbom2fQNaCacBgBcnXEqfVsgPfDQyL09Y2UdE598X3skqfQ+W7rWpnyH1XkUPzv6qZ
         h54Lypd/12TFAlGs1onDVevRCwqospqyEWM3z5XbllA+43hfCyQygWQoX782h3Tj5YMt
         37AXw5NOYYuhUv7MxQ2YZfrHY4P8ZNYzk6gp5rBtM0k4x28fzJK6h7cUT529mt7JLrUS
         AZqA==
X-Gm-Message-State: ACrzQf1fr1F1rflHA4RUcH4euvuS2tbNXbRX4R1g5mGC5CB67W9MAoUs
        jtLa5KHYoXLRdFB9AKhyWCOpJEyVwcM=
X-Google-Smtp-Source: AMsMyM6ajbNthck8O3WF1o+1c/8Kt+/LZ69NQ6nvF17LZv5xSYaJvw/YRsOuqwhN87Jz4vl4Gma5UjnRyp0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c04f:0:b0:6ae:96ac:ac2d with SMTP id
 c76-20020a25c04f000000b006ae96acac2dmr21142783ybf.227.1663720384571; Tue, 20
 Sep 2022 17:33:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Sep 2022 00:31:59 +0000
In-Reply-To: <20220921003201.1441511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220921003201.1441511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921003201.1441511-11-seanjc@google.com>
Subject: [PATCH v4 10/12] KVM: x86: never write to memory from kvm_vcpu_check_block()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

kvm_vcpu_check_block() is called while not in TASK_RUNNING, and therefore
it cannot sleep.  Writing to guest memory is therefore forbidden, but it
can happen on AMD processors if kvm_check_nested_events() causes a vmexit.

Fortunately, all events that are caught by kvm_check_nested_events() are
also recognized by kvm_vcpu_has_events() through vendor callbacks such as
kvm_x86_interrupt_allowed() or kvm_x86_ops.nested_ops->has_events(), so
remove the call and postpone the actual processing to vcpu_block().

Opportunistically honor the return of kvm_check_nested_events().  KVM
punted on the check in kvm_vcpu_running() because the only error path is
if vmx_complete_nested_posted_interrupt() fails, in which case KVM exits
to userspace with "internal error" i.e. the VM is likely dead anyways so
it wasn't worth overloading the return of kvm_vcpu_running().

Add the check mostly so that KVM is consistent with itself; the return of
the call via kvm_apic_accept_events()=>kvm_check_nested_events() that
immediately follows  _is_ checked.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: check and handle return of kvm_check_nested_events()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dcc675d4e44b..8aeacbc2bff9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10815,6 +10815,17 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 			return 1;
 	}
 
+	/*
+	 * Evaluate nested events before exiting the halted state.  This allows
+	 * the halt state to be recorded properly in the VMCS12's activity
+	 * state field (AMD does not have a similar field and a VM-Exit always
+	 * causes a spurious wakeup from HLT).
+	 */
+	if (is_guest_mode(vcpu)) {
+		if (kvm_check_nested_events(vcpu) < 0)
+			return 0;
+	}
+
 	if (kvm_apic_accept_events(vcpu) < 0)
 		return 0;
 	switch(vcpu->arch.mp_state) {
@@ -10837,9 +10848,6 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
-	if (is_guest_mode(vcpu))
-		kvm_check_nested_events(vcpu);
-
 	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
 		!vcpu->arch.apf.halted);
 }
-- 
2.37.3.968.ga6b4b080e4-goog

