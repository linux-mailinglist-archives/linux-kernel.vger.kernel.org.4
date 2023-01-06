Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CB65F8EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjAFBQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjAFBP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:15:59 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A73E863
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:10 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r126-20020a632b84000000b004393806c06eso216745pgr.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=o4UAETXkM62nM2yYuGHBJ1AdJGjwtbarF4DTw13SG8M=;
        b=j2HNEccBP7np7M1sGlh/lR9iiwoxeu2tDdMfTtFmom/1SMGw9AQClRjRPjxLcQnERb
         P92ChTGaFkoInGodIaAPnUdfY53bosFhp2WBXli5H0PS/7/07MxxqJE4tVPSrQgL9zZ4
         iy1PiDEc0mmhxGDEB4e9NZbEj87Xzb/ZJTKCAfEMolx9oL+EUzsxesFZVBys6msUS/dV
         BlERFFcesl/Aa0+XdXyltbE2MS4q6xScax+5zeprGT9eHK5nBMbpS06o+TwXC7g9SbZh
         y2NdVD5PQ5H5gTO6T23k2qqLzFuLP2O4eK7GOViM+89twqSlz/6vLB7iSc/KWmjVNb6L
         ngZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4UAETXkM62nM2yYuGHBJ1AdJGjwtbarF4DTw13SG8M=;
        b=JSDbWrD9ACsmneEMnSvpKY+4E20r6+d6E4pO/k4nPU9msbFGlbKJcW8j0RRf9r+BZZ
         yUnya16QLTgCsCwRQ75Hi+kewz7KAbU/tWo9UWW1/hgvdQncKk6M1Tl+jnfvYYBjVPh4
         v+MGhDHf2/4BlVoVQcAxDOjRyuAF8AXTa6vsuV04ZvhDapfTNuMevRd9mGwzXDiu0FOm
         Xae5sVfNUS/7vVlLUytYLskgyRzMk0GwuoqESQailk/oP8rAT4/Kv5vZUudNbOP4pJPp
         1a87JiN3qknpgQyVmYqdGmP5VCXFIKJRYlvDDI8q+WTKL34yz/hgDPBFbodIrxBE7yXM
         qcDA==
X-Gm-Message-State: AFqh2krladJi4DOtGA+m+s56lEWTikJHvgl979FgryCoAoh/I4sePL0z
        V1JrafXLtYsh7DQWNxg4ST6F6U8lfLs=
X-Google-Smtp-Source: AMrXdXuxaeNgG3qV2/dc3S4AdIlGeqilvlmQHbJQGHhMswaBgY/s1jn0nF3f3Xk4hQBpGykQGzmLpuaPAjQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2e05:b0:225:b536:1209 with SMTP id
 q5-20020a17090a2e0500b00225b5361209mr4108245pjd.101.1672967634940; Thu, 05
 Jan 2023 17:13:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:57 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-25-seanjc@google.com>
Subject: [PATCH v5 24/33] KVM: SVM: Inhibit AVIC if vCPUs are aliased in
 logical mode
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ++++++
 arch/x86/kvm/lapic.c            | 5 +++++
 arch/x86/kvm/svm/avic.c         | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5865bad08a23..b41a01b3a4af 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1218,6 +1218,12 @@ enum kvm_apicv_inhibit {
 	 * AVIC is disabled because SEV doesn't support it.
 	 */
 	APICV_INHIBIT_REASON_SEV,
+
+	/*
+	 * AVIC is disabled because not all vCPUs with a valid LDR have a 1:1
+	 * mapping between logical ID and vCPU.
+	 */
+	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
 };
 
 struct kvm_arch {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 297da684c25f..0faf80cdc1be 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -396,6 +396,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
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
index d1ac19f053ce..1fd473a57159 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -967,7 +967,8 @@ bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 			  BIT(APICV_INHIBIT_REASON_SEV)      |
 			  BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
-			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED);
+			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |
+			  BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
 
 	return supported & BIT(reason);
 }
-- 
2.39.0.314.g84b9a713c41-goog

