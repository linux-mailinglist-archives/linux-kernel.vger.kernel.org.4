Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445A4681CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjA3Vk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjA3VkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0AC1727
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114815; x=1706650815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=voF6jjo5dj3mRofutynhvBZdyYRA2mgyQE5q7XMzfyI=;
  b=IGhswbX6MwpHgvW1cRRt3pbfTQqQApeymmgRsgLmalGvnNteEuuAFZVL
   8N/6WHsaNjI9NTlmRkBoSFpB+Jjg+rt/jIDjT2ADZ08fwGFz/vkbwObTa
   3WgPgo5CbWNKXDYLyg88MULdv4fTETRNYBR/2/RjiSQ18mfYqz1SeyXlz
   k6mETPivLePnCNVrDqyj/gCU7UqSk5tcvVx8wlKYaCbcRzrcfvUGklcc5
   nPVqcMg118EzPqluxD17bMiC+rCIjWuMflYTcso22mxZQRZVXuvXoFFND
   NKSwWexDfaGhNhNYYtZkwnCAyxFtYhjDU7kHyoGPwyYGeapJ0jSDXuGBl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955530"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955530"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571870"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571870"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: [Patch v3 Part2 5/9] x86/microcode: Move late load warning to the same function that taints kernel
Date:   Mon, 30 Jan 2023 13:39:51 -0800
Message-Id: <20230130213955.6046-6-ashok.raj@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130213955.6046-1-ashok.raj@intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Late microcode loading issues a warning and taints the
kernel. Tainting the kernel and emitting the warning happens in two
different functions.

The upcoming support for safe late loading under certain conditions
needs to prevent both the warning and the tainting when the safe
conditions are met. That would require to hand the result of the safe
condition check into the function which emits the warning.

To avoid this awkward construct, move the warning into reload_store()
next to the taint() invocation as that is also the function which will
later contain the safe condition check.

No functional change.

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
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Martin Pohlack <mpohlack@amazon.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 8452fad89bf6..bff566c05f46 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -442,9 +442,6 @@ static int microcode_reload_late(void)
 	int old = boot_cpu_data.microcode, ret;
 	struct cpuinfo_x86 prev_info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -487,6 +484,9 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
+	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+	pr_err("You should switch to early loading, if possible.\n");
+
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW) {
 		ret = size;
-- 
2.37.2

