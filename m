Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4806D61721A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKBXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiKBXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:20:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B186431
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:19:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e13-20020a17090301cd00b001871e6f8714so216891plh.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=s9AuxTlRjBrfjYkcaQi28he/RkCYbCa6yMT59uzOKa0=;
        b=ddAfxHTlEUHw0qawyyn7Bns3LOyks9re4MtMC6FAIFAvlDf6eK/nu/+/9Fi10x1R6n
         WWJsCNbWaFv5FoXY2JkfL2gPHfmH7n5Ig/c/8vgYFwan9v+I5VkTcY5cAcyMIsF0YYgl
         ayeymXyuzlb1ZK6RywTZFK6M2TrYNtbmp52NtBkrAW3CizVOcP2GK1YSKNk0hRzbGX/H
         t6V+7QqjJlqd98Pv08NBqx2q5El2vxmRcwGZXuIwYC0OoPXag/D+TlMulKYngdYVLuGi
         IcUk8i0bIt121WR3Ua8dNN2eN53mKcAGIC6t4monNq6evoAdLql3aLFHNiEvl7F6ATwg
         1KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9AuxTlRjBrfjYkcaQi28he/RkCYbCa6yMT59uzOKa0=;
        b=aQY9PITYwTyAstSESuRzncPG1QTQsxC+2oWcYZZkYX4Jlj2+3lV5MqMA6S7Fzs0fF5
         KN511d9f4hvkhQ41Smv7qFGE0p+2di+oKykiMN7l3U+heR9DFlsv6O3Junvp6zdsvHro
         3la4kA+STI/xKDNLOhluJh2lCuIR+seOOvO3hDWOSfNfpb3hM1txuWliQkbpRWvctB63
         CJVgp0Eymm46C6R/wl0+H1Yr+gKwLcKpIvKMesVz9sZSqKKl4pXE1Zs8VQL/bKjMvwQT
         WbCmmG30IIoFfAlpkF+RlZ1ZnVYNEFtmN5qcZcXgHt4DWGnVHUv3jBRW2wNrqlxqLenq
         OCYQ==
X-Gm-Message-State: ACrzQf34O0CAasg6NFbgvkS7fmQuKhWED7gIpMAhOIdKSX2AXO+0rFLF
        lWPTxs1XH7zWtFb5FhBXub0SlB228Lg=
X-Google-Smtp-Source: AMsMyM4Aj3fLciSdgeuMbOdggWgonn7AFJaBAotEN5fF2aTBDAVACdmSaSGC1ByL/Xgyuk/Z8cG2B3zdT14=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:240a:b0:183:6555:7a89 with SMTP id
 e10-20020a170903240a00b0018365557a89mr27116619plo.68.1667431189462; Wed, 02
 Nov 2022 16:19:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:48 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-22-seanjc@google.com>
Subject: [PATCH 21/44] KVM: MIPS: Register die notifier prior to kvm_init()
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
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
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

Call kvm_init() only after _all_ setup is complete, as kvm_init() exposes
/dev/kvm to userspace and thus allows userspace to create VMs (and call
other ioctls).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/kvm/mips.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 75681281e2df..ae7a24342fdf 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1640,16 +1640,17 @@ static int __init kvm_mips_init(void)
 	if (ret)
 		return ret;
 
-	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-
-	if (ret)
-		return ret;
 
 	if (boot_cpu_type() == CPU_LOONGSON64)
 		kvm_priority_to_irq = kvm_loongson3_priority_to_irq;
 
 	register_die_notifier(&kvm_mips_csr_die_notifier);
 
+	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (ret) {
+		unregister_die_notifier(&kvm_mips_csr_die_notifier);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.38.1.431.g37b22c650d-goog

