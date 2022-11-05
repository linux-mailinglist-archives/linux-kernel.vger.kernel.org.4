Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B8161A79B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKEE5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKEE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:57:12 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB8F31DD7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 21:57:11 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k131-20020a628489000000b0056b3e1a9629so3264885pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXjcYNaRFsRiTOYj/VSeDrYfnk14qW8dp0T0QhmC01U=;
        b=VEy7ANYLdY2iq6bTxxUDZH6+XSU2Nro3Rt2zHGVMA4QIhELj/IrEYMVaEzZGGn3ZuK
         /aVN+XLpm2LmvYFvB2Gd10hGP/dFIqYq2yj+yM9Gndo6RtIm08NiZCTylamQCEAUGEos
         KHPhMs/vHmbr50DuZRCNLnCw0oCUd7D4i0lsFgypH9fASd2wgsXDKOa3p1Ze7zQ7lI05
         G5o9g23jHCJmOenZVwLG2uLqyO8mKbn1UZW6eXIb+/c0Y7bpFnNrqHaliPBbJL7u8fBY
         LF44uC5ML5UeFa6fZChqUid+ocL/63nXT436SgeFZcuIMiYYwh4bRNYoRzNT3A/7jpGO
         DLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXjcYNaRFsRiTOYj/VSeDrYfnk14qW8dp0T0QhmC01U=;
        b=kITcq5n4GdBmJPsb6b3TrPMC8SkKskyydw6s/5SC08wKBLRaZDQ5ONMlYtsicIgmdL
         rXxBVNBoduiKUo1uoYdxXsH1cOdKNw/2u3Yt2zbDRvtijBHOgiZB7PA8MCXAX3KsHoTD
         /eX/vBlfkSEnbulNVg+fANkAlkFRfRAEYjgWp2kRxp2MgXgX4zhsl1BsSjP+mXiJyvXB
         rLhqi4+Iii9PdZDwAOFVR++Y3fbBRvyneNBHpfdADsfRnnAsv0CXcHBmYI9mM5NshFWx
         ODmR19OVrRNdytjEByG4CGv3fC19tt5sg6GNolSlHROMqTp3JQMoC/Zg/qnt2A5yGE1X
         a8Tg==
X-Gm-Message-State: ACrzQf2NH9DhJI9VkzVl536V561vE91iKwehIMMN//+ZYZth4U6k75HE
        Dh/LALMkIGVppvxPJM2NnKag5IZ7PTM8
X-Google-Smtp-Source: AMsMyM74KD9sv5Y/7eP8tBJe72q8a1/ftv2vvR5j5K3J2QbUWaHpU3xhQYXxycxvJJyfgjd96owmfq9yHGCO
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:e883:b0:186:99e3:c079 with SMTP id
 w3-20020a170902e88300b0018699e3c079mr433741plg.149.1667624231359; Fri, 04 Nov
 2022 21:57:11 -0700 (PDT)
Date:   Fri,  4 Nov 2022 21:56:59 -0700
In-Reply-To: <20221105045704.2315186-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221105045704.2315186-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221105045704.2315186-2-vipinsh@google.com>
Subject: [PATCH 1/6] KVM: x86: hyper-v: Use common code for hypercall
 userspace exit
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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
index 0adf4a437e85..db2f96a0ae23 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2270,14 +2270,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2336,14 +2329,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2352,6 +2338,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
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
2.38.1.273.g43a17bfeac-goog

