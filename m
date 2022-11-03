Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A906186D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiKCSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiKCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317262DFB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498361; x=1699034361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KpdhtG2RZ4I61tK91zuLU/1Q/Ncurh7LzYmq24qDOyw=;
  b=GkUHW4+hgeuoIMhUC4SaeyzCgnd/fW3eQyscCCXthi3AhGne7qYHujOT
   qXqNltNdnsYHcVC1c/KztdR/7KuVEydKa5eFHkw0GMdHLASg0UYW6luLW
   nVly9a01Su3Fh6pLTxLH69Jwu+Q2QWfzahA+UHtviKZyjesrEiIDX2b0W
   hLitQdiLT9TNFeI+65op+zQoFFrCf3kindQfya534jfQJh+6SFdLGDPI7
   urE4F/PLhYbdgXdHKxRQ+omvhNVCf5/3gjp28MEr5WxP2TjlKH2/mDDYU
   M9LJhI6AgIyBGnOsb470PVeTXnClYFA6c38zEXXhZE8wiC5k/9/jyoUCk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476968"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476968"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762553"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762553"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 05/13] x86/microcode: Move late-load warning to earlier where kernel taint happens
Date:   Thu,  3 Nov 2022 17:58:53 +0000
Message-Id: <20221103175901.164783-6-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move where the late loading warning is being issued to earlier in the call.
This would put the warn and taint in the same function.

Just a tidy thing, no functional changes.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 9ed1f6e138d6..d41207e50ee6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -487,9 +487,6 @@ static int microcode_reload_late(void)
 	int old = boot_cpu_data.microcode, ret;
 	struct cpuinfo_x86 info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -530,6 +527,9 @@ static ssize_t reload_store(struct device *dev,
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
+	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+	pr_err("You should switch to early loading, if possible.\n");
+
 	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
-- 
2.34.1

