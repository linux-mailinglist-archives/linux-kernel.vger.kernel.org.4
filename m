Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6E67699D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjAUVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUVfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:35:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E423C72
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674336923; x=1705872923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zY4nJSbIj2KCZODz6WytpRpGqSak4jvzYQ/pzIgYhPE=;
  b=SM4uWad2WqK/QlphzQ05Q3D+P7prL7w2wmbHDEVbm118jf3ppNa+Hqyj
   CR7uUh8Gx7aoC/ot1+72EYitDJ3P2OJiW7ecpEcz5pk92pgF+eFB/lJuw
   wNbPPIuIbH4Q08RFPq4AKpl2t0Fa2uCloPo2v2SykFNCAWqOyET3LuemT
   94FOMqbRHD8KfM+y13PkzENARrvxvaQJGwfhSP2gbcHhoMnZJc4UUW8/J
   PZQWz93JowwbqKllvWMiaVDB9EDiXP0UUx5SPULhOhui9y80MpEmukluu
   dIAkm4DYUjUuvfNaXAbTSG0cNf8ZYr3DbXFmERjfB+tRX5ei6LGR9ET+H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="412066308"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="412066308"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 13:35:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="784946310"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="784946310"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 13:35:21 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: [Part 2 v2[cleanup] 1/4] x86/microcode: Taint kernel only if microcode loading was successful
Date:   Sat, 21 Jan 2023 13:35:09 -0800
Message-Id: <20230121213512.251578-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230121213512.251578-1-ashok.raj@intel.com>
References: <87y1pygiyf.ffs@tglx>
 <20230121213512.251578-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when late loading is aborted due to check_online_cpu(), kernel
still ends up tainting the kernel.

Taint only when microcode loading was successful.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
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
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Martin Pohlack <mpohlack@amazon.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index d7cbc83df9b6..c5d80ff00b4e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -475,6 +475,7 @@ static ssize_t reload_store(struct device *dev,
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
+	int load_ret = -1;
 	ssize_t ret = 0;
 
 	ret = kstrtoul(buf, 0, &val);
@@ -495,16 +496,20 @@ static ssize_t reload_store(struct device *dev,
 		goto put;
 
 	mutex_lock(&microcode_mutex);
-	ret = microcode_reload_late();
+	load_ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
 
 put:
 	cpus_read_unlock();
 
-	if (ret == 0)
+	/*
+	 * Taint only when loading was successful
+	 */
+	if (load_ret == 0) {
 		ret = size;
-
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		pr_warn("Microcode late loading tainted the kernel\n");
+	}
 
 	return ret;
 }
-- 
2.34.1

