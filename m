Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C46E8D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjDTIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjDTIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:47:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B569527E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:42 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA86741B36
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681980459;
        bh=QUa3auAj4u9NqRTBT9WVcUeMs8DEO6WQSLZjTthBB3A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=fQpmg6Ek3DEy/BCFq3rwl4YPflP+poM/IUZES8u47fAth2Yvupa3yVqnatF30LZ6b
         iFGjlpfOFmdN3uM3DPN9EBHK5HV8yTQUv201Z7hcQYnAPOwnTbGPdn6uEAPrdhR44l
         VfSQE7BahR4Ptq10JN2NSjkQQxv/JIHmIDBXyN5xGSTmCSUC8qVAZZoaEQa0RXX0wP
         LpmoTU/WrVcENfUP9UWaicyHZInxfsRFPFqFd4dEs83jpEYgXj1f3Hpx9PKHE4rBxx
         Uftz/q0XVZ+s89xyu+lxVD3wRoV9hGrdpQvrUtPQGvCFtrv5AtHSBWD0xnKqQ1y+ji
         3vkZtOcQQxG9A==
Received: by mail-ej1-f70.google.com with SMTP id q24-20020a170906361800b0094fb847ed94so991100ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980459; x=1684572459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUa3auAj4u9NqRTBT9WVcUeMs8DEO6WQSLZjTthBB3A=;
        b=Nr0RRCVKyn6i0jtu4XwAPruc/I54798HgHkkOkAsA0XDFqptabnhuNoIjeBl8l/Neu
         f839wuJmOQhuqDQNurvEm0KHiavsvdVVFuRuNYxNLBP+55ChpCQH0cT66JraZHvDW50k
         DYBMwCusw2YxJjoLD6a2y5XdjPz3mJTPXtGdi0CjQujlCTdmd4VC+psDK9NtQhD+EK/5
         jn0Ta2f2cm/fbo2d1aTrmc8ObZOAlyd0SL8WkJT1LbwPXU3MAPf8HHFdqZWwRQ8a5ZMl
         ZXpC/514U1mXeEmaHcOd+VpMPbwiIxx4p9vsTJ7D2fxo4DkN5bsg90fu2uFqtshJvz/D
         OsKw==
X-Gm-Message-State: AAQBX9cOczqhH+FCxPECDGpbQgJXGFR7wST4kk0HS7zN+0Ks53oO9uZB
        9zJi8IW+wKPG+pctw+lTYSvnTVK2x+jvsiwCkJmmXa3BJxK/XEtR+OBMhA8VzXkdiDVCr8TVvT6
        Tv2Em8cebYNx4brCRjqJJGW/bZWzV5SjRwioPbwsvjQ==
X-Received: by 2002:a17:906:3512:b0:94f:12c0:4c8f with SMTP id r18-20020a170906351200b0094f12c04c8fmr820689eja.50.1681980459545;
        Thu, 20 Apr 2023 01:47:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZzV+Zu8+SSa+Fm3TdTM/basx1ZOevVs7KCOHxWHbqRAxUygjWfAeKhy8CpvyHsuSUMo+P3vg==
X-Received: by 2002:a17:906:3512:b0:94f:12c0:4c8f with SMTP id r18-20020a170906351200b0094f12c04c8fmr820671eja.50.1681980459275;
        Thu, 20 Apr 2023 01:47:39 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c39a000000b005068053b53dsm500964edq.73.2023.04.20.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:47:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     pbonzini@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Sean Christopherson <seanjc@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 2/2] KVM: SVM: add some info prints to SEV init
Date:   Thu, 20 Apr 2023 10:47:17 +0200
Message-Id: <20230420084717.111024-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420084717.111024-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230420084717.111024-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a few pr_info's to sev_hardware_setup to make SEV/SEV-ES
enabling a little bit handier for users. Right now it's too hard
to guess why SEV/SEV-ES are failing to enable.

There are a few reasons.
SEV:
- NPT is disabled (module parameter)
- CPU lacks some features (sev, decodeassists)
- Maximum SEV ASID is 0

SEV-ES:
- mmio_caching is disabled (module parameter)
- CPU lacks sev_es feature
- Minimum SEV ASID value is 1 (can be adjusted in BIOS/UEFI)

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 arch/x86/kvm/svm/sev.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a42536a0681a..14cbb8f14c6b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2168,17 +2168,24 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!sev_enabled || !npt_enabled)
+	if (!sev_enabled)
 		goto out;
 
+	if (!npt_enabled) {
+		pr_info("Failed to enable AMD SEV as it requires Nested Paging to be enabled\n");
+		goto out;
+	}
+
 	/*
 	 * SEV must obviously be supported in hardware.  Sanity check that the
 	 * CPU supports decode assists, which is mandatory for SEV guests to
 	 * support instruction emulation.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_SEV) ||
-	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS)))
+	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS))) {
+		pr_info("Failed to enable AMD SEV as it requires decodeassists and sev CPU features\n");
 		goto out;
+	}
 
 	/* Retrieve SEV CPUID information */
 	cpuid(0x8000001f, &eax, &ebx, &ecx, &edx);
@@ -2188,8 +2195,10 @@ void __init sev_hardware_setup(void)
 
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
-	if (!max_sev_asid)
+	if (!max_sev_asid) {
+		pr_info("Failed to enable SEV as the maximum SEV ASID value is 0.\n");
 		goto out;
+	}
 
 	/* Minimum ASID value that should be used for SEV guest */
 	min_sev_asid = edx;
@@ -2234,16 +2243,22 @@ void __init sev_hardware_setup(void)
 	 * instead relies on #NPF(RSVD) being reflected into the guest as #VC
 	 * (the guest can then do a #VMGEXIT to request MMIO emulation).
 	 */
-	if (!enable_mmio_caching)
+	if (!enable_mmio_caching) {
+		pr_info("Failed to enable SEV-ES as it requires MMIO caching to be enabled\n");
 		goto out;
+	}
 
 	/* Does the CPU support SEV-ES? */
-	if (!boot_cpu_has(X86_FEATURE_SEV_ES))
+	if (!boot_cpu_has(X86_FEATURE_SEV_ES)) {
+		pr_info("Failed to enable SEV-ES as it requires sev_es CPU feature\n");
 		goto out;
+	}
 
 	/* Has the system been allocated ASIDs for SEV-ES? */
-	if (min_sev_asid == 1)
+	if (min_sev_asid == 1) {
+		pr_info("Failed to enable SEV-ES as the minimum SEV ASID value is 1.\n");
 		goto out;
+	}
 
 	sev_es_asid_count = min_sev_asid - 1;
 	if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
-- 
2.34.1

