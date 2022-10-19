Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B264604F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiJSRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJSRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:54:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A313D5B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:54:31 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAD081EC071E;
        Wed, 19 Oct 2022 19:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666202069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JL5d16xQ4WYM5xYTGulLQehtXJra7XYyLAqvFFhLyno=;
        b=DBBrIcNM8mBxCHwDSf7km4Z4m7l/Ys6v9YDzfnMA1JG/TuH3UPbgqazLLE7+TGWgo/oYDj
        LFILzlDzBQ3WSNFNlkNIegHnq41OEvpLpQmiL4oP1obqbs/MYEyfYlFQdE08SHGHt/lLbT
        kg5NnOG2y6SXk+vtgM9QgN+TAHQ+xsU=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] x86/microcode: Drop struct ucode_cpu_info.valid
Date:   Wed, 19 Oct 2022 19:54:26 +0200
Message-Id: <20221019175426.31025-5-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019175426.31025-1-bp@alien8.de>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
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
index 6b025143b073..026bf644344a 100644
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

