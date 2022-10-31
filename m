Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B096139D4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiJaPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJaPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:16:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8011145B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667229399; x=1698765399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MkZ1KS2KjXParkaGXXA5TbN72uiwo7wOn2n9k1I1hVw=;
  b=dl45j1K9/LPemcfVLTSKUu+5DBVze3VLgl3TEy9WHCftIcqoUSt5awus
   AOnroXOQHXE1TfHplDZcJMPVE9vnLYwT2cX17thvFF3FwXhcXlIdTP2z7
   +HDf4+Ir50eOL5+Y8Ug0Nt6ldDxNQZJbqetjZxEiePgjUmYof9kMXaPJe
   IbigIX6mMIRzwiHe7Dbfl14BpGh5p52PLzgugUUertHt88mAczTeo2Rgm
   Gluzr09hZI4BnKAac1K15SgkDXpeR1MufZFSqLTbeqQK9N6gxMhxrypUS
   WZ7Y2y5C4cfKHj+Y0T2SR0GCQ+5dX5m6qEjrgNTqG+dyTIk/+yW+xsu8x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373134137"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="373134137"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 08:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="697045600"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="697045600"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 31 Oct 2022 08:16:36 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 29VFGXGF008839;
        Mon, 31 Oct 2022 15:16:35 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts/head-object-list: remove x86 from the list
Date:   Mon, 31 Oct 2022 16:10:47 +0100
Message-Id: <20221031151047.167288-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031151047.167288-1-alexandr.lobakin@intel.com>
References: <20221031151047.167288-1-alexandr.lobakin@intel.com>
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

Now that x86 boot code is not hardcoded to the particular linking
order, remove x86 files from the list and let them be placed inside
the vmlinux according only to the linker script and linker
preferences.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 scripts/head-object-list.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index b16326a92c45..405d2942898a 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -44,10 +44,4 @@ arch/s390/kernel/head64.o
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
2.38.1

