Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79276B531C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCJVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjCJVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:44:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C69A7A8E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:27 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id v15-20020a17090a458f00b0023816b2f381so3266831pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nch/U2KS5FYfJuFemOwyNE1+WKPHRvL9RTK7YAmLi2g=;
        b=rWCVVA7pRjFLMF9SHUa16e6ftWp6oeXy7xKmhb5ke8JQx0keQK3FAIuZwTqlpT2TJQ
         ma1SoP6r2/cpfSgdBJlDCHv2DLZFkEd0LB3buYUYQYpt92ZLEdc7uY217ngjkDZBmPLR
         C37FPNfg42SARQNuXn9jj2Fc0GLhyUWsWVX4nBSeTkdrAOyRow7uU0LFH8Tw5ontkPBQ
         ENJMWBCDdEuvAfGGA0y3Wgt8xW+Sa6Enlxqdxd5VsdEC/l7DlwkAO14s9KPrBb18zNI+
         O5xfkaVHnpGmzmEeuIJWXxQuHqrXw2+ehJ+e2dA/o9blRyEE6ZnCckIn0VLJN1ClN+g+
         J3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nch/U2KS5FYfJuFemOwyNE1+WKPHRvL9RTK7YAmLi2g=;
        b=OSF0DQYGECCyOW14U6fcURsAkwE3pSMmVT8qpt25Npre6Kygh8fmQsW/mPdwGH9UW9
         whFZTA3qsChyYD2Hj7UifLFhMBGxHFjjSEDiBmQDT5XivP/CgQGnWr3mpUGleJB2/pGO
         BdM0t68uxcqbURkxvXCr/b2E+xtAVNtYyv4/E8Pu6fpHKgvZUs434onKfuljPiBK7mBo
         jEM8u5hRDF0LQ7pHrcI+6uQwHzDXuVqsnn10LtuQ/7AQtTN29Ad2tFZciMUWVUfQaK/i
         hDu9tvuu2H2BcmhkbudZgr/h4GAnD7Y5G9nn1bBYRb43fC1PtkFsUNQYIRqgdikC0UM0
         M/sQ==
X-Gm-Message-State: AO0yUKUr/8YtqdKw3FNeQvH2jxkz9s475vysot1Kk2eMDYkBoiiq/Yvl
        I7Rg68KVdIIbwxsuqbWoP5Sj+gB+y0o=
X-Google-Smtp-Source: AK7set+ie/JuKmj28YG59h40IkUrdcWFz0imbYrE6WGVOhw2bRUMd8Dh4s2Ws+qKuMd3b/EL/elt79Y/+24=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:44a:0:b0:4f0:2691:a0ee with SMTP id
 71-20020a63044a000000b004f02691a0eemr1163603pge.0.1678484590253; Fri, 10 Mar
 2023 13:43:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:31 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-18-seanjc@google.com>
Subject: [PATCH v2 17/18] KVM: x86: Force kvm_rebooting=true during emergency reboot/crash
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

Set kvm_rebooting when virtualization is disabled in an emergency so that
KVM eats faults on virtualization instructions even if kvm_reboot() isn't
reached.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 arch/x86/kvm/vmx/vmx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2db03991dcdf..30f7840151be 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -608,6 +608,8 @@ static inline void kvm_cpu_svm_disable(void)
 
 static void svm_emergency_disable(void)
 {
+	kvm_rebooting = true;
+
 	kvm_cpu_svm_disable();
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 374e3ddbd476..8626010f5d54 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -770,6 +770,8 @@ static void vmx_emergency_disable(void)
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
 
+	kvm_rebooting = true;
+
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
-- 
2.40.0.rc1.284.g88254d51c5-goog

