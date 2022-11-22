Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27216330C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiKUXkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKUXkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:40:32 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E350B703B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p5-20020a170902e74500b001884ba979f8so10360216plf.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DjKtLBmHY6xPnTRB5DGDH5ojMJ0nrj5B/ttXckGAR4=;
        b=A2iqCnDP0HJsAWFSUNpLaJfQ9OUNUJ+mkh9mJPNM5a6n+SBJJjGeOquSwMtAWG3ZLg
         B77KJltzqiBkJskv7OW+R1BiGQ+lJ7F+K9bImXUqfr7BggSIUVc2dkbyH9LkF6vlYL8x
         dPynbRutmgLuRAEkRkwuu+wo69CiAGssVA41xWd1Z+9Un4vaaBrqkpg1jKofv7pEJglj
         xES2bJpM3m1FKDzmhC61XZWRPGaD1IP0RtbSmu5lBxJh2wcRLjMdTlesMKnkgd9KkxUC
         VtKWWcE4LD4DZqdYZ4HsY2f2SxZ9ZKTilPmG52zxaylbcB2lXU2XFHRlS6HQ6HoxWxYR
         lgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DjKtLBmHY6xPnTRB5DGDH5ojMJ0nrj5B/ttXckGAR4=;
        b=SUYDTyO5raYcE8oN82eIiv80Y/DmP0SB+ymKYDUzKQLvRmEO05Z5D6PnxjzDiPOTrO
         S6UmqHdoA1M1tG5RKPgbHRMaPME534skpooCd+otXlikXMihSQl/rkEXHhZILTYxkWFj
         hl67eveioPxIOQGr80J0McqQtN+KQxHUbfZHL0V0NyzPdO+cYoiCpLzDW45IRmkyVlLw
         RAly0/W4rmIW6ZwrvnNGAiCxvnIUcewdA37gV6iwdT2eZGlOUWTpI8qZG1S5vIQnExlP
         SM56MmVRNF/+HuMVvnYcX4lafUD79xdjJ6NwwsXNIl5R1boiL2rd904+NLXG1fKxgxyI
         U51g==
X-Gm-Message-State: ANoB5pldxH9iXH5gAlWdJ1TvaS9RiQ3wSATEXWka9M2L9WtO9ikYQjuQ
        AxzjqhqnCwxHVDORAQ4QfyBaGxBJdvC7
X-Google-Smtp-Source: AA0mqf6u92G9wm2XcDLGCu1gxU+otIgNIkiwSVUw8zDxgajD08NomkE1N+OxA6Zt6JOZxiAICr/ecNH1mhn1
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a63:696:0:b0:476:7bc4:5b6d with SMTP id
 144-20020a630696000000b004767bc45b6dmr19636628pgg.220.1669074031147; Mon, 21
 Nov 2022 15:40:31 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:40:21 -0800
In-Reply-To: <20221121234026.3037083-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221121234026.3037083-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121234026.3037083-2-vipinsh@google.com>
Subject: [PATCH v2 1/6] KVM: x86: hyper-v: Use common code for hypercall
 userspace exit
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Remove duplicate code to exit to userspace for hyper-v hypercalls and
use a common place to exit.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 2c7f2a26421e..0b6964ed2e66 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2503,14 +2503,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
-		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
-		vcpu->run->hyperv.u.hcall.input = hc.param;
-		vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
-		vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
-		vcpu->arch.complete_userspace_io =
-				kvm_hv_hypercall_complete_userspace;
-		return 0;
+		goto hypercall_userspace_exit;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
 		if (unlikely(hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
@@ -2569,14 +2562,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_OPERATION_DENIED;
 			break;
 		}
-		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
-		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
-		vcpu->run->hyperv.u.hcall.input = hc.param;
-		vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
-		vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
-		vcpu->arch.complete_userspace_io =
-				kvm_hv_hypercall_complete_userspace;
-		return 0;
+		goto hypercall_userspace_exit;
 	}
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
@@ -2585,6 +2571,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
 hypercall_complete:
 	return kvm_hv_hypercall_complete(vcpu, ret);
+
+hypercall_userspace_exit:
+	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
+	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
+	vcpu->run->hyperv.u.hcall.input = hc.param;
+	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
+	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
+	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
+	return 0;
 }
 
 void kvm_hv_init_vm(struct kvm *kvm)
-- 
2.38.1.584.g0f3c55d4c2-goog

