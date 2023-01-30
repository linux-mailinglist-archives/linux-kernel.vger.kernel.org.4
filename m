Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A8681CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjA3Vkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjA3VkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59614E93
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114817; x=1706650817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A80r7oChGS9LbqR+hFTuIEP18vZwaZTsItqNNyj9g5M=;
  b=ZtsGPKsHIq6wCx/m3kReHBMqDMp6+3HOE3M8RJ8Pc17FBbC/PWLjDFbW
   GEl50DD/VEK4FtP70OUki0VoZ6N6cCl2JW4sG19d5UjxnCxMT23IabSMU
   TXGkw4lQ7CZI6ske3zeKv0C+9fFj2mbF+EItV9T4SgBje9K5lcJpyWxQ1
   lMUrnm5iUye5kLUm+EOnlQtNKAVs29z/hlbYyoj0u6ArSRgu8lde235FZ
   J9Uy0M+YznelwYX528+j4MfcdAleYTVtMI7XqUJkXSjI8koMrx6Qt0JuA
   gue8Eu/eL79uGUYi0fvtZRbDMeV62pZ6FFWTF5nOOf2JeR4xKfnTUZih1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955565"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571879"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571879"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
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
Subject: [Patch v3 Part2 8/9] x86/microcode/intel: Drop wbinvd() from microcode loading
Date:   Mon, 30 Jan 2023 13:39:54 -0800
Message-Id: <20230130213955.6046-9-ashok.raj@intel.com>
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

Some older processors had a bad interaction when updating microcode if the
caches were dirty causing machine checks. The wbinvd() was added to
mitigate that before performing microcode updates. Now that Linux checks
for the minimum version before performing an update, those microcode
revisions can't be loaded.

Early loading is also not required to use wbinvd() any longer, that was
added as a safety net.

Remove calls to wbinvd().

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
 arch/x86/kernel/cpu/microcode/intel.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 98c92b9affa2..601c586be7b6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -415,12 +415,6 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 
 	old_rev = rev;
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -632,12 +626,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		goto out;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
-- 
2.37.2

