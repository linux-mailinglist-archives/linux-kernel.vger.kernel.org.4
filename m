Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF51712EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbjEZVDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbjEZVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:03:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA2189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:03:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2563aacedccso493025a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685135025; x=1687727025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hTzx+6AXt6K1nszy+Fq4+7PqDznMb4tNoA3e1kmsjc4=;
        b=d6VBKb45i+nhnCfXA61AU9D4t4hC9NNWQ3oHjZy8kPJ8JbUc+p0PI3kEO/JJf4hxha
         CZp1j4ogdlVssTQXCqM6vFPLjoZaBDAvtmZL/IHXPlKjFVSUP/8calK2Rn3ZgQIPfLGr
         dvEYi267LxAayQftT9J4qsYNfZc9tmqbmFijCoJOuyYrUqn3d7R8364ynMB2lLDWl15A
         3HApw/46yk2n7KEfdo4yjiPuQzTTRxfs6bQzMwDfcUcKD6MKtS7QqAFue/YfhAKtLa5W
         a2n4EbiHMOkUTMljD58mKPTGTbxVBlyZEIm0RXhO7Jh0s0wysOrHtj4/1nyMBWEvWxbu
         hXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135025; x=1687727025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTzx+6AXt6K1nszy+Fq4+7PqDznMb4tNoA3e1kmsjc4=;
        b=DpHu8dhl40elbPq6Nk+pE6/5umb3/vHEhcYHUoLQaxzUjZKYy6R2dyR/4suxK2g03A
         n25ixwLU91y+bbyN+jFvI3jChSU7RH6XxdBqPzj7BYpaCREQgcOHnHXNNlzIFwpK1efl
         tx9YrPUcu51NcAiKHXazeeL/jeI4C1QJqQyia33e7padQnmn+7TbvGOwYA7cvZrH/KJ5
         jk7nJhg4XJogo45xEsN0rv3Yf/zRonBCSScihq8e3cMHtX5ZnKie80V6jjPaXj5q65nC
         wYCdh0n3PbQG9M6aKZdW5UMMWHqRCzPcZoSxIr1WyC/5awXxND0b2xVVw4eHgXuG0Lds
         g3JQ==
X-Gm-Message-State: AC+VfDyzX/3x/Z7+5jofQ8F3fLg90XG9g74T42UE9+DIIQPBhH4WjhTk
        V38lFnT1PAQqjVIWjg8cKK0GpaIUc8c=
X-Google-Smtp-Source: ACHHUZ5lP+//MKLoyHxp7ZBBRTK8HPGitRtGZK1VQLXtpErXRJOzC4NPtxPD1FAXGvKn7FX7vuQdBUUv2CQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8c83:b0:253:9751:325f with SMTP id
 b3-20020a17090a8c8300b002539751325fmr780071pjo.4.1685135025225; Fri, 26 May
 2023 14:03:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 26 May 2023 14:03:39 -0700
In-Reply-To: <20230526210340.2799158-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230526210340.2799158-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526210340.2799158-2-seanjc@google.com>
Subject: [PATCH v3 1/2] KVM: x86: Update number of entries for KVM_GET_CPUID2
 on success, not failure
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takahiro Itazuri <itazur@amazon.com>
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

Update cpuid->nent if and only if kvm_vcpu_ioctl_get_cpuid2() succeeds.
The sole caller copies @cpuid to userspace only on success, i.e. the
existing code effectively does nothing.

Arguably, KVM should report the number of entries when returning -E2BIG so
that userspace doesn't have to guess the size, but all other similar KVM
ioctls() don't report the size either, i.e. userspace is conditioned to
guess.

Suggested-by: Takahiro Itazuri <itazur@amazon.com>
Link: https://lore.kernel.org/all/20230410141820.57328-1-itazur@amazon.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0c9660a07b23..241f554f1764 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -501,20 +501,15 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 			      struct kvm_cpuid2 *cpuid,
 			      struct kvm_cpuid_entry2 __user *entries)
 {
-	int r;
-
-	r = -E2BIG;
 	if (cpuid->nent < vcpu->arch.cpuid_nent)
-		goto out;
-	r = -EFAULT;
+		return -E2BIG;
+
 	if (copy_to_user(entries, vcpu->arch.cpuid_entries,
 			 vcpu->arch.cpuid_nent * sizeof(struct kvm_cpuid_entry2)))
-		goto out;
-	return 0;
+		return -EFAULT;
 
-out:
 	cpuid->nent = vcpu->arch.cpuid_nent;
-	return r;
+	return 0;
 }
 
 /* Mask kvm_cpu_caps for @leaf with the raw CPUID capabilities of this CPU. */
-- 
2.41.0.rc0.172.g3f132b7071-goog

