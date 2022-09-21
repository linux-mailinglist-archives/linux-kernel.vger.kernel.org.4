Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4735BF226
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiIUAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiIUAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:33:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965537962A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:32:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d1-20020a17090a2a4100b00202ec7968c0so2050818pjg.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=efA5iJVbRrRgyy7qejkmxwve22ULxnh+arH50++PU/o=;
        b=LKQ43lhsEV6qkmBZlofrSrdl8EJ6mizwyIEMQYN4yuGNXkQj4E20I0hn2n1os/W8rc
         FBABKu95Qjg91h2stXYOQw+qADMR7XZ6aWiaoE4AtE31UgVml4CNZ7U+iemEDcQM7Qu4
         t9Z+X0wLCYzA/PywBX4R2TbwY4IqErPsq7pWjccSbHgqlIcJodfmwDsORX1S0hnpHOqL
         beWZAka2S0YLzR5F93gSfrPtpqFy0vHNPuMIF2SvlDmkv6DmDFSXlrSQYeY1mlT0WWNb
         xuXG79A1mSLbxXjRXjfR/KkQ6hWyNCiYg0/oAhyTPT5fIKU53548mJXGWrhfghBolN1K
         JXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=efA5iJVbRrRgyy7qejkmxwve22ULxnh+arH50++PU/o=;
        b=zJ1QlWacDLKEMnJQmk7B4cRPreXsRTfh+mTgsN8oLgfitUw0RoMgSziDg9EvsBwXFR
         EpaDKWE9ZSu6BCplA4OsKWNQh4lX6Z9GuqeSsj77a05e9O4HUuHfGidtFPBp7nj8ZEKY
         ZgWY5DEwJy1FriczFAFEtTKCl9/26lmPMa5b4MR7t4h+SX/JCBqV6zvgj4fzkEyBLPMx
         fEJvRh3ojdGubLcFyu7DZVaFgHmHNvUyc62Az2OJ5mz8RuI9dKgJi4ncqxpALvDqEsgN
         IbX7GpTxMzA08K448GToBtVXdr2/ymxoacqQpPiE6xoDFq6Dxq4Ivg7x2uxCDeKi3swy
         H43Q==
X-Gm-Message-State: ACrzQf026RZwxP6ErmRCpX2HNrsAYs73uxoKDqs8loQu8PVcxmQYQmdU
        RKqxf9APg+3DnUyx5ooczBO+FeKCoDQ=
X-Google-Smtp-Source: AMsMyM4y6HKockrgOW/pRtDhYoSBz/Hgk7Jbboq2yxWPlcCYVwqDxT8mse4oLg7p1D+UQZFuX9F/d/ndT2k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:be03:b0:178:6f5d:e979 with SMTP id
 r3-20020a170902be0300b001786f5de979mr2126922pls.163.1663720376093; Tue, 20
 Sep 2022 17:32:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Sep 2022 00:31:54 +0000
In-Reply-To: <20220921003201.1441511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220921003201.1441511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921003201.1441511-6-seanjc@google.com>
Subject: [PATCH v4 05/12] KVM: x86: lapic does not have to process INIT if it
 is blocked
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Do not return true from kvm_vcpu_has_events() if the vCPU isn' going to
immediately process a pending INIT/SIPI.  INIT/SIPI shouldn't be treated
as wake events if they are blocked.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: rebase onto refactored INIT/SIPI helpers, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 16a24dd28f26..dcc675d4e44b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12765,7 +12765,8 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (!list_empty_careful(&vcpu->async_pf.done))
 		return true;
 
-	if (kvm_apic_has_pending_init_or_sipi(vcpu))
+	if (kvm_apic_has_pending_init_or_sipi(vcpu) &&
+	    kvm_apic_init_sipi_allowed(vcpu))
 		return true;
 
 	if (vcpu->arch.pv.pv_unhalted)
-- 
2.37.3.968.ga6b4b080e4-goog

