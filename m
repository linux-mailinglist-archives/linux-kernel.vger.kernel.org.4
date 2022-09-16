Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885F5BA62F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIPE7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIPE7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:59:03 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82810A1D4F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:59:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k16-20020a635a50000000b0042986056df6so10274516pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=5sbTEFvzRr7GbC/X6PZeq7okuS0vSIgMoswqUqyuUqc=;
        b=HMBxt0pVNHCYNbxDc8VigBQ1MXR7A+42pRZxXF2slNCnNQZ+6f5rRNNuBLP386Sh1I
         /xpXiblZaqt2Zw/oMm275rNOy7gxR5ESOhvXOrh3Xs9/jW9D+/1iNhcZY5IyiTicaUkm
         vdsRXzItacxSB6z3HdidM9p8wAhXKp7qkPuwr1QZFBuAZTTHewolt3wy8YhP+O6KUZsa
         0gYQ3wFQBolHX3xKaCmoHM77d07g5ZzVOppnYoMu0GmqiRRzTgAVwH7EKg5F7lMYyYXH
         EzXgmLPeSb+K7mdu32DZMPuF4dZzYVMWH6/NKixpzRxtozPZUeSXdTIHgh6YMbQkrS4D
         K00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=5sbTEFvzRr7GbC/X6PZeq7okuS0vSIgMoswqUqyuUqc=;
        b=VrQBvykYyPtZwq638wD+fZOWizCjN0CagorzciaAgkXyYFSRZuvEuZcxDxHIIWQJTM
         pVwzvYquTh/f2/xE1vsOxz2x3N1+ccF/j9PJnK9IbUc/qHP7nzyU/Kw1OpApMuOARqWa
         HJ53yhDPVDDjWK+Uxa6DzaDBrX1cvGYQVfwu9U/aD4lxo1In08fjyM9UjQnX4Kaqdb2P
         LZI7euSlJymrahLFKJazpt8WfkqzAWYrJfCiHFfgkucoWfxkoa4AAr9nL/J5hPM020Oc
         FN96ggkt0prtCivHrj495NKrqW0llVeKXDkkSBei0Jg2ptWllTxci2GaUO+MOb7uyDBk
         R5JQ==
X-Gm-Message-State: ACrzQf05XblBgG+xApDUWcHOKgohYXYdeXRWMM+TF8NUT4YizfETnH5z
        adKuOglYaee6BwW3wwp9HtGWweGhegShiQ==
X-Google-Smtp-Source: AMsMyM7lej8pA2zAcVKJ6uuHmUlBJhtH7xJC3YODVQ9Y2cN9cfo4/QAh/md/oFPO6DRkDPfYzJ58987yAYNHtw==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:10c2:b0:547:4991:c985 with SMTP
 id d2-20020a056a0010c200b005474991c985mr2959344pfu.67.1663304340786; Thu, 15
 Sep 2022 21:59:00 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:58:32 -0700
In-Reply-To: <20220916045832.461395-1-jmattson@google.com>
Mime-Version: 1.0
References: <20220916045832.461395-1-jmattson@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220916045832.461395-6-jmattson@google.com>
Subject: [PATCH 5/5] KVM: svm: Set X86_FEATURE_NO_LMSLE when !nested
From:   Jim Mattson <jmattson@google.com>
To:     Avi Kivity <avi@redhat.com>, Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>
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

KVM has never allowed a guest to set EFER.LMSLE when the "nested"
module parameter was false. In the past, there was no way for a guest
to know whether or not this was a legal EFER bit. Now, we can let the
guest know this bit is illegal by reporting X86_FEATURE_NO_LMSLE in
KVM_GET_SUPPORTED_CPUID.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7c4fd594166c..942602d503ad 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4945,6 +4945,8 @@ static __init void svm_set_cpu_caps(void)
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
+	if (!nested)
+		kvm_cpu_cap_set(X86_FEATURE_NO_LMSLE);
 
 	/* AMD PMU PERFCTR_CORE CPUID */
 	if (enable_pmu && boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
-- 
2.37.3.968.ga6b4b080e4-goog

