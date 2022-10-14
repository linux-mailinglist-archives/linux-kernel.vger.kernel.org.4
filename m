Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695895FF453
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiJNUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJNUJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C111DA374
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778169; x=1697314169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1cRxN49Ycb0ZqM7NXfcXCT4mEZZNuFdDj1zsFuZk6o4=;
  b=l16FQYwfKrAUG2MOKClK7Y4JKdiDvDs7BeNUYVgwuHGjoJmFCGwG2AEA
   gHQn6dGhhLfxFG5nOvDGoaUb6/FjyvmWhXqkR6EGpTh+uYIbG9qt646uF
   YKpi4HJVf6BUmwRDrc/+1VlNsfFh2cXe4x7215Cm3dJbDu/vzrdb8GQ58
   Hiz89mW5KoJ3fdusXmxakMi0FyIJNeAfGx+7wufQc6qXImg4txS+pfEKm
   Wl822Qgl/15iUsBw2vlm4BuZYGMFpU0TDrm+v5fQsnH6A1OFbtWt+Q5Fu
   WdlxjfwGUXD2yWLlhcgXTW2YyJIEnfmSnQhsdZE82ucTaOUAUdjWoclrv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202160"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870159"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870159"
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
Subject: [PATCH 07/13] x86/microcode: Move late-load warning to earlier where kernel taint happens
Date:   Fri, 14 Oct 2022 13:09:07 -0700
Message-Id: <20221014200913.14644-8-ashok.raj@intel.com>
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

Move where the late loading warning is being issued to earlier in the call.
This would put the warn and taint in the same function.

Just a tidy thing, no functional changes.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 50652b019233..7a8fcb914b6a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -571,9 +571,6 @@ static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	/*
 	 * Used for late_load entry and exit rendezvous
 	 */
@@ -624,6 +621,8 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
+	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+	pr_err("You should switch to early loading, if possible.\n");
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
 	if (tmp_ret != UCODE_NEW)
 		goto put;
-- 
2.34.1

