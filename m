Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C64628D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiKNXe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiKNXet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:34:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86894D2DF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36b1a68bfa6so120632407b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=djgaqErjRZF6fX42GfLyq11F7zcT5pI64PmiJ438gBw=;
        b=REwif+0a9OE5bD+nwfe35yDK6CQ72KjjwHwpvsILcX4myGMWvs1vdCVc30HcF0ECyj
         jDRgWq6UJ5MMpTovIj7XMHNL/GyzrwcCseSEv2M/x7Gfx+7KCPz1hPw7cv9rPJq6ZJgd
         EpLN/EWF1+PC44B9jXxzK9mCvasstQOV/szo2rGNorqA3zScWVEUxKEt1+LUcnFB757G
         qHZCtnZcx6AeL49prh/MnpiAUDXNbsbKGMkfKcmHehVt3bLjIdoD44gPcab1f5wIqGzv
         bfzSjdoCCqtblmarASwX5PtaysmUB6VYKiKsoppMf69se3K+xl48A70T48zk2JIP2AXZ
         h2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djgaqErjRZF6fX42GfLyq11F7zcT5pI64PmiJ438gBw=;
        b=eYyywtFXWt2sDRB3PR+yCqFMuQTjQtGAcdzKbrL1eq3JtINMTnZJ4ktihtuARc8g0N
         0+dcgNfDhHldLijBBdSzI4ZowBomSMyOalTtyCH8eOl7pGwm5A4vSdyqehcD7JLFtOMI
         xh8HROUJtS47zV0ZTH6wqeN4nEfQ+C719QUPXsBfP1n0Rwzct4WIb+EDH2W+4qVwAA8o
         TQWPZoC/BqxyNK8HecGvHjNCGLs2MF2TNhzUrLuNoUi7WbRLzks85Kh5m+qEYz3kos2c
         x88tRwNp3w1v8gjzzMfuknvPL/wtvqAdEQj4K+c2WCb4W7/51RJMtJBbG70bea1SUx8t
         j59Q==
X-Gm-Message-State: ANoB5pmPmBKBV0J/npkbS2qktHw6fqaS6KcW5B+UzVAF99BSgrFEMxo/
        k1DdqMyrBTgTlKGQx3Ebv9nlubPLkg4=
X-Google-Smtp-Source: AA0mqf4octYN9bWtyZS9FI52P2bS/dyK2p4B7ZEAYUFivrFYogJnWGZo6zf5cc5brGL9Fo4DCntWBrCPDZE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d2c1:0:b0:6ca:4802:e148 with SMTP id
 j184-20020a25d2c1000000b006ca4802e148mr14627506ybg.417.1668468887768; Mon, 14
 Nov 2022 15:34:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 14 Nov 2022 23:34:40 +0000
In-Reply-To: <20221114233441.3895891-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221114233441.3895891-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114233441.3895891-3-seanjc@google.com>
Subject: [PATCH v3 2/3] x86/reboot: Disable virtualization in an emergency if
 SVM is supported
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

Disable SVM on all CPUs via NMI shootdown during an emergency reboot.
Like VMX, SVM can block INIT and thus prevent bringing up other CPUs via
INIT-SIPI-SIPI.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f2655b78d73c..973a1b2c61bf 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -530,27 +530,26 @@ static inline void kb_wait(void)
 
 static inline void nmi_shootdown_cpus_on_restart(void);
 
-/* Use NMIs as IPIs to tell all CPUs to disable virtualization */
-static void emergency_vmx_disable_all(void)
+static void emergency_reboot_disable_virtualization(void)
 {
 	/* Just make sure we won't change CPUs while doing this */
 	local_irq_disable();
 
 	/*
-	 * Disable VMX on all CPUs before rebooting, otherwise we risk hanging
-	 * the machine, because the CPU blocks INIT when it's in VMX root.
+	 * Disable virtualization on all CPUs before rebooting to avoid hanging
+	 * the system, as VMX and SVM block INIT when running in the host.
 	 *
 	 * We can't take any locks and we may be on an inconsistent state, so
-	 * use NMIs as IPIs to tell the other CPUs to exit VMX root and halt.
+	 * use NMIs as IPIs to tell the other CPUs to disable VMX/SVM and halt.
 	 *
-	 * Do the NMI shootdown even if VMX if off on _this_ CPU, as that
-	 * doesn't prevent a different CPU from being in VMX root operation.
+	 * Do the NMI shootdown even if virtualization is off on _this_ CPU, as
+	 * other CPUs may have virtualization enabled.
 	 */
-	if (cpu_has_vmx()) {
-		/* Safely force _this_ CPU out of VMX root operation. */
-		__cpu_emergency_vmxoff();
+	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
+		/* Safely force _this_ CPU out of VMX/SVM operation. */
+		cpu_crash_disable_virtualization();
 
-		/* Halt and exit VMX root operation on the other CPUs. */
+		/* Disable VMX/SVM and halt on other CPUs. */
 		nmi_shootdown_cpus_on_restart();
 	}
 }
@@ -587,7 +586,7 @@ static void native_machine_emergency_restart(void)
 	unsigned short mode;
 
 	if (reboot_emergency)
-		emergency_vmx_disable_all();
+		emergency_reboot_disable_virtualization();
 
 	tboot_shutdown(TB_SHUTDOWN_REBOOT);
 
-- 
2.38.1.431.g37b22c650d-goog

