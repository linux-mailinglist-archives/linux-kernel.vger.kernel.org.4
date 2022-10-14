Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A705FF44F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJNUJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJNUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3551D81A4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778167; x=1697314167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TOJYUiBrUy7/gcOs7i6uVS4QO3wgYtY5qPGjrygs5kQ=;
  b=JQZy2JLs4DFfyNxmJAJZayvRAT5/IgDTZh4d4bk5KhvHB1QnnmYfat9e
   ZzYWW1Wjm0VzftriLtBucnYXcVkqMZT/sAw4p4p74PfoefeZxd8rXSmrR
   iB8lI6nob556yw3HCQVMkuIX9N2wS8cBMd9KJmnC/bdAoSPrcxnx0qRjZ
   5BJvK8Na/c65/kxXtTEvXemTQ2maujWJaSNqSn/MIGfNPoXkSUw7retbU
   lIgs+xFQo7m88/IakH2LeQujjLPMU2XoAFKgF5hpdELCkKDok08MSlmsK
   kqmlUSbouIUtzgIajEWbpNsU9W1QVMTuSvh8yRvhp37PluH1BcBFglVVm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202152"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870141"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870141"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
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
Subject: [PATCH 02/13] x86/microcode: Do not load from filesystem for CPU hot add
Date:   Fri, 14 Oct 2022 13:09:02 -0700
Message-Id: <20221014200913.14644-3-ashok.raj@intel.com>
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

When request_microcode_fw() is called, refresh_fw parameter must be set
only when late loading. Currently during CPU hotplug, the path is as
follows.

mc_device_add() -> microcode_init_cpu() ->
				request_microcode_fw(refresh_hw=true)

Consider if a new microcode file was just copied, but have not yet
performed a late load. Now adding a new CPU will result in loading that
microcode file vs the rest of the CPUs in the system would have a previous
revision of what was loaded earlier.

Moreover this doesn't need to be any different from logical cpu online
flow, microcode_update_cpu() and mc_device_add() seem to be doing the
opposite things.

Seems like there is no good use for the refresh_fw parameter in
microcode_init_cpu(), so simply drop it.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6a41cee242f6..e4135b4fdbc6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -599,7 +599,7 @@ static enum ucode_state microcode_resume_cpu(int cpu)
 	return UCODE_OK;
 }
 
-static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
+static enum ucode_state microcode_init_cpu(int cpu)
 {
 	enum ucode_state ustate;
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -614,7 +614,8 @@ static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 	if (system_state != SYSTEM_RUNNING)
 		return UCODE_NFOUND;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
+	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev,
+						     false);
 	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
 		apply_microcode_on_target(cpu);
@@ -633,7 +634,7 @@ static enum ucode_state microcode_update_cpu(int cpu)
 	if (uci->valid)
 		return microcode_resume_cpu(cpu);
 
-	return microcode_init_cpu(cpu, false);
+	return microcode_init_cpu(cpu);
 }
 
 static int mc_device_add(struct device *dev, struct subsys_interface *sif)
@@ -649,7 +650,7 @@ static int mc_device_add(struct device *dev, struct subsys_interface *sif)
 	if (err)
 		return err;
 
-	if (microcode_init_cpu(cpu, true) == UCODE_ERROR)
+	if (microcode_init_cpu(cpu) == UCODE_ERROR)
 		return -EINVAL;
 
 	return err;
-- 
2.34.1

