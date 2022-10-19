Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA41604F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJSRyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJSRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:54:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95111C07
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:54:30 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE8201EC0716;
        Wed, 19 Oct 2022 19:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666202068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjHXVZjpCpm9rYxfyt9yqu2jH5RX/dPYyJdOoev5Gl0=;
        b=lND6/zftAY27YhEaP294ZEdtAdlo31RdawHc8GKqkDMKJOyRc0c6kcQ2T9LFQwOyO3lKTY
        YexBv8QKIQKXBKL2nDn/nZU2YiMQ9EZMx25pkdMgSUgHl74QiS8QMH72EqyeMIZvX+yxte
        f65ZjtCNYDfUDeVA0KQVJ34kvVzCI0I=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] x86/microcode: Kill refresh_fw
Date:   Wed, 19 Oct 2022 19:54:24 +0200
Message-Id: <20221019175426.31025-3-bp@alien8.de>
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

request_microcode_fw() can always request firmware now so drop this
superfluous argument.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/microcode.h      | 3 +--
 arch/x86/kernel/cpu/microcode/amd.c   | 5 ++---
 arch/x86/kernel/cpu/microcode/core.c  | 4 ++--
 arch/x86/kernel/cpu/microcode/intel.c | 3 +--
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 74ecc2bd6cd0..d4c36fbd1d39 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -33,8 +33,7 @@ enum ucode_state {
 };
 
 struct microcode_ops {
-	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
-						  bool refresh_fw);
+	enum ucode_state (*request_microcode_fw) (int cpu, struct device *);
 
 	void (*microcode_fini_cpu) (int cpu);
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index e7410e98fc1f..b103d5e5f447 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -891,8 +891,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
  *
  * These might be larger than 2K.
  */
-static enum ucode_state request_microcode_amd(int cpu, struct device *device,
-					      bool refresh_fw)
+static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -901,7 +900,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || !bsp)
+	if (!bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 0aa6609e748c..8401b7235a68 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -477,7 +477,7 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
-	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
@@ -657,7 +657,7 @@ static int __init microcode_init(void)
 	 *  Frankly, I have no clue how that can happen but hey, loading here is cheap so
 	 * why not.
 	 */
-	microcode_ops->request_microcode_fw(boot_cpu_data.cpu_index, &microcode_pdev->dev, true);
+	microcode_ops->request_microcode_fw(boot_cpu_data.cpu_index, &microcode_pdev->dev);
 
 	/* Do per-CPU setup */
 	cpus_read_lock();
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1fcbd671f1df..8c35c70029bf 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -885,8 +885,7 @@ static bool is_blacklisted(unsigned int cpu)
 	return false;
 }
 
-static enum ucode_state request_microcode_fw(int cpu, struct device *device,
-					     bool refresh_fw)
+static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
-- 
2.35.1

