Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDD628D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiKNXfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiKNXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:34:50 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168719FD8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:49 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q6-20020a170902dac600b001873ef77938so10010167plx.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CuKvIMG0gJXVjX3tbXmKavICyGNlOF16asBACO4qrT8=;
        b=aX7xVD9dcMcvK8lTJzwcwroZfbH8mtqoObt1cLCfIfNBrnQLxxBOraVlNmlV1JCA8v
         T3RIatPfsiUm6v2ocVOy7mhJafHTgtZ/VxsTTQp4gkDjXNVCByn+Gft5BNWQjK8VvPoa
         OV1L+vFy/ScifZSCgMAqJ3BHKVSXSWzbhwvw/n+gx8DJryuZ7UOckJDB4I8E43ujvfn2
         HYWG8yhQlTGAQawT97Wi62I9/RKDpDdFA/hILuQIw19xUYAKRZazPOG1geJPc9C6vbR7
         GpW4Us68LKM+T8+3KHHykvt/rS1LtQ1C9k/XLH7wC6gTVyGcq7RVthPp7zc7a4+0mzOS
         u8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuKvIMG0gJXVjX3tbXmKavICyGNlOF16asBACO4qrT8=;
        b=HwYPt2Geu3jzjPxsNrQBVxlwvFsSKFIt6IcdflvrfqbPlSRP15AsviCrWrHNbpuX9j
         0Fx+8ih/jxKjyRbP/+ZKcdzuh4IHcciPVsOZ2ucZbqHWS5VCBw3AbJzam+bP1UnNdL4H
         hsWs59aks2+eejaJV6yW00PcEDe7XshZ4kLJ3Hyc2EIGTXJKXhyWa/cbZHUIRmS5Mf+C
         MEDiWYjxn1+EbN/cpNcH/K770NeZ4an9gybbV+xqhj4eyCiIUU3wtV9PXyeuL27p326e
         KWEujnxE2HVj6fGkFy6pAYUWMSH46XWhAqe8ifmjj0VuSgBKq0OWek1ITnwXSd0Ez5mF
         vCew==
X-Gm-Message-State: ANoB5pldMwLSqE3R0IISVO4mKr2avxyDSJAIo7sRMcZYs7mfmaMzPVcW
        ma5OZoU9AdJW5go9pd8cuRyNiCNozsw=
X-Google-Smtp-Source: AA0mqf4x09lIuwZh4im23IautEl9b4C/xw4JSHaYddbQuuWR0iYnjW3xSI82tH+OAp0etW4Q+a/2ZGOE4IM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1dd8:0:b0:572:24c7:34da with SMTP id
 d207-20020a621dd8000000b0057224c734damr6261309pfd.73.1668468889489; Mon, 14
 Nov 2022 15:34:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 14 Nov 2022 23:34:41 +0000
In-Reply-To: <20221114233441.3895891-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221114233441.3895891-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114233441.3895891-4-seanjc@google.com>
Subject: [PATCH v3 3/3] x86/virt: Fold __cpu_emergency_vmxoff() into its sole caller
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
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

Fold __cpu_emergency_vmxoff() into cpu_emergency_vmxoff(), its sole
remaining caller, to discourage crash/emergency code from handling VMX
but not SVM.  The behavior of VMX and SVM is so similar that it's highly
unlikely that there will be a scenario where VMX needs to be disabled,
but SVM can be left enabled.  In other words, during a crash and/or
emergency reboot, funnel all virtualization teardown sequences through
cpu_crash_disable_virtualization().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 8757078d4442..a9414ef5269e 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -60,22 +60,12 @@ static inline int cpu_vmx_enabled(void)
 	return __read_cr4() & X86_CR4_VMXE;
 }
 
-/** Disable VMX if it is enabled on the current CPU
- *
- * You shouldn't call this if cpu_has_vmx() returns 0.
- */
-static inline void __cpu_emergency_vmxoff(void)
-{
-	if (cpu_vmx_enabled())
-		cpu_vmxoff();
-}
-
 /** Disable VMX if it is supported and enabled on the current CPU
  */
 static inline void cpu_emergency_vmxoff(void)
 {
-	if (cpu_has_vmx())
-		__cpu_emergency_vmxoff();
+	if (cpu_has_vmx() && cpu_vmx_enabled())
+		cpu_vmxoff();
 }
 
 
-- 
2.38.1.431.g37b22c650d-goog

