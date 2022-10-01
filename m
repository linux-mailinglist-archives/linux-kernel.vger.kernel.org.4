Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9885F17E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiJABDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiJABCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:02:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40AFFB22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:19 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 126-20020a630284000000b0043942ef3ac7so3726884pgc.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=9LreyVzYGzmK/M6pRFe0Kt3YpPFGdlmgJSpVgDAtoSQ=;
        b=qLJ0vasa9TjSnqtCrvpmPlD+s2Q34ltzW9TU12k/BYcjipcvZZPk+osTW9p044ij8b
         oDFg2TJJMcpDnJeVRtvk+Pq3JzkiCe1pi2NXrRvkrePVfVmhFw4Hp1ssVVv+V+CiTLkH
         hCF2fV6hGm/UeyUnOaWB9VIr2hh3Mbiux8AsAvlfPStGHZ0c1KPVlCBIbg+0d0ik0DDN
         2qfVTMOGCrMnBN/fbb2EFdTjV+tIey8ME4d48nS1W8c9JWecf5oAA+4qAxT82KWI5aTd
         F495FB2BUhYF4UGqQzmWIa2cRwTbzj9R8nVBje+3wqhVRPNDuOX47Jti6sSDqHUYH+zm
         5r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=9LreyVzYGzmK/M6pRFe0Kt3YpPFGdlmgJSpVgDAtoSQ=;
        b=m0PhZeh51z50ThHxV1GpS0LvZUA00sd/24ic/MCyTw4HxAh+/f+a2oovSZ4DzPr9yv
         WSVIQqLp5rMACaUZAYE2baJaoTNNy5Ug7m9a+ALiQ+QFMJj20An3+MeTQbG5+YhiTj5g
         s3VMRBob3XawAGQxtohBGHtuvtOraJgNOvQSBeadOVKJQVbobeEyNeoXcERbY52t6eyI
         xpXqHAVWRQbzCGX2WcxAcnRnArKDaGl+6yB4XlwCdPHYafnVQwcH/IH0PmlYaTVhTxR8
         f07yKkZR/ERLTXl2BEivPTnBV+RupUGDxHxu7GGdwpqv7vigCM0V59svIDXIzZpMFU6N
         t/YQ==
X-Gm-Message-State: ACrzQf0HNO+KwAzx7wzIqUrQYZvf2ZFrVu1dmscqyezNZAgQLaHWH/tz
        w68b5YkS698YrSpwcTDiRGTfP1NBV7Q=
X-Google-Smtp-Source: AMsMyM5o3cSRXk1Ul41PlT/qbXOMFsS7yS6gj8hxn9OT7I7Qa9raysNtXDxSjeTeNX11GH6rL7NY0Z2KvKU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80e:b0:178:2ecb:16bb with SMTP id
 u14-20020a170902e80e00b001782ecb16bbmr11385068plg.152.1664585999489; Fri, 30
 Sep 2022 17:59:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:07 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-25-seanjc@google.com>
Subject: [PATCH v4 24/32] KVM: x86: Inhibit APICv/AVIC if the optimized
 physical map is disabled
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

Inhibit APICv/AVIC if the optimized physical map is disabled so that KVM
KVM provides consistent APIC behavior if xAPIC IDs are aliased due to
vcpu_id being truncated and the x2APIC hotplug hack isn't enabled.  If
the hotplug hack is disabled, events that are emulated by KVM will follow
architectural behavior (all matching vCPUs receive events, even if the
"match" is due to truncation), whereas APICv and AVIC will deliver events
only to the first matching vCPU, i.e. the vCPU that matches without
truncation.

Note, the "extra" inhibit is needed because  KVM deliberately ignores
mismatches due to truncation when applying the APIC_ID_MODIFIED inhibit
so that large VMs (>255 vCPUs) can run with APICv/AVIC.

Fixes: TDB
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/lapic.c            | 13 ++++++++++++-
 arch/x86/kvm/svm/avic.c         |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ac28bbfbf0e3..171e38b94c89 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1104,6 +1104,12 @@ enum kvm_apicv_inhibit {
 	 */
 	APICV_INHIBIT_REASON_BLOCKIRQ,
 
+	/*
+	 * APICv is disabled because not all vCPUs have a 1:1 mapping between
+	 * APIC ID and vCPU, _and_ KVM is not applying its x2APIC hotplug hack.
+	 */
+	APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED,
+
 	/*
 	 * For simplicity, the APIC acceleration is inhibited
 	 * first time either APIC ID or APIC base are changed by the guest
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 340c2d3e781b..f6f328d36ae2 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -381,6 +381,16 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		cluster[ldr] = apic;
 	}
 out:
+	/*
+	 * The optimized map is effectively KVM's internal version of APICv,
+	 * and all unwanted aliasing that results in disabling the optimized
+	 * map also applies to APICv.
+	 */
+	if (!new)
+		kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED);
+	else
+		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED);
+
 	old = rcu_dereference_protected(kvm->arch.apic_map,
 			lockdep_is_held(&kvm->arch.apic_map_lock));
 	rcu_assign_pointer(kvm->arch.apic_map, new);
@@ -2153,7 +2163,8 @@ static void kvm_lapic_xapic_id_updated(struct kvm_lapic *apic)
 	/*
 	 * Deliberately truncate the vCPU ID when detecting a modified APIC ID
 	 * to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a 32-bit
-	 * value.
+	 * value.  If the wrap/truncation results in unwatned aliasing, APICv
+	 * will be inhibited as part of updating KVM's optimized APIC maps.
 	 */
 	if (kvm_xapic_id(apic) == (u8)apic->vcpu->vcpu_id)
 		return;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index dd0e41d454a7..2908adc79ea6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -965,6 +965,7 @@ bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 			  BIT(APICV_INHIBIT_REASON_PIT_REINJ) |
 			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |
 			  BIT(APICV_INHIBIT_REASON_SEV)      |
+			  BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |
 			  BIT(APICV_INHIBIT_REASON_X2APIC);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 974d9a366d5d..5920166d7260 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7955,6 +7955,7 @@ static bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 			  BIT(APICV_INHIBIT_REASON_ABSENT) |
 			  BIT(APICV_INHIBIT_REASON_HYPERV) |
 			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |
+			  BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED);
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

