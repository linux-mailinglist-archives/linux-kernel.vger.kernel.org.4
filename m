Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A675F16AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiI3Xbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiI3Xbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:31:38 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB915349C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:31:37 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso4108261plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=R0RgZ91roMSEBPJsrvjvkDfFam5SN/lgMQRJiTuvmqc=;
        b=OuDkBTC/7/+wwp2oA6nxhc4qsGi9j4lxh48P9BTwteM1QHrh7U4pxZDP+3KMRH3jUl
         mjhclAQ6XSJ2qFHly66CmaJLnpiAI7wlkU9rYa1am2YMkGHiqK4BH9ZFSq48K+utrA2B
         K2KceinGHtClDe2GunKXJyoYY1dmN8fgrpVRLgnLMu8ACJkcnYgZfAhBh6T6zJu81vrN
         CpyGExB6M9QBwk/KAxy/F/ohhgXa67cT4YW7ArZXhMiJXyjUvxA7ebCVuwzEH4vewrEI
         nEEUW0ls+ygPHQUjV6V06eqDeBzB9ejojf6Hr3JagIFUtspGghQ9UbIs8eHoG4rTU+y3
         XGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R0RgZ91roMSEBPJsrvjvkDfFam5SN/lgMQRJiTuvmqc=;
        b=g3912VhsNbbIYaCsJqUzs726e99fhyoCGCL1kPLyzEcvcHfwpkQgmm0PTVUKhl1bSg
         TnseZEbncZZ7NdeHGbEiVcUGT5mGQDbgel9F+RRwpK4HVS1Iq09VVDIc5EV2Mc/MR2Cf
         /yzguXWyCBig9dgrF5mY9IH3ZEcRWzxYripn2bay++rlgl+cObYCvb6O2XS6ApSDNuKT
         YYL3jU+o526blqB2cYiDJd7jNqv6vtdTQko0e5LYdtbFg06CeOTi7VF87sB+xQQQGYBq
         WLu/eaDuu3U/r+BhgfmanmLtJAOL8G8l+E1bI7PSoCn0S5uD9U/AP/bsgnoKIYAPy1hL
         lK1w==
X-Gm-Message-State: ACrzQf0WLGUobPPv7TgLZIo7ZITAcp9HBZfxOhugj2vu4Bp/hrLrsEGQ
        LP0jCCJmJ5tz0MG+IJsYqzyHgKEI+ZY=
X-Google-Smtp-Source: AMsMyM723OxHhFpusATWVmoaapfvZt1if9qgEY43yn60482Rm7Q/zG9hQv1CmWYT9CI7gNWznyfx2vRR7Z4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr498120pjt.1.1664580696502; Fri, 30 Sep
 2022 16:31:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 30 Sep 2022 23:31:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930233132.1723330-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Resume guest immediately when injecting #GP on ECREATE
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
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

Resume the guest immediately when injecting a #GP on ECREATE due to an
invalid enclave size, i.e. don't attempt ECREATE in the host.  The #GP is
a terminal fault, e.g. skipping the instruction if ECREATE is successful
would result in KVM injecting #GP on the instruction following ECREATE.

Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
Cc: stable@vger.kernel.org
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Effectively compile tested only, found by inspection when auditing use of
kvm_skip_emulated_instruction().

 arch/x86/kvm/vmx/sgx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 8f95c7c01433..b12da2a6dec9 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -182,8 +182,10 @@ static int __handle_encls_ecreate(struct kvm_vcpu *vcpu,
 	/* Enforce CPUID restriction on max enclave size. */
 	max_size_log2 = (attributes & SGX_ATTR_MODE64BIT) ? sgx_12_0->edx >> 8 :
 							    sgx_12_0->edx;
-	if (size >= BIT_ULL(max_size_log2))
+	if (size >= BIT_ULL(max_size_log2)) {
 		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
 
 	/*
 	 * sgx_virt_ecreate() returns:

base-commit: c59fb127583869350256656b7ed848c398bef879
-- 
2.38.0.rc1.362.ged0d419d3c-goog

