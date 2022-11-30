Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8D63E594
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiK3XhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiK3XhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:37:00 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437AEB5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:59 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z10-20020a170902ccca00b001898329db72so13184247ple.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Gab+7smmEIeAzCswMeinhNnVkpeemsKL4/AIt3t4698=;
        b=ZJiwYaMvGcPJ2o6DfJu9KidimXxl4J+NW5eoqSBhAX4kZ+WPgDR8YQpHsF8I2pm3Hj
         u2AZ3u4vgrf43j/UtrcH9r9f1BMELIEBxQScRF3vEb7okCvXsEm3sLXo3I1OXzNtpIMO
         eSUiGAv86HRwAX7VJOF2WQ+5Muz5vqZRHkmjWkYn32GHVJulKdBB7+hMZ22OhD9IV5XN
         uFEoNX/r4vp9anjRuVb/U/rwtImPO+24HlJ0ZA8d/0UxOMJZDsulI322mBzUMbNuT92W
         7KVmMwsSbSQ81Ncz6cur428ZbWpaHi3J0iIHFrwDjN1xElSPZnEUdDexEU0IxrXuJle3
         pItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gab+7smmEIeAzCswMeinhNnVkpeemsKL4/AIt3t4698=;
        b=Qs4UeGut7kK4FBK9Z9uoRn34zLZhAR5p5SkZ0JGRryXnmenalbbQyyVHhHOnNEV/SW
         p1WutI3CgZMJ9dDvqLCjsEoPYIrriTv1O7U+jTtDM8pxyDk3thRys3dwFhBXSQbtuzK3
         khInxy2jtX/Xu9c9oUKXdv3qDDU/jSJFg6tRhcTV+juz3M6FbhEORnLRMY2otV7UP1Pr
         xIL8Gdae8rrgqE9FOnAdWgkAeZhksOwGpW5dGsooj0tHzObqVt16/zcKYJRYK2dpMpkT
         8F06dPTEXNKi/gTP+1gSt+g74U12JckMd3GuJcdZsJRm2HwV5G94Sl8I7Koz3Jtp13o6
         h09Q==
X-Gm-Message-State: ANoB5plY8i4oVmUNdmOSaM9Eawf6pO0QkCJN4MzmvEZm1t7K7LZO7l1y
        V5QbTKKeZEdLPWYwjnMNHCoaFLCVcb4=
X-Google-Smtp-Source: AA0mqf5BU7myFNSKbIJT1C1eVP57Ls7Ae41Vu5YGVA1dp7FypEeyBYAY/wcZijWTQ61QxY/9mYbEIpPftGI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e0f:b0:213:c5ae:55ec with SMTP id
 pg15-20020a17090b1e0f00b00213c5ae55ecmr65534712pjb.182.1669851419154; Wed, 30
 Nov 2022 15:36:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:36:50 +0000
In-Reply-To: <20221130233650.1404148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130233650.1404148-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130233650.1404148-5-seanjc@google.com>
Subject: [PATCH v4 4/4] x86/reboot: Disable SVM, not just VMX, when stopping CPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel
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

Disable SVM and more importantly force GIF=1 when halting a CPU or
rebooting the machine.  Similar to VMX, SVM allows software to block
INITs via CLGI, and thus can be problematic for a crash/reboot.  The
window for failure is smaller with SVM as INIT is only blocked while
GIF=0, i.e. between CLGI and STGI, but the window does exist.

Fixes: fba4f472b33a ("x86/reboot: Turn off KVM when halting a CPU")
Cc: stable@vger.kernel
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 06db901fabe8..375b33ecafa2 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -32,7 +32,7 @@
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
 #include <asm/kexec.h>
-#include <asm/virtext.h>
+#include <asm/reboot.h>
 
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
@@ -122,7 +122,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 	if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
 		return NMI_HANDLED;
 
-	cpu_emergency_vmxoff();
+	cpu_emergency_disable_virtualization();
 	stop_this_cpu(NULL);
 
 	return NMI_HANDLED;
@@ -134,7 +134,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
 	ack_APIC_irq();
-	cpu_emergency_vmxoff();
+	cpu_emergency_disable_virtualization();
 	stop_this_cpu(NULL);
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

