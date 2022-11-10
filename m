Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530966238D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiKJBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiKJBaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:30:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8882529C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:30:09 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id v10-20020a17090a7c0a00b00215deac75b4so251201pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/4bwbP2JIl1w6WCsdAS3m6C3yOQnsuV5KJ06kvZbaP0=;
        b=l0p8172mRh+A5kK8Bj1NUUAho95PhZ6VdTXUfqMRp+FyO9t9EcrGarYer6gc6AW8i+
         6t6+PCG6D2K79fF/x0m9K11xFPRSBPoSS/eB3QE/Rzt9DwrDWPlyrCUTBE/VQP2eYjs8
         EoBvVC0v/E6QTdAlVCD9+9M4FMh5phWFz3D2bGnCo7JmgHsdzYZvKty9fm9FWr/D8l8C
         Tc0BMS+tizJb1lu8fOY1oVWVDFZzfW4sbI/BCILHRzND+SdUDgLmg+pY5Sc87Wgr6IMr
         FwutmXDItzc0icn40EUIFlQOPrGVUMsbPNKWsKO7PMLo+mPVu/ovy7eZB9iA3feo071S
         +dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4bwbP2JIl1w6WCsdAS3m6C3yOQnsuV5KJ06kvZbaP0=;
        b=a7fZV8tdUu082zghGuap1QIkPEWlW0GEhxEaqQDXxDDAsZsT8g7o5TuRJltrHvuP8e
         5TlXRr3bruTvaDTOA3f0HMH83/+xoBltiljTjhEfnfyHKizAaU6UoCJ0zRoKskB7HfSM
         X+8HEdt9p0aPv3tCpIYffU1DvRtEB5Z0t3voIvctWDM98Rsyim0THphfCVLkXJ123Lib
         Yk+HOL3Psj357eaVP390lpYzc8ZSoax6pVx+NRsI7D9dDhwhaIWfphWLbzduBZtBzPu+
         /V8J1AL/2VsXlptF/Ro+wN1iPDlFdvCtFMRS9WFKhB/3OJswlb5JSExTX1LaRHFGmdER
         v4sQ==
X-Gm-Message-State: ACrzQf1WlWyqmbaO4PwCJB7wTw74CEYMF2rHuqOReem82y44h+hOJykm
        nnHNlwGvLTnVNriN5Vv2C/CINwilNak=
X-Google-Smtp-Source: AMsMyM4PRLniObbra8jvUIn003Rf0J+k1M28uWglxYxu3GfkGPEeOUDlqdppjR6pgC4haF7k7GZSwGRbsy4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:e86:b0:56b:9ae8:ca05 with SMTP id
 bo6-20020a056a000e8600b0056b9ae8ca05mr1506767pfb.59.1668043808753; Wed, 09
 Nov 2022 17:30:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 01:30:02 +0000
In-Reply-To: <20221110013003.1421895-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221110013003.1421895-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110013003.1421895-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: SVM: Make MSR permission bitmap offsets read-only
 after init
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Tag the pre-computed offsets into the MSR permission bitmaps as read-only
after init, and similarly tag add_msr_offset() and init_msrpm_offsets()
as __init.  The bitmaps themselves are dynamically configured, but the
offsets, i.e. the set of MSRs that can be passed through to the guest, is
static for a given instance of KVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 arch/x86/kvm/svm/svm.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 527f18d8cc44..e96c808fa8d3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -65,7 +65,7 @@ MODULE_DEVICE_TABLE(x86cpu, svm_cpu_id);
 
 static bool erratum_383_found __read_mostly;
 
-u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
+u32 msrpm_offsets[MSRPM_OFFSETS] __ro_after_init;
 
 /*
  * Set osvw_len to higher value when updated Revision Guides
@@ -860,7 +860,7 @@ static void svm_msr_filter_changed(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void add_msr_offset(u32 offset)
+__init static void add_msr_offset(u32 offset)
 {
 	int i;
 
@@ -887,7 +887,7 @@ static void add_msr_offset(u32 offset)
 	BUG();
 }
 
-static void init_msrpm_offsets(void)
+__init static void init_msrpm_offsets(void)
 {
 	int i;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 199a2ecef1ce..ca348e016729 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -31,7 +31,7 @@
 
 #define MAX_DIRECT_ACCESS_MSRS	46
 #define MSRPM_OFFSETS	32
-extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
+extern u32 msrpm_offsets[MSRPM_OFFSETS] __ro_after_init;
 extern bool npt_enabled;
 extern int vgif;
 extern bool intercept_smi;
-- 
2.38.1.431.g37b22c650d-goog

