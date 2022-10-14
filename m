Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B75FF455
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJNUJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJNUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2D1DA368
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778169; x=1697314169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/8WowSzv6butDgFSPKVaFoajey0RVIfNhZholFNfW4=;
  b=Rvvxatx8fCQx4aQ5B/ealI++O7ja9ObsO1MQzNZxvostvmKxp9eYUqgM
   ZnbdLi1ePjtjM+n0imaVY0juTJPaXEFyb9+zt4AviWipeLCN0WbCfO+mz
   78UdSAqlCxziOPAx0SSiu7P/EbR3nqamTwmiJCjMv7PDxCifQrOFcFqwc
   sXsneBaK3o6LFNxQ/3Lw9bW6BIMJafTjrxz+pejnFrpvKaNZv/rgu7vuG
   pYajjKNOey/iQNV9JM/0zwJvPfCqwlqCmuHvz0R7KJfG8ZQFLHOMC/Lan
   xSXzFYMFGKGJf5qEt8h/wKYuyQ6lAHVfc2p4lvnxHRnL64ChNqvkYvOQ5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202159"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202159"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870156"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870156"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:28 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 06/13] x86/microcode: Rename refresh_fw to late_loading
Date:   Fri, 14 Oct 2022 13:09:06 -0700
Message-Id: <20221014200913.14644-7-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename refresh_fw to late_loading to be more explicit about its purpose.

No functional change.

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h      | 2 +-
 arch/x86/kernel/cpu/microcode/amd.c   | 4 ++--
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 23d25ef546a5..401213fb2e4a 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -60,7 +60,7 @@ enum ucode_state {
 
 struct microcode_ops {
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
-						  bool refresh_fw);
+						  bool late_loading);
 
 	void (*microcode_fini_cpu) (int cpu);
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 5f38dd75cbc5..c18d3f01a452 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -891,7 +891,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
  * These might be larger than 2K.
  */
 static enum ucode_state request_microcode_amd(int cpu, struct device *device,
-					      bool refresh_fw)
+					      bool late_loading)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -900,7 +900,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || !bsp)
+	if (!late_loading || !bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 0f7e4ba05c39..e08777ae9cc4 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -901,7 +901,7 @@ static bool is_blacklisted(unsigned int cpu)
 }
 
 static enum ucode_state request_microcode_fw(int cpu, struct device *device,
-					     bool refresh_fw)
+					     bool late_loading)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
-- 
2.34.1

