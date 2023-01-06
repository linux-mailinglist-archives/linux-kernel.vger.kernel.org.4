Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C491965F8D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjAFBOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbjAFBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:41 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFA72D1A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:40 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso209927pgs.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+aYaKFD5zMoXFl3Mrpqz5yT+Tj9hEBdwhn1YhcxYDeU=;
        b=sVrsJnqLgRkQyST7umHC5BB4qxL1l41vI7qq4E+/x2fYGDtl5AblzcCHBALLb9sRU2
         ri/9ceRv5yQOzb3I+MmQ3K1QAJGXYtF1Y4wKvQgdg92ouBF5eFn7dTG1dhyfPIaqfNya
         TtWAEjejrgGg4APj5FxYfagDJ/CSY7RVZ3U4SuZnL+FCbmpn1Z0CShem1/ETEBsadwyt
         q2k7WmsXJhirwxtI6qS8NTr7kOKbg63MA7fFnTq0fgXqguYnYjo331l4d5XiadWpW5Ye
         8DaMyvexx2ci4k40Bay6fKvVXBqel9Gu10bgBFLXHp4mCFYpcUuvkphUhvN6nqw7lctd
         sOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aYaKFD5zMoXFl3Mrpqz5yT+Tj9hEBdwhn1YhcxYDeU=;
        b=Nqke4zypgPJpU7Ewvju31NALpKMJVkN2s6PqI76X7LBROo5ZBf1booc3ZDM8PAkVMx
         VTndwR2ZuqKjRVeefuWk9zYdvKaYM7b8XKZUJZHf1J4I2CTcIFgZ9+Glr3kUCZXasj9g
         gZOOJnUauvIouCegJFmwajXtK1CJXH41qXfjijYmOuci9eRzEvDORZIFVewI80AwoILE
         yLaEK+gj/ORcOx1iy9xpjfK7tiRLjVqO0d1nON0TeJPQkdP8SlbKR2UEWoK6y4CryM6m
         L+s8HBCLgdOh1c3OZx1KIvPsvxLGTdTWv5eM0zJqc9m2CzmRbGyLfj7q+uaMjY68tkyj
         H68A==
X-Gm-Message-State: AFqh2krVkufRW0+BJ/VHjm+cUKrzV0lcPkejp3Vyw2uTA0pVmaNLN6zW
        c1Paeh3ZOYIgeDjyFLPiIqG5R3D+gUI=
X-Google-Smtp-Source: AMrXdXsFgmf3vW4OGvIOFJZ6YjwA2U3Z4H//RGBlZizTl/eqLOIH4Tvb+Bga8Mjioz5BnlSq2KifbpKrqKg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1c4d:0:b0:581:1898:93ae with SMTP id
 c74-20020a621c4d000000b00581189893aemr2945460pfc.51.1672967619557; Thu, 05
 Jan 2023 17:13:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:48 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-16-seanjc@google.com>
Subject: [PATCH v5 15/33] KVM: SVM: Document that vCPU ID == APIC ID in AVIC
 kick fastpatch
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
index e4b5f8b14882..eb2ad5b54877 100644
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
2.39.0.314.g84b9a713c41-goog

