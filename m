Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F416A5BF146
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiITXdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiITXcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:32:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A06178BD7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w1-20020a63d741000000b0042c254a4ccdso2461622pgi.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=vsB2EXY9q1cnnbhcdlWF5rsjKI75izh6EDAPIDxJ6Xw=;
        b=bAJ+timLm9bQ/xjMToD+8hIRKEhT5G4/eow6iqd/oCrUU1Th682zYJLp9CmuweIK+h
         FHkCiCip6gMjjAmhl2K7/108Tk2/avuol43nXGBGrDH2Chjck4ekNFs9GbOcLBpGr+CN
         pxIPOdfDGkQBLyU/QwhsjLPiFmhH4f5M5EHNq4C+yjFn8xRBjIXPfL9XCbGAsTW57WEt
         AmO2zcCd6MtrTPUjfRxCOPtLhmCiFIugUbtHd9bSDMQvj2NzYZDDtNQU/YXynKdm17eb
         iV2aaTyeIA5FUasRIARSCaYhFE2Zbe1Qp4qwdFp6/BuDFKcW762bIk9Pfg8vFfbu7l5k
         WdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=vsB2EXY9q1cnnbhcdlWF5rsjKI75izh6EDAPIDxJ6Xw=;
        b=Cs32pYA5BVmRqAk7RXN3j/AXf2jP9jW1wWRFJc7fjMbKVHDM/G4rV+i75X1yONDNIK
         Frp7u73Uaaket/jDBcNX+jCi5YGcRf9i8MIu/5S5yIIW6Tpj1SfmDiCsnS3FvBSaWaeL
         46itxtxQQOBxd72PnAMkwbkquPg0J7GcHxa4y/w7rkOy/SFob1R1Xh6SMQwMa5qHppPD
         fxQwcn8ePTYSUNXd4Yqpz6kAP2Y7xK0EKhqIda61oIjjbs5ql6PsgAxKQpdJePqbd8lT
         J8rhZagI/p9M/RIRWHLnA48+86TRtoQ0QQM7046jstdeU0SnNKGBDFnToHR1Meppae0u
         xMBQ==
X-Gm-Message-State: ACrzQf3D5hGItSoN8USy9cZMYGsc2VycOgTggH/1cMngRp4uQFHIFU3J
        48Bev1aYpLZZ17mpY3dHQgQ3Ml6buJU=
X-Google-Smtp-Source: AMsMyM6gwxE+9V1iUOnFoB3jGYRREssKhetvh4T5MdU4y0U/leMrubqM0MU6KrMORuQPVeU27W//QbTQbSU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr524276pjz.1.1663716733523; Tue, 20 Sep
 2022 16:32:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:28 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-23-seanjc@google.com>
Subject: [PATCH v3 22/28] KVM: SVM: Inhibit AVIC if vCPUs are aliased in
 logical mode
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

Inhibit SVM's AVIC if multiple vCPUs are aliased to the same logical ID.
Architecturally, all CPUs whose logical ID matches the MDA are supposed
to receive the interrupt; overwriting existing entries in AVIC's
logical=>physical map can result in missed IPIs.

Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ++++++
 arch/x86/kvm/lapic.c            | 5 +++++
 arch/x86/kvm/svm/avic.c         | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 594674eefe59..32c0bca052e3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1152,6 +1152,12 @@ enum kvm_apicv_inhibit {
 	 * APIC base.  For simplicity, this is sticky.
 	 */
 	APICV_INHIBIT_REASON_X2APIC,
+
+	/*
+	 * AVIC is disabled because not all vCPUs with a valid LDR have a 1:1
+	 * mapping between logical ID and vCPU.
+	 */
+	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
 };
 
 struct kvm_arch {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4db162b1f0b1..804d529d9bfb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -391,6 +391,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 	else
 		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED);
 
+	if (!new || new->logical_mode == KVM_APIC_MODE_MAP_DISABLED)
+		kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
+	else
+		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
+
 	old = rcu_dereference_protected(kvm->arch.apic_map,
 			lockdep_is_held(&kvm->arch.apic_map_lock));
 	rcu_assign_pointer(kvm->arch.apic_map, new);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 2908adc79ea6..27d5abc15a91 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -968,7 +968,8 @@ bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 			  BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |
-			  BIT(APICV_INHIBIT_REASON_X2APIC);
+			  BIT(APICV_INHIBIT_REASON_X2APIC) |
+			  BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
 
 	return supported & BIT(reason);
 }
-- 
2.37.3.968.ga6b4b080e4-goog

