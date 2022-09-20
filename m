Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4D5BF11C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiITXby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiITXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:31:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9B4D81C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:31:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u12-20020a25094c000000b006a9ad6b2cebso3574231ybm.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=cKrarRLCPOriYh8K3EwdraluERzXEnSSkHf6Vm0rWT0=;
        b=QfPIhY6YATNGT6/Gkfj99ZOAN9crVibvS7p2KCIWrzeB74iujsBXQ+92wZOnJqYt9r
         nxDCic0zqRIREdw3csjzh2I4EKmQeHiInBi3QDfiJocTas1o65dmFFxNsA7d8C570+Qp
         w26NLkf2Y/TXjtJHoMLAcWUv40jHJ+vyqrhhjSrdvZHYIiiyk0Nfcbs+O54RrYc+fu1r
         vixNhoPYUD2HqxVjC3WRJYH9vbf4EdFv56PIo5ofZxAXCVVK8+dKDQ1fHjRyp0YGAiny
         FfHfm5dgBUYLFUx6WNiGrXq/Ttaj+t+jPuFdNZH5LBPWxaCPXsKfaa9uZZHfA+7/txOF
         Gu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=cKrarRLCPOriYh8K3EwdraluERzXEnSSkHf6Vm0rWT0=;
        b=DgABn1A4tfeL5Y+HuXThvG1uHwGKp8mHN+looa1ISoNbNEHpOYYpA9RbenDkpbKlV3
         yCBEqgwCaD4oyKM/emjZkwiCqf7SV5SUVYtUF3Tx5RP86EzUSIqvPjm1AtqtwW+bOpJB
         C0d2draF7qL+4fojY+kg4WxcDqlToKXQGl8W+3+ZyvcHdb0QraIHCLW8PFOtcHfuTw3g
         75UEOz3cHGTPOCUw3lJwcpgbafBc1ZkHuQp0w0zZx4YFRmxjsgT9e3x4rT2kZkYtq24X
         6FGhpie9kBHrxxKfgcUwSoUkI5XmV/8Fng3w6tY5q6F3koXZuk9XsPO+okoVM04v5/Pz
         G2/A==
X-Gm-Message-State: ACrzQf28NDYLCv3TmXf3oybdFPuYY7WaOsWKH4H6kmg+NrRCtEyNucmI
        y0lrus710fMS3X7YMPGLN5Tt4QyMuIc=
X-Google-Smtp-Source: AMsMyM4lF7eT4ProyP6MEtPOd0+qAlV4syB88TVqe+KsYwqoK9iRPWWcNAsbmWhIveqZNqTx9BfsIZn6HVY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:de47:0:b0:349:c266:e6ac with SMTP id
 h68-20020a0dde47000000b00349c266e6acmr22048115ywe.233.1663716701829; Tue, 20
 Sep 2022 16:31:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:09 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-4-seanjc@google.com>
Subject: [PATCH v3 03/28] KVM: SVM: Flush the "current" TLB when activating AVIC
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

Flush the TLB when activating AVIC as the CPU can insert into the TLB
while AVIC is "locally" disabled.  KVM doesn't treat "APIC hardware
disabled" as VM-wide AVIC inhibition, and so when a vCPU has its APIC
hardware disabled, AVIC is not guaranteed to be inhibited.  As a result,
KVM may create a valid NPT mapping for the APIC base, which the CPU can
cache as a non-AVIC translation.

Note, Intel handles this in vmx_set_virtual_apic_mode().

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6919dee69f18..712330b80891 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -86,6 +86,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		/* Disabling MSR intercept for x2APIC registers */
 		svm_set_x2apic_msr_interception(svm, false);
 	} else {
+		/*
+		 * Flush the TLB, the guest may have inserted a non-APIC
+		 * mapping into the TLB while AVIC was disabled.
+		 */
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
+
 		/* For xAVIC and hybrid-xAVIC modes */
 		vmcb->control.avic_physical_id |= AVIC_MAX_PHYSICAL_ID;
 		/* Enabling MSR intercept for x2APIC registers */
-- 
2.37.3.968.ga6b4b080e4-goog

