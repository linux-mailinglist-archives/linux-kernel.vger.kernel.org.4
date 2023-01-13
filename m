Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3D66A0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjAMRnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAMRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AE6C053
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630973; x=1705166973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4EqDfmlWSpjXzy20Qe0hd2hnLS19EqiJq6uAIZI/d1Q=;
  b=RYSW8+g2iqBhkqpAtnhLdScqjZnkUkq8ezWbOC1scR7TRGfYGFbBCE9Y
   rK+tqLgGeHOnWbActuc1OyE1yd8dbGFIVusMobWFGsnviXmzJ1xOtrn7y
   uBYDNYQNeu7UQxG/Me7Ova4zldrX3gYYZTDkmHIqZyPTFPJOvS2x1Uaqh
   Xxs3hauiMtzRCnqFhOoaRKrcZJ3lHnU8iNTG4wM3603/h6iGtKEpHwLGN
   7NtVwJiuiKaj6mzD0NMIfNy2dVQGmAjYm8EbuKUYX+eOEhGqBqIkJ4T9N
   8d3l9s3eC1xujt+QrZpsVExhOf1qRhDqE0dEjyAlg4W8hLfckaNC8x7Ic
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304429995"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304429995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766089917"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766089917"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:32 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v1 Part2 1/5] x86/microcode: Move late load warning to the same function that taints kernel
Date:   Fri, 13 Jan 2023 09:29:16 -0800
Message-Id: <20230113172920.113612-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113172920.113612-1-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
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

Currently the warning about late loading and tainting are issued from two
different functions.

Later patches will re-enable microcode late-loading.

Having both messages in the same function helps issuing warnings only
when required.

Move the warning from microcode_reload_late() -> reload_store() where the
kernel tainting also happens.

No functional changes.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Peter Zilstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index d7cbc83df9b6..c361882baf63 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -441,9 +441,6 @@ static int microcode_reload_late(void)
 	int old = boot_cpu_data.microcode, ret;
 	struct cpuinfo_x86 prev_info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -494,6 +491,9 @@ static ssize_t reload_store(struct device *dev,
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

