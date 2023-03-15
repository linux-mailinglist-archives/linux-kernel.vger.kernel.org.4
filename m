Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE16BBD00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjCOTLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjCOTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:11:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28C574FF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:11:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o3-20020a634e43000000b0050726979a86so4727347pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678907492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MPGBQpB/QOW3rOyiIDpJ1ssFrkSwrzaQZYPEXWdODjE=;
        b=DmIV0/goxFG7244B78LovLy06QrlSgu8/f40cOxIKKIBWcFXMdLj2/R/SlxpjVI4Xs
         FyUfyY6rHLpQIRLKr5KEahhvus39lwLLwwb1AQLRk8kAWyYQvyWEI54fGCL0uZ0DnT5p
         1ohtmXtfIfH+AiU7mEHey888ZlDpXgbLWl0bfugYDjapKaQ2Rvv7ZdqM/hiYsJTp137H
         xD1vW+VMReaaLTBGQXU2bY9+JSK17d/EKiYyKK9udwboPopfApz3zvvdmC4KSdaOyM0T
         47Dg2Eri745skE5XoFMII7S7y7R5XBt80sAHmZFd5xoRoRq/FwdnQcqQESDxIsSUmSut
         3MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPGBQpB/QOW3rOyiIDpJ1ssFrkSwrzaQZYPEXWdODjE=;
        b=NK+kbb6tSFwp5Fmes0/P2T2bxljb+Pt0R/TGQ1DryxC5tvuPrgHWKXSep6Ua4rmDRb
         aHYSW2/XE3njTAvDJK0RKNMsX9SsD8pWVat2PAJHRXLMZ+oLeEDc9/RZikS5sTl5pEjY
         eJadOY6ZHQaJQ6JjgZ1fs4vmbqREWIQGQkNBEhh50aW1vEGgrFfwoyttb3XbuC30bpty
         XlAhHmRnmfrDD0a9rXqQ4d69gU6jxeXwSzuA8WEZXVD+34JfiJM37zDtdHP9CPzgcMkA
         jrsU+d3J88ovP7bS/lUryQx/9mcmW2YjREy7L4hgq5SbbjlqjCPu35gcZLZdd34WbJYa
         1IlA==
X-Gm-Message-State: AO0yUKXxxctqkgWnaY5F/sHEyNxn7eBaUtdLgK74MKqMX+ONqr7uVOzD
        l0aIoB4VtKIRlhtzPCgp0EAUu3xQZ58=
X-Google-Smtp-Source: AK7set920HmFpb4MlEzZ8bRlGcqLIXXvrzrExQHAfTr81kPsDnjFnKwpGVaRsLPcCVKmLXRheMOgnHuI+sY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:452:b0:19e:f660:81ee with SMTP id
 iw18-20020a170903045200b0019ef66081eemr303110plb.2.1678907492254; Wed, 15 Mar
 2023 12:11:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 15 Mar 2023 12:11:27 -0700
In-Reply-To: <20230315191128.1407655-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230315191128.1407655-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315191128.1407655-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: VMX: Drop unprotected-by-braces variable declaration
 in case-statement
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
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

Remove the intermediate "guest_flush_l1d" boolean to fix a build error on
clang due to the variable being declared inside a case-statement without
curly braces to create a proper code block.

Fixes: c7ed946b95cb ("kvm: vmx: Add IA32_FLUSH_CMD guest support")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303151912.oZ6SGd90-lkp@intel.com
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c63f6c786eb1..d7bf14abdba1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2325,10 +2325,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 					   X86_FEATURE_IBPB);
 		break;
 	case MSR_IA32_FLUSH_CMD:
-		bool guest_flush_l1d = guest_cpuid_has(vcpu,
-						       X86_FEATURE_FLUSH_L1D);
 		ret = vmx_set_msr_ia32_cmd(vcpu, msr_info,
-					   guest_flush_l1d,
+					   guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D),
 					   L1D_FLUSH,
 					   X86_FEATURE_FLUSH_L1D);
 		break;
-- 
2.40.0.rc2.332.ga46443480c-goog

