Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C355D72D400
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbjFLWDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjFLWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:03:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB328E7E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686607410; x=1718143410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HOyuQFngdneJCdfSjNA/K4eevMiAXCxbNP4WWdAC2rE=;
  b=EjOn7ojzcAtek7F37ANKMHrSZSVySkuVg8dUznFGsn0DFKRec/M/mVch
   oR5v7mN/1ysFttduWvBLkeC0Vp1dfEZy1EuR1bJURABcTbUvRuP63x+R5
   k2E+32mURJtfBFvR11mxrCQBmM9fNHhNqL2iisu4Jr2alyNRvkTufdWVF
   XUh/+ReMZDE+KTsK2eyCinCyUkoWLlcT0LI8tDx6nvye8IXu4kBksiJzw
   Id16tb/A/zOPDCbR4lDzrlkeXhj/xSNkF+1KS06jvvsmwHBOoDVywlnci
   Lv4GdwJMPHH3SYGBgWfSdEoGAn4UIxXtbKUyigUIMQgA2EVpHHYyHL5j8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444550188"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="444550188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="958183347"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="958183347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2023 15:03:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C4861357; Tue, 13 Jun 2023 01:03:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] signal: Use %*ph for printing hexdump of a small buffer
Date:   Tue, 13 Jun 2023 01:03:34 +0300
Message-Id: <20230612220334.44177-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already has a helper to print a hexdump of a small
buffer via pointer extension. Use that instead of open coded
variant.

In long term it helps to kill pr_cont() or at least narrow down
its use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/signal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..6be2df76f0b4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1259,18 +1259,17 @@ static void print_fatal_signal(int signr)
 	pr_info("potentially unexpected fatal signal %d.\n", signr);
 
 #if defined(__i386__) && !defined(__arch_um__)
-	pr_info("code at %08lx: ", regs->ip);
 	{
+		unsigned char insn[16];
 		int i;
+
 		for (i = 0; i < 16; i++) {
-			unsigned char insn;
-
-			if (get_user(insn, (unsigned char *)(regs->ip + i)))
+			if (get_user(insn[i], (unsigned char __user *)(regs->ip + i)))
 				break;
-			pr_cont("%02x ", insn);
 		}
+
+		pr_info("code at %08lx: %*ph\n", regs->ip, i, insn);
 	}
-	pr_cont("\n");
 #endif
 	preempt_disable();
 	show_regs(regs);
-- 
2.40.0.1.gaa8946217a0b

