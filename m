Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3261148C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJ1O2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiJ1O1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:27:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F080BFE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:26:49 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBBAD1EC0754;
        Fri, 28 Oct 2022 16:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666967207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awd9cZozCZs++lKu/R+oRT9FZWWyrMeXGKmrwed6L8c=;
        b=lEiXigve4v6BmnN6n8o3AL+2QkwaLHt8EOnPNQdoZ+4k1KqONaZ0ljkxfJO6bb4vakAFrH
        HsP2c7DxSPsuLc0BDsL3eSTBoNFo/4g4jG9NqCrktl7Xlasy3A8bP8pRVe2K7HyMT8Va4Y
        O5PP6VClDkuh/yeoNyvqQEeeNshn7Yc=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] x86/microcode: Do some minor fixups
Date:   Fri, 28 Oct 2022 16:26:37 +0200
Message-Id: <20221028142638.28498-5-bp@alien8.de>
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

Improve debugging printks and fixup formatting.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7c41e0132fa1..ffb249c29f30 100644
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

