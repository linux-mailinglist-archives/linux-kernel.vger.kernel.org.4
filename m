Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A69C6B5310
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjCJVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCJVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:43:50 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853372E82E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p10-20020a170902e74a00b0019ec1acba17so3444727plf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=O58/NX1IZ5N1NsjCSGJf7yl9B5xM2yhJshLYbTitfTw=;
        b=ePEeLMGOuIYsC67LI0QfBPXgJubkE/M9f8ZKhDvPBktm//0MigobdfesQdehm+HoIF
         4k7Q3bKwvt4tdL0bpEstVgMdYaxqxFitCqcT8J76JdedPjiP9uHj8At1j2Ep1bt+Qyss
         1Y0V1Yw52nFYMpBt+LAtY15BwdEk4PljV3VOvdGy3uJqoBF69H3D0f9I2ocnJ0d52EVG
         oDg2W/79S92oQL08l/DdZG+9/MjLj6wNEP+wMwKX85bWLniR63oOFp4S7QZBRJR360Xb
         n/tY2XUTdNDY9ZWkrRyfL8CsOVWQHwl6hgT1bhDFQZmWMokic4FqhoXv6e9RbeEtLW4f
         pARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O58/NX1IZ5N1NsjCSGJf7yl9B5xM2yhJshLYbTitfTw=;
        b=OGGHP6ZuA1H7Hnvzo4P0FgN5SBPvYlLAf9PD1JRF6Gy46RH3o7JVPxMNjOgyFl5seM
         2Q+JCUWJW7RRyrseA7+tBW6RIjnzYxN3yTT3RBHeTcX64Vi30KObx0f3zhf76JFooxHf
         Tqc0eFxPG/zVnBx1OTujUiL7Mu4luLIMyS+qzIjJBZIf/iu+CD5w/Z4yd9Gb2MSo5VcY
         QbohRacHf8UZUTNYINSaRPJs6xkVTgdHhNytWZzHrCKoXlAKuQFQaVkK8OpxXfmgpJYg
         eS/BpgnW8yzGrmm90mdoR8oLZKirL3X0o+qADWocPlhVhnG1Bwh8QUNpgQaVV7ipblGV
         ucEQ==
X-Gm-Message-State: AO0yUKUTocTh5NSYqtS6oXn7AawTRPNStoQkFTOnxRwmG2dybHZaSSeA
        juXxZC1vt/79Ndu0B/1rry04RZJ1u9k=
X-Google-Smtp-Source: AK7set+UsTftmgf9O9o46TlUeIXToEguwbX0wxCE/bnmeisL1xf8XXc4KngQQC5HRwVFkk8j0rDsBwBiFlM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:714b:b0:19f:22b3:508d with SMTP id
 u11-20020a170902714b00b0019f22b3508dmr187900plm.11.1678484580595; Fri, 10 Mar
 2023 13:43:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:26 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-13-seanjc@google.com>
Subject: [PATCH v2 12/18] x86/virt: Drop unnecessary check on extended CPUID
 level in cpu_has_svm()
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

Drop the explicit check on the extended CPUID level in cpu_has_svm(), the
kernel's cached CPUID info will leave the entire SVM leaf unset if said
leaf is not supported by hardware.  Prior to using cached information,
the check was needed to avoid false positives due to Intel's rather crazy
CPUID behavior of returning the values of the maximum supported leaf if
the specified leaf is unsupported.

Fixes: 682a8108872f ("x86/kvm/svm: Simplify cpu_has_svm()")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index a27801f2bc71..be50c414efe4 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -39,12 +39,6 @@ static inline int cpu_has_svm(const char **msg)
 		return 0;
 	}
 
-	if (boot_cpu_data.extended_cpuid_level < SVM_CPUID_FUNC) {
-		if (msg)
-			*msg = "can't execute cpuid_8000000a";
-		return 0;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_SVM)) {
 		if (msg)
 			*msg = "svm not available";
-- 
2.40.0.rc1.284.g88254d51c5-goog

