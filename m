Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7DF5FE3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJMVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJMVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:13:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF4191D7A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so2573887ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dWPjjwmCXdw1FoLWbTCqb8PkUleSoznDfVrorISf0Bs=;
        b=Wl3SxD4RgiI8mdPWO8AkxLNNNuFvmx2TVKUslqBgYcFOtlxKo0PibzHbprgwD8PCQH
         oq2O2wmIg5XJC70e4y7GFFVrlusSXIq4WR8SveMxveZzg0/6WISqHpZ7OzBkjr01nnp7
         C6uTtRPcGcj5EF+MFcNS3KIOsZAX3AR665gsokStcFaoOmibFpyvlUqT4tzvPCCyECxs
         lpfUQE8m3YQVfaZP6hMuCSAug86mpg81Q/U0VR/UF1XvD1AAX+FStgqMrwKT8N4FNF6y
         lcR5IGwRUJE7UaFfSWZucL1k1lLGHEBhkfck+fYHsFX0SS+sCTzjwGEKQ62XJ1/7pdsi
         UJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWPjjwmCXdw1FoLWbTCqb8PkUleSoznDfVrorISf0Bs=;
        b=vFNojcWjMkE0q1CRiZMkmZA8bgIVvOyppbwYOb5N2A2jejWTdRSw91Lt0Y3M1lfUjU
         MUf+aClhJ0L7xHexF4cNVfcWZiH3hSuqgrluHNqotQlKg7GsPxyyuUpD3A8Bn2PTCFSy
         BH2hdiLCFfYKYSKuHFsmkJdlNJVThJNIRYZTVCPyhmz06UF3WaqqdY+r6nHnkOBINK/C
         1IVlSaWcK3iyhGZlsKfoQaeAYkhzawdHHTJKF2LCpgF1mM3mf7I5bHJuZypTTkSY/l12
         tFQ+v+tcr6v/3wGKOe8xn8yWdMGmmYTVYuzCDpllHXrBDlbyNa4/2QVv3lb+c4SViEzf
         1tug==
X-Gm-Message-State: ACrzQf26NvmPWEt0TtoOc1g7fPV044b924n+dX5Ye6gEgd6/wOK1yEwP
        JRdKzYIz731MjIBxUY1WOPZkVuEf4KU=
X-Google-Smtp-Source: AMsMyM5MqNN6X4L0yO41k0hy74o8gIZHqHekpNg9zfTkf+yB9vmeBeh0sLHX4cs8h+d/YE+9RnqmgaeNThY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bc4b:0:b0:6bc:a469:468c with SMTP id
 d11-20020a25bc4b000000b006bca469468cmr1922360ybk.199.1665695564234; Thu, 13
 Oct 2022 14:12:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 13 Oct 2022 21:12:21 +0000
In-Reply-To: <20221013211234.1318131-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221013211234.1318131-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013211234.1318131-4-seanjc@google.com>
Subject: [PATCH v2 03/16] KVM: x86: Always use non-compat vcpu_runstate_info
 size for gfn=>pfn cache
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
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

Always use the size of Xen's non-compat vcpu_runstate_info struct when
checking that the GPA+size doesn't cross a page boundary.  Conceptually,
using the current mode is more correct, but KVM isn't consistent with
itself as kvm_xen_vcpu_set_attr() unconditionally uses the "full" size
when activating the cache.  More importantly, prior to the introduction
of the gfn_to_pfn_cache, KVM _always_ used the full size, i.e. allowing
the guest (userspace?) to use a poorly aligned GPA in 32-bit mode but not
64-bit mode is more of a bug than a feature, and fixing the bug doesn't
break KVM's historical ABI.

Always using the non-compat size will allow for future gfn_to_pfn_cache
clenups as this is (was) the only case where KVM uses a different size at
check()+refresh() than at activate().  E.g. the length/size of the cache
can be made immutable and dropped from check()+refresh(), which yields a
cleaner set of APIs and avoids potential bugs that could occur if check()
where invoked with a different size than refresh().

Fixes: a795cd43c5b5 ("KVM: x86/xen: Use gfn_to_pfn_cache for runstate area")
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b2be60c6efa4..9e79ef2cca99 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -212,10 +212,7 @@ void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, int state)
 	if (!vx->runstate_cache.active)
 		return;
 
-	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode)
-		user_len = sizeof(struct vcpu_runstate_info);
-	else
-		user_len = sizeof(struct compat_vcpu_runstate_info);
+	user_len = sizeof(struct vcpu_runstate_info);
 
 	read_lock_irqsave(&gpc->lock, flags);
 	while (!kvm_gfn_to_pfn_cache_check(v->kvm, gpc, gpc->gpa,
-- 
2.38.0.413.g74048e4d9e-goog

