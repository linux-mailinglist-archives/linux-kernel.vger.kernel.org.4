Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D9614F15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKAQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKAQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:20:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D91C900
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667319625; x=1698855625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3Sm1HIWJ0zDGafhuDEQGcNzrmUhCp8majAoJIH0MBM=;
  b=W3BmmXXyqWOI+8mSvOPSBYjnFpVempanh+kxEM6qfxfjyyLn3PkA3iGa
   +rEcWAEJ/Flgz3nPtlYJXh5SwYOQ+IK0gvRypfvnwX4lgrqwcgIGlsXPd
   94dC9WkYdjmtCzt1cM+q4VXBGNOSnO+F2xnPY80ynP/2mlHB/eRP4L3ed
   o+6mJFQMhdL/rCFj5L8rjwyo2wZo9gvH4Jxtz73tUyQ41r/gnoA16ARRM
   zRu47pmcGF++nJPu54HRZVU3UyjTteLXgDv5ggcHcgaQaW7EKPAoxtpFU
   cXMm/JZ7cccB79U/3dE7UKBZzJ95LpMtTCQaFTmWKTLBZA2+SJM3Ebj5g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309175948"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309175948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="628623933"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="628623933"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2022 09:19:39 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2A1GJa8C019884;
        Tue, 1 Nov 2022 16:19:38 GMT
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
Subject: [PATCH v2 2/2] scripts/head-object-list: remove x86 from the list
Date:   Tue,  1 Nov 2022 17:15:29 +0100
Message-Id: <20221101161529.1634188-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Tested-by: Jiri Slaby <jirislaby@kernel.org>
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

