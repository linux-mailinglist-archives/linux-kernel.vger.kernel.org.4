Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFE662C51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjAIRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbjAIRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:10:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B738AFC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673284138; x=1704820138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FgU8Goc+WegZo2GsmgzSbtPfTgXqbY4qTIuu55vxmY4=;
  b=QV1llBzi3VkMFCquzd6H5zqNN53YgQU+mOfTyxDdbZKrgptupkXOcv4o
   LUOzRxPYaVJESvztoYG+mikEDTTrtQ5pIKVsxuWvNARRM6HOU4nrn2tuj
   QrgCyIYDXTE45RlXaGTekTaGZVfMClRJ6e7dphW43LjD+SI0RftXBspOR
   5EcXcKo3uaGBv4WDrpvyuomtclyokCbB4vY2hkqEH0kDu8jiHTN6tZ5DC
   6J0Xun78WR2If0tmuUSY1BuatN3dqyIOOL14C6cse2BHgf1pBT+QisM84
   n/dotp0aC3+ts7NK9RmGZKV/Xc1EHJZwdybAneEOBFQJxscOVE37w+SMx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="310722832"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310722832"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 09:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725236435"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="725236435"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2023 09:05:14 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 309H5Be0030759;
        Mon, 9 Jan 2023 17:05:13 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] scripts/head-object-list: remove x86 from the list
Date:   Mon,  9 Jan 2023 18:04:03 +0100
Message-Id: <20230109170403.4117105-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
References: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
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

Now that x86 boot code is not hardcoded to the particular linking
order, remove x86 files from the list and let them be placed inside
the vmlinux according only to the linker script and linker
preferences.

Tested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 scripts/head-object-list.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index b074134cfac2..b2a0e21ea8d7 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -42,10 +42,4 @@ arch/s390/kernel/head64.o
 arch/sh/kernel/head_32.o
 arch/sparc/kernel/head_32.o
 arch/sparc/kernel/head_64.o
-arch/x86/kernel/head_32.o
-arch/x86/kernel/head_64.o
-arch/x86/kernel/head32.o
-arch/x86/kernel/head64.o
-arch/x86/kernel/ebda.o
-arch/x86/kernel/platform-quirks.o
 arch/xtensa/kernel/head.o
-- 
2.39.0

