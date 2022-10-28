Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930E261148D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJ1O2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJ1O1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:27:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2508286B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:26:50 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 423DE1EC0779;
        Fri, 28 Oct 2022 16:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666967208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUzepTEbA+PjW41liMbq12+QwoMLZTumivAWH3EYXPA=;
        b=OTIjjUkTU+7DslvPHPJVlMGazN5sWoqfKdrHoNrgcBCLSxHeModOVgvfhpbAubQ+CLoG0x
        uTUQxU6GhEj0viKoKlZU9bejAcl4Ss3sYOZt6hRBtN4+IPqPuT4od0ut+lhapaIFDPsWhF
        civAaisHtMdTJS0rT+9WKGxvd7WTduc=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] x86/microcode: Drop struct ucode_cpu_info.valid
Date:   Fri, 28 Oct 2022 16:26:38 +0200
Message-Id: <20221028142638.28498-6-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028142638.28498-1-bp@alien8.de>
References: <20221028142638.28498-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It is not needed anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/microcode.h     | 1 -
 arch/x86/kernel/cpu/intel.c          | 1 -
 arch/x86/kernel/cpu/microcode/core.c | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d4c36fbd1d39..d5a58bde091c 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -49,7 +49,6 @@ struct microcode_ops {
 
 struct ucode_cpu_info {
 	struct cpu_signature	cpu_sig;
-	int			valid;
 	void			*mc;
 };
 extern struct ucode_cpu_info ucode_cpu_info[];
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..beb8ca596784 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -210,7 +210,6 @@ int intel_cpu_collect_info(struct ucode_cpu_info *uci)
 	csig.rev = intel_get_microcode_revision();
 
 	uci->cpu_sig = csig;
-	uci->valid = 1;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ffb249c29f30..712aafff96e0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -554,9 +554,9 @@ void microcode_bsp_resume(void)
 	int cpu = smp_processor_id();
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	if (uci->valid && uci->mc)
+	if (uci->mc)
 		microcode_ops->apply_microcode(cpu);
-	else if (!uci->mc)
+	else
 		reload_early_microcode();
 }
 
-- 
2.35.1

