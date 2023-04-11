Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906166DDB35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDKMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDKMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:51:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8649F0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:50:58 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C8B81EC0102;
        Tue, 11 Apr 2023 14:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681217457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5rCvIR1+NXtC/U4YpBicBhbbk7m1XBj1nREQr5sMoc=;
        b=kpslLYUk5j6taciJcyCLs9ClnjOULJdXE1QrTzZwK1TW93HPqpdyAI9EcMfixrSAPtkSL8
        Al6OKlLX8Czv+ifaKtOa4RCmw26TUMcjM2o3HdZcdbVyQlA56lShkBFxi+OWhppzCP/gyC
        iNKca7i9dVybm8PQgmzB3S/8BS1OFc8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] x86/microcode: Do not taint when late loading on AMD
Date:   Tue, 11 Apr 2023 14:50:55 +0200
Message-Id: <20230411125056.2333-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230411124832.GAZDVXIFR3BiExtXba@fat_crate.local>
References: <20230411124832.GAZDVXIFR3BiExtXba@fat_crate.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Describe why the concurrency issues which late loading poses are not
affecting AMD hardware, after discussing it with hw folks. Thus, do not
taint when late loading on it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/x86/microcode.rst      | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  9 +++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index b627c6f36bcf..15b52e2b181d 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -208,6 +208,16 @@ Basically there is no way to declare a new microcode update suitable
 for late-loading. This is another one of the problems that caused late
 loading to be not enabled by default.
 
+AMD
+---
+
+Late loading on AMD does not have the concurrency issues described
+above: when loading is attempted on T0, the T1 is quiesced and does not
+execute instructions. Therefore, even if a higher priority interrupt or
+a fault happens, the whole core will see it either before the microcode
+patch has been applied or after. In either case, T0 and T1 will have the
+same microcode revision and nothing intermediate.
+
 Builtin microcode
 =================
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a329e561354..22cf57c899b6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -440,9 +440,6 @@ static int microcode_reload_late(void)
 	int old = boot_cpu_data.microcode, ret;
 	struct cpuinfo_x86 prev_info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -498,7 +495,11 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		pr_err("Late microcode loading is dangerous and taints the kernel.\n");
+		pr_err("You should switch to early loading if possible.\n");
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
 
 	return ret;
 }
-- 
2.35.1

