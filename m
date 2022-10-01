Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB65F17D3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiJABB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiJABAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:00:54 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078417A74C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f4-20020a636a04000000b0043a18cf1a5aso3683757pgc.14
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=h+90iLbssT+2X1a302WPpFnb6f2TypfnLO84iY5RrGQ=;
        b=mfZNCXiGnI7p1ypGzL1ptYh32xDJBoAspoF6otY5o4Ynm+Uk57mzPT+wcqcPxQeXVf
         40To52bA44S5E2jpfqRz4OdbG9X+FL/OX2VRxFNrzeasSphJ9sf+FwTu2/mPCymNoKAr
         b1Y1lAaSD1OPqdpUQHync3ncJVBJYpohU1xQP0a/Z38It3zAafP47FvOpPMvYZ+/X5ir
         9O91TMuIq3K5mM2KpTzsDXDiXpsHpDH9kOwUbmPrzSPowY75geq4kuaP82LRqbWmZWl1
         oBFbWzEFLfOZv+VZ27KG7SjJQYhNDsfjOw4Xy8M6VhGjYw5uOC3JKJc6rLz61SnZ/M8U
         keZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=h+90iLbssT+2X1a302WPpFnb6f2TypfnLO84iY5RrGQ=;
        b=6HrXYCtJ2k9ZBhtXRshiYkytpnOiIcAaoUWz2h1eC3CuEX1mCVaSW7zzNA8cJnA9kt
         ZVNSf7FJX4yGFsFchYAIem7zjz+2yT/FpkKubtoDQUL2cT2I3+btOHx82aJy3JyAV/Sy
         T34AqaSVUYYmnc35dEe/qqSd6pOo3XPNLbH1cSs6kpxb3OlyqszSQaQ7eIRpHwlsrNhh
         3q0HqGMl5sv3aHTSPvFbyFL7EXbWqDjAcAuvr3N3LHGk3vVseV6f9IJht7/GHDhzCILI
         29gJSUQtEkb+4flqgrWnyfqpA8m+iwqQHJHa2GrWo6N9NzqX4cG7jSmMbQ982NxSlPr/
         PDJw==
X-Gm-Message-State: ACrzQf1MsRa6SbrcESpIlmsBxnVjuzJ8dgENd1Ngso/X9QXUKwnshDWf
        vihgdjy8DNXctz/VQQonDygkmlyRyr4=
X-Google-Smtp-Source: AMsMyM5UxvnMw/tmRE+RDi5H/pVH119fO6xKYnbBT71PyTQHZUb50MZJ6s5H9c1lBVwPg8WoW15XancnCxQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1705:b0:55a:b9c4:6e14 with SMTP id
 h5-20020a056a00170500b0055ab9c46e14mr11665821pfc.40.1664585985944; Fri, 30
 Sep 2022 17:59:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:58:59 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-17-seanjc@google.com>
Subject: [PATCH v4 16/32] KVM: SVM: Document that vCPU ID == APIC ID in AVIC
 kick fastpatch
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

Document that AVIC is inhibited if any vCPU's APIC ID diverges from its
vCPU ID, i.e. that there's no need to check for a destination match in
the AVIC kick fast path.

Opportunistically tweak comments to remove "guest bug", as that suggests
KVM is punting on error handling, which is not the case.  Targeting a
non-existent vCPU or no vCPUs _may_ be a guest software bug, but whether
or not it's a guest bug is irrelevant.  Such behavior is architecturally
legal and thus needs to faithfully emulated by KVM (and it is).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 605c36569ddf..40a1ea21074d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -368,8 +368,8 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 			cluster = (dest >> 4) << 2;
 		}
 
+		/* Nothing to do if there are no destinations in the cluster. */
 		if (unlikely(!bitmap))
-			/* guest bug: nobody to send the logical interrupt to */
 			return 0;
 
 		if (!is_power_of_2(bitmap))
@@ -397,7 +397,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 			if (WARN_ON_ONCE(index != logid_index))
 				return -EINVAL;
 
-			/* guest bug: non existing/reserved logical destination */
+			/* Nothing to do if the logical destination is invalid. */
 			if (unlikely(!(logid_entry & AVIC_LOGICAL_ID_ENTRY_VALID_MASK)))
 				return 0;
 
@@ -406,9 +406,13 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 		}
 	}
 
+	/*
+	 * KVM inhibits AVIC if any vCPU ID diverges from the vCPUs APIC ID,
+	 * i.e. APIC ID == vCPU ID.  Once again, nothing to do if the target
+	 * vCPU doesn't exist.
+	 */
 	target_vcpu = kvm_get_vcpu_by_id(kvm, l1_physical_id);
 	if (unlikely(!target_vcpu))
-		/* guest bug: non existing vCPU is a target of this IPI*/
 		return 0;
 
 	target_vcpu->arch.apic->irr_pending = true;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

