Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2941A712EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjEZVDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbjEZVDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:03:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CCFBB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:03:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c9e9e164so2555941276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685135027; x=1687727027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=94Gih39C/5Jv2sKi/kH1B+XJjmK37tFsbYqDzgh8LSo=;
        b=73RcvMGtNzkiHiAzrUk4D4BsUuUTIDzJR6V5U8XGMy27vYtPxtmlqH4IyiW0B8dF4O
         rA0ZaFT96DO5Xvb3oyGl8FUEw4jXnROB6ckPmAuDivzp5AUQk8VNSwa3ugxH4AGJQvMA
         xBP4sjdzixlOUqbAJE97AIk3m3mPDjp8DxuLalkyp4kNxG5QovsujN3ov45zLGAFnzA5
         UeQu0iKn8bUYXNEdui1uwvMrpUsW5UBj4WxK7z07T8JbGH+MAWtkybrhXng4TQ+0SZl/
         5pLaVTGEBAHh3yjhomAGa6IIPlq1frwJZjRV/ITJGyTiEKVtGCvwVHvWbvMhT8fJgMXA
         N6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135027; x=1687727027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94Gih39C/5Jv2sKi/kH1B+XJjmK37tFsbYqDzgh8LSo=;
        b=XhPp0DoMh8lhOivOTkj5f9bpCTo39vGnlxYcLgTiUeXtD3Ri6ucAt80YdqWFTVlzPX
         YzDFwhkj5tF5j+Vh3CCly3sQI6O+R4SIRblSn0HuclO1hHZRxy0It+IYtOQ1mJuGOcOj
         4dgedZ5sPDwp7KiqPD0pf2vy+MgPHNSjVvosiCmtv4i1XMZXJ1gBjYp96+3jC9j6zmQT
         eq5MSQzub49Y/C0zjTrM2pa2WBt94noW5lWZvBXos2e9/1OAZxRaaOqSIe8E6AI9SB76
         j3c2j4S5tb/v0p1XVwD3s7TIF/ax/z9dLFV5F2GDF2ow7QBnD6ZBTS790xEqXBVS1a2H
         8GSQ==
X-Gm-Message-State: AC+VfDyHTTXuLMy4FEuarUUJ4RjaHxCTSZxys+dLVwdoqgM0VjStigDm
        Lm3DEFRwZDg6HBqnYig/oo5gIjnr9mU=
X-Google-Smtp-Source: ACHHUZ7wz4/ZvBCdD3rlIOVUwAoTohMGbg3GIGXPcyRJsQsUEZ3BXzfeU21emCpgJ6/HAWSYg6v0LHO+KvU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d648:0:b0:bab:9391:470d with SMTP id
 n69-20020a25d648000000b00bab9391470dmr1179468ybg.0.1685135027218; Fri, 26 May
 2023 14:03:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 26 May 2023 14:03:40 -0700
In-Reply-To: <20230526210340.2799158-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230526210340.2799158-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526210340.2799158-3-seanjc@google.com>
Subject: [PATCH v3 2/2] KVM: selftests: Extend cpuid_test to verify
 KVM_GET_CPUID2 "nent" updates
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

Verify that KVM reports the actual number of CPUID entries on success, but
doesn't touch the userspace struct on failure (which for better or worse,
is KVM's ABI).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/x86_64/cpuid_test.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index 2fc3ad9c887e..d3c3aa93f090 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -163,6 +163,25 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu)
 	ent->eax = eax;
 }
 
+static void test_get_cpuid2(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid = allocate_kvm_cpuid2(vcpu->cpuid->nent + 1);
+	int i, r;
+
+	vcpu_ioctl(vcpu, KVM_GET_CPUID2, cpuid);
+	TEST_ASSERT(cpuid->nent == vcpu->cpuid->nent,
+		    "KVM didn't update nent on success, wanted %u, got %u\n",
+		    vcpu->cpuid->nent, cpuid->nent);
+
+	for (i = 0; i < vcpu->cpuid->nent; i++) {
+		cpuid->nent = i;
+		r = __vcpu_ioctl(vcpu, KVM_GET_CPUID2, cpuid);
+		TEST_ASSERT(r && errno == E2BIG, KVM_IOCTL_ERROR(KVM_GET_CPUID2, r));
+		TEST_ASSERT(cpuid->nent == i, "KVM modified nent on failure");
+	}
+	free(cpuid);
+}
+
 int main(void)
 {
 	struct kvm_vcpu *vcpu;
@@ -183,5 +202,7 @@ int main(void)
 
 	set_cpuid_after_run(vcpu);
 
+	test_get_cpuid2(vcpu);
+
 	kvm_vm_free(vm);
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

