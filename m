Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A720604F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJSRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJSRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:54:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5F12ADB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:54:30 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DFE31EC071C;
        Wed, 19 Oct 2022 19:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666202069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pgpm5JAh0V/litpZ4Q9lGMM3/tmEtRFA/DKiwzEQ9g=;
        b=OfriYxZSlcOTNCYmQFuyzbEWUFXSyMHHQVcDZliy3wf2Z3Cbtg3SU1ATR/Hq0AA4hj9At6
        tiJtTGeQGpybG8k3peiS48eOVNgxSNvV1AIAanSRaFyLcsuGuPn24m+n/0bOS3LadcU4l8
        GbPlBMw3bU7j21eEetKc7CD+tDbE0EQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] x86/microcode: Do some minor fixups
Date:   Wed, 19 Oct 2022 19:54:25 +0200
Message-Id: <20221019175426.31025-4-bp@alien8.de>
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

Improve debugging printks and fixup formatting.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 8401b7235a68..6b025143b073 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -568,6 +568,8 @@ static int mc_cpu_starting(unsigned int cpu)
 {
 	enum ucode_state err = microcode_ops->apply_microcode(cpu);
 
+	pr_debug("%s: CPU%d, err: %d\n", __func__, cpu, err);
+
 	return err == UCODE_ERROR;
 }
 
@@ -590,7 +592,7 @@ static int mc_cpu_down_prep(unsigned int cpu)
 
 	/* Suspend is in progress, only remove the interface */
 	sysfs_remove_group(&dev->kobj, &mc_attr_group);
-	pr_debug("CPU%d removed\n", cpu);
+	pr_debug("%s: CPU%d\n", __func__, cpu);
 
 	return 0;
 }
@@ -639,14 +641,11 @@ static int __init microcode_init(void)
 	if (!microcode_ops)
 		return -ENODEV;
 
-	microcode_pdev = platform_device_register_simple("microcode", -1,
-							 NULL, 0);
+	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
 
-	error = sysfs_create_group(&cpu_subsys.dev_root->kobj,
-				   &cpu_root_microcode_group);
-
+	error = sysfs_create_group(&cpu_subsys.dev_root->kobj, &cpu_root_microcode_group);
 	if (error) {
 		pr_err("Error creating microcode group!\n");
 		goto out_pdev;
-- 
2.35.1

