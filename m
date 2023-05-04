Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7296F71D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjEDSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEDSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:18:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C61FD9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:18:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so1831269276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683224311; x=1685816311;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjvvowe8zEt4UQcm8nbwrIVRsEeLiH5hkw0jaKF/Pdo=;
        b=foecG0AHRxDcRcf2EK4zMC4X1DGntPmpGdgtDOgYwhprnBk9aaucm+tbsuckeYwTP1
         FUH9UxtcSd1Ur0Dz7N/OKOjqfMVn31F1ztoFdaHyxedZQOxLYkBISJRasVrxCJfhV4hm
         SBP0qDwxwSrqtiriTVe5zvLYVtkyj5C+8QzxHt6QYzK6Tv58F9+uUZLjY5H8QQn9DTZk
         iCbB1cVZxfwF0l8Q+pHBkBmayGIvP+rfkWolkp10nxmQZnXAtNefl848AMlapMSsm0LO
         kKY4dgqhJj2Kc+4UZ7/2snJOssg60adsk/0daCNNGOmJNnS+t3cBq0Fp20x+qYFQvdFK
         a+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224311; x=1685816311;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjvvowe8zEt4UQcm8nbwrIVRsEeLiH5hkw0jaKF/Pdo=;
        b=G/LR7swxExPmK1xZs9zCiy7QjCyPRIBwFKA3WgXixs+4us+JnUJqmVw6UB5QjhgXOx
         8OXJckqmTVCCdBs1HNK96tidQVPOdZuuJsLQyBMaxe2Rd0Q0RVWiszk+PYi8TKstsqrp
         PtjNhq3thGGiTlkDZYN4z/3VGvEQLsILIpd8Jrt58w9U/8aJCG4/i+xeh1yJ7UQj3TCN
         0vVlRo4nuPLiQEzl9rGgnXEwWx3PNp08Ypq2z76TZEIxRWI/QRUTyCDkH99h0LpvBVkG
         UxIJQqOYwqaMV/vjFhFLcV7QmJAcxJHtwlV+wLdVIsptNrqRa6ehb68VCKKQSgCEY2iY
         /qmQ==
X-Gm-Message-State: AC+VfDzgIYbtmvhA5cP9c+TTSBtrLqjO3tJZPzFyCGosJod9HHqJw/3P
        cgzpp5UwwBNJgaGmohoJawkVXw7QIJ/o
X-Google-Smtp-Source: ACHHUZ5DAwFzBVvUPRW810cVnhluBjmxM976KK6Kbe9fVigxbi50e8yjdOd6AUMGg6g2dcxpAA6Faj6miKiA
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a5b:947:0:b0:b8f:6a10:7654 with SMTP id
 x7-20020a5b0947000000b00b8f6a107654mr370701ybq.5.1683224310867; Thu, 04 May
 2023 11:18:30 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Thu,  4 May 2023 18:18:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230504181827.130532-1-mizhang@google.com>
Subject: [PATCH v2] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspace to
save/restore the register value during migration. Missing this may cause
userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to port the
value to the target VM.

In addition, there is no need to add MSR_IA32_TSX_CTRL when
ARCH_CAP_TSX_CTRL_MSR is not supported in guest. So add the checking in
kvm_probe_msr_to_save().

Fixes: b07a5c53d42a ("KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable TSX on guest that lack it")
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/x86.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 237c483b1230..c8accbd6c861 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1431,7 +1431,7 @@ static const u32 msrs_to_save_base[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL,
+	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
 	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
 	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
 	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
@@ -7077,6 +7077,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
 			return;
 		break;
+	case MSR_IA32_TSX_CTRL:
+		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
+			return;
+		break;
 	default:
 		break;
 	}
-- 
2.40.1.521.gf1e218fcd8-goog

