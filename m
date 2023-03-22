Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA56C3F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCVBQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCVBPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:15:52 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91B58B55
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:15:27 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d2-20020a170902cec200b001a1e8390831so1369057plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679447722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gDWDUJZKEiSdc2jrx8xTfg9KaQTEhFf0r1pqILfpYfw=;
        b=c3vy0tRLOjOsR5JxOTTiqFC4RogaQM7GDamcMvByk11LgnruHpbE0CrS3dqs/uWiNy
         IfAErbnBxDoXUzsSwlirlmq6tg8Gv02goL5hgS5cbCjhSegRXhoeuOPaxT0K5E/hcjXZ
         uHly/hPshpkQc2OGsHdsgvAutoX51UwxGGrw7hek4T9CCI5chUpRR7pp80palsbOhg6j
         CKrExnLgK6rx+rT79i2HMg/l4K5dfZNWoGSokqGj4OGW7/unsdycIDuy1B5fMpI0sqAd
         4BYnElvb6yco11+yccg+6cQyxXLc/sKnc9yrX67bmbEmzHw9Lkvy2JffZ8itDeYSorRY
         L6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDWDUJZKEiSdc2jrx8xTfg9KaQTEhFf0r1pqILfpYfw=;
        b=ud+0/BRCaqE/YOKk2OGFW/sA8rPidS0tw5xDVJDcePn26Es7P5bElYv6D4khqY3Hpz
         3pK33hqhwPuq+77VZ0Hlq2eftszIRoFIONc6lOC513Kk5wxWsQQ/ItrbsAxwnPGIZU0v
         DT6bFdLcNyvSTkiJhDakh98BOdDEJXyVNxg+1mGyQiKBt2kzQX7KOP+j9jfCfYZARfsL
         ab0y8SFRx8NQfrBqsE0sDGRBZOHHObQeJwy/SFC9REwalyPDhyO9g7O8WuXLriRQHCxl
         0xrpcn3PGhImcqzF9ePJUByUhsEPvrjH4VvPu66JvxpphlyCM7ws7PrzZjULZyb2qRpa
         YcRQ==
X-Gm-Message-State: AAQBX9eP8u2nKmipJVcMwhDxIbE9p/JAHxjGhH1NW3J9LFMOfyyr7vJl
        /Z8EDZGELNJtM/OujVN/CQmNHHUkIuA=
X-Google-Smtp-Source: AKy350bhYH/mN3be0Nvdh6JmMN6RjBoXTacZBAfDFH/cZZn0+D6DHLnYaz0gfwAWEf8bsunQUCVF4fokyig=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d88d:b0:1a1:def4:a030 with SMTP id
 b13-20020a170902d88d00b001a1def4a030mr248093plz.0.1679447722736; Tue, 21 Mar
 2023 18:15:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 18:14:38 -0700
In-Reply-To: <20230322011440.2195485-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230322011440.2195485-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: x86: Move MSR_IA32_PRED_CMD WRMSR emulation to
 common code
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dedup the handling of MSR_IA32_PRED_CMD across VMX and SVM by moving the
logic to kvm_set_msr_common().  Now that the MSR interception toggling is
handled as part of setting guest CPUID, the VMX and SVM paths are
identical.

Opportunistically massage the code to make it a wee bit denser.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 14 --------------
 arch/x86/kvm/vmx/vmx.c | 14 --------------
 arch/x86/kvm/x86.c     | 11 +++++++++++
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f757b436ffae..85bb535fc321 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2942,20 +2942,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 */
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
 		break;
-	case MSR_IA32_PRED_CMD:
-		if (!msr->host_initiated &&
-		    !guest_has_pred_cmd_msr(vcpu))
-			return 1;
-
-		if (data & ~PRED_CMD_IBPB)
-			return 1;
-		if (!boot_cpu_has(X86_FEATURE_IBPB))
-			return 1;
-		if (!data)
-			break;
-
-		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
-		break;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_VIRT_SSBD))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c01c76c0d45..29807be219b9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2285,20 +2285,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data & ~(TSX_CTRL_RTM_DISABLE | TSX_CTRL_CPUID_CLEAR))
 			return 1;
 		goto find_uret_msr;
-	case MSR_IA32_PRED_CMD:
-		if (!msr_info->host_initiated &&
-		    !guest_has_pred_cmd_msr(vcpu))
-			return 1;
-
-		if (data & ~PRED_CMD_IBPB)
-			return 1;
-		if (!boot_cpu_has(X86_FEATURE_IBPB))
-			return 1;
-		if (!data)
-			break;
-
-		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
-		break;
 	case MSR_IA32_CR_PAT:
 		if (!kvm_pat_valid(data))
 			return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 237c483b1230..c83ec88da043 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3617,6 +3617,17 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.perf_capabilities = data;
 		kvm_pmu_refresh(vcpu);
 		return 0;
+	case MSR_IA32_PRED_CMD:
+		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
+			return 1;
+
+		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
+			return 1;
+		if (!data)
+			break;
+
+		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
-- 
2.40.0.rc2.332.ga46443480c-goog

