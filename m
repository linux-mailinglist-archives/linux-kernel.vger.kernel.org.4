Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49EF64A743
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiLLSiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiLLShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:37:39 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0621213E21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3ceb4c331faso139915047b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vf/4eKFN2BbTxHb9vSu7n9IRkdIgNgMrNUGeFPcCE4E=;
        b=BLucr3TOr4Bc81H7R2ZUt5urqtyzKGHpHVmCLY3m5X8tCgclyt7rcfkYgPpZKVyhDI
         ccWWN5ADIFdK/w4cH9XNqcJYyQSbbzzcjhP/o+UoDov7EtvOasfnQhOspHFDk19FqsJQ
         rAX+tZe/9NBgVMPYwg+WQhMhadIBmZxsovpzHXT3OpQa9UfgjviRGMeIjtWiifN3P7OP
         6JwROifeI4hBy9qxiZdbku/6HsGFZewkr32tdt6KTThRUrFeXi6nAgV/kIlbi3ZSZn37
         CP47IoogJE3psblBjwdEBahqr7ipUpKAMvE6Ah+b5wEj5gPVqDdAVqRFMyh4uraC5cc6
         gQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vf/4eKFN2BbTxHb9vSu7n9IRkdIgNgMrNUGeFPcCE4E=;
        b=lbhkIIhtqeXlscGmTd5QMUoqifQqOtyKDLBQA/Za31nUK4iq2e0NpCPJ4XX4VVVw1q
         ydY8Ta/wiUi2b2SfJ72+cv1I7BXVkFl5llRqSbn7sSGQHFHSSiXnoSQNxVulD1u4HGJd
         WPLiF54qAoYY4iEnwW6DtqZF6RfT9V+271LSnLgw95xQX78apkYlHY9DPsyiDq1uC03J
         Tl9JVyaiH7BvepUPMr0Fwt6Q+hF23VWK0W/wXjVstU+t9KwplK1owLA2PxIJg+7YuTxn
         5o2qvZAP9iQSFJBWhMYVIOYBUy2altLmIfk4bwtZSzK+rCZnIWqQGPJD7CmWt2YvKTXe
         o0pA==
X-Gm-Message-State: ANoB5plhsI1Q0a578CFOZQtChSWmL3C5xEiJn2sofXLuwlZ7E9oyJYvs
        hi7E0kBb3faxBVMnaLBrdGvkXJmskCGO
X-Google-Smtp-Source: AA0mqf5LJkMrFemYHXdnf93jGHta9bxWD79MNL5HSG+3JVISIbOn4b2wQCsBbDKuTNzb5haaQiD5GGA+PGwm
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6902:91b:b0:6dd:313b:9b30 with SMTP id
 bu27-20020a056902091b00b006dd313b9b30mr95149913ybb.618.1670870257178; Mon, 12
 Dec 2022 10:37:37 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:37:15 -0800
In-Reply-To: <20221212183720.4062037-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221212183720.4062037-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212183720.4062037-9-vipinsh@google.com>
Subject: [Patch v4 08/13] KVM: x86: hyper-v: Use common code for hypercall
 userspace exit
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Remove duplicate code to exit to userspace for hyper-v hypercalls and
use a common place to exit.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

---
 arch/x86/kvm/hyperv.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 283b6d179dbe..2eb68533d188 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2521,14 +2521,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2587,14 +2580,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2603,6 +2589,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
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
2.39.0.rc1.256.g54fd8350bd-goog

