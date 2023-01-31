Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0A683AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAaXpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjAaXo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:44:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B74C6EF;
        Tue, 31 Jan 2023 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675208696; x=1706744696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJlwSFVpT1cewwIwRvUfBxfg5OygWbxR/zFOIt+ZgzQ=;
  b=H0Bz/4BMZ9c6loNizuD1/ey0E+v97kR7DYOxwAXEwSIoyWb7GoljGFlC
   9Crv29lOZ+4h3JeIfuNnq3w25PNhjF5CGpLje1iTJmbJWN5XdBC+qtqdD
   9bzn7W7ckOSFosGVEJcZcQOpAvNtL2sC5vsok0g0Emn5k9Qna1Gu8l/wu
   VQv/Nq40EpUJFwDrNCc8RL7Z9IlhJFQ8NQ6J9iTuVtNcnQSnUbPaAIoGr
   eCsWj62EyRYxlQf5d4cdQuYQPakChQgrct7hrv/x2UVV6lwjT7YUCw5co
   C7E6OpzDr9AQTI1MkJcVrjlFWpShm8qt5o3z4ENbIGzgQY4Iuy0hWThJh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390360415"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390360415"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773192024"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="773192024"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH 1/5] x86/include/asm/msr-index.h: Add IFS Array test bits
Date:   Tue, 31 Jan 2023 15:42:58 -0800
Message-Id: <20230131234302.3997223-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131234302.3997223-1-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
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

Define MSR bitfields for enumerating support for Array BIST test.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d3fe82c5d6b6..ad8997773ad3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -197,6 +197,8 @@
 
 /* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
 #define MSR_INTEGRITY_CAPS			0x000002d9
+#define MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT      2
+#define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
 
-- 
2.25.1

