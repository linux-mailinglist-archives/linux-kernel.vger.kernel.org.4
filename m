Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512E5FF457
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJNUKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJNUJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE8631F8D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778173; x=1697314173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YFnBOmGNu42irRQ8A9ppZsDFGbe8312PDPwfzklaNps=;
  b=HlT/d2fiLCAdNMeFuTpiSKbehE4UeoIQrHiMXr6EWzg3YR6I7QjkHavE
   kYS4iJjL9H3wfOXPXwSETJlvk6ByJcj9IMKhX/wD8mTtj3VuPQekeJJ/j
   bila+OSPyfL1CL/ZrxzNzAdr3S+2K7sdG5LMu2kM78sgyRp+tv4CpXyV3
   3TlZbTdQByTSbxKzG80FZz300J61LLozJc0tLQpMXOCbnR7XnB4OKEfgu
   8hDDchlBksJ94ID+c/65TM099M1ZqJXUKuEL8fCAMDYpSlxIv1llGm1lN
   4iDP9hWvSJHB7XHhF97dIyPdIci83nRi1H42UigW4eGZcklYaxmCSYaRQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202164"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202164"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870171"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870171"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
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
Subject: [PATCH 11/13] x86/microcode: Display revisions only when update is successful
Date:   Fri, 14 Oct 2022 13:09:11 -0700
Message-Id: <20221014200913.14644-12-ashok.raj@intel.com>
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

Display the update message only when its successful

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 46e9c2d8fae0..c6cd815190b1 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -592,8 +592,9 @@ static int microcode_reload_late(void)
 
 	unregister_nmi_handler(NMI_LOCAL, "ucode_nmi");
 
-	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
-		old, boot_cpu_data.microcode);
+	if (!ret)
+		pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+			old, boot_cpu_data.microcode);
 
 done:
 	return ret;
-- 
2.34.1

